#!/bin/bash
domain=$1
app=$2
sudo apt update 

sleep 20s
sudo apt install docker.io docker-compose -y

sudo usermod -aG docker ubuntu
sudo chmod 777 /var/run/docker.sock
sleep 20s


docker-compose -p $app up -d

docker exec -it $app"_frappe_1" bash -c "cd /home/frappe && bench init --skip-redis-config-generation frappe-bench"
docker cp common_site_config.json $app"_frappe_1":/home/frappe/frappe-bench/sites/
docker exec -it $app"_frappe_1" bash -c "cd /home/frappe/frappe-bench && bench get-app erpnext && bench get-app hrms"
docker exec -it $app"_frappe_1" bash -c "cd /home/frappe/frappe-bench && bench new-site $domain --force --no-mariadb-socket --admin-password=admin --db-host=mariadb --db-root-password=123 --install-app erpnext --set-default"
docker exec -it $app"_frappe_1" bash -c "cd /home/frappe/frappe-bench && bench --site $domain install-app hrms"
docker exec $app"_frappe_1" bash -c "cd /home/frappe/frappe-bench && bench start &"


echo "HRMS app installed successfully and running!!!!!!!!!!!!"