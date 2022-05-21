#!/usr/bin/env bash

function neofetchval() {
	out=$(neofetch "$@") || return $?
	val=${out#*: }
	echo "$val"
}

function neofetchlower() {
	out=$(neofetchval "$@") || return $?
	val=${out,,}
	echo "$val"
}
