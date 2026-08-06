# KHVZ FHIR Queries

Diese Beispiele gehen davon aus, dass im VZD-Kontext weiterhin `HealthcareService`
die Ressource ist, auf der gesucht wird.

Platzhalter:

```text
[base] = https://<vzd-fhir-base>
[level-system] = https://gematik.de/fhir/directory/CodeSystem/vzd-level
```

Voraussetzung fuer die Baumabfragen ist der KHVZ-SearchParameter
`HealthcareService:offered-in` auf
`HealthcareService.extension[offeredIn].valueReference`.

## Gesamten KHVZ-Baum eines Krankenhauses holen

Einstieg ueber den Krankenhaus-`HealthcareService` (`#vzd`) und Standort.
Darunter werden Einrichtung, Zentrum und Fachabteilung per `_revinclude:iterate`
geholt.

```http
GET [base]/HealthcareService?organization.identifier=https://gematik.de/fhir/sid/arge-ik/iknr|260123456
  &category=[level-system]|vzd,[level-system]|standort
  &_include:iterate=HealthcareService:organization
  &_include:iterate=HealthcareService:location
  &_include:iterate=HealthcareService:endpoint
  &_revinclude:iterate=HealthcareService:offered-in
```

Erwartete Ressourcen im Bundle:

- Krankenhaus-`HealthcareService` (`#vzd`)
- Standort-`HealthcareService`
- Einrichtung-`HealthcareService`
- Zentrum-`HealthcareService`
- Fachabteilung-`HealthcareService`
- referenzierte `Organization`
- referenzierte `Location`
- referenzierte `Endpoint`

## Gesamten KHVZ-Baum ohne `category=#vzd` am VZD-HealthcareService

Wenn der generische VZD-`HealthcareService` in den Bestandsdaten keine
`category=[level-system]|vzd` hat, darf der Einstieg nicht von dieser Category
abhaengen. Dann ist der stabilste Einstieg die Krankenhaus-`Organization` bzw.
deren Identifier.

### Variante A: alle HealthcareServices der Organization als Einstieg

Diese Query holt alle `HealthcareService`-Ressourcen, die direkt ueber
`providedBy` an der Krankenhaus-`Organization` haengen. Darauf aufbauend werden
per rekursivem RevInclude die untergeordneten KHVZ-Ebenen geholt.

```http
GET [base]/HealthcareService?organization.identifier=https://gematik.de/fhir/sid/arge-ik/iknr|260123456
  &_include:iterate=HealthcareService:organization
  &_include:iterate=HealthcareService:location
  &_include:iterate=HealthcareService:endpoint
  &_revinclude:iterate=HealthcareService:offered-in
```

Diese Variante ist robust gegen fehlende `#vzd`-Category, kann aber weitere
nicht-KHVZ-`HealthcareService`-Ressourcen derselben Organization mitliefern.
Der Client sollte das Ergebnis anhand vorhandener KHVZ-Level
(`standort`, `einrichtung`, `zentrum`, `fachabteilung`) und/oder
`offeredIn`-Beziehungen zum Baum zusammensetzen.

### Variante B: KHVZ-Baum nur ueber Standort starten

Wenn nur der KHVZ-Baum gebraucht wird und der generische VZD-Service nicht
zwingend im Bundle sein muss, kann direkt ueber die Standort-Ebene gestartet
werden.

```http
GET [base]/HealthcareService?organization.identifier=https://gematik.de/fhir/sid/arge-ik/iknr|260123456
  &category=[level-system]|standort
  &_include:iterate=HealthcareService:organization
  &_include:iterate=HealthcareService:location
  &_revinclude:iterate=HealthcareService:offered-in
```

Das liefert:

```text
Standort -> Einrichtung
Standort -> Zentrum
Einrichtung -> Fachabteilung
```

Der generische VZD-`HealthcareService` wird dabei bewusst nicht ueber
`category=#vzd` gesucht.

### Variante C: generischen VZD-Service typbasiert separat dazuholen

Wenn der generische VZD-`HealthcareService` gebraucht wird, aber keine
`category=#vzd` besitzt, kann er separat ueber `organization` und den bekannten
Typ `GESU` gesucht werden.

```http
GET [base]/HealthcareService?organization.identifier=https://gematik.de/fhir/sid/arge-ik/iknr|260123456
  &type=urn:oid:1.3.6.1.4.1.19376.3.276.1.5.4|GESU
  &_include=HealthcareService:organization
  &_include=HealthcareService:location
  &_include=HealthcareService:endpoint
```

Danach kann der eigentliche KHVZ-Baum mit Variante B geholt werden.

### Variante D: Organization zuerst suchen, danach HealthcareService

Wenn der Server Chained Search wie `organization.identifier` nicht oder nur
eingeschraenkt unterstuetzt, kann zweistufig gesucht werden:

```http
GET [base]/Organization?identifier=https://gematik.de/fhir/sid/arge-ik/iknr|260123456
```

Danach mit der gefundenen Organization-ID:

```http
GET [base]/HealthcareService?organization=Organization/<organization-id>
  &_include:iterate=HealthcareService:organization
  &_include:iterate=HealthcareService:location
  &_include:iterate=HealthcareService:endpoint
  &_revinclude:iterate=HealthcareService:offered-in
```

## Baum ab einem konkreten Standort

```http
GET [base]/HealthcareService?_id=<standort-id>
  &_include:iterate=HealthcareService:organization
  &_include:iterate=HealthcareService:location
  &_revinclude:iterate=HealthcareService:offered-in
```

Durch `_revinclude:iterate=HealthcareService:offered-in` werden direkte und
indirekte Kinder geholt:

```text
Standort -> Einrichtung
Standort -> Zentrum
Einrichtung -> Fachabteilung
```

## Direkte Kinder eines Standorts

Einrichtungen und Zentren unter einem Standort:

```http
GET [base]/HealthcareService?offered-in=HealthcareService/<standort-id>
```

Nur Einrichtungen:

```http
GET [base]/HealthcareService?offered-in=HealthcareService/<standort-id>
  &category=[level-system]|einrichtung
```

Nur Zentren:

```http
GET [base]/HealthcareService?offered-in=HealthcareService/<standort-id>
  &category=[level-system]|zentrum
```

## Fachabteilungen einer Einrichtung

```http
GET [base]/HealthcareService?offered-in=HealthcareService/<einrichtung-id>
  &category=[level-system]|fachabteilung
```

## Von Fachabteilung oder Einrichtung nach oben

Parent-Kette holen, z. B. Fachabteilung -> Einrichtung -> Standort:

```http
GET [base]/HealthcareService?_id=<fachabteilung-id>
  &_include:iterate=HealthcareService:offered-in
  &_include:iterate=HealthcareService:organization
  &_include:iterate=HealthcareService:location
```

## Krankenhaus-Service mit Location und Endpoint

```http
GET [base]/HealthcareService?organization.identifier=https://gematik.de/fhir/sid/arge-ik/iknr|260123456
  &category=[level-system]|vzd
  &_include=HealthcareService:organization
  &_include=HealthcareService:location
  &_include=HealthcareService:endpoint
```

## Fachabteilungen nach Fachabteilungsschluessel

```http
GET [base]/HealthcareService?category=[level-system]|fachabteilung
  &type=http://fhir.de/CodeSystem/dkgev/Fachabteilungsschluessel|0100
  &_include=HealthcareService:organization
  &_include:iterate=HealthcareService:offered-in
```