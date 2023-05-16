from .config import ConnectorConfig
from .service_directory import load_service_directory, Service, ServiceVersion
from zeep import Settings, Transport, Client
from zeep.proxy import ServiceProxy
from requests import Session
from requests.auth import HTTPBasicAuth
from enum import Enum
from importlib import resources


def reduce_version(version):
    # Split the version string into parts
    parts = version.split(".")

    # Check if the version string is valid
    if len(parts) != 3:
        raise ValueError("Invalid version string")

    # Return the version without the patch version
    return ".".join(parts[0:2])


def binding_name(sds_service: Service, sds_service_version: ServiceVersion) -> str:
    return f"{{{sds_service_version.TargetNamespace}}}{sds_service.Name}Binding"


class ConnectorServiceName(str, Enum):
    SignatureService = 'SignatureService'
    AuthSignatureService = 'AuthSignatureService'
    EncryptionService = 'EncryptionService'
    CardTerminalService = 'CardTerminalService'
    CardService = 'CardService'
    EventService = 'EventService'
    CertificateService = 'CertificateService'
    AMTSService = 'AMTSService'
    PHRManagementService = 'PHRManagementService'
    PHRService = 'PHRService'
    DPEService = 'DPEService'
    NFDService = 'NFDService'
    KVKService = 'KVKService'
    VSDService = 'VSDService'


def wsdl_location(sds_service: Service, sds_service_version: ServiceVersion) -> str:
    base_dir = resources.files("koap") / "api-telematik" / "conn"
    wsdl_with_version = base_dir / f"{sds_service.Name}_v{sds_service_version.Version.replace('.', '_')}.wsdl"
    if wsdl_with_version.exists():
        return str(wsdl_with_version)
    else:
        wsdl = base_dir / f"{sds_service.Name}.wsdl"
        if not wsdl.exists():
            raise Exception(f"Unable to find WSDL for Service: {sds_service.Name}")
        return str(wsdl)


class ConnectorClient:
    def __init__(self, config: ConnectorConfig, soap_plugins=None):
        self.config = config
        self.soap_plugins = soap_plugins
        session = Session()
        # session.verify = config.trustchain
        self.service_directory = load_service_directory(config, session)
        self.soap_settings = Settings()
        self.soap_settings.forbid_entities = False
        # TODO: support different auth mechanisms
        session.auth = HTTPBasicAuth(
            self.config.auth_basic_username,
            self.config.auth_basic_password.get_secret_value()
        )
        self.transport = Transport(session=session)

    def create_service_client(self, service_name: str, service_version: str) -> ServiceProxy:

        sds_service, sds_service_version = self.service_directory.find_service_version(service_name, service_version)

        client = Client(
            wsdl=wsdl_location(sds_service, sds_service_version),
            settings=self.soap_settings,
            transport=self.transport,
            plugins=self.soap_plugins
        )

        service = client.create_service(
            binding_name(sds_service, sds_service_version),
            address=sds_service_version.EndpointTLS.Location
        )

        return service

    def context(self):
        ctx = {
            'MandantId': self.config.mandant_id,
            'ClientSystemId': self.config.client_system_id,
            'WorkplaceId': self.config.workplace_id,
        }
        if self.config.user_id is not None:
            ctx['UserId'] = self.config.user_id
        return ctx
