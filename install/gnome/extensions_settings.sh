#!/usr/bin/env bash

. "$DOTFILES_PATH/lib/utils.sh" || exit $?

echo "Applying GNOME extensions settings"

if has_gnome_ext "auto-move-windows"; then
	echo " - auto move windows"

	gsettings set org.gnome.shell.extensions.auto-move-windows application-list "['google-chrome.desktop:1', 'Alacritty.desktop:1', 'code.desktop:2']"
fi

if has_gnome_ext "desktop-icons"; then
	echo " - desktop icons"

	gsettings set org.gnome.shell.extensions.desktop-icons show-trash false
	gsettings set org.gnome.shell.extensions.desktop-icons show-home false
	gsettings set org.gnome.shell.extensions.desktop-icons icon-size 'small'
fi

if has_gnome_ext "user-theme"; then
	echo " - user theme"

	gsettings set org.gnome.shell.extensions.user-theme name "Yaru-dark"
fi

if has_gnome_ext "dash-to-dock"; then
	echo " - dash to dock"

	gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'DYNAMIC'
	gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-text '<Super>q'
	gsettings set org.gnome.shell.extensions.dash-to-dock apply-custom-theme false
	gsettings set org.gnome.shell.extensions.dash-to-dock apply-glossy-effect true
	gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'cycle-windows'
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-9 "['<Super>9']"
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color false
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-1 "['<Shift><Super>1']"
	gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor false
	gsettings set org.gnome.shell.extensions.dash-to-dock height-fraction 0.9
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-1 "['<Ctrl><Super>1']"
	gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces false
	gsettings set org.gnome.shell.extensions.dash-to-dock shift-click-action 'minimize'
	gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-timeout 1.0
	gsettings set org.gnome.shell.extensions.dash-to-dock show-delay 0.25
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-2 "['<Shift><Super>2']"
	gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview true
	gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-2 "['<Ctrl><Super>2']"
	gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen false
	gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
	gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'switch-workspace'
	gsettings set org.gnome.shell.extensions.dash-to-dock shift-middle-click-action 'launch'
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-border-color '#e95420'
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-3 "['<Shift><Super>3']"
	gsettings set org.gnome.shell.extensions.dash-to-dock pressure-threshold 200.0
	gsettings set org.gnome.shell.extensions.dash-to-dock hide-delay 0.1
	gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top false
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-3 "['<Ctrl><Super>3']"
	gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites true
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-4 "['<Shift><Super>4']"
	gsettings set org.gnome.shell.extensions.dash-to-dock show-running true
	gsettings set org.gnome.shell.extensions.dash-to-dock force-straight-corner false
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-1 "['<Super>1']"
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-4 "['<Ctrl><Super>4']"
	gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'
	gsettings set org.gnome.shell.extensions.dash-to-dock hotkeys-overlay true
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-5 "['<Shift><Super>5']"
	gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.1
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-color '#e95420'
	gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color false
	gsettings set org.gnome.shell.extensions.dash-to-dock hotkeys-show-dock false
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-5 "['<Ctrl><Super>5']"
	gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button true
	gsettings set org.gnome.shell.extensions.dash-to-dock animate-show-apps true
	gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items false
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-2 "['<Super>2']"
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-running-dots-border-width 0
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-6 "['<Shift><Super>6']"
	gsettings set org.gnome.shell.extensions.dash-to-dock shortcut "['<Super>q']"
	gsettings set org.gnome.shell.extensions.dash-to-dock customize-alphas true
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-3 "['<Super>3']"
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-6 "['<Ctrl><Super>6']"
	gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
	gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts true
	gsettings set org.gnome.shell.extensions.dash-to-dock minimize-shift true
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-7 "['<Shift><Super>7']"
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-10 "['<Super>0']"
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots true
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-4 "['<Super>4']"
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-7 "['<Ctrl><Super>7']"
	gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 1.0
	gsettings set org.gnome.shell.extensions.dash-to-dock middle-click-action 'launch'
	gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-8 "['<Shift><Super>8']"
	gsettings set org.gnome.shell.extensions.dash-to-dock max-alpha 1.0
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-5 "['<Super>5']"
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-8 "['<Ctrl><Super>8']"
	gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-9 "['<Shift><Super>9']"
	gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
	gsettings set org.gnome.shell.extensions.dash-to-dock require-pressure-to-show true
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-6 "['<Super>6']"
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-9 "['<Ctrl><Super>9']"
	gsettings set org.gnome.shell.extensions.dash-to-dock bolt-support true
	gsettings set org.gnome.shell.extensions.dash-to-dock scroll-switch-workspace true
	gsettings set org.gnome.shell.extensions.dash-to-dock preferred-monitor 0
	gsettings set org.gnome.shell.extensions.dash-to-dock min-alpha 0.0
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-7 "['<Super>7']"
	gsettings set org.gnome.shell.extensions.dash-to-dock app-ctrl-hotkey-10 "['<Ctrl><Super>0']"
	gsettings set org.gnome.shell.extensions.dash-to-dock activate-single-window true
	gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'FOCUS_APPLICATION_WINDOWS'
	gsettings set org.gnome.shell.extensions.dash-to-dock isolate-monitors false
	gsettings set org.gnome.shell.extensions.dash-to-dock background-color '#ffffff'
	gsettings set org.gnome.shell.extensions.dash-to-dock app-hotkey-8 "['<Super>8']"
	gsettings set org.gnome.shell.extensions.dash-to-dock app-shift-hotkey-10 "['<Shift><Super>0']"
	gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys true
fi
