" File: ccolors.vim
" Author: Nicholas Christopoulos
" Version: 1.1
" Last Modified: 10 Jan 2021
"
" Overview
" --------
" The ccolors changes the color scheme.
" You can choose scheme from popup menu by pressing Ctrl+F12
" You can select the next/previous availabe in cc_schemes array
" by using F12 and Shift+F12.
"
" The 'cc_schemes' array can be defined by user. By default it is
" filled with all color-schemes that found in VIMs directories.
"
" Required:
"	vim-quickui plugin
"

" Has this already been loaded?
if exists('loaded_ccscheme')
	finish
endif
let loaded_ccscheme = v:true
let g:cc_selected = 0

" cc_schemes is the array with the colorschemes...
" if the array is not yet defined, it fill it with all available
" color schemes found in VIM paths.
if ! exists('g:cc_schemes')
	let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
	let g:cc_schemes = map(paths, 'fnamemodify(v:val, ":t:r")')
endif

func! ccolors#ccswitch(swinc)
	let g:cc_selected += a:swinc
	let cnt = len(g:cc_schemes)
	if g:cc_selected >= cnt
		let g:cc_selected = 0
	elseif g:cc_selected < 0
		let g:cc_selected = cnt - 1
	endif
	silent! execute printf('colorscheme %s', g:cc_schemes[g:cc_selected])
	redraw
	echom printf('Using [%s] color-scheme.', g:cc_schemes[g:cc_selected])
endfunc

func! ccolors#ccselect()
	func! CCSelList(code)
		if a:code == -1
			redraw
			echo "canceled."
		else
			let g:cc_selected = a:code
			silent! execute "colorscheme " .. g:cc_schemes[g:cc_selected]
			redraw
			echom printf('Using [%s] color-scheme.', g:cc_schemes[g:cc_selected])
		endif
	endfunc
	let opts = {"close":"button", "index":string(g:cc_selected), "title":"Select Color Scheme"}
	let opts.callback = 'CCSelList'
	call quickui#listbox#open(g:cc_schemes, opts)
endfunc

if exists('g:loaded_umenu')
	call umenu#additem("&c	Colors Dialog",   "call ccolors#ccselect()")
	call umenu#additem("&n	Colors Next",     "call ccolors#ccswitch(1)")
	call umenu#additem("&p	Colors Previous", "call ccolors#ccswitch(-1)")
endif
imap <silent> <A-F12>n <C-O>:call ccolors#ccswitch(1)<CR>
imap <silent> <A-F12>p <C-O>:call ccolors#ccswitch(-1)<CR>
imap <silent> <A-F12>c <C-O>:call ccolors#ccselect()<CR>

