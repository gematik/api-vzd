#!/usr/bin/env python3
import sys
import xml.etree.ElementTree as ET
import subprocess
import tempfile
import os
import json

NS = {'ns': 'urn:gematik:testkarten:20'}

def convert_smcb(filename):  
  tree = ET.parse( open(filename))
  smcb = tree.find('.//ns:SMC-B', NS)
  if smcb == None:
    return
  cert_enc_rsa = smcb.find(".//ns:ElementaryFile[ns:EFName='EF.C.HCI.ENC.R2048']/ns:EFContent/ns:Value", NS).text
  certinfo = convert_cert(cert_enc_rsa)
  convert_base(certinfo)
  cert_enc_ecc = smcb.find(".//ns:ElementaryFile[ns:EFName='EF.C.HCI.ENC.E256']/ns:EFContent/ns:Value", NS).text
  convert_cert(cert_enc_ecc) 

def convert_hba(filename):  
  tree = ET.parse( open(filename))
  hba = tree.find('.//ns:HBA', NS)
  if hba == None:
    return
  cert_enc_rsa = hba.find(".//ns:ElementaryFile[ns:EFName='EF.C.HP.ENC.R2048']/ns:EFContent/ns:Value", NS).text
  certinfo = convert_cert(cert_enc_rsa)
  convert_base(certinfo)
  cert_enc_ecc = hba.find(".//ns:ElementaryFile[ns:EFName='EF.C.HP.ENC.E256']/ns:EFContent/ns:Value", NS).text
  convert_cert(cert_enc_ecc) 

def convert_base(certinfo):
  telematikID = certinfo['admissionStatement']['registrationNumber']
  base = {
    "telematikID": telematikID,
    "displayName": certinfo['subjectInfo']['cn'],
    "cn": certinfo['subjectInfo']['cn'],
    "givenName": certinfo['subjectInfo'].get('givenName', None),
    "sn": certinfo['subjectInfo'].get('givenName', None),
    "title": certinfo['subjectInfo'].get('title', None),
    "streetAddress": certinfo['subjectInfo'].get('streetAddress', None),
    "postalCode": certinfo['subjectInfo'].get('postalCode', None),
    "localityName": certinfo['subjectInfo'].get('localityName', None),
    "stateOrProvinceName": certinfo['subjectInfo'].get('stateOrProvinceName', None),
    "countryCode": certinfo['subjectInfo']['countryCode'],
  }
  print(f"Writing {telematikID}.json")
  open(f"{telematikID}.json", "wt").write(json.dumps(base, indent=4, ensure_ascii=False))

def convert_cert(cert_hex):
  
  fd, temp_filename = tempfile.mkstemp()
  temp = open(temp_filename, 'wb')
  temp.write(bytes.fromhex(cert_hex))
  temp.close()
  cert_json = subprocess.check_output(["vzd-cli", "admin", "--json", "cert-info", temp_filename])
  certinfo = json.loads(cert_json)
  telematikID = certinfo['admissionStatement']['registrationNumber']
  serialNumber = certinfo['serialNumber']
  print(f"Writing {telematikID}-{serialNumber}.der")
  os.rename(temp_filename, f"{telematikID}-{serialNumber}.der")
  return certinfo

if len(sys.argv) != 2:
  print("Usage: ./convert.py <Auftrag.xml>")

convert_smcb(sys.argv[1])
convert_hba(sys.argv[1])