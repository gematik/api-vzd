Profile: HealthcareServiceDirectory
Parent: HealthcareService
Title: "HealthcareService in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id MS
* identifier 0..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains TelematikID 0..1 MS
* identifier[TelematikID] only $IdentifierTelematikID
* providedBy 1..1 MS
* category MS 
* category from $IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare
* type MS 
* type from HealthcareServiceTypeVS (extensible)
* specialty MS
* specialty from HealthcareServiceSpecialtyVS
* location ..1 MS
* name MS
* telecom MS
  * system MS
  * value MS
  * use MS
* communication MS
* appointmentRequired MS
* availableTime MS
  * extension contains SpecialOpeningTimesEX named specialOpeningTimes 0..1 MS
* notAvailable MS
* availabilityExceptions MS
* endpoint MS
* characteristic MS
  * ^short = "Physical Features & Technical Services"
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* characteristic contains
    technicalCharacteristic 0..* MS and
    physicalFeatures 0..* MS
* characteristic[technicalCharacteristic] from HealthCareServiceTechnicalCharacteristicVS
  * ^short = "Technical Services"
* characteristic[physicalFeatures] from PhysicalFeaturesHealthCareServiceVS (extensible)
  * extension contains PhysicalFeaturesAdditionalNoteEX named additionalNote 0..1 MS
  * ^patternCodeableConcept.coding.system = Canonical(PhysicalFeaturesHealthCareServiceCS)
  * ^short = "Physical Features"
* coverageArea MS
  * extension MS 
  * extension contains 
    ServiceCoverageArea named serviceCoverageArea ..1 MS and
    ServiceCoveragePostalCode named serviceCoveragePostalCode ..* MS