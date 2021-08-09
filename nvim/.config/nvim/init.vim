" Vim Plug {{{

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

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'preservim/nerdcommenter'
Plug 'voldikss/vim-floaterm'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'kyazdani42/nvim-web-devicons'
Plug 'ayu-theme/ayu-vim'
Plug 'hoob3rt/lualine.nvim'
Plug 'edkolev/tmuxline.vim'
call plug#end()

" }}}
" Treesitter {{{

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

" }}}
" Lsp {{{

lua << EOF
-- Go
require'lspconfig'.gopls.setup{}

-- Typescript
require'lspconfig'.tsserver.setup{}
EOF

" }}}
" Lspsaga {{{

lua << EOF
require'lspsaga'.init_lsp_saga()
EOF

" }}}
" Nvim-compe {{{

lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}
EOF

set completeopt=menuone,noselect

" }}}
" Telescope {{{

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

" }}}
" NerdCommenter {{{

" Create default mappings
let g:NERDCreateDefaultMappings = 0

" }}}
" Lualine + Tmuxline {{{

lua << EOF
require('lualine').setup{
    options = {
        theme = 'ayu_dark',
        component_separators = {'', ''},
        section_separators = {'', ''},
    },
    sections = {
        lualine_x = {'encoding', 'filetype'},
    }
}
EOF

let g:tmuxline_preset = "full"
let g:tmuxline_theme = "vim_statusline_1"

" }}}
" Runtimes {{{

" Node.js
let g:node_host_prog = "~/.yarn/bin/neovim-node-host"

" }}}
" UI Layout {{{

set hidden              " Buffers can exist in the background
set number              " Line numbers are good
set relativenumber      " Easier to navigate
set showcmd             " Show incomplete cmds down the bottom
set cmdheight=1         " Give more space for displaying messages
set showmatch           " Highlight matching [{()}]
set noshowmode          " Get rid of VIM status indicator
set noerrorbells        " Get rid of error bells
set laststatus=2        " Set status for Lightline
set colorcolumn=80      " Set color in column 80
set signcolumn=yes
set isfname+=@-@

if (has("termguicolors"))
  set termguicolors     " Enable true color
endif

syntax enable           " Turn on syntax highlighting
set termguicolors
let ayucolor="dark"
colorscheme ayu         " Set colorscheme

" }}}
" Keybinds {{{

let mapleader=" "       " Change leader to a space because the backslash is too far away

" lspsaga
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>

" nvim-compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <Tab>     compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" telescope
nnoremap <leader>ff <CMD>Telescope find_files<CR>
nnoremap <leader>fg <CMD>Telescope live_grep<CR>
nnoremap <leader>fb <CMD>Telescope buffers<CR>
nnoremap <leader>fh <CMD>Telescope help_tags<CR>

" nerdcommenter
map <leader>cc <plug>NERDCommenterSexy
map <leader>cu <plug>NERDCommenterToggle

" float-terminal
nnoremap <silent> <leader>lg <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazygit<CR>
nnoremap <silent> <leader>nn <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 nnn -Hde<CR>
nnoremap <silent> <leader>tt <CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<CR>

" }}}
" Spaces & Tabs {{{

set smartindent
set softtabstop=4 tabstop=4     " 4 space tab
set shiftwidth=4                " 4 space tab
set expandtab                   " Use spaces for tabs
set nowrap                      " Don't wrap lines

" }}}
" Completion {{{

set wildmode=longest,list,full
set wildmenu                        " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~         " stuff to ignore when tab completing
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

set incsearch       " find the next match as we type the search
set nohlsearch      " don't highlight searches
set ignorecase      " ignore case when searching
set smartcase       " unless we type a capital

" }}}
" Scrolling {{{

set scrolloff=8     " start scrolling when we're 8 lines away from margins

" }}}
" Folding {{{

set foldenable          " dont fold by default
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set foldlevelstart=3    " start with fold level of 1

" }}}
" Backups {{{

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set updatetime=50
set shortmess+=c

" }}}

" vim:foldmethod=marker:foldlevel=0
