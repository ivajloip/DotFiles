iab ... \dots
iab => \Rightarrow
iab -> \rightarrow
iab <- \leftarrow
iab <-> \leftrightarrow
iab <=> \iff
iab != \ne
iab >= \ge
iab <= \le
iab == \equiv
iab sigma \sigma
iab tau \tau
iab FI \varphi
iab Theta \Theta
iab delta \delta

set makeprg=pdflatex\ %\ &&\ evince\ %:r.pdf

nmap <F5> :silent call CompileAndDisplay()<CR>

set spell spelllang=en_us
set textwidth=80

function! CompileAndDisplay()
  call VimuxRunCommand('cd $PWD; pdflatex ' . expand("%") . ' &&
        \ evince ' . expand("%:r") . '.pdf > /dev/null & ')
endfunction
