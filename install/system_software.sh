#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Permission denied (try with sudo)"
	exit 1
fi

function install_system_software {
	echo "Installing system software"

	apt-get update && apt-get upgrade -y

	install_ops_software

	install_dev_software

	install_ux_software

	install_common_software
}

function install_ops_software {
	apt-get install -y curl whois net-tools apt-transport-https \
		ca-certificates gnupg-agent software-properties-common nmap \
		htop tmux tree most xclip powerline fonts-powerline \
		qemu-kvm virt-manager

	snap install ufw

	install_virtualbox
	install_tmux_plugins
}

function install_dev_software {
	apt-get install -y cmake nodejs npm postgresql-client direnv ruby-dev shc
	apt-get install -y python3-pip pipenv python3-tk
	apt-get install -y libseccomp-dev

	snap install go --classic
	snap install protobuf --classic
	snap install google-cloud-sdk --classic
	snap install docker
	snap install microk8s --classic && microk8s.enable registry && microk8s.enable helm
	snap install heroku --classic
	snap install hugo --channel=extended
	snap install postman
	snap install beekeeper-studio

	install_git
	install_yarn
	install_ides
	install_sublime_text
}

function install_common_software {
	snap install keepassxc
	snap install skype
	snap install spotify
	apt install -y rawtherapee

	install_browsers
}

function install_ux_software {
	apt-get install -y unclutter imwheel xdotool

	# Tweak.
	add-apt-repository universe && apt-get install -y gnome-tweak-tool
	apt-get install -y gnome-shell-extensions
	apt-get install -y chrome-gnome-shell

	# Icons.
	add-apt-repository -y ppa:numix/ppa &&
		apt-get install -y numix-icon-theme-circle
}

function install_browsers {
	# Chrome.
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
		dpkg -i google-chrome-stable_current_amd64.deb &&
		rm google-chrome-stable_current_amd64.deb
}

function install_git {
	apt-get install -y git
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
}

function install_virtualbox {
	curl -sS https://www.virtualbox.org/download/oracle_vbox_2016.asc | apt-key add - &&
		add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -c -s) contrib" &&
		apt-get install -y virtualbox-6.1
}

function install_tmux_plugins {
	if ! command -v git &>/dev/null; then
		apt-get install -y git
	fi

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function install_yarn {
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&
		add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main" &&
		apt-get install -y yarn
}

function install_ides {
	snap install goland --classic
	snap install webstorm --classic
	snap install pycharm-professional --classic
	snap install intellij-idea-ultimate --classic
	snap install clion --classic
	snap install datagrip --classic
}

function install_sublime_text {
	curl -sS https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - &&
		add-apt-repository "deb https://download.sublimetext.com/ apt/stable/" &&
		apt-get install -y sublime-text
}

install_system_software
