Instance: HealthcareService-organization
InstanceOf: SearchParameter
Usage: #definition
* extension[0]
  * url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
  * valueCode = #trial-use
* insert refChain(identifier)
* insert refChain(name) 
* insert refChain(alias)
* insert refChain(type)
* insert refChain(active)
* insert refChain(organizationVisibility)
* url = "http://hl7.org/fhir/SearchParameter/HealthcareService-organization"
* version = "4.0.1"
* name = "organization"
* status = #active
* experimental = false
* date = "2019-11-01T09:29:23+11:00"
* publisher = "Health Level Seven International (Patient Administration)"
* contact[0].telecom
  * system = #url
  * value = "http://hl7.org/fhir"
* contact[+].telecom
  * system = #url
  * value = "http://www.hl7.org/Special/committees/pafm/index.cfm"
* description = "The organization that provides this Healthcare Service"
* code = #organization
* base = #HealthcareService
* type = #reference
* expression = "HealthcareService.providedBy"
* xpath = "f:HealthcareService/f:providedBy"
* xpathUsage = #normal
* target = #Organization

Instance: HealthcareService-location
InstanceOf: SearchParameter
Usage: #definition
* extension
  * url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
  * valueCode = #trial-use
* insert refChain(identifier)
* insert refChain(address)
* url = "http://hl7.org/fhir/SearchParameter/HealthcareService-location"
* version = "4.0.1"
* name = "location"
* status = #active
* experimental = false
* date = "2019-11-01T09:29:23+11:00"
* publisher = "Health Level Seven International (Patient Administration)"
* contact[0].telecom
  * system = #url
  * value = "http://hl7.org/fhir"
* contact[+].telecom
  * system = #url
  * value = "http://www.hl7.org/Special/committees/pafm/index.cfm"
* description = "The location of the Healthcare Service"
* code = #location
* base = #HealthcareService
* type = #reference
* expression = "HealthcareService.location"
* xpath = "f:HealthcareService/f:location"
* xpathUsage = #normal
* target = #Location

Instance: HealthcareService-endpoint
InstanceOf: SearchParameter
Usage: #definition
* extension
  * url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
  * valueCode = #trial-use
* insert refChain(identifier)
* insert refChain(connectionType)
* insert refChain(status)
* insert refChain(name)
* insert refChain(address)
* insert refChain(payloadType)
* url = "http://hl7.org/fhir/SearchParameter/HealthcareService-endpoint"
* version = "4.0.1"
* name = "endpoint"
* status = #active
* experimental = false
* date = "2019-11-01T09:29:23+11:00"
* publisher = "Health Level Seven International (Patient Administration)"
* contact[0].telecom
  * system = #url
  * value = "http://hl7.org/fhir"
* contact[+].telecom
  * system = #url
  * value = "http://www.hl7.org/Special/committees/pafm/index.cfm"
* description = "Technical endpoints providing access to electronic services operated for the healthcare service"
* code = #endpoint
* base = #HealthcareService
* type = #reference
* expression = "HealthcareService.endpoint"
* xpath = "f:HealthcareService/f:endpoint"
* xpathUsage = #normal
* target = #Endpoint

Instance: PractitionerRole-practitioner
InstanceOf: SearchParameter
Usage: #definition
* extension
  * url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
  * valueCode = #trial-use
* insert refChain(identifier)
* insert refChain(active)
* insert refChain(name)
* insert refChain(qualification)
* url = "http://hl7.org/fhir/SearchParameter/PractitionerRole-practitioner"
* version = "4.0.1"
* name = "practitioner"
* status = #active
* experimental = false
* date = "2019-11-01T09:29:23+11:00"
* publisher = "Health Level Seven International (Patient Administration)"
* contact[0].telecom
  * system = #url
  * value = "http://hl7.org/fhir"
* contact[+].telecom
  * system = #url
  * value = "http://www.hl7.org/Special/committees/pafm/index.cfm"
* description = "Practitioner that is able to provide the defined services for the organization"
* code = #practitioner
* base = #PractitionerRole
* type = #reference
* expression = "PractitionerRole.practitioner"
* xpath = "f:PractitionerRole/f:practitioner"
* xpathUsage = #normal
* target = #Practitioner

Instance: PractitionerRole-location
InstanceOf: SearchParameter
Usage: #definition
* extension
  * url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
  * valueCode = #trial-use
* insert refChain(identifier)
* insert refChain(address)
* url = "http://hl7.org/fhir/SearchParameter/PractitionerRole-location"
* version = "4.0.1"
* name = "location"
* status = #active
* experimental = false
* date = "2019-11-01T09:29:23+11:00"
* publisher = "Health Level Seven International (Patient Administration)"
* contact[0].telecom
  * system = #url
  * value = "http://hl7.org/fhir"
* contact[+].telecom
  * system = #url
  * value = "http://www.hl7.org/Special/committees/pafm/index.cfm"
* description = "One of the locations at which this practitioner provides care"
* code = #location
* base = #PractitionerRole
* type = #reference
* expression = "PractitionerRole.location"
* xpath = "f:PractitionerRole/f:location"
* xpathUsage = #normal
* target = #Location

Instance: PractitionerRole-endpoint
InstanceOf: SearchParameter
Usage: #definition
* extension.url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension.valueCode = #trial-use
* insert refChain(identifier)
* insert refChain(connectionType)
* insert refChain(status)
* insert refChain(name)
* insert refChain(address)
* insert refChain(payloadType)
* url = "http://hl7.org/fhir/SearchParameter/PractitionerRole-endpoint"
* version = "4.0.1"
* name = "endpoint"
* status = #draft
* experimental = false
* date = "2019-11-01T09:29:23+11:00"
* publisher = "Health Level Seven International (Patient Administration)"
* contact[0].telecom.system = #url
* contact[=].telecom.value = "http://hl7.org/fhir"
* contact[+].telecom.system = #url
* contact[=].telecom.value = "http://www.hl7.org/Special/committees/pafm/index.cfm"
* description = "Technical endpoints providing access to services operated for the practitioner with this role"
* code = #endpoint
* base = #PractitionerRole
* type = #reference
* expression = "PractitionerRole.endpoint"
* xpath = "f:PractitionerRole/f:endpoint"
* xpathUsage = #normal
* target = #Endpoint