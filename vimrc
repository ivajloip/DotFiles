" general settings
set nocompatible
set incsearch
set ignorecase
set autoindent
set tabstop=2
set sw=2
set expandtab
set shiftround
set showmatch
set cindent
set nu!
set wildmode=longest:full
set wildmenu

" Vundle
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set rtp+=~/.vim/bundle/vundle/
call vundle#rc('~/.vim/vundle')

Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdcommenter'
Bundle 'The-NERD-tree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fireplace'
  
filetype plugin indent on

syntax on
colorscheme evening

" map escape to kj
inoremap kj <Esc>

" Write file
imap <F2> <Esc><F2>
nmap <F2> :w<CR>

map <leader>nt :NERDTree<CR>

" other setings
set encoding=utf-8
set fileencodings=utf-8,cp1251
set tags=./tags,tags

" Enable this option if you want the cursor to jump to the first detected
" error
let g:syntastic_auto_jump=1

" end of file
