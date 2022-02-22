Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* insert Meta
* id 0..1 MS
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
* type 1..* MS
* type from TIOrganizationTypeVS
* address MS
* partOf MS
* alias MS
* contact MS
* contact.purpose from $ContactEntityTypeVS
