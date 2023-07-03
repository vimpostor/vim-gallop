func gallop#move#move(pat, back)
	let locs = gallop#match#match(a:pat, !!a:back)

	" if back is 2, it means both forward and back
	if a:back == 2
		let f = gallop#match#match(a:pat, 0)
		" intermangle both lists
		let i = 0
		for x in f
			call insert(locs, x, i)
			let i += 1 + (i < len(locs) - 1)
		endfor
	endif
	call gallop#hints#show(locs)
endfunc

func gallop#move#wb(back)
	call gallop#move#move('\<', a:back)
endfunc

func gallop#move#w()
	call gallop#move#wb(0)
endfunc

func gallop#move#b()
	call gallop#move#wb(1)
endfunc

func gallop#move#jk(back)
	call gallop#move#move(printf('^.\{-}\zs\(\%%%dv\|$\)', virtcol('.')), a:back)
endfunc

func gallop#move#j()
	call gallop#move#jk(0)
endfunc

func gallop#move#k()
	call gallop#move#jk(1)
endfunc

func gallop#move#s(n)
	" allows the user to match for a specific string of length n
	let s = ''
	while len(s) < a:n
		let s .= getcharstr()
	endwhile
	call gallop#move#move(s, 2)
endfunc
