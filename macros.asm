MACRO farcall
	ld a, BANK(\1)
	rst $10
	call \1
ENDM

MACRO dbw
	db BANK(\1)
	dw \1
ENDM

