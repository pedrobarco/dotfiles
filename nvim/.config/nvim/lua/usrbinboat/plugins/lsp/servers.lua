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
	"vim",
	"vimdoc",
	"markdown",
	"markdown_inline",
}

M.lsp_servers = {
	"gopls",
	"terraformls",
	"tsserver",
	"lua_ls",
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
