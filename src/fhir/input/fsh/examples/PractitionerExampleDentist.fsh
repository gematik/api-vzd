Instance: PractitionerExampleDentist
InstanceOf: PractitionerDirectory
Usage: #example
Description: "Example of a Practitioner (Dentist) as to be found in gematik FHIR Directory"
* id = "TIPractitionerExampleDentist"
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "2-2.58.00000040"
* qualification[+].code.coding.system=https://gematik.de/fhir/directory/CodeSystem/PractitionerProfessionOID
* qualification[=].code.coding.code = PractitionerProfessionOID#1.2.276.0.76.4.31
* qualification[=].code.coding.display = $Facharzttitel#"Zahnärztin/Zahnarzt"
* name
  * prefix = "Dr."
  * given[+] = "Max"
  * given[+] = "Manfred"
  * family = "Musterman"
  * text = "Dr. Max Manfred Mustermann"
  


 
  
