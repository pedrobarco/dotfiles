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
	"terraform",
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
	"tflint",
	"tsserver",
}

M.formatters = {
	"buildifier",
	"goimports",
	"prettierd",
	"rustfmt",
	"stylua",
	"terraform_fmt",
}

M.linters = {
	"buildifier",
	"eslint_d",
	"golangci_lint",
}

M.debuggers = {
	"codelldb",
	"delve",
}

return M
