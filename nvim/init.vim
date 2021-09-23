" init.vim

" {{{ Vim Specific Settings
" These settings are on by default in nvim
if !has('nvim')
	set nocompatible
	set encoding=utf-8
	set backspace=indent
	set visualbell
	set mouse=a
	set autoread
	set smarttab
	" Better command-line completion
	set wildmenu
endif
" }}}

" {{{ Basic Settings
" Remember unloaded buffers
set hidden

" Title of terminal window is name of file being edited
set title

" Enables line numbers and numbers relative to cursor position
set number
set relativenumber

" Detect filetype
if has('autocmd')
	filetype plugin indent on
endif

" Enable syntax highlighting and true color
if has('syntax')
	syntax on
endif

" Turn on true color if available
if has('termguicolors')
	set termguicolors
endif
" Set Colorscheme if available
try
	colorscheme mycolorscheme
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme default
	set background=dark
endtry

" Disable Annoying Features
" Disable creation of swap files
set noswapfile
set nobackup
set nowrap
set viminfo=
" Modelines have historically been a source of security vulnerabilities
set nomodeline

" How tabs are displayed and inserted
" Settings for hardtabs
set tabstop=4 shiftwidth=4
" Automatically indents lines when you insert a new line :h smartindent
set smartindent

" Case insensitive search and highlight
set incsearch ignorecase smartcase hlsearch

" Wildmenu will ignore certain things
" Ignore all variations of these files/folders
set wildignore+=*/node_modules/*
set wildignore+=*/__pycache__/*
set wildignore+=*/android/*
set wildignore+=*/ios/*
set wildignore+=*/.git/*
set wildignore+=*.pyc

" Move window as you scroll
set scrolloff=11
set sidescrolloff=5

" Text folding :help folds
" Folds text inside {{{'}}} by default
set foldenable
set foldmethod=marker

" Indicate tabs and trailing spaces
" listchars var defines the characters that indicate whitespace
set list

" Completion Menu Settings
set completeopt=menu,menuone,noselect
set complete=.,w,b,u,t
" }}}

" {{{ Custom Mappings and Commands
" Remap control+c to behave like escape so it triggers InsertLeave autocmd
imap <C-c> <Esc>
vmap <C-c> <Esc>

" View mappings
" :nmap - Display normal mode maps
" :imap - Display insert mode maps
" :vmap - Display visual and select mode maps
" :smap - Display select mode maps
" :xmap - Display visual mode maps
" :cmap - Display command-line mode maps
" :omap - Display operator pending mode maps
" Maps leader key to space
let mapleader = ' '

" Still save if you do :W instead of :w
command! W :w
nnoremap <leader>w :w<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>q :qa<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

" xclip is needed for paste and yank with system clipboard
" Paste from system clipboard
" For some reason leader key with this binding is slow but not with control
nnoremap <C-p> "+p
" Yank into system clipboard
nnoremap <C-y> "+y

" Insert a single character from normal mode
nnoremap <C-i> i_<Esc>r
nnoremap <C-a> a_<Esc>r

nnoremap <leader>m :make<CR>
nnoremap <leader>t :make test<CR>

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Remaps for managing tabs
noremap <leader>n :tabnew<Space>
noremap <leader>c :tabclose<CR>
noremap <leader>k :tabnext<CR>
noremap <leader>j :tabprev<CR>
noremap <leader>h :tabfirst<CR>
noremap <leader>l :tablast<CR>

" Insert c multiline comment like /* */
" Insert comment into normal mode move left 2 spaces into insert mode
inoremap <C-d> /*  */<ESC>2hi
" Comment all selected lines in visual mode with //
vnoremap <Leader>d :s/^/\/\//<bar>nohlsearch<CR>

" Insert license header in file
" https://www.gilesorr.com/blog/vimscript-insert.html
command! License :call InsertLicense()
function! InsertLicense()
	let l:text = '/* See LICENSE for copyright and license details. */'
	" Append text to line 0 means insert on the first line
	let l:failed = append(0, l:text)
	if (l:failed)
		echo 'Unable to insert license text'
	else
		" Set buffer to modified
		let &modified = 1
	endif
endfunction

" :h formatoptions and :h fo-table
command! WM call WritingMode()
function! WritingMode()
	" spelling and thesaurus
	setlocal spell spelllang=en_us
	" set thesaurus+=/home/test/.vim/thesaurus/mthesaur.txt
	" complete+=s makes autocompletion search the thesaurus
	" set complete+=s
endfunction
" }}}

" {{{ Status Line
" Shows two line status bar at bottom of editor
" Show current command and mode
set laststatus=2 showcmd showmode
" https://stackoverflow.com/questions/9065941/how-can-i-change-vim-status-line-colour
" Show highlight test command > :so $VIMRUNTIME/syntax/hitest.vim

" Functions for getting git branch
function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" Formats the statusline
set statusline=
set statusline+=%{StatuslineGit()} " Calls function to get git branch
set statusline+=%f " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}] " file format
set statusline+=%y " filetype
set statusline+=%h " help file flag
set statusline+=[%{getbufvar(bufnr('%'),'&mod')?'modified':'saved'}] " modified flag
set statusline+=%r " read only flag
set statusline+=\ %= " align left
set statusline+=\ [%b][0x%B] " ASCII and byte code under cursor
set statusline+=Line:%l/%L[%p%%] " line X of Y [percent of file]
set statusline+=\ Col:%c " current column
set statusline+=\ Buf:%n " Buffer number
" }}}

" {{{ Filetype Specific Settings
" https://softwareengineering.stackexchange.com/questions/148677/why-is-80-characters-the-standard-limit-for-code-width
autocmd FileType c,haskell,sh,bash,zsh,tcsh,csh setlocal colorcolumn=81
autocmd FileType python setlocal colorcolumn=80

" https://lisp-lang.org/style-guide/
" https://google.github.io/styleguide/lispguide.xml
autocmd FileType lisp setlocal colorcolumn=100

" Settings for hardtabs
autocmd FileType c,sh,bash,zsh,tcsh,csh set tabstop=4 shiftwidth=4

" PEP 8, the style guide for python, specifies the use of
" spaces aka softtabs this is because they are morons
" Haskell compiler (GHC) is picky about whitespace
" using four spaces as a tab aka softtabs is generally safer and easier
" Settings for softtabs
autocmd FileType python,haskell set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" Softtabs two spaces wide
autocmd FileType json,lisp set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" }}}

" {{{ Terminal Settings
" Terminal feature is currently only available in neovim as far as I know
if has('nvim')
	" Remap <Esc> to exit terminal-mode
	tnoremap <Esc> <C-\><C-n>
endif
" }}}

" {{{ Plugins
" Disable netrw history (cuz it's really annoying)
let g:netrw_dirhistmax = 0
" Tree like listing
let g:netrw_liststyle = 3
" }}}

" {{{ My Custom Plugins
" Completion menu settings
" myacp.vim
" Use these completion settings for myacp.vim
" set completeopt=menu,menuone,noselect
" set complete=.,w,b,u,t
let g:myacp_enable_ft = get(g:, 'myacp_enable_ft', {}) " enable filetypes
let g:myacp_enable_tab = get(g:, 'myacp_enable_tab', 1) " remap tab
let g:myacp_min_length = get(g:, 'myacp_min_length', 2) " minimal length to open popup
let g:myacp_key_ignore = get(g:, 'myacp_key_ignore', []) " ignore keywords
" Enable for all files
let g:myacp_enable_ft = {'*':1}
" }}}
