/*
Copyright 2026, gematik GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

*******

For additional notes and disclaimer from gematik and in case of changes
by gematik, find details in the "Readme" file.
**/
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
