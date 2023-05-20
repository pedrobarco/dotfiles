return {
	{},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = true,
		config = function()
			-- This is where you modify the settings for lsp-zero
			-- Note: autocompletion settings will not take effect

			require("lsp-zero.settings").preset({})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			-- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

			require("lsp-zero.cmp").extend()
			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				},
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neodev.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"williamboman/mason.nvim",
				build = function()
					vim.cmd("MasonUpdate")
				end,
			},
		},
		config = function()
			require("neodev").setup()

			-- This is where all the LSP shenanigans will live
			local lsp = require("lsp-zero")

			lsp.on_attach(function(_, bufnr)
				-- for conciseness
				local keymap = vim.keymap
				-- keybind options
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, bufopts)
				keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
				keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				keymap.set("n", "<leader>rr", vim.lsp.buf.references, bufopts)
				keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end)

			-- (Optional) Configure lua language server for neovim
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

			lsp.setup()
		end,
	},
}
