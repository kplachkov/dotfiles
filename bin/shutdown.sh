#!/usr/bin/bash

# Display GTK+ dialog to shutdown the computer.
#
# Source: https://github.com/kplachkov/dotfiles

if zenity \
	--question \
	--title "Shutdown" \
	--text "Are you sure you want to shutdown your computer now?" \
	--default-cancel \
	--width 250; then
	shutdown now
fi
