MiniDeps.later(function()
    MiniDeps.add("lewis6991/gitsigns.nvim")
    require("gitsigns").setup({
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "x" },
            topdelete = { text = "x" },
            changedelete = { text = "~" },
        },
    })

    -- blame
    vim.keymap.set({ "n", "v" }, "<leader>gb", ":Gitsigns blame<CR>")
    vim.keymap.set({ "n", "v" }, "<leader>gt", ":Gitsigns blame_line<CR>")

    -- hunks
    vim.keymap.set({ "n", "v" }, "<leader>ga", ":Gitsigns stage_hunk<CR>")
    vim.keymap.set({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
end)
