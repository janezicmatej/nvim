MiniDeps.now(function()
    require("mini.notify").setup()
    vim.notify = MiniNotify.make_notify()
end)
