local has = function(x)
    return vim.fn.has(x) == 1
end

-- UI Layout
vim.opt.number = true              -- line numbers are good
vim.opt.relativenumber = true      -- easier to navigate
vim.opt.showmatch = true           -- highlight matching [{()}]
vim.opt.errorbells = false         -- get rid of error bells
vim.opt.colorcolumn = "80"         -- set color in column 80
vim.opt.signcolumn = "yes"         -- useful for lsp and git
vim.opt.guicursor = ""             -- set cursor shape to block
vim.opt.termguicolors = true       -- enable true color

-- Spaces & Tabs
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4                 -- 4 space tab
vim.opt.shiftwidth = 4              -- 4 space tab
vim.opt.expandtab = true            -- Use spaces for tabs
vim.opt.wrap = false                -- don't wrap lines

-- Search
vim.opt.incsearch = true  -- find the next match as we type the search
vim.opt.hlsearch = false -- don't highlight searches
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true  -- unless we type a capital

-- Scrolling
-- start scrolling when we're 8 lines away from margins
vim.opt.scrolloff=8

-- Folding
vim.opt.foldenable = false   -- don't fold by default
vim.opt.foldmethod = "indent" -- fold based on indent
vim.opt.foldnestmax = 3       -- deepest fold is 3 levels
vim.opt.foldlevelstart = 1    -- start with fold level of 1

-- Backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir= vim.env.HOME .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime=50              -- longer updatetime leads to delays and poor UX
vim.opt.shortmess:append("c")      -- don't pass messages to ins-completion-menu

vim.g.mapleader = "<space>"        -- Map leader key to space
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
