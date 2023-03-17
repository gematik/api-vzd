from urllib.parse import urljoin
from requests import (Session)
from .apitools import (request_to_curl, response_to_text, jwt_to_text)
from .config import (MatrixPasswordConfig, FHIRDirectoryConfig)
from rich.console import Console

debug_console = Console(record=True, stderr=True)
debug_print = debug_console.print


def main():
    matrix_config = MatrixPasswordConfig()

    debug_print("[b]Login to Directory using Matrix password authentication[b]")

    debug_print("\n[b]Matrix configuration:[b]")
    debug_print(matrix_config)

    debug_print("\n[b]FHIR-Directory configuration:[/b]")
    fhir_directory_config = FHIRDirectoryConfig()
    debug_print(fhir_directory_config)

    session = Session()

    debug_print("\n[b]Get authentication methods supported by the Matrix homeserver[/b]")
    debug_print("  See https://matrix.org/docs/guides/client-server-api#login")
    response = session.get(urljoin(matrix_config.homeserver_url, "/_matrix/client/r0/login"))

    debug_print(request_to_curl(response.request))
    debug_print(response_to_text(response))

    response = session.post(
      urljoin(matrix_config.homeserver_url, "/_matrix/client/r0/login"),
      json={
        "type": "m.login.password", 
        "user": matrix_config.id,
        "password": matrix_config.password.get_secret_value(),
      }

    )

    debug_print("\n[b]Perform login and get Matrix Access Token:[b]")
    debug_print(request_to_curl(response.request))
    debug_print(response_to_text(response))

    matrix_access_token = response.json()["access_token"]

    # AF_10036: get OpenID token from Matrix server
    # https://spec.matrix.org/v1.3/client-server-api/#openid
    response = session.post(
      urljoin(matrix_config.homeserver_url, f"/_matrix/client/v3/user/{matrix_config.id}/openid/request_token?access_token={matrix_access_token}"),
      json={

      }
    )

    debug_print("\n[b]Request Matrix OpenID Token:[/b]")
    debug_print(request_to_curl(response.request))
    debug_print(response_to_text(response))

    matrix_opendid_token = response.json()["access_token"]

    # AF_10036: get search-token from /tim-authenticate
    response = session.get(
      urljoin(fhir_directory_config.tim_authenticate_url, f"?mxId={matrix_config.homeserver}"),
      headers={
        "X-Matrix-OpenID-Token": matrix_opendid_token
      },
    )

    debug_print("\n[b]FHIR-Directory /tim-authenticate response[/b]")
    debug_print(request_to_curl(response.request), soft_wrap=True)
    debug_print(response_to_text(response))

    assert response.status_code == 200

    search_api_access_token = response.json()["access_token"]

    debug_print("\n[b]/search API access_token:[/b]")
    debug_print(search_api_access_token, soft_wrap=True)
    debug_print("\n[b]/search API access_token details[/b]")
    debug_print(jwt_to_text(search_api_access_token))

    debug_print("\n[b]Perform FHIR-Search[/b]")
    response = session.get(
        urljoin(fhir_directory_config.search_url, "HealthcareService"),
        params={
            "organization.active": "true",
            "_count": 5,
        },
        headers={
            "Authorization": f"Bearer {search_api_access_token}"
        }
    )

    debug_print(request_to_curl(response.request), soft_wrap=True)
    debug_print(response_to_text(response))

    print(search_api_access_token)
