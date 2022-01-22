Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* insert Meta
* ^url = "https://gematik.de/fhir/directory/StructureDefinition/TIOrganization"
* id 1..1 MS
* active 1..1 MS
* name 1..1 MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains TelematikID 1..1 MS
* identifier[TelematikID] only $IdentifierTelematikID
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1..1 MS
  * system 1..1 MS
  * value 1..1 MS
* type from TIOrganizationTypeVS (required)
* alias 1..1 MS
* address MS
* partOf 0..1 MS
* contact MS

Instance: TIOrganizationExample001
InstanceOf: TIOrganization
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "9-2.58.00000040"
* type = TIPractitionerProfessionOidCS#urn:oid:1.2.276.0.76.4.30
* name = "gematik GmbH"
* active = true
* alias = "gematik"
* address.text = "gematik GmbH, Friedrichstr. 136, 10117 Berlin"
* address.line = "Friedrichstr. 136"
* address.city = "Berlin"
* address.district = "Mitte"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"
/*
* partOf = "280345"
* contact.purpose = "ITSM-RFC"
* contact.name = "gematik ITSM"
* contact.telecom.system = "url"
* contact.telecom.value = "matrix:u/gematik-itsm:gematik.de"
*/
