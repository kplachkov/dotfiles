#!/usr/bin/bash

# shellcheck source=pkg/log/log.sh
. "$DOTFILES_PATH/pkg/log/log.sh"

echo "Setting up firewall"

read -r -p "Allow a device to connect to GSConnect [y/N]: " reply
if [[ $reply =~ ^[Yy]$ ]]; then
	read -r -p "Enter the device private IP: " device_ip

	read -r -p "Are you sure you want to allow ($device_ip) to connect to the computer [y/N]: " reply
	if [[ $reply =~ ^[Yy]$ ]]; then
		/usr/bin/sudo /usr/sbin/ufw allow from "$device_ip" to any port 1714:1764 proto udp
		/usr/bin/sudo /usr/sbin/ufw allow from "$device_ip" to any port 1714:1764 proto tcp
	else
		echo "Abort"
	fi

	unset device_ip
fi

/usr/bin/sudo /usr/sbin/ufw enable
/usr/bin/sudo /usr/sbin/ufw status
