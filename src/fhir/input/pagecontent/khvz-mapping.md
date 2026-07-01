### Überblick

Diese Seite beschreibt die Abbildung des **InEK-Krankenhausstandortverzeichnisses**
(XML-Schema `Standortverzeichnis`, Version 2.1) auf die FHIR-Profile dieses
Implementation Guides. Quelle ist die XSD-Struktur mit den komplexen Typen
`KrankenhausTyp`, `StandortTyp`, `GeoAdresseTyp`, `PostAdresseTyp`, `EinrichtungsTyp`,
`ZentrenTyp` und `FachabteilungTyp`.

Grundprinzip:

* Die **Krankenhaus-Ebene** wird über die [OrganizationDirectory](StructureDefinition-OrganizationDirectory.html)
  abgebildet und ist **nicht** Teil der KHVZ-`HealthcareService`-Profile.
* Jede weitere Ebene (Standort, Einrichtung, Zentrum, Fachabteilung) ist ein eigener
  `HealthcareService`; Adress- und Geodaten liegen auf der zugehörigen
  [LocationDirectory](StructureDefinition-LocationDirectory.html). Siehe
  [Krankenhausverzeichnis (KHVZ)](khvz.html) für das Ebenenmodell.
* Felder ohne natives FHIR-Pendant werden über eigene Extensions abgebildet.

**Legende:** ✅ nativ abgebildet · 🧩 über Extension · ⛔ bewusst nicht abgebildet.

### Dateikopf (`DateikopfTyp`)

Metadaten der Export-Datei (`Dateinummer`, `XmlSchemaVersion`, `LetzteÄnderung`,
`Erstelldatum`). ⛔ Nicht auf Ressourcenebene abgebildet – betrifft den Lieferprozess,
nicht die fachlichen Daten.

### Krankenhaus (`KrankenhausTyp`)

⛔ Out of scope für die KHVZ-`HealthcareService`-Profile – die Krankenhaus-Ebene wird als
[OrganizationDirectory](StructureDefinition-OrganizationDirectory.html) abgebildet. Übersicht
zur Einordnung:

| XSD-Feld | Abbildung | Status |
|---|---|---|
| `HauptIK` | `Organization.identifier` (IKNR) | ✅ (Organization) |
| `Bezeichnung` | `Organization.name` | ✅ (Organization) |
| `Träger` | Krankenhaus-`Organization` (Träger) | ✅ (Organization) |
| `Version`, `GültigVon`, `GültigBis`, `LetzteÄnderung` | – | ⛔ |
| `NachfolgeIK` | – | ⛔ |
| `Ermächtigungsgrundlage` | CodeSystem [InEKErmaechtigungsgrundlagen](CodeSystem-inek-ermaechtigungsgrundlagen.html) vorhanden, derzeit nicht gebunden | ⛔ |
| `Trägerart`, `Rechtsform`, `SitzGesellschaft`, `Registergericht`, `Registernummer` | analog Einrichtung möglich, auf Krankenhaus-Ebene nicht abgebildet | ⛔ |

### Standort (`StandortTyp` → [HealthcareServiceStandort](StructureDefinition-HealthcareServiceStandort.html))

| XSD-Feld | FHIR-Ziel | Status |
|---|---|---|
| `StandortId` | `identifier[standortId]` | ✅ |
| `Bezeichnung` | `name` | ✅ |
| `Aktiv` | `active` | ✅ |
| `Version` | `extension[version]` ([KhvzVersionEx](StructureDefinition-KhvzVersionEx.html)) | 🧩 |
| `GültigVon` / `GültigBis` | `extension[gueltigkeit]` ([KhvzGueltigkeitEx](StructureDefinition-KhvzGueltigkeitEx.html)) | 🧩 |
| `LetzteÄnderung` | `extension[letzteAenderung]` ([KhvzLetzteAenderungEx](StructureDefinition-KhvzLetzteAenderungEx.html)) | 🧩 |
| `Ausnahme` | `extension[ausnahme]` ([KhvzAusnahmeEx](StructureDefinition-KhvzAusnahmeEx.html)) | 🧩 |
| `ReferenzKrankenhaus.IK` | `providedBy` → Krankenhaus-`Organization` (der Standort nutzt kein `offeredIn`) | ✅ |
| `ReferenzKrankenhaus.Version` | – | ⛔ |
| `GeoAdresse` | `location` → LocationDirectory (siehe [GeoAdresse](#geoadresse-geoadressetyp)) | ✅ |
| `Bundesland` | `location.address.state` ([AddressStateVS](ValueSet-AddressStateVS.html)) | ✅ |
| `Gemeindeschlüssel` | `location.address.extension[ags]` (fhir.de [destatis/ags](https://simplifier.net/basisprofil-de-r4/extension-destatis-ags)) | 🧩 |
| `KVBezirk` | `location.extension[kvBezirk]` ([KhvzKvBezirkEx](StructureDefinition-KhvzKvBezirkEx.html), [InEKKVBezirkeVS](ValueSet-inek-kvbezirke-vs.html)) | 🧩 |
| `Adresstyp` | `location.address.extension[adresstyp]` ([KhvzAdresstypEx](StructureDefinition-KhvzAdresstypEx.html), [InEKAdresstypenVS](ValueSet-inek-adresstypen-vs.html)) | 🧩 |
| `PostAdresse` | `location.extension[postadresse]` ([KhvzPostadresseEx](StructureDefinition-KhvzPostadresseEx.html), siehe [PostAdresse](#postadresse-postadressetyp)) | 🧩 |
| `Zentren` | eigene [HealthcareServiceZentrum](StructureDefinition-HealthcareServiceZentrum.html) (`offeredIn` → Standort) | ✅ |
| `Einrichtung` | eigene [HealthcareServiceEinrichtung](StructureDefinition-HealthcareServiceEinrichtung.html) (`offeredIn` → Standort) | ✅ |

### GeoAdresse (`GeoAdresseTyp` → LocationDirectory)

| XSD-Feld | FHIR-Ziel | Status |
|---|---|---|
| `Breitengrad` | `position.latitude` (WGS84) | ✅ |
| `Längengrad` | `position.longitude` (WGS84) | ✅ |
| `PLZ` | `address.postalCode` | ✅ |
| `Ort` | `address.city` | ✅ |
| `Straße` | `address.line` | ✅ |
| `Hausnummer` | `address.line` (zusammengeführt) | ✅ |
| `AdressZusatz` | `address.line` (zusätzliche Zeile) | ✅ |
| `GeoreferenzZone` / `GeoreferenzOst` / `GeoreferenzNord` | – (UTM; Position liegt bereits als WGS84 vor) | ⛔ |

### PostAdresse (`PostAdresseTyp` → `location.extension[postadresse].valueAddress`)

In FHIR R4 ist `Location.address` auf `0..1` begrenzt. Die abweichende Postanschrift wird
daher über die Extension [KhvzPostadresseEx](StructureDefinition-KhvzPostadresseEx.html)
(Datentyp `Address`, `use = #postal`) abgelegt.

| XSD-Feld | FHIR-Ziel | Status |
|---|---|---|
| `PLZ` | `valueAddress.postalCode` | 🧩 |
| `Ort` | `valueAddress.city` | 🧩 |
| `StraßePostfach` | `valueAddress.line` | 🧩 |
| `Hausnummer` | `valueAddress.line` | 🧩 |
| `AdressZusatz` | `valueAddress.line` | 🧩 |

### Einrichtung (`EinrichtungsTyp` → [HealthcareServiceEinrichtung](StructureDefinition-HealthcareServiceEinrichtung.html))

| XSD-Feld | FHIR-Ziel | Status |
|---|---|---|
| `Einrichtungstyp` | `type` ([InEKEinrichtungstypenVS](ValueSet-inek-einrichtungstypen-vs.html)) | ✅ |
| `Standortnummer` | `identifier[standortnummer]` | ✅ |
| `Betriebsstättennummer` (1..*) | `identifier[BSNR]` (`0..*`, [fhir.de BSNR](http://fhir.de/sid/bsnr)) | ✅ |
| `AbrechnungsIK` (0..*) | `identifier[abrechnungsIK]` (IKNR) | ✅ |
| `Name` | `name` | ✅ |
| `Aktiv` | `active` | ✅ |
| `GültigVon` / `GültigBis` | `extension[gueltigkeit]` | 🧩 |
| `Ausnahme` | `extension[ausnahme]` ([KhvzAusnahmeEx](StructureDefinition-KhvzAusnahmeEx.html)) | 🧩 |
| `PSY` / `DRG` | `extension[versorgungsmerkmale]` ([KhvzVersorgungsmerkmaleEx](StructureDefinition-KhvzVersorgungsmerkmaleEx.html), Sub-Extensions `psy` / `drg`) | 🧩 |
| `GeoAdresse` | `location` → LocationDirectory | ✅ |
| `Fachabteilungen` | eigene [HealthcareServiceFachabteilung](StructureDefinition-HealthcareServiceFachabteilung.html) (`offeredIn` → Einrichtung) | ✅ |
| `Träger` | `extension[traeger].extension[traeger]` ([KhvzTraegerEx](StructureDefinition-KhvzTraegerEx.html)) | 🧩 |
| `Trägerart` | `extension[traeger].extension[traegerart]` ([InEKTraegerartenVS](ValueSet-inek-traegerarten-vs.html)) | 🧩 |
| `Rechtsform` | `extension[traeger].extension[rechtsform]` ([InEKRechtsformenVS](ValueSet-inek-rechtsformen-vs.html)) | 🧩 |
| `SitzGesellschaft` | `extension[traeger].extension[sitzGesellschaft]` | 🧩 |
| `Registergericht` | `extension[traeger].extension[registergericht]` | 🧩 |
| `Registernummer` | `extension[traeger].extension[registernummer]` | 🧩 |

### Zentren (`ZentrenTyp` → [HealthcareServiceZentrum](StructureDefinition-HealthcareServiceZentrum.html))

| XSD-Feld | FHIR-Ziel | Status |
|---|---|---|
| `ZentrenArt` (1..*) | `type` ([InEKZentrenartenVS](ValueSet-inek-zentrenarten-vs.html)) | ✅ |
| (Identität) | `identifier[erId]` | ✅ |
| (Hierarchie) | `extension[offeredIn]` → Standort | ✅ |

### Fachabteilung (`FachabteilungTyp` → [HealthcareServiceFachabteilung](StructureDefinition-HealthcareServiceFachabteilung.html))

| XSD-Feld | FHIR-Ziel | Status |
|---|---|---|
| `Fachabteilungsschlüssel` (1..*) | `type` (dkgev Fachabteilungsschlüssel) | ✅ |
| (Identität) | `identifier[erId]` | ✅ |
| (Hierarchie) | `extension[offeredIn]` → Einrichtung | ✅ |

### Bewusst nicht abgebildete Felder

* **Krankenhaus-Ebene** insgesamt (→ Organization), inkl. `Ermächtigungsgrundlage` und `NachfolgeIK`.
* **UTM-Georeferenz** (`GeoreferenzZone`/`-Ost`/`-Nord`) – dieselbe Position liegt als WGS84 in `Location.position` vor.
* **`ReferenzKrankenhaus.Version`** – die Verknüpfung zum Krankenhaus erfolgt über `providedBy`.
