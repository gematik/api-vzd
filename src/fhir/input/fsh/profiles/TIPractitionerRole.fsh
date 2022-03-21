Profile: TIPractitionerRole
Parent: PractitionerRole
Description: "Profile for the PractitionerRole in gematik FHIR Directory"
* insert Meta
* id MS
/* // Vorschlag Oliver: neue Meta IDs: holder_id, owner_id, damit
die telematikIDs nicht in allen Ressourcen gepflegt werden müssen
Eigene Codesysteme für die IDs um sie von telematikID und LANR unterscheiden zu können
*/
* identifier 1..* MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
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

* 





 # {field} active (1..1, MS, LDAP) //reicht active hier oder\n    auch in practitioner und endpoint?
 # {field} practitioner (1..1, MS, LDAP)
 # {field} speciality (0..*, MS)
 # {field} location (0..*, MS)
 # {field} endpoint (0..*, MS)
