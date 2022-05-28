Instance: PractitionerExample001
InstanceOf: PractitionerDirectory
Usage: #example
Description: "Example of a Practitioner as to be found in gematik FHIR Directory"
* id = "TIPractitionerExample001"
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "3-2.58.00000040"
* qualification[+].code = PractitionerProfessionOID#1.2.276.0.76.4.31
* qualification[+].code = $Facharzttitel#010 "FA Allgemeinmedizin"
* qualification[+].code = $Facharzttitel#523 "FA Innere Medizin und (SP) Gastroenterologie"
* name
  * prefix = "Dr."
  * given[+] = "Max"
  * given[+] = "Manfred"
  * family = "Musterman"
  * text = "Dr. Max Manfred Mustermann"
