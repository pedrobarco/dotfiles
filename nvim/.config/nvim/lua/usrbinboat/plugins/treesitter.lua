local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

local servers = require("usrbinboat.plugins.lsp.servers")

treesitter.setup({
	ensure_installed = servers.languages,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
})
