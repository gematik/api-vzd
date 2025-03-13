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
* valueCoding obeys CodingSytemCodeInv
* valueCoding 1.. MS
* valueCoding from OrganizationVisibilityVS

Extension: EndpointVisibility
Id: EndpointVisibility
Title: "EndpointVisibility"
Description: "Visibility of an Endpoint in the FHIR-VZD. This Extensions includes codes of use-cases im which this Endpoint SHALL not be visible."
Context: Endpoint
* insert Meta
* value[x] MS
* value[x] only Coding
* valueCoding obeys CodingSytemCodeInv
* valueCoding 1.. MS
* valueCoding from EndpointVisibilityVS

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
  * valueCoding obeys CodingSytemCodeInv
  * valueCoding 1.. MS
  * valueCoding from OpeningTimeQualifierVS

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
* valueCoding obeys CodingSytemCodeInv
* valueCoding from Iso3166-1-2
  * system 1.. MS
  * code 1.. MS

Extension: ResultsFilteredEx
Id: results-filtered-ex
Title: "Results Filtered Extension"
Description: "Extension reporting the number of results filtered out by the server"
Context: Bundle.total
* insert Meta
* extension contains
    count 1..1 MS and
    reason 1..1 MS
* extension[count]
  * value[x] only integer
  * valueInteger 1.. MS
* extension[reason]
  * value[x] only string
  * valueString 1.. MS

Extension: HolderIdEx
Id: holder-id-ex
Title: "Holder ID Extension"
Description: "Extension for the holder ID of a HealthCard"
Context: HealthcareService, PractitionerRole
* insert Meta
* value[x] only code
* valueCode 1.. MS