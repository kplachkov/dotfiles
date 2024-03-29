# shellcheck disable=SC2148

# Navigation.
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias -- -="cd -"

# Development.
alias serve="python3 -m http.server"
alias edit='$EDITOR'

# Network.
alias edithosts='$EDITOR /etc/hosts'
alias lshosts="cat /etc/hosts"
alias lsnet="sudo netstat -tupln"

# Report.
alias ll='ls -alhF'
alias la='ls -A'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
# $ sleep 10; alert
alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')" && printf "\7"'
