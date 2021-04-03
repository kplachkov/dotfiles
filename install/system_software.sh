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

	install_theme_software

	install_common_software
}

function install_ops_software {
	apt-get install -y curl whois net-tools apt-transport-https \
		ca-certificates gnupg-agent software-properties-common nmap \
		htop tmux tree most xclip

	snap install ufw

	install_tmux_plugins
}

function install_dev_software {
	apt-get install -y cmake nodejs npm postgresql-client direnv ruby-dev shc
	apt-get install -y python3-pip python3-virtualenv python3-tk
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
	snap install shellcheck
	snap install shfmt

	# Git.
	apt-get install -y git
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

	# Yarn.
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&
		add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main" &&
		apt-get install -y yarn

	# IDEs.
	snap install goland --classic
	snap install webstorm --classic
	snap install pycharm-professional --classic
	snap install intellij-idea-ultimate --classic
	snap install clion --classic
	snap install datagrip --classic

	# Sublime.
	curl -sS https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - &&
		add-apt-repository "deb https://download.sublimetext.com/ apt/stable/" &&
		apt-get install -y sublime-text
}

function install_common_software {
	install_browsers

	apt-get install -y imwheel keepassxc
	snap install skype
	snap install spotify
}

function install_browsers {
	# Chrome.
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
		dpkg -i google-chrome-stable_current_amd64.deb &&
		rm google-chrome-stable_current_amd64.deb
}

function install_theme_software {
	# Hide cursor.
	apt-get install -y unclutter

	# Tweak.
	add-apt-repository universe && apt-get install -y gnome-tweak-tool
	apt-get install -y gnome-shell-extensions
	apt-get install -y chrome-gnome-shell

	# Icons.
	add-apt-repository -y ppa:numix/ppa &&
		apt-get install -y numix-icon-theme-circle
}

function install_tmux_plugins {
	if ! command -v git &>/dev/null; then
		apt-get install -y git
	fi

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_system_software
