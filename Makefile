# def var
MEMSIZE	:= 0x40
TARGET	:= main
CC		:= sdcc
AS		:= sdasz80
CFLAGS	:=
LFLAGS	:= -Wl -u
MFLAGS	:= -mz80 --code-loc 0x0006 --data-loc 0x0000 --vc --verbose

all: ${TARGET}.bin ${TARGET}_padded.bin

#add crt0
crt0.rel: crt0.s
	$(AS) -plosgffw crt0.rel crt0.s

#compile + link
${TARGET}.ihx: ${TARGET}.c crt0.rel
	$(CC) $(MFLAGS) $(LFLAGS) --no-std-crt0 crt0.rel ${TARGET}.c

# ihx to bin
${TARGET}.bin: ${TARGET}.ihx
	makebin -p < ${TARGET}.ihx > ${TARGET}.bin

${TARGET}_padded.bin: ${TARGET}.ihx
	sdobjcopy -Iihex -Obinary --gap-fill 0x00 --pad-to ${MEMSIZE} ${TARGET}.ihx ${TARGET}_padded.bin

#disaemble
disasm: ${TARGET}.bin
	z80dasm -g 0x0 -l ${TARGET}.bin

#print machine code
dump: ${TARGET}.bin
	xxd -c 16 -i ${TARGET}.bin

dumppad: ${TARGET}_padded.bin
	xxd -c 16 -i ${TARGET}_padded.bin

clean:
	rm -f ${TARGET} *.cdb *.rel *.hex *.ihx *.lst *.map *.o *.rst *.sym *.lnk *.lib *.bin *.mem *.lk *.noi *.asm