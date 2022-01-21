Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* ^url = "https://gematik.de/fhir/directory/StructureDefinition/TIOrganization"
* ^status = #draft
* id MS
* active MS
* name MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains SliceTelematikID 1..1 MS
* identifier[SliceTelematikID] only IdentifierTelematikId
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1.. MS  //@spilikin die Kardinalität ist aus meiner Sicht unvollständig angegeben. Meintest Du 1..1 ? Im Beispiel ist aber kein type angegeben, daher 0..1 ?
  * system MS
  * value MS
* type 1..* MS
* alias MS
* address MS
* partOf MS
* contact MS

Instance: TIOrganizationExample001
InstanceOf: TIOrganization
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* identifier[+].system = "http://fhir.de/StructureDefinition/identifier-telematik-id"
* identifier[=].value = "9-2.58.00000040"
* name = "gematik GmbH"
* active = true
* type.system = "https://www.gematik.de/fhir/VZD-FHIR-Directory/CodeSystem/TIProfessionOidCS"
* type.code = "urn:oid:1.2.276.0.76.4.58"
* type.display = "Betriebsstätte gematik"
* alias "gematik"
* address.text = "gematik GmbH, Friedrichstr. 136, 10117 Berlin"
* address.line = "Friedrichstr. 136"
* address.city = "Berlin"
* address.district = "Mitte"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"
* partOf = "280345"
* conttact.purpose = "ITSM-RFC"
* conttact.name = "gematik ITSM"
* conttact.telecom.system = "url"
* conttact.telecom.value = "matirx:u/gematik-itsm:gematik.de"
