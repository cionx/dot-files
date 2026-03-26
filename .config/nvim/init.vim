""""" GENERAL SETTINGS AND BEHAVIOUR

" Should be this way by default, but just to make sure.
set nocompatible

" Search down into subdirectories.
set path+=**

" Indentation with tabs, which are displayed with length 4.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Display certain kinds of whitespace differently:
" Tabs are displayed as ··
" Trailing spaces are displayed as S
" Nonbreakable spaces are displayed as ~
set list
set listchars=tab:··,trail:S,nbsp:~

" Hightlight (while typing) a search
set hlsearch
set incsearch

" Show relative line numbers, but absolute current line number.
" Useful for moving to a specific line on screen.
set number relativenumber
" Also highlight the current line.
set cursorline

" Show at least 15 lines beneath/above the cursor, if possible.
set scrolloff=15

" Always show document tabs
set showtabline=2

" Switch between document tabs without saving.
set hidden

" Enable softwraps to display long lines at screen.
" Line breaks are done only at whitespace (if possible).
set wrap
set linebreak
set breakindent

" Configuration of the completion menu.
set completeopt=menu,menuone,noselect

" I don’t like conceal.
let g:tex_conceal = ""

" Allows % do jump between more kind of paired delimiters than just the
" default (), [] and {}.
" This doesn’t automatically work with VimTex. The VimTex configuration later
" on in the file refines these pairs again.
set matchpairs+=⟨:⟩,⟦:⟧,⌈:⌉,⌊:⌋,“:”





""""" KEY BINDINGS

" Control + c works like Escape, but it sometimes slightly different.
" We make sure that they always behave the same.
cnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>
onoremap <C-c> <Esc>
snoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
xnoremap <C-c> <Esc>
noremap! <C-c> <Esc>

" Make semicolon the leader.
let mapleader = ";"

" Stop accidently recording.
nnoremap q <Nop>
" Stop accidental opening of the command history
nnoremap q: <Nop>

" Deleting doesn’t overwritte the buffer.
nnoremap d "_d
vnoremap d "_d

" Pasting doesn’t overwrite the register.
xnoremap p pgvy

" Use Y to copy the current selection into the clipboard.
nnoremap Y "+y
vnoremap Y "+y

" Switching between document tabs.
" alt + arrow keys
noremap <A-Right> gt
noremap <A-Left> gT
" g + arrow keys
noremap g<Right> gt
noremap g<Left> gT
" alt + right-hand WASD
noremap <A-n> gt
noremap <A-t> gT

" Quickfix
nnoremap <silent><C-n> :cnext<CR>
nnoremap <silent><C-p> :cprevious<CR>

" Opening the file under the cursor in a new tab. If this file does not yet
" exist, create it.
nnoremap to :tabedit <cfile> <CR>

" Closing buffer with alt + d
noremap <A-d> :bdelete<CR>

" Switching search highlight on/off via 'hl'.
nnoremap <silent>h <Nop>
nnoremap <silent><expr> hl (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
nnoremap <silent> <C-l> :nohlsearch<CR>

" LANGUAGE SERVER COMMANDS
nnoremap l <Nop>




""""" LOAD PLUGINS

call plug#begin('~/.config/nvim/plugged')

" A collection of often used lua functions.
" Required by various plugins.
Plug 'nvim-lua/plenary.nvim'

" Neovim’s language server configurations.
Plug 'neovim/nvim-lspconfig'

" Little progress indicator for language servers running in the background.
" Displayed in the bottom right.
Plug 'j-hui/fidget.nvim'

" Neovim’s treesitter configurations.
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main' }

" Smart tabs: tabs for indentation and spaces for alignment.
" Doesn’t work as well as I’d like, but better than nothing.
Plug 'Thyrum/vim-stabs'

" Telescope for finding stuff.
" Still requires actual “finders” to do (most of) the actual finding:
"   - fzf-native
"   - file-browser
" Uses fd and ripgrep for searching (optional, both an Arch’s community repo).
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' }
Plug 'nvim-telescope/telescope-file-browser.nvim'

" Quickly getting to a specific position.
Plug 'easymotion/vim-easymotion'

" Text completion, requires sources for suggested completions.
Plug 'hrsh7th/cmp-nvim-lsp'                 " Completion source: language servers.
Plug 'hrsh7th/cmp-buffer'                   " Completion source: text in the buffers.
Plug 'hrsh7th/cmp-path'                     " Completion source: filesystem paths
Plug 'hrsh7th/cmp-cmdline'                  " Completion source: vim’s cmdline
Plug 'hrsh7th/cmp-omni'                     " Completion source: vim’s omnifunc
Plug 'hrsh7th/nvim-cmp'

" Snippets; should be replaced by something else (LuaSnip?) at some point.
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'  " Completion source: Ultisnip

" VimTex for all kinds of LaTeX stuff.
Plug 'lervag/vimtex'

" Lean support.
Plug 'Julian/lean.nvim'

" Previewing Markdown files in a browser.
" Installs a pre-built version so that nodejs and yarn are not needed.
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

" Colour themes.
Plug 'AlexvZyl/nordic.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'Mofiqul/dracula.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'zootedb0t/citruszest.nvim'
Plug 'ribru17/bamboo.nvim'

call plug#end()





""""" LUA SETTINGS

lua << EOF

-----[[ TELESCOPE CONFIGURATION --]]

require('telescope').setup {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--vimgrep",
			"--smart-case",
			"--multiline",
		}
	},
	extensions = {
		file_browser = {
			mappings = {
				["i"] = {
					["<C-t>"] = require("telescope.actions").select_tab
				}
			}
		}
	}
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

local builtin = require('telescope.builtin')

----- Language servers errors/warnings/…
vim.keymap.set('n', '<leader>le', builtin.diagnostics, {})
----- Files.
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fr', builtin.registers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
----- Vim’s internal lists.
vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>cm', builtin.commands, {})
vim.keymap.set('n', '<leader>km', builtin.keymaps, {})
----- Git.
vim.keymap.set('n', '<leader>gh', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
----- Search history.
vim.keymap.set('n', '<leader>h',  builtin.search_history, {})
----- File browser.
vim.api.nvim_set_keymap('n', '<leader>t', ':Telescope file_browser<CR>', { noremap = true })
----- Repeat the last search
vim.api.nvim_set_keymap('n', '<leader>f<space>', ':Telescope resume<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':Telescope resume<CR>', { noremap = true })
----- The general telescope menu
vim.api.nvim_set_keymap('n', '<space>', ':Telescope<CR>', { noremap = true })

-- Others:
-- <C-space> further refine search results (Default)
-- <C-t>     open result in new tab (Configured above)




-----[[ LANGUAGE SERVERS (sorted alphabetically) --]]

local lspconfig = vim.lsp


----- BASH

lspconfig.enable('bashls')

----- C

-- lspconfig.enable('cssls')
-- vim.lsp.config('cssls', {
--   capabilities = capabilities,
-- })
lspconfig.enable('clangd')

----- HTML

lspconfig.enable('html')
lspconfig.config('html', {
	cmd = { 'vscode-html-languageserver', '--stdio' },
	capabilities = capabilities,
})

----- Hyperlang

lspconfig.enable('hyprls')

----- LTeX Plus

lspconfig.enable('ltex_plus')

-- I would like to use XDG_CONFIG_HOME instead of HOME + '/.config',
-- but I don’t know how to get the value of XDG_CONFIG_HOME
-- (or its default value, if it isn’t set).
local XDG_CONFIG_HOME = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. '/.config'
local ltex_config_dir = XDG_CONFIG_HOME .. '/ltex'

local readfile = vim.fn.readfile
local wordfile = {}
wordfile['en-GB'] = 'words-en.txt'
wordfile['de-DE'] = 'words-de.txt'
local drulesfile = {}
drulesfile['en-GB'] = 'disabled-rules-en.txt'
drulesfile['de-DE'] = 'disabled-rules-de.txt'
local fposfile = {}
fposfile['en-GB'] = 'en-false-positives.json'
local envfile = 'environments.json'
local cmdfile = 'commands.json'

-- readfile() used to work out of the box, but at some point it stopped working,
-- so now we have to reimplement things by hand.
local function readstring(filename)
  local file = io.open(filename, 'r')
  if file == null then error(filename) end
  local str = file:read('*a')
  file:close()
  return str
end

local function readlines(filename)
  return vim.split(readstring(filename), '\n')
end

local function readjson(filename)
  return vim.json.decode(readstring(filename))
end

lspconfig.config('ltex_plus', {
	settings = {
		ltex = {
			latex = {
				commands     = readjson( ltex_config_dir .. '/' .. cmdfile ),
				environments = readjson( ltex_config_dir .. '/' .. envfile ),
			},
			additionalRules = {
				enablePickyRules = true,
			},
			checkFrequency = 'save',
			dictionary = {
				['en-GB'] = readfile( ltex_config_dir .. '/' .. wordfile['en-GB'] ),
				['de-DE'] = readfile( ltex_config_dir .. '/' .. wordfile['de-DE'] ),
			},
			disabledRules = {
				['en-GB'] = readfile( ltex_config_dir .. '/' .. drulesfile['en-GB'] ),
				['de-DE'] = readfile( ltex_config_dir .. '/' .. drulesfile['de-DE'] ),
			},
			hiddenFalsePositives = {
				['en-GB'] = readjson( ltex_config_dir .. '/' .. fposfile['en-GB'] )
			},
			language = 'en-GB',
		}
	}
})

----- Lua

lspconfig.enable('lua_ls')

----- Markdown

lspconfig.enable('marksman')

----- Nushell

lspconfig.enable('nushell')

----- OCaml

lspconfig.enable('ocamllsp')

----- Python

lspconfig.enable('pylsp')
lspconfig.enable('pyright')

----- Rust

lspconfig.enable('rust_analyzer')

----- Termux (PKGBUILD, etc.)

lspconfig.enable('termux_language_server')

----- TexLab

lspconfig.enable('texlab')

lspconfig.config('texlab', {
	filetypes = { "tex", "plaintex", "sty", "cls", "bib" },
	settings = {
			texlab = {
					build = {
							isContinuous = true,
					},
					chktex = {
							onEdit = false,
							onOpenAndSave = false,
					},
					formatterLineLength = 100,
					forwardSearch = {
							executable = "okular",
							args = { "--unique", "%p#src:%l%f" }
					}
			}
	}
})

----- Typescript

lspconfig.enable('denols')
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

----- VimScript

lspconfig.enable('vimls')

----- keybindings
-- Copied from https://github.com/neovim/nvim-lspconfig/blob/427378a03ffc1e1bc023275583a49b1993e524d0/README.md with adjusted links

-- Global mappings
vim.keymap.set('n', 'le', vim.diagnostic.open_float)
vim.keymap.set('n', 'lN', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'ln', vim.diagnostic.goto_next)
vim.keymap.set('n', 'lq', vim.diagnostic.setloclist)
-- Local commands
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'lD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'lh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'ls', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'lt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'lm', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, 'la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'lr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'lf', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})




-----[[ FIDGET --]]

require('fidget').setup{}




-----[[ TREE-SITTER --]]

local tree_languages = {
  'bash', 'bibtex',
  'c', 'cmake', 'comment', 'commonlisp', 'cpp', 'css',
  'desktop', 'diff', 'dockerfile',
  'ebnf',
  'fish', 'fsharp',
  'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'gpg',
  'haskell', 'html', 'hyprlang',
  'ini',
  'java', 'javadoc', 'javascript', 'json', 'julia',
  'latex', 'llvm', 'lua', 'luadoc',
  'make', 'markdown', 'markdown_inline', 'menhir', 'mermaid', 'meson',
  'nu',
  'ocaml', 'ocaml_interface', 'ocamllex',
  'perl', 'php', 'printf', 'pymanifest', 'python',
  'query',
  'racket', 'regex', 'requirements', 'rst', 'ruby', 'rust',
  'scheme', 'scss', 'sql', 'ssh_config',
  'tmux', 'todotxt', 'toml', 'typescript', 'typst',
  'udev',
  'vim', 'vimdoc',
  'xml',
  'yaml',
  'zig'
}

require('nvim-treesitter').install(tree_languages)



-----[[ COMPLETION (nvim-cmp) --]]

local kind_icons = {
	Class         = "󰠱",
	Color         = "󰏘",
	Constant      = "󰏿",
	Constructor   = "",
	Enum          = "",
	EnumMember    = "",
	Event         = "",
	Field         = "󰜢",
	File          = "󰈙",
	Folder        = "󰉋",
	Function      = "󰊕",
	Interface     = "",
	Keyword       = "󰌋",
	Method        = ".",
	Module        = "",
	Operator      = "󰆕",
	Property      = "󰜢",
	Reference     = "",
	Snippet       = "",
	Struct        = "",
	Text          = "󰉿",
	TypeParameter = "α",
	Unit          = "",
	Value         = "󰎠",
	Variable      = "𝑥",
}

local cmp = require('cmp')


local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
	completion = {
		keyword_length = 2
	},
	-- Copied from https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
			-- Source
			vim_item.menu = ({
				buffer        = "[Buffer]",
				nvim_lsp      = "[LSP]",
				luasnip       = "[LuaSnip]",
				nvim_lua      = "[Lua]",
				latex_symbols = "[LaTeX]",
			})[entry.source.name]
			return vim_item
		end
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	        ['<C-n>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-p>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
		["<Up>"] = cmp.mapping({
			i =
			function()
				cmp.abort()
				vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
			end,
			c =
			function()
				cmp.close()
				vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
			end,
		}),
		["<Down>"] = cmp.mapping({
			i =
			function()
				cmp.abort()
				vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
			end,
			c =
			function()
				cmp.close()
				vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
			end,
		}),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
		{ name = 'omni' },
		{ name = 'buffer'},
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})



-----[[ LEAN.nvim --]]

require('lean').setup {
	infoview = {
		autoopen = false
	},
	stderr = {
		enable = false
	}
}


EOF





""""" EASYMOVE CONFIGURATION

" Disable the default mappings.
let g:EasyMotion_do_mapping = 0
" Search case-insensitive for lowercase search targets.
let g:EasyMotion_smartcase = 1
" Allow target keys.
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz,.'

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `\{char}{label}`
nnoremap , <Plug>(easymotion-overwin-f)
vnoremap , <Plug>(easymotion-overwin-f)





""""" ULTISNIP CONFIGURATION

let g:UltiSnipsExpandTrigger = '<F2>'
let g:UltiSnipsJumpForwardTrigger = '<C-n>'
let g:UltiSnipsJumpBackwardTrigger = '<C-p>'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'my_snippets']





""""" VIMTEX CONFIGURATION

let g:tex_flavor = 'latex'

" Disable highlighting of Unicode mathematics as TeX commands, see https://github.com/lervag/vimtex/issues/2732#issuecomment-1677584255
let g:vimtex_syntax_match_unicode = v:false

" When inside some delimiters (e.g., parentheses) use tsd (toggle surrounding
" delimiters) to toggle through these (+ no delimiters).
let g:vimtex_delim_toggle_mod_list = [
    \ ['\bigl',  '\bigr'],
    \ ['\Bigl',  '\Bigr'],
    \ ['\biggl', '\biggr'],
    \ ['\Biggl', '\Biggr'],
    \ ['\left',  '\right'],
    \]

" Paired delimiters that we can jump between using %.
let g:vimtex_delim_list = {
    \ 'delim_math' : {
    \   'name' : [
    \     ['(', ')'],
    \     ['[', ']'],
    \     ['\{', '\}'],
    \     ['⟨', '⟩'],
    \     ['⟦', '⟧'],
    \     ['⌈', '⌉'],
    \     ['⌊', '⌋'],
    \     ['\begingroup', '\endgroup'],
    \     ['\lparen', '\rparen'],
    \     ['\lbrack', '\rbrack'],
    \     ['\lbrace', '\rbrace'],
    \     ['\langle', '\rangle'],
    \     ['\lBrack', '\rBrack'],
    \     ['\lceil', '\rceil'],
    \     ['\lfloor', '\rfloor'],
    \     ['\ulcorner', '\urcorner'],
    \     ['\lvert', '\rvert'],
    \     ['\lVert', '\rVert'],
    \   ]
    \ },
    \}


" Disable automatic compilation for every little change.
let g:vimtex_compiler_latexmk = {'continuous' : 0}
" Alt+2 for compilation; uses 'latexmk' per default
nmap <M-2> :wall<Return>:VimtexCompile<Return>
" Alt+3 for opening the PDF viewer at the current position
nmap <M-3> :VimtexView<Return>

" Forward and backward search with okular, as explained in
" :help vimtex-view-okular
" :help vimtex-synctex-inverse-search
let g:vimtex_compiler_progname    = 'nvr'
let g:vimtex_view_method          = 'general'
let g:vimtex_view_general_viewer  = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" In Okular, under
"   Settings > Configure Okular > Editor
" choose 'Custom Text Editor' and enter the following command:
"   nvim --headless -c "VimtexInverseSearch %l '%f'"





""""" MARKDOWN PREVIEW CONFIG

" Taken from: https://github.com/iamcco/markdown-preview.nvim/blob/02cc3874738bc0f86e4b91f09b8a0ac88aef8e96/README.md

" Leave the preview open, even if the file has been closed in the editor.
" Not what I want, but the auto-close function leads to error warnings that
" are more annoying than closing the preview by hand.
let g:mkdp_auto_close = 0
" Disable sync scroll (default is 0); all other options are the untouched
" default values.
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 1,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }
" To change the font for monospace fonts, a custom CSS file must be specified.
" This file is just a copy of
" https://github.com/iamcco/markdown-preview.nvim/blob/02cc3874738bc0f86e4b91f09b8a0ac88aef8e96/app/_static/markdown.css
" with ".markdown-body code > font-family" adjusted.
let g:mkdp_markdown_css = expand('~/.config/nvim/others/markdown-preview/markdown.css')





"""""  COLOURSCHEME SETTINGS

colorscheme retrobox
