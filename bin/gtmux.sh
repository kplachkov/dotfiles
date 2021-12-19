#!/usr/bin/env bash

# Start tmux in full screen if its not running already.
#
# Source: https://github.com/kplachkov/dotfiles

if ! pgrep --exact --full "tmux"; then
	gnome-terminal --full-screen -- tmux
elif [[ $(pgrep --count --exact --full "tmux") == 2 ]]; then
	true # NOP # TODO: focus the window
elif ! pgrep --exact --full "tmux a"; then
	gnome-terminal --full-screen -- tmux a
fi
