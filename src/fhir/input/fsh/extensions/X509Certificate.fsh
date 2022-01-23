CodeSystem: X509CertificateFormatCS
Description: "Codes for X509Certificate encoding formats"
* insert Meta
* ^content = #complete
* #der "DER with Base64"
* #pem "PEM as string"

ValueSet: X509CertificateFormatVS
Description: "Encoding format for X.509 certificate"
* insert Meta
* include codes from system X509CertificateFormatCS

Extension: X509Certificate
Id: X509Certificate
Description: "General purpose extension to provide X.509 certificates as part of a resource"
* insert Meta
* extension contains
  format 1..1 MS
  and content 1..1 MS
* extension[format]
  * ^short = "Encoding format of the certificate in 'content' field."
  * value[x] only code
  * valueCode from X509CertificateFormatVS (required)

* extension[content] 
  * ^short = "Certificate data. The format of the string depends on the specified format."
  * value[x] only string
