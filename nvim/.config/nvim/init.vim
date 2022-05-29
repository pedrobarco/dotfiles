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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'gruvbox-community/gruvbox'
call plug#end()

" Completion
" enable ctrl-n and ctrl-p to scroll through matches
set wildmenu

" Keybinds
let mapleader=" "       " Change leader to space

" Runtimes
" node.js
let g:node_host_prog = "~/.yarn/bin/neovim-node-host"

augroup usrbinboat
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END
