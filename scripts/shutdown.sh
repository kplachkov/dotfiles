#!/bin/bash

zenity \
--question \
--title "Shutdown" \
--text "Are you sure you want to shutdown your computer now?" \
--default-cancel --width 250 && \
if [ $? -eq 0 ]; then
	shutdown now
fi
