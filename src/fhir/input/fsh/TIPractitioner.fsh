Profile: TIPractitioner
Parent: Practitioner
Description: "Profile for the Practitioner in gematik FHIR Directory"
* ^status = #draft
* id 1.. MS
* active 1.. MS
* identifier 1..* MS
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* identifier contains TelematikID 1.. MS
* identifier[TelematikID] only $IdentifierTelematikID
  * type 1.. MS
  * system 1.. MS
  * value 1.. MS

Instance: TIPractitionerExample001
InstanceOf: TIPractitioner
Usage: #example
Description: "Example of a Practitioner as to be found in gematik FHIR Directory"
* id = "TIPractitionerExample001"
* active = true
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "3-2.58.00000040"
