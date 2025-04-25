Profile: PractitionerRoleDirectory
Parent: PractitionerRole
Title: "PractitionerRole in gematik Directory"
* insert Meta
* extension contains 
  HolderIdEx named holderId 0..* MS and
  OwnerTelematikIdEx named ownerTelematikId 0..* MS
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag obeys CodingSytemCodeInv
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id MS
* practitioner 1..1 MS
* location MS
* endpoint MS
* healthcareService MS
* organization MS
* telecom MS
  * system MS
  * value MS
  * use MS

Profile: PractitionerRoleDirectoryStrict
Parent: PractitionerRoleDirectory
Id: PractitionerRoleDirectoryStrict
Title: "PractitionerRoleDirectoryStrict"
Description: "PractitionerRole in gematik Directory with strict constraints"
* insert Meta
* meta.tag only CodingWithCodeAndSystem
* meta.tag
  * ^slicing.rules = #closed
* identifier 0..0
* active 0..0
* period 0..0
* code 0..0
* specialty 0..0
* availableTime 0..0
* notAvailable 0..0
* availabilityExceptions 0..0