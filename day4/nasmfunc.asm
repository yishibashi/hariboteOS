; naskfunc
; TAB=4

;[FORMAT "WOOFF"]							; オブジェクトファイルを作るモード
;[BITS 32]									; 32ビットモード用の機械語を作らせる

; オブジェクトファイルのための情報

;[FILE "naskfunc.nas"]						; ソースファイル名情報

;		GLOBAL _io_hlt						; このプログラムに含まれる関数名

; 以下は実際の関数

;[SECTION .text] 							; オブジェクトファイルではこれを書いてからプログラムを書く

section .text
		GLOBAL _io_hlt
		GLOBAL _write_mem8

_io_hlt:	; void io_hlt(void);
		HLT
		RET

_write_mem8:	; void _write_mem8(int addr, int data);
		MOV			ECX, [ESP+4]			; [ESP+4]にaddrが入っているのでそれをECXに読み込む
		MOV			AL,[ESP+8]				; [ESP+8]にdataが入っているのでそれをALに読み込む
		MOV			[ECX],AL
		RET

