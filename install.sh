#!/bin/bash

dotfilesdir=$(pwd)
dotfiles=(.aliases .bashrc .exports .bash_options)

# Install dotfiles.
for dotf in "${dotfiles[@]}"
do
    /bin/rm -rf ~/${dotf}
    /bin/ln -fs "$dotfilesdir/${dotf}" ~/
done

# Install and setup.
sudo bash ./scripts/sys_install.sh
bash ./scripts/pip_install.sh
bash ./scripts/setup.sh
bash ./scripts/setup_manually.sh
