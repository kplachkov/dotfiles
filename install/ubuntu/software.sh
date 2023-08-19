#!/usr/bin/env bash

. "$DOTFILES_PATH/lib/utils.sh" || exit $?

function install_gnome_software {
	sudo add-apt-repository universe

	sudo apt-get install -y \
		gnome-tweak-tool \
		gnome-shell-extensions \
		chrome-gnome-shell
}

function install_google_chrome {
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
		sudo dpkg -i google-chrome-stable_current_amd64.deb &&
		rm google-chrome-stable_current_amd64.deb
}

function install_gcloud {
	sudo curl -fsSLo /usr/share/keyrings/cloud.google.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg &&
		echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" |
		sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list &&
		sudo apt-get update && sudo apt-get install -y google-cloud-sdk
}

function install_beekeeper_studio {
	curl -fsSL https://deb.beekeeperstudio.io/beekeeper.key |
		gpg --dearmor | sudo tee /usr/share/keyrings/beekeeper-studio.gpg >/dev/null &&
		echo "deb [signed-by=/usr/share/keyrings/beekeeper-studio.gpg] https://deb.beekeeperstudio.io stable main" |
		sudo tee /etc/apt/sources.list.d/beekeeper-studio.list &&
		sudo apt-get update && sudo apt-get install -y beekeeper-studio
}

function main {
	echo "Installing system software"

	sudo apt-get update && sudo apt-get upgrade -y

	sudo ubuntu-drivers autoinstall

	sudo apt-get install -y \
		curl \
		whois \
		net-tools \
		apt-transport-https \
		ca-certificates \
		gnupg \
		software-properties-common \
		nmap \
		htop \
		iftop \
		tmux \
		tree \
		xclip \
		powerline \
		fonts-powerline \
		qemu-kvm \
		virt-manager \
		ufw \
		bat \
		git \
		cmake \
		ruby-dev \
		shc \
		python3-pip \
		pipenv \
		python3-tk \
		libseccomp-dev \
		protobuf-compiler \
		imagemagick \
		rawtherapee \
		gimp \
		keepassxc \
		imwheel \
		papirus-icon-theme

	install_gcloud
	install_beekeeper_studio
	install_google_chrome

	is_gnome && install_gnome_software
}

main "$@"
