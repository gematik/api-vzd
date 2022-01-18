Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* id MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains SliceTelematikID 1..1 MS
* identifier[SliceTelematikID] only IdentifierTelematikID
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1..

Instance: TIOrganizationExample001
InstanceOf: TIOrganization
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* identifier[0].type = $v2-0203#PRN
* identifier[=].system = "http://fhir.de/StructureDefinition/identifier-telematik-id"
* identifier[=].value = "1-123456789"
