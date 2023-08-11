-- import lsp-zero plugin safely
local lsp_status, lsp = pcall(require, "lsp-zero")
if not lsp_status then
	return
end

-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- import neodev plugin safely
local neodev_status, neodev = pcall(require, "neodev")
if not neodev_status then
	return
end

--[[
-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end
--]]

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
lsp.on_attach(function(_, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
	keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
end)

-- local servers = require("usrbinboat.plugins.lsp.servers").lsp_servers

neodev.setup()

lsp.preset({
	name = "minimal",
})

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.gopls.setup({
	settings = {
		gopls = {
			buildFlags = { "-tags=wireinject,integration" },
		},
	},
})

lsp.setup()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
})
