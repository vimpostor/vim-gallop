if exists('g:loaded_gallop') || has('nvim')
	finish
endif
let g:loaded_gallop = 1

call gallop#init()
