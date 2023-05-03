from requests import Session
from urllib.parse import urljoin
from .apitools import (request_to_curl, response_to_text, base64url_decode)
from jwcrypto import jwt, jwk, jws
from jwcrypto.common import json_encode, base64url_encode
from json import loads
from base64 import b64encode
import os
from binascii import unhexlify

from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import utils as ec_utils

from rich.console import Console
from rich.terminal_theme import MONOKAI
from .koap import (
    last_soap_request,
    last_soap_response,
    get_cards,
    get_certificates,
    external_authenticate,
)

debug_console = Console(record=True, stderr=True)
debug_print = debug_console.print


def main():

    session = Session()

    fhir_directopy_base_url = os.getenv("FHIR_DIRECTORY_BASE_URL") or "https://fhir-directory-test.vzd.ti-dienste.de/"
    gematik_idp_base_url = os.getenv("GEMATIK_IDP_BASE_URL") or "https://idp-ref.app.ti-dienste.de/"

    response = session.get(
        urljoin(gematik_idp_base_url, "/.well-known/openid-configuration")
    )
    debug_print("Request openid-configuration manifest")
    debug_print(request_to_curl(response.request), soft_wrap=True)
    # TODO verify signature of discovery document
    openid_configuration = loads(base64url_decode(response.text.split(".")[1]))
    debug_print(openid_configuration)

    puk_idp_sig_json = session.get(openid_configuration["uri_puk_idp_sig"]).json()
    puk_idp_sig = jwt.JWK(**puk_idp_sig_json)

    debug_print("puk_idp_sig", puk_idp_sig)

    debug_print("Begin /owner-authenticate")
    response = session.get(
        urljoin(fhir_directopy_base_url, "/owner-authenticate"),
        allow_redirects=False
    )

    debug_print(request_to_curl(response.request), soft_wrap=True)
    debug_print(response.headers)

    auth_url = response.headers['Location']

    response = session.get(
        auth_url,
    )
    debug_print(request_to_curl(response.request), soft_wrap=True)
    debug_print(response_to_text(response))

    debug_print("Extract challenge")
    challenge: str = response.json()["challenge"]

    # TODO verify signature of challenge (authenticity of IDP-Dienst)

    challenge_jws = jws.JWS()
    challenge_jws.allowed_algs = ["BP256R1"]
    challenge_jws.deserialize(challenge)
    challenge_jws.verify(puk_idp_sig)
    challenge_payload = loads(challenge_jws.payload)
    debug_print("challenge_payload", challenge_payload)

    cards = get_cards()

    debug_print("All available Cards")
    debug_print("GetCard Request")
    debug_print(last_soap_request())
    debug_print("GetCard Response")
    debug_print(last_soap_response())

    # find first SMC-B card
    card = next(filter(lambda c: c.CardType == 'SMC-B', cards))

    debug_print("Using following Card to authenticate:")
    debug_print(card)

    card_handle = card.CardHandle

    card_certificates = get_certificates(card_handle, ['C.AUT'], crypt="ECC")
    debug_print("GetCertificates Request")
    debug_print(last_soap_request())
    debug_print("GetCertificates Response")
    debug_print(last_soap_response())

    certificate_bytes = card_certificates[0].X509Data.X509Certificate

    challenge_response_header = {
        "typ": "JWT",
        "cty": "NJWT",
        # BASE64(DER)
        "x5c": [b64encode(certificate_bytes).decode("utf-8")],
        # BP256R1 for ECC or PS256 for RSA
        "alg": "BP256R1"
    }

    challenge_response_payload = {
      "njwt": challenge
    }

    header_and_payload = f"{base64url_encode(json_encode(challenge_response_header))}.{base64url_encode(json_encode(challenge_response_payload))}"
    debug_print("Challenge response header and payload:")
    debug_print(header_and_payload, soft_wrap=True)

    bytes_to_sign = header_and_payload.encode("utf-8")
    sha256_hasher = hashes.Hash(hashes.SHA256())
    sha256_hasher.update(bytes_to_sign)
    challenge_response_hash = sha256_hasher.finalize()

    debug_print("Challenge response hash", challenge_response_hash)

    challenge_response_signature = external_authenticate(card_handle, challenge_response_hash, "ECC")
    debug_print("ExternalAuthenticate Request")
    debug_print(last_soap_request())
    debug_print("ExternalAuthenticate Response")
    debug_print(last_soap_response())
    
    debug_print("Received signature from konnektor")
    debug_print(challenge_response_signature)

    # ECC signatures must be post-processed
    r, s = ec_utils.decode_dss_signature(challenge_response_signature)
    challenge_response_signature = _encode_int(r, 256) + _encode_int(s, 256)

    signed_token = header_and_payload + "." + base64url_encode(challenge_response_signature)

    debug_print("Complete signed challenge response")
    debug_print(signed_token, soft_wrap=True)

    puk_idp_enc = session.get(openid_configuration["uri_puk_idp_enc"]).json()
    idp_encryption_key = jwt.JWK(**puk_idp_enc)

    token_to_encrypt = jwt.JWT(
        header={
          "alg": "ECDH-ES",
          "enc": "A256GCM",
          "cty": "NJWT",
          "exp": challenge_payload["exp"]
        },
        claims={
          "njwt": signed_token
        }
    )

    token_to_encrypt.make_encrypted_token(idp_encryption_key)

    debug_print("Encrypted challenge response:")
    debug_print(token_to_encrypt.serialize(), soft_wrap=True)

    response = session.post(
        openid_configuration["authorization_endpoint"],
        data={
            "signed_challenge": token_to_encrypt.serialize()
        },
        allow_redirects=False
    )

    debug_print(response.text)
    debug_print(response.headers)

    assert response.status_code == 302, f"Response must be 302 Redirect, got: {response.status_code}"

    redirect_url = response.headers['Location']

    response = session.get(
        redirect_url,
        allow_redirects=False
    )
    debug_print(request_to_curl(response.request), soft_wrap=True)
    debug_print(response_to_text(response))

    owner_access_token = response.json()['access_token']
    print(owner_access_token)

    if not os.path.exists('debug'):
        os.makedirs('debug')
        
    with open(os.path.join('debug', 'owner_authenticate_konnektor.html'), 'w') as f:
        f.write(debug_console.export_html(theme=MONOKAI))


# taken from jwcrypto
def _encode_int(n, bits):
    e = '{:x}'.format(n)
    ilen = ((bits + 7) // 8) * 2  # number of bytes rounded up times 2 bytes
    return unhexlify(e.rjust(ilen, '0')[:ilen])
