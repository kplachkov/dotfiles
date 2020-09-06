#!/bin/bash

echo "Setting up ssh keys"

while true; do
	read -s -p "Enter passphrase: " passphrase
	read -s -p $'\nConfirm passphrase: ' passphrase_confirmation
	echo ""

	if [[ "$passphrase" == "$passphrase_confirmation" ]]; then
		break
	fi

	echo $'\nPassphrases do not match. Try again...\n'
done

machine_name=$(sudo lshw | grep -m1 -oP "(?<=product: )(.*)")
echo "Comment: $machine_name"

ssh-keygen -q -t rsa -b 4096 -C "$machine_name" -P "$passphrase" -f ~/.ssh/id_rsa
ssh-keygen -q -t ed25519 -C "$machine_name" -P "$passphrase" -f ~/.ssh/id_ed25519

unset passphrase
unset passphrase_confirmation
