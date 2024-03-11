# Changelog

## 2024-03-10 - Version 0.11.0

### EndpointDirectory
- EndpointVisibility Extension hinzugefügt

### LocationDirectory
- address muss AddressDeBasis entsprechen
- partOf `MS`
- managingOrganization `MS`

### HealthcareServiceDirectory
- category `MS` & binding an: IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare
- type `MS` binding auf HealthcareServiceTypeVS (HealthcareServiceTypeVS enthält jetzt die Codes zuvor in HealthcareServiceSpecialtyVS enthalten waren)
- speciality binding auf neues VS: HealthcareServiceSpecialityVS
- characteristics `MS` & binding an: HealthCareServiceCharacteristicVS

### OrganizationDirectory
- OrganizationVisibility Extension hinzugefügt
- identifier slicing umgestellt auf `#pattern, $this`
- identifier[TelematikID] hinzugefügt
- identifier[AlternativeTelematikID] hinzugefügt
- type OrganizationTypeVS aufgeteilt in zwei ValueSets & Slices: type[providerType] & type[profession]
- address `MS`
- address `MS`
- address muss AddressDeBasis entsprechen
- partOf `MS`

### PractitionerDirectory
- identifier[TelematikID] maximal Kardinalität auf `1` reduziert
- name muss HumannameDeBasis entsprechen

### Breaking Changes aufgrund von compliance zu dt. Basisprofilen
- Stadteile werden über die Extension http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-precinct abgebildet, district sind in den dt. Basisprofilen auf 0..0 constrained
- Bundesland wird in dt. Basisprofilen mittels: https://simplifier.net/basisprofil-de-r4/codesystemiso31662de kodiert