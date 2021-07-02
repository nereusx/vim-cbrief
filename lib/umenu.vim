" File: umenu.vim
" Author: Nicholas Christopoulos
" Version: 1.0
" Last Modified: 02 Jul 2021
"
" Overview
" --------
"
" Required:
"	vim-quickui plugin
"

" Has this already been loaded?
if exists('g:loaded_umenu')
	finish
endif
let g:loaded_umenu = v:true
let g:umenu#list = [ ]

" add item to umenu
func umenu#additem(str, cmd)
	let g:umenu#list += [ [ a:str, a:cmd ] ]
endfunc

" show popup
func umenu#show()
	let opts = {'title':'User Menu', 'border':1, 'index':0, 'close':'button'}
	call quickui#listbox#open(g:umenu#list, opts)
endfunc

"imap <silent> <A-F12>m <C-O>:call umenu#show()<CR>

