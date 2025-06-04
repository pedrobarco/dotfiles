local repos = os.getenv("REPOS")

return {
	dir = repos .. "/pedrobarco/bruno.nvim",
	opts = {},
	ft = { "bru" },
	enabled = false,
}
