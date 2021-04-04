""""" GENERAL LAYOUT AND BEHAVIOR

" enter the current millenium
set nocompatible

" search down into subdirectories
set path+=**

" indentation of length two with tabs
:set noexpandtab
:set softtabstop=0
:set shiftwidth=2
:set tabstop=2
:set cindent
:set cinoptions=(0,u0,U0

" :set tabstop=2
" :set softtabstop=0
" :set expandtab
" :set shiftwidth=2
" :set smarttab
" :set autoindent
" :set breakindent

" show tabs
:set list
:set listchars=tab:__,trail:S,nbsp:~

" show relative line numbers
:set number

" show 15 more lines
:set scrolloff=15

" no concealment
" I don’t use it and it fucks up highlighting
let g:tex_conceal = ""

" switch between document tabs without saving
:set hidden

" always show document tabs
:set showtabline=2


""""" KEY BINDINGS

" keys for entering and existing normal mode and insertion mode
":nnoremap h i
":nnoremap <C-h> i
":inoremap <C-h> <Esc>
":nnoremap i <Nop>
":nnoremap a <Nop>


" enable the usual sofwraps and navigation inside them
:set wrap
:set linebreak
":set nolist
:nnoremap <Up> gk
:inoremap <Up> <C-o>gk
:nnoremap <Down> gj
:inoremap <Down> <C-o>gj

" quickref
:noremap <C-l> <C-]>

" switching between document tabs
:noremap <C-Right> gt
:noremap <C-Left> gT

" switching hlsearch on/off
:nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"



""""" PLUGINS

call plug#begin('~/.config/nvim/plugged')

" Smart tabs: Indent with tabs, align with spaces
" Plug 'dpc/vim-smarttabs'
" vimtex
Plug 'lervag/vimtex'
" snippets
Plug 'SirVer/ultisnips'
" Smart tabs: Indent with tabs, align with spaces
" CURRENTLY BROKEN Plug 'dpc/vim-smarttabs'
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()




""""" SNIPPET CONFIGURATION
let g:UltiSnipsExpandTrigger='<f2>'
let g:UltiSnipsJumpForwardTrigger='<f2>'
let g:UltiSnipsJumpBackwardTrigger='<f3>'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'my_snippets']





""""" VIMTEX
let g:tex_flavor = 'latex'

let g:vimtex_compiler_latexmk = {'continuous' : 0}
:nmap <M-2> :wall<Return>:VimtexCompile<Return>
:nmap <M-3> :VimtexView<Return>

let g:vimtex_delim_toggle_mod_list = [
	\ ['\bigl', '\bigr'],
	\ ['\Bigl', '\Bigr'],
	\ ['\biggl', '\biggr'],
	\ ['\Biggl', '\Biggr'],
	\ ['\left', '\right'],
	\]

" forward and backward search with okular
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'





""""" COLOUR SETTINGS

" standard colour theme
:colors default

" highlight of line numbers
:highlight LineNr ctermfg=red
:set cursorline
:highlight clear CursorLine
:highlight CursorLineNr ctermfg=green
