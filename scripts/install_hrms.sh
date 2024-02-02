#!/bin/bash

sudo apt update 

sleep 20s
sudo apt install docker.io docker-compose -y

sudo usermod -aG docker ubuntu
sudo chmod 777 /var/run/docker.sock
sleep 20s
# git clone https://argadepp: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@github.com/argadepp/frappe-hrms.git
cd frappe-hrms

docker-compose up -d

docker exec -it frappe-hrms_frappe_1 bash -c "cd /home/frappe && bench init --skip-redis-config-generation frappe-bench"
docker cp common_site_config.json frappe-hrms_frappe_1:/home/frappe/frappe-bench/sites/
docker exec -it frappe-hrms_frappe_1 bash -c "cd /home/frappe/frappe-bench && bench get-app erpnext && bench get-app hrms"
docker exec -it frappe-hrms_frappe_1 bash -c "cd /home/frappe/frappe-bench && bench new-site hrms --force --no-mariadb-socket --admin-password=admin --db-host=mariadb --db-root-password=123 --install-app erpnext --set-default"
docker exec -it frappe-hrms_frappe_1 bash -c "cd /home/frappe/frappe-bench && bench --site hrms install-app hrms"
docker exec frappe-hrms_frappe_1 bash -c "cd /home/frappe/frappe-bench && bench start &"

# Define variables
# KEY_TO_REPLACE="DOMAIN"
# NEW_VALUE=$1

# # Run sed command
# sed -i "s/^${KEY_TO_REPLACE}=.*/${KEY_TO_REPLACE}=${NEW_VALUE}/" .env

# docker-compose -f caddy-compose.yaml up -d

echo "HRMS app installed successfully and running!!!!!!!!!!!!"