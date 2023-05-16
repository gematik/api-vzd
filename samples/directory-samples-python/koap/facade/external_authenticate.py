from koap.client import ConnectorClient
from pydantic import BaseModel
from enum import Enum
from typing import Mapping, Any, Optional
from zeep.helpers import serialize_object


class CardTypeEnum(str, Enum):
    EGK = "EGK"
    HBA_QSIG = "HBA-qSig"
    HBA = "HBA"
    SMC_B = "SMC-B"
    HSM_B = "HSM-B"
    SMC_KT = "SMC-KT"
    KVK = "KVK"
    ZOD_20 = "ZOD_2.0"
    UNKNOWN = "UNKNOWN"
    HBAx = "HBAx"
    SM_B = "SM-B"


# cards which can be used for (external) authentication
AUTH_CARDS = [CardTypeEnum.HBA, CardTypeEnum.SMC_B, CardTypeEnum.HSM_B, CardTypeEnum.SM_B]


class Card(BaseModel):
    CardType: CardTypeEnum | str
    CardHandle: str
    CardHolderName: str
    raw: Optional[Mapping[str, Any]]


def obj_to_card(zeep_obj) -> Card:
    card_dict = serialize_object(zeep_obj)
    card = Card.parse_obj(card_dict)
    card.raw = card_dict
    return card


class ExternalAuthenticateFacade:
    def __init__(self, client: ConnectorClient):
        self.client = client
        self.event_service = client.create_service_client('EventService', '7.2.0')

    def get_auth_cards(self):
        get_cards_response = self.event_service.GetCards(
            Context=self.client.context()
        )
        raw_cards = filter(lambda c: c.CardType in AUTH_CARDS, get_cards_response.Cards.Card)
        return list(map(obj_to_card, raw_cards))
