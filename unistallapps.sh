#!/bin/sh
#unistall nginx
sudo apt-get purge nginx nginx-common
#php
sudo apt-get purge 'php*'
sudo apt-get remove --purge python2.7*
sudo apt-get remove --purge python3**
sudo apt-get purge --auto-remove nodejs
sudo apt-get purge --auto-remove npm
sudo apt-get purge --auto-remove yarn
sudo apt-get remove --purge mysql*
sudo apt-get autoremove