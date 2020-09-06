#!/bin/bash

echo "Installing system software"

if [[ $EUID -ne 0 ]]; then
	echo "Permission denied (try with sudo)"
	exit 1
fi

apt update
apt upgrade -y

ubuntu-drivers autoinstall

# Network.
apt install -y curl whois net-tools apt-transport-https ca-certificates gnupg-agent software-properties-common

# Development.
apt install -y cmake git nodejs npm postgresql-client direnv
apt install -y python3-pip python3-virtualenv python3-tk
snap install go --classic
snap install protobuf --classic
snap install google-cloud-sdk --classic
snap install heroku --classic
snap install hugo --channel=extended
snap install docker
snap install postman
snap install beekeeper-studio
# IDEs.
snap install goland --classic
snap install webstorm --classic
snap install pycharm-professional --classic
snap install intellij-idea-ultimate --classic
snap install clion --classic
snap install datagrip --classic
# Sublime.
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - && \
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list && \
apt update && \
apt install -y sublime-text
# Git LFS.
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
# Yarn.
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt update && apt install -y yarn

# Chrome.
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
dpkg -i google-chrome-stable_current_amd64.deb && \
rm google-chrome-stable_current_amd64.deb

# Appearance.
# Hide cursor.
apt install -y unclutter
# Tweak.
add-apt-repository universe && \
apt update && \
apt install -y gnome-tweak-tool
apt install -y gnome-shell-extensions
apt install -y chrome-gnome-shell
# Icons.
add-apt-repository -y ppa:numix/ppa && \
apt update && \
apt install -y numix-icon-theme-circle

# Miscellaneous.
apt install -y htop tmux tree most imwheel xclip keepassxc
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
snap install skype --classic
snap install spotify
