from typing import Mapping, Union
from requests import (PreparedRequest, Response)
from requests.exceptions import (JSONDecodeError)
from json import (loads, dumps)
from base64 import (urlsafe_b64decode, urlsafe_b64encode)


def request_to_curl(
        request: PreparedRequest,
        hide_body_secrets: Mapping[str, str] = dict()
      ) -> str:
    lines = []
    lines.append(f'curl -X {request.method} "{request.url}"')

    relevant_headers = {k: v for k, v in request.headers.items() if k in ["Authorization", "Content-Type", "SOAPAction"] or k.startswith("X-")}
    for key, value in relevant_headers.items():
        lines.append(f'-H "{key}: {request.headers[key]}"')

    if request.body is not None and request.headers.get("Content-Type", "").startswith("application/json"):
        body = loads(request.body.decode("utf-8"))
        body = body | hide_body_secrets
        lines.append(f"-d @- << EOF\n{dumps(body, indent=2)}\nEOF")
    elif request.body is not None:
        lines.append(f"-d @- << EOF\n{request.body}\nEOF")
    return " \\\n    ".join(lines)


def response_to_text(
        response: Response,
        hide_body_secrets: Mapping[str, str] = dict()
      ) -> str:
    """Converts the response to human readable text"""
    str = f"{response.status_code}"
    try:
        str = str + "\n" + dumps(response.json(), indent=2)
    except JSONDecodeError:
        str = str + "\n" + response.text

    return str


def jwt_to_text(token: str) -> str:
    (header, payload, signature) = map(lambda data: base64url_decode(data), token.split("."))

    header = loads(header.decode("utf-8"))
    payload = loads(payload.decode("utf-8"))

    return dumps(header, indent=4) + "\n" + dumps(payload, indent=4)


def base64url_decode(input: Union[str, bytes]) -> bytes:
    if isinstance(input, str):
        input = input.encode("ascii")

    rem = len(input) % 4

    if rem > 0:
        input += b"=" * (4 - rem)

    return urlsafe_b64decode(input)


def base64url_encode(input: bytes) -> bytes:
    return urlsafe_b64encode(input).replace(b"=", b"")
