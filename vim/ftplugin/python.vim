" Python

"nmap <F5> <Esc>:!python3 %<CR>
nmap <F5> :call VimuxRunCommand('python3 ' . expand("%"))<CR>
imap <F5> <Esc><F5>

nmap <C-_> <Esc>:.s/\(\(\s*\)\@=#\(.*\)\)\\|\(\(\s*#\)\@!\(.*\)\)/\=ToggleComment(submatch(3), submatch(6), '#')/<CR>
imap <C-_> :.s/\(\(\s*\)\@=#\(.*\)\)\\|\(\(\s*#\)\@!\(.*\)\)/\=ToggleComment(submatch(3), submatch(6), '#')/<CR>
