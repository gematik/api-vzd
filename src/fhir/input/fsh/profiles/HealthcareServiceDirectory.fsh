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
* meta.tag contains OriginSlice 1..1 MS
* meta.tag[OriginSlice] from OriginVS 
* id ..1 MS
* providedBy 1..1 MS
* specialty MS
* specialty from HealthcareServiceSpecialtyVS (extensible)
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
