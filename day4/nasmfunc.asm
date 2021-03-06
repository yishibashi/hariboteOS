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
		GLOBAL _io_hlt, _io_cli, _io_sti, _io_stihlt
		GLOBAL _io_in8, _io_in16, _io_in32
		GLOBAL _io_out8, _io_out16, _io_out32
		GLOBAL _io_load_eflags, _io_store_eflags



_io_hlt:	; void io_hlt(void);
		HLT
		RET

_io_cli:
		CLI
		RET

_io_sti:
		STI
		RET

_io_stihlt:
		STI
		HLT
		RET

_io_in8:
		MOV			EDX,[ESP+4]
		MOV			EAX,0
		IN			AL,DX
		RET

_io_in16:
		MOV			EDX,[ESP+4]
		MOV			EAX,0
		IN			AX,DX
		RET

_io_in32:
		MOV			EDX,[ESP+4]
		IN			EAX,DX
		RET

_io_out8:
		MOV			EDX,[ESP+4]
		MOV			AL,[ESP+8]
		OUT			DX,AL
		RET

_io_out16:
		MOV			EDX,[ESP+4]
		MOV			EAX,[ESP+8]
		OUT			DX,AX
		RET

_io_out32:
		MOV			EDX,[ESP+4]
		MOV			EAX,[ESP+8]
		OUT			DX,EAX
		RET

_io_load_eflags:
		PUSHFD
		POP			EAX
		RET

_io_store_eflags:
		MOV			EAX,[ESP+4]
		PUSH		EAX
		POPFD
		RET

