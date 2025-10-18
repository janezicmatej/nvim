MiniDeps.later(function()
    MiniDeps.add("neovim/nvim-lspconfig")

    vim.lsp.enable({
        "pyright",
        "ts_ls",
        "rust_analyzer",
        "clangd",
        "gopls",
        "ruff",
        "stylua",
        "lua_ls",
        "nixd",
        "nil_ls",
        "docker_language_server",
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local bufnr = args.buf

            ---@param keys string
            ---@param func function
            ---@param desc string
            ---@param modes? string | table
            local map_lsp = function(keys, func, desc, modes)
                modes = modes or "n"
                vim.keymap.set(
                    modes,
                    "<leader>l" .. keys,
                    func,
                    { buffer = bufnr, desc = "lsp: " .. desc }
                )
            end

            local fzf = require("fzf-lua")

            map_lsp("d", fzf.lsp_definitions, "definition")
            map_lsp("D", fzf.lsp_declarations, "declaration")
            map_lsp("i", fzf.lsp_implementations, "implementation")
            map_lsp("r", fzf.lsp_references, "references")

            map_lsp("t", fzf.lsp_typedefs, "type definition")

            map_lsp("a", fzf.lsp_code_actions, "code action", { "n", "x" })
            map_lsp("n", vim.lsp.buf.rename, "rename")

            map_lsp("W", fzf.lsp_live_workspace_symbols, "workspace symbols")
            map_lsp("L", fzf.lsp_document_symbols, "document symbols")

            map_lsp("w", fzf.lsp_workspace_diagnostics, "workspace diagnostics")
            map_lsp("l", fzf.lsp_document_diagnostics, "document diagnostics")

            map_lsp(
                "f",
                function() vim.lsp.buf.format({ timeout_ms = 2000 }) end,
                "format"
            )

            local tD_dH = vim.lsp.protocol.Methods.textDocument_documentHighlight
            if client and client:supports_method(tD_dH) then
                local ag = vim.api.nvim_create_augroup
                local ac = vim.api.nvim_create_autocmd
                local g = ag("custom-lsp-tD_dH-highlight", { clear = false })

                ac({ "CursorHold", "CursorHoldI" }, {
                    buffer = bufnr,
                    group = g,
                    callback = vim.lsp.buf.document_highlight,
                })

                ac({ "CursorMoved", "CursorMovedI" }, {
                    buffer = bufnr,
                    group = g,
                    callback = vim.lsp.buf.clear_references,
                })

                ac("LspDetach", {
                    group = ag("custom-lsp-detach", { clear = true }),
                    callback = function(e)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds({
                            group = "custom-lsp-tD_dH-highlight",
                            buffer = e.buf,
                        })
                    end,
                })
            end

            -- inlay hints
            if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
        end,
    })
end)
