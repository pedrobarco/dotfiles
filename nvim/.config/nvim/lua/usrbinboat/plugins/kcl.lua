return {
	"kcl-lang/kcl.nvim",
	init = function()
		vim.api.nvim_command([[autocmd BufRead,BufNewFile *.k set filetype=kcl]])
	end,
	ft = {
		"kcl",
	},
}
