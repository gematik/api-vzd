Profile: LocationDirectory
Parent: Location
Title: "Location in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag obeys CodingSytemCodeInv
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id MS
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
* partOf MS
* managingOrganization MS

Profile: LocationDirectoryStrict
Parent: LocationDirectory
Id: LocationDirectoryStrict
Title: "LocationDirectoryStrict"
Description: "Location in gematik Directory with strict constraints"
* meta.tag
  * ^slicing.rules = #closed
* identifier 0..0
* status 0..0
* operationalStatus 0..0
* alias 0..0
* mode 0..0
* type 0..0
* telecom 0..0
* physicalType 0..0
* hoursOfOperation 0..0
* availabilityExceptions 0..0
* endpoint 0..0