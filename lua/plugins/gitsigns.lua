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
end)
