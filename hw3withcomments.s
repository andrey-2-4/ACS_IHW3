	.intel_syntax noprefix # используем синтаксис intel
	.text
	.globl	factorial
	.type	factorial, @function
factorial: # функция возвращает факториал числа
	push	rbp # rbp кладем на стек
	mov	rbp, rsp # rbp = rsp
	sub	rsp, 16 # rsp -= 16
	mov	QWORD PTR -8[rbp], rdi # (-8 на стеке) = rdi = n
	cmp	QWORD PTR -8[rbp], 1 # сравниваем n и 1
	jbe	.L2 # если >= идем в .L2
	mov	rax, QWORD PTR -8[rbp] # rax = (-8 на стеке) = n
	sub	rax, 1 # rax -= 1
	mov	rdi, rax # rdi = rax
	call	factorial # рекурсивный вызов функции
	imul	rax, QWORD PTR -8[rbp] 
	jmp	.L4 # переход .L4
.L2:
	mov	eax, 1 # eax = 1
.L4:
	leave # завершение функции и возврат результата
	ret
	.globl	sin
	.type	sin, @function
sin: # функция возвращает ~sin(x)
	push	rbp # кладем rbp на стек
	mov	rbp, rsp # rbp = rsp
	sub	rsp, 48 # rsp -=48
	movsd	QWORD PTR -40[rbp], xmm0 # (-40 на стеке) = xmm0 = x
	mov	DWORD PTR -4[rbp], -1 #(-4 на стеке) = -1 = i
	mov	QWORD PTR -16[rbp], 3 # (-16 на стеке) = 3 = j
	movsd	xmm0, QWORD PTR -40[rbp] # xmm0 = (-40 на стеке)
	movsd	QWORD PTR -24[rbp], xmm0 # s = (-24 на стеке) = xmm0
	movsd	xmm0, QWORD PTR -40[rbp] # xmm0 = (-40 на стеке) 
	movsd	QWORD PTR -32[rbp], xmm0 # e = (-32 на стеке) = xmm0
	jmp	.L6 # идем .L6
.L11: # работа с регистрами для дальнейшего вызова pow
	pxor	xmm2, xmm2
	cvtsi2sd	xmm2, DWORD PTR -4[rbp]
	movsd	QWORD PTR -48[rbp], xmm2
	mov	rax, QWORD PTR -16[rbp]
	test	rax, rax
	js	.L7
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	jmp	.L8
.L7:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
	addsd	xmm0, xmm0
.L8: # уже готовы вызывать pow
	mov	rax, QWORD PTR -40[rbp] # rax = (-40 на стеке)
	movapd	xmm1, xmm0 # xmm1 = xmm0
	movq	xmm0, rax # xmm0 = rax
	call	pow@PLT # вызов pow
	mulsd	xmm0, QWORD PTR -48[rbp] 
	movsd	QWORD PTR -48[rbp], xmm0 # (-48 на стеке) = xmm0
	mov	rax, QWORD PTR -16[rbp] # rax = (-16 на стеке) = j
	mov	rdi, rax # rdi = rax
	call	factorial # вызов фунции factorial
	# работа с регистрами, перед переходом на этап проверки
	test	rax, rax
	js	.L9
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	jmp	.L10
.L9:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
	addsd	xmm0, xmm0
.L10:
	movsd	xmm1, QWORD PTR -48[rbp]
	divsd	xmm1, xmm0
	movsd	QWORD PTR -32[rbp], xmm1
	neg	DWORD PTR -4[rbp]
	add	QWORD PTR -16[rbp], 2
	movsd	xmm0, QWORD PTR -24[rbp]
	addsd	xmm0, QWORD PTR -32[rbp]
	movsd	QWORD PTR -24[rbp], xmm0
.L6: # готовы проверять условие цикла
	movsd	xmm0, QWORD PTR -32[rbp] # xmm0 = e
	# проверяем, что e от -0.0005 до 0.0005
	comisd	xmm0, QWORD PTR .LC0[rip]
	jnb	.L11
	movsd	xmm0, QWORD PTR .LC1[rip]
	comisd	xmm0, QWORD PTR -32[rbp]
	jnb	.L11
	# если выходим за границы, то завершаем функцию и возвращаем s
	movsd	xmm0, QWORD PTR -24[rbp] # xmm0 = (-24 на стеке)
	movq	rax, xmm0 # rax = xmm0
	movq	xmm0, rax # xmm0 = rax
	leave # завершение фунцкции
	ret
	.align 8
# строки, что выводятся на экран
.LC2:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 \321\200\320\260\320\267\320\274\320\265\321\200\320\275\320\276\321\201\321\202\321\214 \321\203\320\263\320\273\320\260 x (\320\262 \321\200\320\260\320\264\320\270\320\260\320\275\320\260\321\205 \320\276\321\202 -5 \320\264\320\276 5): "
.LC3:
	.string	"%lf"
	.align 8
.LC6:
	.string	"!\320\275\320\265\320\264\320\276\320\277\321\203\321\201\321\202\320\270\320\274\320\276\320\265 \320\267\320\275\320\260\321\207\320\265\320\275\320\270\320\265!"
.LC7:
	.string	"sin(x) = %.*lf\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp # кладем rbp на стек
	mov	rbp, rsp # rbp = rsp
	sub	rsp, 16 # rsp -= 16
.L14:
	lea	rax, .LC2[rip] # rax = &("Введите размерность угла x (в радианах от -5 до 5): ")
	mov	rdi, rax # rdi = rax
	mov	eax, 0 # eax = 0
	call	printf@PLT # выводим строку
	lea	rax, -8[rbp] # rax = &(-8 на стеке)
	mov	rsi, rax # rsi = rax
	lea	rax, .LC3[rip] # rax = &("%lf")
	mov	rdi, rax # rdi = rax
	mov	eax, 0 # eax = 0
	call	__isoc99_scanf@PLT # считываем x
	# если он введен в нужных пределах, то просто идем дальше, а иначе снова ввод
	movsd	xmm0, QWORD PTR -8[rbp]
	comisd	xmm0, QWORD PTR .LC4[rip]
	ja	.L15
	movsd	xmm1, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR .LC5[rip]
	comisd	xmm0, xmm1
	jbe	.L19
.L15:
	lea	rax, .LC6[rip]
	mov	rdi, rax
	call	puts@PLT
	jmp	.L14
.L19:
	mov	rax, QWORD PTR -8[rbp] # rax = (-8 на стеке)
	movq	xmm0, rax # xmm0 = rax = x
	call	sin # вызов sin
	movq	rax, xmm0 # rax = xmm0
	movq	xmm0, rax # xmm0 = rax
	mov	esi, 23 # esi = 23
	lea	rax, .LC7[rip] # rax = &("sin(x) = %.*lf\n")
	mov	rdi, rax # rdi = rax
	mov	eax, 1 # eax = 1
	call	printf@PLT # выводим строку
	mov	eax, 0 # eax = 0
	leave # завершение программы
	ret
	.align 8
# подставные значения
.LC0:
	.long	-755914244
	.long	1061184077
	.align 8
.LC1:
	.long	-755914244
	.long	-1086299571
	.align 8
.LC4:
	.long	0
	.long	1075052544
	.align 8
.LC5:
	.long	0
	.long	-1072431104
