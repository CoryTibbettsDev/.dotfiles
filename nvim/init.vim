" I accidentally do :W instead of :w to save a lot
" Custom command to call lowercase w with uppercase W
command! W :w

" Detect filetype
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Enable true color support
set termguicolors

" Disable annoying features
" Disable creation of swap files
set noswapfile
" Disable netrw history
let g:netrw_dirhistmax = 0

" Highlight trailing whitespace
" set list listchars=tab:>-,trail:.,extends:>

" How tabs are displayed and inserted
" Settings for hardtabs
set shiftwidth=4 tabstop=4
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

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Rempaps for managing tabs
map tn :tabnew<Space>
map tk :tabnext<CR>
map tj :tabprev<CR>
map th :tabfirst<CR>
map tl :tablast<CR>

" Allows for wrapping movement to next or previous line
set whichwrap+=<,>,h,l,[,]
" remap shift-enter to fire up the sidebar
nnoremap <silent> <S-CR> :rightbelow 20vs<CR>:e .<CR>
" the same remap as above - may be necessary in some distros
nnoremap <silent> <C-M> :rightbelow 20vs<CR>:e .<CR>
" remap control-enter to open files in new tab
nmap <silent> <C-CR> t :rightbelow 20vs<CR>:e .<CR>:wincmd h<CR>
" the same remap as above - may be necessary in some distros
nmap <silent> <NL> t :rightbelow 20vs<CR>:e .<CR>:wincmd h<CR>

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
hi NormalColor guibg=#665c54 guifg=#ebdbb2
hi InsertColor guibg=#b8bb26 guifg=#504945
hi ReplaceColor guibg=#fb4934 guifg=#504945
hi VisualColor  guibg=#8ec07c guifg=#504945

" StatusLine starting colors
hi StatusLine guibg=white guifg=DarkSlateGray
" Colors of the non current statusline
" (the one that's not focused)
hi StatusLine guibg=white guifg=Blue
" Formats the statusline
set statusline=
" Output Mode and color it with the colors set earlier
" Does not work correctly with visual block :h mode() for reference
set statusline+=%#NormalColor#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#InsertColor#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#ReplaceColor#%{(mode()=='R')?'\ \ REPLACE\ ':''}
set statusline+=%#VisualColor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#NormalColor#%{(mode()=='c')?'\ \ COMMAND\ ':''}
set statusline+=%#NormalColor#%{(mode()=='f')?'\ \ FINDER\ ':''}

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

" Completion
" Cuztomize color of popup menu
" https://vi.stackexchange.com/questions/12664/is-there-any-way-to-change-the-popup-menu-color
" NOTE: gui colors are used here because I have termguicolors on
" :help guibg or ctermbg for color info
" Normal item
hi Pmenu guibg=DarkSlateGray ctermbg=0
" Selected item
hi PmenuSel guibg=SlateBlue ctermbg=4
" Scollbar
hi PmenuSbar guibg=black ctermbg=0
" Thumb of scrollbar
hi PmenuThumb guibg=gray ctermbg=7

" Automatically call autocomplete popup
" https://github.com/skywind3000/vim-auto-popmenu
" Created by skywind on 2020/03/05
" Last Modified: 2020/03/09 20:28
"
" Features:
"
" - auto popup complete window without select the first one
" - tab/s-tab to cycle suggestions, <c-e> to cancel
" - use ApcEnable/ApcDisable to toggle for certiain file.
"
" Usage:
"
" Don't select first item automatically need for usability trust me
set completeopt=menu,menuone,noselect
" Source for dictionary, current or other loaded buffers, see ":help cpt'
" set cpt=.,k,b
" Enable for all file types
let g:apc_enable_ft = {'*':1}
" Enable for some filetypes
" let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1}

let g:apc_enable_ft = get(g:, 'apc_enable_ft', {})    " enable filetypes
let g:apc_enable_tab = get(g:, 'apc_enable_tab', 1)   " remap tab
let g:apc_min_length = get(g:, 'apc_min_length', 2)   " minimal length to open popup
let g:apc_key_ignore = get(g:, 'apc_key_ignore', [])  " ignore keywords

" get word before cursor
function! s:get_context()
	return strpart(getline('.'), 0, col('.') - 1)
endfunc

function! s:meets_keyword(context)
	if g:apc_min_length <= 0
		return 0
	endif
	let matches = matchlist(a:context, '\(\k\{' . g:apc_min_length . ',}\)$')
	if empty(matches)
		return 0
	endif
	for ignore in g:apc_key_ignore
		if stridx(ignore, matches[1]) == 0
			return 0
		endif
	endfor
	return 1
endfunc

function! s:check_back_space() abort
	  return col('.') < 2 || getline('.')[col('.') - 2]  =~# '\s'
endfunc

function! s:on_backspace()
	if pumvisible() == 0
		return "\<BS>"
	endif
	let text = matchstr(s:get_context(), '.*\ze.')
	return s:meets_keyword(text)? "\<BS>" : "\<c-e>\<bs>"
endfunc


" autocmd for CursorMovedI
function! s:feed_popup()
	let enable = get(b:, 'apc_enable', 0)
	let lastx = get(b:, 'apc_lastx', -1)
	let lasty = get(b:, 'apc_lasty', -1)
	let tick = get(b:, 'apc_tick', -1)
	if &bt != '' || enable == 0 || &paste
		return -1
	endif
	let x = col('.') - 1
	let y = line('.') - 1
	if pumvisible()
		let context = s:get_context()
		if s:meets_keyword(context) == 0
			call feedkeys("\<c-e>", 'n')
		endif
		let b:apc_lastx = x
		let b:apc_lasty = y
		let b:apc_tick = b:changedtick
		return 0
	elseif lastx == x && lasty == y
		return -2
	elseif b:changedtick == tick
		let lastx = x
		let lasty = y
		return -3
	endif
	let context = s:get_context()
	if s:meets_keyword(context)
		silent! call feedkeys("\<c-n>", 'n')
		let b:apc_lastx = x
		let b:apc_lasty = y
		let b:apc_tick = b:changedtick
	endif
	return 0
endfunc

" autocmd for CompleteDone
function! s:complete_done()
	let b:apc_lastx = col('.') - 1
	let b:apc_lasty = line('.') - 1
	let b:apc_tick = b:changedtick
endfunc

" enable apc
function! s:apc_enable()
	call s:apc_disable()
	augroup ApcEventGroup
		au!
		au CursorMovedI <buffer> nested call s:feed_popup()
		au CompleteDone <buffer> call s:complete_done()
	augroup END
	let b:apc_init_autocmd = 1
	if g:apc_enable_tab
		inoremap <silent><buffer><expr> <tab>
					\ pumvisible()? "\<c-n>" :
					\ <SID>check_back_space() ? "\<tab>" : "\<c-n>"
		inoremap <silent><buffer><expr> <s-tab>
					\ pumvisible()? "\<c-p>" : "\<s-tab>"
		let b:apc_init_tab = 1
	endif
	inoremap <silent><buffer><expr> <cr> pumvisible()? "\<c-y>\<cr>" : "\<cr>"
	inoremap <silent><buffer><expr> <bs> <SID>on_backspace()
	let b:apc_init_bs = 1
	let b:apc_init_cr = 1
	let b:apc_save_infer = &infercase
	setlocal infercase
	let b:apc_enable = 1
endfunc

" disable apc
function! s:apc_disable()
	if get(b:, 'apc_init_autocmd', 0)
		augroup ApcEventGroup
			au! 
		augroup END
	endif
	if get(b:, 'apc_init_tab', 0)
		silent! iunmap <buffer><expr> <tab>
		silent! iunmap <buffer><expr> <s-tab>
	endif
	if get(b:, 'apc_init_bs', 0)
		silent! iunmap <buffer><expr> <bs>
	endif
	if get(b:, 'apc_init_cr', 0)
		silent! iunmap <buffer><expr> <cr>
	endif
	if get(b:, 'apc_save_infer', '') != ''
		let &l:infercase = b:apc_save_infer
	endif
	let b:apc_init_autocmd = 0
	let b:apc_init_tab = 0
	let b:apc_init_bs = 0
	let b:apc_init_cr = 0
	let b:apc_save_infer = ''
	let b:apc_enable = 0
endfunc

" check if need to be enabled
function! s:apc_check_init()
	if &bt == '' && get(g:apc_enable_ft, &ft, 0) != 0
		ApcEnable
	elseif &bt == '' && get(g:apc_enable_ft, '*', 0) != 0
		ApcEnable
	endif
endfunc

" commands & autocmd
command! -nargs=0 ApcEnable call s:apc_enable()
command! -nargs=0 ApcDisable call s:apc_disable()

augroup ApcInitGroup
	au!
	au FileType * call s:apc_check_init()
augroup END
