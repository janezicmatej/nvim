return {
  'SmiteshP/nvim-navbuddy',
  dependencies = {
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('nvim-navbuddy').setup { lsp = { auto_attach = true } }

    -- Plugins
    vim.keymap.set('n', '<leader>nb', ':Navbuddy<CR>', { desc = '[N]av[b]uddy' })
    vim.keymap.set('n', '<leader>nt', ':NvimTreeToggle<CR>', { desc = '[N]vim[T]ree' })
  end,
}
