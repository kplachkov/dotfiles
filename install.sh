#!/bin/bash

# Setup dotfiles.
dotfiles_dir=$(dirname "$(readlink -f "$0")")
dotfiles=(.aliases .bashrc .bash_options .exports .inputrc .tmux.conf)

for dotf in "${dotfiles[@]}"
do
    /bin/ln -fs "$dotfiles_dir/${dotf}" ~/
done

# Setup htop configuration.
htop_config_dir=~/.config/htop/
mkdir -p $htop_config_dir
/bin/ln -fs "$dotfiles_dir/htoprc" $htop_config_dir

# Setup sublime configuration.
subl_config_dir=~/.config/sublime-text-3/Packages/User/
mkdir -p $subl_config_dir
/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Default (Linux).sublime-keymap" $subl_config_dir
/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Preferences.sublime-settings" $subl_config_dir
/bin/ln -fs "$dotfiles_dir/config/sublime-text-3/Package Control.sublime-settings" $subl_config_dir

# Install and setup.
bash "$dotfiles_dir/setup/settings.sh"

sudo bash "$dotfiles_dir/setup/sys_install.sh"
bash "$dotfiles_dir/setup/pip_install.sh"
bash "$dotfiles_dir/setup/manually_install.sh"

bash "$dotfiles_dir/setup/default_apps.sh"
