" Use 2 spaces for indentation
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" When inserting a closing parenthesis, make it *very* visible where the
" matching opening parenthesis is placed.
set showmatch

" By default, 'if' is marked as a lispword. Therefore, if an if-expression
" spans multiple lines, an additional indentation of 2 is used (in the same
" way as, for example, for 'define' and 'let'). This doesn’t aggree with the
" usual rule of aligning all parts of the if-expression.
setlocal lispwords-=if

" Set the formatting tool to scmindent (https://github.com/ds26gte/scmindent).
" This does not affect the auto-formatting, but is instead used for =.
setlocal equalprg=scmindent.lua

