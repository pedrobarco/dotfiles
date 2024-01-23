return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			---@diagnostic disable-next-line: missing-fields
			configs.setup({
				ensure_installed = {
					"bash",
					"dockerfile",
					"go",
					"hcl",
					"javascript",
					"json",
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
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
}
