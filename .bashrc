#!/usr/bin/env bash

# If not running interactively, don't do anything.
case $- in
*i*) ;;
*) return ;;
esac

function _have() {
	out=$(command -v "$@") || return $?
	if [ $# -ne "$(printf "%s" "$out" | grep -c "^")" ]; then
		# Partial match.
		return 3
	fi
}

function _bashrc_source_rcs() {
  for file in ~/.{aliasrc,exportrc,exportrc_private}; do
    # shellcheck disable=SC1090
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
  done
}

function _bashrc_configure_less() {
  # Make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
}

function _bashrc_set_ps1() {
  if _have powerline-daemon; then
    powerline-daemon -q
    export POWERLINE_BASH_CONTINUATION=1
    export POWERLINE_BASH_SELECT=1
    . "/usr/share/powerline/bash/powerline.sh" && return 0
  fi

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

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm* | rxvt*)
  	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  	;;
  *) ;;
  esac
}

function _bashrc_set_dir_colors() {
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi
}

function _bashrc_set_options() {
  # Command name that is the name of a directory is executed
  # as if it were the argument to the cd command. This option
  # is only used by interactive shells.
  shopt -s autocd

  # Minor errors in the spelling of a directory component in a
  # cd command will be corrected. The errors checked for are
  # transposed characters, a missing character, and a character
  # too many. If a correction is found, the corrected path is
  # printed, and the command proceeds. This option is only
  # used by interactive shells.
  shopt -s cdspell

  # Check that a command found in the hash table exists before
  # trying to execute it. If a hashed command no longer exists,
  # a normal path search is performed.
  shopt -s checkhash

  # Attempt spelling correction on directory names during word
  # completion if the directory name initially supplied does not
  # exist.
  shopt -s dirspell

  # Include filenames beginning with a `.` in the results of
  # filename expansion. The filenames `.` and `..` must always
  # be matched explicitly, even if dotglob is set.
  shopt -s dotglob

  # Use extended pattern matching features.
  shopt -s extglob

  # The pattern ‘**’ used in a filename expansion context will match
  # all files and zero or more directories and subdirectories. If the
  # pattern is followed by a ‘/’, only directories and subdirectories
  # match.
  shopt -s globstar

  # The history list is appended to the file named by the value of the
  # HISTFILE variable when the shell exits, rather than overwriting
  # the file.
  shopt -s histappend

  # Give the user the opportunity to re-edit a failed history
  # substitution.
  shopt -s histreedit

  # The results of history substitution are not immediately passed to
  # the shell parser. Instead, the resulting line is loaded into the
  # Readline editing buffer, allowing further modification.
  shopt -s histverify

  # Match filenames in a case-insensitive fashion when performing
  # filename expansion.
  shopt -s nocaseglob

  # Treat a command name that doesn’t have any completions as a possible
  # alias and attempt alias expansion. If it has an alias, Bash attempts
  # programmable completion using the command word resulting from the
  # expanded alias.
  shopt -s progcomp_alias
}

function _bashrc_init_completion() {
  # Enable programmable completion features.
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi

  # shellcheck disable=SC1090
  _have kubectl && source <(kubectl completion bash)

  _have pipenv && eval "$(pipenv --completion)"

  if _have pip3; then
    _pip_completion() {
      # shellcheck disable=SC2207
      COMPREPLY=($(COMP_WORDS="${COMP_WORDS[*]}" \
        COMP_CWORD=$COMP_CWORD \
        PIP_AUTO_COMPLETE=1 $1 2>/dev/null))
    }
    complete -o default -F _pip_completion pip3
  fi
}

_bashrc_source_rcs
_bashrc_configure_less
_bashrc_set_ps1
_bashrc_set_dir_colors
_bashrc_set_options
_bashrc_init_completion
