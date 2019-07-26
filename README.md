# haribote

## day1

- したこと
  1. バイナリ直書き．面倒．
  2. アセンブラで書き直す．

- アセンブラ命令. [NASM - The Netwide Assembler, docs](https://www.nasm.us/xdoc/2.14.02/html/nasmdoc0.html), [index](https://nasm.us/doc/nasmdoci.html)

  - DB ... data byte. ファイルの内容を1バイトだけ直接書く命令．
  - RESB ... reserve byte.
  - DW ... data word. DB命令の仲間. word は16ビット=2バイトの事．
  - DD ... data double-word. 同上．
  - $ ... 現在の行が先頭から何バイト目がを教えてくれる変数．(厳密には違うらしい.)
