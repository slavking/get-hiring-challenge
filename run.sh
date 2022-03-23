#!/bin/sh

aws configure
terraform init
terraform verify
terraform plan -out=plan.txt
#terraform apply "plan.txt" -auto-approve
