--[[ OPTIONS --]]

-- Search down into subdirectories.
vim.opt.path:append('**')

-- By default indent with tabs, which are displayed with length 4.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Display certain kinds of whitespace differently:
-- * Tabs are displayed as a line ──╴ of strechable length
-- * Trailing spaces are displayed as ·
-- * Nonbreakable spaces are displayed as ~
vim.opt.list = true
vim.opt.listchars = {
  tab   = '──╴',
  trail = '·',
  nbsp  = '~',
}

-- Hightlight a search term while typing.
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Show relative line numbers, but absolute current line number.
-- Useful for moving to a specific line on screen.
vim.opt.number = true
vim.opt.relativenumber = true
-- Also highlight the current line.
vim.opt.cursorline = true

-- Show at least 15 lines beneath/above the cursor, if possible.
vim.opt.scrolloff = 15

-- Always show document tabs
vim.opt.showtabline = 2

-- Switch between document tabs without saving.
vim.opt.hidden = true

-- Enable softwraps to display long lines at screen.
-- Line breaks are done only at whitespace (if possible).
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Configuration of the completion menu.
vim.opt.completeopt = 'menu,menuone,noselect'

-- I don’t like conceal.
vim.g.tex_conceal = ''

-- Allows % do jump between more kind of paired delimiters than just the
-- default (), [] and {}.
-- This doesn’t automatically work with VimTex. The VimTex configuration later
-- on in the file refines these pairs again.
vim.opt.matchpairs:append('⟨:⟩,⟦:⟧,⌈:⌉,⌊:⌋,“:”')





--[[ KEY BINDINGS --]]

local modes = {
  -- multiple modes
  normal_visual_select = '',
  insert_command_lang  = 'l',
  insert_command       = '!',
  visual_select        = 'v',
  -- single mode
  normal               = 'n',
  visual               = 'x',
  select               = 's',
  insert               = 'i',
  command              = 'c',
  operator             = 'o',
  terminal             = 't',
}

-- Control + c works like Escape, but it sometimes behaves slightly differently.
-- We make sure that they always behave the same.
vim.keymap.set({modes.normal, modes.insert, modes.visual, modes.command}, '<C-c>', '<Esc>')

-- Make semicolon the leader.
vim.g.mapleader = ';'

-- Stop accidently recording.
vim.keymap.set(modes.normal, 'q', '<Nop>')
-- Stop accidental opening of the command history.
vim.keymap.set(modes.normal, 'q:', '<Nop>')

-- Deleting doesn’t overwritte the buffer.
vim.keymap.set({modes.normal, modes.visual}, 'd', '"_d')

-- Pasting doesn’t overwrite the register.
vim.keymap.set(modes.visual, 'p', 'pgvy')

-- Use Y to copy the current selection into the clipboard.
vim.keymap.set({modes.normal, modes.visual}, 'Y', '"+y')

-- Switching between document tabs.
-- alt + arrow keys
vim.keymap.set({modes.normal, modes.visual}, '<A-Right>', 'gt')
vim.keymap.set({modes.normal, modes.visual}, '<A-Left>', 'gT')
-- alt + right-hand WASD
vim.keymap.set({modes.normal, modes.visual}, '<A-n>', 'gt')
vim.keymap.set({modes.normal, modes.visual}, '<A-t>', 'gT')

-- Quickfix
vim.keymap.set(modes.normal, '<silent><C-n>', ':cnext<CR>')
vim.keymap.set(modes.normal, '<silent><C-p>', ':cprevious<CR>')

-- Opening the file under the cursor in a new tab. If this file does not yet
-- exist, create it.
vim.keymap.set(modes.normal, 'to', ':tabedit <cfile> <CR>')

-- Closing buffer with alt + d
vim.keymap.set(modes.normal, '<A-d>', ':bdelete<CR>')

-- Switching search highlight on/off via 'hl'.
-- The current status of the highlight is in vim.opt.hls,
-- either as 0 (off) or 1 (on).
local function toggle_search_highlight()
  vim.o.hls = not vim.o.hls
end
vim.keymap.set(modes.normal, 'h', '<Nop>')
vim.keymap.set(modes.normal, 'hl', toggle_search_highlight)

-- LANGUAGE SERVER COMMANDS
vim.keymap.set(modes.normal, 'l', '<Nop>')





--[[ LOAD PLUGINS --]]

local function github(repo_name)
  local prefix = 'https://github.com/'
  return prefix .. repo_name
end

vim.pack.add({
  -- A collection of often used lua functions.
  github('nvim-lua/plenary.nvim'),

  -- Neovim’s language server configurations.
  github('neovim/nvim-lspconfig'),

  -- Neovim’s treesitter configurations.
  {
    src = github('nvim-treesitter/nvim-treesitter'),
    version = 'main'
  },

  -- A progress indicator, displayed in the bottom right.
  github('j-hui/fidget.nvim'),

  -- Smart tabs: tabs for indentation and spaces for alignment.
  -- Doesn’t work as well as I’d like, but better than nothing.
  github('Thyrum/vim-stabs'),

  -- Telescope for finding stuff.
  -- Still requires actual “finders” to do (most of) the actual finding:
  --   * fzf-native
  --   * file-browser
  -- Uses fd and ripgrep for searching (optional, both an Arch’s community repo).
  github('nvim-telescope/telescope.nvim'),
  github('nvim-telescope/telescope-fzf-native.nvim'),
    -- Missing: the following after every update:
    -- { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' }
  github('nvim-telescope/telescope-file-browser.nvim'),

  -- Quickly getting to a specific position.
  github('easymotion/vim-easymotion'),

  -- Text completion, requires sources for suggested completions.
  github('hrsh7th/cmp-nvim-lsp'),  -- Completion source: language servers.
  github('hrsh7th/cmp-buffer'),    -- Completion source: text in the buffers.
  github('hrsh7th/cmp-path'),      -- Completion source: filesystem paths.
  github('hrsh7th/cmp-cmdline'),   -- Completion source: vim’s cmdline.
  github('hrsh7th/cmp-omni'),      -- Completion source: vim’s omnifunc.
  github('hrsh7th/nvim-cmp'),

  -- Snippets; should be replaced by something else (LuaSnip?) at some point.
  github('SirVer/ultisnips'),
  github('quangnguyen30192/cmp-nvim-ultisnips'), -- Completion source: Ultisnip

  -- VimTex for all kinds of LaTeX stuff.
  github('lervag/vimtex'),

  -- Lean support. Currently disabled.
  github('Julian/lean.nvim'),

  -- Previewing Markdown files in a browser.
  github('iamcco/markdown-preview.nvim'),
  -- Missing: Installs a pre-built version so that nodejs and yarn are not needed.
  -- { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

  -- Colour themes.
  -- github('ribru17/bamboo.nvim'),
  -- github('zootedb0t/citruszest.nvim'),
  -- github('Mofiqul/dracula.nvim'),
  -- github('rebelot/kanagawa.nvim'),
  -- github('EdenEast/nightfox.nvim'),
  -- github('AlexvZyl/nordic.nvim'),
})





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
vim.keymap.set(modes.normal, '<leader>le', builtin.diagnostics, {})
----- Files.
vim.keymap.set(modes.normal, '<leader>ff', builtin.find_files, {})
vim.keymap.set(modes.normal, '<leader>fg', builtin.live_grep, {})
vim.keymap.set(modes.normal, '<leader>fb', builtin.buffers, {})
vim.keymap.set(modes.normal, '<leader>fr', builtin.registers, {})
vim.keymap.set(modes.normal, '<leader>fh', builtin.help_tags, {})
----- Vim’s internal lists.
vim.keymap.set(modes.normal, '<leader>of', builtin.oldfiles, {})
vim.keymap.set(modes.normal, '<leader>cm', builtin.commands, {})
vim.keymap.set(modes.normal, '<leader>km', builtin.keymaps, {})
----- Git.
vim.keymap.set(modes.normal, '<leader>gh', builtin.git_commits, {})
vim.keymap.set(modes.normal, '<leader>gb', builtin.git_branches, {})
vim.keymap.set(modes.normal, '<leader>gs', builtin.git_status, {})
----- Search history.
vim.keymap.set(modes.normal, '<leader>h',  builtin.search_history, {})
----- File browser.
vim.keymap.set(modes.normal, '<leader>t', ':Telescope file_browser<CR>')
----- Repeat the last search
vim.keymap.set(modes.normal, '<leader>f<space>', ':Telescope resume<CR>')
vim.keymap.set(modes.normal, '<leader>r', ':Telescope resume<CR>')
----- The general telescope menu
vim.keymap.set(modes.normal, '<space>', ':Telescope<CR>')

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
local wordfile = {
  ['en-GB'] = 'words-en.txt',
  ['de-DE'] = 'words-de.txt',
}
local drulesfile = {
  ['en-GB'] = 'disabled-rules-en.txt',
  ['de-DE'] = 'disabled-rules-de.txt',
}
local fposfile = {
  ['en-GB'] = 'en-false-positives.json',
}
local envfile = 'environments.json'
local cmdfile = 'commands.json'

-- readfile() used to work out of the box, but at some point it stopped working,
-- so now we have to reimplement things by hand.
local function readstring(filename)
  local file = io.open(filename, 'r')
  if file == nil then error(filename) end
  local str = file:read('*a')
  file:close()
  return str
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
vim.keymap.set(modes.normal, 'le', vim.diagnostic.open_float)
vim.keymap.set(modes.normal, 'lN', function() vim.diagnostic.jump({count = -1}) end)
vim.keymap.set(modes.normal, 'ln', function() vim.diagnostic.jump({count = 1}) end)
vim.keymap.set(modes.normal, 'lq', vim.diagnostic.setloclist)
-- Local commands
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set(modes.normal, 'lD', vim.lsp.buf.declaration, opts)
    vim.keymap.set(modes.normal, 'ld', vim.lsp.buf.definition, opts)
    vim.keymap.set(modes.normal, 'lh', vim.lsp.buf.hover, opts)
    vim.keymap.set(modes.normal, 'li', vim.lsp.buf.implementation, opts)
    vim.keymap.set(modes.normal, 'ls', vim.lsp.buf.signature_help, opts)
    vim.keymap.set(modes.normal, 'lt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set(modes.normal, 'lm', vim.lsp.buf.rename, opts)
    vim.keymap.set({modes.normal, modes.visual}, 'la', vim.lsp.buf.code_action, opts)
    vim.keymap.set(modes.normal, 'lr', vim.lsp.buf.references, opts)
    vim.keymap.set(modes.normal, 'lf', function() vim.lsp.buf.format { async = true } end, opts)
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
  'todotxt', 'toml', 'typescript', 'typst',
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

local function aux_termcodes(str)
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
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
    { name = 'omni' },
    { name = 'buffer'},
  }),
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<space>'] = cmp.mapping({
      c = function()
          if cmp.visible() then
            cmp.confirm({ select = false })
          end
          vim.api.nvim_feedkeys(aux_termcodes('<space>'), 'n', true)
        end,
      i = function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = false })
            vim.api.nvim_feedkeys(aux_termcodes('<space>'), 'n', true)
          else
            fallback()
          end
        end
    }),
    ['<C-n>'] = cmp.mapping({
      c = function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            vim.api.nvim_feedkeys(aux_termcodes('<Down>'), 'n', true)
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
            vim.api.nvim_feedkeys(aux_termcodes('<Up>'), 'n', true)
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
      i = function()
          cmp.abort()
          vim.api.nvim_feedkeys(aux_termcodes('<Up>'), 'n', true)
        end,
      c = function()
          cmp.close()
          vim.api.nvim_feedkeys(aux_termcodes('<Up>'), 'n', true)
        end,
    }),
    ["<Down>"] = cmp.mapping({
      i = function()
          cmp.abort()
          vim.api.nvim_feedkeys(aux_termcodes('<Down>'), 'n', true)
        end,
      c = function()
          cmp.close()
          vim.api.nvim_feedkeys(aux_termcodes('<Down>'), 'n', true)
        end,
    }),
  }),
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





--[[ LEAN.nvim CONFIGURATION --]]

vim.g.lean_config = {
  infoview = {
    autoopen = false
  },
  stderr = {
    enable = false
  }
}





--[[ EASYMOVE CONFIGURATION --]]

-- Disable the default mappings.
vim.g.EasyMotion_do_mapping = 0
-- Search case-insensitive for lowercase search targets.
vim.g.EasyMotion_smartcase = 1
-- Allowed target keys.
vim.g.EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

-- Jump to anywhere you want with minimal keystrokes, with just one key binding.
vim.keymap.set({modes.normal, modes.visual}, ',', '<Plug>(easymotion-overwin-f)')





--[[ ULTISNIP CONFIGURATION --]]
vim.g.UltiSnipsExpandTrigger = '<F2>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-n>'
vim.g.UltiSnipsJumpBackwardTrigger = '<C-p>'
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips', 'my_snippets'}





--[[ VIMTEX CONFIGURATION --]]

vim.g.tex_flavor = 'latex'

-- Disable highlighting of Unicode mathematics as TeX commands, see https://github.com/lervag/vimtex/issues/2732#issuecomment-1677584255
vim.g.vimtex_syntax_match_unicode = false

-- When inside some delimiters (e.g., parentheses) use tsd (toggle surrounding
-- delimiters) to toggle through these (+ no delimiters).
vim.g.vimtex_delim_toggle_mod_list = {
  {'\\bigl',  '\\bigr'},
  {'\\Bigl',  '\\Bigr'},
  {'\\biggl', '\\biggr'},
  {'\\Biggl', '\\Biggr'},
  {'\\left',  '\\right'},
}

-- Paired delimiters that we can jump between using %.
vim.g.vimtex_delim_list = {
  delim_math = {
    name = {
      {'(', ')'},
      {'[', ']'},
      {'\\{',           '\\}'},
      {'⟨',             '⟩'},
      {'⦅',             '⦆'},
      {'⟦',             '⟧'},
      {'⦃',             '⦄'},
      {'⌈',             '⌉'},
      {'⌊',             '⌋'},
      {'\\begingroup', '\\endgroup'},
      {'\\lparen',     '\\rparen'},
      {'\\lbrack',     '\\rbrack'},
      {'\\lbrace',     '\\rbrace'},
      {'\\langle',     '\\rangle'},
      {'\\lBrack',     '\\rBrack'},
      {'\\lceil',      '\\rceil'},
      {'\\lfloor',     '\\rfloor'},
      {'\\ulcorner',   '\\urcorner'},
      {'\\lvert',      '\\rvert'},
      {'\\lVert',      '\\rVert'},
    },
  },
}

-- Disable automatic compilation for every little change.
vim.g.vimtex_compiler_latexmk = {continuous = 0}
-- Alt+2 for compilation; uses 'latexmk' per default
vim.keymap.set(modes.normal, '<M-2>', ':wall<Return>:VimtexCompile<Return>')
-- Alt+3 for opening the PDF viewer at the current position
vim.keymap.set(modes.normal, '<M-3>', ':VimtexView<Return>')

-- Forward and backward search with okular, as explained in
-- :help vimtex-view-okular
-- :help vimtex-synctex-inverse-search
vim.g.vimtex_compiler_progname    = 'nvr'
vim.g.vimtex_view_method          = 'general'
vim.g.vimtex_view_general_viewer  = 'okular'
vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
-- In Okular, under
--   Settings > Configure Okular > Editor
-- choose 'Custom Text Editor' and enter the following command:
--   nvim --headless -c "VimtexInverseSearch %l '%f'"





--[[ MARKDOWN PREVIEW CONFIG --]]

-- Taken from: https://github.com/iamcco/markdown-preview.nvim/blob/02cc3874738bc0f86e4b91f09b8a0ac88aef8e96/README.md

-- Leave the preview open, even if the file has been closed in the editor.
-- Not what I want, but the auto-close function leads to error warnings that are more annoying than closing the preview by hand.
vim.g.mkdp_auto_close = 0
-- Disable sync scroll (default is 0); all other options are the untouched default values.
vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 1,
  sync_scroll_type = 'middle',
  hide_yaml_meta = 1,
  sequence_diagrams = {},
  flowchart_diagrams = {},
  content_editable = false,
  disable_filename = 0,
  toc = {}
}
-- To change the font for monospace fonts, a custom CSS file must be specified.
-- This file is just a copy of
-- https://github.com/iamcco/markdown-preview.nvim/blob/02cc3874738bc0f86e4b91f09b8a0ac88aef8e96/app/_static/markdown.css
-- with ".markdown-body code > font-family" adjusted.
vim.g.mkdp_markdown_css = vim.fn.expand('~/.config/nvim/others/markdown-preview/markdown.css')
