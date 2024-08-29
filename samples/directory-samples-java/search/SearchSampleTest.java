package de.gematik.directory.samples.search;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.client.api.IRestfulClientFactory;
import ca.uhn.fhir.rest.client.interceptor.BearerTokenAuthInterceptor;
import org.apache.commons.lang3.StringUtils;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.HealthcareService;
import org.hl7.fhir.r4.model.Organization;
import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;

/**
 * Search examples for VZD FHIR.
 */
public class SearchSampleTest {
    private static final Logger logger = LoggerFactory.getLogger(SearchSampleTest.class);

    // Create only one FhirContext-Instance
    private FhirContext fhirContext = FhirContext.forR4(); // Alternatively use "FhirContext.forR4Cached()"

    // Referenzumgebung (RU)
    private final String BASE_URL_RU = "https://fhir-directory-ref.vzd.ti-dienste.de/";
    // Testumgebung (TU)
    private final String BASE_URL_TU = "https://fhir-directory-tu.vzd.ti-dienste.de/";
    // Produktionsumgebung (PU)
    private final String BASE_URL_PU = "https://fhir-directory.vzd.ti-dienste.de/";

    // Endpoint for (TIM-)Search
    private final String SEARCH_URL_INFIX = "/search/";
    // Endpoint for (FDV-)Search
    private final String FDV_SEARCH_URL_INFIX = "/fdv/search/";
    // Endpoint for (Owner-)Search
    private final String OWNER_SEARCH_URL_INFIX = "/owner/";

    // Used URL for SearchExample
    private final String USED_SEARCH_URL = BASE_URL_RU + FDV_SEARCH_URL_INFIX;

    // Configuration //TODO Set your access token
    private final String TEST_ACCESS_TOKEN = "ey...";

    /**
     * Tests the search functionality using HttpClient (Alternative to FhirClient).
     *
     * @throws Exception if an error occurs during the search.
     */
    @Test
    public void testSearchViaHttpClient() throws Exception {

        // Create HTTP Client and execute query
        URI searchUrl = new URI(getHealthcareServiceUrl());
        HttpRequest request = HttpRequest.newBuilder()
                .uri(searchUrl)
                .headers("Content-Type", "application/fhir+json;charset=UTF-8")
                .headers("Authorization", "Bearer " + TEST_ACCESS_TOKEN)
                .GET()
                .build();

        final HttpClient httpClient = HttpClient.newBuilder()
                .version(HttpClient.Version.HTTP_2)
                .connectTimeout(Duration.ofSeconds(10))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        // Check response
        logger.debug("Search for fhir resources StatusCode:'{}'", response.statusCode());
        Assert.assertEquals(200, response.statusCode());
        logger.trace("Search for fhir resources Response:'{}'", response.body());
        Assert.assertNotNull(response.body());

        // Map response to Bundle
        IParser parser = this.fhirContext.newJsonParser();
        Bundle responseBundle = mapBundle(parser, response.body());
        Assert.assertNotNull(responseBundle);

        // Check Bundle
        logger.debug("Search for fhir resources Total:'{}'", responseBundle.getEntry().size());
        Assert.assertEquals(300, responseBundle.getEntry().size());
        logger.trace("Search for fhir resources Response:'{}'", responseBundle.getEntry());
        Assert.assertNotNull(responseBundle.getEntry());

        //Get HealthcareService
        List<HealthcareService> healthcareServiceList = extractHealthcareServices(responseBundle);

        // Check HealthcareService
        Assert.assertNotNull(healthcareServiceList);
        Assert.assertFalse(healthcareServiceList.isEmpty());
        Assert.assertEquals(100, healthcareServiceList.size());
    }

    /**
     * Tests the search functionality using the FHIR client (Alternative to HttpClient).
     */
    @Test
    public void testSearchViaFhirClient() {

        // Create FHIR Client and execute query
        IGenericClient client = createFhirClient(fhirContext);

        BearerTokenAuthInterceptor authInterceptor = new BearerTokenAuthInterceptor(TEST_ACCESS_TOKEN);
        client.registerInterceptor(authInterceptor);

        Bundle responseBundle = client.search().forResource(HealthcareService.class)
                .where(HealthcareService.ORGANIZATION.hasChainedProperty(Organization.ACTIVE.exactly().code("true")))
                //.where(HealthcareService.ORGANIZATION.hasChainedProperty(Organization.IDENTIFIER.exactly().systemAndIdentifier("https://gematik.de/fhir/sid/telematik-id", "3-17.2.1194001000.16.123"))) //TODO uncomment to search for telematikId
                .include(HealthcareService.INCLUDE_ORGANIZATION)
                .include(HealthcareService.INCLUDE_LOCATION)
                .count(100)
                .returnBundle(Bundle.class).execute();

        // Check Bundle
        logger.debug("Search for fhir resources Total:'{}'", responseBundle.getEntry().size());
        Assert.assertEquals(300, responseBundle.getEntry().size());
        logger.trace("Search for fhir resources Response:'{}'", responseBundle.getEntry());
        Assert.assertNotNull(responseBundle.getEntry());

        //Get HealthcareService
        List<HealthcareService> healthcareServiceList = extractHealthcareServices(responseBundle);

        // Check HealthcareService
        Assert.assertNotNull(healthcareServiceList);
        Assert.assertFalse(healthcareServiceList.isEmpty());
        Assert.assertEquals(100, healthcareServiceList.size());
    }

    /**
     * Extracts a list of HealthcareService resources from the given Bundle.
     * To extract PractitionerRole replace HealthcareService with PractitionerRole
     *
     * @param responseBundle the Bundle containing the resources.
     * @return a list of HealthcareService resources.
     */
    private List<HealthcareService> extractHealthcareServices(Bundle responseBundle) {
        return responseBundle.getEntry().stream()
                .map(Bundle.BundleEntryComponent::getResource)
                .filter(HealthcareService.class::isInstance)
                .map(HealthcareService.class::cast)
                .toList();
    }

    /**
     * Constructs the URL for searching all HealthcareService resources.
     *
     * @return the URL as a String for searching all HealthcareService resources.
     */
    private String getHealthcareServiceUrl() {
        return USED_SEARCH_URL + "HealthcareService?organization.active=true"
                // + "&_text=" + fulltext //TODO uncomment to use fulltext search
                // + addGeoSearchParameter(50.1503, 8.6168, 100, "km") //TODO uncomment to use geo search
                // + "&organization.identifier=" + "3-17.2.1194001000.16.123" //TODO uncomment to search for telematikId
                + "&_include=HealthcareService:organization"
                + "&_include=HealthcareService:location";

    }

    /**
     * Constructs the URL for searching all PractitionerRole resources.
     *
     * @return the URL as a String for searching all HealthcareService resources.
     */
    private String getPractitionerRoleUrl() {
        return USED_SEARCH_URL + "PractitionerRole?practitioner.active=true"
                // + "&_text=" + fulltext //TODO uncomment to use fulltext search
                // + addGeoSearchParameter(50.1503, 8.6168, 100, "km") //TODO uncomment to use geo search
                // + "&practitioner.identifier=" + "3-17.2.1194001000.16.123" //TODO uncomment to search for telematikId
                + "&_include=PractitionerRole:practitioner"
                + "&_include=PractitionerRole:location";
    }

    /**
     * Constructs the URL for searching all Endpoint resources.
     *
     * @return the URL as a String for searching all Endpoint resources.
     */
    private String getEndpointUrl() {
        return USED_SEARCH_URL + "Endpoint?status=active"
                // + "&address=" + "@1-2arvtst-ap000033:tim.test.gematik.de" //TODO uncomment to search for address
                // + "&name=" + "DummyName" //TODO uncomment to search for name
                ;
    }

    /**
     * Add geo-search to search url
     *
     * @param latitude  the latitude for the geo-search
     * @param longitude the longitude for the geo-search
     * @param distance  the distance for the geo-search (min. 50)
     * @param unit      the unit for the distance ("km")
     * @return the URL as a String with the geo-search parameters
     */
    private String addGeoSearchParameter(double latitude, double longitude, int distance, String unit) {
        String locationParam = latitude + "|" + longitude + "|" + distance + "|" + unit;
        String encodedLocationParam = URLEncoder.encode(locationParam, StandardCharsets.UTF_8);

        return "&location.near=" + encodedLocationParam;
    }

    /**
     * Maps the given JSON content to a FHIR Bundle.
     *
     * @param parser  the FHIR parser to use.
     * @param content the JSON content to parse.
     * @return the parsed Bundle, or an empty Bundle if the content is blank.
     */
    private Bundle mapBundle(final IParser parser, final String content) {

        if (StringUtils.isNotBlank(content)) {
            return parser.parseResource(Bundle.class, content);
        } else {
            return new Bundle();
        }
    }

    /**
     * Creates a new FHIR client using the given FhirContext.
     *
     * @param fhirContext the FhirContext to use for creating the client.
     * @return the created IGenericClient.
     */
    public IGenericClient createFhirClient(final FhirContext fhirContext) {

        //TODO Set SocketTimeout, ConnectTimeout, PoolMaxPerRoute, PoolMaxTotal if needed
        final IRestfulClientFactory cf = fhirContext.getRestfulClientFactory();

        return cf.newGenericClient(USED_SEARCH_URL);
    }

}
