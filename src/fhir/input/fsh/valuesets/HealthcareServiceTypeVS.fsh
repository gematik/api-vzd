// TODO: Alle hier eingebundenen *_OID_URL-CodeSystems sind lokale Kopien externer Terminologien und existieren nur,
//       weil der VZD die OIDs als coding.system verwendet. Bei einer Umstellung auf URL-Canonicals koennen sie
//       gemeinsam durch Paket-Terminologien ersetzt werden: de.ihe-d.terminology#3.0.1 (Fachrichtungen aerztlich/
//       nicht-aerztlich, patientenbezogene/nicht-patientenbezogene Gesundheitsversorgung) und de.gematik.terminology
//       (zahnaerztliche Fachrichtungen) - Details je CodeSystem in input/fsh/codesystems/external.
ValueSet: HealthcareServiceTypeVS
Description: "ValueSet for `HealthcareService.type`"
* insert Meta
* include codes from system AerztlicheFachrichtungen_OID_URL
* include codes from system ZahnaerztlicheFachrichtungen_OID_URL
* include codes from system NichtAerztlicheFachrichtungen_OID_URL
* include codes from system PatientenbezogeneGesundheitsversorgung_OID_URL
* include codes from system NichtPatientenbezogeneGesundheitsversorgung_OID_URL
* include codes from system PharmacyTypeCS