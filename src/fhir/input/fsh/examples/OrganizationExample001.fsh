Instance: OrganizationExample001-Endpoint-TIM
InstanceOf: EndpointDirectoryStrict
Usage: #example
Description: """
Example TI-Messenger Endpoint
"""
* meta.tag[Origin] = Origin#owner
* status = #active "Active"
* connectionType = EndpointDirectoryConnectionType#tim
* name = "SystemsEngineering:tim.gematik.de"
* address = "matrix:u/SystemsEngineering:tim.gematik.de"
* payloadType = EndpointDirectoryPayloadType#tim-chat

Instance: OrganizationExample001
InstanceOf: OrganizationDirectoryStrict
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* active = true
* extension[organizationVisibility].valueCoding = OrganizationVisibilityCS#hide-versicherte
* identifier[TelematikID].value = "9-2.58.00000040"
* type[profession] = TIOrganizationProfessionTypeOidCS#1.2.276.0.76.4.58
* name = "gematik GmbH"
* active = true
* alias = "gematik"
* address.text = """gematik GmbH
Friedrichstr. 136, 
10117 Berlin"""
* address.line[+] = "Friedrichstr. 136"
* address.city = "Berlin"
* address.district = "Mitte"
* address.state = Region#Berlin
* address.postalCode = "10117"
* address.country = "DE"
// Gibt es bedarf an TI/DE-spezifischen Kontakt-Zwecken?
* contact.name.text = "gematik ITSM"
* contact.telecom[+].system = $ContactPointSystemCS#email
* contact.telecom[=].value = "betrieb@gematik.de"