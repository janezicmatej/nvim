return {
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
}
