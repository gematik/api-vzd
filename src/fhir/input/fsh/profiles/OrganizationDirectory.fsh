Profile: OrganizationDirectory
Parent: Organization
Title: "Organization in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical 
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* id 0..1 MS
* name 1..1 MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains TelematikID 1..1 MS
* identifier[TelematikID] only $IdentifierTelematikID
* identifier contains BSNR 0..1 MS
* identifier[BSNR] only $IdentifierTelematikID
* type 1..1 MS
* type from OrganizationType
* name 1..1 MS
* alias MS
* contact MS
* contact.purpose from $ContactEntityTypeVS
