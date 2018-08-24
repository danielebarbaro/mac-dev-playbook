#!/bin/bash

user=$(whoami)
group=staff

echo "Welcome "$user

root_folder="/Users/$user/Development"
themes_folder="/Users/$user/themes"
config_folder="/Users/$user/config"

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

if ! [ -x "$(command -v xcode-select)" ]; then
  printf "\n\n >> Please install xcode [xcode-select --install && sudo xcodebuild -license accept] and re-run this init file"
  exit 1
fi

if ! [ -x "$(command -v pip)" ]; then
  printf "\n\n >> Please install pip [sudo easy_install pip] and re-run this init file"
  exit 1
fi

if ! [ -x "$(command -v ansible-galaxy)" ]; then
  printf "\n\n >> Please install Ansible [sudo pip install ansible] and re-run this init file"
  exit 1
fi

read -p "Have you stop apachectl? [y/n] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    printf '\n Well done apachectl is down!'
else
    echo 'sudo apachectl stop'
    echo 'sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null'
    exit 1
fi

printf "\n\n Please install Ansible requirements [ansible-galaxy install -r requirements.yml]"
printf "\n Please rename custom.config.yml to config.yml"
printf "\n Please run Ansible Playbook [ansible-playbook main.yml -i inventory -K]"
