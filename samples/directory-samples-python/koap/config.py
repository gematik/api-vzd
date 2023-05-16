from typing import Optional
from urllib.parse import urljoin
from pydantic import BaseSettings, SecretStr


class ConnectorConfig(BaseSettings):
    base_url: str
    mandant_id: str
    client_system_id: str
    workplace_id: str
    user_id: str
    trustchain: Optional[str] = None
    auth_basic_username: Optional[str] = None
    auth_basic_password: Optional[SecretStr] = None
    # TODO p12 mututual TLS

    def construct_url(self, path: str) -> str:
        return urljoin(self.base_url, path)
    
    class Config:
        env_prefix = 'konnektor_'
