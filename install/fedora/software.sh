#!/usr/bin/env bash

. "$DOTFILES_PATH/lib/utils.sh" || exit $?

function install_ops_software() {
	sudo dnf install -y \
		most \
		lshw \
		powerline \
		powerline-fonts \
		tmux \
		tmux-powerline \
		htop \
		bat

	install_tmux_plugins
}

function install_dev_software() {
	install_nodejs
	install_kubectl
	install_gcloud
	install_sublime_text
}

function install_common_software() {
	sudo dnf install -y \
		google-chrome-stable \
		keepassxc \
		rawtherapee
}

function install_ux_software() {
	sudo dnf install -y \
		imwheel \
		numix-icon-theme-circle

	isgnome && install_gnome_software
}

function install_gcloud() {
	sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo <<EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
	sudo dnf install -y google-cloud-cli
}

function install_kubectl() {
	cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
	sudo yum install -y kubectl
}

function install_tmux_plugins() {
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function install_nodejs() {
	sudo dnf install -y nodejs &&
		mkdir -p ~/.npm-global &&
		npm config set prefix ~/.npm-global &&
		npm install --global yarn
}

function install_sublime_text() {
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg &&
		sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo &&
		sudo dnf install -y sublime-text
}

function install_vscode() {
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
		sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' &&
		dnf check-update &&
		sudo dnf install -y code
}

function install_gnome_software() {
	sudo dnf install -y \
		gnome-tweaks \
		gnome-extensions-app \
		gnome-shell-extension-auto-move-windows
}

function main() {
	echo "Installing system software"

	install_ops_software

	install_dev_software

	install_ux_software

	install_common_software
}

main "$@"
