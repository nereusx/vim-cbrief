" Vim color file
" Maintainer:   Nicholas Christopoulos
" Last Change:  2021 Jan 10
"

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="cbrief"

hi Normal       term=NONE cterm=NONE ctermfg=White ctermbg=DarkBlue
hi Normal       gui=NONE guifg=White guibg=DarkBlue
hi NonText      term=NONE cterm=NONE ctermfg=White ctermbg=DarkBlue
hi NonText      gui=NONE guifg=White guibg=DarkBlue

hi Statement    term=NONE cterm=Bold ctermfg=White
hi Statement    gui=Bold guifg=White guibg=DarkBlue
hi Special      term=NONE cterm=NONE ctermfg=LightCyan
hi Special      gui=NONE guifg=Cyan guibg=DarkBlue
hi Constant     term=NONE cterm=Bold ctermfg=220
hi Constant     gui=Bold guifg=220 guibg=DarkBlue
hi Number       cterm=NONE ctermfg=220
hi Character    cterm=NONE ctermfg=Cyan
hi String       cterm=NONE ctermfg=Cyan
hi Boolean      cterm=NONE ctermfg=Blue
hi Comment      term=NONE cterm=NONE ctermfg=250 ctermbg=DarkBlue
hi Comment      gui=NONE guifg=Gray guibg=DarkBlue
hi Preproc      term=NONE cterm=Bold ctermfg=Magenta
hi Preproc      gui=NONE guifg=Magenta
hi Type         term=NONE cterm=Bold ctermfg=220 ctermbg=DarkBlue
hi Identifier   term=NONE cterm=Bold ctermfg=LightGreen ctermbg=DarkBlue
hi Title        cterm=Bold ctermfg=White
hi Title        gui=Bold guifg=White
hi SpellBad     cterm=underline ctermfg=198 ctermbg=NONE

hi StatusLine   term=bold cterm=bold ctermfg=Black ctermbg=White
hi StatusLine   gui=bold guifg=Black guibg=White

hi StatusLineNC term=NONE cterm=NONE ctermfg=Black ctermbg=White
hi StatusLineNC gui=NONE guifg=Black guibg=White

hi Visual       term=NONE cterm=NONE ctermfg=Black ctermbg=DarkCyan
hi Visual       gui=NONE guifg=Black guibg=DarkCyan

hi Search       term=NONE cterm=NONE ctermbg=Gray
hi Search       gui=NONE guibg=Gray

hi VertSplit    term=NONE cterm=NONE ctermfg=Black ctermbg=White
hi VertSplit    gui=NONE guifg=Black guibg=White

hi Directory    term=NONE cterm=NONE ctermfg=Green ctermbg=DarkBlue
hi Directory    gui=NONE guifg=Green guibg=DarkBlue

hi WarningMsg   term=standout cterm=NONE ctermfg=Red ctermbg=DarkBlue
hi WarningMsg   gui=standout guifg=Red guibg=DarkBlue

hi Error        term=NONE cterm=NONE ctermfg=White ctermbg=Red
hi Error        gui=NONE guifg=White guibg=Red

hi Cursor       ctermfg=Black ctermbg=Yellow
hi Cursor       guifg=Black guibg=Yellow
hi CursorLine   term=reverse gui=reverse cterm=NONE ctermfg=White ctermbg=DarkBlue
hi QuickSel		cterm=NONE ctermfg=White ctermbg=DarkBlue gui=NONE guifg=Yellow guibg=DarkBlue
hi LineNr		ctermfg=8

hi Pmenu		term=NONE cterm=NONE ctermfg=Black ctermbg=White
hi Pmenu        gui=NONE guifg=Black guibg=White
hi PmenuSel		term=NONE cterm=NONE ctermfg=Yellow ctermbg=DarkBlue
hi PmenuSel     gui=NONE guifg=Yellow guibg=DarkBlue
hi PmenuSbar	term=NONE cterm=NONE ctermfg=Black ctermbg=White
hi PmenuSbar    gui=NONE guifg=Black guibg=White
hi PmenuThumb	term=NONE cterm=NONE ctermfg=Black ctermbg=White
hi PmenuThumb   gui=NONE guifg=Black guibg=White

