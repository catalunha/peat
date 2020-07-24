# 1 Gerar
keytool -genkey -v -keystore peat.keystore -alias peat -keyalg RSA -keysize 2048 -validity 10000

catalunha@stack:~/flutter-projects/peat$ keytool -genkey -v -keystore peat.keystore -alias peat -keyalg RSA -keysize 2048 -validity 10000
Enter keystore password:  
Re-enter new password: 
What is your first and last name?
  [Unknown]:  peat
What is the name of your organizational unit?
  [Unknown]:  peat
What is the name of your organization?
  [Unknown]:  peat
What is the name of your City or Locality?
  [Unknown]:  peat
What is the name of your State or Province?
  [Unknown]:  peat
What is the two-letter country code for this unit?
  [Unknown]:  peat
Is CN=peat, OU=peat, O=peat, L=peat, ST=peat, C=peat correct?
  [no]:  yes

Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 10,000 days
	for: CN=peat, OU=peat, O=peat, L=peat, ST=peat, C=peat
[Storing peat.keystore]
catalunha@stack:~/flutter-projects/peat$ ls
android  build  doc  ios  lib  peat.iml  peat.keystore  peat.zip  pubspec.lock  pubspec.yaml  README.md  test  web
catalunha@stack:~/flutter-projects/peat$ 

## Senha
senha: peattaep

# 2 Listar

keytool -list -v -alias peat -keystore peat.keystore

catalunha@stack:~/flutter-projects/peat$ keytool -list -v -alias peat -keystore peat.keystore
Enter keystore password:  
Alias name: peat
Creation date: Jul 24, 2020
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: CN=peat, OU=peat, O=peat, L=peat, ST=peat, C=peat
Issuer: CN=peat, OU=peat, O=peat, L=peat, ST=peat, C=peat
Serial number: 3e8cda7c231eeb76
Valid from: Fri Jul 24 11:13:24 BRT 2020 until: Tue Dec 10 11:13:24 BRT 2047
Certificate fingerprints:
	 SHA1: 8B:39:9D:09:6A:E2:33:E7:D8:AD:D9:FF:49:1F:C3:A2:F1:E2:8A:BB
	 SHA256: 64:A0:2A:6C:3C:32:C1:11:38:4F:94:B9:FD:DB:5A:2E:F5:77:24:F8:6F:D7:9F:8F:9F:3A:D8:8C:85:54:20:28
Signature algorithm name: SHA256withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 3

Extensions: 

#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
KeyIdentifier [
0000: 14 69 62 46 C3 06 63 15   02 EA A0 B8 C5 1A E7 C1  .ibF..c.........
0010: 6E EF 44 2E                                        n.D.
]
]

catalunha@stack:~/flutter-projects/peat$ 
