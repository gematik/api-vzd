from urllib.parse import urljoin
from requests import (Session)
from rich import (get_console)
from .apitools import (request_to_curl, response_to_text, jwt_to_text)
from .config import (MatrixConfig, FHIRDirectoryConfig)


def main():
    matrix_config = MatrixConfig()

    print = get_console().print

    print("Matrix configuration:")
    print(matrix_config)

    print("FHIR-Directory configuration:")
    fhir_directory_config = FHIRDirectoryConfig()
    print(fhir_directory_config)

    session = Session()

    print("Get  authentication methods supported by the Matrix homeserver")
    # s. https://matrix.org/docs/guides/client-server-api#login
    response = session.get(urljoin(matrix_config.homeserver_url, "/_matrix/client/r0/login"))

    print(request_to_curl(response.request))
    print(response_to_text(response))

    response = session.post(
      urljoin(matrix_config.homeserver_url, "/_matrix/client/r0/login"),
      json={
        "type": "m.login.password", 
        "user": matrix_config.id,
        "password": matrix_config.password.get_secret_value(),
      }

    )

    print("Perform login and get Matrix Access Token:")
    print(request_to_curl(response.request))
    print(response_to_text(response))

    matrix_access_token = response.json()["access_token"]

    # AF_10036: get OpenID token from Matrix server
    # https://spec.matrix.org/v1.3/client-server-api/#openid
    response = session.post(
      urljoin(matrix_config.homeserver_url, f"/_matrix/client/v3/user/{matrix_config.id}/openid/request_token?access_token={matrix_access_token}"),
      json={

      }
    )

    print("Request Matrix OpenID Token:")
    print(request_to_curl(response.request))
    print(response_to_text(response))

    matrix_opendid_token = response.json()["access_token"]

    # AF_10036: get search-token from /tim-authenticate
    response = session.get(
      urljoin(fhir_directory_config.tim_authenticate_url, f"?mxId={matrix_config.homeserver}"),
      headers={
        "X-Matrix-OpenID-Token": matrix_opendid_token
      },
      verify=False  
    )

    print("FHIR-Directory /tim-authenticate response")
    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))

    search_api_access_token = response.json()["jwt"]

    print("/search API access_token:")
    print(jwt_to_text(search_api_access_token))
    print(search_api_access_token)

    print("Perform FHIR-Search")
    response = session.get(
        urljoin(fhir_directory_config.search_url, "HealthcareService"),
        params={
            "organization.active": "true",
            "_count": 1,
        },
        headers={
            "Authorization": f"Bearer {search_api_access_token}"
        }
    )

    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))
