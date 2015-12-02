set makeprg=pdflatex\ %\ &&\ evince\ %:r.pdf

nmap <leader>t :w<CR>:silent call CompileAndDisplay()<CR>

set spell spelllang=en_us,fr,bg
set textwidth=80

function! CompileAndDisplay()
  call VimuxRunCommand('cd $PWD; pdflatex ' . expand("%") . ' &&
        \ evince ' . expand("%:r") . '.pdf > /dev/null & ')
endfunction

SyntasticToggleMod
