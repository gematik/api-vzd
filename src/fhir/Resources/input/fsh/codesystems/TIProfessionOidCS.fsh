CodeSystem: TIProfessionOidCS
Title: "CodeSystem of ProfessionOIDs from gemSpec_OID"
Description: "The codes for TIOrganization and TIPractitioner types are defined in gemSpec_OID and use a urn notation (urn:oid:[ProfessionOID from gemSpec_OID]). See also https://fachportal.gematik.de/fachportal-import/files/gemSpec_OID_V3.10.0.pdf"
* ^url = "https://gematik.de/fhir/directory/CodeSystem/TIProfessionOidCS"
* ^status = #draft
* ^content = #not-present
* ^filter.code = #urn-oid-regex-filter
* ^filter.description = "A filter to select codes that are in the oid urn format"
* ^filter.operator = #regex
* ^filter.value = "^urn:oid:([1-9][0-9]{0,3}|0)(\\.([1-9][0-9]{0,3}|0)){5,13}$"