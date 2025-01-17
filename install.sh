#!/usr/bin/env bash

function log_fatal {
	echo "$1" >&2
	exit 1
}

function log_error {
	echo "$1" >&2
}

function tinyfetch() {
	"$(dirname "$(readlink -f "$0")")"/.local/bin/tinyfetch "$@"
}

function main() {
	echo "Starting automated installation..."

	os=$(tinyfetch -o 2>/dev/null)

	case $os in
	fedora-silverblue)
		echo "Installing Fedora Silverblue setup..."
		make fedora-silverblue --no-print-directory || return $?
		;;
	fedora-workstation)
		echo "Installing Fedora Workstation setup..."
		make fedora-workstation --no-print-directory || return $?
		;;
	github-codespaces | github-ubuntu)
		echo "Installing GitHub Codespaces setup..."
		make github-codespaces --no-print-directory || return $?
		;;
	macos)
		echo "Installing macOS setup..."
		make macos --no-print-directory || return $?
		;;
	ubuntu)
		echo "Installing Ubuntu setup..."
		make ubuntu --no-print-directory || return $?
		;;
	*)
		log_fatal "Unsupported OS ($(tinyfetch))."
		;;
	esac

	echo "Done."
}

main "$@"
