#!/bin/sh

aws configure
terraform init
terraform validate
terraform plan -out=plan.txt
terraform apply "plan.txt" -auto-approve
