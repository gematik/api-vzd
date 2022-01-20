Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* ^url = "https://gematik.de/fhir/directory/StructureDefinition/TIOrganization"
* ^status = #draft
* id MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains SliceTelematikID 1..1 MS
* identifier[SliceTelematikID] only $IdentifierTelematikID
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1..

Instance: TIOrganizationExample001
InstanceOf: TIOrganization
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* identifier[0].type = $v2-0203#PRN
* identifier[=].system = $IdentifierTelematikID
* identifier[=].value = "9-2.58.00000040"
* name = "gematik GmbH"