Profile: PractitionerRoleDirectory
Parent: PractitionerRole
Description: "Profile for the PractitionerRole in gematik FHIR Directory"
* insert Meta
* id MS
/* neue IDs in Meta: holder_id, owner_id, damit die telematikIDs nicht in allen Ressourcen gepflegt werden müssen
Eigene Codesysteme für die IDs um sie unterscheiden zu können
*/
* practitioner 1..1 MS
* location MS
* endpoint MS