return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		{
			"sindrets/diffview.nvim",
			opts = {
				enhanced_diff_hl = true,
				view = {
					merge_tool = {
						layout = "diff3_mixed",
					},
				},
				file_panel = {
					listing_style = "list",
					win_config = {
						position = "bottom",
						height = 10,
						win_opts = {},
					},
				},
				key_bindings = {
					file_history_panel = {
						q = function()
							require("diffview").close()
						end,
					},
					file_panel = {
						q = function()
							require("diffview").close()
						end,
					},
					view = {
						q = function()
							require("diffview").close()
						end,
					},
				},
			},
		},
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
