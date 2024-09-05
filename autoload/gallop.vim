func gallop#init()
	let g:gallop_options = extend(gallop#default_options(), get(g:, 'gallop_options', {}))

	nnoremap <silent> <LocalLeader>w :call gallop#move#w(0)<CR>
	xnoremap <silent> <LocalLeader>w :call gallop#move#w(1)<CR>
	nnoremap <silent> <LocalLeader>b :call gallop#move#b(0)<CR>
	xnoremap <silent> <LocalLeader>b :call gallop#move#b(1)<CR>
	nnoremap <silent> <LocalLeader>j :call gallop#move#j(0)<CR>
	xnoremap <silent> <LocalLeader>j :call gallop#move#j(1)<CR>
	nnoremap <silent> <LocalLeader>k :call gallop#move#k(0)<CR>
	xnoremap <silent> <LocalLeader>k :call gallop#move#k(1)<CR>
	nnoremap <silent> <LocalLeader>s :call gallop#move#s(2, 0)<CR>
	xnoremap <silent> <LocalLeader>s :call gallop#move#s(2, 1)<CR>
endfunc

func gallop#default_options()
	return #{
		\ keys: 'asdghklqwertyuiopzxcvbnmfj,',
	\ }
endfunc
