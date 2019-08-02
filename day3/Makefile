
default:
	make img

ipl.bin : ipl.asm Makefile
	nasm ipl.asm -o ipl.bin -l ipl.lst

asmhead.bin : asmhead.asm Makefile
	nasm asmhead.asm -o asmhead.bin -l asmhead.lst

nasmfunc.o : nasmfunc.asm Makefile
	nasm -g -f elf nasmfunc.asm -o nasmfunc.o -l nasmfunc.lst

bootpack.hrb : bootpack.c os.lds nasmfunc.o Makefile
	gcc -march=i486 -m32 -fno-pic -nostdlib -T os.lds nasmfunc.o bootpack.c -o bootpack.hrb

haribote.sys : asmhead.bin bootpack.hrb Makefile
	cat asmhead.bin bootpack.hrb > haribote.sys

haribote.img : ipl.bin haribote.sys Makefile
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy haribote.sys -i haribote.img ::

asm :
	make -r ipl.bin

img :
	make -r haribote.img

run : haribote.img
	make img
	qemu-system-i386 -fda haribote.img 

debug :
	make img
	qemu-system-i386 -fda haribote.img -gdb tcp::10000 -S

clean : 
	rm *.lst *.bin *.sys *.img *.hrb
