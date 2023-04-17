package de.gematik.directory.samples.ownersignin;

import de.gematik.directory.samples.jose4jextension.BP256R1Algorithm;
import de.gematik.directory.samples.jose4jextension.JOSE4JBrainpoolExtension;
import io.restassured.path.json.JsonPath;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.client.utils.URLEncodedUtils;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.jose4j.base64url.Base64;
import org.jose4j.base64url.Base64Url;
import org.jose4j.jwa.AlgorithmConstraints;
import org.jose4j.jwe.ContentEncryptionAlgorithmIdentifiers;
import org.jose4j.jwe.JsonWebEncryption;
import org.jose4j.jwe.KeyManagementAlgorithmIdentifiers;
import org.jose4j.jwk.HttpsJwks;
import org.jose4j.jwk.JsonWebKey;
import org.jose4j.jwk.PublicJsonWebKey;
import org.jose4j.jws.AlgorithmIdentifiers;
import org.jose4j.jws.JsonWebSignature;
import org.jose4j.jwt.JwtClaims;
import org.jose4j.jwt.consumer.JwtConsumer;
import org.jose4j.jwt.consumer.JwtConsumerBuilder;
import org.jose4j.jwt.consumer.JwtContext;
import org.jose4j.jwx.JsonWebStructure;
import org.jose4j.keys.resolvers.HttpsJwksVerificationKeyResolver;
import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.security.Security;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.PKCS8EncodedKeySpec;
import java.time.Duration;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Step by step example of authentication flow for FHIR-Directory Owner API using gematik IDP-Service.
 */
public class OwnerSignInSample {
    private final static Logger logger = LoggerFactory.getLogger(OwnerSignInSample.class);
    private final SecureRandom secureRandom = new SecureRandom();
    private static final HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_2)
            .connectTimeout(Duration.ofSeconds(10))
            .build();
    // configuration
    final String IDP_URL = "https://idp-test.app.ti-dienste.de";
    final String CLIENT_ID = "GEMgematFHI1KPraWvqT";

    final String REDIRECT_URI = "https://fhir-directory-test.vzd.ti-dienste.de/signin-gematik-idp-dienst";
    final String SCOPE = "fhir-vzd openid";

    final String OWNER_CERT_FILENAME_DER = System.getenv("OWNER_CERT_FILENAME_DER");
    final String OWNER_KEY_FILENAME_DER = System.getenv("OWNER_KEY_FILENAME_DER");

    @Test
    public void testOwnerSignIn() throws Exception {

        Security.removeProvider(BouncyCastleProvider.PROVIDER_NAME);
        Security.insertProviderAt(new BouncyCastleProvider(), 1);
        JOSE4JBrainpoolExtension.installExtension();

        Assert.assertNotNull("Environment variable OWNER_CERT_FILENAME_DER must be set", OWNER_CERT_FILENAME_DER);
        Assert.assertNotNull("Environment variable OWNER_KEY_FILENAME_DER must be set", OWNER_KEY_FILENAME_DER);

        logger.debug("Configuration");
        logger.debug("IDP_URL: {}", IDP_URL);
        logger.debug("CLIENT_ID: {}", CLIENT_ID);
        logger.debug("REDIRECT_URI: {}", REDIRECT_URI);
        logger.debug("SCOPE: {}", SCOPE);
        logger.debug("OWNER_CERT_FILENAME_DER: {}", OWNER_CERT_FILENAME_DER);
        logger.debug("OWNER_KEY_FILENAME_DER: {}", OWNER_KEY_FILENAME_DER);

        // Step 1
        logger.debug("= Step 1: Step 1: Service retrieves and processes OpenID Configuration");
        logger.debug("== Step 1a: Request OpenID configuration manifest");

        URI openidConfigurationURI = new URIBuilder(IDP_URL)
                .setPath("/.well-known/openid-configuration")
                .build();


        String openidConfigurationJWT = loadStringFromURI(openidConfigurationURI);

        logger.debug("== Step 1b: Verify OpenID configuration manifest signature");

        // extract X509 signer certificate
        JsonWebStructure openidConfigurationJWS = JsonWebStructure.fromCompactSerialization(openidConfigurationJWT);
        Assert.assertNotNull(openidConfigurationJWS.getHeaders().getObjectHeaderValue("x5c"));
        @SuppressWarnings("unchecked") List<String> openidConfigurationX5CHeader = (List<String>) openidConfigurationJWS.getHeaders().getObjectHeaderValue("x5c");
        byte[] openidConfigurationCertBytes = Base64.decode(openidConfigurationX5CHeader.stream().findFirst().orElseThrow());
        X509Certificate openidConfigurationCert = (X509Certificate) CertificateFactory.getInstance("X.509")
                .generateCertificate(new ByteArrayInputStream(openidConfigurationCertBytes));

        logger.error("Certificate validation is not implemented");

        // Parse JWT and verify the signature
        JwtConsumer openidConfigurationConsumer = new JwtConsumerBuilder()
                .setVerificationKey(openidConfigurationCert.getPublicKey())
                .build();
        JwtContext openidConfiguration = openidConfigurationConsumer.process(openidConfigurationJWT);
        logger.debug("openid_configuration:\n{}", new JsonPath(openidConfiguration.getJwtClaims().toJson()).prettify());

        logger.debug("== Step 1c: Retrieve configuration values");

        Assert.assertTrue(openidConfiguration.getJwtClaims().getClaimsMap().containsKey("authorization_endpoint"));
        URI authorizationEndpoint = new URI(openidConfiguration.getJwtClaims().getStringClaimValue("authorization_endpoint"));
        logger.debug("IDP Authorization endpoint URL: {}", authorizationEndpoint);

        Assert.assertTrue(openidConfiguration.getJwtClaims().getClaimsMap().containsKey("token_endpoint"));
        URI tokenEndpoint = new URI(openidConfiguration.getJwtClaims().getStringClaimValue("token_endpoint"));
        logger.debug("IDP token endpoint URL: {}", tokenEndpoint);

        Assert.assertTrue(openidConfiguration.getJwtClaims().getClaimsMap().containsKey("uri_puk_idp_enc"));
        URI uriPukIdpEnc = new URI(openidConfiguration.getJwtClaims().getStringClaimValue("uri_puk_idp_enc"));
        PublicJsonWebKey pukIdpEnc = PublicJsonWebKey.Factory.newPublicJwk(loadStringFromURI(uriPukIdpEnc));
        logger.debug("IDP encryption key URL: {}", uriPukIdpEnc);

        Assert.assertTrue(openidConfiguration.getJwtClaims().getClaimsMap().containsKey("uri_puk_idp_sig"));
        URI uriPukIdpSig = new URI(openidConfiguration.getJwtClaims().getStringClaimValue("uri_puk_idp_sig"));
        PublicJsonWebKey pukIdpSig = PublicJsonWebKey.Factory.newPublicJwk(loadStringFromURI(uriPukIdpSig));
        logger.debug("IDP signature key URL: ={}", uriPukIdpSig);

        // Step 2
        logger.debug("= Step 2: Service prepares and initiates the PKCE flow");

        logger.debug("== Step 2a: Generate random code verifier");
        byte[] pkceCodeVerifierBytes = new byte[32];
        secureRandom.nextBytes(pkceCodeVerifierBytes);
        String pkceCodeVerifier = Base64Url.encode(pkceCodeVerifierBytes);
        logger.debug("code_verifier={}", pkceCodeVerifier);

        logger.debug("== Step 2b: Calculate code challange from code verifier");
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] pkceCodeChallengeBytes = digest.digest(pkceCodeVerifier.getBytes(StandardCharsets.UTF_8));
        String pkceCodeChallenge = Base64Url.encode(pkceCodeChallengeBytes).toString();
        logger.debug("code_challange={}", pkceCodeChallenge);

        logger.debug("== Step 2c: Generate random state");
        byte[] pkceStateBytes = new byte[16];
        secureRandom.nextBytes(pkceStateBytes);
        String pkceState = Base64Url.encode(pkceStateBytes).toString();
        logger.debug("state={}", pkceState);

        // Step 3
        logger.debug("= Step 3: Perform authentication");

        logger.debug("== Step 3a: Start authentication by requesting the challenge");
        URI authorizationRequestURI = new URIBuilder(authorizationEndpoint)
                .addParameter("response_type", "code")
                .addParameter("client_id", CLIENT_ID)
                .addParameter("scope", SCOPE)
                .addParameter("redirect_uri", REDIRECT_URI)
                .addParameter("state", pkceState)
                .addParameter("code_challenge", pkceCodeChallenge)
                .addParameter("code_challenge_method", "S256")
                .build();

        String authorizationResponseString = loadStringFromURI(authorizationRequestURI);

        logger.debug(authorizationResponseString);

        JsonPath authorizationResponse = new JsonPath(authorizationResponseString);

        logger.debug("== Step 3b: Verify challenge signature");
        String challenge = authorizationResponse.get("challenge");

        JsonWebSignature challengeJWS = new JsonWebSignature();
        challengeJWS.setAlgorithmConstraints(
                new AlgorithmConstraints(
                        AlgorithmConstraints.ConstraintType.PERMIT,
                        BP256R1Algorithm.ALGORITHM));

        challengeJWS.setCompactSerialization(challenge);
        challengeJWS.setKey(pukIdpSig.getKey());

        Assert.assertTrue(challengeJWS.verifySignature());
        JsonPath challengeClaims = new JsonPath(challengeJWS.getPayload());
        logger.debug("Challenge signature is valid: {}", challengeClaims);

        logger.debug("== Step 3b: Sign challenge");
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");

        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(new FileInputStream(OWNER_KEY_FILENAME_DER).readAllBytes());
        JsonWebKey ownerKey = JsonWebKey.Factory.newJwk(keyFactory.generatePrivate(keySpec));

        X509Certificate ownerCertificate = (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(new FileInputStream(OWNER_CERT_FILENAME_DER));

        JwtClaims challengeResponsePayload = new JwtClaims();
        challengeResponsePayload.setClaim("njwt", challenge);
        JsonWebSignature challengeResponseJWS = new JsonWebSignature();
        challengeResponseJWS.setHeader("typ", "JWT");
        challengeResponseJWS.setHeader("cty", "NJWT");
        challengeResponseJWS.setHeader("x5c", Arrays.asList(Base64.encode(ownerCertificate.getEncoded())));
        challengeResponseJWS.setAlgorithmHeaderValue(AlgorithmIdentifiers.RSA_PSS_USING_SHA256);
        challengeResponseJWS.setPayload(challengeResponsePayload.toJson());
        challengeResponseJWS.setKey(ownerKey.getKey());
        challengeResponseJWS.sign();

        logger.debug("Signed challenge response:\n{}", challengeResponseJWS.getCompactSerialization());

        JsonWebEncryption challengeResponseJWE = new JsonWebEncryption();
        JwtClaims challengeResponseSignedPayload = new JwtClaims();
        challengeResponseSignedPayload.setClaim("njwt", challengeResponseJWS.getCompactSerialization());
        challengeResponseJWE.setHeader("cty", "NJWT");
        challengeResponseJWE.setHeader("exp", challengeClaims.getInt("exp"));
        challengeResponseJWE.setPlaintext(challengeResponseSignedPayload.toJson());
        challengeResponseJWE.setAlgorithmHeaderValue(KeyManagementAlgorithmIdentifiers.ECDH_ES);
        challengeResponseJWE.setEncryptionMethodHeaderParameter(ContentEncryptionAlgorithmIdentifiers.AES_256_GCM);
        challengeResponseJWE.setKey(pukIdpEnc.getKey());

        String challengeResponse = challengeResponseJWE.getCompactSerialization();

        logger.debug("Signed and encrypted challenge response:\n{}", challengeResponse);

        logger.debug("== Step 3c: Post challenge response to IDP");

        Map<String, String> challengeResponseParameters = new HashMap<>() {{
            put("signed_challenge", challengeResponse);
        }};

        String challengeResponseBody = challengeResponseParameters.entrySet()
                .stream()
                .map(e -> e.getKey() + "=" + URLEncoder.encode(e.getValue(), StandardCharsets.UTF_8))
                .collect(Collectors.joining("&"));

        HttpRequest challengeResponseRequest = HttpRequest.newBuilder()
                .uri(authorizationEndpoint)
                .headers("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString(challengeResponseBody))
                .build();

        HttpResponse<String> challengeResponseResponse = httpClient.send(challengeResponseRequest, HttpResponse.BodyHandlers.ofString());

        Assert.assertEquals(302, challengeResponseResponse.statusCode());

        URI signinRedirectURI =  new URI(challengeResponseResponse.headers().map().get("Location").stream().findFirst().get());
        logger.debug("Got the PKCE redirect witch code: {}", signinRedirectURI);

        // Step 4

        logger.debug("= Step 4: Service retrieves tokens from IDP");

        Map<String, String> signinRedirectParams = URLEncodedUtils.parse(signinRedirectURI, StandardCharsets.UTF_8)
                .stream()
                .collect(Collectors.toMap(NameValuePair::getName, NameValuePair::getValue));

        String code = signinRedirectParams.get("code");

        byte[] tokenKeyBytes = new byte[32];
        secureRandom.nextBytes(tokenKeyBytes);
        String tokenKey = Base64Url.encode(tokenKeyBytes);

        JsonWebEncryption keyVerifierJWE = new JsonWebEncryption();
        JwtClaims keyVerifierPaylooad = new JwtClaims();
        keyVerifierPaylooad.setClaim("token_key", tokenKey);
        keyVerifierPaylooad.setClaim("code_verifier", pkceCodeVerifier);
        keyVerifierJWE.setPlaintext(keyVerifierPaylooad.toJson());
        keyVerifierJWE.setAlgorithmHeaderValue(KeyManagementAlgorithmIdentifiers.ECDH_ES);
        keyVerifierJWE.setEncryptionMethodHeaderParameter(ContentEncryptionAlgorithmIdentifiers.AES_256_GCM);
        keyVerifierJWE.setKey(pukIdpEnc.getKey());

        Map<String, String> tokenRequestParameters = new HashMap<>() {{
            put("grant_type", "authorization_code");
            put("client_id", CLIENT_ID);
            put("redirect_uri", REDIRECT_URI);
            put("code", code);
            put("key_verifier", keyVerifierJWE.getCompactSerialization());
        }};

        String tokenRequestBody = tokenRequestParameters.entrySet()
                .stream()
                .map(e -> e.getKey() + "=" + URLEncoder.encode(e.getValue(), StandardCharsets.UTF_8))
                .collect(Collectors.joining("&"));

        HttpRequest tokenRequest = HttpRequest.newBuilder()
                .uri(tokenEndpoint)
                .headers("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString(tokenRequestBody))
                .build();

        HttpResponse<String> tokenResponse = httpClient.send(tokenRequest, HttpResponse.BodyHandlers.ofString());

        Assert.assertEquals(200, tokenResponse.statusCode());

        JsonPath tokens = new JsonPath(tokenResponse.body());

        String encryptedAccessToken = tokens.getString("access_token");
        String encryptedIdToken = tokens.getString("id_token");

        JsonWebKey tokenKeyJWK = JsonWebKey.Factory.newJwk(String.format("{\"kty\":\"oct\",\"k\":\"%s\"}", tokenKey));

        JsonWebEncryption encryptedAccessTokenReceiver = new JsonWebEncryption();
        encryptedAccessTokenReceiver.setKey(tokenKeyJWK.getKey());

        // decrypt and retrieve the access_token from NJWT structure
        encryptedAccessTokenReceiver.setCompactSerialization(encryptedAccessToken);
        String accessToken = new JsonPath(encryptedAccessTokenReceiver.getPlaintextString()).getString("njwt");

        JsonWebEncryption encryptedIdTokenReceiver = new JsonWebEncryption();
        encryptedIdTokenReceiver.setKey(tokenKeyJWK.getKey());

        // decrypt and retrieve the id_token from NJWT structure
        encryptedIdTokenReceiver.setCompactSerialization(encryptedIdToken);
        String idToken = new JsonPath(encryptedIdTokenReceiver.getPlaintextString()).getString("njwt");

        logger.debug("access_token: {}", accessToken);
        logger.debug("id_token: {}", idToken);

        // Step 5
        logger.debug("= Step 5: Service verifies the tokens");

        HttpsJwks httpsJkws = new HttpsJwks(openidConfiguration.getJwtClaims().getClaimValueAsString("jwks_uri"));
        HttpsJwksVerificationKeyResolver httpsJwksKeyResolver = new HttpsJwksVerificationKeyResolver(httpsJkws);
        JwtConsumer jwtAccessConsumer = new JwtConsumerBuilder()
                .setVerificationKeyResolver(httpsJwksKeyResolver)
                .setExpectedAudience("https://fhir-directory-test.vzd.ti-dienste.de/")
                .setExpectedIssuer(IDP_URL)
                .build();

        JwtClaims accessTokenClaims = jwtAccessConsumer.processToClaims(accessToken);

        JwtConsumer jwtIdConsumer = new JwtConsumerBuilder()
                .setVerificationKeyResolver(httpsJwksKeyResolver)
                .setExpectedAudience(CLIENT_ID)
                .setExpectedIssuer(IDP_URL)
                .build();

        //JwtClaims accessTokenClaims = jwtConsumer.processToClaims(accessToken);
        JwtClaims idTokenClaims = jwtIdConsumer.processToClaims(idToken);

        logger.debug("ACCESS_TOKEN: "+new JsonPath(accessTokenClaims.toJson()).prettify());
        logger.debug("ID_TOKEN: "+new JsonPath(idTokenClaims.toJson()).prettify());

    }

    public static String loadStringFromURI(URI uri) throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(uri)
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() != 200) {
            if (response.headers().map().get("Location") != null) {
                logger.error(response.headers().map().get("Location").toString());
            }
            throw new IOException(String.format("Invalid HTTP Response code: %s", response.statusCode()));
        }
        return response.body();
    }
}
