add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    add("neovim/nvim-lspconfig")

    vim.lsp.enable({
        "pyright",
        "ts_ls",
        "rust_analyzer",
        "clangd",
        "gopls",
        "ruff",
        "stylua",
        "lua_ls",
    })
end)
