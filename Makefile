##@ General

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

auto-install: ## Run automated installation.
	@./install.sh

OS = $(shell .local/bin/tinyfetch -o)
KERNEL = $(shell .local/bin/tinyfetch -k)

define git_install
	git -C $3 fetch || git -c advice.detachedHead=false clone --branch $2 --depth 1 $1 $3
	git -C $3 -c advice.detachedHead=false checkout $2
endef

ifeq ($(KERNEL),darwin)
brew = eval "$$(/opt/homebrew/bin/brew shellenv)" && brew
else ifeq ($(KERNEL),linux)
brew = eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && brew
else
$(error Unsupported kernel ($(KERNEL)).)
endif

##@ Operating systems

fedora-silverblue: configuration gnome rpm-ostree-packages flatpaks tpm ## Install Fedora Silverblue setup.

fedora-workstation: configuration gnome dnf-packages tpm ## Install Fedora Workstation setup.

github-codespaces: configuration apt-packages tpm homebrew ## Install GitHub Codespaces setup.
	$(brew) install \
		k9s \
		lazygit \
		shellcheck \
		shfmt

	cp -R ~/.profile.d/* ~/.bashrc.d/
	rm ~/.npmrc

POWERLINE_REPOSITORY = https://github.com/powerline/powerline
POWERLINE_RELEASE = 2.8.4
POWERLINE_DIR = ~/.powerline

macos: configuration homebrew homebrew-packages tpm ## Install macOS setup.
	$(call git_install,$(POWERLINE_REPOSITORY),$(POWERLINE_RELEASE),$(POWERLINE_DIR))

ubuntu: configuration gnome apt-packages tpm ## Install Ubuntu setup.
	sudo ubuntu-drivers install

##@ Desktop environments

gnome: ## Apply GNOME settings.
	# Keybindings.
	gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-group "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-windows "[]"
	gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "[]"
	gsettings set org.gnome.shell.keybindings toggle-application-view "[]"
	gsettings set org.gnome.settings-daemon.plugins.media-keys logout "['<Control><Super>End']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Super><Shift>Right']"
	gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Super><Shift>Left']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Above_Tab', '<Control><Super>Right']"
	gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Shift><Super>Above_Tab', '<Control><Super>Left']"
	gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
	gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Super>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "['<Shift><Super>Tab']"
	gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Alt>F11']"
	gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>q']"

	# Keyboard.
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'bg+phonetic')]"
	gsettings set org.gnome.desktop.input-sources per-window true
	gsettings set org.gnome.desktop.a11y.keyboard mousekeys-enable true
	gsettings set org.gnome.desktop.a11y.keyboard mousekeys-max-speed 1100
	gsettings set org.gnome.desktop.a11y.keyboard mousekeys-init-delay 60
	gsettings set org.gnome.desktop.a11y.keyboard mousekeys-accel-time 600
	gsettings set org.gnome.desktop.a11y.keyboard mousekeys-accel-time 600

	# Night light.
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
	gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 5
	gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 5
	gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2700

	# Power.
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 5400
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 3600

	# Appearance.
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.interface clock-show-weekday true
	gsettings set org.gnome.desktop.interface clock-format '24h'
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	
	# Miscellaneous.
	gsettings set org.gnome.system.locale region 'en_GB.UTF-8'
	gsettings set org.gnome.desktop.media-handling autorun-never true
	gsettings set org.gnome.desktop.privacy send-software-usage-stats false
	gsettings set org.gnome.desktop.privacy report-technical-problems false
	gsettings set org.gnome.mutter center-new-windows true
	gsettings set org.gtk.Settings.FileChooser show-hidden true
	gsettings set org.gtk.Settings.FileChooser sort-directories-first true
	gsettings set org.gnome.nautilus.preferences show-delete-permanently true
	gsettings set org.gnome.nautilus.preferences show-hidden-files true

##@ Software

rpm-ostree-packages: ## Install RPM-OSTree packages.
	sudo rpm-ostree install \
		alacritty \
		bat \
		libavcodec-freeworld \
		openssl \
		powerline \
		powerline-fonts \
		tmux \
		tmux-powerline

dnf-packages: ## Install DNF packages.
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
		sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' && \
		dnf check-update && \
		sudo dnf install -y code

	sudo dnf install -y \
		lshw \
		nmap \
		powerline \
		powerline-fonts \
		tmux \
		tmux-powerline \
		htop \
		iftop \
		bat \
		alacritty

apt-packages: ## Install APT packages.
	sudo apt-get update && sudo apt-get upgrade -y

	sudo apt-get install -y \
		curl \
		whois \
		net-tools \
		apt-transport-https \
		ca-certificates \
		gnupg \
		software-properties-common \
		nmap \
		htop \
		iftop \
		tmux \
		tree \
		xclip \
		powerline \
		fonts-powerline \
		bat \
		git \
		cmake \
		ruby-dev \
		shc \
		python3-pip \
		pipenv \
		python3-tk \
		libseccomp-dev \
		protobuf-compiler \
		imagemagick \
		gimp
	
	mkdir -p ~/.local/bin
	ln -fs /usr/bin/batcat ~/.local/bin/bat

flatpaks:
	flatpak install flathub \
		org.gnome.Boxes \
		com.mattjakeman.ExtensionManager

homebrew-packages: ## Install Homebrew packages.
	$(brew) install \
		go \
		node \
		helm \
		kubectl \
		minikube \
		k9s \
		lazygit \
		shellcheck \
		shfmt \
		hugo

homebrew: ## Install Homebrew.
	NONINTERACTIVE=1 bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	$(brew) analytics off

TPM_REPOSITORY = https://github.com/tmux-plugins/tpm
TPM_RELEASE = v3.1.0
TPM_DIR = ~/.tmux/plugins/tpm

tpm: ## Install Tmux Plugin Manager.
	$(call git_install,$(TPM_REPOSITORY),$(TPM_RELEASE),$(TPM_DIR))

##@ Common

EXPORTS_DF_SH_PATH = ~/.profile.d/exports.df.sh

define EXPORTS_DF_SH_TEMPLATE
# Code generated by dotfiles.

export POWERLINE_BASH_CONFIG='%s'
export POWERLINE_TMUX_CONFIG='%s'

endef

export EXPORTS_DF_SH_TEMPLATE
configuration: ## Apply configurations of packages and dotfiles.
	cp .bash_profile .bashrc .gitconfig .inputrc .npmrc .tmux.conf ~/
	cp -R .profile.d ~/
	cp -R .bashrc.d ~/

	cp -R .config/powerline ~/.config/
	cp -R .config/lazygit ~/.config/
	cp -R .config/htop ~/.config/

	mkdir -p ~/.config/alacritty
	cp .config/alacritty/base.toml .config/alacritty/theme.toml ~/.config/alacritty/
	cp .config/alacritty/alacritty-$(KERNEL).toml ~/.config/alacritty/alacritty.toml

ifeq ($(OS),$(filter $(OS),fedora-silverblue fedora-workstation))
	printf "$$EXPORTS_DF_SH_TEMPLATE" \
		'/usr/share/powerline/bash/powerline.sh' \
		'/usr/share/tmux/powerline.conf' \
		> $(EXPORTS_DF_SH_PATH)
else ifeq ($(OS),$(filter $(OS),github-codespaces github-ubuntu ubuntu))
	printf "$$EXPORTS_DF_SH_TEMPLATE" \
		'/usr/share/powerline/bindings/bash/powerline.sh' \
		'/usr/share/powerline/bindings/tmux/powerline.conf' \
		> $(EXPORTS_DF_SH_PATH)
else ifeq ($(OS),macos)
	printf "$$EXPORTS_DF_SH_TEMPLATE" \
		'$(POWERLINE_DIR)/powerline/bindings/bash/powerline.sh' \
		'$(POWERLINE_DIR)/powerline/bindings/tmux/powerline.conf' \
		> $(EXPORTS_DF_SH_PATH)
else
	$(warning Unsupported OS ($(OS)). Powerline may not work.)
endif

gpg-key: ## Generate GPG key.
	@gpg --full-generate-key

SSH_COMMENT = $(shell echo "$(USER) - $(OS)")

ssh-keys: ## Generate SSH keys.
	ssh-keygen -q -t rsa -b 4096 -C "$(SSH_COMMENT)" -f ~/.ssh/id_rsa
	ssh-keygen -q -t ed25519 -C "$(SSH_COMMENT)" -f ~/.ssh/id_ed25519

default-apps: ## Set default applications.
	xdg-mime default code.desktop text/plain

##@ Development

fmt: ## Format code.
	@shfmt -w -s .

lint: ## Lint code.
	@shfmt -d -s .
	@shellcheck -x $$(shfmt -f .)
