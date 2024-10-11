Instance: PharmacyOrganizationExample
InstanceOf: OrganizationDirectory
Usage: #example
Title: "PharmacyOrganizationExample"
Description: "PharmacyOrganizationExample"
* meta.tag[Origin] = Origin#ldap
* identifier[TelematikID].value = "3-07.2.1444560000.16.108"
* type = OrganizationProfessionOID#1.2.276.0.76.4.54 "Öffentliche Apotheke"
* name = "Rathausapotheke"
* active = true
* alias = "Rathausapotheke"
* contact.telecom[+].system = $ContactPointSystem#phone "Phone"
* contact.telecom[=].value = "030 1234567"
* address.use = #work
* address.type = #postal
* address.text = "Theodor-Stern-Kai 7, 60596 Frankfurt am Main, Hessen, DE"
* address.line = "Theodor-Stern-Kai 7"
* address.city = "Frankfurt am Main"
* address.state = "Hessen"
* address.postalCode = "60596"
* address.country = "DE"

Instance: PharmacyHealthCareServiceExample
InstanceOf: HealthcareServiceDirectory
Usage: #example
Title: "PharmacyHealthCareServiceExample"
Description: "PharmacyHealthCareServiceExample"
* meta.tag[Origin] = Origin#ldap
* providedBy = Reference(PharmacyOrganizationExample)
* identifier[TelematikID].value = "3-07.2.1444560000.16.108"
* category = PatientBezogenenGesundheitsversorgung#APO "Apotheke"
* type = PharmacyTypeCS#offizin-apotheke "Offizin-Apotheke"
* specialty[+] = PharmacyHealthcareSpecialtyCS#10 "Handverkauf"
* specialty[+] = HealthcareServiceSpecialtyCS#allergietest "Allergietest"
* location[+] = Reference(PharmacyLocationExample)
* name = "Rathausapotheke"
* telecom[+].system = $ContactPointSystem#phone "Phone"
* telecom[=].value = "030 1234567"
* telecom[=].use = $ContactPointUse#work "Work"
* communication[+] = $CommonLanguages#de "German"
* communication[+] = $CommonLanguages#en "English"
* appointmentRequired = false 
* availableTime[+]
  * daysOfWeek[+] = $DaysOfWeek#mon "Monday"
  * daysOfWeek[+] = $DaysOfWeek#tue "Tuesday"
  * daysOfWeek[+] = $DaysOfWeek#tue "Tuesday"
  * daysOfWeek[+] = $DaysOfWeek#wed "Wednesday"
  * daysOfWeek[+] = $DaysOfWeek#thu "Thursday"
  * daysOfWeek[+] = $DaysOfWeek#fri "Friday"
  * availableStartTime = "08:00:00"
  * availableEndTime = "18:00:00"
* availableTime[+]
  * extension[specialOpeningTimes]
    * extension[period]
      * valuePeriod
        * start = "2024-07-20T08:30:00+02:00"
        * end = "2024-07-21T08:30:00+02:00"
    * extension[qualifier]
      * valueCoding = OpeningTimeQualifierCS#notdienst "Notdienst"
* notAvailable
  * description = "Urlaub"
  * during 
    * start = "2024-09-01"
    * end = "2024-09-21"
* availabilityExceptions = "An Feiertagen geschlossen"
* endpoint[+] = Reference(EndpointExample)
* characteristic[technicalCharacteristic][+] = VZDHealthCareServiceCharacteristicsCS#erx-token-receiver "eRX Token Receiver"
* characteristic[technicalCharacteristic][+] = VZDHealthCareServiceCharacteristicsCS#apotheke-verfuegbarkeitsanfrage "Apotheke: Verfügbarkeitsanfrage"
* characteristic[technicalCharacteristic][+] = VZDHealthCareServiceCharacteristicsCS#terminbuchung "Terminbuchung"
* characteristic[physicalFeatures][+] = PhysicalFeaturesHealthCareServiceCS#parkmoeglichkeit "Parkmöglichkeit"
  * extension[additionalNote].valueString = "Vor dem Haus"
* characteristic[physicalFeatures][+] = PhysicalFeaturesHealthCareServiceCS#oepnv "ÖPNV in der Nähe"
* coverageArea
  * extension[serviceCoverageArea]
    * valueQuantity.value = 10000
  * extension[serviceCoveragePostalCode][+]
    * valueString = "60596"
  * extension[serviceCoveragePostalCode][+]
    * valueString = "60597"
  * extension[serviceCoveragePostalCode][+]
    * valueString = "60598"

Instance: PharmacyLocationExample
InstanceOf: LocationDirectory
Usage: #example
Description: "Example of a Pharmacy Location as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* name = "Rathausapotheke"
* address.use = #work
* address.type = #postal
* address.text = "Theodor-Stern-Kai 7, 60596 Frankfurt am Main, Hessen, DE"
* address.line = "Theodor-Stern-Kai 7"
* address.city = "Frankfurt am Main"
* address.state = "Hessen"
* address.postalCode = "60596"
* address.country = "DE"
* availabilityExceptions = "An Feiertagen geschlossen"
* managingOrganization = Reference(OrganizationExample001)
* position.longitude = 8.6648
* position.latitude = 50.097

Instance: PharmacyEndpointTIMExample
InstanceOf: EndpointDirectory
Usage: #example
Description: "Example of a Pharamacy TIM Endpoint"
* meta.tag[Origin] = Origin#ldap
* status = #active "Active"
* connectionType = EndpointDirectoryConnectionType#tim "TI-Messenger Endpoint"
* name = "Messenger"
* managingOrganization = Reference(PharmacyOrganizationExample)
* payloadType = EndpointDirectoryPayloadType#tim-chat "TI-Messenger chat"
* address = "matrix:u/74c1fecc710ce4c8a8bbe310fbc5954c2a5e1e9ef5f70d651da1bfc4c9abe43f:example-domain.de"

Instance: PharmacyEndpointErpReservationExample
InstanceOf: EndpointDirectory
Usage: #example
Description: "Example of a Pharamacy eRP Endpoint"
* meta.tag[Origin] = Origin#ldap
* status = #active "Active"
* connectionType = EndpointDirectoryConnectionType#eRP-onPremise "Reservierung"
* name = "ERP Reservierung"
* managingOrganization = Reference(PharmacyOrganizationExample)
* address = "https://be-305314293.adv-erezept.de/gematik/onPremise/<ti_id>/<transactionID>"
* payloadType = DataAbsentReason#not-applicable

Instance: PharmacyEndpointOnlineAppointmentBookingExample
InstanceOf: EndpointDirectory
Usage: #example
Description: "Example of a Pharamacy online appointment booking Endpoint"
* meta.tag[Origin] = Origin#ldap
* status = #active "Active"
* connectionType = EndpointDirectoryConnectionType#terminbuchung-online "Online Terminbuchung"
* name = "Online Terminbuchung"
* managingOrganization = Reference(PharmacyOrganizationExample)
* address = "https://rathausapotheke.de/terminbuchung"
* payloadType = DataAbsentReason#not-applicable