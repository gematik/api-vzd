Profile: TIPractitioner
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
/* neue Meta IDs: holder_id, owner_id, damit die telematikIDs nicht in allen Ressourcen gepflegt werden müssen
Eigene Codesysteme für die IDs um sie von telematikID und LANR unterscheiden zu können
*/
* identifier contains HolderID 1.. MS
* identifier[HolderID] only $IdentifierHolderID
  * type 1..1 MS
  * system 1..1 MS
  * value 1..* MS
* identifier contains OwnerID 1.. MS
* identifier[OwnerID] only $IdentifierOwnerID
  * type 1..1 MS
  * system 1..1 MS
  * value 1..* MS
* qualification.code MS
* qualification.code from TIPractitionerQualificationVS
* name 1..* MS
* telecom 0..* MS
* gender 0..* MS
* birthDate 0..* MS
* photo 0..* MS
* communication 0..* MS