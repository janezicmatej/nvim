-- bootstrap 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local mini_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/nvim-mini/mini.nvim",
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- set up 'mini.deps' immediately to have its `now()` and `later()` helpers
require("mini.deps").setup()

-- also setup this user command to always save a new lockfile after update
vim.api.nvim_create_user_command("DepsUpdateSnapSave", function(opts)
    local name = opts.args ~= "" and opts.args or nil
    MiniDeps.update(name)
    MiniDeps.snap_save()
end, {
    desc = "Update MiniDeps plugins and save snapshot",
    nargs = "?",
    complete = function(arg, _, _)
        local session_names = vim.tbl_map(
            function(s) return s.name end,
            MiniDeps.get_session()
        )
        return vim.tbl_filter(
            function(n) return vim.startswith(n, arg) end,
            session_names
        )
    end,
})

-- define main config table to be able to use it in scripts
_G.Config = {}

-- dyncamically import lua/plugins/*.lua
local path = vim.fn.stdpath("config") .. "/lua/plugins"

local plugins = vim.iter(vim.fs.dir(path))
    :filter(function(n, t) return t == "file" and n:match("%.lua") end)
    :map(function(n, _)
        local s, _ = n:gsub("%.lua$", "")
        return s
    end)
    :totable()

-- gather errors so any vim.notify overrides happen
local errors = {}

for _, p in ipairs(plugins) do
    local ok, err = pcall(require, "plugins." .. p)
    if not ok then table.insert(errors, "'" .. p .. ".lua'\n\t" .. err) end
end

for _, error in ipairs(errors) do
    vim.notify(error, vim.log.levels.ERROR)
end
