func gallop#move#move(pat, back, visual)
	if a:visual
		let visual_start = gallop#util#visual_start()
	endif

	let locs = gallop#match#match(a:pat, !!a:back, a:visual)

	" if back is 2, it means both forward and back
	if a:back == 2
		let f = gallop#match#match(a:pat, 0, a:visual)
		" intermangle both lists
		let i = 0
		for x in f
			call insert(locs, x, i)
			let i += 1 + (i < len(locs) - 1)
		endfor
	endif

	let jump_pos = gallop#hints#show(locs)

	if a:visual
		" restore visual mode
		keepjumps call cursor(visual_start)
		exec "norm " . visualmode()
	endif

	if jump_pos[0] != 0
		keepjumps call cursor(jump_pos)
	else
		echohl ErrorMsg | echo 'No matches' | echohl None
	endif
endfunc

func gallop#move#wb(back, visual)
	call gallop#move#move('\<', a:back, a:visual)
endfunc

func gallop#move#w(visual)
	call gallop#move#wb(0, a:visual)
endfunc

func gallop#move#b(visual)
	call gallop#move#wb(1, a:visual)
endfunc

func gallop#move#jk(back, visual)
	call gallop#move#move(printf('^.\{-}\zs\(\%%%dv\|$\)', virtcol('.')), a:back, a:visual)
endfunc

func gallop#move#j(visual)
	call gallop#move#jk(0, a:visual)
endfunc

func gallop#move#k(visual)
	call gallop#move#jk(1, a:visual)
endfunc

func gallop#move#s(n, visual)
	" allows the user to match for a specific string of length n
	let s = ''
	while len(s) < a:n
		let s .= getcharstr()
	endwhile
	call gallop#move#move(s, 2, a:visual)
endfunc
