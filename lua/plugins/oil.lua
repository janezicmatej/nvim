add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    add("stevearc/oil.nvim")
    require("oil").setup({ view_options = { show_hidden = true } })
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
end)
