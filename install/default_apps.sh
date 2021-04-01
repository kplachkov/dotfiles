#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Permission denied (try with sudo)"
	exit 1
fi

echo "Setting up default applications"

# Remove amazon.
if [[ -f /usr/share/applications/ubuntu-amazon-default.desktop ]]; then
	rm /usr/share/applications/ubuntu-amazon-default.desktop
fi

# Make sublime default text editor.
if [[ -f /usr/share/applications/sublime_text.desktop ]]; then
	sed -i -e 's/org.gnome.gedit/sublime_text/g' /usr/share/applications/defaults.list
fi
