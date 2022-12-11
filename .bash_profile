# shellcheck disable=SC2148

if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

if [ -d ~/.profile.d ]; then
  for rc in ~/.profile.d/*; do
    if [ -f "$rc" ]; then
      # shellcheck disable=SC1090
      . "$rc"
    fi
  done
  unset rc
fi
