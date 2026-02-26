Profile: PractitionerDirectory
Parent: TIPractitioner
Title: "Practitioner in gematik Directory"
* insert Meta
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag obeys CodingSytemCodeInv
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system =  Canonical(Origin)
* active MS
* identifier:TelematikID ..1
* name ..1 
* qualification 
  * code from TIPractitionerQualificationVS
    * coding obeys CodingSytemCodeInv
* communication MS
  * coding obeys CodingSytemCodeInv

Profile: PractitionerDirectoryStrict
Parent: PractitionerDirectory
Id: PractitionerDirectoryStrict
Title: "PractitionerDirectoryStrict"
Description: "Practitioner in gematik Directory with strict constraints"
* insert Meta
* meta.tag only CodingWithCodeAndSystem
* meta.tag
  * ^slicing.rules = #closed
* identifier 
  ^slicing.rules = #closed
* address 0..0
* telecom 0..0
* qualification 
  * code
    * coding only CodingWithCodeAndSystem
* communication
  * coding only CodingWithCodeAndSystem