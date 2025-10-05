add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    add("ibhagwan/fzf-lua")

    local fzf = require("fzf-lua")
    fzf.setup({
        files = {
            no_ignore = true,
            rg_opts = [[--color=never --hidden --no-ignore-vcs --files -g "!.git"]],
            fd_opts = [[--color=never --hidden --type f --type l --ignore-file .ignore --exclude .git]],
        },
        grep = {
            no_ignore = true,
            rg_opts = "--column --hidden --no-ignore-vcs --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        },
    })

    vim.keymap.set("n", "<leader>sf", fzf.files)
    vim.keymap.set("n", "<leader>sg", fzf.live_grep)
    vim.keymap.set("n", "<leader>sw", fzf.grep_cword)
    vim.keymap.set("v", "<leader>sg", fzf.grep_visual)

    vim.keymap.set("n", "<leader>sr", fzf.resume)
    vim.keymap.set("n", "<leader>sb", fzf.builtin)
end)
