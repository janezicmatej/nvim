local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

now_if_args(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        checkout = "main",
        hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
    })

    require("nvim-treesitter").install({
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "go",
        "html",
        "javascript",
        "json",
        "python",
        "regex",
        "rust",
        "toml",
        "tsx",
        "yaml",
    })
end)
