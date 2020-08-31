#!/bin/bash

dotfiles_dir=$(dirname "$(readlink -f "$0")")

. "$dotfiles_dir/setup/utils.sh"

function main {
	disable_lock

	setup
	install

	enable_lock
	echo "Done."
}

function setup {
	bash "$dotfiles_dir/setup/settings.sh"

	setup_dotfiles

	setup_configurations

	setup_autostart_apps

	setup_ssh_keys
}

function setup_dotfiles {
	echo "Setting up dotfiles"

	dotfiles=(.aliases .bashrc .bash_options .exports .imwheelrc .inputrc .tmux.conf)

	for dotf in "${dotfiles[@]}"
	do
	    /bin/ln -fs "$dotfiles_dir/${dotf}" ~/
	done
}

function setup_configurations {
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

	echo "Setting up cursor configuration"
	mkdir -p /etc/default/
	sudo /bin/ln -fs "$dotfiles_dir/unclutter" /etc/default/
}

function setup_autostart_apps {
	echo "Setting up autostart applications"

	autostart_dir=~/.config/autostart/

	mkdir -p $autostart_dir
	/bin/ln -fs "$dotfiles_dir/imwheel.desktop" $autostart_dir
}

function setup_ssh_keys {
	echo "Setting up ssh keys"

	while true; do
		read -s -p "Enter passphrase: " passphrase
		read -s -p $'\nConfirm passphrase: ' passphrase_confirmation
		echo ""

		if [[ "$passphrase" == "$passphrase_confirmation" ]]; then
			break
		fi

		echo $'\nPassphrases do not match. Try again...\n'
	done

	machine_name=$(sudo lshw | grep -m1 -oP "(?<=product: )(.*)")
	echo "Comment: $machine_name"

	ssh-keygen -q -t rsa -b 4096 -C "$machine_name" -P "$passphrase" -f ~/.ssh/id_rsa
	ssh-keygen -q -t ed25519 -C "$machine_name" -P "$passphrase" -f ~/.ssh/id_ed25519

	unset passphrase
	unset passphrase_confirmation
}

function install {
	sudo bash "$dotfiles_dir/setup/sys_install.sh"

	bash "$dotfiles_dir/setup/pip_install.sh"

	sudo bash "$dotfiles_dir/setup/default_apps.sh"
}

main