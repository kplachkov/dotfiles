#!/usr/bin/bash

# shellcheck source=pkg/log/log.sh
. "$DOTFILES_PATH/pkg/log/log.sh"

function install_ops_software {
	/usr/bin/sudo /usr/bin/apt install -y \
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

	/usr/bin/sudo /usr/bin/snap install ufw

	install_virtualbox
	install_tmux_plugins
}

function install_dev_software {
	/usr/bin/sudo /usr/bin/apt install -y \
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

	/usr/bin/sudo /usr/bin/snap install go --classic
	/usr/bin/sudo /usr/bin/snap install protobuf --classic
	/usr/bin/sudo /usr/bin/snap install google-cloud-sdk --classic
	/usr/bin/sudo /usr/bin/snap install docker
	/usr/bin/sudo /usr/bin/snap install heroku --classic
	/usr/bin/sudo /usr/bin/snap install hugo --channel=extended
	/usr/bin/sudo /usr/bin/snap install postman
	/usr/bin/sudo /usr/bin/snap install beekeeper-studio

	install_git
	install_microk8s
	install_yarn
	install_ides
	install_sublime_text
}

function install_common_software {
	/usr/bin/sudo /usr/bin/apt install -y \
		imagemagick \
		rawtherapee

	/usr/bin/sudo /usr/bin/snap install keepassxc
	/usr/bin/sudo /usr/bin/snap install skype
	/usr/bin/sudo /usr/bin/snap install spotify
	/usr/bin/sudo /usr/bin/snap install gimp

	install_browsers
}

function install_ux_software {
	/usr/bin/sudo /usr/bin/apt install -y \
		unclutter \
		imwheel \
		xdotool

	# Tweak.
	/usr/bin/sudo /usr/bin/add-apt-repository universe &&
		/usr/bin/sudo /usr/bin/apt install -y gnome-tweak-tool

	/usr/bin/sudo /usr/bin/apt install -y \
		gnome-shell-extensions \
		chrome-gnome-shell

	# Icons.
	/usr/bin/sudo /usr/bin/apt install -y numix-icon-theme-circle
}

function install_custom_software {
	/usr/bin/sudo /usr/bin/install "$DOTFILES_PATH/bin/memcheck" /usr/local/bin/
}

function install_browsers {
	# Chrome.
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
		/usr/bin/sudo /usr/bin/dpkg -i google-chrome-stable_current_amd64.deb &&
		rm google-chrome-stable_current_amd64.deb
}

function install_git {
	/usr/bin/sudo /usr/bin/apt install -y git

	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | /usr/bin/sudo /usr/bin/bash
}

function install_microk8s {
	/usr/bin/sudo /usr/bin/snap install microk8s --classic || return $?

	/usr/bin/sudo /usr/sbin/usermod -a -G microk8s "$USER"
	/usr/bin/sudo /usr/bin/chown -f -R "$USER" ~/.kube

	sg microk8s -c "microk8s.enable registry ; microk8s.enable helm ; exit"

	/usr/bin/sudo /usr/bin/snap alias microk8s.kubectl kubectl
	/usr/bin/sudo /usr/bin/snap alias microk8s.helm helm
}

function install_virtualbox {
	curl -sS https://www.virtualbox.org/download/oracle_vbox_2016.asc | /usr/bin/sudo /usr/bin/apt-key add - &&
		/usr/bin/sudo /usr/bin/add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -c -s) contrib" &&
		/usr/bin/sudo /usr/bin/apt install -y virtualbox-6.1
}

function install_tmux_plugins {
	command -v git &>/dev/null || /usr/bin/sudo /usr/bin/apt install -y git || return $?

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function install_yarn {
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | /usr/bin/sudo /usr/bin/apt-key add - &&
		/usr/bin/sudo /usr/bin/add-apt-repository "deb https://dl.yarnpkg.com/debian/ stable main" &&
		/usr/bin/sudo /usr/bin/apt install -y yarn
}

function install_ides {
	/usr/bin/sudo /usr/bin/snap install goland --classic
	/usr/bin/sudo /usr/bin/snap install webstorm --classic
	/usr/bin/sudo /usr/bin/snap install pycharm-professional --classic
	/usr/bin/sudo /usr/bin/snap install intellij-idea-ultimate --classic
	/usr/bin/sudo /usr/bin/snap install clion --classic
	/usr/bin/sudo /usr/bin/snap install datagrip --classic
}

function install_sublime_text {
	curl -sS https://download.sublimetext.com/sublimehq-pub.gpg | /usr/bin/sudo /usr/bin/apt-key add - &&
		/usr/bin/sudo /usr/bin/add-apt-repository "deb https://download.sublimetext.com/ apt/stable/" &&
		/usr/bin/sudo /usr/bin/apt install -y sublime-text
}

function main {
	echo "Installing system software"

	/usr/bin/sudo /usr/bin/apt update

	install_ops_software

	install_dev_software

	install_ux_software

	install_common_software

	install_custom_software
}

main "$@"
