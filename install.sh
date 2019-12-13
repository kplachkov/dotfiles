#!/bin/bash

# Setup dotfiles.
dotfilesdir=$(pwd)
dotfiles=(.aliases .bashrc .bash_options .exports .tmux.conf)

for dotf in "${dotfiles[@]}"
do
    /bin/ln -fs "$dotfilesdir/${dotf}" ~/
done

# Setup htop configuration.
htopconfigdir=~/.config/htop/
mkdir -p $htopconfigdir
/bin/ln -fs "$dotfilesdir/htoprc" $htopconfigdir

# Setup sublime configuration.
subconfigdir=~/.config/sublime-text-3/Packages/User/
mkdir -p $subconfigdir
/bin/ln -fs "$dotfilesdir/config/sublime-text-3/Default (Linux).sublime-keymap" $subconfigdir
/bin/ln -fs "$dotfilesdir/config/sublime-text-3/Preferences.sublime-settings" $subconfigdir
/bin/ln -fs "$dotfilesdir/config/sublime-text-3/Package Control.sublime-settings" $subconfigdir

# Install and setup.
bash ./setup/settings.sh

sudo bash ./setup/sys_install.sh
bash ./setup/pip_install.sh
bash ./setup/manually_install.sh

bash ./setup/default_apps.sh
