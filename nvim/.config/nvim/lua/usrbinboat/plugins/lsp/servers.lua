local M = {}

M.languages = {
	"go",
	"dockerfile",
	"javascript",
	"lua",
	"python",
	"rust",
	"typescript",
	"help",
}

M.lsp_servers = {
	"gopls",
	"tsserver",
	"sumneko_lua",
}

M.formatters = {
	"stylua",
	"prettierd",
	"buildifier",
	"goimports",
}

M.linters = {
	"eslint_d",
	"golangci_lint",
}

return M
