#!/bin/bash

declare -r dotfiles_dir=$(dirname $(dirname "$(readlink -f "$0")"))

echo "Setting up dotfiles"

dotfiles=(.aliases .bashrc .bash_options .exports .imwheelrc .inputrc .tmux.conf)

for dotf in "${dotfiles[@]}"
do
    /bin/ln -fs "$dotfiles_dir/${dotf}" ~/
done


echo "Setting up htop configuration"

htop_config_dir=~/.config/htop/
mkdir -p $htop_config_dir
/bin/ln -fs "$dotfiles_dir/htoprc" $htop_config_dir


echo "Setting up sublime configuration"

subl_config_dir=~/.config/sublime-text-3/Packages/User/
mkdir -p $subl_config_dir
/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Default (Linux).sublime-keymap" $subl_config_dir
/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Preferences.sublime-settings" $subl_config_dir
/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Package Control.sublime-settings" $subl_config_dir


echo "Setting up cursor configuration"

mkdir -p /etc/default/
sudo /bin/ln -fs "$dotfiles_dir/unclutter" /etc/default/
