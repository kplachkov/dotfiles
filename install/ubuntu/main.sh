#!/usr/bin/env bash

if [[ -z $DOTFILES_PATH ]]; then
	echo "Environment variable (DOTFILES_PATH) is not set" >&2
	exit 1
fi

function main() {
	echo "Installing Ubuntu setup"

	"$DOTFILES_PATH/install/ubuntu/software.sh"
	"$DOTFILES_PATH/install/ubuntu/locale.sh"
	"$DOTFILES_PATH/install/ubuntu/default_apps.sh"
}

main "$@"
