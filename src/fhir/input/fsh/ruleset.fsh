Alias: $version = 1.1.0

RuleSet: Meta
* ^status = #active
* ^experimental = false
* ^publisher = "gematik GmbH"
* ^date = 2025-02-26
* ^version = $version

RuleSet: MetaInstance
* version = $version
* status = #active
* experimental = false
* publisher = "gematik GmbH"
* date = 2025-02-26

RuleSet: refChain(code)
* extension[+]
  * url = $refChainEx
  * extension
    * url = "code"
    * valueCode = #{code}