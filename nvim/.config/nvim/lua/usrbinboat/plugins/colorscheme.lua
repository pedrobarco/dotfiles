return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"sam4llis/nvim-tundra",
		priority = 1000,
		enabled = false,
		config = function()
			vim.g.tundra_biome = "jungle" -- 'arctic' or 'jungle'
			vim.opt.background = "dark"
			vim.cmd.colorscheme("tundra")
		end,
	},
}
