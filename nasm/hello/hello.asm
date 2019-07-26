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
