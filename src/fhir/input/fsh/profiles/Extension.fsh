Extension: ServiceCoverageArea
Id: ServiceCoverageArea
Title: "ServiceCoverageArea"
Description: "ServiceCoverage area as a radius in meters"
Context: HealthcareService.coverageArea
* insert Meta
* value[x] only Quantity
* valueQuantity 1.. MS
  * code 1.. MS
  * code = #m
  * system 1.. MS
  * system = $UCUM

Extension: ServiceCoveragePostalCode
Id: ServiceCoveragePostalCode
Title: "ServiceCoveragePostalCode"
Description: "Service coverage area expressed as a postal code (PLZ)"
Context: HealthcareService.coverageArea
* insert Meta
* value[x] only string
* valueString 1.. MS

Extension: OrganizationVisibility
Id: OrganizationVisibility
Title: "OrganizationVisibility"
Description: "Visibility of an Organization in the FHIR-VZD. This Extensions includes codes of use-cases im which this Organization SHALL not be visible."
Context: Organization
* insert Meta
* value[x] MS
* value[x] only Coding
* valueCoding 1.. MS
* valueCoding from OrganizationVisibilityVS

CodeSystem: OrganizationVisibilityCS
Id: OrganizationVisibilityCS
Title: "OrganizationVisibilityCS"
Description: "OrganizationVisibilityCS"
* insert Meta
* #hide-erezeptApp "Eintrag nicht in eRezeptApp darstellen"

ValueSet: OrganizationVisibilityVS
Id: OrganizationVisibilityVS
Title: "OrganizationVisibilityVS"
Description: "OrganizationVisibilityVS"
* insert Meta
* include codes from system OrganizationVisibilityCS

Extension: EndpointVisibility
Id: EndpointVisibility
Title: "EndpointVisibility"
Description: "Visibility of an Endpoint in the FHIR-VZD. This Extensions includes codes of use-cases im which this Endpoint SHALL not be visible."
Context: Endpoint
* insert Meta
* value[x] MS
* value[x] only Coding
* valueCoding 1.. MS
* valueCoding from EndpointVisibilityVS

CodeSystem: EndpointVisibilityCS
Id: EndpointVisibilityCS
Title: "EndpointVisibilityCS"
Description: "EndpointVisibilityCS"
* insert Meta
* #hide-versicherte "Eintrag für Versicherte verbergen"

ValueSet: EndpointVisibilityVS
Id: EndpointVisibilityVS
Title: "EndpointVisibilityVS"
Description: "EndpointVisibilityVS"
* insert Meta
* include codes from system EndpointVisibilityCS

Extension: SpecialOpeningTimesEX
Id: SpecialOpeningTimesEX
Title: "SpecialOpeningTimesEX"
Description: "SpecialOpeningTimesEX"
Context: HealthcareService.availableTime
* insert Meta
* extension contains
    period 1..1 MS and
    qualifier 1..1 MS
* extension[period]
  * value[x] only Period
  * valuePeriod 1.. MS
* extension[qualifier]
  * value[x] only Coding
  * valueCoding 1.. MS
  * valueCoding from OpeningTimeQualifierVS

CodeSystem: OpeningTimeQualifierCS
Id: OpeningTimeQualifierCS
Title: "OpeningTimeQualifierCS"
Description: "Qualifier code for HealthCareService opening times"
* insert Meta
* #notdienst "Notdienst"

ValueSet: OpeningTimeQualifierVS
Id: OpeningTimeQualifierVS
Title: "OpeningTimeQualifierVS"
Description: "ValueSet of Qualifier codes for HealthCareService opening times"
* insert Meta
* include codes from system OpeningTimeQualifierCS

Extension: PhysicalFeaturesAdditionalNoteEX
Id: PhysicalFeaturesAdditionalNoteEX
Title: "Physical Features Additional Note"
Description: "Additional FreeText for HealthCare characteristics"
Context: HealthcareService.characteristic
* insert Meta
* value[x] only string
* valueString 1.. MS

Extension: NCPeHCountryEx
Id: ncpeh-country-ex
Title: "National Contact Point of Health (NCPeH) Country Extension"
Description: "The country extension for  National Contact Point of Health (NCPeH) Organizations, representing the country in which the NCPeH is located." 
Context: Organization
* insert Meta
* value[x] 1.. MS
* value[x] only Coding
* valueCoding 1.. MS
* valueCoding from Iso3166-1-2
  * system 1.. MS
  * code 1.. MS