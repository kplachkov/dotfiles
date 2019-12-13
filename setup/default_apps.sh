#!/bin/bash

# Remove amazon.
if [[ -f /usr/share/applications/ubuntu-amazon-default.desktop ]]; then
	sudo rm /usr/share/applications/ubuntu-amazon-default.desktop
fi

# Make sublime default text editor.
if [[ -f /usr/share/applications/sublime_text.desktop ]]; then
	sudo sed -i -e 's/org.gnome.gedit/sublime_text/g' /usr/share/applications/defaults.list
fi
