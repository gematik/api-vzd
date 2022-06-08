Instance: LocationExample
InstanceOf: LocationDirectory
Usage: #example
Description: "Example of a Location as to be found in gematik FHIR Directory"
* status = "active"
* name[+] = "Praxis am Rathaus"
* description[+] = "Praxis für Allgemeinmedizin"
* address.text = "Hauptstraße 1, 10117 Berlin"
* address.line = "Hauptstraße 1"
* address.city = "Berlin"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"
* hoursOfOperation.daysOfWeek[+] = "mon"
* hoursOfOperation.daysOfWeek[+] = "tue"
* hoursOfOperation.daysOfWeek[+] = "wed"
* hoursOfOperation.daysOfWeek[+] = "thu"
* hoursOfOperation.daysOfWeek[+] = "fri"
* hoursOfOperation.openingTime = "08:00:00"
* hoursOfOperation.openingTime = "18:00:00"
* availabilityExceptions = "An Feiertagen geschlossen"

