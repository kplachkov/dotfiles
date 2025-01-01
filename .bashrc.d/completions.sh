# shellcheck disable=SC2148

# Enable programmable completion features.
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		# shellcheck disable=SC1091
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		# shellcheck disable=SC1091
		. /etc/bash_completion
	fi
fi

# shellcheck disable=SC1090
_have helm && source <(helm completion bash)

# shellcheck disable=SC1090
_have minikube && source <(minikube completion bash)

# shellcheck disable=SC1090
_have kubectl && source <(kubectl completion bash)

if _have pip3; then
	_pip_completion() {
		# shellcheck disable=SC2207
		COMPREPLY=($(COMP_WORDS="${COMP_WORDS[*]}" \
			COMP_CWORD=$COMP_CWORD \
			PIP_AUTO_COMPLETE=1 $1 2>/dev/null))
	}
	complete -o default -F _pip_completion pip3
fi

if _have brew; then
	HOMEBREW_PREFIX="$(brew --prefix)"

	if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
		# shellcheck disable=SC1091
		source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
	else
		for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
			# shellcheck disable=SC1090
			[[ -r ${COMPLETION} ]] && source "${COMPLETION}"
		done
	fi
fi
