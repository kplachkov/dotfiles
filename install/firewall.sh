#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Permission denied (try with sudo)"
	exit 1
fi

echo "Setting up firewall"

read -r -p "Allow a device to connect to GSConnect [y/N]: " reply
if [[ $reply =~ ^[Yy]$ ]]; then
	read -r -p "Enter the device private IP: " device_ip

	read -r -p "Are you sure you want to allow ($device_ip) to connect to the computer [y/N]: " reply
	if [[ $reply =~ ^[Yy]$ ]]; then
		ufw allow from "$device_ip" to any port 1714:1764 proto udp
		ufw allow from "$device_ip" to any port 1714:1764 proto tcp
	else
		echo "Abort"
	fi
fi

ufw enable
ufw status
