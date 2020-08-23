#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Remove amazon.
if [[ -f /usr/share/applications/ubuntu-amazon-default.desktop ]]; then
	rm /usr/share/applications/ubuntu-amazon-default.desktop
fi

# Make sublime default text editor.
if [[ -f /usr/share/applications/sublime_text.desktop ]]; then
	sed -i -e 's/org.gnome.gedit/sublime_text/g' /usr/share/applications/defaults.list
fi
