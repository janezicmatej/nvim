MiniDeps.later(function()
    MiniDeps.add("nvim-lua/plenary.nvim")
    MiniDeps.add("ruifm/gitlinker.nvim")
    require("gitlinker").setup({
        callbacks = {
            ["git.aflabs.org"] = require("gitlinker.hosts").get_gitlab_type_url,
            ["git.janezic.dev"] = require("gitlinker.hosts").get_gitea_type_url,
        },
    })
end)
