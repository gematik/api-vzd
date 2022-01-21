Profile: TIPractitioner
Parent: Practitioner
Description: "Profile for the Practitioner in gematik FHIR Directory"
* ^url = "https://gematik.de/fhir/directory/StructureDefinition/TIPractitioner"
* ^status = #draft
* id MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains SliceTelematikID 1..1 MS
* identifier[SliceTelematikID] only IdentifierTelematikId
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1.. MS
  * system MS
  * value MS

Instance: TIPractitionerExample001
InstanceOf: TIPractitioner
Usage: #example
Description: "Example of a Practitioner as to be found in gematik FHIR Directory"
* identifier[0].type = $v2-0203#PRN
* identifier[=].system = "http://fhir.de/StructureDefinition/identifier-telematik-id"
* identifier[=].value = "3-123456789"
