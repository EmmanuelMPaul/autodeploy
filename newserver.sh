#!/bin/sh
# update apt
sudo apt update
sudo apt upgrade
echo
echo 'system update & ugraded'
echo 'loading next command ...'
sleep 3s
#install python 
sudo apt-get remove --purge python2.7* 
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.7
echo
echo 'python3.7 installed'
echo 'loading next command ...'
sleep 3s
#install nginx web server
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
#make www-data (Nginx user)
sudo chown www-data:www-data /var/www/html -R
echo
echo 'nginx webserver installed'
echo 'loading next command ...'
sleep 3s
#install mysql
sudo apt-get install mysql-server -y
#secure mysql install
sudo mysql_secure_installation
echo
echo 'nginx mysql-server installed'
echo 'loading next command ...'
sleep 3s
#install php
sudo apt install php7.2 php7.2-fpm php7.2-mysql php-common php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline php7.2-mbstring php7.2-xml php7.2-gd php7.2-curl php7.2-zip -y
sudo systemctl start php7.2-fpm
sudo systemctl enable php7.2-fpm
echo
echo 'nginx php7.2 installed'
echo 'loading next command ...'
sleep 3s
#install composer
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer global require laravel/installer
echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
echo
echo 'composer& laravel installed'
echo 'loading next command ...'
sleep 3s
#install nodejs
sudo apt install nodejs -y
sudo apt install npm -y
echo
echo 'node & npm installed'
echo 'loading next command ...'
sleep 3s
#install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn -y
echo
echo 'yarn installed'
echo 'loading next command ...'
sleep 3s

# update apt
sudo apt update
sudo apt upgrade
echo
echo 'system update & ugraded'
echo 'loading next command ...'
sleep 3s
#Final manuel setup
echo "TODO: Final manuel setup | config php set: cgi.fix_pathinfo=0"
echo "TODO: Final manuel setup | config nginx"
#TODO set yarn path 
#export PATH="$PATH:/opt/yarn-[version]/bin"
#export PATH="$PATH:`yarn global bin`"
