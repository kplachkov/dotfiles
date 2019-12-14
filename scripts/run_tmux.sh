#!/bin/bash

if [ "$(tmux a 2>&1)" == "no sessions" ]; then
	tmux
fi
