Invariant: VZD-Service-Opening-Time
Description: "Only allows either specialOpeningTimes extension or daysOfWeek, availableStartTime, availableEndTime"
Expression: "extension('https://gematik.de/fhir/directory/StructureDefinition/SpecialOpeningTimesEX').exists() xor (daysOfWeek.exists() and availableStartTime.exists() and availableEndTime.exists())"
Severity: #error