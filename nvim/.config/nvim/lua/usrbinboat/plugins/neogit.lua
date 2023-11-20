return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
		},
		opts = {
			disable_commit_confirmation = true,
			integrations = {
				diffview = true,
			},
		},
	},
}
