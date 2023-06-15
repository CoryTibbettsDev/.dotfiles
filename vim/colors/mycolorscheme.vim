" Color function based on onehalf
" https://github.com/sonph/onehalf

" Setup: {{{
set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name="mycolorscheme"
" }}}

" Palette: {{{
let s:white = { "gui": "#ffffff", "cterm": "15" }
let s:black = { "gui": "#000000", "cterm": "0" }

let s:dark = { "gui": "#282C34", "cterm": "0" }
let s:darkgray = { "gui": "#323232", "cterm": "8" }
let s:lightgray = { "gui": "#afafaf", "cterm": "7" }

let s:blue = { "gui": "#7AA3F7", "cterm": "33" }
let s:green = { "gui": "#9ECE6A", "cterm": "64" }
let s:red = { "gui": "#F7768E", "cterm": "160" }
let s:yellow = { "gui": "#E0AF68", "cterm": "136" }
let s:orange = { "gui": "#cb4b16", "cterm": "166" }
let s:magenta = { "gui": "#9a7ecc", "cterm": "125" }
let s:violet = { "gui": "#6c71c4", "cterm": "61" }
let s:cyan = { "gui": "#4abaaf", "cterm": "37" }

let s:bg = s:dark
let s:bg2 = s:darkgray
let s:fg = s:white
let s:fg2 = s:lightgray

let s:warmaccent = s:red
let s:warmaccent2 = s:yellow
let s:warmaccent3 = s:orange
let s:warmaccent4 = s:magenta
let s:coldaccent = s:blue
let s:coldaccent2 = s:violet
let s:coldaccent3 = s:green
let s:coldaccent4 = s:cyan
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

call s:hl("Cursor", s:bg, s:coldaccent, "")
call s:hl("CursorColumn", "", s:bg2, "")
call s:hl("CursorLine", "", s:bg2, "")

call s:hl("LineNr", s:fg, s:bg2, "")
call s:hl("CursorLineNr", s:fg2, "", "")

call s:hl("IncSearch", s:bg, s:warmaccent, "")
call s:hl("Search", s:bg, s:coldaccent3, "")

call s:hl("ErrorMsg", s:fg, "", "bold,underline")
call s:hl("ModeMsg", s:fg, "", "")
call s:hl("MoreMsg", s:fg, "", "")
call s:hl("WarningMsg", s:warmaccent, "", "")
call s:hl("Question", s:coldaccent2, "", "")

call s:hl("Pmenu", s:fg, s:bg, "")
call s:hl("PmenuSel", s:bg2, s:coldaccent2, "")
call s:hl("PmenuSbar", s:bg2, s:fg2, "")
call s:hl("PmenuThumb", s:bg, s:fg, "")

call s:hl("SpellBad", s:warmaccent, "", "")
call s:hl("SpellCap", s:warmaccent2, "", "")
call s:hl("SpellLocal", s:warmaccent2, "", "")
call s:hl("SpellRare", s:warmaccent2, "", "")

call s:hl("StatusLine", s:fg, s:bg2, "")
call s:hl("StatusLineNC", s:fg, s:bg, "")
call s:hl("TabLine", s:fg2, s:bg2, "")
call s:hl("TabLineFill", s:fg2, s:bg2, "")
call s:hl("TabLineSel", s:fg, s:bg, "")

call s:hl("Visual", s:bg2, s:fg2, "")
call s:hl("VisualNOS", s:bg2, s:fg2, "")

call s:hl("ColorColumn", "", s:bg2, "")
call s:hl("Conceal", s:fg, "", "")
call s:hl("Directory", s:coldaccent, "", "")
call s:hl("VertSplit", s:bg2, s:bg2, "")
call s:hl("Folded", s:fg, "", "")
call s:hl("FoldColumn", s:fg, "", "")
call s:hl("SignColumn", s:fg, "", "")

call s:hl("MatchParen", s:coldaccent, "", "underline")
call s:hl("SpecialKey", s:fg, "", "")
call s:hl("Title", s:coldaccent3, "", "")
call s:hl("WildMenu", s:fg, "", "")

call s:hl("DiffAdd", s:coldaccent3, "", "")
call s:hl("DiffChange", s:warmaccent2, "", "")
call s:hl("DiffDelete", s:warmaccent, "", "")
call s:hl("DiffText", s:coldaccent, "", "")
" }}}

" Syntax Colors: {{{
" Whitespace is defined in Neovim, not Vim.
" See :help hl-Whitespace and :help hl-SpecialKey
call s:hl("Whitespae", s:bg, "", "")
" Whitespace tab characters and spaces
call s:hl("NonText", s:black, "", "")
call s:hl("Comment", s:coldaccent2, "", "italic")
call s:hl("Constant", s:coldaccent, "", "")
call s:hl("String", s:coldaccent3, "", "")
call s:hl("Character", s:coldaccent3, "", "")
call s:hl("Number", s:warmaccent2, "", "")
call s:hl("Boolean", s:warmaccent2, "", "")
call s:hl("Float", s:warmaccent2, "", "")

call s:hl("Identifier", s:warmaccent, "", "")
call s:hl("Function", s:coldaccent, "", "")
call s:hl("Statement", s:coldaccent2, "", "")

call s:hl("Conditional", s:coldaccent2, "", "")
call s:hl("Repeat", s:coldaccent2, "", "")
call s:hl("Label", s:coldaccent2, "", "")
call s:hl("Operator", s:fg, "", "")
call s:hl("Keyword", s:warmaccent, "", "")
call s:hl("Exception", s:coldaccent2, "", "")

call s:hl("PreProc", s:warmaccent2, "", "")
call s:hl("Include", s:coldaccent2, "", "")
call s:hl("Define", s:coldaccent2, "", "")
call s:hl("Macro", s:coldaccent2, "", "")
call s:hl("PreCondit", s:warmaccent2, "", "")

call s:hl("Type", s:warmaccent2, "", "")
call s:hl("StorageClass", s:warmaccent2, "", "")
call s:hl("Structure", s:warmaccent2, "", "")
call s:hl("Typedef", s:warmaccent2, "", "")

call s:hl("Special", s:coldaccent, "", "")
call s:hl("SpecialChar", s:fg, "", "")
call s:hl("Tag", s:fg, "", "")
call s:hl("Delimiter", s:fg, "", "")
call s:hl("SpecialComment", s:fg, "", "")
call s:hl("Debug", s:fg, "", "")
call s:hl("Underlined", s:fg, "", "")
call s:hl("Ignore", s:fg, "", "")
call s:hl("Error", s:warmaccent, s:bg, "")
call s:hl("Todo", s:coldaccent2, "", "")
" }}}

" Fix Colors In Neovim Terminal Buffers {{{
if has('nvim')
	let g:terminal_color_0 = s:bg2.gui
	let g:terminal_color_1 = s:warmaccent.gui
	let g:terminal_color_2 = s:coldaccent3.gui
	let g:terminal_color_3 = s:warmaccent2.gui
	let g:terminal_color_4 = s:coldaccent.gui
	let g:terminal_color_5 = s:coldaccent2.gui
	let g:terminal_color_6 = s:coldaccent.gui
	let g:terminal_color_7 = s:fg.gui
	let g:terminal_color_8 = s:bg.gui
	let g:terminal_color_9 = s:warmaccent.gui
	let g:terminal_color_10 = s:coldaccent3.gui
	let g:terminal_color_11 = s:warmaccent2.gui
	let g:terminal_color_12 = s:coldaccent.gui
	let g:terminal_color_13 = s:coldaccent2.gui
	let g:terminal_color_14 = s:coldaccent.gui
	let g:terminal_color_15 = s:fg.gui
	let g:terminal_color_background = s:bg.gui
	let g:terminal_color_foreground = s:fg.gui
endif
" }}}
