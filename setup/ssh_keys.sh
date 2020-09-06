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
distribution="$(lsb_release -i -s) $(lsb_release -r -s)"
comment="$machine_name - $distribution"
echo "Comment: $comment"

ssh-keygen -q -t rsa -b 4096 -C "$comment" -P "$passphrase" -f ~/.ssh/id_rsa
ssh-keygen -q -t ed25519 -C "$comment" -P "$passphrase" -f ~/.ssh/id_ed25519

unset passphrase
unset passphrase_confirmation
