from requests import Session
from rich import get_console
from urllib.parse import urljoin
from .apitools import (request_to_curl, response_to_text, base64url_decode)
from jwcrypto import jwt, jwk, jws
from jwcrypto.common import json_encode
from json import dumps, loads
from base64 import b64encode
import os
from cryptography.hazmat.primitives.serialization import (
  load_der_private_key,
  PrivateFormat,
  Encoding,
  NoEncryption,
)


def main():
    print = get_console().print

    session = Session()

    fhir_directopy_base_url = os.getenv("FHIR_DIRECTORY_BASE_URL") or "https://fhir-directory-test.vzd.ti-dienste.de/"
    gematik_idp_base_url = os.getenv("GEMATIK_IDP_BASE_URL") or "https://idp-ref.app.ti-dienste.de/"
    owner_key_filename_der = os.environ["OWNER_KEY_FILENAME_DER"]
    owner_cert_filename_der = os.environ["OWNER_CERT_FILENAME_DER"]

    response = session.get(
        urljoin(gematik_idp_base_url, "/.well-known/openid-configuration")
    )
    print("Request openid-configuration manifest")
    print(request_to_curl(response.request), soft_wrap=True)
    # TODO verify signature
    openid_configuration = loads(base64url_decode(response.text.split(".")[1]))
    print(openid_configuration)

    puk_idp_sig_json = session.get(openid_configuration["uri_puk_idp_sig"]).json()
    puk_idp_sig = jwt.JWK(**puk_idp_sig_json)

    print("puk_idp_sig", puk_idp_sig)

    print("Begin /owner-authenticate")
    response = session.get(
        urljoin(fhir_directopy_base_url, "/owner-authenticate"),
        allow_redirects=False
    )

    print(request_to_curl(response.request), soft_wrap=True)
    print(response.headers)

    auth_url = response.headers['Location']

    # TODO Server Bug
    auth_url = auth_url.replace('https://idp-ref.app.ti-dienste.de', 'https://idp-ref.app.ti-dienste.de/auth')

    response = session.get(
        auth_url,
    )
    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))

    print("Extract challenge")
    challenge: str = response.json()["challenge"]

    challenge_jws = jws.JWS()
    challenge_jws.allowed_algs = ["BP256R1"]
    challenge_jws.deserialize(challenge)
    challenge_jws.verify(puk_idp_sig)
    challenge_payload = loads(challenge_jws.payload)
    print("challenge_payload", challenge_payload)

    owner_key = load_der_private_key(
        open(owner_key_filename_der, "rb").read(),
        password=None
    )

    owner_key_pem = owner_key.private_bytes(
        Encoding.PEM,
        PrivateFormat.TraditionalOpenSSL,
        encryption_algorithm=NoEncryption()
    )

    smcb_key = jwk.JWK.from_pem(owner_key_pem)

    print("SMC-B Soft-Key", smcb_key.export())

    smcb_cert_bytes = open(owner_cert_filename_der, "rb").read()
    cert_base64 = b64encode(smcb_cert_bytes).decode("ascii")

    payload = {
      "njwt": challenge
    }
    jwstoken = jws.JWS(dumps(payload).encode('utf-8'))
    jwstoken.add_signature(
        smcb_key,
        None,
        json_encode({
          "typ": "JWT",
          "cty": "NJWT",
          # BASE64(DER)
          "x5c": [cert_base64],
          # BP256R1 or PS256
          "alg": "PS256"
        }),
    )
    signed_token = jwstoken.serialize(True)
    print(signed_token, soft_wrap=True)

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

    print("Encrypted challenge:")
    print(token_to_encrypt.serialize(), soft_wrap=True)

    print(base64url_decode(token_to_encrypt.serialize().split(".")[0]))

    response = session.post(
        openid_configuration["authorization_endpoint"],
        data={
            "signed_challenge": token_to_encrypt.serialize()
        },
        allow_redirects=False
    )

    print(response)
    print(response.headers)

    redirect_url = response.headers['Location']

    # TODO: change URL because of environments conflict
    redirect_url = redirect_url.replace("https://fhir-directory-ref.vzd.ti-dienste.de/", "https://fhir-directory-test.vzd.ti-dienste.de/")

    response = session.get(
        redirect_url,
        allow_redirects=False
    )
    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))

    print(response.json()['jwt'], soft_wrap=True)
