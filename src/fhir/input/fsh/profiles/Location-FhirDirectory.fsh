Profile: Location-FhirDirectory
Parent: Location
Title: "Profile for an Location resource in the TI FHIR-Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* id 0..1 MS
* name 0..1 MS
* status MS
* name MS
* description MS
* telecom MS
/* @spilikin: habe die Detailierung für telecom ergänzt. Passt das so?
  * system 0..1 MS
  * value 0..1 MS
  * use 0..1 MS
*/
* address MS
* position MS
* hoursOfOperation MS
* availabilityExceptions MS
