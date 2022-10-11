package de.gematik.directory.samples.jose4jextension;

import org.jose4j.jwa.AlgorithmFactoryFactory;
import org.jose4j.keys.EllipticCurves;

import java.lang.reflect.Method;
import java.security.spec.ECParameterSpec;

public class JOSE4JBrainpoolExtension {
    private static boolean installed = false;

    private static void addCurve(String name, ECParameterSpec spec) {
        try {
            Method method = EllipticCurves.class.getDeclaredMethod("addCurve", String.class, ECParameterSpec.class);
            method.setAccessible(true);
            method.invoke(EllipticCurves.class, name, spec);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    public static void installExtension() {
        if (installed) {
            return;
        }
        installed = true;
        addCurve(BP256R1Algorithm.CURVE, BP256R1Algorithm.EC_PARAMETER_SPEC);
        AlgorithmFactoryFactory.getInstance().getJwsAlgorithmFactory()
                .registerAlgorithm(new BP256R1Algorithm());
    }
}
