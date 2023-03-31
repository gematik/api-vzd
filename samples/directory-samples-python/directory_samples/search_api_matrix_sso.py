from urllib.parse import urljoin, quote, urlparse
from requests import (Session)
from rich import (get_console)
from .apitools import (request_to_curl, response_to_text, jwt_to_text)
from .config import (MatrixConfig, FHIRDirectoryConfig)
from http.server import BaseHTTPRequestHandler, HTTPServer
from threading import Thread, Event
from queue import Queue
from time import sleep


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

    login_flows = response.json()

    assert "flows" in login_flows
    assert len(list(filter(lambda f: f["type"] == "m.login.sso", login_flows["flows"]))) > 0
    assert len(list(filter(lambda f: f["type"] == "m.login.token", login_flows["flows"]))) > 0

    # Start SSO Login flow
    # https://matrix.org/docs/guides/sso-for-client-developers
    class SSORedirectRequestHandler(BaseHTTPRequestHandler):
        def do_GET(self):
            query = urlparse(self.path).query
            if query is None or query == "":
                self.send_response(400)
                self.end_headers()
                return
            query_dict = dict(qc.split("=") for qc in query.split("&"))
            if "loginToken" not in query_dict:
                self.send_response(400)
                self.end_headers()
                return
            self.send_response(200)
            self.send_header("Content-type", "text/plain")
            self.end_headers()
            self.wfile.write("Login succesful. Please continue on command line.".encode())
            self.server.queue.put(query_dict["loginToken"])

    class SSORedirectServer(HTTPServer):
        def __init__(self, queue: Queue):
            self.queue = queue
            super().__init__(("127.0.0.1", 8136), SSORedirectRequestHandler)

    queue = Queue()
    shutdownEvent = Event()

    def spawn_sso_redirect_server():
        httpd = SSORedirectServer(queue)
        httpd_thread = Thread(target=lambda: httpd.serve_forever())
        httpd_thread.start()

        def shutdown_listener():
            while True:
                if shutdownEvent.is_set():
                    httpd.shutdown()
                    break
                sleep(.1)
                
        Thread(target=shutdown_listener).start()

    sso_redirect_uri = "http://127.0.0.1:8136/"
    print(f"Starting server at {sso_redirect_uri}")
    spawn_sso_redirect_server()

    sso_login_url = urljoin(matrix_config.homeserver_url, f"/_matrix/client/r0/login/sso/redirect?redirectUrl={quote(sso_redirect_uri)}")

    print(f"Visit {sso_login_url} to continue login", soft_wrap=True)

    try:
        login_token = queue.get()
    except KeyboardInterrupt:
        shutdownEvent.set()
        exit()

    shutdownEvent.set()
    print(login_token)

    print("Perform login and get Matrix Access Token:")

    response = session.post(
      urljoin(matrix_config.homeserver_url, "/_matrix/client/r0/login"),
      json={
        "type": "m.login.token",
        "token": login_token,
      }
    )

    print(request_to_curl(response.request))
    print(response_to_text(response))

    user_id = response.json()["user_id"]

    matrix_access_token = response.json()["access_token"]

    # AF_10036: get OpenID token from Matrix server
    # https://spec.matrix.org/v1.3/client-server-api/#openid
    response = session.post(
      urljoin(matrix_config.homeserver_url, f"/_matrix/client/v3/user/{user_id}/openid/request_token?access_token={matrix_access_token}"),
      json={

      }
    )

    print("Request Matrix OpenID Token:")
    print(request_to_curl(response.request))
    print(response_to_text(response))

    matrix_opendid_token = response.json()["access_token"]

    print("Backchannel Userinfo:")
    response = session.get(
      urljoin(matrix_config.homeserver_backchannel_url, "/_matrix/federation/v1/openid/userinfo"),
      params={
        "access_token": matrix_opendid_token,
      }
    )
    print(request_to_curl(response.request))
    print(response_to_text(response))

    # AF_10036: get search-token from /tim-authenticate
    response = session.get(
      urljoin(fhir_directory_config.tim_authenticate_url, f"?mxId={matrix_config.homeserver}"),
      headers={
        "X-Matrix-OpenID-Token": matrix_opendid_token
      },
    )

    print("FHIR-Directory /tim-authenticate response")
    print(request_to_curl(response.request), soft_wrap=True)
    print(response_to_text(response))

    assert response.status_code == 200

    search_api_access_token = response.json()["access_token"]

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
