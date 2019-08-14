
default:
	make img

ipl.bin : ipl.asm 
	nasm ipl.asm -o ipl.bin -l ipl.lst

asmhead.bin : asmhead.asm 
	nasm asmhead.asm -o asmhead.bin -l asmhead.lst

nasmfunc.o : nasmfunc.asm 
	nasm -g -f elf nasmfunc.asm -o nasmfunc.o -l nasmfunc.lst

makefont : makefont.c
	gcc -c -m32 -march=i486 -fno-pic -nostdlib makefont.c -o makefont

hankaku.o : hankaku.c
	gcc -c -m32 -march=i486 -fno-pic -nostdlib hankaku.c -o hankaku.o

graphic.o : graphic.c 
	gcc -c -m32 -march=i486 -fno-pic -nostdlib graphic.c -o graphic.o

dsctbl.o : dsctbl.c
	gcc -c -m32 -march=i486 -fno-pic -nostdlib dsctbl.c -o dsctbl.o

bootpack.o : bootpack.c
	gcc -c -m32 -march=i486 -fno-pic -nostdlib bootpack.c
#bootpack.hrb : bootpack.c hankaku.c os.lds nasmfunc.o graphic.o dsctbl.o 
#	gcc -march=i486 -m32 -fno-pic -nostdlib -T 
bootpack.hrb :  os.lds nasmfunc.o bootpack.o dsctbl.o graphic.o hankaku.o
	ld -m elf_i386 -T os.lds nasmfunc.o bootpack.o dsctbl.o graphic.o hankaku.o -o bootpack.hrb

haribote.sys : asmhead.bin bootpack.hrb 
	cat asmhead.bin bootpack.hrb > haribote.sys

haribote.img : ipl.bin haribote.sys 
	mformat -f 1440 -C -B ipl.bin -i haribote.img ::
	mcopy haribote.sys -i haribote.img ::

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
	rm *.lst *.bin *.sys *.img *.hrb *.o makefont
