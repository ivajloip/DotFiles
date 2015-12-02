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

" Remap <leader> to ','
let mapleader = ","

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
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'jgdavey/vim-turbux'
Bundle 'Valloric/YouCompleteMe'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim.git'
Bundle 'altercation/vim-colors-solarized.git'

" Experimental plugins
Bundle 'christoomey/vim-tmux-navigator'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'bling/vim-airline'
Bundle 'kien/rainbow_parentheses.vim'

filetype plugin indent on

syntax on
set background=dark
colorscheme solarized

" map escape to kj
inoremap kj <Esc>

" Write file
imap <F2> <Esc><F2>
nmap <F2> :w<CR>
nmap <F9> :source .vimrc<CR>

map <leader>nt :NERDTree<CR>
map <leader>gu :GundoToggle<CR>
map <leader>cp :CtrlP<CR>
map <leader><Space> :noh<CR>

" other setings
set encoding=utf-8
set fileencodings=utf-8,cp1251
set tags=./tags,tags
set history=1000
set cursorline
set cursorcolumn
hi CursorLine cterm=bold
hi SpellBad cterm=underline ctermbg=Black ctermfg=Magenta gui=underline guibg=Black guifg=Magenta
set timeoutlen=300

if v:version >= 703
  set colorcolumn=80
endif

set dir=/tmp/
set pastetoggle=<F3>

" Add bulgarian as an input language, allowing keyboard bindings to work
set keymap=bulgarian-bds
set iminsert=0
set imsearch=-1

autocmd BufWritePre *.{tex,rb,py,c,cpp,h,hpp,clj} :%s/\s\+$//e

let g:VimuxUseNearestPane = 1

" Enable this option if you want the cursor to jump to the first detected
" error
let g:syntastic_auto_jump=1

" Automatically close the Gundo windows when reverting
let g:gundo_close_on_revert=1

" YouCompleteMe
let g:ycm_confirm_extra_conf = 1
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
let g:ycm_seed_identifiers_with_syntax = 1

" ultishnips
let g:UltiSnipsExpandTrigger="<leader>e"
let g:UltiSnipsJumpForwardTrigger="<leader>e"
let g:UltiSnipsJumpBackwardTrigger="<leader>E"
let g:UltiSnipsSnippetDirectories=["my-snippets", "UltiSnips"]

set guioptions-=m
set guioptions-=T

" vim-airline
let g:airline_theme             = 'wombat'
let g:airline#extensions#syntastic#enabled = 1
set laststatus=2

" rainbow parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" end of file
