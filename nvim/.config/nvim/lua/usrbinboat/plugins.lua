-- Plugins
-- Install packer if not found
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })
end

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
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

    -- Managing & Installing LSP
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")

    -- Telescope
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")

    -- Autocompletion
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/nvim-cmp")
    use("onsails/lspkind-nvim")

    -- Formatters & Linters
    use("jose-elias-alvarez/null-ls.nvim")
    use("jayp0521/mason-null-ls.nvim")

    -- Snippets
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Comments
    use("numToStr/Comment.nvim")

    -- File Explorer
    use({"nvim-tree/nvim-tree.lua", requires = {"nvim-tree/nvim-web-devicons"}})

    -- Statusline
    use({"nvim-lualine/lualine.nvim", requires = {"nvim-tree/nvim-web-devicons"}})

    -- Icons
    use("nvim-tree/nvim-web-devicons")

    -- Colorscheme
    use("gruvbox-community/gruvbox")

    -- Markdown
    use({"iamcco/markdown-preview.nvim", run = "cd app && yarn install"})

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
