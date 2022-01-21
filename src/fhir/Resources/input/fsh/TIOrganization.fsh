Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* ^url = "https://gematik.de/fhir/directory/StructureDefinition/TIOrganization"
* ^status = #draft
* id 1.. MS
* active 1.. MS
* name 1.. MS
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

Instance: TIOrganizationExample001
InstanceOf: TIOrganization
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* id = "TIOrganizationExample001"
* active = true
* identifier[+].system = "http://fhir.de/StructureDefinition/identifier-telematik-id"
* identifier[=].value = "9-2.58.00000040"
* name = "gematik GmbH"
