from requests import (Session)
from rich import (get_console)
from .apitools import (request_to_curl, response_to_text, jwt_to_text)
from .config import (TIMProviderAuthConfig, FHIRDirectoryConfig)


def main():
    print = get_console().print
    tim_provider_auth_config = TIMProviderAuthConfig()
    fhir_directory_config = FHIRDirectoryConfig()

    print("TI-Messenger Provider Auth Configuration")
    print(tim_provider_auth_config)
    print("FHIR Directory Configuration")
    print(fhir_directory_config)

    session = Session()
    response = session.post(
        tim_provider_auth_config.url,
        data={"grant_type": "client_credentials"},
        allow_redirects=False,
        auth=(tim_provider_auth_config.client_id, tim_provider_auth_config.secret.get_secret_value())
    )

    print(request_to_curl(response.request))
    print(response_to_text(response))

    ti_provider_access_token = response.json()["access_token"]

    print("TI-Provider Access Token")
    print(jwt_to_text(ti_provider_access_token))
    print(ti_provider_access_token)

    print("[bold]Retrieve TI-Provider API Token[/bold]")
    response = session.get(
        fhir_directory_config.ti_provider_authenticate_url,
        headers={"Authorization": f"Bearer {ti_provider_access_token}"}
    )

    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))

    ti_provider_api_access_token = response.json()["jwt"]

    print("TI-Provider API Access Token")
    print(jwt_to_text(ti_provider_api_access_token))
    print(ti_provider_api_access_token)

    print("Perform test API call")

    response = session.get(
        fhir_directory_config.federation_list_url,
        headers={"Authorization": f"Bearer {ti_provider_api_access_token}"}
    )

    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))

    print("Perform test API call #2")
    response = session.get(
        fhir_directory_config.federation_url,
        headers={
            "Authorization": f"Bearer {ti_provider_api_access_token}"
        }
    )

    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))
