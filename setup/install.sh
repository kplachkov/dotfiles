#!/bin/bash

declare -r dotfiles_dir
dotfiles_dir=$(dirname "$(dirname "$(readlink -f "$0")")")

# shellcheck source=setup/utils.sh
. "$dotfiles_dir/setup/utils.sh"

function main {
	disable_lock

	initial_setup

	install

	final_setup

	enable_lock
	echo "Done."
}

function initial_setup {
	bash "$dotfiles_dir/setup/settings.sh"

	bash "$dotfiles_dir/setup/configuration.sh"

	bash "$dotfiles_dir/setup/ssh_keys.sh"

	bash "$dotfiles_dir/setup/gpg_key.sh"
}

function install {
	sudo bash "$dotfiles_dir/setup/sys_install.sh"

	bash "$dotfiles_dir/setup/pip_install.sh"
}

function final_setup {
	sudo bash "$dotfiles_dir/setup/firewall.sh"

	bash "$dotfiles_dir/setup/autostart_apps.sh"

	sudo bash "$dotfiles_dir/setup/default_apps.sh"

	bash "$dotfiles_dir/setup/extra_apps.sh"
}

main
