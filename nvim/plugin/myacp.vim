" MyAutoCompletePopup
" mycp.vim - auto popup completion window
"
" Forked from https://github.com/skywind3000/vim-auto-popmenu
"
" - auto popup complete window without select the first one
" - tab/s-tab to cycle suggestions, <c-e> to cancel
" - use myacpEnable/myacpDisable to toggle for certiain file.
"
" Usage:
" set cpt=.,k,b
" set completeopt=menu,menuone,noselect
" let g:myacp_enable_ft = {'text':1, 'markdown':1, 'php':1}
" let g:myacp_enable_ft = get(g:, 'myacp_enable_ft', {})    " enable filetypes
" let g:myacp_enable_tab = get(g:, 'myacp_enable_tab', 1)   " remap tab
" let g:myacp_min_length = get(g:, 'myacp_min_length', 2)   " minimal length to open popup
" let g:myacp_key_ignore = get(g:, 'myacp_key_ignore', [])  " ignore keywords

" get word before cursor
function! s:get_context()
	return strpart(getline('.'), 0, col('.') - 1)
endfunc

function! s:meets_keyword(context)
	if g:myacp_min_length <= 0
		return 0
	endif
	let matches = matchlist(a:context, '\(\k\{' . g:myacp_min_length . ',}\)$')
	if empty(matches)
		return 0
	endif
	for ignore in g:myacp_key_ignore
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
	let enable = get(b:, 'myacp_enable', 0)
	let lastx = get(b:, 'myacp_lastx', -1)
	let lasty = get(b:, 'myacp_lasty', -1)
	let tick = get(b:, 'myacp_tick', -1)
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
		let b:myacp_lastx = x
		let b:myacp_lasty = y
		let b:myacp_tick = b:changedtick
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
		let b:myacp_lastx = x
		let b:myacp_lasty = y
		let b:myacp_tick = b:changedtick
	endif
	return 0
endfunc

" autocmd for CompleteDone
function! s:complete_done()
	let b:myacp_lastx = col('.') - 1
	let b:myacp_lasty = line('.') - 1
	let b:myacp_tick = b:changedtick
endfunc

" enable myacp
function! s:myacp_enable()
	call s:myacp_disable()
	augroup myacpEventGroup
		au!
		au CursorMovedI <buffer> nested call s:feed_popup()
		au CompleteDone <buffer> call s:complete_done()
	augroup END
	let b:myacp_init_autocmd = 1
	if g:myacp_enable_tab
		inoremap <silent><buffer><expr> <tab>
					\ pumvisible()? "\<c-n>" :
					\ <SID>check_back_space() ? "\<tab>" : "\<c-n>"
		inoremap <silent><buffer><expr> <s-tab>
					\ pumvisible()? "\<c-p>" : "\<s-tab>"
		let b:myacp_init_tab = 1
	endif
	if get(g:, 'myacp_cr_confirm', 0) == 0
		inoremap <silent><buffer><expr> <cr> 
					\ pumvisible()? "\<c-y>\<cr>" : "\<cr>"
	else
		inoremap <silent><buffer><expr> <cr> 
					\ pumvisible()? "\<c-y>" : "\<cr>"
	endif
	inoremap <silent><buffer><expr> <bs> <SID>on_backspace()
	let b:myacp_init_bs = 1
	let b:myacp_init_cr = 1
	let b:myacp_save_infer = &infercase
	setlocal infercase
	let b:myacp_enable = 1
endfunc

" disable myacp
function! s:myacp_disable()
	if get(b:, 'myacp_init_autocmd', 0)
		augroup myacpEventGroup
			au! 
		augroup END
	endif
	if get(b:, 'myacp_init_tab', 0)
		silent! iunmap <buffer><expr> <tab>
		silent! iunmap <buffer><expr> <s-tab>
	endif
	if get(b:, 'myacp_init_bs', 0)
		silent! iunmap <buffer><expr> <bs>
	endif
	if get(b:, 'myacp_init_cr', 0)
		silent! iunmap <buffer><expr> <cr>
	endif
	if get(b:, 'myacp_save_infer', '') != ''
		let &l:infercase = b:myacp_save_infer
	endif
	let b:myacp_init_autocmd = 0
	let b:myacp_init_tab = 0
	let b:myacp_init_bs = 0
	let b:myacp_init_cr = 0
	let b:myacp_save_infer = ''
	let b:myacp_enable = 0
endfunc

" check if need to be enabled
function! s:myacp_check_init()
	if &bt != ''
		return
	endif
	if get(g:myacp_enable_ft, &ft, 0) != 0
		MyCcpEnable
	elseif get(g:myacp_enable_ft, '*', 0) != 0
		MyAcpEnable
	elseif get(b:, 'myacp_enable', 0)
		MyAcpEnable
	endif
endfunc

" commands & autocmd
command! -nargs=0 MyAcpEnable call s:myacp_enable()
command! -nargs=0 MyAcpDisable call s:myacp_disable()

augroup myacpInitGroup
	au!
	au FileType * call s:myacp_check_init()
	au BufEnter * call s:myacp_check_init()
	au TabEnter * call s:myacp_check_init()
augroup END
