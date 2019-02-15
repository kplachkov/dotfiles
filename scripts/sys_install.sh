#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

apt update
apt upgrade -y

# System.
apt install -y htop tmux tree most

# Network.
apt install -y curl whois net-tools apt-transport-https ca-certificates gnupg-agent software-properties-common

# Security.
apt install -y keepassxc

# Development.
apt install -y cmake git nodejs npm pgadmin3 postgresql-client-10 python-pip python3-pip python-virtualenv
snap install go --classic
snap install protobuf --classic
snap install google-cloud-sdk --classic
snap install heroku --classic
# Git LFS.
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
# Docker.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
apt update && \
apt install -y docker-ce docker-ce-cli containerd.io
# IDEs.
snap install goland --classic
snap install webstorm --classic
snap install pycharm-professional --classic
snap install intellij-idea-ultimate --classic

# Sublime.
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - && \
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list && \
apt update && \
apt install -y sublime-text

# Chrome.
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
dpkg -i google-chrome-stable_current_amd64.deb

# Appearance.
# Tweak.
add-apt-repository universe && \
apt update && \
apt install -y gnome-tweak-tool
apt install -y gnome-shell-extensions
apt install -y chrome-gnome-shell
# Icons.
add-apt-repository ppa:numix/ppa && \
apt update && \
apt install -y numix-icon-theme-circle
