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
		GLOBAL io_hlt, io_cli, io_sti, io_stihlt
		GLOBAL io_in8, io_in16, io_in32
		GLOBAL io_out8, io_out16, io_out32
		GLOBAL io_load_eflags, io_store_eflags
		GLOBAL load_gdtr, load_idtr



io_hlt:	; void io_hlt(void);
		HLT
		RET

io_cli:
		CLI
		RET

io_sti:
		STI
		RET

io_stihlt:
		STI
		HLT
		RET

io_in8:
		MOV			EDX,[ESP+4]
		MOV			EAX,0
		IN			AL,DX
		RET

io_in16:
		MOV			EDX,[ESP+4]
		MOV			EAX,0
		IN			AX,DX
		RET

io_in32:
		MOV			EDX,[ESP+4]
		IN			EAX,DX
		RET

io_out8:
		MOV			EDX,[ESP+4]
		MOV			AL,[ESP+8]
		OUT			DX,AL
		RET

io_out16:
		MOV			EDX,[ESP+4]
		MOV			EAX,[ESP+8]
		OUT			DX,AX
		RET

io_out32:
		MOV			EDX,[ESP+4]
		MOV			EAX,[ESP+8]
		OUT			DX,EAX
		RET

io_load_eflags:
		PUSHFD
		POP			EAX
		RET

io_store_eflags:
		MOV			EAX,[ESP+4]
		PUSH		EAX
		POPFD
		RET
load_gdtr:		; void load_gdtr(int limit, int addr)
		mov		ax, [esp + 4]		; limit
		mov 	[esp + 6], ax
		lgdt	[esp + 6]
		ret

load_idtr:		; void load_idtr(int limit, int addr)
		mov		ax, [esp + 4]		; limit
		mov 	[esp + 6], ax
		lidt	[esp + 6]
		ret
