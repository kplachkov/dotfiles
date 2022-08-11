# [KP](https://github.com/kplachkov)'s dotfiles

[![CI](https://github.com/kplachkov/dotfiles/workflows/CI/badge.svg)](https://github.com/kplachkov/dotfiles/actions?query=workflow%3ACI)

The Software Engineer's setup (applications, desktop environment settings, dotfiles, scripts, libraries and
configurations).

## Installation

:warning: **DO NOT** run this setup if you do not fully
understand [what it does](install/main.sh). :warning:

```shell
bash -c "$(wget -qO - https://raw.githubusercontent.com/kplachkov/dotfiles/master/install/main.sh)"
```

Installation support based on OS:

- Full: Fedora, Ubuntu
- Partial<sup>[a]</sup>: RHEL-based, Debian-based distributions
- Minimal<sup>[b]</sup>: Arch-based, openSUSE-based distributions and macOS

High level representation of the installation process:

- Downloading the repository (by default it is done at `~/projects/dotfiles`, use `DOTFILES_PATH` to change the
  location).
- Installing applications, scripts and libraries.
- Configuring the settings of the desktop environment.
- Generating PGP keys, SSH keys and firewall rules (requires input).
- Installing Python 3 applications and libraries.
- Linking the configuration of applications and the dotfiles (if the files already exist -- they will be replaced).

---

_Notes:_

_a. Partial installation means that some applications may not be installed and some configurations may be missing._  
_b. Minimal installation means that only the dotfiles and the desktop environment (if supported) will be set up._