# shellcheck disable=SC2148

# Don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth
# Increase the maximum number of commands recorded.
export HISTSIZE=100000
# Increase the maximum number of lines of history.
export HISTFILESIZE=100000
# Don't add certain commands to the history file.
export HISTIGNORE="clear:history:exit:pwd:cd:ll:ls:-:reboot:shutdown now:sudo -i"
# Update bash history in real time.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

export NPM_CONFIG_PREFIX="$HOME/.npm-global"

export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1

export HOMEBREW_NO_ANALYTICS=1

if _have /home/linuxbrew/.linuxbrew/bin/brew; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif _have /opt/homebrew/bin/brew; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if _have code; then
	export EDITOR="code --wait --new-window"
	export VISUAL="code --wait --new-window"
fi

if _have bat; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export MANROFFOPT="-c"
fi

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$NPM_CONFIG_PREFIX/bin" ]; then
	PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
fi

if [ -d "$GOBIN" ]; then
	PATH="$GOBIN:$PATH"
fi
