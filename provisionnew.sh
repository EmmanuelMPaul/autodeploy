#!/bin/sh
clear
echo
echo "\033[34m*********************************************\e[0m"
echo "\033[32m***      WELCOME TO AUTODEPLOY TOOL       ***\e[0m"
echo "\033[34m*********************************************\e[0m"
echo "\033[32mLOADING...\e[0m"
# update apt
nextcmd="\033[32mloading next command ...\e[0m"
sudo apt update
sudo apt upgrade
echo
echo "\033[33msystem update & ugraded\e[0m"
echo $nextcmd
sleep 3s
#install python 
read -p"install python3 (Press y|Y for Yes, any other key for No) : "  python3cmd
if [ $python3cmd = 'y' ] || [ $python3cmd = 'Y' ]
then
    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install python3.7
    echo
    echo "\033[33mpython3.7 installed\e[0m"
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

#install mysql
read -p "install mysql-server (Press y|Y for Yes, any other key for No) : "  mysqlcmd
if [ $mysqlcmd = 'y' ] || [ $mysqlcmd = 'Y' ]
then
    sudo apt-get install mysql-server -y
    #secure mysql install
    sudo mysql_secure_installation
    echo
    echo "\033[33mmysql-server installed\e[0m"   
    echo $nextcmd
    sleep 3s
fi

#install php
read -p "install php7.2 (Press y|Y for Yes, any other key for No) : "  php72cmd
if [ $php72cmd = 'y' ] || [ $php72cmd = 'Y' ]
then
    sudo apt install php7.2 php7.2-fpm php7.2-mysql php-common php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline php7.2-mbstring php7.2-xml php7.2-gd php7.2-curl php7.2-zip -y
    sudo systemctl start php7.2-fpm
    sudo systemctl enable php7.2-fpm
    echo
    echo "\033[33mphp7.2  installed\e[0m" 
    echo $nextcmd
    sleep 3s
fi

#install composer
read -p "install composer(Press y|Y for Yes, any other key for No) : "  composercmd
if [ $composercmd = 'y' ] || [ $composercmd = 'Y' ]
then
    cd ~
    curl -sS https://getcomposer.org/installer -o composer-setup.php
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    composer global require laravel/installer
    echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
    echo
    echo "\033[33mcomposer& laravel installer installed\e[0m"
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
    echo 'node & npm installed'
    echo "\033[33mnode & npm installed\e[0m"
    echo $nextcmd
    sleep 3s
fi

#install yarn
read -p "install yarn (Press y|Y for Yes, any other key for No) : "  yarncmd
if [ $yarncmd = 'y' ] || [ $yarncmd = 'Y' ]
then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update
    sudo apt-get install yarn -y
    echo
    echo "\033[33myarn installed\e[0m"
    echo $nextcmd
    sleep 3s
fi
# update apt
sudo apt update
sudo apt upgrade
echo
echo "\033[33msystem update & ugraded\e[0m"
sleep 3s
#Final manuel setup
echo "\033[36mTODO: config php ini set: cgi.fix_pathinfo=0\e[0m"
echo "\033[36mTODO: set nginx root \e[0m"
echo "\033[36mapt packages installed\e[0m"
echo "\033[36mnginx\e[0m"
nginx -v
echo "\033[36mphp\e[0m"
php -v
echo "\033[36myarn\e[0m"
yarn -v
echo "\033[36mnode\e[0m"
node -v
echo "\033[36mnpm\e[0m"
npm -v
composer --version
laravel --version

#TODO set yarn path 
#export PATH="$PATH:/opt/yarn-[version]/bin"
#export PATH="$PATH:`yarn global bin`"
