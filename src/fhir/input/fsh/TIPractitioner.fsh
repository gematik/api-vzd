Profile: TIPractitioner
Parent: Practitioner
Description: "Profile for the Practitioner in gematik FHIR Directory"
* ^status = #draft
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
* qualification.code MS
* qualification.code from TIPractitionerQualificationVS

Instance: TIPractitionerExample001
InstanceOf: TIPractitioner
Usage: #example
Description: "Example of a Practitioner as to be found in gematik FHIR Directory"
* id = "TIPractitionerExample001"
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "3-2.58.00000040"
* qualification[+].code = TIPractitionerProfessionOidCS#1.2.276.0.76.4.31
* qualification[+].code = $Facharzttitel#010 "FA Allgemeinmedizin"
* qualification[+].code = $Facharzttitel#523	"FA Innere Medizin und (SP) Gastroenterologie"