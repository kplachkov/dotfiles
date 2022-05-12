#!/usr/bin/env bash

if [[ -z $DOTFILES_PATH ]]; then
	echo "Environment variable (DOTFILES_PATH) is not set" >&2
	return 1
fi

function link_dotfiles() {
	echo "Setting up dotfiles"

	local dotfiles=(.aliasrc .bashrc .cmdrc .exportrc .imwheelrc .inputrc .profile .tmux.conf)

	for dotfile in "${dotfiles[@]}"; do
		ln -fs "$DOTFILES_PATH/${dotfile}" "$HOME"
	done
}

function link_autostart_apps() {
	echo "Setting up autostart applications"

	local autostart_dir=~/.config/autostart/

	mkdir -p "$autostart_dir"
	ln -fs "$DOTFILES_PATH"/config/autostart/* "$autostart_dir"
}

function link_htop_config() {
	echo "Setting up htop configuration"

	local htop_config_dir="$HOME/.config/htop/"

	mkdir -p "$htop_config_dir"
	ln -fs "$DOTFILES_PATH/htoprc" "$htop_config_dir"
}

function link_sublime_text_config() {
	echo "Setting up sublime text configuration"

	local subl_config_dir="$HOME/.config/sublime-text-3/Packages/User/"

	mkdir -p "$subl_config_dir"
	ln -fs "$DOTFILES_PATH/config/sublime-text-3/Default (Linux).sublime-keymap" "$subl_config_dir"
	ln -fs "$DOTFILES_PATH/config/sublime-text-3/Preferences.sublime-settings" "$subl_config_dir"
	ln -fs "$DOTFILES_PATH/config/sublime-text-3/Package Control.sublime-settings" "$subl_config_dir"
}

function link_cursor_config() {
	echo "Setting up cursor configuration"

	mkdir -p /etc/default/
	sudo ln -fs "$DOTFILES_PATH/unclutter" /etc/default/
}

function link_powerline_config() {
	echo "Setting up powerline configuration"

	local powerline_config_dir="$HOME/.config/powerline/"

	mkdir -p "$powerline_config_dir"
	ln -fs "$DOTFILES_PATH"/config/powerline/* "$powerline_config_dir"
}

function main() {
	link_dotfiles
	link_autostart_apps
	link_htop_config
	link_powerline_config
	link_sublime_text_config
	link_cursor_config
}

main "$@"
