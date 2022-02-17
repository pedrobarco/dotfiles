" Plugins
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

" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup{
    ensure_installed = {
        "dockerfile",
        "go",
        "graphql",
        "javascript",
        "json",
        "typescript",
        "yaml",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
    },
}
EOF
" Lsp
lua << EOF
-- Go
require'lspconfig'.gopls.setup{}
-- Typescript
require'lspconfig'.tsserver.setup{}
EOF

" Telescope
lua << EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  }
}
EOF

" Runtimes
" node.js
let g:node_host_prog = "~/.yarn/bin/neovim-node-host"

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

set laststatus=0        " Disable neovim statusline

if (has("termguicolors"))
  set termguicolors     " Enable true color
endif

syntax enable           " Turn on syntax highlighting
set termguicolors
set background=dark
colorscheme gruvbox     " Set colorscheme

" Keybinds
let mapleader=" "       " Change leader to space
" telescope
nnoremap <leader>ff <CMD>Telescope find_files<CR>
nnoremap <C-p> <CMD>Telescope git_files<CR>
nnoremap <leader>fg <CMD>Telescope live_grep<CR>
nnoremap <leader>fb <CMD>Telescope buffers<CR>
nnoremap <leader>nt <CMD>Telescope file_browser<CR>

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
set undodir=~/.config/nvim/undodir
set undofile
set updatetime=50
set shortmess+=c
