# Changelog

## 2024-09-20 - Version 0.11.15
- fix: version 0.11.14 didn't include dependencies

## 2024-09-20 - Version 0.11.14
- fix: slicing discriminator type meta.tag. Was 'value', now: 'pattern'

## 2024-07-26 - Version 0.11.13
- feat: added Synchronized from ApoVZD as concept to `https://gematik.de/fhir/directory/CodeSystem/Origin`

## 2024-07-26 - Version 0.11.12
- fix: version 0.11.11 didn't include dependencies

## 2024-07-26 - Version 0.11.11
- feat: added PharmacyTypeLDAPCS which represents the pharmacy type codes in the ldap-VZD
- fix: changed display of PharmacyHealthcareSpecialtyCS#50 from `Zytostatikaherstellung` to `Sterilherstellung`

## 2024-07-22 - Version 0.11.10
- feat: added DataAbsentReason#not-applicable "Not Applicable" to the VS-Binding of EndpointDirectory.payloadType

## 2024-07-19 - Version 0.11.9
- fix: EndpointDirectory.managingOrganization: removed MS
- feat: HealthcareServiceDirectoryDirectory.characteristic is now sliced into technical & physicalFeatures characteristics
- feat: HealthcareServiceDirectory.characteristic physicalFeatures characteristics added
- feat: HealthcareServiceDirectory.characteristic[technical] supports "Apotheken-Anfrage"
- feat: HealthcareServiceDirectory.location cardinality set to ..1
- feat: EndpointDirectoryConnectionType removed generic concept `erp-supported` and added the specific concepts `eRP-onPremise`, `eRP-delivery` , `eRP-shipment`
- feat: added HealthcareServiceSpecialtyCS used on HealthcareServiceDirectory.specialty
- feat: added SpecialOpeningTimesEX Extension to capture special opening periods (e.g. "Notdienst") used on `HealthcareServiceDirectory.availableTime`
- feat: added PhysicalFeaturesAdditionalNoteEX to capture additional free text info of `HealthcareServiceDirectory.characteristic` (e.g. description where the parking space is located)
- fix: removed MS from LocationDirectory.hoursOfOperation & availabilityExceptions , opening hours are captured in the HealthcareServiceDirectory
- fix: removed `apo-ident` from PharmacyHealthcareSpecialtyCS
- feat: added VZDHealthCareServiceCharacteristicsCS used on `HealthcareServiceDirectory.characteristic[technicalCharacteristic]`
- feat: added PhysicalFeaturesHealthCareServiceVS
- fix: removed irrelevant information from examples
- feat: added a complete pharmacy example

## 2024-05-30 - Version 0.11.8
- feat: dependency basisprofile updated to 1.5.0 (no changes introduced by this update)

## 2024-05-30 - Version 0.11.7
- feat: dependency basisprofile updated to 1.5.0-ballot2 
- feat: added support for Apotheken Ident Verfahren
  - added concept "Apotheken Ident Verfahren" to EndpointDirectoryConnectionType CodeSystem
  - added concept "Apotheken Ident Verfahren" to PharmacyHealthcareSpecialtyCS
- feat: added Extension https://gematik.de/fhir/directory/StructureDefinition/ServiceCoverageArea for capturing the ServiceArea of a pharmacy in meter 

## 2024-05-07 - Version 0.11.6

- fix: HealthcareServiceDirectory.identifier Kardinalität optional -> 0..1

## 2024-04-30 - Version 0.11.5

- fix: HealthcareServiceDirectory.identifier[TelematikId] optional -> 0..1

## 2024-04-22 - Version 0.11.3

- feat: added "Heimversorgende Apotheke", "Versandapotheke" & "Sterilherstellung" to PharmacyTypeCS
- feat: added TelematikId identifier slice to HealthcareServiceDirectory
- fix: renamed PharmacyHealthcareSpecialityCS and HealthcareServiceSpecialityVS to PharmacyHealthcareSpecialtyCS and HealthcareServiceSpecialtyVS

## 2024-03-16 - Version 0.11.2 & 0.11.1

- fix: dependency basisprofile auf stable version: 1.4.0 (war 1.5.0-ballot)
- fix: id MS auf allen Profilen

### PractitionerRoleDirectory
- feat: healthcareService & Organization MS

### Extensions
- fix EndpointVisibility.context war falsch gesetzt, jetzt korrekt (Organization -> Enpoint)

## 2024-03-16 - Version 0.11.0

### EndpointDirectory
- EndpointVisibility Extension hinzugefügt

### Extensions
- OrganizationVisibility hinzugefügt
- EndpointVisibility hinzugefügt

### LocationDirectory
- partOf `MS`
- managingOrganization `MS`

### HealthcareServiceDirectory
- category `MS` & binding an: IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare
- type `MS` binding auf HealthcareServiceTypeVS (HealthcareServiceTypeVS enthält jetzt die Codes zuvor in HealthcareServiceSpecialtyVS enthalten waren)
- speciality binding auf neues VS: HealthcareServiceSpecialityVS
- characteristics `MS` & binding an: HealthCareServiceCharacteristicVS

### OrganizationDirectory
- OrganizationVisibility Extension hinzugefügt
- type OrganizationTypeVS aufgeteilt in zwei ValueSets & Slices: type[providerType] & type[profession], dient nur der besseren Sichtbarkeit, keine Auswirkungen auf Dateninstanzen
- address `MS`
- partOf `MS`

### PractitionerDirectory
- identifier[TelematikID] maximal Kardinalität auf `1` reduziert 

### Terminology
#### ValueSets
- HealthcareServiceSpecialtyVS entfernt, Konzepte jetzt in: HealthcareServiceTypeVS enthalten
- OrganizationTypeVS enthält nicht mehr: OrganizationProfessionOID (wurde in VS OrganizationProfessionOIDTypeVS ausgelagert, kein Einfluss auf Dateninstanzen)
- Neu: HealthcareServiceSpecialityVS
- Neu: HealthcareServiceTypeVS (enthält die Konzepte aus dem entfernten VS: HealthcareServiceSpecialtyVS)
- Neu: IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare
- Neu: HealthCareServiceCharacteristicVS
- Neu: OrganizationProfessionOIDTypeVS
- Entfernt: PharmacyHealthcareServiceTypeVS (wurde nicht in Profilen genutzt)
- Entfernt: PharmacyTypeVS (wurde nicht in Profilen genutzt)

#### CodeSystems
- PharmacyHealthcareServiceTypeCS umbenannt: PharmacyHealthcareSpecialityCS (wurde nicht in Profilen genutzt)
- EndpointDirectoryConnectionType Liste der Konzepte angepasst
- PharmacyTypeCS Liste der Konzepte angepasst (wurde nicht in Profilen genutzt)