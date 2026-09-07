// Die eingebundenen *_OID_URL-CodeSystems sind lokale Kopien externer Terminologien - noetig, weil der VZD die OIDs
// als coding.system fuehrt (wie ePA-Terminologie und LDAP-Quelle). Umstellung auf Canonicals nur gemeinsam mit gematik.
ValueSet: HealthcareServiceTypeVS
Description: "ValueSet for `HealthcareService.type`"
* insert Meta
* include codes from system AerztlicheFachrichtungen_OID_URL
* include codes from system ZahnaerztlicheFachrichtungen_OID_URL
* include codes from system NichtAerztlicheFachrichtungen_OID_URL
* include codes from system PatientenbezogeneGesundheitsversorgung_OID_URL
* include codes from system NichtPatientenbezogeneGesundheitsversorgung_OID_URL
* include codes from system PharmacyTypeCS