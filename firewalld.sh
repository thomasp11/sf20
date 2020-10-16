#!/bin/bash

IP='0.0.0.0'
INTERFACE='eth0'

sudo firewall-cmd --new-zone=huney --permanent
sudo systemctl restart firewalld

sudo firewall-cmd --zone=huney --set-target=ACCEPT --permanent
sudo systemctl restart firewalld

sudo firewall-cmd --zone=huney --add-masquerade --permanent
sudo systemctl restart firewalld

sudo firewall-cmd --zone=huney --change-interface=${INTERFACE} --permanent
sudo firewall-cmd --zone=huney --add-forward-port=port=1-65534:proto=tcp:toport=65535:toaddr=${IP} --permanent
