#!/usr/bin/env python3
import code
from ntpath import join
from posixpath import split
import sys
import xml.etree.ElementTree as ET
import urllib.request

VERSION="2.5.0-2"

def generate_value_set(url, output_file, template):

  lines = template.split("\n")

  tree = ET.parse( urllib.request.urlopen(url))

  for include in tree.findall('.//{http://hl7.org/fhir}include'):
    comment = include.find("{http://hl7.org/fhir}extension/{http://hl7.org/fhir}valueString").attrib['value']
    system = include.find("{http://hl7.org/fhir}system").attrib['value']
    lines.append(f'// {comment}')
    for concept in include.findall("{http://hl7.org/fhir}concept"):
      code = concept.find("{http://hl7.org/fhir}code").attrib['value']
      display = concept.find("{http://hl7.org/fhir}display").attrib['value']
      lines.append(f'* {system}#{code} "{display}"')
    
  open(output_file, "wt").write("\n".join(lines))

generate_value_set(
  url=f"https://raw.githubusercontent.com/gematik/api-ePA/{VERSION}/src/vocabulary/value_sets/vs-practice-setting-code.xml",
  output_file="input/fsh/valuesets/GEM_DIR_VS_OrganizationType.fsh",
  template="""ValueSet: GEM_DIR_VS_OrganizationType
Description: "ValueSet for `Organization.type`"
* insert Meta
* include codes from system GEM_DIR_CS_OrganizationProfessionOID
* include codes from system GEM_DIR_CS_OrganizationProviderType"""
)

generate_value_set(
  url=f"https://raw.githubusercontent.com/gematik/api-ePA/{VERSION}/src/vocabulary/value_sets/vs-author-specialty.xml",
  output_file="input/fsh/valuesets/GEM_DIR_VS_PractitionerRoleSpecialty.fsh",
  template="""ValueSet: GEM_DIR_VS_PractitionerRoleSpecialty
Description: "ValueSet for `PractitonerRole.specialty`"
* insert Meta
* include codes from system GEM_DIR_CS_PractitionerProfessionOID"""
)
