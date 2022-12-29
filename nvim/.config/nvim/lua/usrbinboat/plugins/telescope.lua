local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local builtin = require("telescope.builtin")

telescope.setup({
	defaults = require("telescope.themes").get_ivy({}),
	pickers = {
		find_files = {
			-- file and text search in hidden files and directories
			-- `hidden = true` will still show the inside of .git/ if not ignored
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
		},
	},
})

telescope.load_extension("fzy_native")

local M = {}

M.project_files = function()
	local opts = {} -- define here if you want to define something
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

return M
