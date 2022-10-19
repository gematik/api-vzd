package de.gematik.directory.samples.jose4jextension;

import org.jose4j.jwa.AlgorithmFactoryFactory;
import org.jose4j.keys.EllipticCurves;

import java.lang.reflect.Method;
import java.security.spec.ECParameterSpec;

public class JOSE4JBrainpoolExtension {
    private static boolean installed = false;

    public static void installExtension() {
        if (installed) {
            return;
        }
        installed = true;
        EllipticCurves.addCurve(BP256R1Algorithm.CURVE, BP256R1Algorithm.EC_PARAMETER_SPEC);
        AlgorithmFactoryFactory.getInstance().getJwsAlgorithmFactory()
                .registerAlgorithm(new BP256R1Algorithm());
    }
}
