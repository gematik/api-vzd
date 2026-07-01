### Überblick

Das **Krankenhausverzeichnis (KHVZ)** bildet die innere Struktur eines Krankenhauses im
Verzeichnisdienst (VZD) über mehrere Ebenen ab. Jede Ebene ist ein eigener
`HealthcareService`, der

* über `providedBy` mit der Krankenhaus-`Organization` (Träger) verknüpft ist und
* über die R5-Backport-Extension [`offeredIn`](https://hl7.org/fhir/R5/healthcareservice-definitions.html#HealthcareService.offeredIn)
  hierarchisch auf seinen übergeordneten `HealthcareService` verweist.

Die fachliche Klassifikation der Ebene erfolgt über das CodeSystem
[VzdLevelCS](CodeSystem-vzd-level.html) im Slice `category[VzdLevelVS]`.

Die feldgenaue Abbildung der InEK-XSD-Struktur (`Standortverzeichnis` v2.1) auf die Profile
ist auf der Seite [KHVZ – Mapping (XSD → Profile)](khvz-mapping.html) beschrieben.

### Ebenenmodell

| Ebene | Profil | `category[vzdLevel]` | Identifier | `type` (Binding) | `offeredIn` → | `location` |
|---|---|---|---|---|---|---|
| (Krankenhaus, generisch) | [HealthcareServiceDirectory](StructureDefinition-HealthcareServiceDirectory.html) | `#vzd` | TelematikID | – | – | LocationDirectory |
| Standort | [HealthcareServiceStandort](StructureDefinition-HealthcareServiceStandort.html) | `#standort` | `standortId` | – | – (nur `providedBy`) | LocationDirectory (1..1) |
| Einrichtung | [HealthcareServiceEinrichtung](StructureDefinition-HealthcareServiceEinrichtung.html) | `#einrichtung` | `BSNR` (0..*), `standortnummer`, `abrechnungsIK` (ggf. `standortId`) | [InEKEinrichtungstypenVS](ValueSet-inek-einrichtungstypen-vs.html) | Standort | LocationDirectory (1..1) |
| Zentrum | [HealthcareServiceZentrum](StructureDefinition-HealthcareServiceZentrum.html) | `#zentrum` | `erId` | [InEKZentrenartenVS](ValueSet-inek-zentrenarten-vs.html) | Standort | – (0..0) |
| Fachabteilung | [HealthcareServiceFachabteilung](StructureDefinition-HealthcareServiceFachabteilung.html) | `#fachabteilung` | `erId` | Fachabteilungsschlüssel (dkgev) | Einrichtung | – (0..0) |

Alle vier KHVZ-Profile leiten von dem abstrakten Basis-Profil
[HealthcareServiceKhvzBase](StructureDefinition-HealthcareServiceKhvzBase.html) ab, in dem
die gemeinsamen Constraints (Origin-Tag, `providedBy`, vzdLevel-Slicing, Extensions,
Identifier-Slicing) gebündelt sind.

### Hierarchie über `offeredIn`

Die Eltern-Kind-Beziehung zwischen den HealthcareService-Ebenen wird **nicht** über
`partOf` (gibt es bei HealthcareService nicht), sondern über die aus R5 zurückportierte
Extension `offeredIn` modelliert. In jedem KHVZ-Profil ist das Ziel von `offeredIn` auf das
jeweils übergeordnete Profil typisiert:

* Einrichtung → Standort
* Zentrum → Standort
* Fachabteilung → Einrichtung

Der **Standort** ist die oberste KHVZ-`HealthcareService`-Ebene und nutzt **kein** `offeredIn`
(`extension[offeredIn] 0..0`). Seine Zuordnung zum Krankenhaus erfolgt ausschließlich über
`providedBy` → Krankenhaus-`Organization`.

### Gültigkeit und letzte Änderung

Auf den KHVZ-Ebenen (insb. Standort) stehen zwei Extensions zur Verfügung:

* [KhvzGueltigkeitEx](StructureDefinition-KhvzGueltigkeitEx.html) – komplexe Extension mit
  den Sub-Extensions `gueltigVon` und `gueltigBis`.
* [KhvzLetzteAenderungEx](StructureDefinition-KhvzLetzteAenderungEx.html) – Zeitpunkt der
  letzten Änderung.

### Location-Wiederverwendung

Es wird kein eigenes Location-Profil eingeführt. Standort- und Einrichtungs-Locations nutzen
das bestehende [LocationDirectory](StructureDefinition-LocationDirectory.html). Dessen `type`
ist `0..1` und an [LocationVzdTypeVS](ValueSet-location-vzd-type-vs.html) gebunden (Codes
`vzd`, `standort`, `einrichtung` aus dem gemeinsamen
[VzdLevelCS](CodeSystem-vzd-level.html)).

### Abbildung als UML

<style>
.khvz-uml svg { width: auto !important; height: auto !important; max-width: 100%; }
</style>
<div class="khvz-uml">
{% include khvz-model.svg %}
</div>

### Beispiel-Kette

Eine durchgängige Beispiel-Instanzkette (Standort über `providedBy`, darunter über `offeredIn`
verkettet):

1. [KhvzKrankenhausOrganizationExample](Organization-KhvzKrankenhausOrganizationExample.html)
   – Krankenhaus-`Organization` (Träger)
2. [KhvzVzdHealthcareServiceExample](HealthcareService-KhvzVzdHealthcareServiceExample.html)
   – generischer VZD-HealthcareService (`#vzd`), `providedBy` → Organization, mit Location
   [KhvzKrankenhausLocationExample](Location-KhvzKrankenhausLocationExample.html) und KIM-Endpoint
   [KhvzKrankenhausKimEndpointExample](Endpoint-KhvzKrankenhausKimEndpointExample.html)
3. [KhvzStandortExample](HealthcareService-KhvzStandortExample.html)
   – Standort, `providedBy` → Krankenhaus-`Organization` (kein `offeredIn`), mit Location
   [KhvzStandortLocationExample](Location-KhvzStandortLocationExample.html)
4. [KhvzEinrichtungExample](HealthcareService-KhvzEinrichtungExample.html)
   – Einrichtung, `offeredIn` → Standort, mit Location
   [KhvzEinrichtungLocationExample](Location-KhvzEinrichtungLocationExample.html)
5. [KhvzZentrumExample](HealthcareService-KhvzZentrumExample.html)
   – Zentrum, `offeredIn` → Standort
6. [KhvzFachabteilungExample](HealthcareService-KhvzFachabteilungExample.html)
   – Fachabteilung, `offeredIn` → Einrichtung
