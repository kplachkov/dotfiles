#!/bin/bash

dotfiles_dir=$(dirname "$(dirname "$(readlink -f "$0")")")
declare -r dotfiles_dir

echo "Setting up autostart applications"

autostart_dir=~/.config/autostart/

mkdir -p $autostart_dir
/bin/ln -fs "$dotfiles_dir/imwheel.desktop" $autostart_dir
