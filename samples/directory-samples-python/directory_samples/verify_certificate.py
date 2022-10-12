from .koap import (
  get_cards, 
  get_certificates,
  last_soap_request,
  last_soap_response,
  verify_certificate,
)
from rich import print


def main():
    cards = get_cards()

    print(last_soap_request())
    print(last_soap_response())

    hba = next(filter(lambda card: card['CardType'] == 'HBA', cards))

    card_handle = hba['CardHandle']

    certificates = get_certificates(card_handle, ['C.QES'])

    print(last_soap_request())
    print(last_soap_response())

    verification_report = verify_certificate(certificates[0].X509Data.X509Certificate)

    print(last_soap_request())
    print(last_soap_response())

    print(verification_report)

