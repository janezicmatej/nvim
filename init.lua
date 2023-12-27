-- Set <space> as the leader key
--  WARN: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'options'
require 'autocmd'
require 'keymaps'

require('lazy').setup({
  {
    -- NOTE: Theme
    'sainnhe/gruvbox-material',
    priority = 1000,
    lazy = false,
    -- config = function()
    --   vim.g.gruvbox_material_background = 'soft'
    --   vim.g.gruvbox_material_better_performance = 1
    --   vim.g.gruvbox_material_enable_italic = 1
    --
    --   vim.cmd.colorscheme 'gruvbox-material'
    -- end,
    config = function()
      vim.o.background = 'dark'
      vim.g.gruvbox_material_background = 'light'
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.cmd.colorscheme 'gruvbox-material'
      -- changing bg and border colors
      vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
      vim.api.nvim_set_hl(0, 'LspInfoBorder', { link = 'Normal' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
    end,
  },

  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: Second, plugins that require setup call (done via opts)

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- colorize in files
  { 'norcalli/nvim-colorizer.lua', opts = {} },

  -- autopairs on newline
  { 'windwp/nvim-autopairs', opts = {} },

  -- highlighting for comments
  { 'folke/todo-comments.nvim', dependencies = 'nvim-lua/plenary.nvim', opts = {} },

  -- cargo crates
  { 'saecki/crates.nvim', dependencies = 'nvim-lua/plenary.nvim', opts = {} },

  -- import other plugins
  { import = 'plugins' },
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
