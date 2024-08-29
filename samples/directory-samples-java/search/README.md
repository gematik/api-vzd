# VZD FHIR - Suchbeispiele

## Das Beispiel enthält:
- HealthcareService-Suche via HTTP-Client (analog zur bestehenden Owner-Authenticate-Implementierung)
- HealthcareService-Suche via HAPI FHIR Client
- Überprüfung des HTTP-Status-Codes und Auslesen des ResponseBody
- Mapping von FHIR-Ressourcen mit HAPI FHIR Mapper (inklusive Initialisierung eines FHIR-Kontexts)
- Extrahieren von definierten RessourceTypen (am Beispiel von HealthcareService)
- Die URL der VZD-FHIR-Außenschnittstellen RU, TU, PU
- Relative Pfade zu “search”, ”fdv/search”, ”owner”
- Das Einschließen von referenzierten Ressourcen (include Organization, include Location)
- URL-Beispiele für die Suche nach PractitionerRole und Endpoint
- Syntax für die Volltext-Suche
- Syntax für die Geo-Suche
- Syntax für die Suche nach einer TelematikId
- Syntax für die Suche nach Endpoint.name und Endpoint.address

## Ausführung
1. Access-Token in Variable “TEST_ACCESS_TOKEN" hinterlegen
2. Test für HTTP-Client oder alternativ für HAPI-FHIR-Client ausführen
   1. Bei Bedarf auskommentierte Zeilen einkommentieren
   2. Bei Bedarf getPractitionerRoleUrl und getEndpointUrl statt getHealthcareServiceUrl verwenden
   3. Bei Bedarf Staging über Variable USED_SEARCH_URL anpassen