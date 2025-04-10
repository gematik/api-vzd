Invariant: VZD-Service-Opening-TimeInv-1
Description: "If the specialOpeningTimes extension is set, daysOfWeek, availableStartTime, and availableEndTime must not be set."
Expression: "extension('https://gematik.de/fhir/directory/StructureDefinition/SpecialOpeningTimesEX').exists() implies (daysOfWeek.empty() and availableStartTime.empty() and availableEndTime.empty())"
Severity: #error

Invariant: VZD-Service-Opening-TimeInv-2
Description: "If the specialOpeningTimes extension is not set, daysOfWeek, availableStartTime, and availableEndTime all must be set."
Expression: "extension('https://gematik.de/fhir/directory/StructureDefinition/SpecialOpeningTimesEX').empty() implies (daysOfWeek.exists() and availableStartTime.exists() and availableEndTime.exists())"
Severity: #error

Invariant: CodingSytemCodeInv
Description: "System and Code SHOULD be present"
Expression: "system.exists() and code.exists()"
Severity: #warning