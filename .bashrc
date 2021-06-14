# If not running interactively, don't do anything.
case $- in
*i*) ;;
*) return ;;
esac

# Load additional settings.
for file in ~/.{aliases,bash_options,exports}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;
esac

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. "/usr/share/powerline/bindings/bash/powerline.sh"

# Completions
if command -v kubectl &>/dev/null; then
	source <(kubectl completion bash)
fi

eval "$(pipenv --completion)"

# pip bash completion start
_pip_completion() {
	COMPREPLY=($(COMP_WORDS="${COMP_WORDS[*]}" \
		COMP_CWORD=$COMP_CWORD \
		PIP_AUTO_COMPLETE=1 $1 2>/dev/null))
}
complete -o default -F _pip_completion pip3
# pip bash completion end

eval "$(direnv hook bash)"
