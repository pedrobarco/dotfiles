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
		"zenbones-theme/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		priority = 1000,
		enabled = false,
		config = function()
			vim.o.background = "dark"
			vim.cmd.colorscheme("zenbones")
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		priority = 1000,
		enabled = true,
		config = function()
			require("cyberdream").setup({
				colors = {
					bg = "#0d0d0d",
				},
			})
			vim.cmd.colorscheme("cyberdream")
		end,
	},
}
