# ファイル生成規則

ipl.img : ipl.asm Makefile
	nasm ipl.asm -o ipl.img -l ipl.lst

img : ipl.img Makefile
	nasm ipl.asm -o ipl.img -l ipl.lst

run : ipl.img Makefile
	qemu-system-i386 ipl.img
