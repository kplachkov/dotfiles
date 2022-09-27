#!/usr/bin/env bash

. "$DOTFILES_PATH/lib/utils.sh" || exit $?

have ufw || exit $?

echo "Setting up firewall rules"

read -r -p "Allow a device to connect to GSConnect [y/N]: " reply
if [[ $reply =~ ^[Yy]$ ]]; then
	read -r -p "Enter the device private IP: " device_ip

	read -r -p "Are you sure you want to allow ($device_ip) to connect to the computer [y/N]: " reply
	if [[ $reply =~ ^[Yy]$ ]]; then
		sudo ufw allow from "$device_ip" to any port 1714:1764 proto udp || exit $?
		sudo ufw allow from "$device_ip" to any port 1714:1764 proto tcp || exit $?
	else
		echo "Abort"
	fi

	unset device_ip
fi

sudo ufw enable || exit $?
sudo ufw status verbose
