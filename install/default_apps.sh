#!/usr/bin/bash

# shellcheck source=pkg/log/log.sh
. "$DOTFILES_PATH/pkg/log/log.sh"

echo "Setting up default applications"

# Remove amazon.
if [[ -f /usr/share/applications/ubuntu-amazon-default.desktop ]]; then
	/usr/bin/sudo /usr/bin/rm /usr/share/applications/ubuntu-amazon-default.desktop
fi

# Make sublime the default text editor.
if [[ -f /usr/share/applications/sublime_text.desktop ]]; then
	/usr/bin/sudo /usr/bin/sed -i -e 's/org.gnome.gedit/sublime_text/g' /usr/share/applications/defaults.list
fi
