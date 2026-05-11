	.file	"hexRewrite.c"
	.text
	.section	.rodata
.LC0:
	.string	"binary.out"
.LC1:
	.string	"r"
	.align 8
.LC2:
	.string	"[ERROR]: could not open the file '%s'!\n"
.LC3:
	.string	"%08x  "
.LC4:
	.string	"%02x "
.LC5:
	.string	" |"
.LC6:
	.string	"|"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$512064, %rsp
	movq	$.LC0, -24(%rbp)
	movq	$0, -512064(%rbp)
	movq	$0, -512056(%rbp)
	leaq	-512048(%rbp), %rax
	movl	$511984, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	movq	-24(%rbp), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L2
	movq	stderr(%rip), %rax
	movq	-24(%rbp), %rdx
	movl	$.LC2, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L2:
	movq	-32(%rbp), %rax
	movl	$2, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	ftell
	movq	%rax, -40(%rbp)
	movq	-32(%rbp), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek
	movq	-32(%rbp), %rcx
	movq	-40(%rbp), %rdx
	leaq	-512064(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	fread
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	leaq	-512064(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L3
.L11:
	movq	-48(%rbp), %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -49(%rbp)
	movq	-8(%rbp), %rax
	andl	$15, %eax
	testq	%rax, %rax
	jne	.L4
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
.L4:
	movzbl	-49(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movq	-40(%rbp), %rax
	subq	$1, %rax
	cmpq	%rax, -8(%rbp)
	je	.L5
	movq	-8(%rbp), %rax
	andl	$15, %eax
	cmpq	$15, %rax
	jne	.L6
.L5:
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	movq	-8(%rbp), %rax
	andq	$-16, %rax
	movq	%rax, -16(%rbp)
	jmp	.L7
.L10:
	movq	-48(%rbp), %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -50(%rbp)
	cmpb	$31, -50(%rbp)
	jbe	.L8
	cmpb	$126, -50(%rbp)
	ja	.L8
	movzbl	-50(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	jmp	.L9
.L8:
	movl	$46, %edi
	call	putchar
.L9:
	addq	$1, -16(%rbp)
.L7:
	movq	-16(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jbe	.L10
	movl	$.LC6, %edi
	call	puts
.L6:
	addq	$1, -8(%rbp)
.L3:
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.L11
	movl	$10, %edi
	call	putchar
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.5.0 20240719 (Red Hat 11.5.0-5)"
	.section	.note.GNU-stack,"",@progbits
