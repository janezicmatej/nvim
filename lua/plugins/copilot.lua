local now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

now_if_args(function()
    MiniDeps.add("github/copilot.vim")

    vim.g.copilot_filetypes = {
        -- disable all and only allow specific filetyps
        ["*"] = false,
        --
        c = true,
        cpp = true,
        dockerfile = true,
        go = true,
        javascript = true,
        lua = true,
        nix = true,
        python = true,
        rust = true,
        sh = true,
        typescript = true,
    }
end)
