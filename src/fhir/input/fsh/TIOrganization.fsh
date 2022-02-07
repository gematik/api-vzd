Profile: TIOrganization
Parent: Organization
Description: "Profile for the Organization in gematik FHIR Directory"
* insert Meta
* id 0..1 MS
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
* alias 0..* MS
* address MS
* partOf 0..1 MS
* contact MS
* contact.purpose from $ContactEntityTypeVS
* contact.telecom.extension contains X509CertificatePEM named certificate 0..* MS
* endpoint.extension contains X509CertificatePEM named certificate 0..* MS

Instance: TIOrganizationExample001-Endpoint-KIM
InstanceOf: Endpoint
Usage: #example
Description: """
"""
* status = #active
* connectionType = #secure-email
* payloadType = #urn:ihe:pcc:xphr:2007
* address = "mailto:gematik006@xxx.kim.telematik"
* extension[X509CertificatePEM].valueString = """
-----BEGIN CERTIFICATE-----
MIIC6jCCAksCCQCwBVjloct7dDAKBggqhkjOPQQDAjCBuDELMAkGA1UEBhMCREUx
DzANBgNVBAgMBkJlcmxpbjEPMA0GA1UEBwwGQmVybGluMRUwEwYDVQQKDAxnZW1h
dGlrIEdtYkgxHDAaBgNVBAsME1N5c3RlbXMgRW5naW5lZXJpbmcxJTAjBgNVBAMM
HGdlbWF0aWswMDZAeHh4LmtpbS50ZWxlbWF0aWsxKzApBgkqhkiG9w0BCQEWHGdl
bWF0aWswMDZAeHh4LmtpbS50ZWxlbWF0aWswHhcNMjIwMTI0MTcxMDU0WhcNMzEx
MjAzMTcxMDU0WjCBuDELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJlcmxpbjEPMA0G
A1UEBwwGQmVybGluMRUwEwYDVQQKDAxnZW1hdGlrIEdtYkgxHDAaBgNVBAsME1N5
c3RlbXMgRW5naW5lZXJpbmcxJTAjBgNVBAMMHGdlbWF0aWswMDZAeHh4LmtpbS50
ZWxlbWF0aWsxKzApBgkqhkiG9w0BCQEWHGdlbWF0aWswMDZAeHh4LmtpbS50ZWxl
bWF0aWswgZswEAYHKoZIzj0CAQYFK4EEACMDgYYABABD6IbJvLbm+Q+QwKRg5L+Q
399OYMyBQENdX4K1k8esIK2eFynSrTW9T9QKnlUpGJ6JoyqR7AII6MS5yJHwqBir
wQHHTaDrmPmACYW93nQ0uuNRA3C62AthKdLHFnC0kkfu99R7bszB3vvoLQCDHRj+
4cmxVmSI9oEPRnPM3IeRxL8I0zAKBggqhkjOPQQDAgOBjAAwgYgCQgHbg/d3J7Z9
A2HRSa+kuBgvRe/Ts+juMfvm6HT9hD+zX1KKCxejoCYzthJ7Dm3zBk5dUaNUXKzC
1y2mJttRWIE9YgJCAVV0nLIIl0Qf2akSkQS+bS3/ZtsN3hdFVhUknDIASfGDEeH7
PB/fbtfleMpbrN1Y3wpPcXDuWrPYcer8WGvs18ru
-----END CERTIFICATE-----
"""
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
* address.state = BundeslaenderCS#BE
* address.postalCode = "10117"
* address.country = "DE"
* partOf = Reference(280345)
// Gibt es bedarf an TI/DE-spezifischen Kontakt-Zwecken?
* contact.purpose = $ContactEntityTypeCS#ADMIN
* contact.name.text = "gematik ITSM"
* contact.telecom[+].system = $ContactPointSystemCS#url
* contact.telecom[=].value = "matrix:u/gematik-itsm:gematik.de"
// woran erkennen wir, dass es eine KIM EMail adresse ist? ".telematik$"?
* contact.telecom[+].system = $ContactPointSystemCS#email
* contact.telecom[=].value = "gematik006@xxx.kim.telematik"
* contact.telecom[=].extension[X509CertificatePEM].valueString = """
-----BEGIN CERTIFICATE-----
MIIC6jCCAksCCQCwBVjloct7dDAKBggqhkjOPQQDAjCBuDELMAkGA1UEBhMCREUx
DzANBgNVBAgMBkJlcmxpbjEPMA0GA1UEBwwGQmVybGluMRUwEwYDVQQKDAxnZW1h
dGlrIEdtYkgxHDAaBgNVBAsME1N5c3RlbXMgRW5naW5lZXJpbmcxJTAjBgNVBAMM
HGdlbWF0aWswMDZAeHh4LmtpbS50ZWxlbWF0aWsxKzApBgkqhkiG9w0BCQEWHGdl
bWF0aWswMDZAeHh4LmtpbS50ZWxlbWF0aWswHhcNMjIwMTI0MTcxMDU0WhcNMzEx
MjAzMTcxMDU0WjCBuDELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJlcmxpbjEPMA0G
A1UEBwwGQmVybGluMRUwEwYDVQQKDAxnZW1hdGlrIEdtYkgxHDAaBgNVBAsME1N5
c3RlbXMgRW5naW5lZXJpbmcxJTAjBgNVBAMMHGdlbWF0aWswMDZAeHh4LmtpbS50
ZWxlbWF0aWsxKzApBgkqhkiG9w0BCQEWHGdlbWF0aWswMDZAeHh4LmtpbS50ZWxl
bWF0aWswgZswEAYHKoZIzj0CAQYFK4EEACMDgYYABABD6IbJvLbm+Q+QwKRg5L+Q
399OYMyBQENdX4K1k8esIK2eFynSrTW9T9QKnlUpGJ6JoyqR7AII6MS5yJHwqBir
wQHHTaDrmPmACYW93nQ0uuNRA3C62AthKdLHFnC0kkfu99R7bszB3vvoLQCDHRj+
4cmxVmSI9oEPRnPM3IeRxL8I0zAKBggqhkjOPQQDAgOBjAAwgYgCQgHbg/d3J7Z9
A2HRSa+kuBgvRe/Ts+juMfvm6HT9hD+zX1KKCxejoCYzthJ7Dm3zBk5dUaNUXKzC
1y2mJttRWIE9YgJCAVV0nLIIl0Qf2akSkQS+bS3/ZtsN3hdFVhUknDIASfGDEeH7
PB/fbtfleMpbrN1Y3wpPcXDuWrPYcer8WGvs18ru
-----END CERTIFICATE-----
"""
* endpoint[+] = Reference(TIOrganizationExample001-Endpoint-KIM)
