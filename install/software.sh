#!/usr/bin/env bash

if [[ -z $DOTFILES_PATH ]]; then
	echo "Environment variable (DOTFILES_PATH) is not set" >&2
	exit 1
fi

function install_go_software() {
	echo "Installing Go software"

	go install github.com/jesseduffield/lazygit@latest
}

function install_bash_software() {
	echo "Installing BASH software"

	sudo install "$DOTFILES_PATH/bin/memwatch" /usr/local/bin/
}

function install_npm_software() {
	echo "Installing NPM software"

	npm install --global yarn
}

function install_tpm() {
	echo "Installing Tmux Plugin Manager"

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

function install_numix_folders {
	echo "Installing Numix Folders"

	local numix_folders_path="$HOME/projects/numix-folders"

	git clone https://github.com/numixproject/numix-folders.git "$numix_folders_path" &&
		(cd "$numix_folders_path" && printf '6\ncustom\n676767\n973552\ne4e4e4\n' | sudo "$numix_folders_path/numix-folders" -t)
}

function main() {
	echo "Installing OS agnostic software"

	install_go_software
	install_bash_software
	install_npm_software
	install_tpm
}

main "$@"
