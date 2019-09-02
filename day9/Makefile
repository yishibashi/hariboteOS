CFLAGS = -c -m32 -march=i486 -fno-pic -nostdlib

ipl.bin : ipl.asm 
	nasm ipl.asm -o ipl.bin -l ipl.lst

asmhead.bin : asmhead.asm 
	nasm asmhead.asm -o asmhead.bin -l asmhead.lst

nasmfunc.o : nasmfunc.asm 
	nasm -g -f elf nasmfunc.asm -o nasmfunc.o -l nasmfunc.lst


%.o : %.c
	gcc $(CFLAGS) $*.c -o $*.o



OBJS = nasmfunc.o bootpack.o dsctbl.o graphic.o hankaku.o int.o sprintf.o fifo.o keyboard.o mouse.o
bootpack.hrb :  os.lds $(OBJS)
	ld -m elf_i386 -T os.lds $(OBJS) -o $@



haribote.sys : asmhead.bin bootpack.hrb 
	cat asmhead.bin bootpack.hrb > haribote.sys

haribote.img : ipl.bin haribote.sys 
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy haribote.sys -i haribote.img ::


# +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

default:
	make img

.PHONY: asm
asm :
	make -r ipl.bin

.PHONY: img
img :
	make -r haribote.img

.PHONY: run
run : haribote.img
	make img
	qemu-system-i386 -fda haribote.img 

.PHONY: debug
debug :
	make img
	qemu-system-i386 -fda haribote.img -gdb tcp::10000 -S

.PHONY: clean
clean : 
	rm *.lst *.bin *.sys *.img *.hrb *.o 
