#!/usr/bin/bash

function log::fatal {
	echo "$1" >&2
	exit 1
}

function log::error {
	echo "$1" >&2
}
