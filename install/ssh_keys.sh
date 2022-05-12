#!/usr/bin/env bash

# shellcheck source=lib/neofetch.sh
. "$DOTFILES_PATH/lib/neofetch.sh"

function gen_identity() {
	hardware_model=$(neofetchval model) || return $?
	distro=$(neofetchval distro --distro_shorthand tiny --os_arch off) || return $?
	desktop_env=$(neofetchval de) || return $?

	echo "$hardware_model - $distro - $desktop_env"
}

function main {
	echo "Generating SSH keys"

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

	comment=$(gen_identity) || return $?

	echo "Comment: $comment"

	ssh-keygen -q -t rsa -b 4096 -C "$comment" -P "$passphrase" -f ~/.ssh/id_rsa
	ssh-keygen -q -t ed25519 -C "$comment" -P "$passphrase" -f ~/.ssh/id_ed25519
}

main "$@"
