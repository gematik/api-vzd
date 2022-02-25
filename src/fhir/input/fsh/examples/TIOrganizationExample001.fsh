Instance: TIOrganizationExample001-Endpoint-KIM
InstanceOf: TIEndpoint
Usage: #example
Description: """
Example KIM 1.5 Endpoint with any payload
"""
* status = #active
* connectionType = TIEndpointConnectionTypeCS#kim-1.5
* payloadType = #any
* address = "mailto:gematik006@xxx.kim.telematik"

Instance: TIOrganizationExample001-Endpoint-TIM
InstanceOf: Endpoint
Usage: #example
Description: """
"""
* status = #active
* connectionType = TIEndpointConnectionTypeCS#ti-messenger
* address = "@betrieb:tim.gematik.de"
* payloadType = #any

Instance: TIOrganizationExample001-Endpoint-EPA
InstanceOf: Endpoint
Usage: #example
Description: """
Example of an ePA-Endpoint with a dedicated X509-Certficate
for authorization.
"""
* status = #active
* connectionType = TIEndpointConnectionTypeCS#epa
* address = "urn:TODO"
* payloadType = #any
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
* type = TIInstitutionTypeOidCS#1.2.276.0.76.4.58
* name = "gematik GmbH"
* active = true
* alias = "gematik"
* address.text = "gematik GmbH, Friedrichstr. 136, 10117 Berlin"
* address.line = "Friedrichstr. 136"
* address.city = "Berlin"
* address.district = "Mitte"
* address.state = BundeslaenderCS#Berlin
* address.postalCode = "10117"
* address.country = "DE"
// Gibt es bedarf an TI/DE-spezifischen Kontakt-Zwecken?
* contact.purpose = $ContactEntityTypeCS#ADMIN
* contact.name.text = "gematik ITSM"
* contact.telecom[+].system = $ContactPointSystemCS#email
* contact.telecom[=].value = "betrieb@gematik.de"
* endpoint[+] = Reference(TIOrganizationExample001-Endpoint-KIM)
* endpoint[+] = Reference(TIOrganizationExample001-Endpoint-TIM)
* endpoint[+] = Reference(TIOrganizationExample001-Endpoint-EPA)
