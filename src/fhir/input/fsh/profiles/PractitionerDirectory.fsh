Profile: PractitionerDirectory
Parent: Practitioner
Title: "Practitioner in gematik Directory"
* insert Meta
* id MS
* identifier 1..* MS
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* identifier contains TelematikID 1.. MS
* identifier[TelematikID] only $IdentifierTelematikID
* identifier contains LANR 0.. MS
* identifier[LANR] only $IdentifierLANR
* identifier contains ZANR 0.. MS
* identifier[ZANR] only $IdentifierZANR
* name 1..1 MS
  * text 1..1 MS
  * family 1..1 MS
  * given 1..* MS
  * prefix MS
  * suffix MS
* telecom MS
  * system MS
  * value MS
  * use MS
* gender MS
* birthDate MS
* photo MS
* qualification MS
* qualification.code from PractitionerQualificationVS
* communication MS
