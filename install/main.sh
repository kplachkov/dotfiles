#!/usr/bin/env bash

# shellcheck source=lib/screen.sh
. "$DOTFILES_PATH/lib/screen.sh" || retun $?

function init {
	"$DOTFILES_PATH/install/settings.sh"

	"$DOTFILES_PATH/install/configuration.sh"

	"$DOTFILES_PATH/install/ssh_keys.sh"

	"$DOTFILES_PATH/install/pgp_keys.sh"

	"$DOTFILES_PATH/install/locale.sh"
}

function install {
	sudo ubuntu-drivers autoinstall

	"$DOTFILES_PATH/install/system_software.sh"

	"$DOTFILES_PATH/install/python_software.sh"

	"$DOTFILES_PATH/install/custom_software.sh"
}

function post_install {
	"$DOTFILES_PATH/install/firewall.sh"

	"$DOTFILES_PATH/install/default_apps.sh"

	"$DOTFILES_PATH/install/extra_apps.sh"
}

function main {
	echo "Installing setup"

	disable_screen_lock

	init

	install

	post_install

	enable_screen_lock

	echo "Done."
}

main "$@"
