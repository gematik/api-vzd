Profile: OrganizationDirectory
Parent: Organization
Title: "Organization in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical 
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* extension contains 
    OrganizationVisibility named organizationVisibility 0..* MS and
    NCPeHCountryEx named ncpehCountryEx 0..1 MS
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id MS
* active MS
* name 1..1 MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains TelematikID 1..1 MS
* identifier[TelematikID] only $IdentifierTelematikID
* identifier contains BSNR 0..1 MS
* identifier[BSNR] only $IdentifierBSNR
* identifier contains KZVA 0..1 MS
* identifier[KZVA] only $IdentifierKZVA
* identifier contains IKNR 0..1 MS
* identifier[IKNR] only $IdentifierIKNR
* type 1..* MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* type contains providerType 0..*  MS and profession 0..* MS
* type[providerType] from OrganizationTypeVS
* type[profession] from OrganizationProfessionOIDTypeVS
* name 1..1 MS
* alias MS
* contact MS
* address MS
  * use MS
  * text MS
  * line MS
  * city MS
  * state MS
  * postalCode MS
  * country MS
* partOf MS

Extension: NCPeHCountryEx
Id: ncpeh-country-ex
Title: "National Contact Point of Health (NCPeH) Country Extension"
Description: "The country extension for  National Contact Point of Health (NCPeH) Organizations, representing the country in which the NCPeH is located." 
Context: Organization
* value[x] 1.. MS
* value[x] only CodeableConcept
* valueCodeableConcept 1.. MS
* valueCodeableConcept from Iso3166-1-2
  * coding ..1 MS
    * system 1.. MS
    * code 1.. MS
