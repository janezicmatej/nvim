return {
  -- inject lsp formatting, diagonstics etc
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local none_ls = require 'null-ls'

    none_ls.setup {
      sources = {
        -- general
        none_ls.builtins.code_actions.gitsigns,
        -- python
        -- none_ls.builtins.formatting.black,
        -- typescript
        none_ls.builtins.formatting.prettier,
        -- lua
        none_ls.builtins.formatting.stylua,
      },
    }
  end,
}
