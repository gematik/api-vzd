Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* insert Meta
* id 1..1 MS
* active 1..1 MS
* name 1..1 MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains TelematikID 1..1 MS
* identifier[TelematikID] only $IdentifierTelematikID
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1..1 MS
  * system 1..1 MS
  * value 1..1 MS
* type 1..* MS
* type from TIOrganizationTypeVS
* alias 1..1 MS
* address MS
* partOf 0..1 MS
* contact MS
* contact.purpose from $ContactEntityTypeVS
* contact.telecom.extension contains X509Certificate named certificate 0..1 MS

Instance: TIOrganizationExample001
InstanceOf: TIOrganization
Usage: #example
Description: "Example of an Organization as to be found in gematik FHIR Directory"
* identifier[+].system = $IdentifierTelematikID
* identifier[=].value = "9-2.58.00000040"
* type = TIPractitionerProfessionOidCS#urn:oid:1.2.276.0.76.4.30
* name = "gematik GmbH"
* active = true
* alias = "gematik"
* address.text = "gematik GmbH, Friedrichstr. 136, 10117 Berlin"
* address.line = "Friedrichstr. 136"
* address.city = "Berlin"
* address.district = "Mitte"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"
* partOf = Reference(280345)
// Gibt es bedarf an TI/DE-spezifischen Kontakt-Zwecken?
* contact.purpose = $ContactEntityTypeCS#ADMIN
* contact.name.text = "gematik ITSM"
// alternative 1: matrix wird über URL festgestellt
* contact.telecom[+].system = $ContactPointSystemCS#url
* contact.telecom[=].value = "matrix:u/gematik-itsm:gematik.de"
// alternative 2: ti-messenger ist eigener code
* contact.telecom[+].system = TIContactPointSystemCS#matrix
* contact.telecom[=].value = "matrix:u/gematik-itsm:gematik.de"
// alternative 1: KIM Adresse ist "email"
* contact.telecom[+].system = $ContactPointSystemCS#email
* contact.telecom[=].value = "gematik006@xxx.kim.telematik"
// alternative 2: KIM Adresse ist eigener code 
// dadurch kollidiert nicht "KIM email" mit "normalen" email
// eventuell kann man auch einen Slice definieren, 
// der Zertifikat sicherstellt
* contact.telecom[+].system = TIContactPointSystemCS#kim
* contact.telecom[=].value = "gematik006@xxx.kim.telematik"
* contact.telecom[=].extension[X509Certificate].extension[format].valueCode = #der
* contact.telecom[=].extension[X509Certificate].extension[content].valueString = """
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
"""
// noch ein Beispiel, diesmal mit PEMZertifikat
* contact.telecom[+].system = TIContactPointSystemCS#kim
* contact.telecom[=].value = "gematik007@xxx.kim.telematik"
* contact.telecom[=].extension[X509Certificate].extension[format].valueCode = #pem
* contact.telecom[=].extension[X509Certificate].extension[content].valueString = """
-----BEGIN ENCRYPTED PRIVATE KEY-----
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
3yVZFd+WJlfOMQsFtIUqmDA+uA==
-----END ENCRYPTED PRIVATE KEY-----
"""
