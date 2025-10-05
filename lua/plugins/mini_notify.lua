add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    require("mini.notify").setup()
    vim.notify = MiniNotify.make_notify()
end)
