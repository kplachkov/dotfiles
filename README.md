# [KP](https://github.com/kplachkov)'s dotfiles

[![CI](https://github.com/kplachkov/dotfiles/workflows/CI/badge.svg)](https://github.com/kplachkov/dotfiles/actions?query=workflow%3ACI)

The Software Engineer's setup (dotfiles, packages, desktop environment settings, scripts and configurations).

## Installation

```shell
make auto-install
```

Supported operating systems:
- Fedora Workstation
- Ubuntu Desktop
- macOS
- GitHub Codespaces

High level representation of the automated installation:
1. The automation determines the OS.
2. The configurations of packages and the dotfiles are applied (if the files already exist -- they will be replaced).
3. The settings of the desktop environment are applied.
4. Software is installed.

More information:
```shell
make help
```
