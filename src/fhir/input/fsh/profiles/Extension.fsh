Extension: ServiceCoverageArea
Id: ServiceCoverageArea
Title: "ServiceCoverageArea"
Description: "ServiceCoverage area as a radius in meters"
Context: HealthcareService.coverageArea
* insert Meta
* value[x] only Quantity
* valueQuantity 1.. MS
  * code 1.. MS
  * code = #m
  * system 1.. MS
  * system = $UCUM

Extension: ServiceCoveragePostalCode
Id: ServiceCoveragePostalCode
Title: "ServiceCoveragePostalCode"
Description: "Service coverage area expressed as a postal code (PLZ)"
Context: HealthcareService.coverageArea
* insert Meta
* value[x] only string
* valueString 1.. MS

Extension: OrganizationVisibility
Id: OrganizationVisibility
Title: "OrganizationVisibility"
Description: "Visibility of an Organization in the FHIR-VZD. This Extensions includes codes of use-cases im which this Organization SHALL not be visible."
Context: Organization
* insert Meta
* value[x] MS
* value[x] only Coding
* valueCoding obeys CodingSytemCodeInv
* valueCoding 1.. MS
* valueCoding from OrganizationVisibilityVS

Extension: EndpointVisibility
Id: EndpointVisibility
Title: "EndpointVisibility"
Description: "Visibility of an Endpoint in the FHIR-VZD. This Extensions includes codes of use-cases im which this Endpoint SHALL not be visible."
Context: Endpoint
* insert Meta
* value[x] MS
* value[x] only Coding
* valueCoding obeys CodingSytemCodeInv
* valueCoding 1.. MS
* valueCoding from EndpointVisibilityVS

Extension: SpecialOpeningTimesEX
Id: SpecialOpeningTimesEX
Title: "SpecialOpeningTimesEX"
Description: "SpecialOpeningTimesEX"
Context: HealthcareService.availableTime
* insert Meta
* extension contains
    period 1..1 MS and
    qualifier 1..1 MS
* extension[period]
  * value[x] only Period
  * valuePeriod 1.. MS
* extension[qualifier]
  * value[x] only Coding
  * valueCoding obeys CodingSytemCodeInv
  * valueCoding 1.. MS
  * valueCoding from OpeningTimeQualifierVS

Extension: PhysicalFeaturesAdditionalNoteEX
Id: PhysicalFeaturesAdditionalNoteEX
Title: "Physical Features Additional Note"
Description: "Additional FreeText for HealthCare characteristics"
Context: HealthcareService.characteristic
* insert Meta
* value[x] only string
* valueString 1.. MS

Extension: ResultsFilteredEx
Id: results-filtered-ex
Title: "Results Filtered Extension"
Description: "Extension reporting the number of results filtered out by the server"
Context: Bundle.total
* insert Meta
* extension contains
    count 1..1 MS and
    reason 1..1 MS
* extension[count]
  * value[x] only integer
  * valueInteger 1.. MS
* extension[reason]
  * value[x] only string
  * valueString 1.. MS

Extension: HolderIdEx
Id: holder-id-ex
Title: "Holder ID Extension"
Description: "Extension for the holder ID of a HealthCard" // liste der berechtigt updates durchzuführen
Context: HealthcareService, PractitionerRole
* insert Meta
* value[x] only code
* valueCode 1.. MS

Extension: OwnerTelematikIdEx
Id: OwnerTelematikIdEx
Title: "OwnerTelematikIdEx"
Description: "Extension for the Telematik ID of the owner of a Resource" // erzeuger und inhaber
Context: Resource
* insert Meta
* value[x] only $IdentifierTelematikID
* valueIdentifier 1.. MS

Extension: ConnectionTypeKimVersionEx
Id: ConnectionTypeKimVersionEx
Title: "ConnectionType KimVersion Extension"
Description: "Extension for the KIM version of an Endpoint connection type"
Context: Endpoint.connectionType
* insert Meta
* extension contains
    version 1..1 MS and
    xxlMailSupported 1..1 MS
* extension[version]
  * value[x] only Coding
  * valueCoding obeys CodingSytemCodeInv
  * valueCoding 1.. MS
  * valueCoding from KimVersionVS
* extension[xxlMailSupported]
  * value[x] only boolean
  * valueBoolean 1.. MS

Extension: EndpointFADIdEx
Id: EndpointFADIdEx
Title: "Endpoint Fachdienst-ID Extension"
Description: "Extension for the FAD of an KIM Endpoint"
Context: Endpoint
* insert Meta
* value[x] only Identifier
* valueIdentifier 1.. MS
  * system 1.. MS
  * system = $IdentifierFAD
  * value 1.. MS

Extension: EndpointCertificateEx
Id: EndpointCertificateEx
Title: "Endpoint Certificate Extension"
Description: """X.509-Zertifikat eines Endpunkts, z. B. das Verschlüsselungszertifikat einer KIM-Mailadresse.
Die Extension ist wiederholbar, um Zertifikatswechsel (Rollover) abzubilden.
"""
Context: Endpoint
* insert Meta
* extension contains
    certificate 1..1 MS and
    serialNumber 0..1 MS and
    issuer 0..1 MS and
    publicKeyAlgorithm 0..1 MS and
    period 0..1 MS and
    active 0..1 MS
* extension[certificate]
  * ^short = "Zertifikat im DER-Format, Base64-kodiert"
  * value[x] only base64Binary
  * valueBase64Binary 1.. MS
* extension[serialNumber]
  * ^short = "Seriennummer des Zertifikats (dezimal)"
  * value[x] only string
  * valueString 1.. MS
* extension[issuer]
  * ^short = "Distinguished Name des Ausstellers"
  * value[x] only string
  * valueString 1.. MS
* extension[publicKeyAlgorithm]
  * value[x] only Coding
  * valueCoding obeys CodingSytemCodeInv
  * valueCoding 1.. MS
  * valueCoding from CertificatePublicKeyAlgorithmVS
* extension[period]
  * ^short = "Gültigkeitszeitraum: start = notBefore, end = notAfter"
  * value[x] only Period
  * valuePeriod 1.. MS
* extension[active]
  * ^short = "Zertifikat ist gültig bzw. nicht gesperrt"
  * value[x] only boolean
  * valueBoolean 1.. MS