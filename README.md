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


OUTPUT OF PROGRAM

00000000  2a 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00  |*...............|
00000010  28 00 00 80 18 00 00 00 b0 04 00 00 00 00 00 00  |(...............|
00000020  00 00 00 00 00 00 00 00 0c 00 00 00 38 00 00 00  |............8...|
00000030  18 00 00 00 02 00 00 00 00 00 4c 05 00 00 01 00  |..........L.....|
00000040  2f 75 73 72 2f 6c 69 62 2f 6c 69 62 53 79 73 74  |/usr/lib/libSyst|
00000050  65 6d 2e 42 2e 64 79 6c 69 62 00 00 00 00 00 00  |em.B.dylib......|
00000060  26 00 00 00 10 00 00 00 90 80 00 00 08 00 00 00  |&...............|
00000070  29 00 00 00 10 00 00 00 98 80 00 00 00 00 00 00  |)...............|
00000080  1d 00 00 00 10 00 00 00 00 81 00 00 98 01 00 00  |................|
00000090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
000000a0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
000000b0  ff 03 01 d1 fd 7b 03 a9 fd c3 00 91 09 00 00 90  |.....{..........|
000000c0  29 91 15 91 2a 01 40 b9 a8 23 00 d1 aa 83 1f b8  |)...*.@..#......|
000000d0  29 11 40 39 a9 c3 1f 38 09 00 00 90 29 a5 15 91  |).@9...8....)...|
000000e0  2a 01 40 b9 ab 43 00 d1 eb 0b 00 f9 aa 03 1f b8  |*.@..C..........|
000000f0  29 09 40 79 a9 43 1f 78 09 00 00 90 29 bd 15 91  |).@y.C.x....)...|
00000100  e9 0f 00 f9 09 00 00 90 29 d1 15 91 e9 0f 00 f9  |........).......|
00000110  e9 03 00 91 28 01 00 f9 00 00 00 90 00 e4 15 91  |....(...........|
00000120  0e 00 00 94 e8 0b 40 f9 e9 03 00 91 28 01 00 f9  |......@.....(...|
00000130  00 00 00 90 00 1c 16 91 08 00 00 94 00 00 00 90  |................|
00000140  00 54 16 91 05 00 00 94 00 00 80 52 fd 7b 43 a9  |.T.........R.{C.|
00000150  ff 03 01 91 c0 03 5f d6 30 00 00 90 10 02 40 f9  |......_.0.....@.|
00000160  00 02 1f d6 30 31 32 33 34 66 69 72 73 74 00 62  |....01234first.b|
00000170  65 61 72 00 63 61 74 73 00 0a 73 74 72 69 6e 67  |ear.cats..string|
00000180  31 3d 28 25 73 29 00 0a 73 74 72 69 6e 67 32 3d  |1=(%s)..string2=|
00000190  28 25 73 29 00 0a 45 4f 4a 0a 00 00 01 00 00 00  |(%s)..EOJ.......|
000001a0  1c 00 00 00 00 00 00 00 1c 00 00 00 00 00 00 00  |................|
000001b0  1c 00 00 00 02 00 00 00 b0 04 00 00 40 00 00 00  |............@...|
000001c0  40 00 00 00 58 05 00 00 00 00 00 00 40 00 00 00  |@...X.......@...|
000001d0  00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  |................|
000001e0  0c 00 01 00 10 00 01 00 00 00 00 00 00 00 00 04  |................|
000001f0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  |................|
