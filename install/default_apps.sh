#!/usr/bin/env bash

echo "Setting up sublime as the default text editor"

if [[ -f /usr/share/applications/sublime_text.desktop ]]; then
	sudo sed -i -e 's/org.gnome.gedit/sublime_text/g' /usr/share/applications/defaults.list
fi
