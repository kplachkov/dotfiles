#!/usr/bin/env bash

# Start multiple programs if they are not running already.
#
# Source: https://github.com/kplachkov/dotfiles

if ! pgrep chrome; then
	google-chrome &
fi

if ! pgrep --exact --full "tmux"; then
	alacritty --command tmux
elif [[ $(pgrep --count --exact --full "tmux") == 2 ]]; then
	true # NOP
elif ! pgrep --exact --full "tmux a"; then
	alacritty --command tmux a
fi
