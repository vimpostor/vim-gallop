func gallop#move#move(pat, back)
	let cursor_pos = [line('.'), col('.')]
	let top_line = line('w0')
	let bottom_line = line('w$')

	let locs = []
	let p = [1, 1]
	while p[0] != 0
		let p = searchpos(a:pat, 'W' . (a:back ? 'b' : ''), a:back ? top_line : bottom_line)
		call add(locs, p)
	endwhile
	" remove the last invalid [0, 0] pos
	call remove(locs, -1)

	" reset cursor
	keepjumps call winrestview(#{lnum: cursor_pos[0], topline: top_line})
	keepjumps call cursor(cursor_pos)

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
