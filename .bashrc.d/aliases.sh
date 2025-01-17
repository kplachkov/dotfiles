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

# Report.
alias ll='ls -alhF'
alias la='ls -A'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
