-- Plugins
-- Install lazy if not found
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- Treesitter
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",

	-- LSP Support
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"folke/neodev.nvim",

	-- Autocompletion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",

	-- Snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	"nvim-telescope/telescope-fzy-native.nvim",

	-- Formatters & Linters
	"jose-elias-alvarez/null-ls.nvim",
	"jayp0521/mason-null-ls.nvim",

	-- Debuggers
	"mfussenegger/nvim-dap",
	{ "jayp0521/mason-nvim-dap.nvim", dependencies = { "mfussenegger/nvim-dap" } },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{ "leoluz/nvim-dap-go", dependencies = { "mfussenegger/nvim-dap" } },

	-- File Explorer
	{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- Statusline
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

	-- Colorscheme
	"sainnhe/gruvbox-material",

	-- Misc
	"numToStr/Comment.nvim",
	"tpope/vim-surround",

	-- Git
	"lewis6991/gitsigns.nvim",
	{ "TimUntersberger/neogit", dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } },

	-- Database
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-ui",

	-- Go
	"fatih/vim-go",

	-- Terraform
	"hashivim/vim-terraform",

	-- Markdown
	-- use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })
}

local opts = {}

local status, lazy = pcall(require, "lazy")
if not status then
	return
end

lazy.setup("usrbinboat.plugins")
