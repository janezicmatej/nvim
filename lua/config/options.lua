vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- general
vim.o.backup = false
vim.o.mouse = ""
-- TODO:(janezicmatej) i think mouse scroll is binded to up/down and this
-- deosn't always work
vim.o.mousescroll = "ver:0,hor:0"
vim.o.writebackup = false
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- ui
vim.o.breakindent = true
vim.o.colorcolumn = "+1"
vim.o.number = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.winborder = "double"

-- editing
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- diagnostic show virtual text
vim.diagnostic.config({ virtual_text = true })
local function swap_diagnostic()
    local virtext = vim.diagnostic.config().virtual_text
    local virlines = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_text = not virtext, virtual_lines = not virlines })
end
vim.keymap.set("n", "<leader>dt", swap_diagnostic)

-- osc52 escape codes copy
local function ocs52_paste_fail()
    vim.notify("can't paste via osc52", vim.log.levels.WARN)
    return {}
end
vim.g.clipboard = {
    name = "osc52-writeonly",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = ocs52_paste_fail,
        ["*"] = ocs52_paste_fail,
    },
}

vim.o.completeopt = "menuone,noselect,fuzzy,nosort"

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight when yanking text",
    group = vim.api.nvim_create_augroup("CustomHighlightYank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})
