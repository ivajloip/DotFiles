.DEFAULT_GOAL := install

UNAME := $(shell uname)
PKGS_MIN := htop tmux zsh
PKGS_DEV := build-essential git ripgrep
PKGS_NWK := iotop tpcdump
PKGS_DESKTOP := awesome acpitool clipit gnome-screensaver nemo network-manager-gnome rxvt-unicode x11-utils xclip xnest xpra xsel xxkb

INSTALL_CMD=$(shell [ "$(UNAME)" = "Darwin" ] && brew || apt )

.PHONY: install
install: init-submodules install-min
	@chsh -s /bin/zsh $(whomai)

.PHONY: init-submodules
init-submodules:
	@git submodule update --init --recursive

.PHONY: link-to-home
link-to-home: init-submodules
	@ln -s $(CURDIR)/tmux.conf ~/.tmux.conf
	@ln -s $(CURDIR)/zshrc ~/.zshrc
	@ln -s $(CURDIR)/gitconfig ~/.gitconfig
	@ln -s $(CURDIR)/vim/after ~/.config/nvim/after
	@ln -s $(CURDIR)/vim/init.lua ~/.config/nvim/init.lua
	@ln -s $(CURDIR)/vim/lua ~/.config/nvim/lua

.PHONY: link-to-home-linux
link-to-home-linux:
	@ln -s $(CURDIR)/xxkbrc ~/.xxkbrc
	@ln -s $(CURDIR)/Xdefaults ~/.Xdefaults
	@ln -s $(CURDIR)/xprofile ~/.xprofile
	@ln -s $(CURDIR)/awesome ~/.config/
	@mkdir $(HOME)/.config/urxvt/
	@ln -s $(CURDIR)/urxvt-perls/clipboard $(HOME)/.config/urxvt/

.PHONY: install-min
install-min: link-to-home
	@sudo $(INSTALL_CMD) install $(PKGS_MIN)

.PHONY: install-dev
install-dev:
	@sudo $(INSTALL_CMD) install $(PKGS_DEV)

.PHONY: install-desktop
install-nwk:
	@sudo $(INSTALL_CMD) install $(PKGS_NWK)

.PHONY: install-desktop
install-desktop:
	@sudo $(INSTALL_CMD) install $(PKGS_DESKTOP)

.PHONY: set-terminal-alternative
set-terminal-alternative:
	@sudo update-alternatives --config x-terminal-emulator
