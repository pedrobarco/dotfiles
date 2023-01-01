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
	"sumneko_lua",
	"gopls",
	"tsserver",
}

M.formatters = {
	"stylua",
	"prettier",
	"buildifier",
	"goimports",
}

M.linters = {
	"eslint_d",
	"golangci_lint",
}

return M
