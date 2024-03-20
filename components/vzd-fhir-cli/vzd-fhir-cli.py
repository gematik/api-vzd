import yaml
from base64 import b64decode
from cryptography.fernet import Fernet
import requests
from loguru import logger
import argparse

# Configuration file path
CONFIG_FILE = "config.yaml"

class FHIROauthClient:
    """
    FHIROauthClient class handles OAuth client credential flow for authentication
    with a FHIR server.
    """
    def __init__(self, config_path):
        self.config_path = config_path
        self.client_id = None
        self.client_secret = None
        self.access_token = None
        self.token_url = None
        self.base_url = None
        self._load_config()

    def _load_config(self):
        """
        Loads configuration details from the YAML file. Decrypts client_id and client_secret
        using a user-provided password.
        """
        with open(self.config_path, "r") as f:
            config = yaml.safe_load(f)
        self.token_url = config["token_url"]
        self.base_url = config["base_url"]
        # Decrypt client credentials
        password = input("Enter password to decrypt credentials: ")
        fernet = Fernet(b64decode(password))
        self.client_id = fernet.decrypt(config["client_id"]).decode()
        self.client_secret = fernet.decrypt(config["client_secret"]).decode()

    def get_access_token(self):
        """
        Fetches an access token from the FHIR server using OAuth client credential flow.
        """
        payload = {
            "grant_type": "client_credentials",
            "client_id": self.client_id,
            "client_secret": self.client_secret,
        }
        headers = {"Content-Type": "application/x-www-form-urlencoded"}
        response = requests.post(self.token_url, auth=(self.client_id, self.client_secret), data=payload, headers=headers)
        response.raise_for_status()  # Raise exception for unsuccessful requests
        self.access_token = response.json()["access_token"]
        logger.info("Access token retrieved successfully.")

    def make_request(self, method, url, params=None):
        """
        Makes a request to the FHIR server with appropriate headers and error handling.
        """
        if not self.access_token:
            self.get_access_token()
        headers = {"Authorization": f"Bearer {self.access_token}"}
        response = requests.request(method, url, headers=headers, params=params)
        response.raise_for_status()
        return response.json()

class FHIRClient:
    """
    FHIRClient class handles interaction with the FHIR server for searching resources.
    """

    def __init__(self, oauth_client, fhir_server_url):
        self.oauth_client = oauth_client
        self.fhir_server_url = fhir_server_url

    def search_fhir(self, search_term, search_type="fhir"):
        """
        Performs a search on the FHIR server based on search_term and search_type.
        search_type can be "fhir" for FHIR search or "text" for full text search.
        """
        if search_type == "fhir":
            url = f"{self.fhir_server_url}/_search"
            params = {"_include": "**:system", "_sort": "_lastUpdated"}
            if search_term.startswith("HealthcareService"):
                params["type"] = search_term
            elif search_term.startswith("PractitionerRole"):
                params["type"] = search_term
            else:
                logger.error(f"Invalid search term type: {search_term}")
                return None
        elif search_type == "text":
            url = f"{self.oauth_client.base_url}/Patient"
            params = {"_search": search_term}
        else:
            logger.error(f"Invalid search type: {search_type}")
            return None
        return self.oauth_client.make_request("GET", url, params=params)
    
    def process_results(self, search_results):
        """
        Processes the search results and extracts relevant information
        based on the FHIR server data structure. Prints the results in YAML format.
        """
        if not search_results:
            logger.info("No results found for the search.")
            return
        for entry in search_results["entry"]:
            resource = entry["resource"]
            print(yaml.dump(resource))

def main(config_file, fhir_server_url, auth_server_url):
    """
    Main function for command-line execution.
    """
    # Initialize FHIROauthClient and FHIRClient objects
    oauth_client = FHIROauthClient(config_file, auth_server_url)
    # Prompt user for search details
    search_term = input("Enter search term (e.g., HealthcareService, PractitionerRole): ")
    search_type = input("Choose search type (fhir/text): ")
    fhir_client = FHIRClient(oauth_client, fhir_server_url)
    # Call search function and handle results (implementation needed)
    # fhir_client.search_fhir(search_term, search_type)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="FHIR Client")
    parser.add_argument("--fhir_server_url", default="https://fhir-directory-test.vzd.ti-dienste.de/search", required=True, help="URL of the FHIR server")
    parser.add_argument("--auth_server_url", default="https://auth-ref.vzd.ti-dienste.de:9443/auth/realms/RSDirectoryAdministration/protocol/openid-connect/token", required=True, help="URL of the OAuth2 authentication server")
    parser.add_argument("--config_file", default="config.yaml", required=True, help="Path to the configuration file")
    args = parser.parse_args()

    main(args.config_file, args.fhir_server_url, args.auth_server_url)