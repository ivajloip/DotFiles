" Ruby

set tabstop=2
nmap <F5> :!ruby %<CR>
imap <F5> <Esc> <F5>

nmap <C-_> :.s/\(\(\s*\)\@=#\(.*\)\)\\|\(\(\s*#\)\@!\(.*\)\)/\=ToggleComment(submatch(3), submatch(6), '#')/<CR>
imap <C-_> <Esc> <C-_>
