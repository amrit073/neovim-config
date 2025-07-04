-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  }
  use "folke/which-key.nvim"
  use "linux-cultist/venv-selector.nvim"
  use 'AckslD/swenv.nvim'
  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup { { snippet_engine = "luasnip" } }
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  }
  use { 'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons' }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'rafamadriz/friendly-snippets' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('vim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use { 'windwp/nvim-autopairs' }
  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- use { 'NeogitOrg/neogit', requires = 'nvim-lua/plenary.nvim' }
  use 'navarasu/onedark.nvim'                   -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim'               -- Fancier statusline
  use { 'lukas-reineke/indent-blankline.nvim' } -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim'                   -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth'                        -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use { 'nvim-tree/nvim-tree.lua', requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  } }

  use 'karb94/neoscroll.nvim'

  use { 'rmagatti/goto-preview' }

  use { "petertriho/nvim-scrollbar" }

  use 'nyngwang/NeoNoName.lua'

  use 'mfussenegger/nvim-dap-python'
  -- use {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       keymaps = {
  --         accept_suggestion = "<Tab>",
  --       },
  --       disable_keymaps = false, -- disables built in keymaps for more manual control
  --     })
  --   end,
  -- }
  --
  use {
    'nvim-flutter/flutter-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }
  use({
    "olimorris/codecompanion.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    }
  })

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Fold using tresitter
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- require('swenv').setup({
--   -- Should return a list of tables with a `name` and a `path` entry each.
--   -- Gets the argument `venvs_path` set below.
--   -- By default just lists the entries in `venvs_path`.
--   get_venvs = function(venvs_path)
--     return require('swenv.api').get_venvs(venvs_path)
--   end,
--   -- Path passed to `get_venvs`.
--   venvs_path = vim.fn.expand('~/venvs'),
--   -- Something to do after setting an environment, for example call vim.cmd.LspRestart
--   post_set_venv = nil,
-- })

require("scrollbar").setup({
  handle = {
    text = " ",
    blend = 0,                  -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
    color = nil,
    color_nr = nil,             -- cterm
    highlight = "CursorColumn",
    hide_if_all_visible = true, -- Hides handle if all lines are visible
  },
  handlers = {
    cursor = false,
    diagnostic = true,
    gitsigns = true, -- Requires gitsigns
    handle = true,
    search = false,  -- Requires hlslens
    ale = false,     -- Requires ALE
  },
}
)



-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
    sections = {
      lualine_a = 'swenv',
      lualine_x = { 'swenv', icon = '' }
    }
  },
}



-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
local highlight = {
  "CursorColumn",
}

require("ibl").setup({
  indent = {
    char = '┊',
    highlight = highlight
  },
  scope = { enabled = false },
}
)
require('nvim-autopairs').setup()
-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 100,
    ignore_whitespace = false,
  },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  defaults = {
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    layout_strategy = "horizontal",
    layout_config = {
      height = 0.8,
      width = 0.8,
      prompt_position = "bottom",
      preview_width = 0.5,
    },
    prompt_prefix = " ",
    cache_picker = {
      num_pickers = 20,
    },
  },
}

require("nvim-tree").setup({
  diagnostics = {
    enable = true,
  },
  view = {
    side = "right",
    preserve_window_proportions = true,
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "all",
    root_folder_label = ":~:s?$?/..?",
    indent_width = 2,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    }
  }
})

require("bufferline").setup {
  options = {
    diagnostics = "nvim_lsp",
    numbers = "ordinal",
    middle_mouse_command = "bdelete! %d",        -- can be a string | function, | false see "Mouse actions"
    right_mouse_command = "BufferLineTogglePin", -- can be a string | function | false, see "Mouse actions"
    color_icons = true,
    separator_style = "thin",
    diagnostics_indicator = function()
      return ' '
    end,
    git = {
      enable = true
    },
    log = {
      enable = true,
      truncate = true,
      types = {
        git = true,
        profile = true,
      },
    },
    offsets = {
      {
        filetype = 'NvimTree',
      }
    },
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find()
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').git_status, { desc = '[S]earch Git [S]tash' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').treesitter, { desc = '[S]earch [T]reesitter' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'typescript' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    -- keymaps = {
    --   init_selection = '<c-space>',
    --   node_incremental = '<c-space>',
    --   scope_incremental = '<c-s>',
    --   node_decremental = '<c-backspace>',
    -- },
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

local keymap = vim.keymap.set
local builtin = require('telescope.builtin')

-- Rename and Code Action
keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[LSP] Rename' })
keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[LSP] Code Action' })

-- Go to Definition/References/Implementation
keymap('n', 'gd', builtin.lsp_definitions, { desc = '[LSP] Go to Definition' })
keymap('n', 'gr', builtin.lsp_references, { desc = '[LSP] Go to References' })
keymap('n', 'gI', vim.lsp.buf.implementation, { desc = '[LSP] Go to Implementation' })
keymap('n', 'gD', vim.lsp.buf.declaration, { desc = '[LSP] Go to Declaration' })

-- Type Definition and Symbols
keymap('n', '<leader>D', vim.lsp.buf.type_definition, { desc = '[LSP] Type Definition' })
keymap('n', '<leader>ds', builtin.lsp_document_symbols, { desc = '[LSP] Document Symbols' })
keymap('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[LSP] Workspace Symbols' })

-- Documentation
keymap('n', 'K', vim.lsp.buf.hover, { desc = '[LSP] Hover Documentation' })
keymap('n', '<C-k>', vim.lsp.buf.signature_help, { desc = '[LSP] Signature Help' })

-- Workspace management
keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = '[LSP] Add Workspace Folder' })
keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = '[LSP] Remove Workspace Folder' })
keymap('n', '<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = '[LSP] List Workspace Folders' })
vim.api.nvim_create_user_command('Format', function(_)
  vim.lsp.buf.format()
end, { desc = 'Format current buffer with LSP' })

-- vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- pyright = {
  --   inlay_hints = true
  --
  -- },
  --
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- This strips out &nbsp; and some ending escaped backslashes out of hover
-- strings because the pyright LSP is... odd with how it creates hover strings.
local hover = function(_, result, ctx, config)
  if not (result and result.contents) then
    return vim.lsp.handlers.hover(_, result, ctx, config)
  end
  if type(result.contents) == "string" then
    local s = string.gsub(result.contents or "", "&nbsp;", " ")
    s = string.gsub(s, [[\\\n]], [[\n]])
    result.contents = s
    return vim.lsp.handlers.hover(_, result, ctx, config)
  else
    local s = string.gsub((result.contents or {}).value or "", "&nbsp;", " ")
    s = string.gsub(s, "\\\n", "\n")
    result.contents.value = s
    return vim.lsp.handlers.hover(_, result, ctx, config)
  end
end

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'


mason_lspconfig.setup({
  handlers = function(server_name)
    local server = servers[server_name] or {}
    -- This handles overriding only values explicitly passed
    -- by the server configuration above. Useful when disabling
    -- certain features of an LSP (for example, turning off formatting for ts_ls)
    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
    require('lspconfig')[server_name].setup(server)
  end,
})

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      local copilot_keys = vim.fn['copilot#Accept']()
      if copilot_keys ~= '' and type(copilot_keys) == 'string' then
        vim.api.nvim_feedkeys(copilot_keys, 'i', true)
      else
        fallback()
      end
    end, { 'i', 's' }),
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    -- local suggestion = require('supermaven-nvim.completion_preview')
    -- if suggestion.has_suggestion() then
    --   suggestion.on_accept_suggestion()
    -- else
    --   fallback()
    -- end
    --
    -- does this work as lsp_expand
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'CodeCompanion' },
    -- { name = 'supermaven' }
  },
}
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline' }
  })
})

require('neogen').setup({ snippet_engine = 'luasnip' });
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
vim.cmd('source $HOME/.config/nvim/term.vim')
vim.cmd('source $HOME/.config/nvim/dappy.lua')
-- vim.cmd('source $HOME/.config/nvim/newplugs.lua');
-- require('newplugs')



vim.api.nvim_create_user_command('W', function(_)
  vim.cmd('w')
end, { desc = ':W = :w' })

vim.api.nvim_create_user_command('Q', function(_)
  vim.cmd('q')
end, { desc = ':Q = :q' })


vim.api.nvim_set_keymap("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>", { noremap = true })


require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = 'copilot'
    },
    inline = {
      adapter = 'copilot'
    },
  },
})

-- local root_files = { '.git', 'pyproject.toml', 'setup.py', 'setup.cfg', 'Pipfile', 'venv', 'requirements.txt' }
--
-- -- Configure the Ty LSP client
-- vim.lsp.config['ty'] = {
--   cmd       = { 'ty', 'server' }, -- command to start Ty
--   filetypes = { 'python' },       -- only activate for Python files
--   root_dir  = vim.fs.root(0, root_files),
--   settings  = {},                 -- (no special settings needed initially)
-- }
-- -- Enable (auto-start) the Ty server for Python
-- vim.lsp.enable('ty')
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "python",
--   callback = function()
--     vim.lsp.start({
--       name = "ty",
--       cmd = { "ty", "server" },
--       root_dir = vim.fs.root(0, { ".git", "pyproject.toml", "setup.py", 'requirements.txt' }),
--       filetypes = { "python" },
--     })
--   end,
-- })
