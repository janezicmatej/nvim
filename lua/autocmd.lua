vim.api.nvim_create_autocmd({ 'BufEnter, BufWinEnter' }, { command = 'set colorcolumn=120,80,88', pattern = { '*.py', '*.pyi' } })
vim.api.nvim_create_autocmd({ 'BufEnter, BufWinEnter' }, { command = 'set colorcolumn=80,100', pattern = { '*.rs' } })
vim.api.nvim_create_autocmd({ 'BufEnter, BufWinEnter' }, { command = 'set splitright', pattern = { '*' } })
vim.api.nvim_create_autocmd({ 'BufEnter, BufWinEnter' }, { command = 'set splitbelow', pattern = { '*' } })

return {}
