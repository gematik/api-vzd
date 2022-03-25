Profile: Endpoint-FhirDirectory
Parent: Endpoint
Description: "Endpoints for applications in the TI FHIR-Directory"
* insert Meta
//* extension contains X509CertificatePEM named certificate 0..* MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains TelematikID 1..1 MS
* identifier[TelematikID] only $IdentifierTelematikID
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1..1 MS
  * system 1..1 MS
  * value 1..1 MS
* status 0..* MS
* connectionType 1..1 MS
* name 0..1 MS
* managingOrganization 0..* MS
* payloadType 1..* MS
* address 1..1 MS