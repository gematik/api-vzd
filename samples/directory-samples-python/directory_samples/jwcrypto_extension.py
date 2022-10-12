from jwcrypto.jwa import (JWA, _RawEC, JWAAlgorithm)
from jwcrypto.jwk import JWKpycaCurveMap
from cryptography.hazmat.primitives import hashes


class _BP256R1(_RawEC, JWAAlgorithm):

    name = "BP256R1"
    description = "ECDSA using Brainpool256R1 curve and SHA-256"
    keysize = 256
    algorithm_usage_location = 'alg'
    algorithm_use = 'sig'

    def __init__(self):
        super(_BP256R1, self).__init__('BP-256', hashes.SHA256())


def install_jwcrypto_extension():
    JWA.algorithms_registry['BP256R1'] = _BP256R1
    JWKpycaCurveMap['brainpoolP256r1'] = 'BP-256'
    