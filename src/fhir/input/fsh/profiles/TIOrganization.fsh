Profile: TIOrganization
Parent: Organization
Title: "Profile for an Organization resource in the TI"
Description: """Defines the data structure for medical, regulatory and technical
organisations specific for german Healthcare and Telematics Infrastructure.
"""
* insert Meta
* id 0..1 MS
* name 1..1 MS
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier contains TelematikID 1..1 MS
* identifier[TelematikID] only $IdentifierTelematikID
  * ^patternIdentifier.type = $v2-0203#PRN
  * type 1..1 MS
  * system 1..1 MS
  * value 1..1 MS
/* neue Meta IDs: holder_id, owner_id, damit die telematikIDs nicht in allen Ressourcen gepflegt werden müssen
Eigene Codesysteme für die IDs um sie von telematikID und LANR unterscheiden zu können
*/
* identifier contains HolderID 1.. MS
* identifier[HolderID] only $IdentifierHolderID
  * type 1..1 MS
  * system 1..1 MS
  * value 1..* MS
* identifier contains OwnerID 1.. MS
* identifier[OwnerID] only $IdentifierOwnerID
  * type 1..1 MS
  * system 1..1 MS
  * value 1..* MS
* type 1..* MS
* type from TIOrganizationTypeVS
//* address MS
* partOf MS
* name 1..1 MS
* alias MS
* telecom MS
* partOf MS
* contact MS
//* contact.purpose from $ContactEntityTypeVS
//* extension contains X509CertificateBundleExtension named certificates 0..1 MS