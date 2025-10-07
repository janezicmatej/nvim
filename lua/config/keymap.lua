vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

vim.keymap.set(
    "t",
    "<C-x>",
    vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
    { desc = "escape terminal mode" }
)

vim.keymap.set("n", "<leader>hh", ":noh<cr>", { desc = "no highlight search" })
