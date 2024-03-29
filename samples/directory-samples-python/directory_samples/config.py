from pydantic import (BaseSettings, SecretStr)
from urllib.parse import urljoin


class TIMProviderAuthConfig(BaseSettings):
    """Settings to access the Keycloak for authenticating the TI-Messenger Providers"""
    url: str
    client_id: str
    secret: SecretStr

    class Config:
        env_prefix = "TIM_PROVIDER_AUTH_"


class FHIRDirectoryConfig(BaseSettings):
    """Settings to access the FHIR Directory, defaults to TU"""
    base_url: str

    @property
    def search_url(self):
        return urljoin(self.base_url, "/search/")

    @property
    def tim_authenticate_url(self):
        return urljoin(self.base_url, "/tim-authenticate")

    @property
    def ti_provider_authenticate_url(self):
        return urljoin(self.base_url, "/ti-provider-authenticate")

    @property
    def federation_list_url(self):
        return urljoin(self.base_url, "/tim-provider-services/FederationList/federationList.jws")

    @property
    def federation_url(self):
        return urljoin(self.base_url, "/tim-provider-services/federation")

    @property
    def owner_authenticate_url(self):
        return urljoin(self.base_url, "/owner-authenticate")

    class Config:
        env_prefix = "FHIR_DIRECTORY_"

class MatrixPasswordConfig(BaseSettings):
    """Settings to access the matrix homeserver"""
    id: str
    password: SecretStr

    @property
    def homeserver_url(self) -> str:
        return f"https://{self.homeserver}"

    @property
    def homeserver(self) -> str:
        return self.id.split(':', 1)[1]

    class Config:
        env_prefix = "MATRIX_"


class MatrixConfig(BaseSettings):
    """Settings to access the matrix homeserver"""
    homeserver: str

    @property
    def homeserver_url(self) -> str:
        return f"https://{self.homeserver}"

    @property
    def homeserver_backchannel_url(self) -> str:
        return f"https://{self.homeserver}:8448"
    
    class Config:
        env_prefix = "MATRIX_"


class OwnerSoftCertConfig(BaseSettings):
    """Srttings for soft-certificate based OwnerAPI authentication‚"""
    cert_filename_der: str
    key_filename_der: str

    class Config:
        env_prefix = "OWNER_"
