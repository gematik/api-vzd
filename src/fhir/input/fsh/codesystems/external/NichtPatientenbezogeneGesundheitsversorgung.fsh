//FIXME: URL in IHE http://ihe-d.de/CodeSystems/NichtPatientBezogeneGesundheitsversorgung
// ABER: VZD nutzt oids analog zu den Fachrichtungen-CodeSystemen
// TODO: Solange der VZD am OID-Canonical haengt, muss dieses CodeSystem lokal gepflegt werden.
//       Bei einer Umstellung auf URL-Canonicals kann es durch de.ihe-d.terminology#3.0.1 ersetzt werden:
//       http://ihe-d.de/CodeSystems/NichtPatientBezogeneGesundheitsversorgung (Version 2018-07-13T16:21:25),
//       inhaltlich identisch (7 Codes, gleiche Displays und Definitionen).
//       Breaking: coding.system in bestehenden Instanzen wandert von urn:oid: auf die IHE-URL.

CodeSystem: NichtPatientenbezogeneGesundheitsversorgung_OID_URL
Id: nicht-patientenbezogene-gesundheitsversorgung-oid-url
Title: "NichtPatientenbezogeneGesundheitsversorgung"
Description: "Einrichtungsarten der nicht-patientenbezogenen Gesundheitsversorgung (IHE-D healthcareFacilityTypeCode)"
* insert Meta
* ^url = "urn:oid:1.3.6.1.4.1.19376.3.276.1.5.3"
* ^version = "2018-07-13T16:21:25"
* ^caseSensitive = true
* #BIL "Bildungseinrichtung" "Kindergarten, Schulen, Hochschulen und andere erzieherische Einrichtungen für Kinder oder Erwachsene"
* #FOR "Forschungseinrichtung" "Einrichtung der medizinischen Forschung außerhalb von Arztpraxis oder Krankenhaus."
* #GEN "Gen-Analysedienste" "Organisationen die Dienste für Vaterschafts-/Mutterschaftstest anbieten, für Abstammungtests, Riskoanalysen, etc."
* #MDK "Medizinischer Dienst der Krankenversicherung" "Alle medizinischen Dienste die sozialmedizinische Begutachtungen nach § 275 SGB V für die Krankenversicherungen oder Pflegebegutachtungen nach § 18 bzw. §§ 114ff SGB XI für die Pflegeversicherungen durchführen."
* #PAT "Patient außerhalb der Betreuung" "Dieser Wert kann zur Kennzeichnung der Herkunft von Dokumenten verwendet werden, die der Patient selbstständig erstellt und eingestellt hat, zum Beispiel über ein Patientenportal oder eine Smartphone-App. Daten die vom Patienten über eine solche Lösung stellvertretend für einen Heilberufler eingestellt werden (z.B. gescannter Arztbrief, DICOM-DVD) sollten nicht diesen Wert verwenden, sondern den für den Heilberufler vorgesehenen Wert."
* #SPE "Spendedienste" "Blutspendedienst, Knochenmarkspendedienst, Samenbank, Nabelschnur-Blutbank, Bio-Banken, etc."
* #VER "Versicherungsträger" "Träger der gesetzlichen Krankenversicherung (d.h. Krankenkasse) oder der privaten Krankenversicherung."
