#!/bin/bash
cd ../

# Define variables
KEY_TO_REPLACE="DOMAIN"
NEW_VALUE=$1

# Run sed command
sed -i "s/^${KEY_TO_REPLACE}=.*/${KEY_TO_REPLACE}=${NEW_VALUE}/" .env

docker-compose -f caddy-compose.yaml up -d

echo "Enabled successfully https on site "https://$NEW_VALUE" , please access it."