return {
  -- inject lsp formatting, diagonstics etc
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        -- general
        null_ls.builtins.code_actions.gitsigns,
        -- python
        -- null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.ruff,
        -- typescript
        null_ls.builtins.formatting.prettier,
        -- lua
        null_ls.builtins.formatting.stylua,
      },
    }
  end,
}
