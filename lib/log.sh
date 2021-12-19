#!/usr/bin/env bash

function log_fatal {
	echo "$1" >&2
	exit 1
}

function log_error {
	echo "$1" >&2
}
