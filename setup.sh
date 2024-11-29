# colors
red='\e[1;31m'
grn='\e[1;32m' 
org='\e[1;93m' 
rst='\e[0m'
    
#banner
echo "${grn}       
    ____  _           
   / __ \(_)___  _____
  / / / / / __ \/ ___/
 / /_/ / / /_/ (__  ) 
/_____/_/ .___/____/  
       /_/            
${rst}"

# ask to install
while true; do
    read -p "Do you wish to install Dips and dependencies? (y/n) " yn
    case $yn in
        [Yy]* ) echo "${grn}... installing${rst}"; break;;
        [Nn]* ) echo "${red}... installation canceled${rst}";exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


# installation process
install_dependency () {
    name=$1
    install_command=$2
    if eval "$name --version"
    then
        echo "${grn} ... $name already installed, skipping${rst}"
    else
        echo "${grn} ... install $name ${rst}"
        eval $3
        eval $install_command
    fi
}

install_dependency "telnet" "sudo apt install -y telnet"
install_dependency "picocom" "sudo apt install -y picocom"
install_dependency "curl" "sudo apt install -y curl"
install_dependency "node" "sudo apt install nodejs -y" "curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - "
install_dependency "git" "sudo apt install -y git"
install_dependency "lynx" "sudo apt install -y lynx"
install_dependency "pm2" "sudo npm i -g pm2"
install_dependency "tailscale" "curl -fsSL https://tailscale.com/install.sh | sh"
sudo pm2 startup
mkdir ~/dips

# donwload settings if the file does not exists
if test -f ~/dips/settings.json; then
    echo "${org}... settings file found skipping download.${rst}"
else
    echo "${org}... downloading settings file.${rst}"
    wget -O ~/dips/settings.json https://raw.githubusercontent.com/francorosa/v-installer/master/settings.json
fi

# donwload usb update process
if test -f ~/dips/usb.js; then
    echo "${org}... usb tool skipping download.${rst}"
else
    echo "${org}... downloading usb tool.${rst}"
    wget -O ~/dips/usb.js https://raw.githubusercontent.com/francorosa/v-installer/master/usb.js
fi

sudo apt install -y build-essential libudev-dev
npm i usb;

# ask wich version to install
while true; do
    echo "${grn}Select mode:"
    echo "1: Install I21A00 - 90% Ullage ( TLS450 )"
    echo "2: Install I20100 - 100% Ullage ( TLS350 )"
    echo "3: Install I20100 - 100% Ullage ( TLS350-Serial )"
    echo "4: Install I20100 - 100% Ullage ( TLS350-Email )"
    echo "5: Install I21A00 - 90% Ullage ( TLS450-Email )"
    read -p "Enter your choice (1, 2, 3, 4 or 5): " choice
    case $choice in
        [1]* ) echo "${grn}... installing I21A00 - 90% Ullage (TLS450)${rst}"; wget -O ~/dips/api.js https://raw.githubusercontent.com/francorosa/v-installer/master/api_u_build.js; break;;
        [2]* ) echo "${red}... installing I20100 - 100% Ullage (TLS350)${rst}"; wget -O ~/dips/api.js https://raw.githubusercontent.com/francorosa/v-installer/master/api_build.js; break;;
        [3]* ) echo "${red}... installing I20100 - 100% Ullage (TLS350-Serial)${rst}"; wget -O ~/dips/api.js https://raw.githubusercontent.com/francorosa/v-installer/master/serial_build.js; npm i serialport; break;;
        [4]* ) echo "${red}... installing I20100 - 100% Ullage (TLS350-Email)${rst}"; wget -O ~/dips/api.js https://raw.githubusercontent.com/francorosa/v-installer/master/email_build.js; break;;
        [5]* ) echo "${red}... installing I20100 - 90% Ullage (TLS450-Email)${rst}"; wget -O ~/dips/api.js https://raw.githubusercontent.com/francorosa/v-installer/master/email_u_build.js; break;;
        * ) echo "Please answer 1, 2, 3, 4, or 5";;
    esac
done

sudo pm2 delete dips
sudo pm2 delete usb
sudo pm2 start ~/dips/api.js --restart-delay 5000 --max-memory-restart 300M --name "dips"
sudo pm2 start ~/dips/usb.js --restart-delay 5000 --max-memory-restart 300M --name "usb"
sudo pm2 save

# tailscale installation

rm z
echo "${grn}... installation complete!${rst}"

echo "${grn}... don't forget to edit ${red}dips/settings.json ${rst}"
echo "${grn}... after any settings change run ${red}sudo pm2 restart dips${rst}"
