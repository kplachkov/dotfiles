#!/usr/bin/env bash

echo "Applying GNOME settings"

# Keybindings.

gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-group "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "[]"
gsettings set org.gnome.shell.keybindings toggle-application-view "[]"
# Logout.
# gsettings set org.gnome.settings-daemon.plugins.media-keys logout "['<Control><Super>Delete']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Super><Shift>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Super><Shift>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Above_Tab', '<Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Shift><Super>Above_Tab', '<Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "['<Shift><Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Alt>F11']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>q']"

# Custom keybindings.

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/shutdown/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/gtmux/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/workspace/']"
# Shutdown computer.
# Native option:
# gsettings set org.gnome.settings-daemon.plugins.media-keys power "['<Control><Super>End']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/shutdown/ name "shutdown"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/shutdown/ command "$DOTFILES_PATH/bin/shutdown.sh"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/shutdown/ binding "<Primary><Super>End"
# Start tmux in full screen.
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/gtmux/ name "gtmux"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/gtmux/ command "$DOTFILES_PATH/bin/gtmux.sh"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/gtmux/ binding "<Super>t"
# Start workspace.
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/workspace/ name "workspace"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/workspace/ command "$DOTFILES_PATH/bin/workspace.sh"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/workspace/ binding "<Super>w"

# Keyboard.

gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'bg+phonetic')]"
gsettings set org.gnome.desktop.input-sources per-window true
gsettings set org.gnome.desktop.peripherals.keyboard repeat true
gsettings set org.gnome.desktop.peripherals.keyboard delay 345
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-enable true
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-max-speed 1100
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-init-delay 60
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-accel-time 600
gsettings set org.gnome.desktop.a11y.keyboard mousekeys-accel-time 600

# Night light.

gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 5
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 5
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2248

# Power.

gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 5400
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 3600

# Appearance.

gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface gtk-key-theme 'Adwaita'
gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
gsettings set org.gnome.desktop.interface cursor-size 32
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 12'
gsettings set org.gnome.desktop.interface font-name 'Cantarell 12'

# Miscellaneous

gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'Alacritty.desktop']"

gsettings set org.gnome.system.locale region 'en_GB.UTF-8'

gsettings set org.gnome.desktop.media-handling autorun-never true
gsettings set org.gnome.desktop.peripherals.mouse speed 1.0
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
gsettings set org.gnome.desktop.privacy report-technical-problems false

gsettings set org.gtk.Settings.FileChooser show-hidden true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

gsettings set org.gnome.mutter center-new-windows true
