return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	init = function()
		-- let vim-herdr-navigation own <c-h/j/k/l>; it falls back to
		-- TmuxNavigate* when outside herdr so tmux keeps working
		vim.g.tmux_navigator_no_mappings = 1
	end,
	config = function()
		-- editor side is loaded from the herdr-managed plugin install
		-- (downloaded via `herdr plugin install`, not lazy.nvim)
		local pattern = vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-*/editor/nvim.lua")
		local matches = vim.fn.glob(pattern, true, true)
		if #matches > 0 then
			dofile(matches[1])
		else
			-- herdr plugin not installed yet: keep plain tmux navigation
			vim.keymap.set("n", "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { silent = true })
			vim.keymap.set("n", "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { silent = true })
			vim.keymap.set("n", "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { silent = true })
			vim.keymap.set("n", "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { silent = true })
		end

		-- previous-split is not covered by vim-herdr-navigation
		vim.keymap.set("n", "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", { silent = true })
	end,
}
