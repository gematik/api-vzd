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
* identifier[TelematikID] ^patternIdentifier.system = $IdentifierTelematikID
* identifier[TelematikID] ^patternIdentifier.type = $sct#63161005 // primary
* identifier contains AlternativeTelematikID 0..* MS
* identifier[AlternativeTelematikID] ^patternIdentifier.system = $IdentifierTelematikID
* identifier[AlternativeTelematikID] ^patternIdentifier.type = $sct#2603003 //secondary
* identifier contains KZVA 0..1 MS
* identifier[KZVA] ^patternIdentifier.system = $IdentifierKZVA
* identifier contains IKNR 0..1 MS
* identifier[IKNR] ^patternIdentifier.system = $IdentifierIKNR
* identifier contains BSNR 0..1 MS
* identifier[BSNR] ^patternIdentifier.system = $IdentifierBSNR
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