#!/bin/bash

declare -r dotfiles_dir=$(dirname $(dirname "$(readlink -f "$0")"))

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

	bash "$dotfiles_dir/setup/configuration.sh"

	bash "$dotfiles_dir/setup/autostart_apps.sh"

	bash "$dotfiles_dir/setup/ssh_keys.sh"
}

function install {
	sudo bash "$dotfiles_dir/setup/sys_install.sh"

	bash "$dotfiles_dir/setup/pip_install.sh"

	sudo bash "$dotfiles_dir/setup/default_apps.sh"
}

main
