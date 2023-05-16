from koap.client import ConnectorClient, ConnectorServiceName, ConnectorConfig
from rich.console import Console
import pytest

c = Console()
print = c.print


def test_get_cards():
    config = ConnectorConfig()
    conn = ConnectorClient(config)

    event_service = conn.create_service_client('EventService', '7.2.0')

    response = event_service.GetCards(
        Context=conn.context()
    )

    assert len(response.Cards.Card) > 0, "More than one card must be available"


def test_certificates():
    config = ConnectorConfig()
    conn = ConnectorClient(config)

    event_service = conn.create_service_client('EventService', '7.2.0')
    cards_response = event_service.GetCards(
        Context=conn.context()
    )
    assert len(cards_response.Cards.Card) > 0, "More than one card must be available"

    card = next(filter(lambda c: c.CardType == 'SMC-B', cards_response.Cards.Card))

    print(card.CardType)

    certificate_service = conn.create_service_client('CertificateService', '6.0.1')

    certificates_response = certificate_service.ReadCardCertificate(
        CardHandle=card.CardHandle,
        Context=conn.context(),
        CertRefList=["C.AUT"],
    )

    print(certificates_response.X509DataInfoList.X509DataInfo)

    assert len(certificates_response.X509DataInfoList.X509DataInfo) > 0


def test_specific_version():
    config = ConnectorConfig()
    conn = ConnectorClient(config)

    conn.create_service_client(ConnectorServiceName.CertificateService, '6.0.1')
    
    with pytest.raises(Exception):
        conn.create_service_client('CertificateService', '10.0.0')


def test_create_client():
    config = ConnectorConfig()
    conn = ConnectorClient(config)
    assert 0 < len(conn.service_directory.ServiceInformation.Service)
