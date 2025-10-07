MiniDeps.later(function()
    MiniDeps.add("f-person/git-blame.nvim")
    require("gitblame").setup({
        enabled = false,
        message_template = "  <sha>: <author> <date> <summary>",
        date_format = "%Y-%m-%d",
    })

    vim.keymap.set("n", "<leader>gt", ":GitBlameToggle<CR>")
    vim.keymap.set("n", "<leader>gs", ":GitBlameCopySHA<CR>")
end)
