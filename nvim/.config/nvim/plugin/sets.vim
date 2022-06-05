" UI Layout
set number              " line numbers are good
set relativenumber      " easier to navigate
set showmatch           " highlight matching [{()}]
set noerrorbells        " get rid of error bells
set colorcolumn=80      " set color in column 80
set signcolumn=yes      " useful for lsp and git
set guicursor=          " set cursor shape to block

if (has("termguicolors"))
    set termguicolors     " Enable true color
endif

" Spaces & Tabs
set smartindent
set softtabstop=4 tabstop=4     " 4 space tab
set shiftwidth=4                " 4 space tab
set expandtab                   " Use spaces for tabs
set nowrap                      " don't wrap lines

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
set foldlevelstart=1    " start with fold level of 1

" Backups
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set updatetime=50       " longer updatetime leads to delays and poor UX
set shortmess+=c        " don't pass messages to ins-completion-menu
