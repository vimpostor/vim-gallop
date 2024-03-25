func gallop#init()
	if !exists('g:gallop_keys')
		let g:gallop_keys = 'asdghklqwertyuiopzxcvbnmfj,'
	endif

	noremap <silent> <LocalLeader>w :call gallop#move#w(0)<CR>
	xnoremap <silent> <LocalLeader>w :call gallop#move#w(1)<CR>
	noremap <silent> <LocalLeader>b :call gallop#move#b(0)<CR>
	xnoremap <silent> <LocalLeader>b :call gallop#move#b(1)<CR>
	noremap <silent> <LocalLeader>j :call gallop#move#j(0)<CR>
	xnoremap <silent> <LocalLeader>j :call gallop#move#j(1)<CR>
	noremap <silent> <LocalLeader>k :call gallop#move#k(0)<CR>
	xnoremap <silent> <LocalLeader>k :call gallop#move#k(1)<CR>
	noremap <silent> <LocalLeader>s :call gallop#move#s(2, 0)<CR>
	xnoremap <silent> <LocalLeader>s :call gallop#move#s(2, 1)<CR>
endfunc
