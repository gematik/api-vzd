Instance: OrganizationTypeDisplaySP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "organization-type-display"
* description = "Search organizations by the display value of their type."
* code = #type-display
* base = #Organization
* type = #string
* expression = "Organization.type.coding.display"
* target = #Organization

Instance: EndpointAddressSP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "address"
* description = "Search by the address field of the Endpoint resource."
* code = #address
* base = #Endpoint
* type = #string
* expression = "Endpoint.address"

Instance: OrganizationVisibilitySP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "organization-visibility"
* description = "Search on https://gematik.de/fhir/directory/StructureDefinition/OrganizationVisibility extension on organization"
* code = #organizationVisibility
* base = #Organization
* type = #token
* expression = "Organization.extension.where(url = 'https://gematik.de/fhir/directory/StructureDefinition/OrganizationVisibility').value.ofType(Coding)"

Instance: PractitionerQualificationSP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "practitioner-qualification"
* description = "Search on Practitioner.qualification.code & Practitioner.qualification.code.coding.display"
* code = #qualification
* base = #Practitioner
* type = #token
* expression = "Practitioner.qualification.code | Practitioner.qualification.code.coding.display"

Instance: EndpointVisibilitySP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "endpoint-visibility"
* description = "Search on Endpoint.extension(https://gematik.de/fhir/directory/StructureDefinition/EndpointVisibility)"
* code = #endpointVisibility
* base = #Endpoint
* type = #token
* expression = "Endpoint.extension.where(url = 'https://gematik.de/fhir/directory/StructureDefinition/EndpointVisibility').value.ofType(Coding)"

Instance: HealthcareServiceCoverageAreaPostalCodeSP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "service-coverage-plz"
* description = "Search on HealthcareService.coverageArea.extension(https://gematik.de/fhir/directory/StructureDefinition/ServiceCoveragePostalCode)"
* code = #coverageAreaPostalCode
* base = #HealthcareService
* type = #string
* expression = "HealthcareService.coverageArea.extension.where(url = 'https://gematik.de/fhir/directory/StructureDefinition/ServiceCoveragePostalCode').value.ofType(string)"

Instance: OrganizationNCPeHCountrySP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "ncpeh-country"
* description = "Search on Organization.extension(https://gematik.de/fhir/directory/StructureDefinition/NCPeHCountry)"
* code = #ncpeh-country
* base = #Organization
* type = #token
* expression = "Organization.extension.where(url = 'https://gematik.de/fhir/directoryNCPeHCountry/StructureDefinition').value.ofType(Coding)"

Instance: OrganizationAliasSP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "alias"
* description = "Search on Organization.alias"
* code = #alias
* base = #Organization
* type = #string
* expression = "Organization.alias"

Instance: HolderIdSP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "holder-id"
* description = "Search on .extension(https://gematik.de/fhir/directory/StructureDefinition/HolderId)"
* code = #holder-id
* base[+] = #HealthcareService
* base[+] = #PractitionerRole
* type = #token
* expression = "HealthcareService.extension.where(url='https://gematik.de/fhir/directory/StructureDefinition/holder-id-ex').value | PractitionerRole.extension.where(url='https://gematik.de/fhir/directory/StructureDefinition/holder-id-ex').value"

Instance: OwnerTelematikIdSP
InstanceOf: SearchParameter
Usage: #definition
* insert MetaInstance
* name = "owner-telematik-id"
* description = "SearchParameter for the Telematik ID of the owner of a resource using the OwnerTelematikIdEx extension"
* code = #owner-telematik-id
* base[+] = #Endpoint
* base[+] = #HealthcareService
* base[+] = #PractitionerRole
* type = #token
* expression = "extension.where(url='https://gematik.de/fhir/directory/StructureDefinition/OwnerTelematikIdEx').value"
