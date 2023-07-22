-- Plugins
-- Install packer if not found
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local PACKER_BOOTSTRAP = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- Use packer to manage all other plugins
return packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})
	use("nvim-treesitter/nvim-treesitter-context")

	-- Managing & Installing LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				run = ":MasonUpdate",
			},
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})
	use({ "folke/neodev.nvim" })

	-- Telescope
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")

	-- Formatters & Linters
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	-- Debuggers
	use("mfussenegger/nvim-dap")
	use({ "jayp0521/mason-nvim-dap.nvim", requires = { "mfussenegger/nvim-dap" } })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({ "leoluz/nvim-dap-go", requires = { "mfussenegger/nvim-dap" } })

	-- File Explorer
	use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } })

	-- Statusline
	use({ "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons" } })

	-- Icons
	use("onsails/lspkind-nvim")
	use("nvim-tree/nvim-web-devicons")

	-- Colorscheme
	use("sainnhe/gruvbox-material")

	-- Misc
	use("numToStr/Comment.nvim")
	use("tpope/vim-surround")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use({ "TimUntersberger/neogit", requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } })

	-- Database
	use("tpope/vim-dadbod")
	use("kristijanhusak/vim-dadbod-ui")

	-- Go
	use("fatih/vim-go")

	-- Terraform
	use("hashivim/vim-terraform")

	-- Markdown
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })

	-- YAML
	use("towolf/vim-helm")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
