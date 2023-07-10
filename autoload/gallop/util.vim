func gallop#util#cursor()
	return [line('.'), col('.')]
endfunc

func gallop#util#visual_start()
	return [line("'<"), col("'<")]
endfunc
