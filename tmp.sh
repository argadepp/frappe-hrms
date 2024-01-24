#!/bin/bash

# Define variables
KEY_TO_REPLACE="DOMAIN"
NEW_VALUE=$1

# Run sed command
sed -i "s/^${KEY_TO_REPLACE}=.*/${KEY_TO_REPLACE}=${NEW_VALUE}/" .env
