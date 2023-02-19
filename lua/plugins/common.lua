return {
  -- NOTE: Theme
  {
    'ellisonleao/gruvbox.nvim',

    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  },

  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: Second, plugins that require setup call

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',        opts = {} },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',       opts = {} },

  -- colorize in files
  { "norcalli/nvim-colorizer.lua", opts = {} },

  -- highlighting for comments
  { "folke/todo-comments.nvim",    dependencies = "nvim-lua/plenary.nvim", opts = {} },

  -- NOTE: Third, plugins that require some setup, but not enugh for separate file

  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'gruvbox',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  { -- git blame annotations
    'f-person/git-blame.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>gt', ':GitBlameToggle<CR>', { desc = '[G]it Blame [T]oggle', noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>gu', ':GitBlameOpenCommitURL<CR>',
        { desc = '[G]it Blame Open Commit [U]rl', noremap = true })
    end
  },

  { -- a more adventurous wildmenu
    'gelguy/wilder.nvim',

    dependencies = { 'romgrk/fzy-lua-native' },

    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':', '/', '?' } })
      -- Disable Python remote plugin
      wilder.set_option('use_python_remote_plugin', 0)

      wilder.set_option('pipeline', {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        )
      })

      wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          highlights = {
            border = 'Normal',
          },
          border = 'rounded',
          highlighter = wilder.lua_fzy_highlighter(),
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        })
      ))
    end,
  },

  { -- file tree
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      require('neo-tree').setup {}
    end,
  },
}
