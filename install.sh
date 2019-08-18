#!/bin/bash

# Setup dotfiles.
dotfilesdir=$(pwd)
dotfiles=(.aliases .bashrc .bash_options .exports .tmux.conf)

for dotf in "${dotfiles[@]}"
do
    /bin/ln -fs "$dotfilesdir/${dotf}" ~/
done

# Setup htop configuration.
mkdir -p ~/.config/htop/
/bin/ln -fs "$dotfilesdir/htoprc" ~/.config/htop/

# Install and setup.
sudo bash ./scripts/sys_install.sh
bash ./scripts/pip_install.sh
bash ./scripts/setup.sh
bash ./scripts/setup_manually.sh
