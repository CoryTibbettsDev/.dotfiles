" Many settings are different by default in nvim but I set them in case my
" config is used with vim
" https://dev.to/vonheikemen/how-many-lines-of-code-does-it-take-to-turn-vim-into-a-nice-editor-10ni
" UTS-8 character encoding pretty standard
set encoding=utf-8

" Stuff that needs to been set in vim but not nvim
if !has('nvim')
	set nocompatible
	set backspace=indent,eol,start
	set hidden
	set mouse=a
endif

" Detect filetype
filetype plugin indent on

" Title of window is name of file being edited
set title

" Enables line numbers and numbers relative to cursor position
set number
set relativenumber

" Allows for wrapping movement to next or previous line
" set whichwrap+=<,>,h,l,[,]

" Enable syntax highlighting and true color
syntax on

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

" Disable annoying features
" Disable creation of swap files
set noswapfile
set nobackup
set nowrap
set viminfo=
" Disable netrw history
let g:netrw_dirhistmax = 0

" How tabs are displayed and inserted
" Settings for hardtabs
set tabstop=4 shiftwidth=4
" Settings for softtabs
" set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab

" Automatically indents lines when you insert a new line :h smartindent
set cindent

" Case insensitive search and highlight
set incsearch ignorecase smartcase hlsearch

" Better command-line completion
set wildmenu
" Wildmenu will ignore certain things
" Ignore all variations of node_modules
set wildignore=**node_modules**

" Move window as you scroll
set scrolloff=11
set sidescrolloff=5

" Text folding :help folds
" Folds text inside {{{'}}} by default
set foldenable
set foldmethod=marker

" Re-read file when changes are made outside of vim
set autoread

" Highlight trailing whitespace
set list listchars=tab:>-,trail:.,extends:>

" Mappings
" View mappings
" :nmap - Display normal mode maps
" :imap - Display insert mode maps
" :vmap - Display visual and select mode maps
" :smap - Display select mode maps
" :xmap - Display visual mode maps
" :cmap - Display command-line mode maps
" :omap - Display operator pending mode maps
" Maps leader key to comma
let mapleader = ','

" I accidentally do :W instead of :w to save a lot
" Custom command to call lowercase w with uppercase W
command! W :w

nnoremap <leader>w :wq<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>r :source $MYVIMRC<CR>

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Rempaps for managing tabs
map tn :tabnew<Space>
map tk :tabnext<CR>
map tj :tabprev<CR>
map th :tabfirst<CR>
map tl :tablast<CR>

" Comment all selected lines in visual mode
" https://stackoverflow.com/questions/46893804/vimscript-mapping-for-commenting-visual-blocks
vnoremap <Leader>c :s/^/#/<bar>nohlsearch<cr>

" Insert c multiline comment like /* */
" Insert comment into normal mode move left 2 spaces into insert mode
inoremap <C-d> /*  */<ESC>2hi

" https://www.maketecheasier.com/turn-vim-word-processor/
" https://thepracticalsysadmin.com/using-vim-as-a-word-processor/
" :h formatoptions and :h fo-table
command! WP call WordProcessor()
function! WordProcessor()
	" movement changes
	map j gj
	map k gk
	" formatting text
	setlocal noexpandtab
	setlocal wrap
	setlocal linebreak
	set textwidth=80
	setlocal smartindent
	" Hard Wrap
	" setlocal formatoptions+=a
	" spelling and thesaurus
	setlocal spell spelllang=en_us
	" set thesaurus+=/home/test/.vim/thesaurus/mthesaur.txt
	" complete+=s makes autocompletion search the thesaurus
	" set complete+=s
endfunction

" Insert license header in file
" https://www.gilesorr.com/blog/vimscript-insert.html
command! License :call InsertLicense()
function! InsertLicense()
	let text = '/* See LICENSE for copyright and license details. */'
	" Append text to line 0 means insert on the first line
	let failed = append(0, text)
	if (failed)
		echo 'Unable to insert license text'
	else
		" Set buffer to modified
		let &modified = 1
	endif
endfunction

" Get highlight group of the word under cursor
" Use ctrl+shitf+p
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" Netrw file browser settings
" Tree like listing
let g:netrw_liststyle = 3

" Status Line
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
set statusline+=\ [%b][0x%B]\ " ASCII and byte code under cursor
set statusline+=Line:%l/%L[%p%%] " line X of Y [percent of file]
set statusline+=\ Col:%c " current column
set statusline+=\ Buf:%n " Buffer number

" Completion menu settings
set completeopt=menu,menuone,noselect
set complete=.,w,b,u,t
" myacp.vim
let g:myacp_enable_ft = get(g:, 'myacp_enable_ft', {})   " enable filetypes
let g:myacp_enable_tab = get(g:, 'myacp_enable_tab', 1)  " remap tab
let g:myacp_min_length = get(g:, 'myacp_min_length', 1)  " minimal length to open popup
let g:myacp_key_ignore = get(g:, 'myacp_key_ignore', []) " ignore keywords
" Enable for all files
let g:myacp_enable_ft = {'*':1}
