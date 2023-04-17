from requests import (Session)
from rich.console import Console
from .apitools import (request_to_curl, response_to_text, jwt_to_text)
from .config import (TIMProviderAuthConfig, FHIRDirectoryConfig)

debug_console = Console(record=True, stderr=True)
debug_print = debug_console.print


def main():
    tim_provider_auth_config = TIMProviderAuthConfig()
    fhir_directory_config = FHIRDirectoryConfig()

    debug_print("TI-Messenger Provider Auth Configuration")
    debug_print(tim_provider_auth_config)
    debug_print("FHIR Directory Configuration")
    debug_print(fhir_directory_config)

    session = Session()

    debug_print("Requesting PROVIDER_ACCESS_TOKEN from ProviderAuthorizationSertvice")
    response = session.post(
        tim_provider_auth_config.url,
        data={"grant_type": "client_credentials"},
        allow_redirects=False,
        auth=(tim_provider_auth_config.client_id, tim_provider_auth_config.secret.get_secret_value())
    )

    debug_print(request_to_curl(response.request))
    debug_print(response_to_text(response))

    ti_provider_access_token = response.json()["access_token"]

    debug_print("TI-Provider Access Token")
    debug_print(jwt_to_text(ti_provider_access_token))
    debug_print(ti_provider_access_token)

    debug_print("[bold]Retrieve TI-Provider API Token[/bold]")
    response = session.get(
        fhir_directory_config.ti_provider_authenticate_url,
        headers={"Authorization": f"Bearer {ti_provider_access_token}"}
    )

    debug_print(request_to_curl(response.request), soft_wrap=True)
    debug_print(response_to_text(response))

    ti_provider_api_access_token = response.json()["access_token"]

    debug_print("TI-Provider API Access Token")
    debug_print(jwt_to_text(ti_provider_api_access_token))
    debug_print(ti_provider_api_access_token)

    debug_print("Perform test API call")

    response = session.get(
        fhir_directory_config.federation_list_url,
        headers={"Authorization": f"Bearer {ti_provider_api_access_token}"}
    )

    debug_print(request_to_curl(response.request), soft_wrap=True)
    debug_print(response_to_text(response))

    debug_print("Perform test API call #2")
    response = session.get(
        fhir_directory_config.federation_url,
        headers={
            "Authorization": f"Bearer {ti_provider_api_access_token}"
        }
    )

    debug_print(request_to_curl(response.request), soft_wrap=True)
    debug_print(response_to_text(response))

    print(ti_provider_api_access_token)
