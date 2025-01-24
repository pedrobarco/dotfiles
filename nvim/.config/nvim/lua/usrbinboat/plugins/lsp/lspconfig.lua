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
			local lspconfig = require("lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(_, bufnr)
				-- keybind options
				local opts = { noremap = true, silent = true, buffer = bufnr }

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
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
			end

			local default_setup = function(server)
				lspconfig[server].setup({
					capabilities = lsp_capabilities,
					on_attach = on_attach,
				})
			end

			local mason_lspconfig = require("mason-lspconfig")
			local mason_registry = require("mason-registry")

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
					"volar",
					"kcl",
				},
				-- auto-install configured servers (with lspconfig)
				automatic_installation = true,
				handlers = {
					default_setup,
					["gopls"] = function()
						lspconfig.gopls.setup({
							capabilities = lsp_capabilities,
							on_attach = on_attach,
							settings = {
								gopls = {
									buildFlags = { "-tags=mage,wireinject,integration" },
								},
							},
						})
					end,
					["volar"] = function()
						lspconfig.volar.setup({
							capabilities = lsp_capabilities,
							on_attach = on_attach,
							init_options = {
								vue = {
									hybridMode = false,
								},
							},
						})
					end,
					["ts_ls"] = function()
						local vue_language_server_path = mason_registry
							.get_package("vue-language-server")
							:get_install_path() .. "/node_modules/@vue/language-server"

						lspconfig.ts_ls.setup({
							capabilities = lsp_capabilities,
							on_attach = on_attach,
							init_options = {
								plugins = {
									{
										name = "@vue/typescript-plugin",
										location = vue_language_server_path,
										languages = { "vue" },
									},
								},
							},
						})
					end,
				},
			})

			lspconfig.gleam.setup({})
		end,
	},
}
