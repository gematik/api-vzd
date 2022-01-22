CodeSystem: TIInstitutionTypeOidCS
Title: "CodeSystem for TI Institutions using OIDs"
Description: """
The codes for Institutions based on OIDs defined in gemSpec_OID 
We use a urn notation (urn:oid:[ProfessionOID from gemSpec_OID]). 
See also https://fachportal.gematik.de/fachportal-import/files/gemSpec_OID_V3.10.0.pdf
"""
* insert Meta
* ^content = #fragment
* #urn:oid:1.2.276.0.76.4.50 "Betriebsstätte Arzt"
* #urn:oid:1.2.276.0.76.4.51 "Zahnarztpraxis"
* #urn:oid:1.2.276.0.76.4.52 "Betriebsstätte Psychotherapeut"
* #urn:oid:1.2.276.0.76.4.53 "Krankenhaus"
* #urn:oid:1.2.276.0.76.4.54 "Öffentliche Apotheke"
* #urn:oid:1.2.276.0.76.4.55 "Krankenhausapotheke"
* #urn:oid:1.2.276.0.76.4.56 "Bundeswehrapotheke"
* #urn:oid:1.2.276.0.76.4.57 "Betriebsstätte Mobile Einrichtung Rettungsdienst"
* #urn:oid:1.2.276.0.76.4.58 "Betriebsstätte gematik"
* #urn:oid:1.2.276.0.76.4.59 "Betriebsstätte Kostenträger"
* #urn:oid:1.2.276.0.76.4.187 "Betriebsstätte Leistungserbringerorganisation Vertragszahnärzte"
* #urn:oid:1.2.276.0.76.4.190 "AdV-Umgebung bei Kostenträger"
* #urn:oid:1.2.276.0.76.4.223 "Betriebsstätte GKV-Spitzenverband"
* #urn:oid:1.2.276.0.76.4.226 "Betriebsstätte Mitgliedsverband der Krankenhäuser"
* #urn:oid:1.2.276.0.76.4.227 "Betriebsstätte der Deutsche Krankenhaus TrustCenter und Informationsverarbeitung GmbH"
* #urn:oid:1.2.276.0.76.4.228 "Betriebsstätte der Deutschen Krankenhausgesellschaft"
* #urn:oid:1.2.276.0.76.4.224 "Betriebsstätte Apothekerverband"
* #urn:oid:1.2.276.0.76.4.225 "Betriebsstätte Deutscher Apothekerverband"
* #urn:oid:1.2.276.0.76.4.229 "Betriebsstätte der Bundesärztekammer"
* #urn:oid:1.2.276.0.76.4.230 "Betriebsstätte einer Ärztekammer"
* #urn:oid:1.2.276.0.76.4.231 "Betriebsstätte einer Zahnärztekammer"
* #urn:oid:1.2.276.0.76.4.242 "Betriebsstätte der Kassenärztlichen Bundesvereinigung"
* #urn:oid:1.2.276.0.76.4.243 "Betriebsstätte der Bundeszahnärztekammer"
* #urn:oid:1.2.276.0.76.4.244 "Betriebsstätte der Kassenzahnärztlichen Bundesvereinigung"
* #urn:oid:1.2.276.0.76.4.245 "Betriebsstätte Gesundheits-, Kranken- und Altenpflege"
* #urn:oid:1.2.276.0.76.4.246 "Betriebsstätte Geburtshilfe"
* #urn:oid:1.2.276.0.76.4.247 "Betriebsstätte Physiotherapie"
* #urn:oid:1.2.276.0.76.4.248 "Betriebsstätte Augenoptiker"
* #urn:oid:1.2.276.0.76.4.249 "Betriebsstätte Hörakustiker"
* #urn:oid:1.2.276.0.76.4.250 "Betriebsstätte Orthopädieschuhmacher"
* #urn:oid:1.2.276.0.76.4.251 "Betriebsstätte Orthopädietechniker"
* #urn:oid:1.2.276.0.76.4.252 "Betriebsstätte Zahntechniker"
* #urn:oid:1.2.276.0.76.4.253 "Rettungsleitstelle"
* #urn:oid:1.2.276.0.76.4.254 "Betriebsstätte Sanitätsdienst Bundeswehr"
* #urn:oid:1.2.276.0.76.4.255 "Betriebsstätte Öffentlicher Gesundheitsdienst"
* #urn:oid:1.2.276.0.76.4.256 "Betriebsstätte Arbeitsmedizin"
* #urn:oid:1.2.276.0.76.4.257 "Betriebsstätte Vorsorge- und Rehabilitation"
* #urn:oid:1.2.276.0.76.4.273 "ePA KTR-Zugriffsautorisierung"
* #urn:oid:1.2.276.0.76.4.262 "Betriebsstätte Pflegeberatung nach § 7a SGB XI"
* #urn:oid:1.2.276.0.76.4.263 "Betriebsstätte Psychotherapeutenkammer"
* #urn:oid:1.2.276.0.76.4.264 "Betriebsstätte Bundespsychotherapeutenkammer"
* #urn:oid:1.2.276.0.76.4.265 "Betriebsstätte Landesapothekerkammer"
* #urn:oid:1.2.276.0.76.4.266 "Betriebsstätte Bundesapothekerkammer"
* #urn:oid:1.2.276.0.76.4.267 "Betriebsstätte elektronisches Gesundheitsberuferegister"
* #urn:oid:1.2.276.0.76.4.268 "Betriebsstätte Handwerkskammer"
* #urn:oid:1.2.276.0.76.4.269 "Betriebsstätte Register für Gesundheitsdaten"
* #urn:oid:1.2.276.0.76.4.270 "Betriebsstätte Abrechnungsdienstleister"
* #urn:oid:1.2.276.0.76.4.271 "Betriebsstätte PKV-Verband"

/*
* ^expansion.contains[+].system = "https://gematik.de/fhir/directory/CodeSystem/TIOrganizationTypeCS"
* #urn:ti-organization:tim-provider
"TI-Messenger-Provider"
* ^expansion.contains[+].system = "https://gematik.de/fhir/directory/CodeSystem/TIOrganizationTypeCS"
* #urn:ti-organization:kim-provider
"KIM-Provider"
* ^expansion.contains[+].system = "https://gematik.de/fhir/directory/CodeSystem/TIOrganizationTypeCS"
* #urn:ti-organization:card-issuer
"Kartenherausgeber"
*/

/*
* ^url = "https://gematik.de/fhir/directory/CodeSystem/TIProfessionOidCS"
* ^status = #draft
* ^content = #not-present
* ^filter.code = #urn-oid-regex-filter
* ^filter.description = "A filter to select codes that are in the oid urn format"
* ^filter.operator = #regex
* ^filter.value = "^urn:oid:([1-9][0-9]{0,3}|0)(\\.([1-9][0-9]{0,3}|0)){5,13}$"
*/