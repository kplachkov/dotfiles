#!/usr/bin/env bash

scripts_dir=$(dirname "$(readlink -f "$0")")

if ! pgrep chrome; then
	google-chrome &
fi

if ! pgrep smartgit.sh; then
	~/smartgit/bin/smartgit.sh &
fi

if ! pgrep goland.sh; then
	goland &
fi

if ! tmux_proc_count=$(pgrep -c tmux) || [[ $tmux_proc_count == 1 ]]; then
	"$scripts_dir"/gtmux.sh &
fi
