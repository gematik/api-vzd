Instance: PractitionerExample001
InstanceOf: PractitionerDirectory
Usage: #example
Description: "Example of a Practitioner as to be found in gematik FHIR Directory"
* active = true
* id = "TIPractitionerExample001"
* identifier[TelematikID].value = "1-1.58.00000040"
* identifier[LANR].value = "123456789"
* qualification[+].code = PractitionerProfessionOID#1.2.276.0.76.4.31
* qualification[+].code = $Facharzttitel#010 "FA Allgemeinmedizin"
* qualification[+].code = $Facharzttitel#523 "FA Innere Medizin und (SP) Gastroenterologie"
* name
  * prefix = "Dr."
  * given[+] = "Max"
  * given[+] = "Manfred"
  * family = "Musterman"
  * text = "Dr. Max Manfred Mustermann"
