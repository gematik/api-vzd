Alias: $version = 0.11.22

RuleSet: Meta
* ^status = #active
* ^experimental = false
* ^publisher = "gematik GmbH"
* ^date = "2024-10-29"
* ^version = $version

RuleSet: MetaInstance
* version = $version
* status = #active
* experimental = false
* publisher = "gematik GmbH"
* date = "2024-10-29"

RuleSet: refChain(code)
* extension[+]
  * url = $refChainEx
  * extension
    * url = "code"
    * valueCode = #{code}