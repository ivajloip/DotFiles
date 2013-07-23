#!/bin/bash -e

bash setup_urxvt_clipboard.sh

# install some programs
sudo apt-get install htop iotop tcpdump acpitool vim vim-gtk awesome \
  tmux rxvt-unicode xxkb git zsh xpra axel xnest xsel x11-utils network-manager-gnome

bash setup_env.sh
