Profile: PractitionerRole-FhirDirectory
Parent: PractitionerRole
Description: "Profile for the PractitionerRole in gematik FHIR Directory"
* insert Meta
* id MS
/* neue Meta IDs: holder_id, owner_id, damit die telematikIDs nicht in allen Ressourcen gepflegt werden müssen
Eigene Codesysteme für die IDs um sie von telematikID und LANR unterscheiden zu können
*/
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
* active 1..1 MS
* practitioner 1..1 MS
* speciality MS
* location MS
* endpoint MS