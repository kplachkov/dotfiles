#!/bin/bash

dotfiles_dir=$(dirname "$(dirname "$(readlink -f "$0")")")
declare -r dotfiles_dir

# shellcheck source=install/utils.sh
. "$dotfiles_dir/install/utils.sh"

function main {
	echo "Installing setup"

	disable_lock

	init

	install

	post_install

	enable_lock

	echo "Done."
}

function init {
	"$dotfiles_dir/install/settings.sh"

	"$dotfiles_dir/install/configuration.sh"

	"$dotfiles_dir/install/ssh_keys.sh"

	"$dotfiles_dir/install/gpg_key.sh"
}

function install {
	sudo ubuntu-drivers autoinstall

	sudo "$dotfiles_dir/install/system_software.sh"

	"$dotfiles_dir/install/python_software.sh"
}

function post_install {
	sudo "$dotfiles_dir/install/firewall.sh"

	"$dotfiles_dir/install/autostart_apps.sh"

	sudo "$dotfiles_dir/install/default_apps.sh"

	"$dotfiles_dir/install/extra_apps.sh"

	sudo "$dotfiles_dir/install/snap_aliases.sh"
}

main
