add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    add("sainnhe/gruvbox-material")

    vim.o.background = "dark"
    vim.g.gruvbox_material_background = "light"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_diagnostic_line_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_enable_italic = 1

    -- vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
    -- vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

    vim.cmd.colorscheme("gruvbox-material")
end)
