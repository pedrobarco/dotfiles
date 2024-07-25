return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local lga_actions = require("telescope-live-grep-args.actions")

		telescope.setup({
			defaults = require("telescope.themes").get_ivy({
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
			}),
			pickers = {
				find_files = {
					-- file and text search in hidden files and directories
					-- `hidden = true` will still show the inside of .git/ if not ignored
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
				},
			},
			extensions = {
				live_grep_args = {
					mappings = { -- extend mappings
						i = {
							["<C-k>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
						},
					},
				},
			},
		})

		telescope.load_extension("fzy_native")
		telescope.load_extension("live_grep_args")
	end,
	keys = {
		-- file commands
		{
			"<C-p>",
			function()
				local builtin = require("telescope.builtin")
				local opts = {} -- define here if you want to define something
				local ok = pcall(builtin.git_files, opts)
				if not ok then
					builtin.find_files(opts)
				end
			end,
			desc = "find with git_files, otherwise fallback to find_files",
		},
		{
			"<leader>ff",
			require("telescope.builtin").find_files,
			desc = "find files within current working directory, respects .gitignore",
		},
		{
			"<leader>fs",
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
			desc = "find string in current working directory as you type",
		},
		{
			"<leader>fc",
			function()
				require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
			end,
			desc = "find string under cursor in current working directory",
		},
		{
			"<leader>fb",
			require("telescope.builtin").buffers,
			desc = "list open buffers in current neovim instance",
		},
		{ "<leader>fh", require("telescope.builtin").help_tags, desc = "list available help tags" },
		{
			"<leader>fls",
			require("telescope.builtin").lsp_document_symbols,
			desc = "list LSP document symbols in the current buffer",
		},
		-- git commands
		{
			"<leader>gc",
			require("telescope.builtin").git_commits,
			desc = "list all git commits (use <cr> to checkout)",
		}, -- "gc" for git commits
		{
			"<leader>gfc",
			require("telescope.builtin").git_bcommits,
			desc = "list git commits for current file/buffer (use <cr> to checkout)",
		}, -- "gfc" for git file commits
		{
			"<leader>gb",
			require("telescope.builtin").git_branches,
			desc = "list git branches (use <cr> to checkout)",
		}, -- "gb" for git branches
	},
}
