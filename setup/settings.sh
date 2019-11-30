#!/bin/bash

# Default applications.
# Remove amazon.
if [[ -f /usr/share/applications/ubuntu-amazon-default.desktop ]]; then
	sudo rm /usr/share/applications/ubuntu-amazon-default.desktop
fi

# Make sublime default text editor.
if [[ -f /usr/share/applications/sublime_text.desktop ]]; then
	sudo sed -i -e 's/org.gnome.gedit/sublime_text/g' /usr/share/applications/defaults.list
fi

# Setup tmux manager.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Settings.
# Keybindings.
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-group "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Above_Tab', '<Control><Alt>Down']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Shift><Super>Above_Tab', '<Control><Alt>Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "['<Shift><Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Primary>F11']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Primary>space']"
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
