#!/usr/bin/env bash

if [[ -z $DOTFILES_PATH ]]; then
	echo "Environment variable (DOTFILES_PATH) is not set" >&2
	exit 1
fi

function install_homebrew() {
	echo "Installing Homebrew"

	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" &&
		brew analytics off
}

function install_homebrew_software() {
	echo "Installing Homebrew software"

	brew install go
	brew install node
	brew install helm
	brew install kubectl
	brew install minikube
	brew install k9s
	brew install lazygit
	brew install shellcheck
	brew install shfmt
	brew install hugo
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

function install_nerd_fonts() {
	echo "Installing Nerd Fonts"

	local nerd_fonts_path="$HOME/projects/nerd-fonts"

	git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git "$nerd_fonts_path" &&
		cd "$nerd_fonts_path" &&
		git sparse-checkout add patched-fonts/JetBrainsMono &&
		"$nerd_fonts_path"/install.sh JetBrainsMono
}

function main() {
	echo "Installing OS agnostic software"

	install_homebrew
	install_homebrew_software
	install_bash_software
	install_npm_software
	install_tpm
}

main "$@"
