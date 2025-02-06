-- set leader key to space
vim.g.mapleader = " "

vim.keymap.set("v", "<leader>y", '"+y') -- copy to system clipboard

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selection up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selection down

vim.keymap.set("n", "<C-u>", "<C-u>zz") -- page up and center cursor in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- page down and center cursor in screen
