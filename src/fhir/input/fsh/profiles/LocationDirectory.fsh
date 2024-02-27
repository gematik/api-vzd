Profile: LocationDirectory
Parent: Location
Title: "Location in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id 0..1 MS
* name MS
* description MS
* address MS
* address only AddressDeBasis
  * use MS
  * text MS
  * line MS
  * city MS
  * state MS
// FIXME: widerspricht dt. Basisprofilen  * state from AddressStateVS (extensible)
  * postalCode MS
  * country MS
* position MS
  * longitude MS
  * latitude MS
  * altitude MS
* partOf MS
* hoursOfOperation MS
  * daysOfWeek MS
  * allDay MS
  * openingTime MS
  * closingTime MS
* availabilityExceptions MS
* managingOrganization MS