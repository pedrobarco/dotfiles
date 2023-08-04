-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- import mason-nvim-dap plugin safely
local mason_nvim_dap_status, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_status then
	return
end

-- enable mason
mason.setup()

local servers = require("usrbinboat.plugins.lsp.servers")

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = servers.lsp_servers,
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = { unpack(servers.formatters), unpack(servers.linters) },
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

mason_nvim_dap.setup({
	-- list of debuggers for mason to install
	ensure_installed = servers.debuggers,
	-- auto-install configured debuggers (with nvim-dap)
	automatic_installation = true,
	-- sets up dap in the predefined manner
	handlers = {},
})
