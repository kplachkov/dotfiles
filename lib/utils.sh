#!/usr/bin/env bash

function neofetch_val() {
	out=$(neofetch "$@") || return $?
	val=${out#*: }
	echo "$val" | trim
}

function have() {
	out=$(command -v "$@") || return $?
	if [ $# -ne "$(printf "%s" "$out" | grep -c "^")" ]; then
		# Partial match.
		return 3
	fi
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

function get_desktop_env() {
	neofetch_val de
}

function get_distro() {
	neofetch_val distro --distro_shorthand tiny --os_arch off
}

function is_linux() {
	[[ $(uname | to_lower) == linux ]]
}

function is_distro() {
	[[ $(get_distro | to_lower) == *"$1"* ]]
}

function is_desktop_env() {
	[[ $(get_desktop_env | to_lower) == *"$1"* ]]
}

function is_fedora() {
	is_distro fedora
}

function is_ubuntu() {
	is_distro ubuntu
}

function is_gnome() {
	is_desktop_env gnome
}

function has_gnome_ext() {
	is_gnome || return $?

	[[ $(gnome-extensions list | to_lower) == *"$1"* ]]
}
