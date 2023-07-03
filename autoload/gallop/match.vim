func gallop#match#match(pat, back)
	let cursor_pos = gallop#util#cursor()
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

	return locs
endfunc
