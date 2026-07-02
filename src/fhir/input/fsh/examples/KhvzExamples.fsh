// ============================================================================
// KHVZ Beispiel-Kette:
// Organization (Krankenhaus) -> generischer VZD-HS (#vzd)
//   -> Standort -> Einrichtung -> Zentrum
//                  Einrichtung -> Fachabteilung
// Hierarchie über extension[offeredIn].
// ============================================================================

Instance: KhvzKrankenhausOrganizationExample
InstanceOf: OrganizationDirectoryStrict
Usage: #example
Description: "Krankenhaus-Organization als Träger der KHVZ-HealthcareServices"
* meta.tag[Origin] = Origin#ldap
* identifier[TelematikID].value = "5-2-KH-Musterklinik-01"
* identifier[IKNR].value = "260123456"
* type[profession] = TIOrganizationProfessionTypeOidCS#1.2.276.0.76.4.53 "Krankenhaus"
* name = "Musterklinik gGmbH"
* active = true
* alias = "Musterklinik"
* contact.name.text = "Zentrale Musterklinik gGmbH"
* contact.telecom[+].system = $ContactPointSystem#phone "Phone"
* contact.telecom[=].value = "030 1234000"
* contact.telecom[+].system = $ContactPointSystem#url "URL"
* contact.telecom[=].value = "https://www.musterklinik.example"

Instance: KhvzVzdHealthcareServiceExample
InstanceOf: HealthcareServiceDirectoryStrict
Usage: #example
Description: "Generischer VZD-HealthcareService (Ebene #vzd) des Krankenhauses"
* meta.tag[Origin] = Origin#ldap
* providedBy = Reference(KhvzKrankenhausOrganizationExample)
* category[VzdLevelVS] = VzdLevelCS#vzd "VZD"
* type = AerztlicheFachrichtungen_OID_URL#GESU "Öffentliches Gesundheitswesen"
* name = "Musterklinik gGmbH"
* telecom[+].system = $ContactPointSystem#phone "Phone"
* telecom[=].value = "030 1234000"
* telecom[=].use = $ContactPointUse#work "Work"
* location[+] = Reference(KhvzKrankenhausLocationExample)
* endpoint[+] = Reference(KhvzKrankenhausKimEndpointExample)
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#mon "Monday"
  * availableStartTime = "00:00:00"
  * availableEndTime = "23:59:59"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#tue "Tuesday"
  * availableStartTime = "00:00:00"
  * availableEndTime = "23:59:59"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#wed "Wednesday"
  * availableStartTime = "00:00:00"
  * availableEndTime = "23:59:59"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#thu "Thursday"
  * availableStartTime = "00:00:00"
  * availableEndTime = "23:59:59"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#fri "Friday"
  * availableStartTime = "00:00:00"
  * availableEndTime = "23:59:59"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#sat "Saturday"
  * availableStartTime = "00:00:00"
  * availableEndTime = "23:59:59"
* availableTime[+]
  * daysOfWeek = $DaysOfWeek#sun "Sunday"
  * availableStartTime = "00:00:00"
  * availableEndTime = "23:59:59"

// --- Krankenhaus-Location & Endpoint ----------------------------------------
Instance: KhvzKrankenhausLocationExample
InstanceOf: LocationDirectoryStrict
Usage: #example
Description: "Location des Krankenhauses (VZD-Ebene)"
* meta.tag[Origin] = Origin#ldap
* name = "Musterklinik gGmbH"
* type = VzdLevelCS#vzd "VZD"
* address.text = "Klinikstraße 1, 10117 Berlin"
* address.line = "Klinikstraße 1"
* address.city = "Berlin"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"
* position.longitude = 13.3777
* position.latitude = 52.5163
* managingOrganization = Reference(KhvzKrankenhausOrganizationExample)

Instance: KhvzKrankenhausKimEndpointExample
InstanceOf: EndpointDirectoryStrict
Usage: #example
Description: "KIM-Endpunkt des Krankenhauses"
* meta.tag[Origin] = Origin#ldap
* status = #active "Active"
* connectionType = EndpointDirectoryConnectionType#kim "KIM Endpoint"
* connectionType.extension[kimVersion]
  * extension[version].valueCoding = KimVersionCS#2.0 "KIM 2.0 Endpoint"
  * extension[xxlMailSupported].valueBoolean = true
* name = "KIM-Mailadresse Zentrale"
* payloadType = EndpointDirectoryKIMappTags#Arztbrief "eArztbrief"
* address = "zentrale@musterklinik.kim.telematik"

// --- Standort ---------------------------------------------------------------
Instance: KhvzStandortLocationExample
InstanceOf: LocationDirectoryStrict
Usage: #example
Description: "Location des Standorts"
* meta.tag[Origin] = Origin#ldap
* type = VzdLevelCS#standort "Standort"
* extension[kvBezirk].valueCoding = InEKKvBezirke#72 "Berlin"
* address.use = #work
* address.type = #physical
* address.extension[adresstyp].valueCoding = InEKAdresstypen#1 "Gebäude (§ 2a Absatz 1 Satz 1 KHG)"
* address.extension[gemeindeschluessel].valueCoding = http://fhir.de/sid/destatis/ags#11000000
* address.text = "Klinikstraße 1, 10117 Berlin"
* address.line = "Klinikstraße 1"
* address.city = "Berlin"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"
// PostAdresse als separate Adresse (FHIR R4: Location.address ist 0..1, daher Extension)
* extension[postadresse].valueAddress.use = #work
* extension[postadresse].valueAddress.type = #postal
* extension[postadresse].valueAddress.line = "Postfach 12 34 56"
* extension[postadresse].valueAddress.city = "Berlin"
* extension[postadresse].valueAddress.postalCode = "10999"
* extension[postadresse].valueAddress.country = "DE"
* position.longitude = 13.3777
* position.latitude = 52.5163

Instance: KhvzStandortExample
InstanceOf: HealthcareServiceStandort
Usage: #example
Description: "Standort-Ebene des Krankenhausverzeichnisses"
* meta.tag[Origin] = Origin#ldap
* extension[gueltigkeit].extension[gueltigVon].valueDateTime = "2018-01-01"
* extension[letzteAenderung].valueDateTime = "2025-12-19"
* extension[version].valueInteger = 1
* extension[ausnahme].valueBoolean = false
* providedBy = Reference(KhvzKrankenhausOrganizationExample)
* identifier[standortId].value = "123456"
* category[VzdLevelVS] = VzdLevelCS#standort "Standort"
* active = true
* name = "Musterklinik gGmbH - Standort Berlin-Mitte"
* location = Reference(KhvzStandortLocationExample)

// --- Einrichtung ------------------------------------------------------------
Instance: KhvzEinrichtungLocationExample
InstanceOf: LocationDirectoryStrict
Usage: #example
Description: "Location der Einrichtung"
* meta.tag[Origin] = Origin#ldap
* type = VzdLevelCS#einrichtung "Einrichtung"
* address.text = "Klinikstraße 1, Haus B, 10117 Berlin"
* address.line = "Klinikstraße 1, Haus B"
* address.city = "Berlin"
* address.state = "Berlin"
* address.postalCode = "10117"
* address.country = "DE"

Instance: KhvzEinrichtungExample
InstanceOf: HealthcareServiceEinrichtung
Usage: #example
Description: "Einrichtungs-Ebene des Krankenhausverzeichnisses"
* meta.tag[Origin] = Origin#ldap
* extension[offeredIn].valueReference = Reference(KhvzStandortExample)
* extension[ausnahme].valueBoolean = false
* extension[versorgungsmerkmale].extension[psy].valueBoolean = false
* extension[versorgungsmerkmale].extension[drg].valueBoolean = true
* extension[traeger].extension[traeger].valueString = "Musterklinik gGmbH"
* extension[traeger].extension[traegerart].valueCoding = InEKTraegerarten#f "freigemeinnützig"
* extension[traeger].extension[rechtsform].valueCoding = InEKRechtsformen#07 "gGmbH"
* extension[traeger].extension[sitzGesellschaft].valueString = "Berlin"
* extension[traeger].extension[registergericht].valueString = "Amtsgericht Charlottenburg"
* extension[traeger].extension[registernummer].valueString = "HRB 123456"
* providedBy = Reference(KhvzKrankenhausOrganizationExample)
* identifier[BSNR].value = "999999999"
* identifier[standortnummer].value = "771234001"
* identifier[abrechnungsIK].value = "260123456"
* category[VzdLevelVS] = VzdLevelCS#einrichtung "Einrichtung"
* active = true
* type = InEKEinrichtungstypen#00 "Stationäre Behandlung"
* name = "Musterklinik gGmbH - Klinik für Innere Medizin"
* location = Reference(KhvzEinrichtungLocationExample)

// --- Zentrum ----------------------------------------------------------------
Instance: KhvzZentrumExample
InstanceOf: HealthcareServiceZentrum
Usage: #example
Description: "Zentrums-Ebene des Krankenhausverzeichnisses"
* meta.tag[Origin] = Origin#ldap
* extension[offeredIn].valueReference = Reference(KhvzStandortExample)
* providedBy = Reference(KhvzKrankenhausOrganizationExample)
* identifier[erId].value = "123456-02"
* category[VzdLevelVS] = VzdLevelCS#zentrum "Zentrum"
* type = InEKZentrenarten#02 "Onkologisches Zentrum"
* name = "Musterklinik gGmbH - Onkologisches Zentrum"

// --- Fachabteilung ----------------------------------------------------------
Instance: KhvzFachabteilungExample
InstanceOf: HealthcareServiceFachabteilung
Usage: #example
Description: "Fachabteilungs-Ebene des Krankenhausverzeichnisses"
* meta.tag[Origin] = Origin#ldap
* extension[offeredIn].valueReference = Reference(KhvzEinrichtungExample)
* providedBy = Reference(KhvzKrankenhausOrganizationExample)
* identifier[erId].value = "771234001-0100"
* category[VzdLevelVS] = VzdLevelCS#fachabteilung "Fachabteilung"
* type = $Fachabteilungsschluessel#0100 "Innere Medizin"
* name = "Musterklinik gGmbH - Innere Medizin"
