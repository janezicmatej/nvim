MiniDeps.later(function()
    MiniDeps.add("ibhagwan/fzf-lua")

    local fzf_lua = require("fzf-lua")
    fzf_lua.setup({
        files = {
            no_ignore = true,
            toggle_ignore_flag = "--no-ignore-vcs",
        },
        grep = {
            no_ignore = true,
            toggle_ignore_flag = "--no-ignore-vcs",
        },
    })

    vim.keymap.set("n", "<leader>sf", fzf_lua.files)
    vim.keymap.set("n", "<leader>sg", fzf_lua.live_grep)
    vim.keymap.set("n", "<leader>sw", fzf_lua.grep_cword)
    vim.keymap.set("v", "<leader>sg", fzf_lua.grep_visual)
    vim.keymap.set("n", "<leader>sj", fzf_lua.jumps)
    vim.keymap.set("n", "<leader>sh", fzf_lua.helptags)
    vim.keymap.set("n", "<leader>sr", fzf_lua.resume)
    vim.keymap.set("n", "<leader>sb", fzf_lua.builtin)
end)
