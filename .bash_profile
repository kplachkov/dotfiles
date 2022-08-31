# shellcheck disable=SC2148

if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

for file in ~/.{exportrc,exportrc_private}; do
	# shellcheck disable=SC1090
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Set PATH so it includes user's private bin.

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.npm-global/bin" ]; then
	PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "$GOBIN" ]; then
	PATH="$GOBIN:$PATH"
fi
