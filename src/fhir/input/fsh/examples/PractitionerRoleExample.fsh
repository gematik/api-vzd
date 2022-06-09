Instance: PractitionerRoleExample
InstanceOf: PractitionerRoleDirectory
Usage: #example
Description: "Example of an PractitionerRole as to be found in gematik FHIR Directory"
* practitioner = Reference(PractitionerExampleDentist)
* location[+] = Reference(LocationExample)
* endpoint[+] = Reference(EndpointExample)

