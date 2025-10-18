local function default_header()
    local hour = tonumber(vim.fn.strftime("%H"))
    local part_id = math.floor((hour + 4) / 8) + 1
    local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
    local username = vim.loop.os_get_passwd()["username"] or "USERNAME"

    return ("good %s, %s"):format(day_part, username)
end

local function reinstall_treesitter()
    local ts = require("nvim-treesitter")
    ts.install(ts.get_installed(), { force = true })
end

MiniDeps.now(function()
    require("mini.starter").setup({
        query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
        evaluate_single = true,
        header = default_header,
        footer = "",
        items = {
            --stylua: ignore start
            -- builtins
            { name = "edit new buffer",              action = "enew",               section = "builtin actions" },
            { name = "quit neovim",                  action = "qall",               section = "builtin actions" },
            -- dependencies
            { name = "update dependencies",          action = "DepsUpdate",         section = "dependencies" },
            { name = "snap dependencies",            action = "DepsSnapSave",       section = "dependencies" },
            { name = "load dependencies",            action = "DepsSnapLoad",       section = "dependencies" },
            { name = "clean dependencies",           action = "DepsClean",          section = "dependencies" },
            -- debug
            { name = "reinstall treesitter parsers", action = reinstall_treesitter, section = "debug" },
            --stylua: ignore end
        },
    })
end)
