-- import cmp-nvim-lsp plugin safely
local lsp_status, lsp = pcall(require, "lsp-zero")
if not lsp_status then
	return
end

-- import neodev plugin safely
local neodev_status, neodev = pcall(require, "neodev")
if not neodev_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
lsp.on_attach(function(_, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, bufopts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	keymap.set("n", "<leader>rr", vim.lsp.buf.references, bufopts)
	keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end)

local servers = require("usrbinboat.plugins.lsp.servers").lsp_servers

neodev.setup()

lsp.preset("recommended")
lsp.ensure_installed(servers)
lsp.setup_nvim_cmp({
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
			})(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. strings[1] .. " "
			kind.menu = "    " .. strings[2] .. ""
			return kind
		end,
	},
})

lsp.configure("gopls", {
	settings = {
		gopls = {
			buildFlags = { "-tags=wireinject" },
		},
	},
})
lsp.nvim_workspace()
lsp.setup()
