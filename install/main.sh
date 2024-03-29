#!/usr/bin/env bash

export DOTFILES_PATH="${DOTFILES_PATH:-$HOME/projects/dotfiles}"

declare -r dotfiles_https_url="https://github.com/kplachkov/dotfiles.git"
declare -r dotfiles_ssh_url="git@github.com:kplachkov/dotfiles.git"

function to_lower() {
	if [ -t 0 ]; then
		return 2
	fi

	cat | tr "[:upper:]" "[:lower:]"
}

function have() {
	out=$(command -v "$@") || return $?
	if [ $# -ne "$(printf "%s" "$out" | grep -c "^")" ]; then
		# Partial match.
		return 3
	fi
}

function install_utilities() {
	echo "Installing required utilities"

	core=$(uname | to_lower)

	case $core in
	linux)
		install_linux_utilities || return $?
		;;
	darwin)
		install_darwin_utilities || return $?
		;;
	*)
		echo "Unsupported core ($core)" >&2
		return 1
		;;
	esac
}

function install_linux_utilities() {
	if have apt-get; then
		sudo apt-get update
		sudo apt-get install -y git neofetch || return $?
	elif have dnf; then
		sudo dnf install -y git neofetch || return $?
	elif have pacman; then
		sudo pacman -S git neofetch || return $?
	elif have zypper; then
		sudo zypper in -y git-core neofetch || return $?
	else
		echo "No supported package manager found" >&2
		return 1
	fi
}

function install_darwin_utilities() {
	distro=$(sw_vers -productName | to_lower)

	case $distro in
	macos)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew install git neofetch || return $?
		;;
	*)
		echo "Unsupported Darwin distribution ($distro)" >&2
		return 1
		;;
	esac
}

function download_dotfiles() {
	if [[ -d $DOTFILES_PATH && -n "$(ls -A "$DOTFILES_PATH")" ]]; then
		echo "The directory of the dotfiles ($DOTFILES_PATH) is not empty"
	else
		echo "Downloading dotfiles"

		git clone "$dotfiles_https_url" "$DOTFILES_PATH" || return $?

		(cd "$DOTFILES_PATH" && git remote set-url origin "$dotfiles_ssh_url")
	fi

	validate_dotfiles || return $?
}

function validate_dotfiles() {
	echo "Validating dotfiles ($DOTFILES_PATH)"

	if [ -z "$DOTFILES_FINGERPRINT" ]; then
		echo "Environment variable (DOTFILES_FINGERPRINT) is not set, the validation of the dotfiles will not be performed"
		return 0
	fi

	if [[ $(gen_dotfiles_fingerprint) != "$DOTFILES_FINGERPRINT" ]]; then
		echo "Dotfiles are invalid" >&2
		return 1
	fi

	echo "Dotfiles are valid"
}

function gen_dotfiles_fingerprint() {
	git ls-files "$DOTFILES_PATH" |
		xargs -I {} sha256sum "{}" |
		cut -d " " -f 1 |
		sha256sum |
		cut -d " " -f 1
}

function source_functions() {
	# shellcheck source=lib/utils.sh
	source "$DOTFILES_PATH/lib/utils.sh" || return $?
	# shellcheck source=lib/log.sh
	source "$DOTFILES_PATH/lib/log.sh" || return $?
}

function configure_distro() {
	echo "Configuring distribution"

	if is_ubuntu; then
		"$DOTFILES_PATH/install/ubuntu/main.sh" || return $?
	elif is_fedora; then
		"$DOTFILES_PATH/install/fedora/main.sh" || return $?
	else
		log_error "Unsupported distribution ($(get_distro))"

		try_partial_installation || return $?
	fi
}

function try_partial_installation() {
	is_linux || return 1

	echo "Searching for partial installation"

	if have apt-get; then
		echo "Found partial installation (Ubuntu)"
		"$DOTFILES_PATH/install/ubuntu/main.sh" || return $?
	elif have dnf; then
		echo "Found partial installation (Fedora)"
		"$DOTFILES_PATH/install/fedora/main.sh" || return $?
	else
		log_error "No partial installation found"
		return 1
	fi
}

function configure_desktop_env() {
	echo "Configuring desktop environment"

	if is_gnome; then
		"$DOTFILES_PATH/install/gnome/main.sh" || return $?
	else
		log_error "Unsupported desktop environment ($(get_desktop_env))"
		return 1
	fi
}

function install_common() {
	"$DOTFILES_PATH/install/software.sh"

	"$DOTFILES_PATH/install/default_apps.sh"

	"$DOTFILES_PATH/install/firewall_rules.sh"

	"$DOTFILES_PATH/install/ssh_keys.sh"

	"$DOTFILES_PATH/install/pgp_keys.sh"

	"$DOTFILES_PATH/install/configs.sh"
}

function main() {
	echo "Installing setup"

	install_utilities || exit $?

	download_dotfiles || exit $?

	source_functions || exit $?

	configure_distro

	configure_desktop_env

	install_common

	echo "Done."
}

main "$@"
