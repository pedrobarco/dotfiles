" ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
" ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
" ██║   ██║██║██╔████╔██║██████╔╝██║
" ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"  ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"   ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝



" UI Config {{{

syntax on
filetype plugin on
filetype plugin indent on
set relativenumber
set number
" set cursorline
set wildmenu
set lazyredraw
set showmatch
set backspace=indent,eol,start

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}
" Spacing {{{  
set expandtab
set shiftwidth=4
set softtabstop=4
" }}}
" Searching {{{  
set incsearch
set hlsearch
" }}}
" Folding {{{  
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=manual
" }}}
" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}
" Custom Functions {{{
" }}}
" Keybindings {{{
let mapleader = " "

nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader>s :mksession<CR>

vmap <F6> :!xclip -f -sel clip<CR>
map <F7> :-1r !xclip -o -sel clip<CR>
" }}}
" Plugin List {{{ 
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'Yggdroot/indentLine'

call plug#end()
filetype plugin indent on
" }}}
" Colorscheme {{{
  " colorscheme Tomorrow-Night-Bright
   colorscheme fray
" }}}
" Lightline {{{
set laststatus=2
set showcmd
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"R":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }
" }}}
" NERDTree {{{
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp']
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=0

nnoremap <Leader>n :NERDTreeToggle<Enter>
" }}}
" NerdCommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
" }}}
" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" }}}

" vim:foldmethod=marker:foldlevel=0
