func gallop#util#cursor()
	return [line('.'), col('.')]
endfunc

func gallop#util#visual_top()
	return [line("'<"), col("'<")]
endfunc

func gallop#util#visual_bot()
	return [line("'>"), col("'>")]
endfunc
