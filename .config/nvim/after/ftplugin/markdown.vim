" Indent with 2 spaces in markdown files.
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

" Softwrapped lines should be properly indented in lists…
setlocal breakindentopt+=list:-1
" … and for these purposes, we treat '>' as a list indicator.
" The following regular expression was created as follows:
" - Take the default (accessed via ':set formatlistpat?'):
"     ^\s*\d\+\.\s\+\|^\s*[-*+]\s\+\|^\[^\ze[^\]]\+\]:\&^.\{4\}
" - Add '>' to the list of symbols '-', '*', '+':
"     ^\s*\d\+\.\s\+\|^\s*[-*+>]\s\+\|^\[^\ze[^\]]\+\]:\&^.\{4\}
" - Also modify the third option to better catch stuff like '[1]: …':
"     ^\s*\d\+\.\s\+\|^\s*[-*+>]\s\+\|^\s*\[.\{-}\]:\s*
" - Allow multiple lists to start on the same line, so that lists in quotes
"   are properly indented:
"     ^\s*\(\d\+\.\s\+\|[-*+>]\s\+\|\[.\{-}\]:\s*\)
"   Note that the leading '^' needs to be outside the group (this took me some
"   time to notice).
" - Allow for list items to be labeled by words:
"     ^\s*\([a-z0-9]\+\.\s\+\|[-*+>]\s\+\|\[.\{-}\]:\s*\)
"   (The class \d needs to be spelled out as 0-9, but I don’t know why.)
" - Escape backslashes with some trial and error:
setlocal formatlistpat=^\\s*\\([a-z0-9]\\+\\.\\s\\+\\\\|[-*+>]\\s\\+\\\\|\\[.\\{-}\\]:\\s*\\)\\+
