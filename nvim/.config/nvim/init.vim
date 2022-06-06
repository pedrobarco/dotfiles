" Plugins
" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

" Use Vim-plug plugin to manage all other plugins
call plug#begin()
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-project.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'gruvbox-community/gruvbox'
call plug#end()

" Keybinds
let mapleader=" "       " Change leader to space

" Load plugin configurations
lua require("usrbinboat")

augroup usrbinboat
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
