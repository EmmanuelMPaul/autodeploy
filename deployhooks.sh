#!/bin/sh
clear
echo
echo
echo "\033[34m*********************************************\e[0m"
echo "\033[32m***  WELCOME TO AUTO GIT HOOK SETUP TOOL  ***\e[0m"
echo "\033[34m*********************************************\e[0m"
echo "\033[32mLOADING...\e[0m"
sleep 3s
#temp dir
clear
nextcmd="\033[32mloading next command ...\e[0m"
read -p "Enter repo name: var/ "  repo
gitrepo="/var/$repo"
prod='/var/www'
sudo mkdir -p $gitrepo/tmp/
sudo chgrp -R users $gitrepo/tmp/
sudo chmod g+w $gitrepo/tmp/
echo
echo "\033[33mdefault git hook repo:  $gitrepo craeted\e[0m"
echo $nextcmd
sleep 2s

#enter website name
read -p "Enter Your project|website name: "  project
#prod dir
sudo mkdir -p $prod/$project
sudo chgrp -R users $prod/$project
sudo chmod g+w $prod/$project

echo
echo "\033[33mdefault production dir: $prod/$project craeted\e[0m"
echo $nextcmd
sleep 2s

#create git repo
sudo mkdir -p $gitrepo/git/$project.git
# Init the repo as an empty git repository
cd $gitrepo/git/$project.git
sudo git init --bare


echo
echo  "\033[33mgit repo initialized\e[0m"
echo  $nextcmd
sleep 2s

#set permission for Git Repo
cd $gitrepo/git/$project.git
# Define group recursively to "users", on the directories
sudo chgrp -R users .
# Define permissions recursively, on the sub-directories 
# g = group, + add rights, r = read, w = write, X = directories only
# . = curent directory as a reference
sudo chmod -R g+rwX .
# Sets the setgid bit on all the directories
sudo find . -type d -exec chmod g+s '{}' +
# Make the directory a Git shared repo
sudo git config core.sharedRepository group

#create hook file 
cd $gitrepo/git/$project.git/hooks
# create a post-receive file
sudo touch post-receive
# make it executable 
sudo chmod +x post-receive
         
#create post-receive hook file
>post-receive
STR="#!/bin/bash"
echo $STR>> post-receive
target="$prod/$project"
STR2="TARGET=\"$target\""
echo $STR2>> post-receive
# A temporary directory for deployment
temp="$gitrepo/tmp/$project"
STR3="TEMP=\"$temp\""
echo $STR3>> post-receive
# The Git repo
repo="$gitrepo/git/$project.git"
STR4="REPO=\"$repo\""
echo $STR4>> post-receive
# Deploy the content to the temporary directory
STR5='mkdir -p $TEMP'
echo $STR5>> post-receive
STR6='git --work-tree=$TEMP --git-dir=$REPO checkout -f'
echo $STR6>> post-receive
STR7='cd $TEMP'
echo $STR7>> post-receive
#install project packages
read -p "run composer install (Press y|Y for Yes, any other key for No) : "  composercmd
if [ $composercmd = 'y' ] || [ $composercmd = 'Y' ]
then
    echo 'composer install'>> post-receive
    sleep 2s
fi
read -p "npm run install & prod (Press y|Y for Yes, any other key for No) : "  npmcmd
if [ $npmcmd = 'y' ] || [ $npmcmd = 'Y' ]
then
    echo 'npm install'>> post-receive   
    echo 'npm prod'>> post-receive   
    sleep 2s
fi
# with the temporary directory
STR8="cd /"
echo $STR8>> post-receive
STR9='rm -rf $TARGET'
echo $STR9>> post-receive
STR10='mv $TEMP $TARGET'
echo $STR10>> post-receive

echo
echo "\033[33mgit hook post-receive created\e[0m"
sleep 2s

echo
echo "\033[32mDONE\e[0m"
echo "\033[36mDeploy from the local computer\e[0m"
echo "\033[36mgit remote add deploy ssh://<your-name>@<your-ip>$gitrepo/git/$project.git/\e[0m"
