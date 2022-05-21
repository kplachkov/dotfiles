#!/usr/bin/env bash

export DOTFILES_PATH="$HOME/projects/dotfiles"

declare -r dotfiles_https_url="https://github.com/kplachkov/dotfiles.git"
declare -r dotfiles_ssh_url="git@github.com:kplachkov/dotfiles.git"

function install_utilities() {
	echo "Installing required utilities"

	distro=$(grep -oP '(?<=^ID=).*' /etc/os-release) || return $?

	case $distro in
	ubuntu)
		sudo apt update
		sudo apt install -y git neofetch || return $?
		;;
	*)
		echo "Unsupported distribution ($distro)" >&2
		return 1
		;;
	esac
}

function download_dotfiles() {
	echo "Downloading dotfiles"

	git clone "$dotfiles_https_url" "$DOTFILES_PATH" || return $?

	(cd "$DOTFILES_PATH" && git remote set-url origin "$dotfiles_ssh_url")
}

function source_functions() {
	echo "Sourcing required functions"

	local files=(.cmdrc lib/neofetch.sh lib/log.sh)

	for file in "${files[@]}"; do
		# shellcheck disable=SC1090
		source "$DOTFILES_PATH/$file" || return $?
	done
}

function install_common() {
	"$DOTFILES_PATH/install/firewall_rules.sh"

	"$DOTFILES_PATH/install/ssh_keys.sh"

	"$DOTFILES_PATH/install/pgp_keys.sh"

	"$DOTFILES_PATH/install/configs.sh"

	"$DOTFILES_PATH/install/default_apps.sh"

	"$DOTFILES_PATH/install/python_software.sh"

	"$DOTFILES_PATH/install/custom_software.sh"
}

function main() {
	echo "Installing setup"

	install_utilities || exit 1

	download_dotfiles || exit 1

	source_functions || exit 1

	distro=$(neofetchlower distro --distro_shorthand tiny --os_arch off)

	case $distro in
	ubuntu)
		"$DOTFILES_PATH/install/ubuntu/software.sh"
		"$DOTFILES_PATH/install/ubuntu/locale.sh"
		;;
	*)
		log_error "Unsupported distribution ($distro)"
		;;
	esac

	desktop_env=$(neofetchlower de)

	case $desktop_env in
	gnome)
		"$DOTFILES_PATH/install/gnome/settings.sh"
		"$DOTFILES_PATH/install/gnome/extensions.sh"
		;;
	*)
		log_error "Unsupported desktop environment ($desktop_env)"
		;;
	esac

	install_common

	echo "Done."
}

main "$@"
