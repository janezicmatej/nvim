local M = {}

M.nvim_open_win_border = function(hl_name)
  return {
    { '┌', hl_name },
    { '─', hl_name },
    { '┐', hl_name },
    { '│', hl_name },
    { '┘', hl_name },
    { '─', hl_name },
    { '└', hl_name },
    { '│', hl_name },
  }
end

return M
