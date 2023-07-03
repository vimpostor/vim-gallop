func SetUp()
	" init plugin manually, because VimEnter is not triggered
	call gallop#init()
endfunc

func Test_loaded()
	call assert_equal(1, g:loaded_gallop)
endfunc
