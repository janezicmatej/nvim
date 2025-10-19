MiniDeps.later(function()
    MiniDeps.add("zbirenbaum/copilot.lua")
    -- TODO:(@janezicmatej) setup lsp nes
    -- MiniDeps.add("copilotlsp-nvim/copilot-lsp")

    local function no_attach_for_env()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            return false
        end
        return true
    end

    local opts = {
        panel = {
            keymap = {
                jump_prev = false,
                jump_next = false,
                accept = false,
                refresh = false,
                open = false,
            },
        },
        suggestion = {
            -- auto_trigger = true,
            keymap = {
                accept = false,
                accept_word = false,
                accept_line = false,
                next = false,
                prev = false,
                dismiss = false,
            },
        },
        filetypes = {
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
            sh = no_attach_for_env,
            bash = no_attach_for_env,
            typescript = true,
        },
    }
    require("copilot").setup(opts)

    local suggestion = require("copilot.suggestion")

    local function accept_if_visible()
        vim.notify("is visible " .. (suggestion.is_visible() or "nil"))
        if suggestion.is_visible() ~= nil then
            suggestion.accept()
        else
            return "<Tab>"
        end
    end

    local function close_pum_if_open(func)
        return function()
            if vim.fn.pumvisible() == 1 then vim.fn.complete(vim.fn.col("."), {}) end
            return func()
        end
    end

    -- stylua: ignore start
    vim.keymap.set({ "i" }, "<Tab>", accept_if_visible, { desc = "copilot: accept suggestion", expr = true })
    vim.keymap.set({ "n", "i" }, "<M-j>", suggestion.accept_line, { desc = "copilot: accept line" })

    vim.keymap.set({ "n", "i" }, "<M-l>", close_pum_if_open(suggestion.next), { desc = "copilot: next suggestion" })
    vim.keymap.set({ "n", "i" }, "<M-h>", close_pum_if_open(suggestion.prev), { desc = "copilot: previous suggestion" })
    -- stylua: ignore start
end)
