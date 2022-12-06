#!/bin/bash
clear
# This script will download the latest validation script from the template source save it
# to the scripts_folder and execute it to validate your fhir ressources.
script_name=downloaded_validation_script.sh
script_path=./scripts/$script_name

parentdir="$(dirname "$script_path")"
mkdir -p "$parentdir"

curl https://raw.githubusercontent.com/gematik/spec-TemplateForSimplifierProjects/master/scripts/$script_name -o $script_path
chmod a+x $script_path
$script_path "$@"
