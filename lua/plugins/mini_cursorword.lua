MiniDeps.later(function()
    require("mini.cursorword").setup()

    local function disable(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local tD_dH = vim.lsp.protocol.Methods.textDocument_documentHighlight
        if client and not client.supports_method(tD_dH) then return end
        vim.b[args.buf].minicursorword_disable = true
    end

    vim.api.nvim_create_autocmd("LspAttach", { callback = disable })
end)
