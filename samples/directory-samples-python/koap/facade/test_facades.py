from koap.facade.external_authenticate import ExternalAuthenticateFacade
from koap.client import ConnectorClient, ConnectorConfig
from rich.console import Console


debug_console = Console()
print = debug_console.print


def test_external_authenticate():
    client = ConnectorClient(ConnectorConfig())
    ext_auth = ExternalAuthenticateFacade(client)
    print(ext_auth.get_auth_cards())
