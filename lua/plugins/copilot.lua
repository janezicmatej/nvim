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
        typescript = true,
    }

    -- remap default <M-\> to first close pumenu if open
    local function suggest()
        if vim.fn.pumvisible() == 1 then vim.fn.complete(vim.fn.col("."), {}) end
        return vim.fn["copilot#Suggest"]()
    end
    vim.keymap.set("i", "<M-\\>", suggest)
end)
