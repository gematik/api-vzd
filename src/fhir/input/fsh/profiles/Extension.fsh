Extension: ServiceCoverageArea
Id: ServiceCoverageArea
Title: "ServiceCoverageArea"
Description: "ServiceCoverage area as a radius in meters"
Context: HealthcareService.coverageArea
* insert Meta
* value[x] only Quantity
* valueQuantity 1.. MS
  * code = #m
  * system = $UCUM

Extension: OrganizationVisibility
Id: OrganizationVisibility
Title: "OrganizationVisibility"
Description: "Visibility of an Organization in the FHIR-VZD. This Extensions includes codes of use-cases im which this Organization SHALL not be visible."
Context: Organization
* insert Meta
* value[x] MS
* value[x] only Coding
* value[x] from OrganizationVisibilityVS

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
* value[x] from EndpointVisibilityVS

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

