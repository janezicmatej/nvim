MiniDeps.later(function()
    require("mini.indentscope").setup({
        draw = {
            delay = 0,
            animation = require("mini.indentscope").gen_animation.none(),
        },
    })

    local disable = {
        "fzf",
        "fzflua_backdrop",
        "qf",
    }

    local disable_set = {}
    for _, v in ipairs(disable) do
        disable_set[v] = true
    end

    local function term_disable(args) vim.b[args.buf].miniindentscope_disable = true end
    local function ft_disable(args)
        local ft = vim.bo[args.buf].filetype
        if disable_set[ft] == nil then return end
        vim.b[args.buf].miniindentscope_disable = true
    end

    vim.api.nvim_create_autocmd("TermOpen", { callback = term_disable })
    vim.api.nvim_create_autocmd("Filetype", { callback = ft_disable })
end)
