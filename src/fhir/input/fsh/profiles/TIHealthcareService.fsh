Profile: TIHealthcareService
Parent: HealthcareService
Title: "Profile for an HealthcareService resource in the TI"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* id 0..1 MS
* name 0..1 MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains HolderID 1.. MS
* identifier[HolderID] only $IdentifierHolderID
  * type 1..1 MS
  * system 1..1 MS
  * value 1..* MS
* identifier contains OwnerID 1.. MS
* identifier[OwnerID] only $IdentifierOwnerID
  * type 1..1 MS
  * system 1..1 MS
  * value 1..* MS
* status MS
* name MS
* description MS
* telecom MS
* address MS
* position MS
* hoursOfOperation MS
* availabilityExceptions MS
