Instance: EndpointExample
InstanceOf: EndpointDirectory
Usage: #example
Description: "Example of a Endpoint as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#owner
* extension[endpointVisibility].valueCoding = EndpointVisibilityCS#hide-versicherte
* status = #active "Active"
* connectionType = EndpointDirectoryConnectionType#tim "TI-Messenger Endpoint"
* name = "Messenger"
* managingOrganization = Reference(OrganizationExample)
* payloadType = EndpointDirectoryPayloadType#tim-chat "TI-Messenger chat"
* address = "matrix:u/74c1fecc710ce4c8a8bbe310fbc5954c2a5e1e9ef5f70d651da1bfc4c9abe43f:example-domain.de"

Instance: PractitionerExampleDentist
InstanceOf: PractitionerDirectory
Usage: #example
Description: "Example of a Practitioner (Dentist) as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* id = "TIPractitionerExampleDentist"
* identifier[TelematikID].value = "2-2.58.00000040"
* qualification[+].code = PractitionerProfessionOID#1.2.276.0.76.4.31 "Zahnärztin/Zahnarzt"
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
* meta.tag[Origin] = Origin#ldap
* practitioner = Reference(PractitionerExampleDentist)
* location[+] = Reference(LocationExample)
* endpoint[+] = Reference(EndpointExample)


Instance: OrganizationExample
InstanceOf: OrganizationDirectory
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* identifier[TelematikID].value = "2-2.58.00000040"
* type = https://gematik.de/fhir/directory/CodeSystem/OrganizationProfessionOID#1.2.276.0.76.4.51 "Zahnarztpraxis"
* name = "Zahnarztpraxis Dr. Mustermann"
* active = true
* alias = "Zahnarztpraxis am Bahnhof"
* contact.name.text = "Empfang Zahnarztpraxis Dr. Mustermann"
* contact.telecom[+].system = $ContactPointSystem#phone "Phone"
* contact.telecom[=].value = "030 1234567"

Instance: LocationExample
InstanceOf: LocationDirectory
Usage: #example
Description: "Example of a Location as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* name[+] = "Praxis am Rathaus"
* description[+] = "Praxis für Allgemeinmedizin"
* address.text = "Hauptstraße 1, 10117 Berlin"
* address.line = "Hauptstraße 1"
* address.city = "Berlin"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"
* managingOrganization = Reference(OrganizationExample001)

Instance: HealthcareServiceExample
InstanceOf: HealthcareServiceDirectory
Usage: #example
Description: "Example of an HealthcareService as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* providedBy = Reference(OrganizationExample)
* identifier[TelematikID].value = "2-2.58.00000040"
* category = PatientBezogenenGesundheitsversorgung#PRA "Arztpraxis"
* type[+] = $AerztlicheFachrichtungen#MZKH "Zahnmedizin"
* type[+] = $AerztlicheFachrichtungen#ORAL "Oralchirurgie"
* specialty = ServiceType#92 "Paediatric Dentistry"
* location[+] = Reference(LocationExample)
* name = "Zahnmedizin"
* telecom[+].system = $ContactPointSystem#phone "Phone"
* telecom[=].value = "030 7654321"
* telecom[=].use = $ContactPointUse#work "Work"

* communication[+] = $CommonLanguages#de "German"
* communication[+] = $CommonLanguages#en "English"
* appointmentRequired = true 
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#mon "Monday"
  * availableStartTime = "08:00:00"
  * availableEndTime = "18:00:00"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#tue "Tuesday"
  * availableStartTime = "08:00:00"
  * availableEndTime = "18:00:00"
* availableTime[+] 
  * daysOfWeek = $DaysOfWeek#wed "Wednesday"
  * availableStartTime = "08:00:00"
  * availableEndTime = "18:00:00"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#thu "Thursday"
  * availableStartTime = "08:00:00"
  * availableEndTime = "18:00:00"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#fri "Friday"
  * availableStartTime = "08:00:00"
  * availableEndTime = "18:00:00"
* availableTime.availableStartTime = "08:00:00"
* availableTime.availableEndTime = "18:00:00"
* availabilityExceptions = "An Feiertagen geschlossen"
* endpoint[+] = Reference(EndpointExample)
* characteristic = VZDHealthCareServiceCharacteristicsCS#erx-token-receiver "eRX Token Receiver"
