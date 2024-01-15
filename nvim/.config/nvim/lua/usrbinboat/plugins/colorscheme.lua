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
			require("nvim-tundra").setup({
				dim_inactive_windows = {
					enabled = true,
					color = require("nvim-tundra.palette.arctic").gray._875,
				},
				plugins = {
					lsp = true,
					semantic_tokens = true,
					treesitter = true,
					nvimtree = true,
					cmp = true,
					context = true,
					dbui = true,
					gitsigns = true,
					neogit = true,
				},
			})
			vim.cmd.colorscheme("tundra")
			vim.opt.statusline = "%2{mode()} | %{expand('%:p:h:t')}/%t %m %r %= %y %8(%l,%c%) %4p%%"
		end,
	},
}
