Profile: OrganizationDirectory
Parent: TIOrganization
Title: "Organization in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical 
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* extension contains 
    OrganizationVisibility named organizationVisibility 0..* MS
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag obeys CodingSytemCodeInv
* meta.tag contains Origin 1..1 MS and FdV 0..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = Canonical(Origin)
* meta.tag[FdV].system = Canonical(ResourceTag)
* meta.tag[FdV].code = #fdv-relevant
* meta.tag[FdV].display = "Relevant for ePA FdV"
* identifier 1..
* identifier[TelematikID] 1..

Profile: OrganizationDirectoryStrict
Parent: OrganizationDirectory
Id: OrganizationDirectoryStrict
Title: "OrganizationDirectoryStrict"
Description: "Organization in gematik Directory with strict constraints"
* insert Meta
* meta.tag only CodingWithCodeAndSystem
* meta.tag
  * ^slicing.rules = #closed
* extension[organizationVisibility].valueCoding only CodingWithCodeAndSystem
* extension[ncpehCountryEx].valueCoding only CodingWithCodeAndSystem
* identifier 
  ^slicing.rules = #closed
* type 
  ^slicing.rules = #closed
* telecom 0..0
* endpoint 0..0