-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- nvim-tree
keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", {}) -- toggle file explorer

-- telescope
keymap.set("n", "<C-p>", "<CMD>lua require'usrbinboat.plugins.telescope'.project_files()<CR>") -- find with git_files, otherwise fallback to find_files
keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<CMD>Telescope live_grep<CR>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<CMD>Telescope grep_string<CR>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<CMD>Telescope help_tags<CR>") -- list available help tags

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
