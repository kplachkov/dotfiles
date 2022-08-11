#!/usr/bin/env bash

if [[ -z $DOTFILES_PATH ]]; then
	echo "Environment variable (DOTFILES_PATH) is not set" >&2
	exit 1
fi

function main() {
	echo "Installing Fedora setup"

	"$DOTFILES_PATH/install/fedora/software.sh"
}

main "$@"
