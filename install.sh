#!/bin/bash

declare -r dotfiles_repository="https://github.com/kplachkov/dotfiles.git"
declare -r dotfiles_dir="$HOME/projects/dotfiles"

echo "Installing required software"
sudo apt update
sudo apt install -y git

echo "Downloading files"
git clone $dotfiles_repository $dotfiles_dir && \
(cd $dotfiles_dir && git remote set-url origin git@github.com:kplachkov/dotfiles.git)

echo "Installing setup"
bash "$dotfiles_dir/setup/install.sh"
