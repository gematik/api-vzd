from typing import List, Optional
from pydantic import (BaseSettings)
from urllib.parse import urljoin
from requests import Session
from zeep import Client
from zeep.proxy import ServiceProxy
from zeep.transports import Transport
from zeep.settings import Settings
from zeep.plugins import HistoryPlugin
from requests.auth import HTTPBasicAuth
from lxml import etree

soap_settings = Settings()
soap_settings.forbid_entities = False

session = Session()
session.verify = False
transport = Transport(session=session)

soap_history = HistoryPlugin()


def last_soap_request() -> str:
    envelope = soap_history.last_sent["envelope"]
    return etree.tostring(envelope, pretty_print=True).decode("utf-8")


def last_soap_response() -> str:
    envelope = soap_history.last_received["envelope"]
    return etree.tostring(envelope, pretty_print=True).decode("utf-8")


class ConnectorConfig(BaseSettings):
    base_url: str
    mandant_id: str
    client_system_id: str
    workplace_id: str
    user_id: str
    username: Optional[str]
    password: Optional[str]

    def construct_url(self, path: str) -> str:
        return urljoin(self.base_url, path)


connector_config = ConnectorConfig(
    base_url="https://192.168.1.156/",
    mandant_id="M1",
    client_system_id="C1",
    workplace_id="A1",
    user_id="U1",
    username="client",
    password="client",
)

session.auth = HTTPBasicAuth(connector_config.username, connector_config.password)


def create_service_client(service_name: str, namespace: str) -> ServiceProxy:
    client = Client(
        f"./api-telematik/conn/{service_name}.wsdl",
        settings=soap_settings,
        transport=transport,
        plugins=[soap_history]
    )

    service = client.create_service(
        f"{{{namespace}}}{service_name}Binding",
        # TODO: resolve endpoint using servicedirectory.sds 
        address=connector_config.construct_url(f"ws/{service_name}")
    )

    return service


def get_cards():

    service = create_service_client(
      "EventService",
      "http://ws.gematik.de/conn/EventService/WSDL/v7.2"
    )

    response = service.GetCards(
        Context={
            'MandantId': connector_config.mandant_id,
            'ClientSystemId': connector_config.client_system_id,
            'WorkplaceId': connector_config.workplace_id,
        }
    )

    return response.Cards.Card


def get_certificates(card_handle: str, cert_types=List[str]):
    service = create_service_client(
      "CertificateService",
      "http://ws.gematik.de/conn/CertificateService/WSDL/v6.0"
    )

    response = service.ReadCardCertificate(
        CardHandle=card_handle,
        Context={
            'MandantId': connector_config.mandant_id,
            'ClientSystemId': connector_config.client_system_id,
            'WorkplaceId': connector_config.workplace_id,
            'UserId': connector_config.user_id,
        },
        CertRefList=cert_types
    )

    return response.X509DataInfoList.X509DataInfo


def verify_certificate(cert_data: bytes):
    service = create_service_client(
      "CertificateService",
      "http://ws.gematik.de/conn/CertificateService/WSDL/v6.0"
    )

    response = service.VerifyCertificate(
        Context={
            'MandantId': connector_config.mandant_id,
            'ClientSystemId': connector_config.client_system_id,
            'WorkplaceId': connector_config.workplace_id,
            'UserId': connector_config.user_id,
        },
        X509Certificate=cert_data
    )

    return response


def external_authenticate(card_handle: str, hash: bytes):
    service = create_service_client(
      "AuthSignatureService",
      "http://ws.gematik.de/conn/AuthSignatureService/WSDL/v7.4"
    )

    response = service.ExternalAuthenticate(
        CardHandle=card_handle,
        Context={
            "MandantId": connector_config.mandant_id,
            "ClientSystemId": connector_config.client_system_id,
            "WorkplaceId": connector_config.workplace_id,
        },
        OptionalInputs={
            'SignatureType': 'urn:ietf:rfc:3447',
            'SignatureSchemes': 'RSASSA-PSS'
        },
        BinaryString={
          "Base64Data": {
              "MimeType": "application/octet-stream",
              "_value_1": hash
          }
        }
    )

    return response.SignatureObject.Base64Signature._value_1

