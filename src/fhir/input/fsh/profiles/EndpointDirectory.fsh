Profile: EndpointDirectory
Parent: Endpoint
Title: "Endpoint in gematik Directory"
Description: "Endpoints for applications in the gematik Directory"
* insert Meta
* status 1..1 MS
* connectionType 1..1 MS
* connectionType.code from EndpointConnectionTypeVS
* name 1..1 MS  // identical to address; because search is possible in element name and not in element address
* managingOrganization 0..1 MS
* payloadType 1..* MS
* payloadType from EndpointPayloadTypeVS 
* address 1..1 MS