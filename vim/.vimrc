" Plugins
" Use Vim-plug plugin to manage all other plugins
call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'earthly/earthly.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()

" UI Layout
set hidden              " Buffers can exist in the background
set number              " Line numbers are good
set relativenumber      " Easier to navigate
set showcmd             " Show incomplete cmds down the bottom
set cmdheight=1         " Give more space for displaying messages
set showmatch           " Highlight matching [{()}]
set noerrorbells        " Get rid of error bells
set colorcolumn=80      " Set color in column 80

set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

if (has("termguicolors"))
  set termguicolors     " Enable true color
endif

syntax enable           " Turn on syntax highlighting
set termguicolors
set background=dark
colorscheme gruvbox     " Set colorscheme

" Keybinds
let mapleader=" "       " Change leader to space

" Spaces & Tabs
set smartindent
set softtabstop=2 tabstop=2     " 2 space tab
set shiftwidth=2                " 2 space tab
set expandtab                   " Use spaces for tabs
set nowrap                      " Don't wrap lines

" Completion
" enable ctrl-n and ctrl-p to scroll through matches
set wildmenu

" Search
set incsearch       " find the next match as we type the search
set nohlsearch      " don't highlight searches
set ignorecase      " ignore case when searching
set smartcase       " unless we type a capital

" Scrolling
" start scrolling when we're 8 lines away from margins
set scrolloff=8

" Folding
set nofoldenable        " don't fold by default
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set foldlevelstart=3    " start with fold level of 1

" Backups
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set updatetime=50
set shortmess+=c
