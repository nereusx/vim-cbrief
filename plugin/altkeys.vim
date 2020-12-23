" Fix meta-keys which generate <Esc>a .. <Esc>z
"
" The problem is well known and it may be already fixed
" in some environments.
"
" Creates <A-a> .. <A-z> keys
"
" Copy this file to ~/.vim and load it
"
"	cp altkeys.vim ~/.vim
"	echo 'source ~/.vim/altkeys.vim' >> ~/.vimrc
"

if has('nvim') || has('gui_running')
	finish
endif
if exists('g:loaded_altkeys')
	finish
endif
let g:loaded_altkeys = 1

func! altkeys#load()
	function! s:metacode(key)
		exec "set <A-".a:key.">=\e".a:key
	endfunc
	function! s:key_escape(name, code)
		exec "set ".a:name."=\e".a:code
	endfunc
	for i in range(10)
		call s:metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(nr2char(char2nr('a') + i))
		call s:metacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		call s:metacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:metacode(c)
	endfor
	
	call s:key_escape('<F1>', 'OP')
	call s:key_escape('<F2>', 'OQ')
	call s:key_escape('<F3>', 'OR')
	call s:key_escape('<F4>', 'OS')
	call s:key_escape('<S-F1>', '[1;2P')
	call s:key_escape('<S-F2>', '[1;2Q')
	call s:key_escape('<S-F3>', '[1;2R')
	call s:key_escape('<S-F4>', '[1;2S')
	call s:key_escape('<S-F5>', '[15;2~')
	call s:key_escape('<S-F6>', '[17;2~')
	call s:key_escape('<S-F7>', '[18;2~')
	call s:key_escape('<S-F8>', '[19;2~')
	call s:key_escape('<S-F9>', '[20;2~')
	call s:key_escape('<S-F11>', '[23;2~')

	imap [1;5P <C-F1>

	call s:key_escape('<S-F10>', '[21;2~')
	imap [21;3~ <A-F10>
	imap [21;5~ <C-F10>

	call s:key_escape('<S-F12>', '[24;2~')
	imap [24;3~ <A-F12>
	imap [24;5~ <C-F12>
	
	call s:key_escape('<C-Right>', '[1;5C')
	call s:key_escape('<C-Left>', '[1;5D')
	
	" this supposed solves compose-key issues
	if $TERM != "linux" " its terminal emulator
		set esckeys
		"set modifyotherKeys
		let &t_TI = "\<Esc>[>4;2m"
		let &t_TE = "\<Esc>[>4;m"
	endif
endfunc

if get(g:, 'cbrief_fix_altkeys', '1')
	call altkeys#load()
endif

