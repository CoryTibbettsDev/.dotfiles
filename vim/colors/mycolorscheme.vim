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

let s:almostblack = { "gui": "#0f0f0f", "cterm": "8" }
let s:darkgray = { "gui": "#1c1c1c", "cterm": "8" }
let s:lightgray = { "gui": "#5b5b5b", "cterm": "7" }

" These colors are exactly the named color not stylized versions
let s:red = { "gui": "#fc0000", "cterm": "160" }
let s:blue = { "gui": "#0000fc", "cterm": "33" }
let s:green = { "gui": "#00fc00", "cterm": "33" }
let s:yellow = { "gui": "#ECD803", "cterm": "136" }

let s:lightblue = { "gui": "#7AA3F7", "cterm": "33" }
let s:niceblue = { "gui": "#035899", "cterm": "33" }
let s:darkgreen = { "gui": "#117520", "cterm": "37" }
let s:orange = { "gui": "#cb4b16", "cterm": "166" }
let s:magenta = { "gui": "#9a7ecc", "cterm": "125" }
let s:violet = { "gui": "#6c71c4", "cterm": "61" }
let s:cyan = { "gui": "#4abaaf", "cterm": "37" }

let s:bg = s:darkgray
let s:bg2 = s:almostblack
let s:fg = s:white
let s:fg2 = s:lightgray

let s:warm = s:orange
let s:warm2 = s:lightblue
let s:warm3 = s:orange
let s:cold = s:niceblue
let s:cold2 = s:violet
let s:cold3 = s:cyan

" Highlight group for statusline colors
highlight MyModeColor guifg=s:fg guibg=s:bg2
highlight MyStatusColor guifg=s:fg guibg=s:gray
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

call s:hl("Cursor", s:bg, s:cold, "")
call s:hl("CursorColumn", "", s:bg2, "")
call s:hl("CursorLine", "", s:bg2, "")

call s:hl("LineNr", s:fg, s:bg2, "")
call s:hl("CursorLineNr", s:fg2, "", "")

call s:hl("IncSearch", s:bg, s:warm, "")

call s:hl("ErrorMsg", s:fg, "", "bold,underline")
call s:hl("ModeMsg", s:fg, "", "")
call s:hl("MoreMsg", s:fg, "", "")
call s:hl("WarningMsg", s:warm, "", "")
call s:hl("Question", s:cold2, "", "")

call s:hl("Pmenu", s:fg, s:bg, "")
call s:hl("PmenuSel", s:bg2, s:cold2, "")
call s:hl("PmenuSbar", s:bg2, s:fg2, "")
call s:hl("PmenuThumb", s:bg, s:fg, "")

call s:hl("SpellBad", s:warm, "", "")
call s:hl("SpellCap", s:warm2, "", "")
call s:hl("SpellLocal", s:warm2, "", "")
call s:hl("SpellRare", s:warm2, "", "")

call s:hl("StatusLine", s:fg, s:bg2, "")
call s:hl("StatusLineNC", s:fg, s:bg, "")
call s:hl("TabLine", s:fg2, s:bg2, "")
call s:hl("TabLineFill", s:fg2, s:bg2, "")
call s:hl("TabLineSel", s:fg, s:bg, "")

call s:hl("Visual", s:bg2, s:fg2, "")
call s:hl("VisualNOS", s:bg2, s:fg2, "")

call s:hl("ColorColumn", "", s:bg2, "")
call s:hl("Conceal", s:fg, "", "")
call s:hl("Directory", s:cold, "", "")
call s:hl("VertSplit", s:bg2, s:bg2, "")
call s:hl("Folded", s:fg, "", "")
call s:hl("FoldColumn", s:fg, "", "")
call s:hl("SignColumn", s:fg, "", "")

call s:hl("MatchParen", s:cold, "", "underline")
call s:hl("SpecialKey", s:fg, "", "")
call s:hl("Title", s:cold3, "", "")
call s:hl("WildMenu", s:fg, "", "")

call s:hl("DiffAdd", s:cold3, "", "")
call s:hl("DiffChange", s:warm2, "", "")
call s:hl("DiffDelete", s:warm, "", "")
call s:hl("DiffText", s:cold, "", "")
" }}}

" Syntax Colors: {{{
" Whitespace is defined in Neovim, not Vim.
" See :help hl-Whitespace and :help hl-SpecialKey
call s:hl("Whitespae", s:bg, "", "")
" Whitespace tab characters and spaces
call s:hl("NonText", s:black, "", "")
call s:hl("Comment", s:cold2, "", "italic")
call s:hl("Constant", s:cold, "", "")
call s:hl("String", s:cold3, "", "")
call s:hl("Character", s:cold3, "", "")
call s:hl("Number", s:warm2, "", "")
call s:hl("Boolean", s:warm2, "", "")
call s:hl("Float", s:warm2, "", "")

call s:hl("Identifier", s:warm, "", "")
call s:hl("Function", s:cold, "", "")
call s:hl("Statement", s:cold2, "", "")

call s:hl("Conditional", s:cold2, "", "")
call s:hl("Repeat", s:cold2, "", "")
call s:hl("Label", s:cold2, "", "")
call s:hl("Operator", s:fg, "", "")
call s:hl("Keyword", s:warm, "", "")
call s:hl("Exception", s:cold2, "", "")

call s:hl("PreProc", s:warm2, "", "")
call s:hl("Include", s:cold2, "", "")
call s:hl("Define", s:cold2, "", "")
call s:hl("Macro", s:cold2, "", "")
call s:hl("PreCondit", s:warm2, "", "")

call s:hl("Type", s:warm2, "", "")
call s:hl("StorageClass", s:warm2, "", "")
call s:hl("Structure", s:warm2, "", "")
call s:hl("Typedef", s:warm2, "", "")

call s:hl("Special", s:cold, "", "")
call s:hl("SpecialChar", s:fg, "", "")
call s:hl("Tag", s:fg, "", "")
call s:hl("Delimiter", s:fg, "", "")
call s:hl("SpecialComment", s:fg, "", "")
call s:hl("Debug", s:fg, "", "")
call s:hl("Underlined", s:fg, "", "")
call s:hl("Ignore", s:fg, "", "")
call s:hl("Error", s:warm, s:bg, "")
call s:hl("Todo", s:cold2, "", "")
" }}}

" Fix Colors In Neovim Terminal Buffers {{{
if has('nvim')
	let g:terminal_color_0 = s:bg2.gui
	let g:terminal_color_1 = s:warm.gui
	let g:terminal_color_2 = s:cold3.gui
	let g:terminal_color_3 = s:warm2.gui
	let g:terminal_color_4 = s:cold.gui
	let g:terminal_color_5 = s:cold2.gui
	let g:terminal_color_6 = s:cold.gui
	let g:terminal_color_7 = s:fg.gui
	let g:terminal_color_8 = s:bg.gui
	let g:terminal_color_9 = s:warm.gui
	let g:terminal_color_10 = s:cold3.gui
	let g:terminal_color_11 = s:warm2.gui
	let g:terminal_color_12 = s:cold.gui
	let g:terminal_color_13 = s:cold2.gui
	let g:terminal_color_14 = s:cold.gui
	let g:terminal_color_15 = s:fg.gui
	let g:terminal_color_background = s:bg.gui
	let g:terminal_color_foreground = s:fg.gui
endif
" }}}

" Change Status Line Color Based on Mode {{{
" https://vim.fandom.com/wiki/Change_statusline_color_to_show_insert_or_normal_mode
if version >= 700
	autocmd ModeChanged *:n call s:hl("MyModeColor", s:fg, s:bg2, "")
	autocmd ModeChanged *:i call s:hl("MyModeColor", s:fg, s:niceblue, "")
	autocmd ModeChanged *:[vV] call s:hl("MyModeColor", s:fg, s:darkgreen, "")
	autocmd ModeChanged *:\v(|s|S|) call s:hl("MyModeColor", s:fg, s:magenta, "")
	autocmd ModeChanged *:c call s:hl("MyModeColor", s:fg, s:orange, "")
	" Why do I need to do this to get the right colors when launching?
	call s:hl("MyModeColor", s:fg, s:bg2, "")
	call s:hl("MyStatusColor", s:fg, s:bg2, "")
endif
" }}}
