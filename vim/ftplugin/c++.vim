" C++

let g:syntastic_c_checker='splint'

nmap <F5> <Esc>:!g++ -o %:r % -ggdb && ./%:r<CR>
imap <F5> :!g++ -o %:r % -ggdb && ./%:r<CR>

let c_comment_strings=1
