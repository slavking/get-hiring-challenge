##Zadatak 1:

Napraviti EC2 instancu na AWS platformi koristeci sledece parametre:
AMI: Amazon Linux 2 (64-bit)
Type: t2.micro
VPC: custom (non-default) --> kreirati custom VPC
Subnet: custom (non-default) --> kreirati custom public subnet

- Instalirati i startovati Apache Web Server na datoj instanci. Omoguciti javni pristup default web stranici Apache web 
servera, i SSH pristup datom serveru samo sa svoje IP adrese.
  Koristeci AWS tagove, prilepiti sledece metapodatke za datu EC2 instancu:

  Tag key: Name, Tag value: test-ec2;

  Tag key: Description, Tag value: Test instance;

  Tag key: CostCenter, Tag value: 123456;

Napomena: Obavezno koristiti IaC (Infrastructure as Code) tool po izboru (Terraform/CloudFormation), za podizanje 
prethodno opisane infrastrukture.


##Zadatak 2:

Napraviti u programskom jeziku po izboru (Python/PowerShell) program, koji salje sledecu poruku na email: "Hello, world!".
Potrebno je da se data poruka salje jednom dnevno u 1h ujutru. Veci deo logike programa treba da bude implementiran preko AWS servisa.

Hints: Prilikom realizacije koristiti sledece AWS tehnologije: 
AWS Lambda, 
AWS CloudWatch/EventBridge, 
Simple Notification Service (SNS). 
AWS Lambda koristiti za izvrsavanje koda, EventBridge/CloudWatch koristiti za zakazivanje periodicnog izvrsavanja 
datog programa, a SNS koristiti za objavljivanje date poruke u okviru odredjenog topic-a. 
Consumeri (sa odredjenim email-om) je potrebno da se rucno subscribuju na dati topic - ovaj deo logike nije potrebno implementirati u samom kodu.