# colors
red='\e[1;31m'
grn='\e[1;32m' 
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

install_dependency "curl" "sudo apt-get install -y curl "
install_dependency "git" "sudo apt-get install  -y git"
install_dependency "node" "sudo apt install nodejs -y" "curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - "
install_dependency "pm2" "sudo npm i -g pm2"
sudo pm2 startup
wget -O ~/settings.json https://raw.githubusercontent.com/francorosa/v-installer/master/settings.json

# ask wich version to install
while true; do
    read -p "Select mode:\n 1: Install I21A00 - 90% Ullage (TLS450)\n 2: Install I20100 - 100% Ullage (TLS350) (1/2)" yn
    case $yn in
        [1]* ) echo "${grn}... installing I21A00 - 90% Ullage (TLS450)${rst}"; wget -O ~/api.js https://raw.githubusercontent.com/francorosa/v-installer/master/api_u_build.js; break;;
        [2]* ) echo "${red}... installing I20100 - 100% Ullage (TLS350)${rst}"; wget -O ~/api.js https://raw.githubusercontent.com/francorosa/v-installer/master/api_build.js; break;;
        * ) echo "Please answer 1 or 2.";;
    esac
done


sudo pm2 start ~/api.js --restart-delay 5000 --max-memory-restart 300M --name "dips"
sudo pm2 save

rm z
echo "${grn}... done${rst}"

echo "${grn}... Don't forget to edit settings.js to set the right id, times and email receivers${rst}"
echo "${grn}... After any settings change run 'sudo pm2 restart dips'${rst}"