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

" map escape to kj
inoremap kj <Esc>

" Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin on
syntax on
colorscheme evening

" Command complete with tab
set wildmode=longest:full
set wildmenu

" Write file
imap <F2> <Esc><F2>
nmap <F2> :w<CR>

" other setings
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp1251
set tags=./tags,tags

function ToggleComment(str1, str2, comment)
    if strlen(a:str1) > 0
        return a:str1
    else
        return a:comment . a:str2
    endif
endfunction

" end of file
