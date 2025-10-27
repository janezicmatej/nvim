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

local function deps_section()
    local mini_deps = require("mini.deps")
    local nr_deps = #vim.iter(mini_deps):enumerate():totable()

    local items = {
        {
            name = "number of dependencies " .. nr_deps,
            action = "",
            section = "dependencies",
        },
    }

    local function mk_dep_item(name, action)
        return { name = name, action = action, section = "dependencies" }
    end

    local deps_actions = {
        mk_dep_item("update dependencies", "DepsUpdate"),
        mk_dep_item("snap dependencies", "DepsSnapSave"),
        mk_dep_item("load dependencies", "DepsSnapLoad"),
        mk_dep_item("clean dependencies", "DepsClean"),
    }

    if vim.fn.getcwd() == vim.fn.stdpath("config") then
        for _, item in ipairs(deps_actions) do
            table.insert(items, item)
        end
    end

    return items
end

MiniDeps.now(function()
    local builtins = {
        { name = "edit new buffer", action = "enew", section = "builtin actions" },
        { name = "quit neovim", action = "qall", section = "builtin actions" },
    }

    require("mini.starter").setup({
        query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
        evaluate_single = true,
        header = default_header,
        footer = "",
        items = {
            -- builtins
            builtins,
            -- dependencies
            deps_section,
            -- debug
            {
                name = "reinstall treesitter parsers",
                action = reinstall_treesitter,
                section = "debug",
            },
        },
    })
end)
