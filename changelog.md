# Changelog

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