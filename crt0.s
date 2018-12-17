	.module	crt0
	.globl	_main
	.area	_HEADER (ABS)

	.org 0x0
init:
	ld		sp,#0x0040
	call	_main
