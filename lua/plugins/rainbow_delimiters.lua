MiniDeps.later(function()
    MiniDeps.add("HiPhish/rainbow-delimiters.nvim")

    -- HACK:(@janezicmatej) neovim 0.12 get_parser returns nil instead of erroring
    local lib = require("rainbow-delimiters.lib")
    local original_attach = lib.attach
    lib.attach = function(bufnr, lang)
        local parser = vim.treesitter.get_parser(bufnr, lang, { error = false })
        if not parser then return end
        return original_attach(bufnr, lang)
    end

    require("rainbow-delimiters.setup").setup()
end)
