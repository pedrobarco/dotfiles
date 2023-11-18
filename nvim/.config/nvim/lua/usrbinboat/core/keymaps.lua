-- set leader key to space
vim.g.mapleader = " "

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selection up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selection down

vim.keymap.set("n", "<C-u>", "<C-u>zz") -- page up and center cursor in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- page down and center cursor in screen

--[[
-- dap
local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

vim.keymap.set("n", "<leader>dc", dap.continue) -- launch debug session and continue execution
vim.keymap.set("n", "<leader>do", dap.step_over) -- step over the current line
vim.keymap.set("n", "<leader>di", dap.step_into) -- step into a function or method if possible
vim.keymap.set("n", "<leader>dO", dap.step_out) -- step out of a function or method if possible
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint) -- create or remove a breakpoint at the current line
vim.keymap.set("n", "<leader>dl", dap.run_last) -- run the last debug session

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

-- vim-test
vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>") -- run the test nearest to the cursor
vim.keymap.set("n", "<leader>tc", ":TestClass<CR>") -- run the first test class found
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>") -- run all tests in the current file
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>") -- run the whole test suite
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>") -- run the last test
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>") -- visit the test file
--]]
