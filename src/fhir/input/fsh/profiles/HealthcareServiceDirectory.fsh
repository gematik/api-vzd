Profile: HealthcareServiceDirectory
Parent: HealthcareService
Title: "HealthcareService in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* extension contains HolderIdEx named holderId 0..* MS
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag obeys CodingSytemCodeInv
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
  * coding obeys CodingSytemCodeInv
* category from HealthcareServiceCategoryCodes
* type MS
  * coding obeys CodingSytemCodeInv 
* type from HealthcareServiceTypeVS
* specialty MS
  * coding obeys CodingSytemCodeInv
* specialty from HealthcareServiceSpecialtyVS
* location ..1 MS
* name MS
* telecom MS
  * system MS
  * value MS
  * use MS
* communication MS
  * coding obeys CodingSytemCodeInv
* appointmentRequired MS
* availableTime MS
  * obeys VZD-Service-Opening-TimeInv-1
  * obeys VZD-Service-Opening-TimeInv-2
  * extension contains SpecialOpeningTimesEX named specialOpeningTimes 0..1 MS
  * daysOfWeek ..1 MS
  * allDay ..0
  * availableStartTime MS
  * availableEndTime MS
* notAvailable MS
  * description MS
  * during MS
* availabilityExceptions MS
* endpoint MS
* characteristic MS
  * coding obeys CodingSytemCodeInv
  * ^short = "Physical Features & Technical Services"
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* characteristic contains
    technicalCharacteristic 0..* MS and
    physicalFeatures 0..* MS
* characteristic[technicalCharacteristic] from HealthCareServiceTechnicalCharacteristicVS
  * ^short = "Technical Services"
* characteristic[physicalFeatures] from PhysicalFeaturesHealthCareServiceVS
  * extension contains PhysicalFeaturesAdditionalNoteEX named additionalNote 0..1 MS
//  * ^patternCodeableConcept.coding.system = Canonical(PhysicalFeaturesHealthCareServiceCS)
  * ^short = "Physical Features"
* coverageArea MS
  * extension MS 
  * extension contains 
    ServiceCoverageArea named serviceCoverageArea ..1 MS and
    ServiceCoveragePostalCode named serviceCoveragePostalCode ..* MS

Profile: HealthcareServiceDirectoryStrict
Parent: HealthcareServiceDirectory
Id: HealthcareServiceDirectoryStrict
Title: "HealthcareServiceDirectoryStrict"
Description: "HealthcareService in gematik Directory with strict constraints"
* insert Meta
* meta.tag only CodingWithCodeAndSystem
* meta.tag
  * ^slicing.rules = #closed
* identifier 
  ^slicing.rules = #closed
* active 0..0
* category.coding only CodingWithCodeAndSystem
* type.coding only CodingWithCodeAndSystem
* specialty.coding only CodingWithCodeAndSystem
* comment 0..0
* extraDetails 0..0
* photo 0..0
* telecom
  * rank 0..0
  * period 0..0
* coverageArea
  * reference 0..0
  * type 0..0
  * identifier 0..0
  * display 0..0
* serviceProvisionCode 0..0
* eligibility 0..0 
* program 0..0
* communication.coding only CodingWithCodeAndSystem
* characteristic
  * ^slicing.rules = #closed
  * coding only CodingWithCodeAndSystem
* referralMethod 0..0
* availableTime 
  * extension[specialOpeningTimes]
    * extension[qualifier].valueCoding only CodingWithCodeAndSystem
