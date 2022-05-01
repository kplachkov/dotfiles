#!/usr/bin/env bash

# shellcheck source=lib/log.sh
. "$DOTFILES_PATH/lib/log.sh" || retun $?

function install_dependencies {
	havecmd lshw || sudo apt install -y lshw
}

function main {
	echo "Generating SSH keys"

	if ! install_dependencies; then
		log_error "Installing dependencies failed"
		return 1
	fi

	local passphrase
	local passphrase_confirmation

	while true; do
		read -r -s -p "Enter passphrase: " passphrase
		read -r -s -p $'\nConfirm passphrase: ' passphrase_confirmation
		echo ""

		if [[ $passphrase == "$passphrase_confirmation" ]]; then
			break
		fi

		echo $'\nPassphrases do not match. Try again...\n'
	done

	machine_name=$(sudo lshw | grep -m1 -oP "(?<=product: )(.*)")
	if [[ -z $machine_name ]]; then
		log_error "Missing machine name"
		return 1
	fi

	distribution_id=$(lsb_release -i -s)
	distribution_release=$(lsb_release -r -s)

	distribution="$distribution_id $distribution_release"

	comment="$machine_name - $distribution"

	echo "Comment: $comment"

	ssh-keygen -q -t rsa -b 4096 -C "$comment" -P "$passphrase" -f ~/.ssh/id_rsa
	ssh-keygen -q -t ed25519 -C "$comment" -P "$passphrase" -f ~/.ssh/id_ed25519
}

main "$@"
