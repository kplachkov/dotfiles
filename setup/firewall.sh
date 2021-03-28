#!/bin/bash

echo "Setting up firewall"

if [[ $EUID -ne 0 ]]; then
	echo "Permission denied (try with sudo)"
	exit 1
fi


read -p "Allow a device to connect to GSConnect [y/N]: " answer
if [[ $answer =~ ^[Yy]$ ]]; then
	read -p "Enter the device private IP: " device_ip

	read -p "Are you sure you want to allow ($device_ip) to connect to the computer [y/N]: " answer
	if [[ $answer =~ ^[Yy]$ ]]; then
		ufw allow from $device_ip to any port 1714:1764 proto udp
		ufw allow from $device_ip to any port 1714:1764 proto tcp
	else
		echo "Abort"
	fi
fi

ufw enable
ufw status
