Profile: Practitioner-FhirDirectory
Parent: Practitioner
Description: "Profile for the Practitioner in gematik FHIR Directory"
* insert Meta
* id MS
* identifier 1..* MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "$this"
  * ^slicing.rules = #open
* identifier contains TelematikID 1.. MS
* identifier[TelematikID] only $IdentifierTelematikID
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1.. MS
  * system 1.. MS
  * value 1.. MS
/* @spilikin: habe die Detailierung für die LANR ergänzt. Passt das so?
* identifier contains LebenslangeArztNummer 1.. MS
* identifier[LebenslangeArztNummer] only $IdentifierLebenslangeArztNummer
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1.. MS
  * system 1.. MS
  * value 1.. MS
*/
* name 1..* MS
/* @spilikin: habe die Detailierung für name ergänzt. Passt das so?
  * text 0..1 MS
  * family 1..1 MS
  * given 0..* MS
  * prefix 0..* MS
  * suffix 0..* MS
*/
* telecom 0..* MS
/* @spilikin: habe die Detailierung für telecom ergänzt. Passt das so?
  * system 0..1 MS
  * value 0..1 MS
  * use 0..1 MS
*/
* gender 0..1 MS
* birthDate 0..1 MS
* photo 0.. MS
* qualification 0..* MS
/* @spilikin: habe die Detailierung für qualification ergänzt. Passt das so?
  * identifier
    * ^slicing.discriminator.type = #pattern
    * ^slicing.discriminator.path = "$this"
    * ^slicing.rules = #open
  * identifier contains AuthorSpeciality 1.. MS
  * identifier[AuthorSpeciality] only $IHEXDSauthorSpeciality
    * type 1..1 MS
    * system 1..1 MS
    * value 1..1 MS
*/

//* qualification.code MS
//* qualification.code from TIPractitionerQualificationVS
* communication 0..* MS