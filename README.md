# [KP](https://github.com/kplachkov)'s dotfiles

[![CI](https://github.com/kplachkov/dotfiles/workflows/CI/badge.svg)](https://github.com/kplachkov/dotfiles/actions?query=workflow%3ACI)

The Software Engineer's setup. Ubuntu dotfiles, scripts and configurations.

## Installation
:warning: **DO NOT** run this setup if you do not fully
understand [what it does](install/main.sh). :warning:

```shell
bash -c "$(wget -qO - https://raw.githubusercontent.com/kplachkov/dotfiles/master/install/main.sh)"
```

`.aliasrc`, `.bashrc`, `.cmdrc`, `.exportrc`, `.imwheelrc`, `.inputrc`, `.profile` and `.tmux.conf` will be linked in `$HOME`, if those files already exist -- they will be replaced.
