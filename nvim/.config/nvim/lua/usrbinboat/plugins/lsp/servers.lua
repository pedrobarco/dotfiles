local M = {}

M.languages = {
	"go",
	"dockerfile",
	"lua",
	"typescript",
	"javascript",
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
}

M.linters = {
	"eslint_d",
	"golangci_lint",
}

return M
