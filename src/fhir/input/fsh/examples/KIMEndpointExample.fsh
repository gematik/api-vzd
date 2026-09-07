Instance: KIMEndpointExample
InstanceOf: EndpointDirectoryStrict
Usage: #example
Description: "Beispiel eines KIM-Endpunkts (KIM 2.0) mit allen relevanten Extensions"
* meta.tag[Origin] = Origin#ldap
* extension[endpointVisibility].valueCoding = EndpointVisibilityCS#hide-versicherte
* extension[ownerTelematikId].valueIdentifier.value = "1-1.58.00000040"
* extension[endpointFADId].valueIdentifier
  * value = "fad-12345"
* extension[certificate]
  * extension[certificate].valueBase64Binary = "MIIFAzCCA+ugAwIBAgIHAkhg11wm8jANBgkqhkiG9w0BAQsFADCBmjELMAkGA1UEBhMCREUxHzAdBgNVBAoMFmdlbWF0aWsgR21iSCBOT1QtVkFMSUQxSDBGBgNVBAsMP0luc3RpdHV0aW9uIGRlcyBHZXN1bmRoZWl0c3dlc2Vucy1DQSBkZXIgVGVsZW1hdGlraW5mcmFzdHJ1a3R1cjEgMB4GA1UEAwwXR0VNLlNNQ0ItQ0E0MSBURVNULU9OTFkwHhcNMjMwMjA4MjMwMDAwWhcNMjgwMjA4MjI1OTU5WjCBhjELMAkGA1UEBhMCREUxHDAaBgNVBAoMEzMwMjIxMDgwMCBOT1QtVkFMSUQxEzARBgNVBAQMClNjaG5lZXJvc2UxETAPBgNVBCoMCEFkZWxoZWlkMTEwLwYDVQQDDChBcnp0cHJheGlzIEFkZWxoZWlkIFNjaG5lZXJvc2UgVEVTVC1PTkxZMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5bLYnCey3gKVzWxQKINRf8rnY2d/SQQbMZDhGoqyUngIUcTn1sJtrQYdQuOryvOJiTeeBoh6aNkxMnzHDcnAAmKtsEq+0gbsLgnhJHLUZTOYJifcmTkPLYvVIxAlRi0RFS/9NfQ0PjXCFh6kLGAdQs1F1suvWX2H6NZy1TKAyQIXS43SuCxI6sldas0tcFj4wqjRx8TPJD/bnml8HPtHfLdVjLWjPOPqewqv4a7Lh5z0rTmf20fQv5R2Ws27mCfl9+pvbB0X+qGiVo+mlPuFskZLehF5fOyJF1YTiTs81bNsTpGYbuLRUQ+0iaQBNOKvVsNPBNlr7nmEBZqEPrDTwIDAQABo4IBXjCCAVowDgYDVR0PAQH/BAQDAgWgMCAGA1UdIAQZMBcwCgYIKoIUAEwEgSMwCQYHKoIUAEwETTATBgNVHSUEDDAKBggrBgEFBQcDAjBbBgUrJAgDAwRSMFAwTjBMMEowSDAWDBRCZXRyaWVic3N0w6R0dGUgQXJ6dDAJBgcqghQATAQyEyMxLTItQVJaVFBSQVhJUy1BZGVsaGVpZFNjaG5lZXJvc2UwMTAfBgNVHSMEGDAWgBS6+DpYEfaG6gSibcR667mz+ktvwjAsBgNVHR8EJTAjMCGgH6AdhhtodHRwOi8vZWhjYS5nZW1hdGlrLmRlL2NybC8wOAYIKwYBBQUHAQEELDAqMCgGCCsGAQUFBzABhhxodHRwOi8vZWhjYS5nZW1hdGlrLmRlL29jc3AvMAwGA1UdEwEB/wQCMAAwHQYDVR0OBBYEFMrpwW7ItfI7/kzq4OMoL6upYZrnMA0GCSqGSIb3DQEBCwUAA4IBAQCvImqyaj9qJHZbJRa2GiRup3vNC2L/y3Ckkouk8O3IUPxtgiHMLX9lFnoP9kwPYj4rRxaxlcXj4enKFAv7PRS5rpWkNXeC8fu5iwKfw9Nb7cHga7dPQaAzXB5UCplQ9PK27USqeJCfRfHrDMMLNJ2pbyEFxIT+YmlAC9TK2r+iXzNfEStXwB+PR+PFs7jHhggfIOp2cT3NHCG20SbhjlNtu2K0SKkA2ugUmRcoKwFu+qhQkSH83ToJwAxQXW2pN0Tqdbhpo4n5hYJuUDtjUN/FLbx0Fl4WYzfZ0aQqaqVQAl8ITxELyP/cloSKHVKekejiEEXAnJ4YLZQLoNo+bFtc"
  * extension[serialNumber].valueString = "642530720622322"
  * extension[issuer].valueString = "CN=GEM.SMCB-CA41 TEST-ONLY,OU=Institution des Gesundheitswesens-CA der Telematikinfrastruktur,O=gematik GmbH NOT-VALID,C=DE"
  * extension[publicKeyAlgorithm].valueCoding = CertificatePublicKeyAlgorithmCS#RSA "RSA"
  * extension[period].valuePeriod
    * start = "2023-02-08T23:00:00Z"
    * end = "2028-02-08T22:59:59Z"
  * extension[active].valueBoolean = true
* status = #active "Active"
* connectionType = EndpointDirectoryConnectionType#kim "KIM Endpoint"
* connectionType.extension[kimVersion]
  * extension[version].valueCoding = KimVersionCS#2.0 "KIM 2.0 Endpoint"
  * extension[xxlMailSupported].valueBoolean = true
* name = "KIM-Mailadresse"
* payloadType = EndpointDirectoryKIMappTags#Arztbrief "eArztbrief"
* address = "dr.mustermann@praxis-mustermann.kim.telematik"
