# shellcheck disable=SC2148

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, then return.
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

if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      # shellcheck disable=SC1090
      . "$rc"
    fi
  done
  unset rc
fi
