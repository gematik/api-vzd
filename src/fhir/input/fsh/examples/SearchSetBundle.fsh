Instance: FilteredSearchSetBundle
InstanceOf: Bundle
Usage: #example
* type = #searchset
* total = 3
  * extension[ResultsFilteredEx]
    * extension[count].valueInteger = 15
    * extension[reason].valueString = "Reason: hideVersicherte"
* entry[0].fullUrl = "http://example.org/fhir/Endpoint/MessengerEndpointWithVisibility"
* entry[=].resource = MessengerEndpointWithVisibility
* entry[+].fullUrl = "http://example.org/fhir/Endpoint/OrganizationExample001-Endpoint-TIM"
* entry[=].resource = OrganizationExample001-Endpoint-TIM