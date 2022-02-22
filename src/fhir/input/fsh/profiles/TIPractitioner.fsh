Profile: TIPractitioner
Parent: Practitioner
Description: "Profile for the Practitioner in gematik FHIR Directory"
* ^status = #draft
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
* qualification.code MS
* qualification.code from TIPractitionerQualificationVS
