from requests import Session
from rich import get_console
from urllib.parse import urljoin, urlsplit, parse_qs
from .apitools import (request_to_curl, response_to_text, base64url_decode, base64url_encode)
from jwcrypto import jwt, jwk, jwe, jws
from jwcrypto.common import json_encode
from json import dumps, loads
import hashlib
import secrets
from base64 import b64encode
from .koap import (
  get_cards,
  get_certificates,
  external_authenticate,
  last_soap_request,
  last_soap_response,
)
from .config import OwnerSoftCertConfig
from cryptography.hazmat.primitives.serialization import (
  load_der_private_key, 
  PrivateFormat,
  Encoding,
  NoEncryption,
)

card_handle = 'SMC-B-5'


def main():
    print = get_console().print

    url = "https://idp-ref.app.ti-dienste.de/"  
    client_id = "GEMgematFHI4HkPrd8SR"
    redirect_uri = "https://fhir-directory-ref.vzd.ti-dienste.de/signin-gematik-idp-dienst"
    scope = "fhir-vzd openid"

    session = Session()

    response = session.get(
        urljoin(url, "/.well-known/openid-configuration")
    )
    print("Request openid-configuration manifest")
    print(request_to_curl(response.request), soft_wrap=True)
    openid_configuration = loads(base64url_decode(response.text.split(".")[1]))
    print(openid_configuration)

    print("Generate PKCE code verifier")
    code_verifier = base64url_encode(secrets.token_bytes(32)).decode('utf-8')
    print("code_verifier", code_verifier)

    print("Create PKCE code challenge")
    code_challenge = hashlib.sha256(code_verifier.encode('utf-8')).digest()
    code_challenge = base64url_encode(code_challenge).decode('utf-8')
    print("code_challenge", code_challenge)

    print("Generate random state für PKCE")
    state = base64url_encode(secrets.token_bytes(16)).decode("utf-8")
    print("state", state)

    auth_endpoint = openid_configuration["authorization_endpoint"]
    print(f"Send authentication request to {url}")
    response = session.get(
        auth_endpoint,
        params={
            "response_type": "code",
            "client_id": client_id,
            "scope": scope,
            "redirect_uri": redirect_uri,
            "state": state,
            "code_challenge": code_challenge,
            "code_challenge_method": "S256",
        },
        allow_redirects=False
    )
    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))

    puk_idp_sig_json = session.get(openid_configuration["uri_puk_idp_sig"]).json()
    puk_idp_sig = jwt.JWK(**puk_idp_sig_json)

    print("puk_idp_sig", puk_idp_sig)

    print("Extract challenge")
    challenge: str = response.json()["challenge"]

    challenge_jws = jws.JWS()
    challenge_jws.allowed_algs = ["BP256R1"]
    challenge_jws.deserialize(challenge)
    challenge_jws.verify(puk_idp_sig)
    challenge_payload = loads(challenge_jws.payload)
    print("challenge_payload", challenge_payload)

    cards = get_cards()
    print(cards)

    smcb = next(filter(lambda card: card['CardType'] == 'SMC-B', cards))

    card_handle = smcb['CardHandle']

    certificates = get_certificates(card_handle, ["C.AUT"])
    print(certificates)
    cert_der = certificates[0].X509Data.X509Certificate
    cert_base64 = b64encode(cert_der).decode("ascii")
    print(last_soap_request())
    print(last_soap_response())

    token_to_sign = jwt.JWT(
        header={
            "typ": "JWT",
            "cty": "NJWT",
            # BASE64(DER)
            "x5c": [cert_base64],
            # BP256R1 or PS256
            "alg": "PS256"
        },
        claims={
          "njwt": challenge
        }
    )

    data_to_sign = b'.'.join([
        base64url_encode(token_to_sign.header.encode("utf-8")),
        base64url_encode(token_to_sign.claims.encode("utf-8")),
    ])

    print(data_to_sign, soft_wrap=True)

    print(data_to_sign)

    data_to_sign_hash = hashlib.sha256(data_to_sign).digest()

    payload_external_signature = external_authenticate(card_handle, data_to_sign_hash)

    print(last_soap_request())
    print(last_soap_response())

    signed_token = b".".join([
        base64url_encode(token_to_sign.header.encode("utf-8")),
        base64url_encode(token_to_sign.claims.encode("utf-8")),
        base64url_encode(payload_external_signature)
    ]).decode("ascii")

    print(signed_token, soft_wrap=True)

    # sign using software certificate
    owner_soft_cert_config = OwnerSoftCertConfig()

    owner_key = load_der_private_key(
        open(owner_soft_cert_config.key_filename_der, "rb").read(),
        password=None
    )

    owner_key_pem = owner_key.private_bytes(
        Encoding.PEM,
        PrivateFormat.TraditionalOpenSSL,
        encryption_algorithm=NoEncryption()
    )

    smcb_key = jwk.JWK.from_pem(owner_key_pem)

    print("SMC-B Soft-Key", smcb_key.export())

    smcb_cert_bytes = open(owner_soft_cert_config.cert_filename_der, "rb").read()
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

    print(base64url_decode(token_to_encrypt.serialize().split(".")[0]))

    response = session.post(
        urljoin(url, openid_configuration["authorization_endpoint"]),
        data={
            "signed_challenge": token_to_encrypt.serialize()
        },
        allow_redirects=False
    )

    print(response)
    print(response.headers)
    print(response.raw.read())

    redirect_with_code_url = response.headers["Location"]
    redirect_params = parse_qs(urlsplit(redirect_with_code_url).query)

    code = redirect_params["code"][0]

    print(code)

    # create key_verifier
    token_key = base64url_encode(secrets.token_bytes(32)).decode("utf-8")

    puk_idp_enc = session.get(openid_configuration["uri_puk_idp_enc"]).json()
    idp_encryption_key = jwt.JWK(**puk_idp_enc)

    key_verifier = jwt.JWT(
        header={
          "alg": "ECDH-ES",
          "enc": "A256GCM",
          "cty": "NJWT",
        },
        claims={
          "token_key": token_key,
          "code_verifier": code_verifier,
        }
    )

    key_verifier.make_encrypted_token(idp_encryption_key)

    token_endpoint = openid_configuration["token_endpoint"]

    response = session.post(
        url=token_endpoint,
        data={
          "grant_type": "authorization_code",
          "client_id": client_id,
          "redirect_uri": redirect_uri,
          "code": code,
          "code_verifier": code_verifier,
          "key_verifier": key_verifier.serialize(),
        },
        allow_redirects=False,
    )

    print(response)
    print(response.raw.read())

    encrypted_access_token = response.json()["access_token"]

    token_key_jwk = jwk.JWK(kty="oct", k=token_key)

    access_token_njwt = jwe.JWE()
    access_token_njwt.deserialize(
      encrypted_access_token,
      key=token_key_jwk,
    )

    access_token = loads(access_token_njwt.payload)["njwt"]
    print("access_token", access_token)

    # idp_jwk_dict = session.get(openid_configuration["jwks_uri"]).json()[]
    puk_idp_sig_json = session.get(openid_configuration["uri_puk_idp_sig"]).json()
    puk_idp_sig = jwt.JWK(**puk_idp_sig_json)

    print("puk_idp_sig", puk_idp_sig)

    access_token_jws = jws.JWS()
    access_token_jws.allowed_algs = ["BP256R1"]
    access_token_jws.deserialize(access_token)
    access_token_jws.verify(puk_idp_sig)
    access_token_payload = loads(access_token_jws.payload)
    print("access_token_payload", access_token_payload)
