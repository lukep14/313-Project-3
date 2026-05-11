	.file	"hexRewrite.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"binary.out"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"[ERROR]: could not open the file '%s'!\n"
	.section	.rodata.str1.1
.LC3:
	.string	"%08x  "
.LC4:
	.string	"%02x "
.LC5:
	.string	" |"
.LC6:
	.string	"|"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	xorl	%esi, %esi
	pxor	%xmm0, %xmm0
	movl	$511984, %edx
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$512000, %rsp
	.cfi_def_cfa_offset 512048
	leaq	16(%rsp), %rdi
	movaps	%xmm0, (%rsp)
	call	memset
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	fopen
	testq	%rax, %rax
	je	.L25
	movq	%rax, %rbp
	movl	$2, %edx
	xorl	%esi, %esi
	movq	%rax, %rdi
	call	fseek
	movq	%rbp, %rdi
	xorl	%ebx, %ebx
	call	ftell
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	fseek
	movq	%rbp, %rcx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rsp, %rdi
	leaq	-1(%r12), %r13
	call	fread
	movq	%rbp, %rdi
	call	fclose
	testq	%r12, %r12
	jne	.L11
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L4:
	xorl	%eax, %eax
	movzbl	%bpl, %esi
	movl	$.LC4, %edi
	call	printf
	cmpq	$15, %r14
	je	.L13
	cmpq	%r13, %rbx
	je	.L13
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L12
.L11:
	movq	%rbx, %r14
	movzbl	(%rsp,%rbx), %ebp
	andl	$15, %r14d
	jne	.L4
	movq	%rbx, %rsi
	movl	$.LC3, %edi
	xorl	%eax, %eax
	call	printf
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L13:
	movq	%rbx, %rbp
	movl	$.LC5, %edi
	xorl	%eax, %eax
	call	printf
	andq	$-16, %rbp
	cmpq	%rbx, %rbp
	ja	.L10
	.p2align 4,,10
	.p2align 3
.L7:
	movzbl	(%rsp,%rbp), %edi
	leal	-32(%rdi), %eax
	cmpb	$94, %al
	jbe	.L23
	movl	$46, %edi
.L23:
	call	putchar
	addq	$1, %rbp
	cmpq	%rbx, %rbp
	jbe	.L7
.L10:
	movl	$.LC6, %edi
	addq	$1, %rbx
	call	puts
	cmpq	%rbx, %r12
	jne	.L11
.L12:
	movl	$10, %edi
	call	putchar
	addq	$512000, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L25:
	.cfi_restore_state
	movq	stderr(%rip), %rdi
	movl	$.LC1, %edx
	movl	$.LC2, %esi
	xorl	%eax, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.5.0 20240719 (Red Hat 11.5.0-5)"
	.section	.note.GNU-stack,"",@progbits
