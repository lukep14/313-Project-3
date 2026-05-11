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
	.text
	.globl	main
	.type	main, @function
main:
.LFB22:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
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
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movl	$511984, %edx
	movl	$0, %esi
	leaq	16(%rsp), %rdi
	call	memset
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	fopen
	testq	%rax, %rax
	je	.L16
	movq	%rax, %rbx
	movl	$2, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek
	movq	%rbx, %rdi
	call	ftell
	movq	%rax, %r12
	movl	$0, %edx
	movl	$0, %esi
	movq	%rbx, %rdi
	call	fseek
	movq	%rbx, %rcx
	movq	%r12, %rdx
	movl	$1, %esi
	movq	%rsp, %rdi
	call	fread
	movq	%rbx, %rdi
	call	fclose
	testq	%r12, %r12
	je	.L3
	movl	$0, %ebx
	leaq	-1(%r12), %r13
	jmp	.L11
.L16:
	movl	$.LC1, %edx
	movl	$.LC2, %esi
	movq	stderr(%rip), %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %edi
	call	exit
.L4:
	movzbl	%bpl, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	cmpq	%rbx, %r13
	je	.L12
	cmpq	$15, %r14
	je	.L12
.L5:
	addq	$1, %rbx
	cmpq	%rbx, %r12
	je	.L3
.L11:
	movzbl	(%rsp,%rbx), %ebp
	movq	%rbx, %r14
	andl	$15, %r14d
	jne	.L4
	movq	%rbx, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	jmp	.L4
.L12:
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	movq	%rbx, %rbp
	andq	$-16, %rbp
	cmpq	%rbx, %rbp
	jbe	.L10
.L7:
	movl	$.LC6, %edi
	call	puts
	jmp	.L5
.L8:
	movl	$46, %edi
	call	putchar
.L9:
	addq	$1, %rbp
	cmpq	%rbx, %rbp
	ja	.L7
.L10:
	movzbl	(%rsp,%rbp), %edi
	leal	-32(%rdi), %eax
	cmpb	$94, %al
	ja	.L8
	movzbl	%dil, %edi
	call	putchar
	jmp	.L9
.L3:
	movl	$10, %edi
	call	putchar
	movl	$0, %eax
	addq	$512000, %rsp
	.cfi_def_cfa_offset 48
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
	.cfi_endproc
.LFE22:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.5.0 20240719 (Red Hat 11.5.0-5)"
	.section	.note.GNU-stack,"",@progbits
