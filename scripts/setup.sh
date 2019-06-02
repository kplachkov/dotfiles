#!/bin/bash

sudo ubuntu-drivers autoinstall

if [[ -f /usr/share/applications/ubuntu-amazon-default.desktop ]]; then
	sudo rm -rf /usr/share/applications/ubuntu-amazon-default.desktop
fi

# Night light.
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 7
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 5
# Appearance.
gsettings set org.gnome.desktop.interface icon-theme "Numix-Circle"
gsettings set org.gnome.desktop.interface cursor-theme "Yaru"
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.desktop.interface cursor-size 64
gsettings set org.gnome.desktop.interface clock-show-date true
# Privacy.
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
gsettings set org.gnome.desktop.privacy report-technical-problems false
# Show hidden files.
gsettings set org.gtk.Settings.FileChooser show-hidden true

# Make sublime default text editor.
if [[ -f /usr/share/applications/sublime_text.desktop ]]; then
	sudo sed -i -e 's/gedit/sublime_text/g' /usr/share/applications/defaults.list
fi
