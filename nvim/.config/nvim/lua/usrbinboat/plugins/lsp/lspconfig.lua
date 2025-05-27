return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {},
			},
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		config = function()
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if not client then
						return
					end

					-- keybind options
					local opts = { noremap = true, silent = true, buffer = ev.buf }

					-- Mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, opts)
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, opts)
					vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				end,
			})

			vim.lsp.config("*", {
				capabilities = lsp_capabilities,
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						buildFlags = { "-tags=mage,wireinject,integration" },
					},
				},
			})

			vim.lsp.config("volar", {
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			})

			vim.lsp.config("ts_ls", {
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = "",
							languages = { "vue" },
						},
					},
				},
			})

			vim.lsp.enable("gleam")

			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				-- list of servers for mason to install
				ensure_installed = {
					"bzl",
					"gopls",
					"gradle_ls",
					"kotlin_language_server",
					"lua_ls",
					"rust_analyzer",
					"terraformls",
					"tflint",
					"ts_ls",
					"vue_ls",
					"kcl",
				},
				automatic_enable = true,
			})
		end,
	},
}
