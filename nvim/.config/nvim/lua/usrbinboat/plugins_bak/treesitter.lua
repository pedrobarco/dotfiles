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
		disable = { "python" },
	},
	incremental_selection = {
		enable = true,
	},
})
