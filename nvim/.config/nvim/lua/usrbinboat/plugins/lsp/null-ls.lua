return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			{
				"jayp0521/mason-null-ls.nvim",
				dependencies = { "williamboman/mason.nvim" },
				opts = {
					-- list of formatters & linters for mason to install
					ensure_installed = {
						"buildifier",
						"goimports",
						"prettierd",
						"stylua",
						"terraform_fmt",
						"eslint_d",
						"golangci_lint",
						"nixpkgs_fmt",
					},
					-- auto-install configured formatters & linters (with null-ls)
					automatic_installation = true,
				},
			},
		},
		config = function()
			local null_ls = require("null-ls")

			-- for conciseness
			local code_actions = null_ls.builtins.code_actions -- to setup code actions
			local diagnostics = null_ls.builtins.diagnostics -- to setup linters
			local formatting = null_ls.builtins.formatting -- to setup formatters

			-- to setup format on save
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			-- configure null_ls
			null_ls.setup({
				-- setup formatters & linters
				sources = {
					code_actions.eslint_d,
					diagnostics.golangci_lint,
					diagnostics.eslint_d.with({
						condition = function(utils)
							return utils.root_has_file_matches(".eslintrc.*")
						end,
					}),
					diagnostics.buildifier,
					formatting.stylua,
					formatting.buildifier,
					formatting.goimports,
					formatting.prettierd,
					formatting.rustfmt,
					formatting.terraform_fmt,
					formatting.nixpkgs_fmt,
				},

				-- configure format on save
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										--  only use null-ls for formatting instead of lsp server
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,
			})
		end,
	},
}
