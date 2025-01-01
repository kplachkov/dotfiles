#!/usr/bin/env bash

function log_fatal {
	echo "$1" >&2
	exit 1
}

function log_error {
	echo "$1" >&2
}

function to_lower() {
	if [ -t 0 ]; then
		return 2
	fi

	cat | tr "[:upper:]" "[:lower:]"
}

function trim() {
	if [ -t 0 ]; then
		return 2
	fi

	input=$(cat) || return $?

	# Remove leading whitespace characters.
	input="${input#"${input%%[![:space:]]*}"}"

	# Remove trailing whitespace characters.
	input="${input%"${input##*[![:space:]]}"}"

	printf '%s' "$input"
}

function osfetch() {
	grep -oP '^ID="?\K[a-zA-Z0-9_ ]+' /etc/os-release 2>/dev/null || uname | to_lower
}

function main() {
	echo "Starting automated installation..."

	os_id=$(osfetch)

	case $os_id in
	ubuntu)
		if [[ $TERM_PROGRAM == "vscode" || -z $DISPLAY ]]; then
			echo "Installing GitHub Codespaces setup..."
			make github-codespaces --no-print-directory || return $?
		else
			echo "Installing Ubuntu Desktop setup..."
			make ubuntu-desktop --no-print-directory || return $?
		fi
		;;
	fedora)
		echo "Installing Fedora Workstation setup..."
		make fedora-workstation --no-print-directory || return $?
		;;
	darwin)
		echo "Installing macOS setup..."
		make macos --no-print-directory || return $?
		;;
	*)
		log_fatal "Unsupported OS/kernel ($os_id)."
		;;
	esac

	echo "Done."
}

main "$@"
