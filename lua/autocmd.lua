vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, { command = 'set colorcolumn=79,80,88,120', pattern = { '*.py', '*.pyi' } })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, { command = 'set colorcolumn=80,100', pattern = { '*.rs' } })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, { command = 'set splitright', pattern = { '*' } })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, { command = 'set splitbelow', pattern = { '*' } })

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

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.gitlab-ci*.{yml,yaml}',
  callback = function()
    vim.bo.filetype = 'yaml.gitlab'
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = vim.fn.expand '~' .. '/.ssh/config.d/*.config',
  callback = function()
    vim.bo.filetype = 'sshconfig'
  end,
})
