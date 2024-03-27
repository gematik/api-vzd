Profile: HealthcareServiceDirectory
Parent: HealthcareService
Title: "HealthcareService in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #value
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = "https://gematik.de/fhir/directory/CodeSystem/Origin"
* id MS
* providedBy 1..1 MS
* category MS 
* category from $IHEXDShealthcareFacilityTypeCodePatientRelatedHealthcare
* type MS 
* type from HealthcareServiceTypeVS (extensible)
* specialty MS
* specialty from HealthcareServiceSpecialityVS 
* location MS
* name MS
* telecom MS
  * system MS
  * value MS
  * use MS
* serviceProvisionCode MS
* communication MS
* appointmentRequired MS
* availableTime MS
* availabilityExceptions MS
* endpoint MS
* characteristic MS
* characteristic from HealthCareServiceCharacteristicVS