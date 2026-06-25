// CodeSystems
// CodeSystems HL7:
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $ContactEntityTypeCS = http://terminology.hl7.org/CodeSystem/contactentity-type
Alias: $ContactPointSystemCS = http://hl7.org/fhir/contact-point-system
Alias: $HL7EndpointConnectionType = http://terminology.hl7.org/CodeSystem/endpoint-connection-type
Alias: $ContactEntityType = http://terminology.hl7.org/CodeSystem/contactentity-type
Alias: $DaysOfWeek = http://hl7.org/fhir/days-of-week
Alias: $ContactPointSystem = http://hl7.org/fhir/contact-point-system
Alias: $ContactPointUse = http://hl7.org/fhir/contact-point-use

// CodeSytems External:
Alias: $UCUM = http://unitsofmeasure.org
Alias: $loinc = http://loinc.org
Alias: $sct = http://snomed.info/sct
Alias: $CommonLanguages = urn:ietf:bcp:47

// ValueSets
// ValueSets HL7:
Alias: $ContactEntityTypeVS = http://terminology.hl7.org/ValueSet/contactentity-type
// ValueSets IHE:
Alias: $IHEXDSauthorSpeciality = http://ihe-d.de/ValueSets/IHEXDSauthorSpeciality
Alias: $IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare = http://ihe-d.de/ValueSets/IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare

//Extensions
//Extensions hapi specific:
Alias: $refChainEx = https://smilecdr.com/fhir/ns/StructureDefinition/searchparameter-uplift-refchain
//Extensions R5->R4 Cross-Version (aus hl7.fhir.uv.xver-r5.r4):
Alias: $offeredIn = http://hl7.org/fhir/5.0/StructureDefinition/extension-HealthcareService.offeredIn

// CodeSystems / ValueSets (etabliert)
Alias: $Fachabteilungsschluessel = http://fhir.de/CodeSystem/dkgev/Fachabteilungsschluessel
Alias: $FachabteilungsschluesselVS = http://fhir.de/ValueSet/dkgev/Fachabteilungsschluessel

// Identifiers
// TelematikID
Alias: $IdentifierTelematikID = http://fhir.de/StructureDefinition/identifier-telematik-id

// FADId (Fachdienst-ID)
Alias: $IdentifierFAD = https://gematik.de/fhir/sid/fachdienst-id

// BSNR (etabliert, deutsche Basisprofile)
Alias: $bsnr = http://fhir.de/sid/bsnr

// KHVZ-Identifier (Platzhalter - InEK-Absprache ausstehend)
Alias: $sidStandortId = https://gematik.de/fhir/directory/sid/standort-id
Alias: $sidInekErId = https://gematik.de/fhir/directory/sid/inek-er-id