" Python

nmap <F5> <Esc>:!python3 %<CR>
imap <F5> :!python3 %<CR>

nmap <C-_> <Esc>:.s/\(\(\s*\)\@=#\(.*\)\)\\|\(\(\s*#\)\@!\(.*\)\)/\=ToggleComment(submatch(3), submatch(6), '#')/<CR>
imap <C-_> :.s/\(\(\s*\)\@=#\(.*\)\)\\|\(\(\s*#\)\@!\(.*\)\)/\=ToggleComment(submatch(3), submatch(6), '#')/<CR>
