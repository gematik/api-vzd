Profile: PractitionerDirectory
Parent: Practitioner
Title: "Practitioner in gematik Directory"
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
* identifier contains LebenslangeArztNummer 0.. MS
* identifier[LebenslangeArztNummer] only $IdentifierLebenslangeArztNummer
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1.. MS
  * system 1.. MS
  * value 1.. MS
* identifier contains LebenslangeZahnarztNummer 0.. MS
* identifier[LebenslangeZahnarztNummer] only $IdentifierLebenslangeZahnarztNummer
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1.. MS
  * system 1.. MS
  * value 1.. MS
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
