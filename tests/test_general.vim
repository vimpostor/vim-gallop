func SetUp()
	" init plugin manually, because VimEnter is not triggered
	call gallop#init()

	let lorem = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
	call append(1, lorem->split('\. ')->map({_, v -> v . '.'}))
	call deletebufline(bufnr('%'), 1)
endfunc

func Current_word()
	return expand('<cword>')
endfunc

func Assert_word(w)
	call assert_equal(a:w, Current_word())
endfunc

func Test_loaded()
	call assert_equal(1, g:loaded_gallop)
endfunc

func Test_move_w()
	call cursor(1, 1)
	call Assert_word("Lorem")

	" move one word further
	call feedkeys('a')
	call gallop#move#w(0)
	call Assert_word("ipsum")

	" move two words further
	call feedkeys('s')
	call gallop#move#w(0)
	call Assert_word("sit")
endfunc

func Test_move_b()
	call cursor(2, 1)
	norm w
	call Assert_word("vero")

	" move back one word
	call feedkeys('a')
	call gallop#move#b(0)
	call Assert_word("At")

	" move back across lines
	call feedkeys('a')
	call gallop#move#b(0)
	call Assert_word("voluptua")
endfunc

func Test_move_j()
	call cursor(1, 1)

	" move down one line
	call feedkeys('a')
	call gallop#move#j(0)
	call assert_equal([2, 1], gallop#util#cursor())

	" move down two lines
	call feedkeys('s')
	call gallop#move#j(0)
	call assert_equal([4, 1], gallop#util#cursor())
endfunc

func Test_move_k()
	call cursor(4, 1)

	" move up one line
	call feedkeys('a')
	call gallop#move#k(0)
	call assert_equal([3, 1], gallop#util#cursor())

	" move up two lines
	call feedkeys('s')
	call gallop#move#k(0)
	call assert_equal([1, 1], gallop#util#cursor())
endfunc

func Test_move_s()
	call cursor(1, 1)

	call feedkeys('taki')
	call feedkeys('s')
	call gallop#move#s(4, 0)
	call Assert_word("takimata")

	call feedkeys('jus')
	call feedkeys('a')
	call gallop#move#s(3, 0)
	call Assert_word("justo")

	call feedkeys('et')
	call feedkeys('s')
	call gallop#move#s(2, 0)
	call Assert_word("et")

	call feedkeys('c')
	call feedkeys('s')
	call gallop#move#s(1, 0)
	call Assert_word("accusam")
endfunc

func Test_no_duplicates()
	for i in range(4)
		let n = float2nr(pow(len(g:gallop_options.keys), i)) + 1
		let r = gallop#hints#unique_labels(n)
		call assert_equal(n, len(r))
		let s = sort(r)
		call assert_equal(uniq(copy(s)), s)
	endfor
endfunc

func Test_no_prefix_collision()
	for i in range(3)
		let n = float2nr(pow(len(g:gallop_options.keys), i)) + 1
		let r = gallop#hints#unique_labels(n)
		for i in r
			" the only label containing i as prefix is itself
			call assert_equal([i], filter(deepcopy(r), {_, v -> strcharpart(v, 0, len(i)) == i}))
		endfor
	endfor
endfunc
