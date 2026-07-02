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
Description: "Extension for the holder ID of a HealthCard" // liste der berechtigten updates durchzuführen
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

Extension: KhvzGueltigkeitEx
Id: KhvzGueltigkeitEx
Title: "KHVZ Gültigkeit Extension"
Description: "Gültigkeitszeitraum eines KHVZ-HealthcareService (Standortdaten): gültigVon und gültigBis."
Context: HealthcareService
* insert Meta
* extension contains
    gueltigVon 0..1 MS and
    gueltigBis 0..1 MS
* extension[gueltigVon]
  * value[x] only dateTime
  * valueDateTime 1.. MS
* extension[gueltigBis]
  * value[x] only dateTime
  * valueDateTime 1.. MS

Extension: KhvzLetzteAenderungEx
Id: KhvzLetzteAenderungEx
Title: "KHVZ Letzte Änderung Extension"
Description: "Zeitpunkt der letzten Änderung eines KHVZ-HealthcareService (Standortdaten)."
Context: HealthcareService
* insert Meta
* value[x] only dateTime
* valueDateTime 1.. MS

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

Extension: KhvzAusnahmeEx
Id: KhvzAusnahmeEx
Title: "KHVZ Ausnahme Extension"
Description: "Kennzeichnet einen KHVZ-HealthcareService (Standort/Einrichtung) als Ausnahme im Sinne des InEK-Standortverzeichnisses."
Context: HealthcareService
* insert Meta
* value[x] only boolean
* valueBoolean 1.. MS

Extension: KhvzVersionEx
Id: KhvzVersionEx
Title: "KHVZ Version Extension"
Description: "Versionsnummer eines KHVZ-HealthcareService (Standortdaten) gemäß InEK-Standortverzeichnis."
Context: HealthcareService
* insert Meta
* value[x] only integer
* valueInteger 1.. MS

Extension: KhvzVersorgungsmerkmaleEx
Id: KhvzVersorgungsmerkmaleEx
Title: "KHVZ Versorgungsmerkmale Extension"
Description: "Versorgungsmerkmale einer KHVZ-Einrichtung: PSY (Psychiatrie/Psychosomatik) und DRG."
Context: HealthcareService
* insert Meta
* extension contains
    psy 0..1 MS and
    drg 0..1 MS
* extension[psy]
  * value[x] only boolean
  * valueBoolean 1.. MS
* extension[drg]
  * value[x] only boolean
  * valueBoolean 1.. MS

Extension: KhvzTraegerEx
Id: KhvzTraegerEx
Title: "KHVZ Träger Extension"
Description: "Träger- und Rechtsformangaben einer KHVZ-Einrichtung: Träger, Trägerart, Rechtsform, Sitz der Gesellschaft, Registergericht und Registernummer."
Context: HealthcareService
* insert Meta
* extension contains
    traeger 0..1 MS and
    traegerart 0..1 MS and
    rechtsform 0..1 MS and
    sitzGesellschaft 0..1 MS and
    registergericht 0..1 MS and
    registernummer 0..1 MS
* extension[traeger]
  * value[x] only string
  * valueString 1.. MS
* extension[traegerart]
  * value[x] only Coding
  * valueCoding obeys CodingSytemCodeInv
  * valueCoding 1.. MS
  * valueCoding from InEKTraegerartenVS
* extension[rechtsform]
  * value[x] only Coding
  * valueCoding obeys CodingSytemCodeInv
  * valueCoding 1.. MS
  * valueCoding from InEKRechtsformenVS
* extension[sitzGesellschaft]
  * value[x] only string
  * valueString 1.. MS
* extension[registergericht]
  * value[x] only string
  * valueString 1.. MS
* extension[registernummer]
  * value[x] only string
  * valueString 1.. MS

Extension: KhvzKvBezirkEx
Id: KhvzKvBezirkEx
Title: "KHVZ KV-Bezirk Extension"
Description: "KV-Bezirk eines KHVZ-Standorts gemäß InEK-Standortverzeichnis."
Context: Location
* insert Meta
* value[x] only Coding
* valueCoding obeys CodingSytemCodeInv
* valueCoding 1.. MS
* valueCoding from InEKKVBezirkeVS

Extension: KhvzAdresstypEx
Id: KhvzAdresstypEx
Title: "KHVZ Adresstyp Extension"
Description: "Adresstyp (Gebäude/Fläche) einer KHVZ-Standortadresse gemäß InEK-Standortverzeichnis."
Context: Address
* insert Meta
* value[x] only Coding
* valueCoding obeys CodingSytemCodeInv
* valueCoding 1.. MS
* valueCoding from InEKAdresstypenVS

Extension: KhvzPostadresseEx
Id: KhvzPostadresseEx
Title: "KHVZ Postadresse Extension"
Description: "Separate Postadresse eines KHVZ-Standorts. In FHIR R4 erlaubt Location nur eine native address; die abweichende Postanschrift (PostAdresse aus dem InEK-Standortverzeichnis) wird daher als zusätzliche Adresse hier abgelegt (type = #postal)."
Context: Location
* insert Meta
* value[x] only Address
* valueAddress 1.. MS