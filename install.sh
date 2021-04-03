#!/bin/bash

declare -r dotfiles_https_url="https://github.com/kplachkov/dotfiles.git"
declare -r dotfiles_ssh_url="git@github.com:kplachkov/dotfiles.git"

declare -r dotfiles_dir="$HOME/projects/dotfiles"

function main {
	download

	"$dotfiles_dir/install/main.sh"
}

function download {
	echo "Downloading files"

	sudo apt-get update && sudo apt-get install -y git

	git clone "$dotfiles_https_url" "$dotfiles_dir" &&
		(cd "$dotfiles_dir" && git remote set-url origin "$dotfiles_ssh_url")
}

main
