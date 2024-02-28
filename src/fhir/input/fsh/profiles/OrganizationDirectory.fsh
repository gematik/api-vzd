Profile: OrganizationDirectory
Parent: Organization
Title: "Organization in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical 
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* extension contains OrganizationVisibility named organizationVisibility 0..* MS
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id 0..1 MS
* name 1..1 MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains TelematikID 1..1 MS
* identifier[TelematikID] only $IdentifierTelematikID
* identifier[TelematikID] ^patternIdentifier.system = $SidTelematikID
* identifier[TelematikID] ^patternIdentifier.use = #usual
* identifier contains AlternativeTelematikID 0..* MS
* identifier[AlternativeTelematikID] only $IdentifierTelematikID
* identifier[AlternativeTelematikID] ^patternIdentifier.system = $SidTelematikID
* identifier[AlternativeTelematikID] ^patternIdentifier.use = #secondary
* identifier contains KZVA 0..1 MS
* identifier[KZVA] only IdentifierKzva
* identifier[KZVA] ^patternIdentifier.system = $SidKZVA
* identifier contains IKNR 0..1 MS
* identifier[IKNR] only IdentifierIknr
* identifier[IKNR] ^patternIdentifier.system = $SidIKNR
* identifier contains BSNR 0..1 MS
* identifier[BSNR] only IdentifierBsnr
* identifier[BSNR] ^patternIdentifier.system = $SidBSNR
* type 1..* MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* type contains providerType 0..*  MS and profession 0..* MS
* type[providerType] from OrganizationProviderTypeVS
* type[profession] from OrganizationProfessionOIDTypeVS
* name 1..1 MS
* alias MS
* contact MS
* address MS
* address only AddressDeBasis
  * use MS
  * text MS
  * line MS
  * city MS
  * state MS
  * postalCode MS
  * country MS
* partOf MS