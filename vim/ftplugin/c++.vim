" C++

nmap <F5> <Esc>:!g++ -o %:r % -ggdb && ./%:r<CR>
imap <F5> :!g++ -o %:r % -ggdb && ./%:r<CR>

nmap <C-_> <Esc>:.s#\(\(\s*\)\@=//\(.*\)\)\\|\(\(\s*//\)\@!\(.*\)\)#\=ToggleComment(submatch(3), submatch(6), '//')#<CR>
imap <C-_> :.s#\(\(\s*\)\@=//\(.*\)\)\\|\(\(\s*//\)\@!\(.*\)\)#\=ToggleComment(submatch(3), submatch(6), '//')#<CR>

let c_comment_strings=1
