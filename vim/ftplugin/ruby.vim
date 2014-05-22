" Ruby

set tabstop=2
nmap <F5> :call VimuxRunCommand('cd $PWD; bundle exec rspec ' . expand("%"))<CR>
imap <F5> <Esc> <F5>

let g:turbux_command_rspec="bin/rspec"
