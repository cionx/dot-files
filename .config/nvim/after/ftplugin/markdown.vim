" Indent with 2 spaces in markdown files.
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=2

" Softwrapped lines should be properly indented in lists…
setlocal breakindentopt+=list:-1
" … and for these purposes, we treat '>' as a list indicator.
" The following regular expression was created as follows:
" - Take the default (accessed via ':set formatlistpat?'):
"     ^\s*\d\+\.\s\+\|^\s*[-*+]\s\+\|^\[^\ze[^\]]\+\]:\&^.\{4\}
" - add '>' to the list of symbols '-', '*', '+'
"     ^\s*\d\+\.\s\+\|^\s*[-*+>]\s\+\|^\[^\ze[^\]]\+\]:\&^.\{4\}
" - Also modify the third option to better catch stuff like '[1]: …':
"     ^\s*\d\+\.\s\+\|^\s*[-*+>]\s\+\|^\s*\[.\{-}\]:\s*
" - Allow multiple lists to start on the same line, so that lists in quotes
"   are properly indented:
"     ^\s*\(\d\+\.\s\+\|[-*+>]\s\+\|\[.\{-}\]:\s*\)
"   Note that the leading '^' needs to be outside the group (this took me some
"   time to notice).
" - Escape backslashes with some trial and error:
setlocal formatlistpat=^\\s*\\(\\d\\+\\.\\s\\+\\\\|[-*+>]\\s\\+\\\\|\\[.\\{-}\\]:\\s*\\)\\+
