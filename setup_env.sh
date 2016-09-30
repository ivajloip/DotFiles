#!/bin/bash -e

cur_dir=`pwd`

ln -s $cur_dir/vimrc ~/.vimrc
ln -s $cur_dir/tmux.conf ~/.tmux.conf
ln -s $cur_dir/zshrc ~/.zshrc
ln -s $cur_dir/xxkbrc ~/.xxkbrc
ln -s $cur_dir/Xdefaults ~/.Xdefaults
ln -s $cur_dir/vim ~/.vim
ln -s $cur_dir/xprofile ~/.xprofile
ln -s $cur_dir/gitconfig ~/.gitconfig
ln -s $cur_dir/ycm_extra_conf.py ~/.ycm_extra_conf.py
ln -s $cur_dir/awesome ~/.config/

mkdir $HOME/.config/urxvt/
ln -s $cur_dir/urxvt-perls/clipboard $HOME/.config/urxvt/
