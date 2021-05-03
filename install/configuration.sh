#!/bin/bash

dotfiles_dir=$(dirname "$(dirname "$(readlink -f "$0")")")
declare -r dotfiles_dir

dotfiles=(.aliases .bashrc .bash_options .exports .imwheelrc .inputrc .profile .tmux.conf)

htop_config_dir="$HOME/.config/htop/"
subl_config_dir="$HOME/.config/sublime-text-3/Packages/User/"

function main {
	set_dotfiles
	set_htop_config
	set_sublime_text_config
	set_cursor_config
}

function set_dotfiles {
	echo "Setting up dotfiles"

	for dotfile in "${dotfiles[@]}"; do
		/bin/ln -fs "$dotfiles_dir/${dotfile}" "$HOME"
	done
}

function set_htop_config {
	echo "Setting up htop configuration"

	mkdir -p "$htop_config_dir"
	/bin/ln -fs "$dotfiles_dir/htoprc" "$htop_config_dir"
}

function set_sublime_text_config {
	echo "Setting up sublime text configuration"

	mkdir -p "$subl_config_dir"
	/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Default (Linux).sublime-keymap" "$subl_config_dir"
	/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Preferences.sublime-settings" "$subl_config_dir"
	/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Package Control.sublime-settings" "$subl_config_dir"
}

function set_cursor_config {
	echo "Setting up cursor configuration"

	mkdir -p /etc/default/
	sudo /bin/ln -fs "$dotfiles_dir/unclutter" /etc/default/
}

main
