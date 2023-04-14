Profile: PractitionerRoleDirectory
Parent: PractitionerRole
Title: "PractitionerRole in gematik Directory"
* insert Meta
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag contains OriginSlice 1..1 MS
* meta.tag[OriginSlice] from OriginVS 
* id MS
/* neue IDs in Meta: holder_id, owner_id, damit die telematikIDs nicht in allen Ressourcen gepflegt werden müssen
Eigene Codesysteme für die IDs um sie unterscheiden zu können
*/
* practitioner 1..1 MS
* location MS
* endpoint MS
