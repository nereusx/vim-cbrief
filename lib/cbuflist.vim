if exists('g:BufferListLoaded')
  finish
endif
let g:BufferListLoaded = 1

func! cbuflist#buflist()
	call quickui#tools#list_buffer('e')
endfunc



