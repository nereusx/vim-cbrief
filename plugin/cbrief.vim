" File: cbrief.vim
" Description: fix and improvement of brief.vim
" Author: Nicholas Christopoulos (nereus@freemail.gr)
" Version: 1.0
" Last Modified: Jan 2021
"
"	F11		toggles insert mode
"	C-INS	copies to system clipboard (using xclip if no clipboard is available)
"	S-INS	pastes from system clipboard (using xclip of no clipboard is available)
"

" prevent to load again
if exists('g:loaded_cbrief') | finish | endif
let g:loaded_cbrief = 1

let schome = fnamemodify(resolve(expand('<sfile>:p')), ':h:h') . '/lib'

" fix ALT keys mapping
exec 'source '.schome.'/altkeys.vim'
if get(g:, 'cbrief_fix_altkeys', '1')
	call altkeys#load()
endif

" i have conflict with this one, I dont know even what it does
" it seems it is enables a diacritic-character mode but that 
" it is suppossed does the loadkeys in console or the X''s xkb
"
inoremap <silent> <A-SPACE> <SPACE>
noremap <silent> <A-SPACE> <SPACE>

" load default BRIEF emulation
exec 'source '.schome.'/brief.vim'

" colors
exec 'source '.schome.'/ccolors.vim'

" colors
exec 'source '.schome.'/csession.vim'

" my buflist
exec 'source '.schome.'/cbuflist.vim'

"
set virtualedit=onemore
set startofline
set backspace=indent,eol,start

" Only insert mode is supported
" Use CTRL-O to execute one Normal mode command.
set insertmode

" msgbox:
" call popup_create('do you want to quit (Yes/no)?', #{
"	\ filter: 'popup_filter_yesno',
"	\ callback: 'QuitCallback',
"	\ })
"
" listbox:
" func ColorSelected(id, result) " use a:result, index or -1 for cancel
" endfunc
" call popup_menu(['red', 'green', 'blue'], #{
"	\ callback: 'ColorSelected',
"	\ })
"
let g:quickui_border_style = 2

" F10: command-line
inoremap <F10> <C-O>:
nnoremap <F10> <ESC>:

" F11: switch modes
func! cbrief#toggle_insert_mode()
	if &insertmode == 1
		set noinsertmode
		echo "Insert mode is OFF"
	else
		set insertmode
		echo "Insert mode is ON"
	endif
endfunc

inoremap <silent> <F11> <C-O>:call cbrief#toggle_insert_mode()<CR>
nnoremap <silent> <F11> <ESC>:call cbrief#toggle_insert_mode()<CR><ESC>

" Alt+X: Quit
func! s:CountModBufs()
    redir => buflist
    silent! ls +
    redir END
    return len(split(buflist, '\n'))
endfunc

func! cbrief#quit()
	let cnt = s:CountModBufs()
	if cnt > 0
		let choice = confirm(
			\ printf('%d %s', cnt, 'buffer(s) has not been saved. Exit?'),
			\ "&yes\n&no\n&write", 1)
		if choice == 1
			silent! execute 'qa!'
		elseif choice == 2
			" nothing, remain in editor
			redraw
			echo "canceled"
		elseif choice == 3
			silent! execute 'xa!'
			echom "write all and quit!"
		endif
	else
		silent! execute 'qa!'
	endif
endfunc
inoremap <A-x> <C-O>:call cbrief#quit()<CR>

" open file
inoremap <A-e> <C-O>:edit<space>

" search
inoremap <A-s> <C-O>/
inoremap <C-S> <C-O>?

" search next
inoremap <silent> <A-f> <C-O>n

" search next backward
inoremap <silent> <C-F> <C-O>N

" Search and replace from the current cursor position
inoremap <silent> <A-t> <F6>

" === clipboard ===
" Paste scrap buffer contents to current cursor position.
" Vim register 'a' is used as the scrap buffer
inoremap <silent> <Ins> <C-O>"aP
inoremap <silent> <C-V> <C-O>"aP
" Copy marked text to scrap.
inoremap <silent> <C-C> <C-O>"ayy
vnoremap <silent> <C-C> "ay
" Cut line or mark to scrap buffer.
inoremap <silent> <C-X> <C-O>"add
vnoremap <silent> <C-X> "ax

" shift-arrows
inoremap <S-Up>		<C-O>:normal V<CR>
inoremap <S-Down>	<C-O>:normal V<CR>
inoremap <S-Left>	<C-O>:normal v<CR>
inoremap <S-Right>	<C-O>:normal v<CR>
inoremap <S-Home>	<C-O>:normal v^<CR>
inoremap <S-End>	<C-O>:normal v$<CR>
vnoremap <S-Up>		k
vnoremap <S-Down>	j
vnoremap <S-Left>	h
vnoremap <S-Right>	l
" ================

" === system clipboard ===

" paste from X11 primary clipboard
func! cbrief#xpaste()
	let ai = &autoindent
	let si = &smartindent
	let &autoindent = 0
	let &smartindent = 0
	if has('clipboard')
		exec 'normal "*P'
	else
		let @"=system('xclip -o -sel clip')
		exec 'normal "*P'
	endif
	let &smartindent = si
	let &autoindent = ai
	redraw
	echom "Clipborad text inserted."
endfunc
command! Bxpaste	call cbrief#xpaste()

" copy to X11 primary clipboard
func! cbrief#xcopy()
	if has('clipboard')
		exec 'normal "*yy'
	else
		call system('xclip -i -sel clip', @")
	endif
	redraw
	echom "Text copied to Clipboard."
endfunc
command! Bxcopy		call cbrief#xcopy()

" Copy marked text to system clipboard.  If no mark, copy current line
inoremap <silent> <C-Ins> <C-O>:call cbrief#xcopy()<CR>

" Paste the system clipboard contents to current cursor
inoremap <silent> <S-Ins> <C-O>:call cbrief#xpaste()<CR>

" Cut the marked text to system clipboard. If no mark, cut the current line
inoremap <silent> <S-Del> <C-O>"*dd
vnoremap <silent> <S-Del> "*d
" ========================

" === windows ===

" move to window
inoremap <silent> <F1>	<C-O>:call <SID>ExecArrow(2)<CR>

" resize window
inoremap <silent> <F2>	<C-O>:call <SID>ExecArrow(3)<CR>

" Split window
inoremap <silent> <F3>	<C-O>:call <SID>ExecArrow(1)<CR>

" Close window
inoremap <silent> <F4>	<C-O>:call <SID>ExecArrow(4)<CR>

" ------------------

func! s:ExecArrow(mode)
let exitf = v:false
if a:mode == 1 " Split
	echo "Select side for the new window (use cursor keys)."
elseif a:mode == 2 " Move
	echo "Point to destination (use cursor keys)."
elseif a:mode == 3 " Resize
	echo "Select an edge to move (use cursor keys)."
elseif a:mode == 4 " Delete
	echo "Select window edge to delete (use cursor keys)."
endif
while !exitf
	let key = getchar()
	if a:mode == 1 " Split
		if key == "\<Left>"
			silent! exec "leftabove vsplit"
		elseif key == "\<Up>"
			silent! exec "leftabove split"
		elseif key == "\<Right>"
			silent! exec "rightbelow vsplit"
		elseif key == "\<Down>"
			silent! exec "rightbelow split"
		endif
		let exitf = v:true
	elseif a:mode == 2 " Move
		if key == "\<Left>"
			silent! exec "wincmd h"
		elseif key == "\<Up>"
			silent! exec "wincmd k"
		elseif key == "\<Right>"
			silent! exec "wincmd l"
		elseif key == "\<Down>"
			silent! exec "wincmd j"
		endif
		let exitf = v:true
	elseif a:mode == 3 " Resize
		if key == "\<Left>"
			silent! exec "vert res -1"
		elseif key == "\<Up>"
			silent! exec "res -1"
		elseif key == "\<Right>"
			silent! exec "vert res +1"
		elseif key == "\<Down>"
			silent! exec "res +1"
		elseif key == 27
			let exitf = v:true
		elseif key == 113
			let exitf = v:true
		else
			echo "key code = " .. string(key)
		endif
		let exitf = v:true " ??? getchar does not work well
	elseif a:mode == 4 " close
		if key == "\<Left>"
			silent! exec "wincmd h"
			silent! exec "close"
		elseif key == "\<Up>"
			silent! exec "wincmd k"
			silent! exec "close"
		elseif key == "\<Right>"
			silent! exec "wincmd l"
			silent! exec "close"
		elseif key == "\<Down>"
			silent! exec "wincmd j"
			silent! exec "close"
		endif
		let exitf = v:true
	endif
"	while getchar(1)
"		getchar(0)
"	endwhile
endwhile
endfunc

" buffer list
func! s:BufList()
	call cbuflist#buflist()
endfunc
inoremap <silent> <A-b>	<C-O>:call <SID>BufList()<CR>

func! s:HelpView(cmd, opts)
"	let text = system(a:cmd)
"	call popup_dialog(text, #{ callback: 'PopupEmptyHandler', })
	call quickui#textbox#command(a:cmd, a:opts)
endfunc

"
func! s:HelpOnKey(word)
let opts = { 'title': ' Unix Pages: [' . a:word . '] '}
let cmd = ''
let manfilt = ' | col -bx'

if &filetype == "pascal"
	" fpman required: https://github.com/suve/fpman
	let opts['title'] = ' FPC Pages: [' . a:word . '] '
	let cmd = printf('%s/.vim/pasdoc %s %s', $HOME, a:word, manfilt)
elseif &filetype == "php"
	" pear {install|upgrade} doc.php.net/pman
	let opts['title'] = ' pman: [' . a:word . '] '
	let cmd = printf('pman %s %s', a:word, manfilt)
elseif &filetype == "perl"
	" this is tricky, use 'perldoc perldoc'
	let opts['title'] = ' perldoc: [' . a:word . '] '
	let cmd = printf('perldoc -f %s', a:word)
elseif &filetype == "python"
	let opts['title'] = ' pydoc: [' . a:word . '] '
	let cmd = printf('pydoc %s %s', a:word, manfilt)
else " C or bash or anything else
	" add C++: https://github.com/jeaye/stdman
	let cmd = printf('man %s %s', a:word, manfilt)
endif
call s:HelpView(cmd, opts)
endfunc

inoremap <silent> <C-F1> <C-O>:call <SID>HelpOnKey(expand('<cword>'))<CR>

let g:quickui_border_style = 2
command! Routines :call quickui#tools#list_function()
inoremap <silent> <C-G>	<C-O>:Routines<CR>

" Alt+H
func! s:VimHelp()
	let topk = inputdialog('Enter topic: ', expand('<cword>'), '')
	if topk != ''
		call quickui#tools#display_help(topk)
	endif
endfunc
inoremap <silent> <A-h>	<C-O>:call <SID>VimHelp()<CR>

"command! NAV <C-L>:Explore<CR>

" === key-macros ===
" 
" qr	q = start recording, r = named register
" q     stop recording
" qR	start recording again, R = [capital] named register, it is appends to register
" [count]@q replay macro
" 
func s:CBriefMacRec()
	if get(b:, 'brief_rec_mode', 0) == 0
		normal qq
		let b:brief_rec_mode = 1
	elseif b:brief_rec_mode == 2
		normal qQ
		let b:brief_rec_mode = 1
	else
		normal q
		let b:brief_rec_mode = 0
	endif
endfunc

func s:CBriefMacPause()
	if get(b:, 'brief_rec_mode', 0) == 1
		normal q
		let b:brief_rec_mode = 2
	endif
endfunc

inoremap <silent> <F7>		<C-O>:call <SID>CBriefMacRec()<CR>
inoremap <silent> <S-F7>	<C-O>:call <SID>CBriefMacPause()<CR>
"inoremap <F8>		<C-O>:normal @q<CR>

" (un)ident selection 
xnoremap <S-TAB>  <gv
xnoremap <TAB>    >gv

