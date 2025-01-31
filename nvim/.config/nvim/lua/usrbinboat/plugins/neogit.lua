return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"sindrets/diffview.nvim",
	},
	opts = {
		disable_commit_confirmation = true,
	},
	keys = {
		{
			"<leader>gs",
			function()
				require("neogit").open()
			end,
			desc = "open neogit",
		},
	},
}
