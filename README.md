# [KP](https://github.com/kplachkov)'s dotfiles

[![CI](https://github.com/kplachkov/dotfiles/workflows/CI/badge.svg)](https://github.com/kplachkov/dotfiles/actions?query=workflow%3ACI)

The Software Engineer's setup (dotfiles, packages, desktop environment settings, scripts and configurations).

## Installation

```shell
bash -c "$(wget -qO - https://raw.githubusercontent.com/kplachkov/dotfiles/master/install/main.sh)"
```

High level representation of the installation process:

- Downloading the repository (by default it is done at `~/projects/dotfiles`, use `DOTFILES_PATH` to change the
  location).
- Installing packages.
- Configuring the settings of the desktop environment.
- Generating PGP keys, SSH keys and firewall rules (requires input).
- Linking the configurations of packages and the dotfiles (if the files already exist -- they will be replaced).

Installation types based on operating systems:

- Full installation:
    - Fedora
    - Ubuntu

- Partial installation (some packages may not be installed, and some configurations may be missing):
    - RHEL-based distributions (excluding Fedora)
    - Debian-based distributions (excluding Ubuntu)

- Minimal installation (only the dotfiles and few packages and configurations will be installed):
    - Arch-based distributions
    - openSUSE-based distributions
    - macOS
