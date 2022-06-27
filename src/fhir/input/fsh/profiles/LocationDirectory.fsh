Profile: LocationDirectory
Parent: Location
Title: "Location in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* id 0..1 MS
* name MS
* description MS
* address MS
  * use MS
  * text MS
  * line MS
  * city MS
  * district MS
  * state MS
  * state from AddressStateVS
  * postalCode MS
  * country MS
* position MS
  * longitude MS
  * latitude MS
  * altitude MS
* hoursOfOperation MS
  * daysOfWeek MS
  * allDay MS
  * openingTime MS
  * closingTime MS
* availabilityExceptions MS
