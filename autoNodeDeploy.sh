#!/bin/sh
clear
echo
echo
echo "\033[34m*********************************************\e[0m"
echo "\033[32m***   NODE PROJECT AUTO AUTODEPLOY TOOL   ***\e[0m"
echo "\033[34m*********************************************\e[0m"
echo "\033[32mLOADING...\e[0m"
sleep 3s
# update | upgrade apt
nextcmd="\033[32mloading next command ...\e[0m"
sudo apt update
sudo apt upgrade
clear
echo $nextcmd
sleep 3s
#install git
read -p "install git (Press y|Y for Yes, any other key for No) : "  gitcmd
if [ $gitcmd = 'y' ] || [ $gitcmd = 'Y' ]
then
    sudo apt install git -y
    echo
    echo "\033[33mgit installed\e[0m"
    echo $nextcmd
    sleep 3s
fi

#install nodejs
read -p "install node and npm (Press y|Y for Yes, any other key for No) : "  nodecmd
if [ $nodecmd = 'y' ] || [ $nodecmd = 'Y' ]
then
    sudo apt install nodejs -y
    sudo apt install npm -y
    echo
    echo "\033[33mnode & npm installed\e[0m"
    echo $nextcmd
    sleep 3s
fi

#install pm2 process manager
read -p "install pm2(process manager) (Press y|Y for Yes, any other key for No) : "  pmcmd
if [ $pmcmd = 'y' ] || [ $pmcmd = 'Y' ]
then
    sudo npm i pm2 -g
    echo
    echo "\033[33mpm2(process manager) installed\e[0m"
    echo $nextcmd
    sleep 3s
fi

#install nginx web server
read -p "install nginx (Press y|Y for Yes, any other key for No) : "  nginxcmd
if [ $nginxcmd = 'y' ] || [ $nginxcmd = 'Y' ]
then
    sudo apt install nginx -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
    #make www-data (Nginx user)
    sudo chown www-data:www-data /var/www/ -R
    echo
    echo "\033[33mnginx webserver installed\e[0m"
    echo $nextcmd
    sleep 3s
fi

#temp dir
read -p "Enter git repo url: www/ "  repo
prod='/var/www'

#enter website name
read -p "Enter Your project|website name: "  project

git clone $repo $prod/$project
#prod dir
sudo mkdir -p $prod/$project
sudo chgrp -R users $prod/$project
sudo chmod g+w $prod/$project

#Install dependencies and test app
cd $prod/$project
npm install
echo "\033[33mproject dependencies installed\e[0m"
sleep 3s
echo $nextcmd

#Setup PM2 process manager to keep your app running
read -p "Enter pm2 app (or whatever your file name) : "  pm2start
pm2 start $prod/$project/$pm2start

# Other pm2 commands
pm2 show app
pm2 status
pm2 restart app

# To make sure app starts when reboot
pm2 startup ubuntu

#Setup ufw firewall
sudo apt install ufw -y
sudo ufw enable
sudo ufw status
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

echo "\033[33mcopy the setting below before nginx default config file opens\e[0m"
echo "\033[33m****************************************************************\e[0m"
cat /var/autodeploy/nginxcofig.txt
echo "\033[33m****************************************************************\e[0m"
sleep 10s
sudo nano /etc/nginx/sites-available/default
# Check NGINX config
sudo nginx -t

# Restart NGINX
sudo service nginx restart

