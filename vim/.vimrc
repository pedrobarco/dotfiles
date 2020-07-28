"       _
"  __ _(_)_ __  _ _ __
"  \ V / | '  \| '_/ _|
" (_)_/|_|_|_|_|_| \__|

" Vim Plug {{{

" Use Vim-plug plugin to manage all other plugins
if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	  	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'yarisgutierrez/ayu-lightline'
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" }}}
" Lightline {{{

let g:lightline = {}
let g:lightline.colorscheme = 'ayu'

" }}}
" Tmuxline {{{

let g:tmuxline_powerline_separators = 0

" }}}
" UI Layout {{{

set nocompatible						"Use Vim settings, rather then Vi settings (much better!).
set hidden								"Buffers can exist in the background
set number								"Line numbers are good
set relativenumber						"Easier to navigate
set backspace=indent,eol,start			"Allow backspace in insert mode
set history=1000						"Store lots of :cmdline history
set showcmd								"Show incomplete cmds down the bottom
set showmatch							"Highlight matching [{()}]
set noshowmode							"Get rid of VIM status indicator
set laststatus=2						"Set status for Lightline

if (has("termguicolors"))
  set termguicolors						"Enable true color
endif

syntax enable							"Turn on syntax highlighting
set background=dark						"Set dark colorscheme
let ayucolor="dark"						"Set mirage version of ayu
colorscheme	ayu							"Set colorscheme

" }}}
" Keybinds {{{

let mapleader=" "				"Change leader to a space because the backslash is too far away

" Nerdtree
map <Leader>n :NERDTreeToggle<CR>

" Fzf
map <C-p> :Files<CR>

" }}}
" Spaces & Tabs {{{

set autoindent
set smartindent
set smarttab
set shiftwidth=4	"4 space tab
set softtabstop=4	"4 space tab
set tabstop=4		"4 space tab
set noexpandtab		"Use tabs for spaces
set modelines=1		"One line setup vim setup on-file
filetype indent on
filetype plugin on
set autoindent

set list listchars=tab:\ \ ,trail:· " Display tabs and trailing spaces visually

set nowrap			"Don't wrap lines
set linebreak		"Wrap lines at convenient points

" }}}
" Completion {{{

set wildmode=longest:full,list:full
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" }}}
" Search {{{

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" }}}
" Scrolling {{{

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" }}}
" Folding {{{

set foldenable        "dont fold by default
set foldmethod=indent "fold based on indent
set foldnestmax=3    "deepest fold is 3 levels
set foldlevelstart=3   " start with fold level of 1

" }}}
" Backups {{{

set noswapfile
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" }}}

" vim:foldmethod=marker:foldlevel=0
