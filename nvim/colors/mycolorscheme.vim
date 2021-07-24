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
" Dark Background Tones
let s:base03 = { "gui": "#002b36", "cterm": "234" }
let s:base02 = { "gui": "#073642", "cterm": "235" }
" Content Tones
let s:base01 = { "gui": "#586e75", "cterm": "240" }
let s:base00 = { "gui": "#657b83", "cterm": "241" }
let s:base0 = { "gui": "#839496", "cterm": "244" }
let s:base1 = { "gui": "#93a1a1", "cterm": "245" }
" Light Background Tones
let s:base2 = { "gui": "#eee8d5", "cterm": "254" }
let s:base3 = { "gui": "#fdf6e3", "cterm": "230" }
" Accent Tones
let s:yellow = { "gui": "#b58900", "cterm": "136" }
let s:orange = { "gui": "#cb4b16", "cterm": "166" }
let s:red = { "gui": "#dc322f", "cterm": "160" }
let s:magenta = { "gui": "#d33682", "cterm": "125" }
let s:violet = { "gui": "#6c71c4", "cterm": "61" }
let s:blue = { "gui": "#6c71c4", "cterm": "33" }
let s:cyan = { "gui": "#268bd2", "cterm": "37" }
let s:green = { "gui": "#268bd2", "cterm": "64" }

" Base Colors
let s:bg = s:base03
let s:bg2 = s:base02
let s:fg = s:base3
let s:fg2 = s:base2
" Accent Colors
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

call s:hl("LineNr", s:fg2, s:bg2, "")
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

call s:hl("StatusLine", s:fg2, s:bg2, "")
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
call s:hl("NonText", s:base00, "", "")
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
