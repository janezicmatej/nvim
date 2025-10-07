MiniDeps.later(function()
    MiniDeps.add("ibhagwan/fzf-lua")

    local fzf = require("fzf-lua")
    fzf.setup({
        files = {
            no_ignore = true,
            toggle_ignore_flag = "--no-ignore-vcs",
        },
        grep = {
            no_ignore = true,
            toggle_ignore_flag = "--no-ignore-vcs",
        },
    })

    vim.keymap.set("n", "<leader>sf", fzf.files)
    vim.keymap.set("n", "<leader>sg", fzf.live_grep)
    vim.keymap.set("n", "<leader>sw", fzf.grep_cword)
    vim.keymap.set("v", "<leader>sg", fzf.grep_visual)

    vim.keymap.set("n", "<leader>sr", fzf.resume)
    vim.keymap.set("n", "<leader>sb", fzf.builtin)
end)
