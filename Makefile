.DEFAULT_GOAL := install

.PHONY: init-submodules
init-submodules:
	@git submodule update --init --recursive

.PHONY: link-to-home
link-to-home: init-submodules
	@ln -s $(CURDIR)/vimrc ~/.vimrc
	@ln -s $(CURDIR)/tmux.conf ~/.tmux.conf
	@ln -s $(CURDIR)/zshrc ~/.zshrc
	@ln -s $(CURDIR)/xxkbrc ~/.xxkbrc
	@ln -s $(CURDIR)/Xdefaults ~/.Xdefaults
	@ln -s $(CURDIR)/vim ~/.vim
	@ln -s $(CURDIR)/xprofile ~/.xprofile
	@ln -s $(CURDIR)/gitconfig ~/.gitconfig
	@ln -s $(CURDIR)/ycm_extra_conf.py ~/.ycm_extra_conf.py
	@ln -s $(CURDIR)/awesome ~/.config/
	@mkdir $(HOME)/.config/urxvt/
	@ln -s $(CURDIR)/urxvt-perls/clipboard $HOME/.config/urxvt/

.PHONY: install-base-apps-debian
install-base-apps-debian: link-to-home
	# not tested
	@sudo apt-get install \
		htop \
		iotop \
		tcpdump \
		vim \
		vim-gtk \
		git \
		zsh \
		awesome \
		tmux \
		rxvt-unicode \
		acpitool \
		xxkb \
		xpra \
		axel \
		xnest \
		xsel \
		x11-utils \
		network-manager-gnome \
		build-essentials \
		ack

.PHONY: install-base-apps-fedora
install-base-apps-fedora: link-to-home
	# not tested
	@dnf install \
		htop \
		iotop \
		tcpdump \
		vim \
		vim-gtk \
		git \
		zsh \
		awesome \
		tmux \
		rxvt-unicode \
		acpitool \
		xxkb \
		xpra \
		axel \
		xnest \
		xsel \
		x11-utils \
		network-manager-gnome \
		build-essentials \
		ack

.PHONY: set-terminal-alternative
set-terminal-alternative:
	@sudo update-alternatives --config x-terminal-emulator
