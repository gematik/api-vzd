Instance: OrganizationExample
InstanceOf: OrganizationDirectory
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "2-2.58.00000040"
* type = TIInstitutionTypeOidCS#1.2.276.0.76.4.51
* name = "Zahnarztpraxis Dr. Mustermann"
* active = true
* alias = "Zahnarztpraxis am Bahnhof"
* address.text = "Zahnarztpraxis Dr. Mustermann, Friedrichstr. 136, 10117 Berlin"
* address.line = "Friedrichstr. 136"
* address.city = "Berlin"
* address.district = "Mitte"
* address.state = BundeslaenderCS#Berlin
* address.postalCode = "10117"
* address.country = "DE"
* contact.purpose = $ContactEntityTypeCS#Patient
* contact.name.text = "Patientenkontakt"
* contact.telecom[+].system = $ContactPointSystemCS#email
* contact.telecom[=].value = "info@dr.mustermann.de"


