-- Bootstrap 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
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

-- Set up 'mini.deps' immediately to have its `now()` and `later()` helpers
require("mini.deps").setup()

-- Also setup this user command to always save a new lockfile after update
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

-- Define main config table to be able to use it in scripts
_G.Config = {}

-- import other plugins
local r = function(m) require("plugins." .. m) end

local order = {
    "colorscheme",
    "oil",
    "fzf_lua",
}

for _, m in ipairs(order) do
    r(m)
end
