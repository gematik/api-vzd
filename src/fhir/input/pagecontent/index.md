### Einleitung

Dieser Implementation Guide beschreibt die FHIR-Profile, Extensions, Terminologien und
Suchparameter des **gematik FHIR-Verzeichnisdienstes (VZD)**.

Der VZD bildet u. a. folgende Bereiche ab:

* Organisationen, HealthcareServices, Locations und Endpoints der Telematikinfrastruktur
* das **Krankenhausverzeichnis (KHVZ)** mit den HealthcareService-Ebenen
  Standort, Einrichtung, Zentrum und Fachabteilung

### Inhalt

Eine vollständige Übersicht aller in diesem IG definierten Artefakte (Profile, Extensions,
CodeSystems, ValueSets und Beispiele) findet sich auf der Seite
[Artefakte](artifacts.html).

#### Krankenhausverzeichnis (KHVZ)

Die KHVZ-Ebenen (Standort, Einrichtung, Zentrum, Fachabteilung) werden als
HealthcareService-Profile modelliert, die von einem abstrakten Basisprofil abgeleitet und
über die R5-Backport-Extension `offeredIn` hierarchisch verknüpft werden. Die vollständige
Beschreibung inkl. UML-Diagramm findet sich auf der Seite
[Krankenhausverzeichnis (KHVZ)](khvz.html).

### Kontakt

[gematik GmbH](https://www.gematik.de)
