" =================================
" mycolorscheme.vim
" Color function based on onehalf
" https://github.com/sonph/onehalf
" =================================

" Setup: {{{
set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name="mycolorscheme"
" }}}

" Palette: {{{
let s:black = { "gui": "#24283b", "cterm": "235" }
let s:white = { "gui": "#ffffff", "cterm": "250" }
let s:darkgray1 = { "gui": "#06080a", "cterm": "237" }
let s:darkgray2 = { "gui": "#282d42", "cterm": "236" }
let s:darkgray3 = { "gui": "#2f344d", "cterm": "236" }
let s:darkgray4 = { "gui": "#333954", "cterm": "237" }
let s:darkgray4 = { "gui": "#3a405e", "cterm": "237" }
let s:bg_red = { "gui": "#ff7a93", "cterm": "203" }
let s:diff_red = { "gui": "#804d49", "cterm": "52" }
let s:bg_green = { "gui": "#b9f27c", "cterm": "107" }
let s:diff_green = { "gui": "#618041", "cterm": "22" }
let s:bg_blue = { "gui": "#7da6ff", "cterm": "110" }
let s:diff_blue = { "gui": "#3e5380", "cterm": "17" }
let s:red = { "gui": "#F7768E", "cterm": "203" }
let s:orange = { "gui": "#FF9E64", "cterm": "215" }
let s:yellow = { "gui": "#E0AF68", "cterm": "179" }
let s:green= { "gui": "#9ECE6A", "cterm": "107" }
let s:blue = { "gui": "#7AA2F7", "cterm": "110" }
let s:purple = { "gui": "#ad8ee6", "cterm": "176" }
let s:gray = { "gui": "#444B6A", "cterm": "246" }

let s:fg = s:white
let s:bg = s:darkgray2
let s:non_text = s:bg
let s:cursor_line = s:darkgray3
let s:selection = s:darkgray4
let s:comment_fg = s:purple
" }}}

" Color Function: {{{
function! s:hl(group, fg, bg, attr)
	if type(a:fg) == type({})
		exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm
	else
		exec "hi " . a:group . " guifg=NONE cterm=NONE"
	endif
	if type(a:bg) == type({})
		exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . a:bg.cterm
	else
		exec "hi " . a:group . " guibg=NONE ctermbg=NONE"
	endif
	if a:attr != ""
		exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
	else
		exec "hi " . a:group . " gui=NONE cterm=NONE"
	endif
endfun
" }}}

" User Interface Colors: {{{
call s:hl("Normal", s:fg, s:bg, "")

call s:hl("Cursor", s:bg, s:blue, "")
call s:hl("CursorColumn", "", s:cursor_line, "")
call s:hl("CursorLine", "", s:cursor_line, "")

call s:hl("LineNr", s:fg, s:bg, "")
call s:hl("CursorLineNr", s:fg, "", "")

call s:hl("IncSearch", s:bg, s:bg_red, "")
call s:hl("Search", s:bg, s:bg_green, "")

call s:hl("ErrorMsg", s:fg, "", "bold,underline")
call s:hl("ModeMsg", s:fg, "", "")
call s:hl("MoreMsg", s:fg, "", "")
call s:hl("WarningMsg", s:red, "", "")
call s:hl("Question", s:purple, "", "")

call s:hl("Pmenu", s:fg, s:black, "")
call s:hl("PmenuSel", s:black, s:blue, "")
call s:hl("PmenuSbar", "", s:selection, "")
call s:hl("PmenuThumb", "", s:fg, "")

call s:hl("SpellBad", s:red, "", "")
call s:hl("SpellCap", s:yellow, "", "")
call s:hl("SpellLocal", s:yellow, "", "")
call s:hl("SpellRare", s:yellow, "", "")

call s:hl("StatusLine", s:fg, s:bg, "")
call s:hl("StatusLineNC", s:comment_fg, s:cursor_line, "")
call s:hl("TabLine", s:comment_fg, s:cursor_line, "")
call s:hl("TabLineFill", s:comment_fg, s:cursor_line, "")
call s:hl("TabLineSel", s:fg, s:bg, "")

call s:hl("Visual", "", s:selection, "")
call s:hl("VisualNOS", "", s:selection, "")

call s:hl("ColorColumn", "", s:darkgray3, "")
call s:hl("Conceal", s:fg, "", "")
call s:hl("Directory", s:blue, "", "")
call s:hl("VertSplit", s:darkgray4, s:darkgray4, "")
call s:hl("Folded", s:fg, "", "")
call s:hl("FoldColumn", s:fg, "", "")
call s:hl("SignColumn", s:fg, "", "")

call s:hl("MatchParen", s:blue, "", "underline")
call s:hl("SpecialKey", s:fg, "", "")
call s:hl("Title", s:green, "", "")
call s:hl("WildMenu", s:fg, "", "")

call s:hl("DiffAdd", s:green, "", "")
call s:hl("DiffChange", s:yellow, "", "")
call s:hl("DiffDelete", s:red, "", "")
call s:hl("DiffText", s:blue, "", "")
" }}}

" Syntax Colors: {{{
" Whitespace is defined in Neovim, not Vim.
" See :help hl-Whitespace and :help hl-SpecialKey
call s:hl("Whitespae", s:non_text, "", "")
call s:hl("NonText", s:non_text, "", "")
call s:hl("Comment", s:comment_fg, "", "italic")
call s:hl("Constant", s:blue, "", "")
call s:hl("String", s:green, "", "")
call s:hl("Character", s:green, "", "")
call s:hl("Number", s:yellow, "", "")
call s:hl("Boolean", s:yellow, "", "")
call s:hl("Float", s:yellow, "", "")

call s:hl("Identifier", s:red, "", "")
call s:hl("Function", s:blue, "", "")
call s:hl("Statement", s:purple, "", "")

call s:hl("Conditional", s:purple, "", "")
call s:hl("Repeat", s:purple, "", "")
call s:hl("Label", s:purple, "", "")
call s:hl("Operator", s:fg, "", "")
call s:hl("Keyword", s:red, "", "")
call s:hl("Exception", s:purple, "", "")

call s:hl("PreProc", s:yellow, "", "")
call s:hl("Include", s:purple, "", "")
call s:hl("Define", s:purple, "", "")
call s:hl("Macro", s:purple, "", "")
call s:hl("PreCondit", s:yellow, "", "")

call s:hl("Type", s:yellow, "", "")
call s:hl("StorageClass", s:yellow, "", "")
call s:hl("Structure", s:yellow, "", "")
call s:hl("Typedef", s:yellow, "", "")

call s:hl("Special", s:blue, "", "")
call s:hl("SpecialChar", s:fg, "", "")
call s:hl("Tag", s:fg, "", "")
call s:hl("Delimiter", s:fg, "", "")
call s:hl("SpecialComment", s:fg, "", "")
call s:hl("Debug", s:fg, "", "")
call s:hl("Underlined", s:fg, "", "")
call s:hl("Ignore", s:fg, "", "")
call s:hl("Error", s:red, s:bg, "")
call s:hl("Todo", s:purple, "", "")
" }}}

" Fix colors in neovim terminal buffers {{{
if has('nvim')
	let g:terminal_color_0 = s:black.gui
	let g:terminal_color_1 = s:red.gui
	let g:terminal_color_2 = s:green.gui
	let g:terminal_color_3 = s:yellow.gui
	let g:terminal_color_4 = s:blue.gui
	let g:terminal_color_5 = s:purple.gui
	let g:terminal_color_6 = s:blue.gui
	let g:terminal_color_7 = s:white.gui
	let g:terminal_color_8 = s:black.gui
	let g:terminal_color_9 = s:red.gui
	let g:terminal_color_10 = s:green.gui
	let g:terminal_color_11 = s:yellow.gui
	let g:terminal_color_12 = s:blue.gui
	let g:terminal_color_13 = s:purple.gui
	let g:terminal_color_14 = s:blue.gui
	let g:terminal_color_15 = s:white.gui
	let g:terminal_color_background = s:bg.gui
	let g:terminal_color_foreground = s:fg.gui
endif
" }}}
