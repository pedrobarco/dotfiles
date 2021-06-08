"       _
"  __ _(_)_ __  _ _ __
"  \ V / | '  \| '_/ _|
" (_)_/|_|_|_|_|_| \__|

" Vim Plug {{{

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Use Vim-plug plugin to manage all other plugins
call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'puremourning/vimspector'

Plug 'tpope/vim-fugitive'
call plug#end()

" }}}
" Runtimes {{{

" Node.js
let g:node_host_prog = "~/.nvm/versions/node/v14.17.0/bin/neovim-node-host"

" }}}
" UI Layout {{{

set hidden							"Buffers can exist in the background
set number							"Line numbers are good
set relativenumber						"Easier to navigate
set showcmd							"Show incomplete cmds down the bottom
set cmdheight=1							"Give more space for displaying messages
set showmatch							"Highlight matching [{()}]
set noshowmode							"Get rid of VIM status indicator
set noerrorbells						"Get rid of error bells
set laststatus=2						"Set status for Lightline
set colorcolumn=80
set signcolumn=yes

if (has("termguicolors"))
  set termguicolors						"Enable true color
endif

syntax enable							"Turn on syntax highlighting
colorscheme default						"Set colorscheme

" }}}
" Keybinds {{{

let mapleader=" "				"Change leader to a space because the backslash is too far away

" }}}
" Spaces & Tabs {{{

set autoindent
set smartindent
set softtabstop=4	"4 space tab
set tabstop=4		"4 space tab
set shiftwidth=4	"4 space tab
set expandtab		"Use spaces for tabs

set nowrap		"Don't wrap lines
set linebreak		"Wrap lines at convenient points

" }}}
" Completion {{{

set wildmode=longest,list,full
set wildmenu						"enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~			"stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" }}}
" Search {{{

set incsearch       " Find the next match as we type the search
set nohlsearch      " Don't highlight searches
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" }}}
" Scrolling {{{

set scrolloff=8         "Start scrolling when we're 8 lines away from margins

" }}}
" Folding {{{

set foldenable        "dont fold by default
set foldmethod=indent "fold based on indent
set foldnestmax=3    "deepest fold is 3 levels
set foldlevelstart=3   " start with fold level of 1

" }}}
" Backups {{{

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set updatetime=50

" }}}

" vim:foldmethod=marker:foldlevel=0
