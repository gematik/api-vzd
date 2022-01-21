Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* ^url = "https://gematik.de/fhir/directory/StructureDefinition/TIOrganization"
* ^status = #draft
* id MS
* active MS
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

Instance: TIOrganizationExample001
InstanceOf: TIOrganization
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* identifier[+].system = "http://fhir.de/StructureDefinition/identifier-telematik-id"
* identifier[=].value = "9-2.58.00000040"
* name = "gematik GmbH"
* active = true
