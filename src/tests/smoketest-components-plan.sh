#!/bin/bash

environment=$1
region=$2
bucket=$3

cd ../resources

terraform init \
--backend-config="bucket=${bucket}" \
--backend-config="key=${environment}/template-api-nodejs-state" \
--backend-config="region=${region}"

terraform plan \
-var "region=${region}"