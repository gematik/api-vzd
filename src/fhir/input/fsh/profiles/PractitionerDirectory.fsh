Profile: PractitionerDirectory
Parent: Practitioner
Title: "Practitioner in gematik Directory"
* insert Meta
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag obeys CodingSytemCodeInv
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id MS
* identifier 1..* MS
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* identifier contains TelematikID 1..1 MS
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
  * code MS
  * code from PractitionerQualificationVS
    * coding obeys CodingSytemCodeInv
* communication MS
  * coding obeys CodingSytemCodeInv

Profile: PractitionerDirectoryStrict
Parent: PractitionerDirectory
Id: PractitionerDirectoryStrict
Title: "PractitionerDirectoryStrict"
Description: "Practitioner in gematik Directory with strict constraints"
* meta.tag only CodingWithCodeAndSystem
* meta.tag
  * ^slicing.rules = #closed
* identifier 
  ^slicing.rules = #closed
* active 0..0
* address 0..0
* qualification 
  * code
    * coding only CodingWithCodeAndSystem
* communication
  * coding only CodingWithCodeAndSystem