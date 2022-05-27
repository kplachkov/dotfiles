#!/usr/bin/env bash

function neofetchval() {
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

function tolower() {
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
