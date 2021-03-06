# haribote

memo
```
$ nasm hoge.nas -o hoge.img // -l hoge.lst を追加すると対応する機械語が表示できる
$ qemu-system-i386 hoge.img // 上手く行かないときは, -fda というオプションを付ける
```

## day1

- したこと
  1. バイナリ直書き．面倒．
  2. アセンブラで書き直す． 次の変更を加える. (NASMとnaskの違いによるエラー？？？)
     ```
       ; RESB  0x1fe-$         ; 0x001feまでを0x00で埋める命令
       RESB  0x1fe-($-$$)    ; 0x001feまでを0x00で埋める命令
     ```
     warning が出てくるのは REST を TIMES に変更すれば解消できる. 例) ``RESB 18`` -> ``TIMES 18 DB 0``

- アセンブラ命令. [NASM - The Netwide Assembler, docs](https://www.nasm.us/xdoc/2.14.02/html/nasmdoc0.html), [index](https://nasm.us/doc/nasmdoci.html)

  - DB ... data byte. ファイルの内容を1バイトだけ直接書く命令．
  - RESB ... reserve byte.
  - DW ... data word. DB命令の仲間. word は16ビット=2バイトの事．
  - DD ... data double-word. 同上．
  - $ ... 現在の行が先頭から何バイト目がを教えてくれる変数．(厳密には違うらしい.)
  - $$ ... 現在のセクションの最初を表す.

## day2

- したこと
  1. CD-ROMの projects/02_days を作業ディレクトリにコピー.(アーカイブマネージャーを使えばCD-ROMの中身を見ることができる．)
  2. helloos3/helloos.nas のl.58を``RESB    0x7dfe-0x7c00-($-$$)``に変更すると動く.[参考](https://qiita.com/pollenjp/items/d15fce401bccd37e8059#helloos3%E3%81%A7%E8%A9%B0%E3%81%BE%E3%81%A3%E3%81%9F%E3%81%A8%E3%81%93%E3%82%8D) 
  3. helloos4/ipl.nas も同様.

- アセンブラ命令.
  - $$ ... 現在のセクションの最初を表す.
  - ORG ... origin. 機械語が実行時にPCのメモリのどこに読み込まれるかを教える命令．

    >The function of the ORG directive is to specify the origin address which NASM will assume the program begins at when it is loaded into memory.
  - JUMP ... そのままの意味. C言語でいうgoto文.
  - MOV ... move. 代入．
  - \<label name\>: ... entry: , putloop: など．　ラベルの宣言.
  - ADD ... 足し算.
  - CMP ... 比較命令.
  - JE ... 条件ジャンプ. 比較命令の結果によってジャンプをしたりしなかったりする．
    ```
      CMP AL,0
      JE fin
      MOV AH, 0x03
    ```
    は, C言語でいうと
    ```
      if (AL == 0) { goto fin; }
      AH = 0x03;
    ```
  - INT ... interrupt. ソフトウェア割り込み命令.
  - HLT ... halt. CPUを停止, 待機状態にする.

  に等しい.


- レジスタ
  16bit.
  - AX ... accumulator, AX = AH(high) + AL(low).
  - CX ... counter
  - DX ... data
  - BX ... base
  - SP ... stack pointer, スタック用ポインタ
  - BP ... base pointer, ベース用ポインタ
  - SI ... source index, 読み込みインデックス
  - DI ... destination index, 書き込みインデックス
  8bit.
  - AL
  - CL
  - DL
  - BL
  - AH
  - CH
  - DH
  - BH
  セグメントレジスタ,16bit. day3で説明.
  - ES
  - CS
  - SS
  - DS
  - FS
  - GS


## day3

著者作成のツールを使わない人向け．（面倒な所が多い）


- 書籍のリンク(... community.osdev.info ...)は古いので[こちら](http://oswiki.osask.jp/?%28AT%29BIOS)を参考にする.
- fdaオプションをつける.
  ```
  $ qemu-system-i386  -fda hoge.img
  ```

- 参考文献・リンク
  - [30日OS自作入門-3日目（C言語導入）-](https://motojiroxx.hatenablog.com/entry/2018/06/11/004414)
  - [OS自作入門 3日目-2 【Linux】| デバッグして実行順序を追ってみる](http://bttb.s1.valueserver.jp/wordpress/blog/2017/12/06/makeos-3-2/)
  - [『30日でできる！OS自作入門』をLinuxでやってみる 3日目](https://syusui.tumblr.com/post/109884535088/30%E6%97%A5%E3%81%A7%E3%81%A7%E3%81%8D%E3%82%8Bos%E8%87%AA%E4%BD%9C%E5%85%A5%E9%96%80%E3%82%92linux%E3%81%A7%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-3%E6%97%A5%E7%9B%AE?is_related_post=1)
  - [Linuxがブートするまで](https://keichi.net/post/linux-boot/)
  - [linux-inside](https://0xax.gitbooks.io/linux-insides/)

- したこと
  - IPL(初期プログラムローダ)の作成.
  - 5 OS本体を書き始める: haribote.sys と ipl.bin をくっつける.(Makefile参照.)
    ```
    mformat -f 1440 -C -B ipl.bin -i haribote.img ::
    mcopy haribote.sys -i haribote.img ::
    ```
 - 9 ついにC言語導入へ: 参考文献・リンクを参考にする．(これもMakefile参照.)



- アセンブラ命令.
  - JC ... jump if carry. キャリーフラグが１だったらジャンプしなさい，という命令. ``INT 0x10``を読んでエラーがない場合はキャリーフラグが０，エラーがある場合はキャリーフラグが１になる．
  - JNC ... jump if not carry.
  - JBE ... jump if below or equal
  - JB ... jump if below 
  - EQU ... C言語でいう#define. 定数を宣言するのに使う.


## day4
(メモを取るのを忘れてた.)

- INSERT命令は追加せずにnasmのオプションで指定した.

- アセンブラ命令.


## day5

- したこと
  - 5 フォントを増やしたい　までは本に沿って進めていくだけ．
  - 5　でフォントを増やすために配布されていた makefont.c を改造して  
    ```
     char hankaku[4096] = {
	   0x00,0x00, ..., 0x00
	   ... ...
	   0x00, 0x18, ..., 0xe7, 0x00, 0x00 // A
	   ... ...
	   ...
	 };
	```
	というコードを hankaku.c というファイルに掃き出しそれを bootpack.c から読み込むようにした.
  - sprintf 動かず. 取り敢えず，sprintf を bootpack.c に直接書いた．
  - あとは本に従っていく.



## day6

- したこと
  - bootpack.c の分割.
    - Makefile を修正した. 特に ``-fno-pic`` オプションを付け忘れると動かないことに注意する.(このあたりはよくわかってない.[参考, OS自作入門 6日目-1 【Linux】 | 分割コンパイル](http://bttb.s1.valueserver.jp/wordpress/blog/2017/12/21/makeos-6-1/))
  - あとは本に書いてる通りにすすめていけるはず。

## day7

- したこと
  - 本のとおりに進めていくだけ.

## day8

- したこと
  - 本のとおりに進めていくだけ.

## day9
