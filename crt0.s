	.module	crt0
	.globl	_main
	.area	_HEADER (ABS)

	.org 0x0080
init:
	ld		sp,#0xFFFF
	call	_main
