vim.g.mapleader = " "

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

vim.o.completeopt = "menuone,noselect,fuzzy,nosort"

-- default plus added dash
vim.o.iskeyword = "@,48-57,_,192-255,-"
