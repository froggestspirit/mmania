farcall: MACRO
	ld a, BANK(\1)
	rst $10
	call \1
ENDM