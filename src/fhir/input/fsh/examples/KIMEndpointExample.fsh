Instance: KIMEndpointExample
InstanceOf: EndpointDirectoryStrict
Usage: #example
Description: "Beispiel eines KIM-Endpunkts (KIM 2.0) mit allen relevanten Extensions"
* meta.tag[Origin] = Origin#ldap
* extension[endpointVisibility].valueCoding = EndpointVisibilityCS#hide-versicherte
* extension[ownerTelematikId].valueIdentifier.value = "1-1.58.00000040"
* extension[EndpointFADIdEx].valueIdentifier
  * value = "fad-12345"
* status = #active "Active"
* connectionType = EndpointDirectoryConnectionType#kim "KIM Endpoint"
* connectionType.extension[kimVersion]
  * extension[version].valueCoding = KimVersionCS#kim-2.0 "KIM 2.0 Endpoint"
  * extension[xxlMailSupported].valueBoolean = true
* name = "KIM-Mailadresse"
* payloadType = DataAbsentReason#not-applicable "Not Applicable"
* address = "dr.mustermann@praxis-mustermann.kim.telematik"
