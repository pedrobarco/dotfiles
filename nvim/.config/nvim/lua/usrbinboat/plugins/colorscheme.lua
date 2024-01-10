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
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("github_dark_default")
		end,
	},
}
