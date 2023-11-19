return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
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

			mason_lspconfig.setup({
				-- list of servers for mason to install
				ensure_installed = {
					"gopls",
					"lua_ls",
					"rust_analyzer",
					"terraformls",
					"tflint",
					"tsserver",
				},
				-- auto-install configured servers (with lspconfig)
				automatic_installation = true,
				handlers = { default_setup },
			})
		end,
	},
	{
		"williamboman/mason-nvim-dap.nvim",
		dependencies = {
			{ "mfussenegger/nvim-dap" },
		},
		config = function()
			local mason_nvim_dap = require("mason-nvim-dap")

			mason_nvim_dap.setup({
				-- list of debuggers for mason to install
				ensure_installed = {
					"codelldb",
					"delve",
				},
				-- auto-install configured debuggers (with nvim-dap)
				automatic_installation = true,
				-- sets up dap in the predefined manner
				handlers = {},
			})
		end,
	},
	{
		"jayp0521/mason-null-ls.nvim",
		dependencies = {
			{ "jose-elias-alvarez/null-ls.nvim" },
		},
		config = function()
			local mason_null_ls = require("mason-null-ls")

			mason_null_ls.setup({
				-- list of formatters & linters for mason to install
				ensure_installed = {
					"buildifier",
					"goimports",
					"prettierd",
					"rustfmt",
					"stylua",
					"terraform_fmt",
					"eslint_d",
					"golangci_lint",
				},
				-- auto-install configured formatters & linters (with null-ls)
				automatic_installation = true,
			})
		end,
	},
}
