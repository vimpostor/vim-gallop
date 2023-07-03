func gallop#hints#init()
	if has('nvim')
		let s:ns = nvim_create_namespace('gallop')
	else
		call prop_type_add('gallop', {})
	endif
	let s:popups = []
endfunc

func gallop#hints#unique_labels(n)
	if !a:n
		return []
	endif

	let k = split(g:gallop_keys, '\zs')
	let r = k
	let i = len(r) - 1

	while len(r) < a:n
		let a = remove(r, i)
		let r = r[:i - 1] + map(deepcopy(k), {_, v -> a .. v})[:a:n - len(r) - 1] + r[i:]

		let i = (i - 1) % len(r)
	endwhile

	return r[:a:n - 1]
endfunc

func gallop#hints#show(l)
	let labels = map(gallop#hints#unique_labels(len(a:l)), {i, v -> #{i: i, v: v}})

	while len(labels) > 1
		let i = 0
		while i < len(labels)
			let x = a:l[labels[i].i]

			if has('nvim')
				call add(s:popups, nvim_buf_set_extmark(bufnr('%'), s:ns, x[0] - 1, x[1] - 1, #{virt_text: [[labels[i].v, 'DiffText']], virt_text_pos: 'overlay'}))
			else
				call prop_add(x[0], x[1], #{type: 'gallop', length: 1, id: i + 1})
				call add(s:popups, popup_create(labels[i].v, #{line: 1, col: 1, textprop: 'gallop', textpropid: i + 1, pos: 'botright', highlight: 'DiffText'}))
			endif

			let i += 1
		endwhile

		redraw
		let c = getcharstr()
		call gallop#hints#clear()

		let labels = filter(labels, {_, v -> v.v[0] == c})->map({_, v -> #{i: v.i, v: v.v[1:]}})
	endwhile

	if len(labels)
		call cursor(a:l[labels[0].i])
	else
		echohl ErrorMsg | echo 'No matches' | echohl None
	endif
endfunc

func gallop#hints#clear()
	if has('nvim')
		call nvim_buf_clear_namespace(bufnr('%'), s:ns, 0, -1)
	else
		for i in s:popups
			call popup_close(i)
		endfor
		let s:popups = []
		call prop_remove(#{type: 'gallop', all: 1})
	endif
endfunc

call gallop#hints#init()
