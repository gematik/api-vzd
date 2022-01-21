Profile: TIPractitioner
Parent: Practitioner
Description: "Profile for the Practitioner in gematik FHIR Directory"
* ^url = "https://gematik.de/fhir/directory/StructureDefinition/TIPractitioner"
* ^status = #draft
* id MS
* identifier 1..* MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* identifier contains
  Versichertennummer-GKV 0..1 MS
* identifier[Versichertennummer-GKV] only IdentifierKvid10
  * ^patternIdentifier.type = $identifier-type-de-basis#GKV
  * type 1.. MS
  * system MS
  * value MS
  
Instance: TIPractitionerExample001
InstanceOf: TIPractitioner
Usage: #example
Description: "Example of a Practitioner as to be found in gematik FHIR Directory"
* identifier[0].type = $identifier-type-de-basis#GKV
* identifier[=].system = "http://fhir.de/sid/gkv/kvid-10"
* identifier[=].value = "A123456789"