package de.gematik.directory.samples.jose4jextension;

import org.jose4j.jws.EcdsaUsingShaAlgorithm;
import org.jose4j.jws.JsonWebSignatureAlgorithm;

import java.math.BigInteger;
import java.security.spec.ECFieldFp;
import java.security.spec.ECParameterSpec;
import java.security.spec.ECPoint;
import java.security.spec.EllipticCurve;

public class BP256R1Algorithm extends EcdsaUsingShaAlgorithm implements JsonWebSignatureAlgorithm {
    public static final ECParameterSpec EC_PARAMETER_SPEC = new ECParameterSpec(
            new EllipticCurve(
                    new ECFieldFp(
                            new BigInteger("76884956397045344220809746629001649093037950200943055203735601445031516197751")
                    ),
                    new BigInteger("56698187605326110043627228396178346077120614539475214109386828188763884139993"),
                    new BigInteger("17577232497321838841075697789794520262950426058923084567046852300633325438902")
            ),
            new ECPoint(
                    new BigInteger("63243729749562333355292243550312970334778175571054726587095381623627144114786"),
                    new BigInteger("38218615093753523893122277964030810387585405539772602581557831887485717997975")
            ),
            new BigInteger("76884956397045344220809746629001649092737531784414529538755519063063536359079"),
    1);
    public static String CURVE = "BP-256";

    public static String ALGORITHM = "BP256R1";

    public BP256R1Algorithm() {
        super(ALGORITHM,  "SHA256withECDSA", "BP-256", 64);
    }
}
