#!/usr/bin/env bash

function install_ops_software {
	sudo apt install -y \
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
		most \
		xclip \
		powerline \
		fonts-powerline \
		qemu-kvm \
		virt-manager \
		ufw

	install_tmux_plugins
}

function install_dev_software {
	sudo apt install -y \
		cmake \
		ruby-dev \
		shc \
		python3-pip \
		pipenv \
		python3-tk \
		libseccomp-dev \
		protobuf-compiler

	sudo snap install go --classic
	sudo snap install node --classic
	sudo snap install hugo --channel=extended
	sudo snap install postman

	install_git
	install_gcloud
	install_heroku
	install_kubectl
	install_helm
	install_beekeeper_studio
	install_yarn
	install_ides
	install_sublime_text
}

function install_common_software {
	sudo apt install -y \
		imagemagick \
		rawtherapee \
		gimp \
		keepassxc

	install_browsers
}

function install_ux_software {
	sudo apt install -y \
		unclutter \
		imwheel \
		xdotool

	sudo add-apt-repository universe &&
		sudo apt install -y gnome-tweak-tool

	sudo apt install -y \
		gnome-shell-extensions \
		chrome-gnome-shell

	install_numix
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

function install_gcloud {
	sudo curl -fsSLo /usr/share/keyrings/cloud.google.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg &&
		echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" |
		sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list &&
		sudo apt update && sudo apt install -y google-cloud-sdk
}

function install_kubectl {
	sudo curl -fsSLo /usr/share/keyrings/kubernetes.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg &&
		echo "deb [signed-by=/usr/share/keyrings/kubernetes.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" |
		sudo tee /etc/apt/sources.list.d/kubernetes.list &&
		sudo apt update && sudo apt install -y kubectl
}

function install_heroku {
	curl https://cli-assets.heroku.com/install.sh | sh
}

function install_beekeeper_studio {
	curl -fsSL https://deb.beekeeperstudio.io/beekeeper.key |
		gpg --dearmor | sudo tee /usr/share/keyrings/beekeeper-studio.gpg >/dev/null &&
		echo "deb [signed-by=/usr/share/keyrings/beekeeper-studio.gpg] https://deb.beekeeperstudio.io stable main" |
		sudo tee /etc/apt/sources.list.d/beekeeper-studio.list &&
		sudo apt update && sudo apt install -y beekeeper-studio
}

function install_docker {
	curl https://get.docker.com | sh
}

function install_helm {
	curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
}

function install_microk8s {
	sudo snap install microk8s --classic || return $?

	sudo usermod -a -G microk8s "$USER"
	sudo chown -f -R "$USER" ~/.kube

	sg microk8s -c "microk8s.enable registry ; microk8s.enable helm ; exit"

	sudo snap alias microk8s.kubectl kubectl
	sudo snap alias microk8s.helm helm
}

function install_tmux_plugins {
	havecmd git || sudo apt install -y git || return $?

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function install_yarn {
	havecmd npm || sudo snap install node --classic || return $?

	npm install --global yarn
}

function install_ides {
	sudo snap install goland --classic
	sudo snap install webstorm --classic
	sudo snap install pycharm-professional --classic
	sudo snap install datagrip --classic
}

function install_sublime_text {
	curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg |
		gpg --dearmor | sudo tee /usr/share/keyrings/sublime-text.gpg >/dev/null &&
		echo "deb [signed-by=/usr/share/keyrings/sublime-text.gpg] https://download.sublimetext.com/ apt/stable/" |
		sudo tee /etc/apt/sources.list.d/sublime-text.list &&
		sudo apt update && sudo apt install -y sublime-text
}

function install_numix {
	sudo apt install -y numix-icon-theme-circle

	havecmd git || sudo apt install -y git || return $?

	local numix_folders_path="$HOME/projects/numix-folders"

	git clone https://github.com/numixproject/numix-folders.git "$numix_folders_path" &&
		(cd "$numix_folders_path" && printf '6\ncustom\n676767\n973552\ne4e4e4\n' | sudo "$numix_folders_path/numix-folders" -t)
}

function main {
	echo "Installing Ubuntu software"

	sudo apt update && sudo apt upgrade -y

	sudo ubuntu-drivers autoinstall

	install_ops_software

	install_dev_software

	install_ux_software

	install_common_software
}

main "$@"
