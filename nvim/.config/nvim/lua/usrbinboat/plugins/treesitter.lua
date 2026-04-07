return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- install parsers
			local parsers = {
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
			}
			require("nvim-treesitter").install(parsers)

			-- enable highlighting and indentation for all installed parsers
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					if pcall(vim.treesitter.start) then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			-- register custom parsers
			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = function()
					require("nvim-treesitter.parsers").bru = {
						install_info = {
							url = "https://github.com/pedrobarco/tree-sitter-bru",
							branch = "main",
						},
					}
					require("nvim-treesitter.parsers").kcl = {
						install_info = {
							url = "https://github.com/kcl-lang/tree-sitter-kcl",
							branch = "main",
						},
					}
				end,
			})

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
