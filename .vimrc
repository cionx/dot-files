""""" GENERAL LAYOUT AND BEHAVIOR

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

" show relative line numbers,
" but absolute current line number
:set number relativenumber

" show 15 more lines
:set scrolloff=15

" switch between document tabs without saving
:set hidden

" always show document tabs
:set showtabline=2

" enable the usual sofwraps and navigation inside them
:set wrap
:set linebreak
":set nolist

" configuration of the completion menu
set completeopt=menu,menuone,noselect

" I don’t like it.
let g:tex_conceal = ""


""""" KEY BINDINGS

" change leader
let mapleader = ","

" deleting doesn’t overwritte the buffer
nnoremap d "_d
vnoremap d "_d

:nnoremap <Up> gk
:inoremap <Up> <C-o>gk
:nnoremap <Down> gj
:inoremap <Down> <C-o>gj

" switching between document tabs
:noremap <C-Right> gt
:noremap <C-Left> gT

" switching hlsearch on/off
:nnoremap h <Nop>
:nnoremap <silent><expr> hl (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" adjust a i e for KOY keyboard layout
nnoremap i a
:nnoremap a i
:vnoremap i a
:vnoremap a i

" language server
:nnoremap l <Nop>
:nnoremap le <cmd>lua vim.diagnostic.open_float()<CR>
:nnoremap lN <cmd>lua vim.diagnostic.goto_prev()<CR>
:nnoremap ln <cmd>lua vim.diagnostic.goto_next()<CR>
:nnoremap la <cmd>lua vim.lsp.buf.code_action()<CR>
:nnoremap lD <cmd>lua vim.lsp.buf.declaration()<CR>
:nnoremap ld <cmd>lua vim.lsp.buf.definition()<CR>
:nnoremap lf <cmd>lua vim.lsp.buf.formatting()<CR>
:nnoremap lh <cmd>lua vim.lsp.buf.hover()<CR>
:nnoremap li <cmd>lua vim.lsp.buf.implementation()<CR>
:nnoremap lm <cmd>lua vim.lsp.buf.rename()<CR>
:nnoremap lr <cmd>lua vim.lsp.buf.references()<CR>
:nnoremap ls <cmd>lua vim.lsp.buf.signature_help()<CR>
:nnoremap lt <cmd>lua vim.lsp.buf.type_definition()<CR>



""""" LOAD PLUGINS

call plug#begin('~/.config/nvim/plugged')

" Neovim language server configurations
Plug 'neovim/nvim-lspconfig'

" Neovim tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" snippets
Plug 'SirVer/ultisnips'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-omni'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" For ultisnips users
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" For pictograms
Plug 'onsails/lspkind-nvim'
"
" vimtex
Plug 'lervag/vimtex'

" lean support
Plug 'Julian/lean.nvim'
Plug 'nvim-lua/plenary.nvim'

" smart tabs
Plug 'dpc/vim-smarttabs'

" kanagawa theme
Plug 'rebelot/kanagawa.nvim'

call plug#end()



""""" LUA SETTINGS

lua << EOF

--[[ Language Servers --]]

local lsconfig = require('lspconfig')

-- rust

lsconfig.rust_analyzer.setup{}

-- python

lsconfig.pylsp.setup{}

-- html

lsconfig.html.setup {
	cmd = { 'vscode-html-languageserver', '--stdio' },
	capabilities = capabilities,
}

-- ltex
require'lspconfig'.ltex.setup{}
local readfile = vim.fn.readfile

local wordfile = {}
wordfile['en-GB']  = 'words-en.txt'

local drulesfile = {}
drulesfile['en-GB'] = 'disabled-rules-en.txt'

local fposfile = {}
fposfile['en-GB'] = 'en-false-positives.json'

local cmdfile = 'commands.json'

lsconfig.ltex.setup{
	settings = {
		ltex = {
			latex = {
				commands = vim.json.decode( table.concat( readfile( vim.env.HOME .. '/.ltex/' .. cmdfile ), '\n' ) ),
			},
			additionalRules = {
				enablePickyRules = true,
			},
			checkFrequency = 'save',
			dictionary = {
				['en-GB'] = readfile( vim.env.HOME .. '/.ltex/' .. wordfile['en-GB'] ),
			},
			disabledRules = {
				['en-GB'] = readfile( vim.env.HOME .. '/.ltex/' .. drulesfile['en-GB'] ),
			},
			hiddenFalsePositives = {
				['en-GB'] = vim.json.decode( table.concat( readfile( vim.env.HOME .. '/.ltex/' .. fposfile['en-GB'] ), '\n' ) )
			},
			language = 'en-GB',
		}
	}
}

-- texlab

lsconfig.texlab.setup{
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
}

-- typescript

lsconfig.tsserver.setup{}



--[[ Tree-sitter --]]

require('nvim-treesitter.configs').setup {
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = {"latex"},

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- List of parsers to ignore installing
	ignore_install = { },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = { "latex" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}

--[[ Completion (nvim-cmp) --]]

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require('cmp')

local kind_icons = {
	Class = "ﴯ",
	Color = "",
	Constant = "",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "",
	File = "",
	Folder = "",
	Function = "",
	Interface = "",
	Keyword = "",
	Method = "",
	Module = "",
	Operator = "",
	Property = "ﰠ",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "",
	TypeParameter = "",
	Unit = "",
	Value = "",
	Variable = "",
}

cmp.setup({
	-- Copied from https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			-- Source
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
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
		["<S-Tab>"] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
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
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
		{ name = 'omni' },
		{ name = 'buffer',
			option = {
				keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-.]\w*\)*\)]]
			}
		},
	})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lsconfig['texlab'].setup {
	capabilities = capabilities
}
--[[ lsconfig['html'].setup {
	capabilities = capabilities
} --]]
lsconfig['tsserver'].setup {
	capabilities = capabilities
}

--[[ Lean --]]

require('lean').setup{
	abbreviations = { builtin = true },
	lsp = { on_attach = on_attach },
	lsp3 = { on_attach = on_attach },
	mappings = true,
}

--[[ Kanagawa Color Scheme --]]

require('kanagawa').setup({
	transparent = true,
})

EOF



""""" SNIPPET CONFIGURATION

let g:UltiSnipsExpandTrigger='<F2>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'my_snippets']



""""" VIMTEX CONFIGURATION

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
" let g:vimtex_view_general_options_latexmk = '--unique'



""""" COLOUR SETTINGS

" colour theme
colorscheme kanagawa

" highlight of line numbers
" :highlight LineNr ctermfg=red
" :set cursorline
" :highlight clear CursorLine
" :highlight CursorLineNr ctermfg=green
