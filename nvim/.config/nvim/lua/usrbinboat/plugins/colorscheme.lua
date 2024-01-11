return {
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.gruvbox_material_background = "hard"
	-- 		vim.cmd.colorscheme("gruvbox-material")
	-- 	end,
	-- },
	{
		"sam4llis/nvim-tundra",
		priority = 1000,
		config = function()
			require("nvim-tundra").setup()
			vim.cmd.colorscheme("tundra")
		end,
	},
}
