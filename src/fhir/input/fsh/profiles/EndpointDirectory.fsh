Profile: EndpointDirectory
//Id: gem-dir-endpoint
Parent: Endpoint
Title: "Endpoint in gematik Directory"
Description: "Endpoints for applications in the gematik Directory"
* insert Meta
* id MS
* extension contains EndpointVisibility named endpointVisibility 0..* MS
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* status 1..1 MS
* connectionType 1..1 MS
  * code MS
  * code from EndpointConnectionTypeVS
  * system MS
* name 1..1 MS
* payloadType MS
* payloadType from EndpointPayloadTypeVS
* address 1..1 MS

Profile: EndpointDirectoryStrict
Parent: EndpointDirectory
Id: endpoint-directory-Strict
Title: "EndpointDirectory-Strict"
Description: "Endpoint in gematik Directory with strict constraints"
* meta.tag
  * ^slicing.rules = #closed
* identifier 0..0
* managingOrganization 0..0
* contact 0..0
* period 0..0
* payloadMimeType 0..0
* header 0..0
