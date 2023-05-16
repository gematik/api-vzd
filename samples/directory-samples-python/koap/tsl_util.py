import requests
import base64
import xml.etree.ElementTree as ET
from cryptography import x509
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization


TSL_URL_TU = "https://download-test.tsl.ti-dienste.de/ECC/ECC-RSA_TSL-test.xml"
TSL_URL_RU = "https://download-ref.tsl.ti-dienste.de/ECC/ECC-RSA_TSL-ref.xml"
TSL_URL_PU = "https://download.tsl.ti-dienste.de/ECC/ECC-RSA_TSL.xml"

TYPE_CA_NON_QES = "http://uri.etsi.org/TrstSvc/Svctype/CA/PKC"


def tsl_to_pem(tsl_url: str, output_file: str):
    response = requests.get(tsl_url)

    if response.status_code != 200:
        raise Exception("Failed to retrieve XML. Error code:", response.status_code)

    root = ET.fromstring(response.content)

    ns = {'tsl': 'http://uri.etsi.org/02231/v2#'}

    with open(output_file, "wb") as out:
        # Iterate over the elements
        for element in root.findall('./tsl:TrustServiceProviderList/tsl:TrustServiceProvider/tsl:TSPServices/tsl:TSPService', ns):
            type = element.findtext('./tsl:ServiceInformation/tsl:ServiceTypeIdentifier', namespaces=ns)
            if type != TYPE_CA_NON_QES:
                continue
            # TODO: differentiate between Components CAs and User CAs
            cert_der_b64 = element.findtext("tsl:ServiceInformation/tsl:ServiceDigitalIdentity/tsl:DigitalId/tsl:X509Certificate", namespaces=ns)
            cert_der = base64.b64decode(cert_der_b64)
            certificate = x509.load_der_x509_certificate(cert_der, default_backend())
            pem_certificate = certificate.public_bytes(encoding=serialization.Encoding.PEM)
            out.write(pem_certificate)
