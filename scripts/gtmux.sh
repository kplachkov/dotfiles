#!/usr/bin/env bash

if ! pgrep tmux; then
	gnome-terminal --full-screen -- tmux
else
	gnome-terminal --full-screen -- tmux a
fi
