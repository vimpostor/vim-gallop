func gallop#init()
	let g:gallop_options = extend(gallop#default_options(), get(g:, 'gallop_options', {}))

	if g:gallop_options.default_mappings
		nnoremap <silent> <LocalLeader>w <Cmd>call gallop#move#w()<CR>
		xnoremap <silent> <LocalLeader>w <Cmd>call gallop#move#w()<CR>
		nnoremap <silent> <LocalLeader>b <Cmd>call gallop#move#b()<CR>
		xnoremap <silent> <LocalLeader>b <Cmd>call gallop#move#b()<CR>
		nnoremap <silent> <LocalLeader>j <Cmd>call gallop#move#j()<CR>
		xnoremap <silent> <LocalLeader>j <Cmd>call gallop#move#j()<CR>
		nnoremap <silent> <LocalLeader>k <Cmd>call gallop#move#k()<CR>
		xnoremap <silent> <LocalLeader>k <Cmd>call gallop#move#k()<CR>
		nnoremap <silent> <LocalLeader>s <Cmd>call gallop#move#s(2)<CR>
		xnoremap <silent> <LocalLeader>s <Cmd>call gallop#move#s(2)<CR>
	endif
endfunc

func gallop#default_options()
	return #{
		\ default_mappings: 1,
		\ keys: 'asdghklqwertyuiopzxcvbnmfj,',
	\ }
endfunc
