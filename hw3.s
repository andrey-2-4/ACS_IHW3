	.intel_syntax noprefix
	.text
	.globl	factorial
	.type	factorial, @function
factorial:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi
	cmp	QWORD PTR -8[rbp], 1
	jbe	.L2
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, 1
	mov	rdi, rax
	call	factorial
	imul	rax, QWORD PTR -8[rbp]
	jmp	.L4
.L2:
	mov	eax, 1
.L4:
	leave
	ret
	.size	factorial, .-factorial
	.globl	sin
	.type	sin, @function
sin:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	movsd	QWORD PTR -40[rbp], xmm0
	mov	DWORD PTR -4[rbp], -1
	mov	QWORD PTR -16[rbp], 3
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -32[rbp], xmm0
	jmp	.L6
.L11:
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
.L8:
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	mulsd	xmm0, QWORD PTR -48[rbp]
	movsd	QWORD PTR -48[rbp], xmm0
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	factorial
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
.L6:
	movsd	xmm0, QWORD PTR -32[rbp]
	comisd	xmm0, QWORD PTR .LC0[rip]
	jnb	.L11
	movsd	xmm0, QWORD PTR .LC1[rip]
	comisd	xmm0, QWORD PTR -32[rbp]
	jnb	.L11
	movsd	xmm0, QWORD PTR -24[rbp]
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	ret
	.size	sin, .-sin
	.section	.rodata
	.align 8
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
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
.L14:
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -8[rbp]
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
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
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	call	sin
	movq	rax, xmm0
	movq	xmm0, rax
	mov	esi, 23
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
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
