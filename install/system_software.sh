#!/usr/bin/env bash

function install_ops_software {
	sudo apt install -y \
		curl \
		whois \
		net-tools \
		apt-transport-https \
		ca-certificates \
		gnupg-agent \
		software-properties-common \
		nmap \
		htop \
		tmux \
		tree \
		most \
		xclip \
		powerline \
		fonts-powerline \
		qemu-kvm \
		virt-manager

	sudo snap install ufw

	install_virtualbox
	install_tmux_plugins
}

function install_dev_software {
	sudo apt install -y \
		cmake \
		nodejs \
		npm \
		postgresql-client \
		direnv \
		ruby-dev \
		shc \
		python3-pip \
		pipenv \
		python3-tk \
		libseccomp-dev

	sudo snap install go --classic
	sudo snap install protobuf --classic
	sudo snap install google-cloud-sdk --classic
	sudo snap install docker
	sudo snap install heroku --classic
	sudo snap install hugo --channel=extended
	sudo snap install postman
	sudo snap install beekeeper-studio

	install_git
	install_microk8s
	install_yarn
	install_ides
	install_sublime_text
}

function install_common_software {
	sudo apt install -y \
		imagemagick \
		rawtherapee

	sudo snap install keepassxc
	sudo snap install skype
	sudo snap install spotify
	sudo snap install gimp

	install_browsers
}

function install_ux_software {
	sudo apt install -y \
		unclutter \
		imwheel \
		xdotool

	# Tweak.
	sudo add-apt-repository universe &&
		sudo apt install -y gnome-tweak-tool

	sudo apt install -y \
		gnome-shell-extensions \
		chrome-gnome-shell

	# Icons.
	sudo apt install -y numix-icon-theme-circle
}

function install_custom_software {
	sudo install "$DOTFILES_PATH/bin/memcheck" /usr/local/bin/
}

function install_browsers {
	# Chrome.
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
		sudo dpkg -i google-chrome-stable_current_amd64.deb &&
		rm google-chrome-stable_current_amd64.deb
}

function install_git {
	sudo apt install -y git

	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
}

function install_microk8s {
	sudo snap install microk8s --classic || return $?

	sudo usermod -a -G microk8s "$USER"
	sudo chown -f -R "$USER" ~/.kube

	sg microk8s -c "microk8s.enable registry ; microk8s.enable helm ; exit"

	sudo snap alias microk8s.kubectl kubectl
	sudo snap alias microk8s.helm helm
}

function install_virtualbox {
	curl -sS https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add - &&
		sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -c -s) contrib" &&
		sudo apt install -y virtualbox-6.1
}

function install_tmux_plugins {
	_have git || sudo apt install -y git || return $?

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function install_yarn {
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &&
		sudo add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main" &&
		sudo apt install -y yarn
}

function install_ides {
	sudo snap install goland --classic
	sudo snap install webstorm --classic
	sudo snap install pycharm-professional --classic
	sudo snap install intellij-idea-ultimate --classic
	sudo snap install clion --classic
	sudo snap install datagrip --classic
}

function install_sublime_text {
	curl -sS https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - &&
		sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/" &&
		sudo apt install -y sublime-text
}

function main {
	echo "Installing system software"

	sudo apt update

	install_ops_software

	install_dev_software

	install_ux_software

	install_common_software

	install_custom_software
}

main "$@"
