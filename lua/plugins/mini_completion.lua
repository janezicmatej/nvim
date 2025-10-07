MiniDeps.later(function()
    require("mini.completion").setup({
        lsp_completion = {
            -- `source_func` should be one of 'completefunc' or 'omnifunc'.
            source_func = "omnifunc",
        },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
        end,
    })
    vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
end)
