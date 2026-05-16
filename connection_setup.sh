#!/bin/bash
# colors
red=$'\e[1;31m'
grn=$'\e[1;32m' 
org=$'\e[1;93m' 
rst=$'\e[0m'

mkdir -p ~/dips

echo -e "${grn}... Adding connection watchdog ${rst}"

wget -q -O ~/dips/connection.sh https://raw.githubusercontent.com/francorosa/v-installer/master/connection.sh
sudo pm2 start connection.sh --name "connection" --interpreter bash
sudo pm2 save

echo -e "${grn}... connection installation complete!${rst}"