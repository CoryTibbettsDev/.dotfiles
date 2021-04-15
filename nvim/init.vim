" I accidentally do :W instead of :w to save a lot
" Custom command to call lowercase w with uppercase W
command! W :w

" Detect filetype
filetype plugin indent on

" Colors
" Enable syntax highlighting
syntax on

" :h xterm-true-color
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

try
	colorscheme mycolorscheme
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme default
	set background=dark
endtry

" Get highlight group of the word under cursor
" Use ctrl+shitf+p
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" Text folding :help folds
" Folds text inside {{{'}}} by default
set foldenable
set foldmethod=marker

" Disable annoying features
" Disable creation of swap files
set noswapfile
" Disable netrw history
let g:netrw_dirhistmax = 0

" Highlight trailing whitespace
set list listchars=tab:>-,trail:.,extends:>

" How tabs are displayed and inserted
" Settings for hardtabs
set tabstop=4 shiftwidth=4
" Settings for softtabs
" set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab

" Vertical line showing end of the line
" set colorcolumn=80

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

" Allows wrapping of text if window too small
set wrap breakindent

" Move window as you scroll instead of going all the way to the bottom
set scrolloff=11

" UTS-8 character encoding pretty standard
set encoding=utf-8

" Enables line numbers and numbers relative to cursor position
set number
set relativenumber

set title

" Allows for wrapping movement to next or previous line
set whichwrap+=<,>,h,l,[,]

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Rempaps for managing tabs
map tn :tabnew<Space>
map tk :tabnext<CR>
map tj :tabprev<CR>
map th :tabfirst<CR>
map tl :tablast<CR>

"" remap shift-enter to fire up the sidebar
"nnoremap <silent> <S-CR> :rightbelow 20vs<CR>:e .<CR>
"" the same remap as above - may be necessary in some distros
"nnoremap <silent> <C-M> :rightbelow 20vs<CR>:e .<CR>
"" remap control-enter to open files in new tab
"nmap <silent> <C-CR> t :rightbelow 20vs<CR>:e .<CR>:wincmd h<CR>
"" the same remap as above - may be necessary in some distros
"nmap <silent> <NL> t :rightbelow 20vs<CR>:e .<CR>:wincmd h<CR>

" Netrw file browser settings
" Tree like listing
let g:netrw_liststyle = 3

" Satus Line
" Shows two line status bar at bottom of editor
" Show current command and mode
set ruler laststatus=2 showcmd showmode
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

" https://stackoverflow.com/questions/48271865/vim-whats-the-best-way-to-set-statusline-color-to-change-based-on-mode
" Formats the statusline
set statusline=
set statusline+=%{StatuslineGit()} " Calls function to get git branch
set statusline+=%f " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}] " file format
set statusline+=%y " filetype
set statusline+=%h " help file flag
set statusline+=[%{getbufvar(bufnr('%'),'&mod')?'modified':'saved'}] "modified flag
set statusline+=%r " read only flag
set statusline+=\ %= " align left
set statusline+=\ [%b][0x%B]\ " ASCII and byte code under cursor
set statusline+=Line:%l/%L[%p%%] " line X of Y [percent of file]
set statusline+=\ Col:%c " current column
set statusline+=\ Buf:%n " Buffer number

set completeopt=menu,menuone,noselect
set complete=.,w,b,u,t
" myacp.vim
let g:myacp_enable_ft = get(g:, 'myacp_enable_ft', {})    " enable filetypes
let g:myacp_enable_tab = get(g:, 'myacp_enable_tab', 1)   " remap tab
let g:myacp_min_length = get(g:, 'myacp_min_length', 2)   " minimal length to open popup
let g:myacp_key_ignore = get(g:, 'myacp_key_ignore', [])  " ignore keywords
" Enable for all files
let g:myacp_enable_ft = {'*':1}
