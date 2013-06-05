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

# Fix for vundle install
rmdir $cur_dir/vim/bundle/vundle
cd $cur_dir/vim/bundle/
git clone https://github.com/gmarik/vundle.git
