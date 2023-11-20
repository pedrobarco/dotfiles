return {
	{
		"vim-test/vim-test",
		keys = {
			{
				"<leader>tn",
				":TestNearest<CR>",
				desc = "run the test nearest to the cursor",
			},
			{
				"<leader>tc",
				":TestClass<CR>",
				desc = "run the first test class found",
			},
			{
				"<leader>tf",
				":TestFile<CR>",
				desc = "run all tests in the current file",
			},
			{
				"<leader>ts",
				":TestSuite<CR>",
				desc = "run the whole test suite",
			},
			{
				"<leader>tl",
				":TestLast<CR>",
				desc = "run the last test",
			},
			{
				"<leader>tv",
				":TestVisit<CR>",
				desc = "visit the test file",
			},
		},
	},
}
