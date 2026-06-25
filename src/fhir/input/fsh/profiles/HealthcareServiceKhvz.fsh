// ============================================================================
// KHVZ HealthcareService-Hierarchie (Krankenhausverzeichnis im VZD)
// Abstraktes Basis-Profil + 4 Ebenen: Standort, Einrichtung, Zentrum, Fachabteilung
// Hierarchie über die R5->R4 Cross-Version-Extension offeredIn.
// ============================================================================

Profile: HealthcareServiceKhvzBase
Parent: HealthcareService
Title: "HealthcareService KHVZ Basis (abstrakt)"
Description: """Abstraktes Basis-Profil für die KHVZ-HealthcareService-Ebenen
(Standort, Einrichtung, Zentrum, Fachabteilung). Bündelt die gemeinsamen
VZD-Constraints. Nicht direkt instanziieren."""
* insert Meta
* ^abstract = true
* extension contains
    $offeredIn named offeredIn 0..1 MS and
    KhvzGueltigkeitEx named gueltigkeit 0..1 MS and
    KhvzLetzteAenderungEx named letzteAenderung 0..1 MS
* meta.tag 1.. MS
  * ^slicing.discriminator.type = #pattern
  * ^slicing.discriminator.path = "system"
  * ^slicing.rules = #open
* meta.tag obeys CodingSytemCodeInv
* meta.tag contains Origin 1..1 MS
* meta.tag[Origin] from OriginVS
* meta.tag[Origin].system = Canonical(Origin)
* id MS
* identifier 0..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* providedBy 1..1 MS
* providedBy only Reference(OrganizationDirectory)
* category MS
  * coding obeys CodingSytemCodeInv
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains VzdLevelVS 1..1 MS
* category[VzdLevelVS] from VzdLevelVS
* type MS
  * coding obeys CodingSytemCodeInv
* name 1..1 MS
* location MS

// ----------------------------------------------------------------------------
// Standort
// ----------------------------------------------------------------------------
Profile: HealthcareServiceStandort
Parent: HealthcareServiceKhvzBase
Id: HealthcareServiceStandort
Title: "HealthcareService Standort (KHVZ)"
Description: "Standort-Ebene des Krankenhausverzeichnisses als HealthcareService."
* insert Meta
* extension[offeredIn] 1..1 MS
* extension[offeredIn].value[x] only Reference(HealthcareServiceDirectory)
* category[VzdLevelVS] = VzdLevelCS#standort
* identifier contains standortId 1..1 MS
* identifier[standortId].system = $sidStandortId
* identifier[standortId].value 1.. MS
* type 0..0
* location 1..1 MS
* location only Reference(LocationDirectory)

// ----------------------------------------------------------------------------
// Einrichtung
// ----------------------------------------------------------------------------
Profile: HealthcareServiceEinrichtung
Parent: HealthcareServiceKhvzBase
Id: HealthcareServiceEinrichtung
Title: "HealthcareService Einrichtung (KHVZ)"
Description: "Einrichtungs-Ebene des Krankenhausverzeichnisses als HealthcareService."
* insert Meta
* extension[offeredIn] 1..1 MS
* extension[offeredIn].value[x] only Reference(HealthcareServiceStandort)
* category[VzdLevelVS] = VzdLevelCS#einrichtung
* identifier contains
    BSNR 0..1 MS and
    standortId 0..1 MS
* identifier[BSNR].system = $bsnr
* identifier[BSNR].value 1.. MS
* identifier[standortId].system = $sidStandortId
* identifier[standortId].value 1.. MS
* type 1.. MS
* type from InEKEinrichtungstypenVS (required)
* location 1..1 MS
* location only Reference(LocationDirectory)

// ----------------------------------------------------------------------------
// Zentrum
// ----------------------------------------------------------------------------
Profile: HealthcareServiceZentrum
Parent: HealthcareServiceKhvzBase
Id: HealthcareServiceZentrum
Title: "HealthcareService Zentrum (KHVZ)"
Description: "Zentrums-Ebene des Krankenhausverzeichnisses als HealthcareService."
* insert Meta
* extension[offeredIn] 1..1 MS
* extension[offeredIn].value[x] only Reference(HealthcareServiceStandort)
* category[VzdLevelVS] = VzdLevelCS#zentrum
* identifier contains erId 1..1 MS
* identifier[erId].system = $sidInekErId
* identifier[erId].value 1.. MS
* type 1.. MS
* type from InEKZentrenartenVS (required)
* location 0..0

// ----------------------------------------------------------------------------
// Fachabteilung
// ----------------------------------------------------------------------------
Profile: HealthcareServiceFachabteilung
Parent: HealthcareServiceKhvzBase
Id: HealthcareServiceFachabteilung
Title: "HealthcareService Fachabteilung (KHVZ)"
Description: "Fachabteilungs-Ebene des Krankenhausverzeichnisses als HealthcareService."
* insert Meta
* extension[offeredIn] 1..1 MS
* extension[offeredIn].value[x] only Reference(HealthcareServiceEinrichtung)
* category[VzdLevelVS] = VzdLevelCS#fachabteilung
* identifier contains erId 1..1 MS
* identifier[erId].system = $sidInekErId
* identifier[erId].value 1.. MS
* type 1.. MS
* type from $FachabteilungsschluesselVS (required)
* location 0..0
