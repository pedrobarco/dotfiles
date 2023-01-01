-- UI Layout
vim.opt.number = true -- line numbers are good
vim.opt.relativenumber = true -- easier to navigate
vim.opt.showmatch = true -- highlight matching [{()}]
vim.opt.errorbells = false -- get rid of error bells
vim.opt.colorcolumn = "80" -- set color in column 80
vim.opt.signcolumn = "yes" -- useful for lsp and git
vim.opt.guicursor = "" -- set cursor shape to block
vim.opt.termguicolors = true -- enable true color
vim.opt.pumheight = 20 -- items to show in the popup menu

-- Spaces & Tabs
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4 -- 4 space tab
vim.opt.shiftwidth = 4 -- 4 space tab
vim.opt.expandtab = true -- Use spaces for tabs
vim.opt.wrap = false -- don't wrap lines

-- Search
vim.opt.incsearch = true -- find the next match as we type the search
vim.opt.hlsearch = false -- don't highlight searches
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- unless we type a capital

-- Scrolling
-- start scrolling when we're 8 lines away from margins
vim.opt.scrolloff = 8

-- Backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.env.HOME .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local usrbinboat_group = augroup("usrbinboat", {})

-- Trim whitespace
autocmd({ "BufWritePre" }, {
	group = usrbinboat_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})
