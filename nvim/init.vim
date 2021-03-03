" Detect filetype
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Enable true color support
set termguicolors

" Disable creation of swap files
set noswapfile

" How tabs are displayed and inserted
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab

" Automatically indents lines
set cindent
" Other ways to autoindent
" set autoindent
" set smartindent

" Case insensitive search
set incsearch ignorecase smartcase hlsearch

" Better command-line completion
set wildmenu
" Wildmenu will ignore certain things
" Ignore all variations of node_modules
set wildignore=**node_modules**

" Shows two line status bar at bottom of editor
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 

set wrap breakindent

" Move window as you scroll instead of going all the way to the bottom
set scrolloff=11

" UTS-8 character encoding pretty standard
set encoding=utf-8

" Enables line numbers and numbers relative to cursor position
set number
set relativenumber

set title

" Rempaps for managing tabs
map tn :tabnew<Space>
map tk :tabnext<CR>
map tj :tabprev<CR>
map th :tabfirst<CR>
map tl :tablast<CR>

" Allows for wrapping movement to next or previous line
set whichwrap+=<,>,h,l,[,]

" Netrw file browser settings
" Tree like listing
let g:netrw_liststyle = 3
