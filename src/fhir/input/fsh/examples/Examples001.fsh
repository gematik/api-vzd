Instance: EndpointExample
InstanceOf: EndpointDirectory
Usage: #example
Description: "Example of a Endpoint as to be found in gematik FHIR Directory"
* status = $EndpointStatus#active "Active"
* connectionType = https://simplifier.net/vzd-fhir-directory/endpointconnectiontypevs#tim "TI-Messenger Endpoint"
* name = "Messenger"
* managingOrganization = Reference(OrganizationExample)
* payloadType = https://simplifier.net/vzd-fhir-directory/endpointpayloadtype#tim-chat "TI-Messenger chat"
* address = "matrix:u/74c1fecc710ce4c8a8bbe310fbc5954c2a5e1e9ef5f70d651da1bfc4c9abe43f:example-domain.de"

Instance: PractitionerExampleDentist
InstanceOf: PractitionerDirectory
Usage: #example
Description: "Example of a Practitioner (Dentist) as to be found in gematik FHIR Directory"
* id = "TIPractitionerExampleDentist"
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "2-2.58.00000040"
* qualification[+].code.coding.system = https://gematik.de/fhir/directory/CodeSystem/PractitionerProfessionOID
* qualification[=].code.coding.code = "1.2.276.0.76.4.31"
* qualification[=].code.coding.display = "Zahnärztin/Zahnarzt"
* name
  * prefix = "Dr."
  * given[+] = "Max"
  * given[+] = "Manfred"
  * family = "Musterman"
  * text = "Dr. Max Manfred Mustermann"

Instance: PractitionerRoleExample
InstanceOf: PractitionerRoleDirectory
Usage: #example
Description: "Example of an PractitionerRole as to be found in gematik FHIR Directory"
* practitioner = Reference(PractitionerExampleDentist)
* location[+] = Reference(LocationExample)
* endpoint[+] = Reference(EndpointExample)


Instance: OrganizationExample
InstanceOf: OrganizationDirectory
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "2-2.58.00000040"
* type = https://gematik.de/fhir/directory/CodeSystem/OrganizationProfessionOID#1.2.276.0.76.4.51 "Zahnarztpraxis"
* name = "Zahnarztpraxis Dr. Mustermann"
* active = true
* alias = "Zahnarztpraxis am Bahnhof"
* contact.purpose = $ContactEntityType#PATINF "Patient"
* contact.name.text = "Empfang Zahnarztpraxis Dr. Mustermann"
* contact.telecom[+].system = $ContactPointSystem#phone "Phone"
* contact.telecom[=].value = "030 1234567"

Instance: LocationExample
InstanceOf: LocationDirectory
Usage: #example
Description: "Example of a Location as to be found in gematik FHIR Directory"
* name[+] = "Praxis am Rathaus"
* description[+] = "Praxis für Allgemeinmedizin"
* address.text = "Hauptstraße 1, 10117 Berlin"
* address.line = "Hauptstraße 1"
* address.city = "Berlin"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"
* hoursOfOperation.daysOfWeek[+] = $DaysOfWeek#mon "Monday"
* hoursOfOperation.daysOfWeek[+] = $DaysOfWeek#tue "Tuesday"
* hoursOfOperation.daysOfWeek[+] = $DaysOfWeek#wed "Wednesday"
* hoursOfOperation.daysOfWeek[+] = $DaysOfWeek#thu "Thursday"
* hoursOfOperation.daysOfWeek[+] = $DaysOfWeek#fri "Friday"
* hoursOfOperation.openingTime = "08:00:00"
* hoursOfOperation.closingTime = "18:00:00"
* availabilityExceptions = "An Feiertagen geschlossen"

Instance: HealthcareServiceExample
InstanceOf: HealthcareServiceDirectory
Usage: #example
Description: "Example of an HealthcareService as to be found in gematik FHIR Directory"
* providedBy = Reference(OrganizationExample)
* speciality = $PracticeSettingCodeValueSet#408444009 "Dental-General dental practice"
* location[+] = Reference(LocationExample)
* name = "Zahnmedizin"
* telecom[+].system = $ContactPointSystem#phone "Phone"
* telecom[=].value = "030 7654321"
* telecom[=].use = $ContactPointUse#work "Work"
* serviceProvisionCode = $ServiceProvisionConditions#free "Free"
* communication[+] = $CommonLanguages#de "German"
* communication[+] = $CommonLanguages#en "English"
* appointmentRequired = true 
* availableTime.daysOfWeek[+] = $DaysOfWeek#mon "Monday"
* availableTime.daysOfWeek[+] = $DaysOfWeek#tue "Tuesday"
* availableTime.daysOfWeek[+] = $DaysOfWeek#wed "Wednesday"
* availableTime.daysOfWeek[+] = $DaysOfWeek#thu "Thursday"
* availableTime.daysOfWeek[+] = $DaysOfWeek#fri "Friday"
* availableTime.availableStartTime = "08:00:00"
* availableTime.availableEndTime = "18:00:00"
* availabilityExceptions = "An Feiertagen geschlossen"
* endpoint[+] = Reference(EndpointExample)

