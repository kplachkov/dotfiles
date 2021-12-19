#!/usr/bin/env bash

export DOTFILES_PATH="$HOME/projects/dotfiles"

declare -r dotfiles_https_url="https://github.com/kplachkov/dotfiles.git"
declare -r dotfiles_ssh_url="git@github.com:kplachkov/dotfiles.git"

function download_files {
	echo "Downloading files"

	sudo apt update

	sudo apt install -y git || return $?
	git clone "$dotfiles_https_url" "$DOTFILES_PATH" || return $?

	(cd "$DOTFILES_PATH" && git remote set-url origin "$dotfiles_ssh_url")
}

function main {
	if ! download_files; then
		echo "Downloading files failed" >&2
		exit 1
	fi

	"$DOTFILES_PATH/install/main.sh"
}

main "$@"
