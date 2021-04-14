""""" GENERAL LAYOUT AND BEHAVIOR

" colour theme
colorscheme gruvbox

" enter the current millenium
set nocompatible

" search down into subdirectories
set path+=**

" indentation of length two with tabs
:set tabstop=2
:set softtabstop=0
:set shiftwidth=2
:set noexpandtab

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

" change leader
let mapleader = " "

" deleting doesn’t overwritte the buffer
nnoremap d "_d
vnoremap d "_d

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




""""" POPUP MENU
" Maximum number of items to show in popup menu
" Pesudo blend effect for popup menu
" set pumblend=1
" Don’t blend current entry
" hi PmenuSel blend=0



""""" LOAD PLUGINS

call plug#begin('~/.config/nvim/plugged')

" vimtex
Plug 'lervag/vimtex'
" snippets
Plug 'SirVer/ultisnips'
" Neovim language server configurations
Plug 'neovim/nvim-lspconfig'
" CHADtree
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
" Smart tabs: Indent with tabs, align with spaces
Plug 'dpc/vim-smarttabs'
" Completion
Plug 'nvim-lua/completion-nvim'
" Buffer Completion
Plug 'steelsojka/completion-buffers'
" gruvbox theme
Plug 'morhetz/gruvbox'

call plug#end()




""""" COMPLETION

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Down> and <Up> to navigate through popup menu
inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_trigger_keyword_length=3
let g:completion_enable_server_trigger = 0
let g:completion_word_min_length=5
let g:completion_word_min_length=5

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'UltiSnips'

" matching stategy
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" completion sources, adding buffers
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet', 'buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]





""""" SNIPPET CONFIGURATION

let g:UltiSnipsExpandTrigger='<F3>'
let g:UltiSnipsJumpForwardTrigger='<F4>'
let g:UltiSnipsJumpBackwardTrigger='<s-F4>'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'my_snippets']




""""" ChadTree
:nnoremap <silent> <Leader>c :CHADopen<CR>




""""" LUA SETTINGS

lua << EOF

local lsconfig = require('lspconfig')

lsconfig.pyright.setup{}

lsconfig.texlab.setup{
	filetypes = { "tex", "plaintex", "sty", "cls", "bib" },
	settings = {
		latex = {
			build = {
				args = {"-interaction=nonstopmode", "-synctex=1", "%f"},
			},
			forwardSearch = {
				executable = "okular",
				args = {"--unique", "%p#src:%l%f"}
			},
			lint = {
				onSave = true
			}
		}
	}
}

EOF




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

" " forward and backward search with okular
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'




""""" COLOUR SETTINGS

" highlight of line numbers
" :highlight LineNr ctermfg=red
" :set cursorline
" :highlight clear CursorLine
" :highlight CursorLineNr ctermfg=green
