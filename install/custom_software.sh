#!/usr/bin/env bash

echo "Installing custom software"

if [[ -z $DOTFILES_PATH ]]; then
	return 1
fi

sudo install "$DOTFILES_PATH/bin/memwatch" /usr/local/bin/
