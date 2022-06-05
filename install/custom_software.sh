#!/usr/bin/env bash

echo "Installing custom software"

if [[ -z $DOTFILES_PATH ]]; then
	echo "Environment variable (DOTFILES_PATH) is not set" >&2
	exit 1
fi

sudo install "$DOTFILES_PATH/bin/memwatch" /usr/local/bin/
