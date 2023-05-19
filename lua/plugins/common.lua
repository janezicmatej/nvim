return {
  -- NOTE: Theme
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    lazy = false,
    config = function()
      vim.g.gruvbox_material_background = 'soft'
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = 1

      vim.cmd.colorscheme 'gruvbox-material'
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

  -- newage search plugin
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  -- permanent links to fileranges
  {
    'ruifm/gitlinker.nvim',
    config = function()
      require('gitlinker').setup {
        callbacks = {
          ['git.aflabs.org'] = require('gitlinker.hosts').get_gitlab_type_url,
        },
      }
    end,
  },

  -- NOTE: Third, plugins that require some setup, but not enugh for separate file

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
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

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'gruvbox-material',
        statusline_style = 'mix',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1,
          },
        },
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  {
    -- git blame annotations
    'f-person/git-blame.nvim',
    init = function()
      -- disable on startup
      vim.g.gitblame_enabled = 0
    end,
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>gt', ':GitBlameToggle<CR>', { desc = '[G]it Blame [T]oggle', noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>gu', ':GitBlameOpenCommitURL<CR>', { desc = '[G]it Blame Open Commit [U]rl', noremap = true })
    end,
  },

  {
    -- a more adventurous wildmenu
    'gelguy/wilder.nvim',
    dependencies = { 'romgrk/fzy-lua-native' },
    config = function()
      local wilder = require 'wilder'
      wilder.setup { modes = { ':', '/', '?' } }
      -- Disable Python remote plugin
      wilder.set_option('use_python_remote_plugin', 0)

      wilder.set_option('pipeline', {
        wilder.branch(
          wilder.cmdline_pipeline {
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          },
          wilder.vim_search_pipeline()
        ),
      })

      wilder.set_option(
        'renderer',
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
          highlights = {
            border = 'Normal',
          },
          border = 'rounded',
          highlighter = wilder.lua_fzy_highlighter(),
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        })
      )
    end,
  },

  {
    'projekt0n/circles.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      icons = { empty = '●', filled = '○', lsp_prefix = '●' },
    },
  },

  -- file menu
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {
        renderer = {
          icons = {
            glyphs = require('circles').get_nvimtree_glyphs(),
          },
        },
        filters = {
          custom = {
            '__pycache__',
          },
        },
        git = {
          ignore = false,
        },
      }
    end,
  },
}
