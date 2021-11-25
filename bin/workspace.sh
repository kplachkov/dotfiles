#!/usr/bin/bash

# Start multiple programs if they are not running already.
#
# Source: https://github.com/kplachkov/dotfiles

if ! pgrep chrome; then
	google-chrome &
fi

if ! pgrep smartgit.sh; then
	~/smartgit/bin/smartgit.sh &
fi

if ! pgrep goland.sh; then
	goland &
fi

if ! pgrep --exact --full "tmux"; then
	gnome-terminal --full-screen -- tmux
elif [[ $(pgrep --count --exact --full "tmux") == 2 ]]; then
	true # NOP
elif ! pgrep --exact --full "tmux a"; then
	gnome-terminal --full-screen -- tmux a
fi
