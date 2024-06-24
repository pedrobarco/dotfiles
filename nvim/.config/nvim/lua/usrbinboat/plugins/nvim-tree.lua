return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- disable netrw at the very start of your init.lua (strongly advised)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true

		require("nvim-tree").setup({
			view = {
				adaptive_size = true,
			},
			filters = { custom = { "^.git$" } },
		})
	end,
	keys = {
		{ "<leader>e", "<CMD>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
	},
}
