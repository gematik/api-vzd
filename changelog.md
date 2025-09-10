# Changelog

## tbd Version 1.0.0
- `feat`: introduced dependencies to de.gematik.terminology & de.gematik.ti in order to align gematik IGs

## 2025-08-25 Version 0.11.26 (feat for 0.11.25 only)
- `feat`: relaxed binding of qualification.code on PractitionerDirectory to extensible, allowing the validation of any code as the current existing data instances are not compliant to the strict binding. This is a temporary solution until the data instances are migrated to the new codes and won't be changed in the current and more recent releases.

## 2025-07-17 Version 0.16.0
- `feat`: Added fdv-relevant tag to Organisation resources and introduced the ResourceTag CodeSystem for all non-origin meta.tag values.
- `change`: updated de.basisprofil.r4 dependency to 1.5.4 which is fully compatible for the VZD

## 2025-07-17 Version 0.15.0
- `change`: the new specialty codes from PharmacyHealthcareSpecialtyCS are now containg the definitons as part of the display value. e.g.: "Bluthochdruck" "Standardisierte Risikoerfassung bei Bluthochdruck" -> "Bluthochdruck: Standardisierte Risikoerfassung bei Bluthochdruck"
- `change`: the VS http://ihe-d.de/ValueSets/IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare was removed from the HealthcareServiceCategoryCodes as they are not used or needed for the VZD.

### data migration
- update display values in HealthcareService instances for PharmacyHealthcareSpecialtyCS codes: 60, 70, 80, 90, 100
  
## 2025-05-22 Version 0.14.0
- `change`: removed `erx-token-receiver`from VZDHealthCareServiceCharacteristicsCS. This code was not used in the VZD and was removed.
- `feat`: added new specialty codes to PharmacyHealthcareSpecialtyCS:
  - #60 "Bluthochdruck" "Standardisierte Risikoerfassung bei Bluthochdruck"
  - #70 "Inhalativa" "Üben der Inhalationstechnik"
  - #80 "Polymedikation" "Erweiterte Medikationsberatung bei Polymedikation"
  - #90 "Orale Krebstherapie" "Betreuung bei Einnahme von Krebsmedikamenten"
  - #100 "Organtransplantation" "Beratung nach Organtransplantation" PharmacyHealthcareSpecialtyCS

## 2025-05-06 Version 0.13.1
- `change`: applied the CodingSytemCodeInv directly to .type slices instead of .type to avoid Snapshotting issues in some environments.

## 2025-04-17 Version 0.13.0
- `change`: removed KBV_CS_SFHIR_BAR2_WBO_OID_URL (urn:oid:1.2.276.0.76.5.114) as these were replaced by IHE codes several years ago. 
- `change`: removed KBV_CS_SFHIR_BAR2_WBO_OID_URL (urn:oid:1.2.276.0.76.5.114) from PractitionerQualificationVS
- `fix`: set VS binding on correct element for Endpoint.connectionType. Was on code, but should be on connectionType(Coding)
- `fix`: changed OwnerTelematikIdSP base from Ressource to explicit resource types, enables the usage in hapi-fhir-server
- `feat`: added holderId Extension to PractitionerRoleDirectory and HealthcareServiceDirectory to represent the holderId.
- `feat`: added OwnerTelematikIdEx Extension
- `feat`: added OwnerTelematikIdEx to HealthcareServiceDirectory, PractitionerRoleDirectory and HealthcareServiceDirectory with 0..* cardinality
- `feat`: added SearchParameter HolderIdSP to enable search for holderIds
- `feat`: added SearchParameter OwnerTelematikIdSP to enable search for owners TelematikId
- `feat`: split VZD-Service-Opening-TimeInv in two Invariants to report better validation errors to implementers
- `change`: moved .telecom from Practitioner to PractitionerRole
- `change`: removed communication and appointmentRequired from examples, as these are currently not used
- `change`: remove deprecated codes from VZDHealthCareServiceCharacteristicsCS
- `change`: update PractitionerDirectory to change cardinality of 'given' field from 1..* to 0..* 

### data migration
- copy .telecom from Practitioner to PractitionerRole(s), remove .telecom on Practitioner

## 2025-02-27 Version 0.12.0
- `feat`: using SemVer for release versions
- `change`: new concepts added to: OrganizationProfessionOID
- `change`: new concepts added to: PractitionerProfessionOID
- `change`: display values of some PractitionerProfessionOID concepts were changed

### data migration
- new Concepts OrganizationProfessionOID:
  - 1.2.276.0.76.4.311 "Betriebsstätte Hilfsmittelerbringer (Hinweis: Betriebsstätten der Hilfsmittelerbringer, welche nicht den Gesundheitshandwerken zugeordnet sind)"
  - 1.2.276.0.76.4.314 "Betriebsstätte Frisör"
  - 1.2.276.0.76.4.317 "Betriebsstätte Soziotherapie" 
- new Concepts PractitionerProfessionOID:
  - 1.2.276.0.76.4.312 "Hilfsmittelerbringer/-in (Hinweis: Berufsgruppen der Hilfsmittelerbringer/-innen, die nicht den Gesundheitshandwerken zugeordnet sind)"
  - 1.2.276.0.76.4.313 "Frisör/-in"
  - 1.2.276.0.76.4.316 "Leistungserbringer/-in Soziotherapie"
  - 1.2.276.0.76.4.318 "Leistungserbringer/in Stimm-, Sprech-, Sprach- und Schluck-Therapie"
  - 1.2.276.0.76.4.315 "Masseur/-in und medizinische/-r Bademeister/-in"
  - 1.2.276.0.76.4.319 "Diätassistent/-in"
- changed display values in PractitionerProfessionOID:
  - 1.2.276.0.76.4.237 "Augenoptiker/-in"
  - 1.2.276.0.76.4.277 "Leistungserbringer/-in Ernährungstherapie"
  - 1.2.276.0.76.4.308 "Augenoptiker/-in und Hörakustiker/-in"

## 2025-02-06 Version 0.11.25
- `fix`: CodeSystem: AerztlicheBerufsvarianten contained codes with a wrong prefix of `#`, these prefixes were removed.
- `feat`: added ResultsFilteredEx Extension to represent how many results where filtered together with the reason of the filtering.

### data migration
- remove `#`from code instances of the CodeSystem: `urn:oid:1.2.276.0.76.5.493` used on `Practitoner.qualification`

## 2025-01-10  Version 0.11.24
- `fix`: relaxed cardinality of OrganizationDirectory.identifier[IKNR] from 0..1 -> 0..* allowing multiple IKNR for an Organization
- removed: PractitionerDirectory.identifier[ZANR]  as it is not required.
- `fix`: `breaking` Updated Contents of external IHE & KBV CodeSystems
- `fix`: `breaking` OrganizationVisibilityCS: renamed #hide-erezeptApp "Eintrag nicht in eRezeptApp darstellen" to #hide-versicherte "Eintrag für Versicherte verbergen"
- `fix`: changed status to active for CodeSystems:
  - AerztlicheBerufsvarianten
  - AerztlicheFachrichtungen_OID_URL
  - FacharzttitelDerAerztekammern_OID_URL
  - KBV_CS_SFHIR_BAR2_WBO_OID_URL
  - NichtAerztlicheFachrichtungen_OID_URL
  - QualifikationenNichtAerztlicherAutoren_OID_URL
  - QualifikatorenZahnaerztlicherAutoren_OID_URL
  - ZahnaerztlicheFachrichtungen_OID_URL
- `fix`: changed status to active for Valusets:
  - HealthcareServiceCategoryCodes
  - NCPeHHealthcareServiceSpecialityVS
- `fix`: changed status to active for Profiles:
  - CodingWithCodeAndSystem
  - EndpointDirectoryStrict
  - HealthcareServiceDirectoryStrict
  - LocationDirectoryStrict
  - OrganizationDirectoryStrict
  - PractitionerDirectoryStrict
  - PractitionerRoleDirectoryStrict
- `fix`: changed status to active for SearchParameter:
  - PractitionerRole-endpoint

### data migration
- CodeSystem: OrganizationVisibilityCS (https://gematik.de/fhir/directory/CodeSystem/OrganizationVisibilityCS)
  - #hide-erezeptApp "Eintrag nicht in eRezeptApp darstellen" was changed to #hide-versicherte "Eintrag für Versicherte verbergen"
- CodeSystem: KBV_CS_SFHIR_BAR2_WBO Fachgruppen (urn:oid:1.2.276.0.76.5.114)
  - removed: 
    - 091 "SP Kinderkardiologie"
    - 196 "SP Kinderradiologie"
    - 304 "FA Kinderchirurgie"
    - 518 "FA Sprach-, Stimm- und kindliche Hörstörungen"
    - 530 "SP Kinder-Hämatologie und -Onkologie"
    - 542 "FA Plastische und Ästhetische Chirurgie"
    - 544 "FA Allgemeinchirurgie"
  - new:
    - 144 "Psychotherapeutisch tätige Ärztin/Psychotherapeutisch tätiger Arzt (Zusatzbezeichnung)"
    - 305 "Medizinische Genetik"
    - 306 "Medizinische Informatik"
    - 307 "Pathologische Physiologie"
    - 317 "Physiologische Chemie"
    - 350 "Biomathematik"
    - 351 "Biophysik"
    - 352 "Geschichte der Medizin"
    - 353 "Industrietoxikologie"
    - 354 "Klinische Strahlenphysik"
    - 355 "Medizinische Wissenschaftsinformation"
    - 356 "Medizinische Physik und Biophysik"
    - 358 "Fachbiologie der Medizin"
    - 371 "Fachwissenschaftlerin/Fachwissenschaftler Chemie und Labordiagnostik"
    - 372 "Fachwissenschaftlerin/Fachwissenschaftler Genetik"
    - 373 "Fachwissenschaftlerin/Fachwissenschaftler Immunologie"
    - 374 "Fachwissenschaftlerin/Fachwissenschaftler Zytologie/Histologie"
    - 470 "Psychologische Psychotherapeutin/Psychologischer Psychotherapeut"
    - 471 "Kinder- und Jugendlichenpsychotherapeutin/Kinder- und Jugendlichenpsychotherapeut"
    - 474 "Fachpsychotherapeutin/Fachpsychotherapeut für Erwachsene"
    - 475 "Fachpsychotherapeutin/Fachpsychotherapeut für Kinder und Jugendliche"
    - 476 "Fachpsychotherapeutin/Fachpsychotherapeut für Neuropsychologische Psychotherapie"
    - 573 "FÄ/FA Kinder -und Jugendchirurgie"
    - 574 "FÄ/FA Plastische, Rekonstruktive und Ästhetische Chirurgie"
    - 575 "FÄ/FA Phoniatrie und Pädaudiologie ((M-)WBO 2018)"
    - 576 "SP Kinder- und Jugend-Hämatologie und -Onkologie"
    - 577 "SP Kinder- und Jugend-Kardiologie"
    - 578 "SP Kinder- und Jugendradiologie"
    - 579 "FÄ/FA Innere Medizin und Infektiologie ((M-)WBO 2018)"
  - changed display values (listing the new display values):
    - 010 "FÄ/FA Allgemeinmedizin (alte (M-)WBO, kammerindividuell, EU-Ärzte)"
    - 020 "FÄ/FA Anästhesiologie"
    - 030 "FÄ/FA Augenheilkunde"
    - 050 "FÄ/FA Frauenheilkunde und Geburtshilfe"
    - 060 "FÄ/FA Hals-, Nasen-, Ohrenheilkunde"
    - 070 "FÄ/FA Haut- und Geschlechtskrankheiten"
    - 080 "FÄ/FA Innere Medizin" 
    - 102 "FÄ/FA Kinder- und Jugendpsychiatrie und -psychotherapie"
    - 110 "FÄ/FA Laboratoriumsmedizin"
    - 130 "FÄ/FA Mund-Kiefer-Gesichtschirurgie"
    - 142 "FÄ/FA Neurologie"
    - 200 "FÄ/FA Urologie"
    - 210 "FÄ/FA Arbeitsmedizin"
    - 220 "FÄ/FA Nuklearmedizin"
    - 230 "FÄ/FA Öffentliches Gesundheitswesen"
    - 240 "FÄ/FA Rechtsmedizin"
    - 250 "FÄ/FA Hygiene und Umweltmedizin"
    - 271 "FÄ/FA Neuropathologie"
    - 281 "FÄ/FA Klinische Pharmakologie"
    - 291 "FÄ/FA Strahlentherapie"
    - 301 "FÄ/FA Anatomie"
    - 302 "FÄ/FA Biochemie"
    - 303 "FÄ/FA Transfusionsmedizin"
    - 308 "FÄ/FA Physiologie"
    - 313 "FÄ/FA Herzchirurgie"
    - 314 "FÄ/FA Humangenetik"
    - 330 "FÄ/FA Physikalische und Rehabilitative Medizin"
    - 341 "FÄ/FA Kinder- und Jugendmedizin"
    - 359 "Fachzahnärztin/Fachzahnarzt für Mikrobiologie"
    - 360 "Fachzahnärztin/Fachzahnarzt für Kieferchirurgie (§ 6 Abs. 1 BMV-Ä)"
    - 361 "Fachzahnärztin/Fachzahnarzt für theoretisch-experimentelle Medizin (§ 6 Abs. 2 BMV-Ä)"
    - 511 "FÄ/FA Gefäßchirurgie"
    - 512 "FÄ/FA Orthopädie und Unfallchirurgie"
    - 513 "FÄ/FA Thoraxchirurgie"
    - 514 "FÄ/FA Visceralchirurgie/FÄ/FA Viszeralchirurgie"
    - 521 "FÄ/FA Innere Medizin und (SP) Angiologie"
    - 522 "FÄ/FA Innere Medizin und (SP) Endokrinologie und Diabetologie"
    - 523 "FÄ/FA Innere Medizin und (SP) Gastroenterologie"
    - 524 "FÄ/FA Innere Medizin und (SP) Hämatologie und Onkologie"
    - 525 "FÄ/FA Innere Medizin und (SP) Kardiologie"
    - 526 "FÄ/FA Innere Medizin und (SP) Nephrologie"
    - 527 "FÄ/FA Innere Medizin und (SP) Pneumologie"
    - 528 "FÄ/FA Innere Medizin und (SP) Rheumatologie"
    - 532 "FÄ/FA Mikrobiologie, Virologie und Infektionsepidemiologie"
    - 534 "FÄ/FA Psychosomatische Medizin und Psychotherapie"
    - 535 "FÄ/FA Radiologie (neue (M-)WBO)"
- CodeSystem: QualifikationenNichtAerztlicherAutoren_OID_URL (urn:oid:1.3.6.1.4.1.19376.3.276.1.5.11)
  - removed:
    - 5 "Tiermedizinischer Fachangestellter"
    - 93 "Medizinische Datenerhebung"
    - 142 "Veterinärmedizinischer-technischer Assistent"
    - 158 "Medien, Kultur, Gestaltung, Kunst (außer Pädagogen)"
    - 159 "Schutz und Sicherheit"
    - 162 "Verfahrens- und Produktentwicklung, technisches Zeichnen, Konstruktion"
    - 163 "Sprachen"
    - 164 "Produktion, Produktionsplanung, Produktionssteuerung, Instandhaltung"
    - 166 "Reinigung"
    - 167 "Bau, Architektur, Rohstoffe"
    - 168 "Verwaltungsberufe (außer medizinische), kaufmännische Berufe, Verkehr"
    - 170 "Elektro, Energie, Ver- und Entsorgung"
    - 171 "Gastgewerbe und Tourismus, Veranstaltungsmanagement und Hauswirtschaft"
    - 172 "IT"
  - new:
    - 175 "Fachgesundheits- und krankenpfleger für Intensivpflege und Anästhesie"
    - 176 "Fachgesundheits- und krankenpfleger im Operations-/Endoskopiedienst"
    - 177 "Fachgesundheits- und krankenpfleger für Hygiene"
    - 178 "Fachgesundheits- und krankenpfleger für Palliativ- und Hospizpflege"
    - 186 "Pflegefachmann/Pflegefachfrau"
    - 187 "Fachgesundheits- und krankenpfleger für Onkologie"
    - 188 "Fachgesundheits- und krankenpfleger für Psychiatrie"
  - changed display values (listing the new display values):
    - 24 "Assistenten für Gesundheitstourismus,  -prophylaxe"
    - 76 "Kinder- und Jugendlichenpsychotherapeut"
    - 184 "Fachpsychotherapeut für Kinder und Jugendliche"
    - 185 "Fachpsychotherapeut für Erwachsene" 
- CodeSystem QualifikatorenZahnaerztlicherAutoren_OID_URL (urn:oid:1.2.276.0.76.5.492):
  - changed display values (listing the new display values):
    -1 "Zahnarzt"


## 2025-01-10  Version 0.11.23
- `feat`: added Invariant `CodingSytemCodeInv` throwing a warning if a Coding element is missing system or code. Added to:
  - EndpointDirectory.meta.tag
  - EndpointDirectory.connectionType
  - EndpointDirectory.payloadType.coding
  - OrganizationVisibility.valueCoding
  - EndpointVisibility.valueCoding
  - SpecialOpeningTimesEX.extension[qualifier].valueCoding
  - NCPeHCountryEx.valueCoding
  - HealthcareServiceDirectory.meta.tag
  - HealthcareServiceDirectory.category.coding
  - HealthcareServiceDirectory.type.coding
  - HealthcareServiceDirectory.specialty.coding
  - HealthcareServiceDirectory.communication.coding
  - HealthcareServiceDirectory.characteristic.coding
  - LocationDirectory.meta.tag
  - OrganizationDirectory.meta.tag
  - OrganizationDirectory.type.coding
  - PractitionerDirectory.meta.tag
  - PractitionerDirectory.qualification.code.coding
  - PractitionerDirectory.communication.coding
  - PractitionerRoleDirectory.meta.tag
- `feat`: added a data type profile `CodingWithCodeAndSystem` setting .code and .system to a min cardinality of 1. Applied in the derived strict profiles at the same elements as the `CodingSytemCodeInv` invariant.
- `fix`: added SearchParameters with Uplifted-Refchains extension for hapi fhir servers (was not included in 0.11.22 due to a technical issue)
- `fix`: added strict profiles: These profiles are derived from the VZD-profiles, are restricted non-MS elements to 0..0, add closed slicing. Purpose technical validation for VZD implementations (was not included in 0.11.22 due to a technical issue)
- `fix`: Extensions: OrganizationVisibility & EndpointVisibility had a required binding on Extension.value[x] which implies a min cardinality of 1. valueCoding is now set to 1.. explicitly.
- `feat`: upgraded dependency de.basisprofil.r4 to version 1.5.1. This has no direct impact on the vzd.

### data migration
- none

## 2024-12-20  Version 0.11.22  

- `feat`: added SearchParameter for NCPeHCountryEx: OrganizationNCPeHCountrySP
- `feat`: added SearchParameter for Organization.alias: OrganizationAliasSP
- `feat`: added strict profiles: These profiles are derived from the VZD-profiles, are restricted non-MS elements to 0..0, add closed slicing. Purpose technical validation for VZD implementations
- `feat`: added SearchParameters with Uplifted-Refchains extension for hapi fhir servers

### data migration
- none

## 2024-12-03 - Version 0.11.21  
- `feat`: restricted all extensible bindings to required:
  - EndpointDirectory.code
  - EndpointDirectory.payloadType
  - HealthcareServiceDirectory.type
  - HealthcareServiceDirectory.characteristic
  - LocationDirectory.state
  - PractitionerDirectory.qualification.code
- `feat`: removed ServiceType from Fhir core from HealthcareServiceSpecialtyVS
  - affects: HealthcareServiceDirectory.speciality
- `feat`: added NCPeHCountryEx to OrganizationDirectory to represent the NCPeH country in a coded form
- `feat`: added CodeSystems for HealthcareServiceTypeVS which weren't included before
- `feat`: added * OrganizationProfessionOID#1.2.276.0.76.4.292 "NCPeH Fachdienst" to HealthcareServiceCategoryCodes ValueSet

### data migration
- check instances if they are using concepts outside of the bound ValueSets:
  - EndpointDirectory.code (NAME!!!)
  - EndpointDirectory.payloadType
  - HealthcareServiceDirectory.type
  - HealthcareServiceDirectory.characteristic
  - LocationDirectory.state
  - PractitionerDirectory.qualification.code
- check instances if they are using concepts from ServiceType on HealthcareServiceDirectory.speciality

## 2024-11-15 - Version 0.11.20
- `fix`: SystemsEngineering:tim.gematik.de Example address is now a matrix uri

## 2024-10-29 - Version 0.11.19
- `fix`: EndpointAddressSP search typ switched from uri -> string due to a hapi issue not beeing able to chain with uri SP

## 2024-10-15 - Version 0.11.18
- `feat`: restrict HealthcareServiceDirectory.availableTime.daysOfWeek to ..1 to enforce a an availableTime per weekday
- `feat`: set HealthcareServiceDirectory.availableTime.allDay to ..0 to simplify implementations, all day can be entered as 0:00 - 23:59
- `feat`: added Invariant: VZD-Service-Opening-Time which only allows the specialOpeningTimes extension on availableTime if the other fields are empty

## 2024-10-11 - Version 0.11.17
- `feat`: added SearchParameter: OrganizationTypeDisplaySP, EndpointAddressSP, OrganizationVisibilitySP, PractitionerQualificationSP, EndpointVisibilitySP, HealthcareServiceCoverageAreaPostalCodeSP
- `feat`: added serviceCoveragePostalCode Extension on HealthcareServiceDirectory.coverageArea
- `feat`: added #eRP-availability "Apotheke Verfügbarkeitsanfrage" to EndpointDirectoryConnectionType

## 2024-09-24 - Version 0.11.16
- `fix`: added missing PhysicalFeaturesHealthCareServiceCS

## 2024-09-20 - Version 0.11.15
- `fix`: version 0.11.14 didn't include dependencies

## 2024-09-20 - Version 0.11.14
- `fix`: slicing discriminator type meta.tag. Was 'value', now: 'pattern'

## 2024-07-26 - Version 0.11.13
- `feat`: added Synchronized from ApoVZD as concept to `https://gematik.de/fhir/directory/CodeSystem/Origin`

## 2024-07-26 - Version 0.11.12
- `fix`: version 0.11.11 didn't include dependencies

## 2024-07-26 - Version 0.11.11
- `feat`: added PharmacyTypeLDAPCS which represents the pharmacy type codes in the ldap-VZD
- `fix`: changed display of PharmacyHealthcareSpecialtyCS#50 from `Zytostatikaherstellung` to `Sterilherstellung`

## 2024-07-22 - Version 0.11.10
- `feat`: added DataAbsentReason#not-applicable "Not Applicable" to the VS-Binding of EndpointDirectory.payloadType

## 2024-07-19 - Version 0.11.9
- `fix`: EndpointDirectory.managingOrganization: removed MS
- `feat`: HealthcareServiceDirectoryDirectory.characteristic is now sliced into technical & physicalFeatures characteristics
- `feat`: HealthcareServiceDirectory.characteristic physicalFeatures characteristics added
- `feat`: HealthcareServiceDirectory.characteristic[technical] supports "Apotheken-Anfrage"
- `feat`: HealthcareServiceDirectory.location cardinality set to ..1
- `feat`: EndpointDirectoryConnectionType removed generic concept `erp-supported` and added the specific concepts `eRP-onPremise`, `eRP-delivery` , `eRP-shipment`
- `feat`: added HealthcareServiceSpecialtyCS used on HealthcareServiceDirectory.specialty
- `feat`: added SpecialOpeningTimesEX Extension to capture special opening periods (e.g. "Notdienst") used on `HealthcareServiceDirectory.availableTime`
- `feat`: added PhysicalFeaturesAdditionalNoteEX to capture additional free text info of `HealthcareServiceDirectory.characteristic` (e.g. description where the parking space is located)
- `fix`: removed MS from LocationDirectory.hoursOfOperation & availabilityExceptions , opening hours are captured in the HealthcareServiceDirectory
- `fix`: removed `apo-ident` from PharmacyHealthcareSpecialtyCS
- `feat`: added VZDHealthCareServiceCharacteristicsCS used on `HealthcareServiceDirectory.characteristic[technicalCharacteristic]`
- `feat`: added PhysicalFeaturesHealthCareServiceVS
- `fix`: removed irrelevant information from examples
- `feat`: added a complete pharmacy example

## 2024-05-30 - Version 0.11.8
- `feat`: dependency basisprofile updated to 1.5.0 (no changes introduced by this update)

## 2024-05-30 - Version 0.11.7
- `feat`: dependency basisprofile updated to 1.5.0-ballot2 
- `feat`: added support for Apotheken Ident Verfahren
  - added concept "Apotheken Ident Verfahren" to EndpointDirectoryConnectionType CodeSystem
  - added concept "Apotheken Ident Verfahren" to PharmacyHealthcareSpecialtyCS
- `feat`: added Extension https://gematik.de/fhir/directory/StructureDefinition/ServiceCoverageArea for capturing the ServiceArea of a pharmacy in meter 

## 2024-05-07 - Version 0.11.6

- `fix`: HealthcareServiceDirectory.identifier Kardinalität optional -> 0..1

## 2024-04-30 - Version 0.11.5

- `fix`: HealthcareServiceDirectory.identifier[TelematikId] optional -> 0..1

## 2024-04-22 - Version 0.11.3

- `feat`: added "Heimversorgende Apotheke", "Versandapotheke" & "Sterilherstellung" to PharmacyTypeCS
- `feat`: added TelematikId identifier slice to HealthcareServiceDirectory
- `fix`: renamed PharmacyHealthcareSpecialityCS and HealthcareServiceSpecialityVS to PharmacyHealthcareSpecialtyCS and HealthcareServiceSpecialtyVS

## 2024-03-16 - Version 0.11.2 & 0.11.1

- `fix`: dependency basisprofile auf stable version: 1.4.0 (war 1.5.0-ballot)
- `fix`: id MS auf allen Profilen

### PractitionerRoleDirectory
- `feat`: healthcareService & Organization MS

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