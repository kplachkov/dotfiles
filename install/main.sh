#!/bin/bash

declare -r dotfiles_dir
dotfiles_dir=$(dirname "$(dirname "$(readlink -f "$0")")")

# shellcheck source=install/utils.sh
. "$dotfiles_dir/install/utils.sh"

function main {
	disable_lock

	init

	install

	post_install

	enable_lock
	echo "Done."
}

function init {
	bash "$dotfiles_dir/install/settings.sh"

	bash "$dotfiles_dir/install/configuration.sh"

	bash "$dotfiles_dir/install/ssh_keys.sh"

	bash "$dotfiles_dir/install/gpg_key.sh"
}

function install {
	sudo bash "$dotfiles_dir/install/system_software.sh"

	bash "$dotfiles_dir/install/python_software.sh"
}

function post_install {
	sudo bash "$dotfiles_dir/install/firewall.sh"

	bash "$dotfiles_dir/install/autostart_apps.sh"

	sudo bash "$dotfiles_dir/install/default_apps.sh"

	bash "$dotfiles_dir/install/extra_apps.sh"
}

main
