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

Bundle 'gmarik/vundle'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdcommenter'
Bundle 'The-NERD-tree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'guns/vim-clojure-static'
Bundle 'vim-scripts/yavdb'
Bundle 'benmills/vimux'
Bundle 'sjl/gundo.vim'
Bundle 'tristen/vim-sparkup'
  
filetype plugin indent on

syntax on
colorscheme evening

" map escape to kj
inoremap kj <Esc>

" Write file
imap <F2> <Esc><F2>
nmap <F2> :w<CR>
nmap <F9> :source .vimrc<CR>

map <leader>nt :NERDTree<CR>
map <leader>gu :GundoToggle<CR>
map <leader><Space> :noh<CR>

" other setings
set encoding=utf-8
set fileencodings=utf-8,cp1251
set tags=./tags,tags
set history=1000
set colorcolumn=80
set cursorline
set cursorcolumn
hi CursorLine cterm=bold ctermbg=DarkRed guibg=DarkRed " Dark red 
hi SpellBad cterm=underline ctermbg=Black ctermfg=Magenta gui=underline guibg=Black guifg=Magenta

set dir=/tmp/
set pastetoggle=<F3>

" Add bulgarian as an input language, allowing keyboard bindings to work
set keymap=bulgarian-bds
set iminsert=0
set imsearch=-1

" Enable this option if you want the cursor to jump to the first detected
" error
let g:syntastic_auto_jump=1

" Automatically close the Gundo windows when reverting
let g:gundo_close_on_revert=1

" end of file
