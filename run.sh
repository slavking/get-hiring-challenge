#!/bin/sh

aws configure
terraform init
terraform validate
terraform plan -out=plan.txt
terraform apply -auto-approve plan.txt
