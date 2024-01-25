#!/bin/bash
roleArn="arn:aws:iam::734522607489:role/terraform-infra-create-role"

aws sts assume-role --role-arn $roleArn --role-session-name deploy-frappe --output json --duration 3600 > ./out.json


accessKey=$(jq -r '.Credentials.AccessKeyId' ./out.json)
secretKey=$(jq -r '.Credentials.SecretAccessKey' ./out.json)
sessionToken=$(jq -r '.Credentials.SessionToken' ./out.json)


aws configure set aws_access_key_id $accessKey
aws configure set aws_secret_access_key $secretKey
aws configure set aws_session_token $sessionToken