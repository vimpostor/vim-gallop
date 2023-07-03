func gallop#init()
	if !exists('g:gallop_keys')
		let g:gallop_keys = 'asdghklqwertyuiopzxcvbnmfj,'
	endif

	map <silent> <LocalLeader>w :call gallop#move#w()<CR>
	map <silent> <LocalLeader>b :call gallop#move#b()<CR>
	map <silent> <LocalLeader>j :call gallop#move#j()<CR>
	map <silent> <LocalLeader>k :call gallop#move#k()<CR>
endfunc
