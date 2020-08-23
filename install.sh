#!/bin/bash

dotfiles_dir=$(dirname "$(readlink -f "$0")")

. "$dotfiles_dir/setup/utils.sh"

function main {
	disable_lock

	setup_configuration
	install

	enable_lock
	echo "Done."
}

function setup_configuration {
	echo "Setting up dotfiles"
	dotfiles=(.aliases .bashrc .bash_options .exports .imwheelrc .inputrc .tmux.conf)

	for dotf in "${dotfiles[@]}"
	do
	    /bin/ln -fs "$dotfiles_dir/${dotf}" ~/
	done

	echo "Setting up htop configuration"
	htop_config_dir=~/.config/htop/
	mkdir -p $htop_config_dir
	/bin/ln -fs "$dotfiles_dir/htoprc" $htop_config_dir

	echo "Setting up sublime configuration"
	subl_config_dir=~/.config/sublime-text-3/Packages/User/
	mkdir -p $subl_config_dir
	/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Default (Linux).sublime-keymap" $subl_config_dir
	/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Preferences.sublime-settings" $subl_config_dir
	/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Package Control.sublime-settings" $subl_config_dir

	echo "Setting up autostart applications and scripts"
	autostart_dir=~/.config/autostart/
	mkdir -p $autostart_dir
	/bin/ln -fs "$dotfiles_dir/imwheel.desktop" $autostart_dir

	echo "Setting up cursor configuration"
	mkdir -p /etc/default/
	sudo /bin/ln -fs "$dotfiles_dir/unclutter" /etc/default/

	echo "Applying system settings"
	bash "$dotfiles_dir/setup/settings.sh"
}

function install {
	echo "Installing system software"
	sudo bash "$dotfiles_dir/setup/sys_install.sh"

	echo "Installing python libraries"
	bash "$dotfiles_dir/setup/pip_install.sh"

	echo "Setting up default applications"
	sudo bash "$dotfiles_dir/setup/default_apps.sh"
}

main