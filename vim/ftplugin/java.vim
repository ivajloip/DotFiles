" Java

set tabstop=4

let java_highlight_all=1
let java_highlight_debug=1

let java_ignore_javadoc=1
let java_highlight_functions=1
let java_mark_braces_in_parens_as_errors=1

nmap <F5> :!javac -cp . % && java -cp . %:r<CR>
imap <F5> <Esc><F5>
