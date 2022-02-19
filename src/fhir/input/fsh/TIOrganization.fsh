Profile: TIOrganization
Parent: Organization
Title: "Profile for an Organization resource in the TI"
Description: """Defines the data structure for medical, regulatory and technical 
organisations specific for german Healthcare and Telematics Infrastructure.
"""
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
* contact.telecom.extension contains X509CertificatePEM named certificate 0..* MS
