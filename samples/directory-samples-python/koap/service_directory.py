from pydantic import BaseModel
from koap.config import ConnectorConfig
from typing import List, Tuple, Optional
from requests import Session
import xml.etree.ElementTree as ET


def element_to_obj(element: ET.Element, single_elements: List[str] = [], collapse_elements: List[Tuple] = []):
    result = {}
    result.update(element.attrib)
    tag = element.tag.split('}')[-1]

    for child in element:
        key = child.tag.split('}')[-1]
        val = element_to_obj(child, single_elements, collapse_elements)
        if key in single_elements:
            result[key] = val
        elif key in result:
            result[key].append(val)
        elif type(val) == str:
            result[key] = val
        else:
            result[key] = [val]

    if len(result.keys()) == 0:
        return element.text

    if element.text is not None:
        result['_text'] = element.text

    for collapse in collapse_elements:
        if collapse[0] == tag:
            return result[key]

    return result


class LocalProductVersion(BaseModel):
    HWVersion: str
    FWVersion: str


class ProductVersion(BaseModel):
    Local: LocalProductVersion


class ProductIdentification(BaseModel):
    ProductVendorID: str
    ProductCode: str
    ProductVersion: ProductVersion


class ProductTypeInformation(BaseModel):
    ProductType: str
    ProductTypeVersion: str


class ProductInformation(BaseModel):
    ProductTypeInformation: ProductTypeInformation
    ProductIdentification: ProductIdentification


class Endpoint(BaseModel):
    Location: str


class ServiceVersion(BaseModel):
    TargetNamespace: str
    Version: str
    EndpointTLS: Endpoint
    Endpoint: Optional[Endpoint] = None


class Service(BaseModel):
    Name: str
    Versions: List[ServiceVersion]


class ServiceInformation(BaseModel):
    Service: List[Service]


class ConnectorServices(BaseModel):
    ProductInformation: ProductInformation
    ServiceInformation: ServiceInformation

    def find_service_version(self, service_name: str, service_version: str) -> Tuple[Service, ServiceVersion]:
        for service in self.ServiceInformation.Service:
            if service.Name == service_name:
                for version in service.Versions:
                    if version.Version == service_version:
                        return (service, version)
                raise Exception(f"Version '{service_version}' for service '{service_name}' is provided by your connector. Available Versions: {','.join(s.Version for s in service.Versions)} ")

        raise Exception(f"Service not found: '{service_name}'")


def load_service_directory(config: ConnectorConfig, session: Session) -> ConnectorServices:
    url = config.construct_url("/connector.sds")

    response = session.get(url)
    root = ET.fromstring(response.text)

    root_obj = element_to_obj(
        root,
        single_elements=[
            "ProductInformation",
            "ProductTypeInformation",
            "ProductIdentification",
            "ProductMiscellaneous",
            "ProductVersion",
            "ServiceInformation",
            "Versions",
            "Local",
            "Endpoint",
            "EndpointTLS",
        ],
        collapse_elements=[
            ("Versions", "Version")
        ]
    )

    # import json
    # print(json.dumps(root_obj, indent=2))

    return ConnectorServices.parse_obj(root_obj)
