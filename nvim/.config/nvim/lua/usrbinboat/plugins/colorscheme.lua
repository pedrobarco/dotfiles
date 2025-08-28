return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		enabled = false,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"topazape/oldtale.nvim",
		priority = 1000,
		enabled = false,
		config = function()
			require("oldtale").setup({
				integrations = {
					cmp = true,
					gitsigns = true,
					lazy = true,
					lsp = true,
					mason = true,
					telescope = true,
					treesitter = true,
				},
			})
			vim.cmd.colorscheme("oldtale")
		end,
	},
	{
		"savq/melange-nvim",
		priority = 1000,
		enabled = false,
		config = function()
			vim.cmd.colorscheme("melange")
		end,
	},
	{
		"Tsuzat/NeoSolarized.nvim",
		priority = 1000,
		enabled = true,
		config = function()
			require("NeoSolarized").setup({
				style = "light",
				transparent = false,
				italics = false,
			})
			vim.cmd.colorscheme("NeoSolarized")
		end,
	},
}
