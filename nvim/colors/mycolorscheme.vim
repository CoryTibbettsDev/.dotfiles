" ===============================================================
" mycolorscheme.vim
" Thank you to the many wonderful people who's colorschemes I
" learned from
" Colors based on tokyonight
" https://github.com/ghifarit53/tokyonight.vim/
" Color function based on onehalf
" https://github.com/sonph/onehalf
" ===============================================================

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
let s:white = { "gui": "#a9b1d6", "cterm": "250" }
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

" let s:palette = {
" 	\ 'black':      ['#06080a', '237',  'DarkGrey'],
" 	\ 'bg0':        ['#24283b', '235',  'Black'],
" 	\ 'bg1':        ['#282d42', '236',  'DarkGrey'],
" 	\ 'bg2':        ['#2f344d', '236',  'DarkGrey'],
" 	\ 'bg3':        ['#333954', '237',  'DarkGrey'],
" 	\ 'bg4':        ['#3a405e', '237',  'Grey'],
" 	\ 'bg_red':     ['#ff7a93', '203',  'Red'],
" 	\ 'diff_red':   ['#803d49', '52',   'DarkRed'],
" 	\ 'bg_green':   ['#b9f27c', '107',  'Green'],
" 	\ 'diff_green': ['#618041', '22',   'DarkGreen'],
" 	\ 'bg_blue':    ['#7da6ff', '110',  'Blue'],
" 	\ 'diff_blue':  ['#3e5380', '17',   'DarkBlue'],
" 	\ 'fg':         ['#a9b1d6', '250',  'White'],
" 	\ 'red':        ['#F7768E', '203',  'Red'],
" 	\ 'orange':     ['#FF9E64', '215',  'Orange'],
" 	\ 'yellow':     ['#E0AF68', '179',  'Yellow'],
" 	\ 'green':      ['#9ECE6A', '107',  'Green'],
" 	\ 'blue':       ['#7AA2F7', '110',  'Blue'],
" 	\ 'purple':     ['#ad8ee6', '176',  'Magenta'],
" 	\ 'grey':       ['#444B6A', '246',  'LightGrey'],
" 	\ 'none':       ['NONE',    'NONE', 'NONE']
" 	\ }
" }}}

" Color Function: {{{
function! s:h(group, fg, bg, attr)
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
call s:h("Normal", s:fg, s:bg, "")

call s:h("Cursor", s:bg, s:blue, "")
call s:h("CursorColumn", "", s:cursor_line, "")
call s:h("CursorLine", "", s:cursor_line, "")

call s:h("LineNr", s:fg, s:bg, "")
call s:h("CursorLineNr", s:fg, "", "")

call s:h("DiffAdd", s:green, "", "")
call s:h("DiffChange", s:yellow, "", "")
call s:h("DiffDelete", s:red, "", "")
call s:h("DiffText", s:blue, "", "")

call s:h("IncSearch", s:bg, s:yellow, "")
call s:h("Search", s:bg, s:yellow, "")

call s:h("ErrorMsg", s:fg, "", "bold,underline")
call s:h("ModeMsg", s:fg, "", "")
call s:h("MoreMsg", s:fg, "", "")
call s:h("WarningMsg", s:red, "", "")
call s:h("Question", s:purple, "", "")

call s:h("Pmenu", s:fg, s:bg, "")
call s:h("PmenuSel", s:fg, s:blue, "")
call s:h("PmenuSbar", "", s:selection, "")
call s:h("PmenuThumb", "", s:fg, "")

call s:h("SpellBad", s:red, "", "")
call s:h("SpellCap", s:yellow, "", "")
call s:h("SpellLocal", s:yellow, "", "")
call s:h("SpellRare", s:yellow, "", "")

call s:h("StatusLine", s:blue, s:cursor_line, "")
call s:h("StatusLineNC", s:comment_fg, s:cursor_line, "")
call s:h("TabLine", s:comment_fg, s:cursor_line, "")
call s:h("TabLineFill", s:comment_fg, s:cursor_line, "")
call s:h("TabLineSel", s:fg, s:bg, "")

call s:h("Visual", "", s:selection, "")
call s:h("VisualNOS", "", s:selection, "")

call s:h("ColorColumn", "", s:darkgray3, "")
call s:h("Conceal", s:fg, "", "")
call s:h("Directory", s:blue, "", "")
call s:h("VertSplit", s:darkgray4, s:darkgray4, "")
call s:h("Folded", s:fg, "", "")
call s:h("FoldColumn", s:fg, "", "")
call s:h("SignColumn", s:fg, "", "")

call s:h("MatchParen", s:blue, "", "underline")
call s:h("SpecialKey", s:fg, "", "")
call s:h("Title", s:green, "", "")
call s:h("WildMenu", s:fg, "", "")
" }}}

" Syntax Colors: {{{
" Whitespace is defined in Neovim, not Vim.
" See :help hl-Whitespace and :help hl-SpecialKey
call s:h("Whitespae", s:non_text, "", "")
call s:h("NonText", s:non_text, "", "")
call s:h("Comment", s:comment_fg, "", "italic")
call s:h("Constant", s:blue, "", "")
call s:h("String", s:green, "", "")
call s:h("Character", s:green, "", "")
call s:h("Number", s:yellow, "", "")
call s:h("Boolean", s:yellow, "", "")
call s:h("Float", s:yellow, "", "")

call s:h("Identifier", s:red, "", "")
call s:h("Function", s:blue, "", "")
call s:h("Statement", s:purple, "", "")

call s:h("Conditional", s:purple, "", "")
call s:h("Repeat", s:purple, "", "")
call s:h("Label", s:purple, "", "")
call s:h("Operator", s:fg, "", "")
call s:h("Keyword", s:red, "", "")
call s:h("Exception", s:purple, "", "")

call s:h("PreProc", s:yellow, "", "")
call s:h("Include", s:purple, "", "")
call s:h("Define", s:purple, "", "")
call s:h("Macro", s:purple, "", "")
call s:h("PreCondit", s:yellow, "", "")

call s:h("Type", s:yellow, "", "")
call s:h("StorageClass", s:yellow, "", "")
call s:h("Structure", s:yellow, "", "")
call s:h("Typedef", s:yellow, "", "")

call s:h("Special", s:blue, "", "")
call s:h("SpecialChar", s:fg, "", "")
call s:h("Tag", s:fg, "", "")
call s:h("Delimiter", s:fg, "", "")
call s:h("SpecialComment", s:fg, "", "")
call s:h("Debug", s:fg, "", "")
call s:h("Underlined", s:fg, "", "")
call s:h("Ignore", s:fg, "", "")
call s:h("Error", s:red, s:bg, "")
call s:h("Todo", s:purple, "", "")
" }}}

" Git {{{
call s:h("gitcommitComment", s:comment_fg, "", "")
call s:h("gitcommitUnmerged", s:red, "", "")
call s:h("gitcommitOnBranch", s:fg, "", "")
call s:h("gitcommitBranch", s:purple, "", "")
call s:h("gitcommitDiscardedType", s:red, "", "")
call s:h("gitcommitSelectedType", s:green, "", "")
call s:h("gitcommitHeader", s:fg, "", "")
call s:h("gitcommitUntrackedFile", s:blue, "", "")
call s:h("gitcommitDiscardedFile", s:red, "", "")
call s:h("gitcommitSelectedFile", s:green, "", "")
call s:h("gitcommitUnmergedFile", s:yellow, "", "")
call s:h("gitcommitFile", s:fg, "", "")
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile
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
