#!/bin/bash

cur_dir=`pwd`
cd ..
git clone 'https://github.com/muennich/urxvt-perls.git'

urxvt_lib_dir="$HOME/.config/urxvt"

mkdir $urxvt_lib_dir
cp urxvt-perls/clipboard $urxvt_lib_dir/

cd $cur_dir
