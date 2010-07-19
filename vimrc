" this file is created by nemo

set nocompatible

set incsearch
set ignorecase
set autoindent
set tabstop=4
set sw=4
set expandtab
set shiftround
set showmatch
set cindent
set nu!
syntax on
colorscheme evening

" Select all.
"map! <c-a> ggVG

map! <C-s> <Esc>:w<CR>
map <C-s> :w<CR>

vmap <C-c> "+yy
nmap <C-c> "+yy
nmap <C-v> "+p

"map <C-v> <Esc>:p<CR>
"map! <C-v> <Esc>:p<CR>

map! <C-space> <C-p>
map! <F9> :!python3.0 %<CR>

" Java specific stuff
let java_highlight_all=1
let java_highlight_debug=1

let java_ignore_javadoc=1
let java_highlight_functions=1
let java_mark_braces_in_parens_as_errors=1

" highlight strings inside C comments
let c_comment_strings=1

" end of file

