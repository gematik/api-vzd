Invariant: VZD-Service-Opening-TimeInv
Description: "Only allows either specialOpeningTimes extension or daysOfWeek, availableStartTime, availableEndTime"
Expression: "extension('https://gematik.de/fhir/directory/StructureDefinition/SpecialOpeningTimesEX').exists() xor (daysOfWeek.exists() and availableStartTime.exists() and availableEndTime.exists())"
Severity: #error

Invariant: CodingSytemCodeInv
Description: "System and Code SHOULD be present"
Expression: "system.exists() and code.exists()"
Severity: #warning