Profile: EndpointDirectory
Parent: Endpoint
Description: "Endpoints for applications in the TI FHIR-Directory"
* insert Meta
* status MS
* connectionType 1..1 MS
/* @spilikin: habe die Detailierung für qualification ergänzt. Passt das so?
Nein, hier muss ValueSet verwendet werden
* connectionType from $ValueSetName
*/
  * system = "https://gematik.de/fhir/directory/CodeSystem/TIEndpointConnectionTypeCS" (exactly)
  * code 1..1 MS
  * display 1..1 MS
* name 1..1 MS  // identical to address; because search is possible in element name and not in element address
* managingOrganization 0..1 MS
* payloadType 1..* MS
/* @spilikin: habe die Detailierung für payloadType ergänzt. Passt das so?
*/
  * coding MS
    * system = "https://gematik.de/fhir/directory/CodeSystem/TIEndpointConnectionTypeCS" (exactly)
    * code 1..1 MS
    * display 1..1 MS

* address 1..1 MS