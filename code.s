	.intel_syntax noprefix # Используем синтаксис в стиле Intel
	.text # Начало секции
	.globl	fillB # Объявляем и экспортируем fillB
	.type	fillB, @function # Отмечаем, что это функция
fillB:	
	push	rbp # Стандартный пролог функции(заталкиваем rbp на стек)
	mov	rbp, rsp # Стандартный пролог функции(копирование rsp в rbp)
	
	# 4 - i
	# 24 - A
	# 32 - B
	# 36 - n
	# 48 - cnt
	
	# Загрузка параметров в стек.
	mov	QWORD PTR -24[rbp], rdi # A
	mov	QWORD PTR -32[rbp], rsi # B
	mov	DWORD PTR -36[rbp], edx # n
	mov	QWORD PTR -48[rbp], rcx # cnt
	mov	DWORD PTR -4[rbp], 0 # i = 0
	jmp	.L2 # Переход к метке L2(условию цикла)
.L4:
	mov	eax, DWORD PTR -4[rbp] # eax := rbp - 4 (i)
	lea	rdx, 0[0+rax*4] # rdx := A[i]
	mov	rax, QWORD PTR -24[rbp] #  rax = rbp[-24] (A)
	add	rax, rdx # rax := (*A + i)
	mov	eax, DWORD PTR [rax] # eax := A[i]
	
	test	eax, eax # Проверка условия if (A[i] > 0)
	jle	.L3 # Если не выполняется A[i] > 0, то переходим к следующей итерации цикла
	
	mov	rax, QWORD PTR -48[rbp] # rax := rbp[-48] (cnt)
	mov	eax, DWORD PTR [rax] # eax := *cnt (сохраняем значение из cnt, разыменование)
	lea	rdx, 0[0+rax*4] # индексация
	mov	rax, QWORD PTR -32[rbp] # rax := rbp[-32] (B)
	add	rdx, rax # rdx := rax (*B + cnt)
	mov	eax, DWORD PTR -4[rbp] # eax := i
	mov	DWORD PTR [rdx], eax # B[rdx] = i (B[*cnt] = i)
	
	mov	rax, QWORD PTR -48[rbp] # rax := cnt
	mov	eax, DWORD PTR [rax] # eax := *cnt
	lea	edx, 1[rax] # edx := (*cnt) + 1
	mov	rax, QWORD PTR -48[rbp] # rax := cnt
	mov	DWORD PTR [rax], edx # ++(*cnt)
.L3:
	add	DWORD PTR -4[rbp], 1 # ++i
.L2:
	mov	eax, DWORD PTR -4[rbp] # eax := i
	cmp	eax, DWORD PTR -36[rbp] # (Сравнение i и n)
	jl	.L4 # Если выполняется (i < n), то переходим к метке L4(внутрь цикла)
	pop	rbp
	ret

# Загружаем "%d"
.LC0:
	.string	"%d "

	.text # Начало секции.
	.type	printArr, @function # Отмечаем, что printArr функция
printArr:
	push	rbp # Стандартный пролог фунции(заталкиваем rbp на стек)
	mov	rbp, rsp # Стандартный пролог функции(копирование rsp в rbp)
	sub	rsp, 48 # Выделяем 48 байт на стеке.
	
	# 4 - i
	# 24 - out
	# 32 - arr
	# 36 - n
	
	mov	QWORD PTR -24[rbp], rdi # out
	mov	QWORD PTR -32[rbp], rsi # arr
	mov	DWORD PTR -36[rbp], edx # n
	mov	DWORD PTR -4[rbp], 0 # i = 0
	jmp	.L6 # Переход к метке L6(условию цикла)
.L7:
	mov	eax, DWORD PTR -4[rbp] # eax := i
	lea	rdx, 0[0+rax*4] # индексация
	mov	rax, QWORD PTR -32[rbp] # rax := rbp[-32] (arr)
	add	rax, rdx # rax := rdx
	mov	edx, DWORD PTR [rax] # edx := arr[i] (3 аргумент для fprintf)
	mov	rax, QWORD PTR -24[rbp] # rax := rbp[-24]
	lea	rcx, .LC0[rip] # "%d"
	mov	rsi, rcx # rsi := rcx (2 аргумент для fprintf)
	mov	rdi, rax # rdi := rax (1 аргумент для fprintf)
	mov	eax, 0 # 
	call	fprintf@PLT # Вызов fprintf
	add	DWORD PTR -4[rbp], 1 # 
.L6:
	mov	eax, DWORD PTR -4[rbp] # eax := i
	cmp	eax, DWORD PTR -36[rbp] # Сравнение i и n
	jl	.L7 # Если i < n, то переходим к метке L7(внутрь цикла).
	leave
	ret

# Загружаем "%d"
.LC1:
	.string	"%d"

	.text # Начало секции 
	.type	fillArr, @function # Объявляея, что fillArr функция
fillArr:
	# Стандартный пролог функции(выделяем 48 байт на стеке)
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	
	# 4 - i
	# 24 - in
	# 32 - arr
	# 36 - n
	
	# Загрузка параметров в стек
	mov	QWORD PTR -24[rbp], rdi # in
	mov	QWORD PTR -32[rbp], rsi # arr
	mov	DWORD PTR -36[rbp], edx # n
	mov	DWORD PTR -4[rbp], 0 # i = 0
	jmp	.L9 # Переход к метке L9(условию цикла)
.L10:
	mov	eax, DWORD PTR -4[rbp] # eax := rbp[-4] (i)
	lea	rdx, 0[0+rax*4] # rdx := rax*4 (индексация)
	mov	rax, QWORD PTR -32[rbp] # rax := rbp[-32] (arr)
	add	rdx, rax # rdx := arr[i] (3 аргумент для fscanf)
	mov	rax, QWORD PTR -24[rbp] # rax := rbp[-24] (in)
	lea	rcx, .LC1[rip] # rcx := "%d"
	mov	rsi, rcx # (2 аргумент для fscanf)
	mov	rdi, rax # (1 аргумент для fscanf)
	mov	eax, 0 # eax := 0
	call	__isoc99_fscanf@PLT # Вызов fscanf
	add	DWORD PTR -4[rbp], 1 # ++i
.L9:
	mov	eax, DWORD PTR -4[rbp] # eax := rbp[-4] (i)
	cmp	eax, DWORD PTR -36[rbp] # Сравнение i и n
	jl	.L10 # Переход внурь цикла, если выполнено i < n
	leave
	ret
.LC2:
	.string	"r" # Загружаем "r"
.LC3:
	.string	"input.txt" # Загружаем "input.txt"
.LC4:
	.string	"w" # Загружаем "w"
.LC5:
	.string	"output.txt" # Загружаем "output.txt"
	
	.text #  Начало секции
	.globl	main # Экспортируем main
	.type	main, @function # Объявляем, что это функция
main:
	# Стандартный пролог функции(выделяем 832 байта не стеке).
	push	rbp
	mov	rbp, rsp
	sub	rsp, 832
	
	# 8 - in
	# 16 - out
	# 416 - A 
	# 816 - B
	# 820 - n
	# 824 - cnt
	
	lea	rax, .LC2[rip] # "r"
	mov	rsi, rax # rsi := rax (2 аргумент для fopen)
	lea	rax, .LC3[rip] # "input.txt"
	mov	rdi, rax # rdi := rax (1 аргумент для fopen)
	call	fopen@PLT # Вызов fopen.
	mov	QWORD PTR -8[rbp], rax # rbp[-8] = rax (in = fopen("input.txt", "r"))
	
	lea	rax, .LC4[rip] # "w"
	mov	rsi, rax # rsi := rax (2 аргумент для fopen)
	lea	rax, .LC5[rip] # "output.txt"
	mov	rdi, rax # rdi := rax (1 аргумент для fopen)
	call	fopen@PLT # Вызов fopen.
	mov	QWORD PTR -16[rbp], rax # rbp[-16] := rax (out = fopen("output.txt", "w"))
	
	lea	rdx, -820[rbp] # rdx := rbp[-820] (3 аргумент для fscanf, n)
	mov	rax, QWORD PTR -8[rbp] # rax := rbp[-8] (in)
	lea	rcx, .LC1[rip] # "%d"
	mov	rsi, rcx # rsi := rcx (2 аргумент для fscanf)
	mov	rdi, rax # rdi = rax (1 аргумент для fscanf)
	mov	eax, 0 # eax := 0
	call	__isoc99_fscanf@PLT # Вызов fscanf
	
	mov	edx, DWORD PTR -820[rbp] # edx := rbp[-820] (3 аргумент для fillArr)
	lea	rcx, -416[rbp] # rcx := rbp[-416] (A)
	mov	rax, QWORD PTR -8[rbp] # rax := rbp[-8] (in)
	mov	rsi, rcx # rsi := rcx (2 аргумент для fillArr)
	mov	rdi, rax # rdi := rax (1 аргумент для fillArr)
	call	fillArr # Вызов fillArr
	
	mov	DWORD PTR -824[rbp], 0 # cnt = 0
	mov	edx, DWORD PTR -820[rbp] # edx := rbp[-820] (3 аргумент для fillB)
	lea	rcx, -824[rbp] # rcx := rbp[-824] (4 аргумент для fillB)
	lea	rsi, -816[rbp] # rsi := rbp[-216] (2 аргумент для fillB)
	lea	rax, -416[rbp] # rax := rbp[-416] (A)
	mov	rdi, rax # (1 аргумент для fillB)
	call	fillB # Вызов fillB
	
	mov	edx, DWORD PTR -824[rbp] # (3 аргумент для printArr)
	lea	rcx, -816[rbp] # rcx := rbp[-816] (B)
	mov	rax, QWORD PTR -16[rbp] # rax := rbp[-16] (out)
	mov	rsi, rcx # rsi := rcx (2 аргумент для printArr)
	mov	rdi, rax #rdi := rax (1 аргумент для printArr)
	call	printArr # Вызов printArr
	
	mov	eax, 0 # return 0;
	leave
	ret
