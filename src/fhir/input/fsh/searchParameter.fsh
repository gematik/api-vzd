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
* publisher = "gematik GmbH"
* description = "Search on Endpoint.extension(https://gematik.de/fhir/directory/StructureDefinition/EndpointVisibility)"
* code = #endpointVisibility
* base = #Endpoint
* type = #token
* expression = "Endpoint.extension.where(url = 'https://gematik.de/fhir/directory/StructureDefinition/EndpointVisibility').value.ofType(Coding)"