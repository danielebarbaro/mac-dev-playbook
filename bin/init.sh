#!/bin/bash

user=$(whoami)
group=staff

user_mysql=root
pass_mysql=root

echo "Welcome "$user

#if ! [ -x "$(command -v git)" ]; then
#  echo 'Error: git is not installed.' >&2
#  exit 1
#fi

root_folder="/Users/$user/Development"
themes_folder="/Users/$user/themes"
config_folder="/Users/$user/config"
library_launch_folder="~/Library/LaunchAgents"

#create folders tree
if [ ! -d "$root_folder" ]; then
    printf "\nCreating folder $root_folder\n\n"
    mkdir -p $root_folder
fi

if [ ! -d "$themes_folder" ]; then
    printf "\nCreating folder $themes_folder\n\n"
    mkdir -p $themes_folder
fi

if [ ! -d "$config_folder" ]; then
    printf "\nCreating folder $config_folder\n\n"
    mkdir -p $config_folder
fi

if [ ! -d "$library_launch_folder" ]; then
    printf "\nCreating LaunchAgents folder\n\n"
    mkdir -p $library_launch_folder
fi

if ! [ -x "$(command -v xcode-select)" ]; then
  echo "\n\nInstalling xcode..."
  xcode-select --install
fi

read -p "Have you stop apachectl? [y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '\nWell done!'
else
    echo 'sudo apachectl stop'
    echo 'sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null'
    exit 1
fi

# install homebrew
`which -s brew`
if [[ $? != 0 ]]; then
    echo "\n\nInstalling Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "\n\nRunning Homebrew Updates..."
    brew update && brew upgrade
fi

brew doctor
