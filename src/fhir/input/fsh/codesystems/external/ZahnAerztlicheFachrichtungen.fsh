//FIXME: URL in de.gematik.terminology = https://gematik.de/fhir/terminology/CodeSystem/epa-zahnaerztliche-fachrichtungen-cs
// Frage: woher stammt die OID, IHE?
// TODO: Kein IHE-CodeSystem, das Pendant liegt in de.gematik.terminology (bereits Abhaengigkeit):
//       https://gematik.de/fhir/terminology/CodeSystem/epa-zahnaerztliche-fachrichtungen-cs (Version 1.0.7),
//       gleiche 2 Codes und Displays, dort zusaetzlich mit Definitionen. Bei einer Umstellung auf URL-Canonicals
//       kann dieses lokale CodeSystem entfallen. Breaking: coding.system in bestehenden Instanzen wandert
//       von urn:oid:1.2.276.0.76.5.494 auf die gematik-URL.
CodeSystem: ZahnaerztlicheFachrichtungen_OID_URL
Id: zahnaerztliche-fachrichtungen-oid-url
Title: "ZahnaerztlicheFachrichtungen"
Description: "ZahnaerztlicheFachrichtungen"
* insert Meta
* ^url = "urn:oid:1.2.276.0.76.5.494"
* ^caseSensitive = true
* #MZAH "Allgemeine Zahnheilkunde"
* #ZGES "Öffentliches Gesundheitswesen"