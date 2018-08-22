#!/bin/bash

user=$(whoami)
group=staff

user_mysql=root
pass_mysql=root

echo "Welcome "$user

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
  echo "\n\n >> Please install xcode [xcode-select --install] and re-run this init file"
  exit 1
fi

if ! [ -x "$(command -v pip)" ]; then
  echo "\n\n >> Please install pip [sudo easy_install pip] and re-run this init file"
  exit 1
fi

if ! [ -x "$(command -v ansible-galaxy)" ]; then
  echo "\n\n >> Please install Ansible [sudo pip install ansible] and re-run this init file"
  exit 1
fi

read -p "Have you stop apachectl? [y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '\nWell done apachectl is down!'
else
    echo 'sudo apachectl stop'
    echo 'sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null'
    exit 1
fi

echo "\n\nPlease install Ansible requirements [ansible-galaxy install -r requirements.yml]"
echo "\nPlease rename custom.config.yml to config.yml and verify config files (dotfiles_repo_local_destination)"
echo "\nPlease run Ansible Playbook [ansible-playbook main.yml -i inventory -K]"

echo "\nShow Library folder"
chflags nohidden ~/Library
echo "\nShow hidden files"
defaults write com.apple.finder AppleShowAllFiles YES
echo "\nShow path bar"
defaults write com.apple.finder ShowPathbar -bool true
echo "\nShow status bar"
defaults write com.apple.finder ShowStatusBar -bool true

exit 0