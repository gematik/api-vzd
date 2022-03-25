Profile: TIEndpoint
Parent: Endpoint
Description: "Endpoints for applications in the TI"
* insert Meta
//* extension contains X509CertificatePEM named certificate 0..* MS

* identifier 1..* MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* identifier contains OwnerID 1.. MS

* status 0..* MS
* connectionType 1..1 MS
* name 0..1 MS
* managingOrganization 0..1 MS
* payloadType 1..* MS
* address 1..1 MS