from requests import Session
from rich import (get_console)
from urllib.parse import urljoin
from .apitools import (request_to_curl, response_to_text, base64url_decode, base64url_encode)
from json import (loads)
import hashlib
import os


def main():
    print = get_console().print
    url = "https://idp-ref.app.ti-dienste.de/"

    session = Session()

    response = session.get(
        urljoin(url, "/.well-known/openid-configuration")
    )

    print(request_to_curl(response.request), soft_wrap=True)
    openid_configuration = loads(base64url_decode(response.text.split(".")[1]))
    print(openid_configuration)

    code_verifier = base64url_encode(os.urandom(40)).decode('utf-8')
    print("code_verifier", code_verifier)

    code_challenge = hashlib.sha256(code_verifier.encode('utf-8')).digest()
    code_challenge = base64url_encode(code_challenge).decode('utf-8')
    print("code_challenge", code_challenge)

    client_id = "gematikTestPs"
    redirect_uri = "http://test-ps.gematik.de/erezept"

    state = base64url_encode(os.urandom(16)).decode("utf-8")
    print("State:", state)
    scope = "fhir-vzd openid"

    response = session.get(
        urljoin(url, openid_configuration["authorization_endpoint"]),
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

    challenge: str = response.json()["challenge"]
    challenge_info = loads(base64url_decode(challenge.split(".")[1]))

    print(challenge_info)

    digest = hashlib.sha256()
    digest.update(challenge.encode("utf-8"))
    print(base64url_encode(digest.digest()).decode("ascii"))

    response = session.post(
        urljoin(url, openid_configuration["authorization_endpoint"]),
        data={
            "signed_challenge": "1234"
        },
        allow_redirects=False
    )

    print(request_to_curl(response.request))
    print(response.text)