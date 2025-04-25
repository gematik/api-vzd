Instance: PractitionerExample001
InstanceOf: PractitionerDirectoryStrict
Usage: #example
Description: "Example of a Practitioner as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* id = "TIPractitionerExample001"
* identifier[TelematikID].value = "1-1.58.00000040"
* identifier[LANR].value = "123456789"
* qualification[+].code = PractitionerProfessionOID#1.2.276.0.76.4.31
* name
  * prefix = "Dr."
  * given[+] = "Max"
  * given[+] = "Manfred"
  * family = "Musterman"
  * text = "Dr. Max Manfred Mustermann"
