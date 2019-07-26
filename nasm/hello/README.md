# NASM 

30日OS本ではnaskを使っているが一般的な(?)nasmを用いることもできるらしい．

## アセンブラで遊ぶ.

### hello world

- [参考１](http://hironemu.hatenablog.com/entry/20090210/1234279094)
- [参考２](http://www.mztn.org/lxasm/asm01.html)

```nasm
;------------------------------------
; hello.asm
;------------------------------------
section .text
global _start

msg             db   'hello, world', 0x0A
msglen          equ  $ - msg

_start:
                mov    ecx, msg
                mov    edx, msglen
                mov    eax, 4
                mov    ebx, 1
                int    0x80
                mov    eax, 1
                mov    ebx, 0
                int    0x80
;------------------------------------

```

実行するには,

```
$ nasm -f elf64 hello.asm
$ ld -s -o hello hello.o
$ ./hello
hello, world
```
とする.



