Instance: NCPeHOrganizationExample
InstanceOf: OrganizationDirectoryStrict
Usage: #example
Description: "Example of an NCPeH Organization as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* extension[ncpehCountryEx].valueCoding = urn:iso:std:iso:3166#PT "Portugal"
* identifier[TelematikID].value = "2-2.58.00000041"
* type[profession] = OrganizationProfessionOID#1.2.276.0.76.4.292 "NCPeH Fachdienst"
* name = "NCPeH Portugal"
* active = true

Instance: NCPeHHealthcareServiceExample
InstanceOf: HealthcareServiceDirectoryStrict
Usage: #example
Description: "Example of a NCPeH HealthcareService as to be found in gematik FHIR Directory"
* meta.tag[Origin] = Origin#ldap
* providedBy = Reference(NCPeHOrganizationExample)
* category = OrganizationProfessionOID#1.2.276.0.76.4.292 "NCPeH Fachdienst"
* specialty[+] = $loinc#60591-5 "Patientenübersicht"
* specialty[+] = $loinc#57833-6 "elektronische Verordnungen"
* name = "NCPeH Portugal"