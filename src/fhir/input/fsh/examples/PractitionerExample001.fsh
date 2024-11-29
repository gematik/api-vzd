Instance: PractitionerExample001
InstanceOf: PractitionerDirectory
Usage: #example
Description: "Example of a Practitioner as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* active = true
* id = "TIPractitionerExample001"
* identifier[TelematikID].value = "1-1.58.00000040"
* identifier[LANR].value = "123456789"
* qualification[+].code = PractitionerProfessionOID#1.2.276.0.76.4.31
* qualification[+].code = KBV_CS_SFHIR_BAR2_WBO_OID_URL#010 "FA Allgemeinmedizin"
* qualification[+].code = KBV_CS_SFHIR_BAR2_WBO_OID_URL#523 "FA Innere Medizin und (SP) Gastroenterologie"
* name
  * prefix = "Dr."
  * given[+] = "Max"
  * given[+] = "Manfred"
  * family = "Musterman"
  * text = "Dr. Max Manfred Mustermann"
