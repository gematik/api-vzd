// Pendant in de.gematik.terminology (bereits Abhaengigkeit): https://gematik.de/fhir/terminology/CodeSystem/epa-zahnaerztliche-fachrichtungen-cs
// Die OID stammt von gematik, nicht von IHE - dort als identifier hinterlegt, die Zuordnung ist also offiziell.
// TODO: durch das Paket ersetzen, sobald gematik auf Canonicals wechselt; breaking, coding.system aendert sich in allen Instanzen.
CodeSystem: ZahnaerztlicheFachrichtungen_OID_URL
Id: zahnaerztliche-fachrichtungen-oid-url
Title: "ZahnaerztlicheFachrichtungen"
Description: "ZahnaerztlicheFachrichtungen"
* insert Meta
* ^url = "urn:oid:1.2.276.0.76.5.494"
* ^caseSensitive = true
* #MZAH "Allgemeine Zahnheilkunde"
* #ZGES "Öffentliches Gesundheitswesen"