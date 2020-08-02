farcall: MACRO
	ld a, BANK(\1)
	rst $10
	call \1
ENDM

dbw: MACRO
	db BANK(\1)
	dw \1
ENDM

