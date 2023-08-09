local M = {}

M.languages = {
	"dockerfile",
	"go",
	"hcl",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

M.lsp_servers = {
	"gopls",
	"lua_ls",
	"rust_analyzer",
	"terraformls",
	"tsserver",
}

M.formatters = {
	"buildifier",
	"goimports",
	"prettierd",
	"rustfmt",
	"stylua",
}

M.linters = {
	"eslint_d",
	"golangci_lint",
}

M.debuggers = {
	"codelldb",
	"delve",
}

return M
