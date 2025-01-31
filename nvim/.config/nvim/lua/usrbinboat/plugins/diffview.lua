-- get the default branch name for the current git repository
local function get_default_branch_name()
	local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
	return res.code == 0 and "main" or "master"
end

-- get the git range for the diff
-- @param from string: the from git ref
-- @param to string: the to git ref
-- @return string: the git range
local function get_git_range(from, to)
	return from .. ".." .. to
end

-- get the remote name for the given ref
-- @param ref string: the ref to get the remote name for
-- @return string: the remote name
local function get_remote_name(ref)
	return "origin/" .. ref
end

return {
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
	keys = {
		{
			"<leader>hm",
			function()
				local from = get_default_branch_name()
				local to = "HEAD"
				local range = get_git_range(from, to)
				require("diffview").open({ range })
			end,
			desc = "diff against local main branch",
		},
		{
			"<leader>hM",
			function()
				local from = get_remote_name(get_default_branch_name())
				local to = "HEAD"
				local range = get_git_range(from, to)
				require("diffview").open({ range })
			end,
			desc = "diff against remote main branch",
		},
	},
}
