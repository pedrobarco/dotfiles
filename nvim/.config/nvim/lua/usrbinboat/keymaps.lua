-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- nvim-tree
keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", {}) -- toggle file explorer

-- telescope
local telescope_status, telescope = pcall(require, "telescope.builtin")
if not telescope_status then
	return
end

-- file commands
keymap.set("n", "<C-p>", require("usrbinboat.plugins.telescope").project_files) -- find with git_files, otherwise fallback to find_files
keymap.set("n", "<leader>ff", telescope.find_files) -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", telescope.live_grep) -- find string in current working directory as you type
keymap.set("n", "<leader>fc", telescope.grep_string) -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", telescope.buffers) -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", telescope.help_tags) -- list available help tags
keymap.set("n", "<leader>fls", telescope.lsp_document_symbols) -- list LSP document symbols in the current buffer

-- git commands
keymap.set("n", "<leader>gc", telescope.git_commits) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", telescope.git_bcommits) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", telescope.git_branches) -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", telescope.git_status) -- list current changes per file with diff preview ["gs" for git status]

-- dap
local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>do", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>dO", dap.step_out)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input({ "Log point message: " }))
end)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>dl", dap.run_last)

-- dap-ui widgets
local widgets_status, widgets = pcall(require, "dap.ui.widgets")
if not widgets_status then
	return
end

vim.keymap.set({ "n", "v" }, "<leader>dh", widgets.hover)
vim.keymap.set({ "n", "v" }, "<leader>dp", widgets.preview)
vim.keymap.set("n", "<leader>df", function()
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<leader>ds", function()
	widgets.centered_float(widgets.scopes)
end)
