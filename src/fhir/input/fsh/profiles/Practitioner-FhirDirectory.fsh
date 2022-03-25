Profile: Practitioner-FhirDirectory
Parent: Practitioner
Description: "Profile for the Practitioner in gematik FHIR Directory"
* insert Meta
* id MS
* identifier 1..* MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* identifier contains TelematikID 1.. MS
* identifier[TelematikID] only $IdentifierTelematikID
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1.. MS
  * system 1.. MS
  * value 1.. MS
* name 1..* MS
* telecom 0..* MS
* gender 0..* MS
* birthDate 0..* MS
* photo 0..* MS
* qualification 0..* MS
//* qualification.code MS
//* qualification.code from TIPractitionerQualificationVS
* communication 0..* MS