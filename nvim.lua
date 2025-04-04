vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'christoomey/vim-sort-motion',
  'editorconfig/editorconfig-vim',
  'michaeljsmith/vim-indent-object',
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-speeddating',
  'tpope/vim-surround',
  'tpope/vim-vinegar',
  'axkirillov/easypick.nvim',
  { 'folke/which-key.nvim', opts = {} },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  { 'numToStr/Comment.nvim', opts = {} },


  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      { 'j-hui/fidget.nvim', tag = 'v1.1.0', opts = {} },
    },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- Don't override the built-in and fugitive keymaps.
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'diagnostics'},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',

      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
}, {})

require('telescope').setup {
  extensions = {
    undo = {
      mappings = {
        i = {
          ["<cr>"] = require("telescope-undo.actions").restore
        },
      },
    },
  },
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-q>'] = (
          require("telescope.actions").smart_send_to_qflist +
          require("telescope.actions").open_qflist
        ),
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
require("telescope").load_extension("undo")
local easypick = require("easypick")
easypick.setup({
  pickers = {
    {
      name = "git_status",
      command = "git status --porcelain | cut -c4-",
      previewer = easypick.previewers.branch_diff({base_branch = 'HEAD'})
    },

    {
      name = "changed_files",
      command = "git diff --name-only $(git merge-base HEAD origin/master)",
      previewer = easypick.previewers.branch_diff({base_branch = 'origin/master'})
    },
  }
})


-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'go',
      'java',
      'javascript',
      'json',
      'lua',
      'python',
      'rust',
      'starlark',
      'terraform',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
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
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Create a command `:Format` local to the LSP buffer.
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup { }
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup()

cmp.setup {
  completion = {
    autocomplete = false,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Telescope maps.
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').git_files, { desc = 'Search git files' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>cf', '<cmd>Easypick changed_files<CR>', { desc = '[C]hanged [F]iles' })
vim.keymap.set('n', '<leader>gs', '<cmd>Easypick git_status<CR>', { desc = '[G]it [S]tatus' })

-- Highlight yanked text.
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set completeopt to have a better completion experience.
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- Enable break indent.
vim.o.breakindent = true

-- Save undo history.
vim.o.undofile = true

-- d and u make the window vertically smaller and bigger, respectively.
vim.keymap.set('n', '<leader>d', '1000<C-W>-')
vim.keymap.set('n', '<leader>u', '20<C-W>+')

-- Make the current buffer executable.
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>')

-- Open the current buffer in a new tab.
vim.keymap.set('n', '<leader>t', '<cmd>tabe %<CR>')

-- Open the current directory/folder in the current pane.
vim.keymap.set('n', '<leader>f', '<cmd>Explore<CR>')

-- Easier to get out of insert mode with 'kj'.
vim.keymap.set('i', 'kj', '<Esc>')

-- Automatically insert the closing brace.
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O')

-- Live dangerously (disable all back up files).
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Ignore case in search patterns by default.
vim.opt.ignorecase = true
-- Searches are case-sensitive if caps used.
vim.opt.smartcase = true

-- Reopen all changed files with :EA.
vim.api.nvim_create_user_command('EA', 'checktime', {})

-- Show dollar sign at end of text to be changed.
vim.opt.cpoptions:append('$')

-- Powerline already displays the mode.
vim.opt.showmode = false

-- Enable sane indent settings. Note: These can get overridden by EditorConfig.
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Display some whitespace characters.
vim.opt.listchars = {
  tab = '>-',
  trail = '.',
  extends = '>',
  precedes= '<',
}
vim.opt.list = true

-- Highlight the current line.
vim.opt.cursorline = true

-- Don't always redraw (in macros, etc. in particular).
vim.opt.lazyredraw = true

-- Don't automatically resize windows when splitting.
vim.opt.equalalways = false

-- Keep 5 lines of context at the top and bottom of the cursor.
vim.opt.scrolloff = 5

-- Don't allow buffers to be hidden without prompting to save them.
vim.opt.hidden = false

-- Display a line at 80 columns.
vim.opt.colorcolumn = '80'

-- Enable dictionary completion and spell mode for prose files.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'gitcommit', 'text' },
  callback = function() vim.opt.spell = true end
})
