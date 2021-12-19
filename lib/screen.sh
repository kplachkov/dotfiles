#!/usr/bin/env bash

function disable_screen_lock {
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0
	echo "Lock screen is disabled"
}

function enable_screen_lock {
	gsettings set org.gnome.desktop.screensaver lock-enabled true
	gsettings set org.gnome.desktop.session idle-delay 120
	echo "Lock screen is enabled"
}