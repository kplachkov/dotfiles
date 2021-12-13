#!/usr/bin/env bash

function set_dotfiles {
	echo "Setting up dotfiles"

	local dotfiles=(.aliases .bashrc .bash_options .exports .imwheelrc .inputrc .profile .tmux.conf)

	for dotfile in "${dotfiles[@]}"; do
		ln -fs "$DOTFILES_PATH/${dotfile}" "$HOME"
	done
}

function set_autostart_apps {
	echo "Setting up autostart applications"

	local autostart_dir=~/.config/autostart/

	mkdir -p "$autostart_dir"
	ln -fs "$DOTFILES_PATH"/config/autostart/* "$autostart_dir"
}

function set_htop_config {
	echo "Setting up htop configuration"

	local htop_config_dir="$HOME/.config/htop/"

	mkdir -p "$htop_config_dir"
	ln -fs "$DOTFILES_PATH/htoprc" "$htop_config_dir"
}

function set_sublime_text_config {
	echo "Setting up sublime text configuration"

	local subl_config_dir="$HOME/.config/sublime-text-3/Packages/User/"

	mkdir -p "$subl_config_dir"
	ln -fs "$DOTFILES_PATH/config/sublime-text-3/Default (Linux).sublime-keymap" "$subl_config_dir"
	ln -fs "$DOTFILES_PATH/config/sublime-text-3/Preferences.sublime-settings" "$subl_config_dir"
	ln -fs "$DOTFILES_PATH/config/sublime-text-3/Package Control.sublime-settings" "$subl_config_dir"
}

function set_cursor_config {
	echo "Setting up cursor configuration"

	mkdir -p /etc/default/
	sudo ln -fs "$DOTFILES_PATH/unclutter" /etc/default/
}

function set_powerline_config {
	echo "Setting up powerline configuration"

	local powerline_config_dir="$HOME/.config/powerline/"

	mkdir -p "$powerline_config_dir"
	ln -fs "$DOTFILES_PATH"/config/powerline/* "$powerline_config_dir"
}

function main {
	set_dotfiles
	set_autostart_apps
	set_htop_config
	set_powerline_config
	set_sublime_text_config
	set_cursor_config
}

main "$@"
