# shellcheck disable=SC2148

if _have powerline-daemon; then
	powerline-daemon -q
	# shellcheck disable=SC1090
	. "$POWERLINE_BASH_CONFIG"
fi
