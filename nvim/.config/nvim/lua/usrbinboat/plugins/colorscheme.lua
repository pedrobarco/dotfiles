return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		enabled = true,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}
