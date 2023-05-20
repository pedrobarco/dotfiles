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
