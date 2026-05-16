#!/usr/bin/bash
wget -O ~/dips/connection.sh https://raw.githubusercontent.com/francorosa/v-installer/master/connection.sh
mkdir ~/dips
pm2 start connection.sh --name "connection" --interpreter bash
sudo pm2 save

echo "${grn}... connection installation complete!${rst}"

