MiniDeps.now(function()
    MiniDeps.add("j-hui/fidget.nvim")

    local opts = {
        notification = {
            override_vim_notify = true,
        },
    }

    require("fidget").setup(opts)
end)
