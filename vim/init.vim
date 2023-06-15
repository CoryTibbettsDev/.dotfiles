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
	" Remember unloaded buffers
	set hidden
endif
" }}}

" {{{ Disable Annoying Features
set nowrap
" Modelines have historically been a source of security vulnerabilities
set nomodeline
" Disable creation of various data files
set noswapfile
set nobackup
if has('nvim')
	set shada=
	set shadafile=
else
	set viminfo=
	set viminfofile=
endif
" }}}

" {{{ Basic Settings
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
nnoremap <leader>w :w<CR>:make<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>e :e $MYVIMRC<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
" Open netrw
nnoremap <leader>f :Ex<CR>

" xclip is needed for paste and yank with system clipboard
" For some reason leader key with this binding is slow but not with control
" Paste from system clipboard
nnoremap <C-p> "+p
" Yank into system clipboard
nnoremap <C-y> "+y

" Insert <br  /> for markdown line breaks
nnoremap <leader>b a<br  /><Esc>

nnoremap <leader>m :make<CR>
nnoremap <leader>t :make test<CR>

" Quickfix list shortcuts
" https://github.com/tpope/vim-unimpaired
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>

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
" Insert c multiline block style comment
" Trailing space is necessary don't delete
noremap <Leader>d i/*<CR><CR>/<ESC>ka 

" Insert groff defined string(variable) \*[name]
inoremap <C-g> \*[
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
" set statusline+=\ [%b][0x%B] " ASCII and byte code under cursor
set statusline+=Col:%c " current column
set statusline+=\ Line:%l/%L[%p%%] " line X of Y [percent of file]
" set statusline+=\ Buf:%n " Buffer number
" }}}

" {{{ Formatting Options
" How tabs are displayed and inserted
" Settings for hardtabs
set tabstop=4 shiftwidth=4 noexpandtab
" Automatically indents lines when you insert a new line :h smartindent
set smartindent
" https://softwareengineering.stackexchange.com/questions/148677/why-is-80-characters-the-standard-limit-for-code-width
set colorcolumn=81
" }}}

" {{{ Filetype Specific Formatting Options
" Python does not want lines to exceed 79 characters instead of the normal 80
autocmd FileType python setlocal colorcolumn=80

" https://lisp-lang.org/style-guide/
" https://google.github.io/styleguide/lispguide.xml
autocmd FileType lisp setlocal colorcolumn=100

" Makefiles require tab characters/hardtabs to be used
autocmd FileType make setlocal tabstop=4 shiftwidth=4 noexpandtab

" PEP 8, the style guide for python, specifies the use of
" spaces aka softtabs this is because they are morons
" Haskell compiler (GHC) is picky about whitespace
" using four spaces as a tab aka softtabs is generally safer and easier
" Settings for softtabs
autocmd FileType python,haskell setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" Softtabs two spaces wide
autocmd FileType json,lisp setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" }}}

" {{{ Terminal Settings
" Terminal feature is currently only available in neovim as far as I know
if has('nvim')
	" Remap <Esc> to exit terminal-mode
	tnoremap <Esc> <C-\><C-n>
endif
" }}}

" {{{ Writing
" https://gist.github.com/sjl/1038710
" https://gist.github.com/vim-voom/1035030
func! Foldexpr_markdown(lnum)
	let l1 = getline(a:lnum)

	if l1 =~ '^\s*$'
		" ignore empty lines
		return '='
	endif

	let l2 = getline(a:lnum+1)

	if l2 =~ '^==\+\s*'
		" next line is underlined (level 1)
		return '>1'
	elseif l2 =~ '^--\+\s*'
		" next line is underlined (level 2)
		return '>2'
	elseif l1 =~ '^#'
		" current line starts with hashes
		return '>'.matchend(l1, '^#\+')
	elseif a:lnum == 1
		" fold any 'preamble'
		return '>1'
	else
		" keep previous foldlevel
		return '='
	endif
endfunc

" :h formatoptions and :h fo-table
command! WM call WritingMode()
function! WritingMode()
	setlocal spell spelllang=en_us
	" set thesaurus+=/home/test/.vim/thesaurus/mthesaur.txt
	" complete+=s makes autocompletion search the thesaurus
	" set complete+=s
	setlocal textwidth=80

	if &filetype == "markdown"
		setlocal foldexpr=Foldexpr_markdown(v:lnum)
		setlocal foldmethod=expr
	endif
	" see ':help fold-options' for more
	setlocal foldenable
	setlocal foldlevel=0
	setlocal foldcolumn=0
	" Shows the first line as is, plus fold level and the number of hidden lines
	" setlocal foldtext=getline(v:foldstart).'\ Level:\ '.v:foldlevel.'\ Lines:\ '.(v:foldend-v:foldstart)
endfunction
" }}}

" {{{ Plugins
" Disable netrw history (cuz it's really annoying)
let g:netrw_dirhistmax = 0

" vim-plug
" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'https://github.com/jpalardy/vim-slime'
call plug#end()

" vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
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
