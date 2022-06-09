Instance: HealthcareServiceExample
InstanceOf: HealthcareServiceDirectory
Usage: #example
Description: "Example of an HealthcareService as to be found in gematik FHIR Directory"
* providedBy = Reference(OrganizationExample)
* speciality = $practiceSettingCode#MZKH
* location[+] = Reference(LocationExample)
* name = "Zahnmedizin"
* telecom[+].system = "phone"
* telecom[=].value = "0301234567"
* telecom[=].use = "work"
* serviceProvisionCode = $ServiceProvisionConditions#free
* communication[+] = $languages#de
* communication[+] = $languages#en
* appointmentRequired = true 
* availableTime.daysOfWeek[+] = "mon"
* availableTime.daysOfWeek[+] = "tue"
* availableTime.daysOfWeek[+] = "wed"
* availableTime.daysOfWeek[+] = "thu"
* availableTime.daysOfWeek[+] = "fri"
* availableTime.availableStartTime = "08:00:00"
* availableTime.availableEndTime = "18:00:00"
* availabilityExceptions = "An Feiertagen geschlossen"
* endpoint[+] = Reference(EndpointExample)



