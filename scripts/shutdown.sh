#!/bin/bash

result=$(zenity \
	--question \
	--title "Shutdown" \
	--text "Are you sure you want to shutdown your computer now?" \
	--default-cancel --width 250)

if $result; then
	shutdown now
fi
