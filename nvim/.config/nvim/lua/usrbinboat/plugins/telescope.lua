-- find with git_files, otherwise fallback to find_files
local function project_files()
	local builtin = require("telescope.builtin")
	local opts = {} -- define here if you want to define something
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	dependencies = {
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-lua/plenary.nvim",
	},
	cmd = "Telescope",
	keys = {
		{
			"<C-p>",
			function()
				project_files()
			end,
			desc = "Find Project Files",
		},
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fs",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Find String",
		},
		{
			"<leader>fc",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Find Word",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "List Buffers",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "List Help Tags",
		},
		{
			"<leader>fls",
			function()
				require("telescope.builtin").lsp_document_symbols()
			end,
			desc = "Goto Symbol",
		},
		{
			"<leader>gc",
			function()
				require("telescope.builtin").git_commits()
			end,
			desc = "Git Commits",
		},
		{
			"<leader>gfc",
			function()
				require("telescope.builtin").git_bcommits()
			end,
			desc = "Git File Commits",
		},
		{
			"<leader>gb",
			function()
				require("telescope.builtin").git_branches()
			end,
			desc = "Git Branches",
		},
	},
	opts = {
		pickers = {
			find_files = {
				-- file and text search in hidden files and directories
				-- `hidden = true` will still show the inside of .git/ if not ignored
				find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
			},
		},
	},
	config = function(_, opts)
		opts.defaults =
			require("telescope.themes").get_ivy({
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob",
					"!.git/*",
				},
			}), require("telescope").load_extension("fzy_native")
		require("telescope").setup(opts)
	end,
}
