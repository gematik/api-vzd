Profile: HealthcareServiceDirectory
Parent: HealthcareService
Title: "HealthcareService in gematik Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* id ..1 MS
* providedBy 1..1 MS
* specialty MS
* specialty from OrganizationTypeVS (extensible)
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
