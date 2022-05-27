#!/usr/bin/env bash

if [[ -z $DOTFILES_PATH ]]; then
	echo "Environment variable (DOTFILES_PATH) is not set" >&2
	exit 1
fi

function main() {
	echo "Installing GNOME setup"

	"$DOTFILES_PATH/install/gnome/settings.sh"
	"$DOTFILES_PATH/install/gnome/extensions.sh"
}

main "$@"
