Extension: X509CertificateBundleExtension
Id: X509CertificateBundleExtension
Description: """
This bundle contains a list of X509Certificates, 
each represented as Binary resource.
"""
* insert Meta
* extension.value[x] only Reference(X509CertificateBundle)
