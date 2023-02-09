local M = {}

M.languages = {
	"dockerfile",
	"go",
	"hcl",
	"javascript",
	"json",
	"lua",
	"python",
	"rust",
	"typescript",
	"yaml",
	"help",
}

M.lsp_servers = {
	"gopls",
	"terraformls",
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

M.debuggers = {
	"delve",
}

return M
