#!/usr/bin/bash
# colors
red='\e[1;31m'
grn='\e[1;32m' 
org='\e[1;93m' 
rst='\e[0m'
echo "${grn}... Adding connection watchdog ${rst}"

wget -O ~/dips/connection.sh https://raw.githubusercontent.com/francorosa/v-installer/master/connection.sh
mkdir ~/dips
sudo pm2 start connection.sh --name "connection" --interpreter bash
sudo pm2 save

echo "${grn}... connection installation complete!${rst}"

