# Run Validation script

Run script `validate.sh -d . -is` to

1. Run sushi FHIR Files generator
2. Validate all files in the current (`.`) folder
3. Get a html output file for each FHIR file in `../validation_results/`

You can use following script options

### Install dependencies from sushi-config.yaml

`-i` installs dependencies with firely.terminal from `sushi-config.yaml` file

```bash
./validate.sh -i
```

### Sort resulting html files into severity folders

`-s` sorts resulting html files in folders by the severities of the findings.
Categories are: `error`, `warning`, `information` and `unknown`

```bash
./validate.sh -s
```

### Change default folder

`-d foldername` sets foldername for validation. Default is: `./Resources`

```bash
validate.sh -d ./Testresources
```

### Process single file

`-f filename` sets filename for single validation.

```bash
validate.sh -f ./Resources/fsh-generated/resources/myProfile.json
```

### Work with specific version of Hapi Validator

`-v version` defines a version od the used Hapi Validator. If the specified version of the hapi validator is not present the default will be used. Validator-JARs will be downloaded to ~/.fhir/validators/.

```bash
validate.sh -v 5.6.70
```