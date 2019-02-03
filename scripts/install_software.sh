#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

apt update
apt upgrade -y

# System.
apt install -y htop tmux tree

# Network.
apt install -y curl whois apt-transport-https ca-certificates gnupg-agent software-properties-common

# Development.
apt install -y cmake git git-lfs nodejs npm pgadmin3 postgresql-client python-pip python3-pip python-virtualenv

# Libs.
apt install -y libcairo2-dev libxcb1-dev libxcb-composite0-dev libxcb-randr0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev python-xcbgen libasound2-dev libmpdclient-dev libiw-dev xcb-proto

# Security.
apt install -y keepassxc

# Docker.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
apt update && \
apt install -y docker-ce docker-ce-cli containerd.io

# Sublime.
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - && \
echo "deb https://download.sublimetext.com/ apt/stable/" | tee && \
apt update && \
apt install -y sublime-text

# Chrome.
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
dpkg -i google-chrome-stable_current_amd64.deb

# Tweak.
add-apt-repository universe
apt install -y gnome-tweak-tool && \
apt install -y gnome-shell-extensions

# Snaps.
snap install goland --classic
snap install webstorm --classic
snap install pycharm-professional --classic
snap install intellij-idea-ultimate --classic
snap install protobuf --classic
