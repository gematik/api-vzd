Profile: HealthcareServiceDirectory
Parent: HealthcareService
Title: "Profile for an HealthcareService resource in the TI FHIR-Directory"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* id ..1 MS
* active 1..1 MS
* providedBy 1..1 MS
* specialty MS
* location MS
* name MS
* telecom MS
/* @spilikin: habe die Detailierung für telecom ergänzt. Passt das so?
*/
  * system 0..1 MS
  * value 0..1 MS
  * use 0..1 MS
* serviceProvisionCode MS
  * coding MS
    * code 1..1 MS
    * display 1..1 MS
* communication MS
/* @spilikin: habe die Detailierung für qualification ergänzt. Passt das so?
*/
  * coding MS
    * code 1..1 MS
    * display 1..1 MS
* appointmentRequired MS
* availableTime MS
* availabilityExceptions MS
* endpoint MS
