#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Permission denied (try with sudo)"
	exit 1
fi

echo "Setting up snap aliases"

snap alias microk8s.kubectl kubectl
snap alias microk8s.helm helm
