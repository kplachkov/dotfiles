#!/usr/bin/env bash

. "$DOTFILES_PATH/lib/utils.sh" || exit $?

function install_virtualization() {
	sudo dnf install -y @virtualization &&
		sudo usermod -a -G libvirt "$(whoami)" ||
		return $?

	sudo systemctl start libvirtd
	sudo systemctl enable libvirtd
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

	sudo dnf install -y \
		most \
		lshw \
		powerline \
		powerline-fonts \
		tmux \
		tmux-powerline \
		htop \
		iftop \
		bat \
		alacritty \
		golang \
		nodejs \
		google-chrome-stable \
		keepassxc \
		rawtherapee \
		imwheel \
		unclutter-xfixes \
		papirus-icon-theme

	install_virtualization
	install_kubectl
	install_gcloud
	install_vscode

	is_gnome && install_gnome_software
}

main "$@"
