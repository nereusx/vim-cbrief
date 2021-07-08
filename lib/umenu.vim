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
let g:umenu#datalist = { }
let g:umenu#datalist[0] = [ ]
let g:umenu#datalist_count = 1

" add item to umenu
func umenu#additem(str, cmd)
	let g:umenu#datalist[0] += [ [ a:str, a:cmd ] ]
endfunc

"
func umenu#dir2opt(cdir, pat, cmd)
	let files = filter(split(globpath(a:cdir, a:pat), '\n'), '!isdirectory(v:val)')
	if empty(files)
		echom 'No matching files'
		return
	endif
	for f in files
"		let t_nam = substitute(f, a:cdir, '', 'g') 
		let t_nam = fnamemodify(f, ":t") 
		let t_cmd = substitute(a:cmd, '%f', f, 'g') 
		let g:umenu#datalist[g:umenu#datalist_count] += [ [ t_nam, t_cmd ] ]
	endfor
endfunc

" add a directory
func umenu#addfiles(topic, cdir, pat, cmd)
	let g:umenu#datalist[g:umenu#datalist_count] = [ ]
	call umenu#dir2opt(a:cdir, a:pat, a:cmd)
	let g:umenu#datalist[0] += [ [ a:topic, 'call umenu#showsub('.g:umenu#datalist_count.')' ] ]
	let g:umenu#datalist_count += 1
endfunc

" show sub-popup
func umenu#showsub(index)
	let opts = {'title':'User Menu', 'border':1, 'index':0, 'close':'button'}
	call quickui#listbox#open(g:umenu#datalist[a:index], opts)
endfunc

" show popup
func umenu#show()
	call umenu#showsub(0)
endfunc

"imap <silent> <A-F12>m <C-O>:call umenu#show()<CR>

