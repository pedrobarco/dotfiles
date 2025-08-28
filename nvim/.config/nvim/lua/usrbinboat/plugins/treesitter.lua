return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			---@diagnostic disable-next-line: missing-fields
			configs.setup({
				ensure_installed = {
					"bash",
					"css",
					"dockerfile",
					"gleam",
					"go",
					"hcl",
					"helm",
					"javascript",
					"json",
					"kotlin",
					"lua",
					"markdown",
					"markdown_inline",
					"nix",
					"python",
					"rust",
					"terraform",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"yaml",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
				},
			})

			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			---@diagnostic disable-next-line: inject-field
			parser_config.bru = {
				install_info = {
					url = "https://github.com/pedrobarco/tree-sitter-bru",
					files = { "src/parser.c" },
					branch = "main",
					generate_requires_npm = false,
					requires_generate_from_grammar = false,
				},
			}

			---@diagnostic disable-next-line: inject-field
			parser_config.kcl = {
				install_info = {
					url = "https://github.com/kcl-lang/tree-sitter-kcl",
					files = { "src/parser.c" },
					branch = "main",
					generate_requires_npm = false,
					requires_generate_from_grammar = false,
				},
			}

			vim.api.nvim_create_augroup("KCLFileType", { clear = true })
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				group = "KCLFileType",
				pattern = "*.k",
				callback = function()
					vim.opt.filetype = "kcl"
				end,
			})
			vim.api.nvim_create_autocmd({ "FileType" }, {
				group = "KCLFileType",
				pattern = "kcl",
				callback = function()
					vim.opt_local.commentstring = "# %s"
				end,
			})
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "gleam",
				callback = function()
					vim.opt_local.commentstring = "// %s"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
}
