# 313-Project-3 Luke Parrish
Hexdump of Binary file written in C 

DIFFERENCES BETWEEN -O0 -O1 -O3
--------------------------------
All 3 outputs have very similar lengths (160, 158, 164, respectively).
This minimal difference shows that length of code is not representative of any substantial optimizations.

We know that -O0 has no optimization effect on the generated assembly making it a 1:1 translation and therefore a reference template when comparing to -O1 and -O3

First difference is how the 500kb are allocated to memory. 
In -O1, we push 512064 bits to the stack with a frame pointer:
pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$512064, %rsp

In -O2 and -O3, these are distributed between other 5 registers and stores 512000 exactly 
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

  AND

  pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	xorl	%esi, %esi
	pxor	%xmm0, %xmm0
	movl	$511984, %edx

  All the registers call memset, which officially dedicates the memory to the buffer that is used  to read off the material in the binary.
  But 03 before calling memset does this zeroing with a single 16 byte zeroing vs -o1 and -o0's two 8 bit moves 

For the loop with index i, a key difference is that each time in -O0 the index has to be moved from memory to be loaded into and compared to 15 when determining whether or not we've reached the end of a row..

movb	%al, -49(%rbp)
	movq	-8(%rbp), %rax
	andl	$15, %eax
	testq	%rax, %rax
	jne	.L4

  vs -O1 and -O3 respectively:

  movzbl	(%rsp,%rbx), %ebp
	movq	%rbx, %r14
	andl	$15, %r14d
	jne	.L4

  movq	%rbx, %r14
	movzbl	(%rsp,%rbx), %ebp
	andl	$15, %r14d
	jne	.L4


  A unique  thing that stands out with -O3 is the addition of "p2align" within the data section before _start:
  .LC6:
	.string	"|"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function

  This is effectively registry padding 
  .p2align 4,,10
	.p2align 3

The purpose of padding is to make memory retrieval easier in contiguous memory that is evenly spread in a certain number  than not. The 4 and 10 and 3 are padding to make the instructions segmented with a certain length


-O1 optimization is primarily concerned with minor optimizations such as unnecessary memory to register calls while -O3 is concerned with new algorithms to make memory retrieval and several operations much faster. 


OUTPUT OF PROGRAM (Photo from UMBC's GLSERVER)
<img width="1012" height="901" alt="image" src="https://github.com/user-attachments/assets/53a4cb6a-2d8c-43f7-ba84-6dd406c0e5da" />
