-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- nvim-tree
keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", {}) -- toggle file explorer

-- telescope
keymap.set("n", "<C-p>", require("usrbinboat.plugins.telescope").project_files) -- find with git_files, otherwise fallback to find_files
keymap.set("n", "<leader>ff", require("telescope.builtin").find_files) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", require("telescope.builtin").live_grep) -- find string in current working directory as you type
keymap.set("n", "<leader>fc", require("telescope.builtin").grep_string) -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", require("telescope.builtin").buffers) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags) -- list available help tags

-- telescope git commands
keymap.set("n", "<leader>gc", require("telescope.builtin").git_commits) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", require("telescope.builtin").git_bcommits) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches) -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", require("telescope.builtin").git_status) -- list current changes per file with diff preview ["gs" for git status]

-- dap
vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)
vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<leader>B", require("dap").set_breakpoint)
vim.keymap.set("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input({ "Log point message: " }))
end)
vim.keymap.set("n", "<leader>dr", require("dap").repl.open)
vim.keymap.set("n", "<leader>dl", require("dap").run_last)
vim.keymap.set({ "n", "v" }, "<leader>dh", require("dap.ui.widgets").hover)
vim.keymap.set({ "n", "v" }, "<leader>dp", require("dap.ui.widgets").preview)
vim.keymap.set("n", "<leader>df", function()
	local widgets = require("dap.ui.widgets").centered_float()
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
--]]
