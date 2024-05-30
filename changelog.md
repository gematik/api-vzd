# Changelog

## 2024-05-30 - Version 0.11.7
- feat: dependency basisprofile updated to 1.5.0-ballot2 
- feat: added support for Apotheken Ident Verfahren
  - added concept "Apotheken Ident Verfahren" to EndpointDirectoryConnectionType CodeSystem
  - added concept "Apotheken Ident Verfahren" to PharmacyHealthcareSpecialtyCS

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