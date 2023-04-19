Profile: PractitionerRoleDirectory
Parent: PractitionerRole
Title: "PractitionerRole in gematik Directory"
* insert Meta
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id MS
* practitioner 1..1 MS
* location MS
* endpoint MS
