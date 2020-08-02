INCLUDE "macros.asm"

SECTION "bank00", ROM0

SECTION "rst00", ROM0[$00]
	ret

SECTION "rst08", ROM0[$08]
JumpList::
	jp Logged_0x0932

SECTION "rst10", ROM0[$10]
BankSwitch::
	ld [$FF00+$8C],a
	ld [$2000],a
	ret

SECTION "rst18", ROM0[$18]
	ret

SECTION "rst20", ROM0[$20]
	ret

SECTION "rst28", ROM0[$28]
	ret

SECTION "rst30", ROM0[$30]
	ret

SECTION "rst38", ROM0[$38]
	ret

SECTION "vblankInt", ROM0[$40]
	jp Logged_0x0331

UnknownData_0x0043:
INCBIN "baserom.gb", $0043, $0048 - $0043

SECTION "lcdstatInt", ROM0[$48]
	jp Logged_0x041D

UnknownData_0x004B:
INCBIN "baserom.gb", $004B, $0050 - $004B

SECTION "timerInt", ROM0[$50]

UnknownData_0x0050:
INCBIN "baserom.gb", $0050, $0058 - $0050

SECTION "serialInt", ROM0[$58]
	jp Logged_0x048D

UnknownData_0x005B:
INCBIN "baserom.gb", $005B, $0060 - $005B

SECTION "joypadInt", ROM0[$60]

UnknownData_0x0060:
INCBIN "baserom.gb", $0060, $0100 - $0060

SECTION "start", ROM0[$100]
	nop
	jp Init

SECTION "Header", ROM0[$134]
	db "MOGURANYA",0,0,0,0,0,0,0;Title
	db $30,$31;0x144 New Licensee Code
	db $03;SGB Flag
	db $03;Cart Type
	db $04;ROM Size
	db $02;RAM Size
	db $01;Destination Code
	db $33;Old Licensee Code
	db $00;Version

SECTION "Home", ROM0[$150]

Init:
	di
	ld sp,$DFFE
	ld a,$01
	rst BankSwitch
	ld a,$02
	call Logged_0x1626
	ld b,$3C
	call Logged_0x16BA
	call Logged_0x4000
	call Logged_0x1543
	jr Logged_0x0173

Logged_0x0169:
	di
	ld sp,$DFFE
	farcall Logged_0x404D

Logged_0x0173:
	farcall Logged_0x1C000
	ld a,$01
	rst BankSwitch
	ei
	ld a,$0D
	call Logged_0x1629

Logged_0x0182:
	ld a,[$C156]
	and a
	jr nz,Logged_0x0192
	ld hl,$C0DE
	ld c,$42
	ld a,[hli]
	ld [$FF00+c],a
	inc c
	ld a,[hl]
	ld [$FF00+c],a

Logged_0x0192:
	ld hl,$C0AC
	ld a,[hl]
	and a
	jr z,Logged_0x01AA
	dec [hl]
	xor a
	ld [$FF00+$8B],a
	ld a,[$C0FE]
	and a
	jp nz,Logged_0x025A
	xor a
	ld [$FF00+$96],a
	jp Logged_0x025A

Logged_0x01AA:
	ld a,$20
	ld [$FF00+$00],a
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	cpl
	and $0F
	swap a
	ld b,a
	ld a,$30
	ld [$FF00+$00],a
	ld a,$10
	ld [$FF00+$00],a
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	cpl
	and $0F
	or b
	ld c,a
	ld a,[$FF00+$8A]
	xor c
	and c
	ld [$FF00+$8B],a
	ld a,c
	ld [$FF00+$8A],a
	ld a,$30
	ld [$FF00+$00],a
	ld a,[$C0FE]
	and a
	jr nz,Unknown_0x01F7
	ld hl,$FF95
	ld a,[$FF00+$8A]
	ld [hli],a
	ld a,[$FF00+$8B]
	ld [hl],a
	jr Logged_0x025A

Unknown_0x01F7:
	ld a,[$C0F8]
	ld c,a
	ld b,$00
	ld hl,$C100
	add hl,bc
	ld a,[hl]
	cp $F0
	jr c,Unknown_0x020E
	xor a
	ld hl,$C10A
	ld [hli],a
	ld [hl],a
	jr Logged_0x025A

Unknown_0x020E:
	ld e,l
	ld d,h
	ld a,[$D120]
	xor $01
	add a,a
	ld c,a
	ld b,$00
	ld hl,$FF93
	add hl,bc
	ld a,[de]
	ld c,a
	ld a,[hli]
	xor c
	and c
	ld [hld],a
	ld [hl],c
	ld a,[$C0F7]
	ld c,a
	ld b,$00
	ld hl,$C100
	add hl,bc
	ld e,l
	ld d,h
	ld a,[$D120]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$FF93
	add hl,bc
	ld a,[de]
	ld c,a
	ld a,[hli]
	xor c
	and c
	ld [hld],a
	ld [hl],c
	ld a,[$FF00+$8A]
	ld [$C10D],a
	ld a,[$C0FE]
	cp $01
	jr z,Unknown_0x0255
	ld a,[$FF00+$8A]
	ld [$C104],a
	jr Logged_0x025A

Unknown_0x0255:
	ld a,[$FF00+$8A]
	ld [$C109],a

Logged_0x025A:
	ld a,[$D12C]
	rra
	jr nc,Logged_0x0285
	ld d,$F0
	ld a,[$FF00+$95]
	ld b,a
	cp d
	jr nc,Logged_0x0285
	ld a,[$FF00+$93]
	ld c,a
	cp d
	jr nc,Logged_0x0285
	ld d,$0F
	ld a,c
	cp d
	jr z,Logged_0x0278
	ld a,b
	cp d
	jr nz,Logged_0x0285

Logged_0x0278:
	xor a
	ld [$D262],a
	ld bc,$0108
	call Logged_0x0AE5
	jp Logged_0x0169

Logged_0x0285:
	call Logged_0x02CF
	ld hl,$C15C
	ld a,[hli]
	and $0F
	call nz,Logged_0x0323
	ld hl,$C707
	res 0,[hl]
	ld hl,$D24A
	inc [hl]
	xor a
	ld [$D249],a
	ld a,[$C0FE]
	and a
	jr nz,Unknown_0x02BA
	db $76;halt
	ld hl,$C0A5

Logged_0x02A8:
	bit 0,[hl]
	jr z,Logged_0x02A8
	res 0,[hl]
	ld hl,$FF92
	inc [hl]
	ld a,$03
	call Logged_0x1331
	jp Logged_0x0182

Unknown_0x02BA:
	ld hl,$C0FA
	xor a
	ld [hl],a
	db $76;halt

Unknown_0x02C0:
	ld a,[hl]
	and a
	jr z,Unknown_0x02C0
	ld hl,$FF92
	inc [hl]
	ld hl,$D25E
	inc [hl]
	jp Logged_0x0182

Logged_0x02CF:
	ld a,[$FF00+$90]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$02DD
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x02DD:
INCBIN "baserom.gb", $02DD, $02E5 - $02DD

UnknownData_0x02E5:
INCBIN "baserom.gb", $02E5, $02F1 - $02E5

LoggedData_0x02F1:
INCBIN "baserom.gb", $02F1, $02F3 - $02F1

UnknownData_0x02F3:
INCBIN "baserom.gb", $02F3, $02F5 - $02F3

LoggedData_0x02F5:
INCBIN "baserom.gb", $02F5, $02F7 - $02F5

UnknownData_0x02F7:
INCBIN "baserom.gb", $02F7, $02F9 - $02F7

LoggedData_0x02F9:
INCBIN "baserom.gb", $02F9, $02FB - $02F9

UnknownData_0x02FB:
INCBIN "baserom.gb", $02FB, $02FF - $02FB
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x20000
	pop af
	rst BankSwitch
	ret

UnknownData_0x030B:
INCBIN "baserom.gb", $030B, $0323 - $030B

Logged_0x0323:
	rra
	jr c,Logged_0x0329
	inc hl
	jr Logged_0x0323

Logged_0x0329:
	ld a,[hl]
	ld [$FF00+$47],a
	xor a
	ld [$C15C],a
	ret

Logged_0x0331:
	push af
	push bc
	push de
	push hl
	di
	ld a,[$D12E]
	and a
	jr z,Logged_0x034A
	call $FF80 ;Unknown bank
	call Logged_0x095F
	ld hl,$C0A5
	set 0,[hl]
	jp Logged_0x0376

Logged_0x034A:
	ld a,[$C0FE]
	and a
	jr nz,Logged_0x0359
	ld a,[$C0AC]
	ld hl,$D249
	or [hl]
	jr nz,Logged_0x035F

Logged_0x0359:
	call $FF80 ;Unknown bank
	call Logged_0x095F

Logged_0x035F:
	call Logged_0x1393
	ld hl,$C0A5
	set 0,[hl]
	ld a,[$D134]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$039C
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

Logged_0x0376:
	ld a,[$C156]
	cp $02
	jr nz,Logged_0x0386
	ld hl,$C1A4
	ld a,[hli]
	ld [$FF00+$42],a
	ld a,[hl]
	ld [$FF00+$43],a

Logged_0x0386:
	ld a,[$C0FE]
	ld hl,$C0F9
	and [hl]
	jr z,Logged_0x0393
	ld a,$81
	ld [$FF00+$02],a

Logged_0x0393:
	ei
	call Logged_0x0463
	pop hl
	pop de
	pop bc
	pop af
	reti

LoggedData_0x039C:
INCBIN "baserom.gb", $039C, $03A6 - $039C
	xor a
	ld [$FF00+$47],a
	ld hl,$FF40
	set 6,[hl]
	res 3,[hl]
	ld a,$E3
	ld [$C0A7],a
	ld b,$00
	ld a,[$C0FE]
	and a
	jr nz,Logged_0x03DB
	ld b,$03
	jr Logged_0x03DB
	ld a,$FF
	ld [$FF00+$47],a
	ld hl,$FF40
	res 6,[hl]
	set 3,[hl]
	ld a,$AB
	ld [$C0A7],a
	ld b,$00
	ld a,[$C0FE]
	and a
	jr nz,Logged_0x03DB
	ld b,$04

Logged_0x03DB:
	ld hl,$D134
	ld [hl],b
	jr Logged_0x0376
	ld b,$7B
	ld a,[$FF00+$90]
	cp $0C
	jr z,Logged_0x040D
	ld b,$77
	cp $0E
	jr z,Logged_0x040D
	ld a,[$CFDD]
	add a,a
	add a,$48
	ld b,a
	jr Logged_0x040D
	ld b,$7C
	ld a,[$FF00+$90]
	cp $0C
	jr z,Logged_0x040D
	ld b,$79
	cp $0E
	jr z,Logged_0x040D
	ld a,[$CFDD]
	add a,a
	add a,$49
	ld b,a

Logged_0x040D:
	ld a,b
	push af
	call Logged_0x164B
	pop af
	call Logged_0x3262
	xor a
	ld [$D134],a
	jp Logged_0x0376

Logged_0x041D:
	push af
	push hl
	push bc
	ld a,[$C128]
	ld c,a
	ld b,$00
	ld hl,$C12A
	add hl,bc
	ld c,$12

Logged_0x042C:
	nop
	dec c
	jr nz,Logged_0x042C
	ld a,[hli]
	ld [$FF00+$42],a
	ld a,[hli]
	ld [$FF00+$43],a
	ld a,[hli]
	ld [$FF00+$45],a
	ld a,[hl]
	ld hl,$FF40
	rra
	jr c,Logged_0x0444
	res 1,[hl]
	jr Logged_0x0446

Logged_0x0444:
	set 1,[hl]

Logged_0x0446:
	ld hl,$C127
	inc [hl]
	ld a,[$C129]
	cp [hl]
	jr z,Logged_0x0459
	ld hl,$C128
	ld a,[hl]
	add a,$04
	ld [hl],a
	jr Logged_0x045E

Logged_0x0459:
	xor a
	ld [hl],a
	ld [$C128],a

Logged_0x045E:
	pop bc
	pop hl
	pop af
	reti

UnknownData_0x0462:
INCBIN "baserom.gb", $0462, $0463 - $0462

Logged_0x0463:
	ld hl,$D244
	ld de,$DC00
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	xor a
	ld [hld],a
	ld [hld],a
	ld [hl],a
	ld a,[$FF00+$8C]
	push af
	ld a,[$D243]
	ld c,a
	ld b,$00
	ld hl,$048A
	add hl,bc
	ld a,[hl]
	rst BankSwitch
	call Logged_0x1C002
	pop af
	rst BankSwitch
	ret

LoggedData_0x048A:
INCBIN "baserom.gb", $048A, $048D - $048A

Logged_0x048D:
	push af
	push bc
	push de
	push hl
	di
	ld a,$80
	ld [$FF00+$02],a
	ld a,[$C0FE]
	and a
	jr nz,Unknown_0x04AE
	ld a,[$FF00+$01]
	ld [$C100],a
	ld a,[$C109]
	ld [$FF00+$01],a
	ld a,$01
	ld [$C0FA],a
	jp Logged_0x05AE

Unknown_0x04AE:
	ld a,[$D262]
	and a
	jp z,Unknown_0x0582
	ld a,[$C0FA]
	and a
	jr z,Unknown_0x04D6
	ld hl,$D25A
	ld a,[hld]
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hli],a
	ld a,[$FF00+$01]
	ld [hl],a
	ld hl,$D12B
	set 2,[hl]
	ld a,$F5
	ld [$FF00+$01],a
	xor a
	ld [$C0FA],a
	jp Logged_0x05AE

Unknown_0x04D6:
	ld hl,$D12B
	bit 2,[hl]
	jr z,Unknown_0x0512
	res 2,[hl]
	ld a,[$FF00+$01]
	cp $F5
	jr nz,Unknown_0x04F0
	ld a,[$C10C]
	ld [$C10D],a
	ld a,[$D25B]
	jr Unknown_0x04F2

Unknown_0x04F0:
	ld a,[$FF00+$01]

Unknown_0x04F2:
	ld [$D25C],a
	ld hl,$C10A
	ld a,[hli]
	ld d,a
	ld a,[hld]
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hl],a
	ld a,[$D259]
	ld e,a
	ld hl,$D12C
	set 7,[hl]
	ld a,$01
	ld [$C0FA],a
	jr Unknown_0x0565

Unknown_0x0512:
	ld hl,$D12C
	bit 7,[hl]
	jr z,Unknown_0x053B
	res 7,[hl]
	ld hl,$C10A
	ld a,[hli]
	ld d,a
	ld a,[hld]
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hl],a
	ld hl,$D25A
	ld a,[hld]
	ld e,a
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hl],a
	ld a,$01
	ld [$C0FA],a
	jr Unknown_0x0565

Unknown_0x053B:
	ld a,[$FF00+$01]
	cp $F5
	jr nz,Unknown_0x0547
	xor a
	ld [$C0FA],a
	jr Unknown_0x057B

Unknown_0x0547:
	ld hl,$C10A
	ld a,[hli]
	ld d,a
	ld a,[hld]
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hli],a
	inc hl
	ld a,[hld]
	ld [hl],a
	ld hl,$D25A
	ld a,[hld]
	ld [hli],a
	ld e,a
	inc hl
	ld a,[hld]
	ld [hli],a
	ld a,[$FF00+$01]
	ld [hl],a
	ld a,$01
	ld [$C0FA],a

Unknown_0x0565:
	ld a,[$C0F8]
	ld c,a
	ld b,$00
	ld hl,$C100
	add hl,bc
	ld [hl],e
	ld a,[$C0F7]
	ld c,a
	ld b,$00
	ld hl,$C100
	add hl,bc
	ld [hl],d

Unknown_0x057B:
	ld a,[$C10D]
	ld [$FF00+$01],a
	jr Logged_0x05AE

Unknown_0x0582:
	ld a,[$C0F8]
	ld c,a
	ld b,$00
	ld hl,$C100
	add hl,bc
	ld a,[$FF00+$01]
	ld [hl],a
	ld a,[$C0F7]
	ld c,a
	ld b,$00
	ld hl,$C100
	add hl,bc
	ld a,[$C10A]
	ld [hl],a
	ld hl,$C10D
	ld a,[hld]
	dec hl
	dec hl
	ld [hl],a
	ld a,[$C109]
	ld [$FF00+$01],a
	ld a,$01
	ld [$C0FA],a

Logged_0x05AE:
	ei
	pop hl
	pop de
	pop bc
	pop af
	reti

Logged_0x05B4:
	ld c,$80
	ld b,$0A
	ld hl,$05C2

Logged_0x05BB:
	ld a,[hli]
	ld [$FF00+c],a
	inc c
	dec b
	jr nz,Logged_0x05BB
	ret

LoggedData_0x05C2:
INCBIN "baserom.gb", $05C2, $05CC - $05C2

Logged_0x05CC:
	call Logged_0x0ADC
	ld a,[$D12A]
	bit 6,a
	jr nz,Logged_0x05E0
	call Logged_0x0765

Logged_0x05D9:
	ld a,$0E
	call Logged_0x1629
	jr Logged_0x05E5

Logged_0x05E0:
	ld a,$0B
	call Logged_0x1629

Logged_0x05E5:
	ld a,$03
	call Logged_0x1629

Logged_0x05EA:
	di
	ld a,[$FF00+$FF]
	ld [$C0A6],a
	and $FE
	ld [$FF00+$FF],a
	ei

Logged_0x05F5:
	ld a,[$FF00+$44]
	cp $91
	jr c,Logged_0x05F5
	ld a,[$FF00+$40]
	and $7F
	ld [$FF00+$40],a
	ld a,[$C109]
	cp $FD
	ret z
	xor a
	ld [$C109],a
	ld [$FF00+$01],a
	ret

Logged_0x060E:
	ld hl,$FF47
	ld de,$D24C
	ld a,[hl]
	ld [de],a
	xor a
	ld [hli],a
	inc de
	ld a,[hl]
	ld [de],a
	xor a
	ld [hli],a
	inc de
	ld a,[hl]
	ld [de],a
	xor a
	ld [hl],a
	call Logged_0x064A
	ld a,[$D12A]
	bit 6,a
	jp z,Logged_0x0829
	ld hl,$FF47
	ld de,$D24C
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld a,[$C0A0]
	bit 7,a
	ret z
	ld b,$02
	call Logged_0x16BA
	xor a
	jp Logged_0x1629

Logged_0x064A:
	ld a,[$C0FE]
	rst JumpList
	dw Logged_0x0747
	dw Unknown_0x0652

Unknown_0x0652:
	di
	ld hl,$FF93
	ld de,$C10E
	ld c,$04
	call Logged_0x092B
	ld a,[$FF00+$FF]
	and $F8
	ld [$FF00+$FF],a
	ei
	ld hl,$C10A
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$D259
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld a,[$C0F8]
	ld c,a
	ld b,$00
	ld hl,$C100
	add hl,bc
	ld e,l
	ld d,h
	ld hl,$C0FA
	xor a
	ld [hl],a
	ld a,[$C0F9]
	and a
	jr z,Unknown_0x06E6
	ld c,$10

Unknown_0x068D:
	xor a
	ld [$C109],a
	ld a,$81
	ld [$FF00+$02],a

Unknown_0x0695:
	ld a,[hl]
	and a
	jr z,Unknown_0x0695
	xor a
	ld [hl],a
	push bc
	call Unknown_0x0759
	pop bc
	dec c
	jr nz,Unknown_0x068D
	ld b,$00

Unknown_0x06A5:
	xor a
	ld [$C109],a
	ld a,$81
	ld [$FF00+$02],a

Unknown_0x06AD:
	ld a,[hl]
	and a
	jr z,Unknown_0x06AD
	xor a
	ld [hl],a
	ld a,b
	cp $3C
	jr c,Unknown_0x06BE
	call Logged_0x0747
	jp Logged_0x0169

Unknown_0x06BE:
	ld a,[de]
	cp $FA
	jr z,Unknown_0x06CB
	push bc
	call Unknown_0x0759
	pop bc
	inc b
	jr Unknown_0x06A5

Unknown_0x06CB:
	ld c,$02

Unknown_0x06CD:
	ld a,$FA
	ld [$C109],a
	ld a,$81
	ld [$FF00+$02],a

Unknown_0x06D6:
	ld a,[hl]
	and a
	jr z,Unknown_0x06D6
	xor a
	ld [hl],a
	dec c
	jr z,Unknown_0x0735
	push bc
	call Unknown_0x0759
	pop bc
	jr Unknown_0x06CD

Unknown_0x06E6:
	ld c,$10

Unknown_0x06E8:
	xor a
	ld [$C109],a
	ld hl,$0000
	ld b,$00

Unknown_0x06F1:
	inc hl
	ld a,h
	or l
	jr nz,Unknown_0x06FC
	inc b
	ld a,b
	cp $02
	jr z,Unknown_0x071E

Unknown_0x06FC:
	ld a,[$C0FA]
	and a
	jr z,Unknown_0x06F1
	xor a
	ld [$C0FA],a
	dec c
	jr nz,Unknown_0x06E8

Unknown_0x0709:
	ld a,$FA
	ld [$C109],a
	ld bc,$0000
	ld l,$00

Unknown_0x0713:
	inc bc
	ld a,b
	or c
	jr nz,Unknown_0x0724
	inc l
	ld a,l
	cp $02
	jr nz,Unknown_0x0724

Unknown_0x071E:
	call Logged_0x0747
	jp Logged_0x0169

Unknown_0x0724:
	ld a,[$C0FA]
	and a
	jr z,Unknown_0x0713
	xor a
	ld [$C0FA],a
	ld a,[de]
	cp $FA
	jr z,Unknown_0x0735
	jr Unknown_0x0709

Unknown_0x0735:
	xor a
	ld [$C109],a
	ld [$C0FA],a
	ld hl,$C10E
	ld de,$FF93
	ld c,$04
	call Logged_0x092B

Logged_0x0747:
	xor a
	ld [$FF00+$0F],a
	ld a,[$C0A6]
	ld [$FF00+$FF],a
	ld a,[$C0A7]
	ld [$FF00+$40],a
	ld a,[$FF00+$06]
	ld [$FF00+$05],a
	ret

Unknown_0x0759:
	ld bc,$06D6

Unknown_0x075C:
	nop
	nop
	nop
	dec bc
	ld a,b
	or c
	jr nz,Unknown_0x075C
	ret

Logged_0x0765:
	ld a,[$C0A0]
	bit 7,a
	jr nz,Unknown_0x07C0
	ld c,$03

Logged_0x076E:
	ld b,$04

Logged_0x0770:
	dec b
	jr z,Logged_0x07AC
	ld a,[$C0FE]
	rst JumpList
	dw Logged_0x077B
	dw Unknown_0x0787

Logged_0x077B:
	db $76;halt
	ld hl,$C0A5

Logged_0x077F:
	bit 0,[hl]
	jr z,Logged_0x077F
	res 0,[hl]
	jr Logged_0x07AA

Unknown_0x0787:
	db $76;halt
	ld hl,$0000
	xor a
	ld [$D25F],a

Unknown_0x078F:
	inc hl
	ld a,h
	or l
	jr nz,Unknown_0x07A0
	ld a,[$D25F]
	inc a
	ld [$D25F],a
	cp $02
	jp z,Unknown_0x071E

Unknown_0x07A0:
	ld a,[$C0FA]
	and a
	jr z,Unknown_0x078F
	xor a
	ld [$C0FA],a

Logged_0x07AA:
	jr Logged_0x0770

Logged_0x07AC:
	push bc
	ld hl,$FF47
	call Logged_0x080D
	inc hl
	call Logged_0x080D
	inc hl
	call Logged_0x080D
	pop bc
	dec c
	jr nz,Logged_0x076E
	ret

Unknown_0x07C0:
	ld hl,$C181
	xor a
	ld c,$10
	call Logged_0x091D
	ld hl,$C161
	ld de,$C182
	ld c,$08
	call Logged_0x092B
	ld hl,$C181
	ld a,$51
	ld [hli],a
	call Unknown_0x08FF
	ld hl,$C181
	call Unknown_0x16A4
	ld hl,$C182
	call Unknown_0x08FF
	ld hl,$C181
	call Unknown_0x16A4
	ld hl,$C182
	ld de,$01FC
	ld c,$04

Unknown_0x07F7:
	ld a,e
	ld [hli],a
	ld [hl],d
	inc hl
	inc de
	dec c
	jr nz,Unknown_0x07F7
	ld hl,$C181
	call Unknown_0x16A4
	ld hl,$FF47
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ret

Logged_0x080D:
	ld b,$00
	ld d,$C0
	ld e,$40
	ld c,$04

Logged_0x0815:
	ld a,[hl]
	and d
	jr z,Logged_0x081A
	sub e

Logged_0x081A:
	or b
	ld b,a
	srl d
	srl d
	srl e
	srl e
	dec c
	jr nz,Logged_0x0815
	ld [hl],b
	ret

Logged_0x0829:
	ld a,[$C0A0]
	bit 7,a
	jr nz,Unknown_0x0874
	ld c,$03

Logged_0x0832:
	ld b,$04

Logged_0x0834:
	dec b
	jr z,Logged_0x0857
	ld a,[$C0FE]
	rst JumpList
	dw Logged_0x083F
	dw Unknown_0x084B

Logged_0x083F:
	db $76;halt
	ld hl,$C0A5

Logged_0x0843:
	bit 0,[hl]
	jr z,Logged_0x0843
	res 0,[hl]
	jr Logged_0x0855

Unknown_0x084B:
	db $76;halt
	ld hl,$C0FA

Unknown_0x084F:
	ld a,[hl]
	and a
	jr z,Unknown_0x084F
	xor a
	ld [hl],a

Logged_0x0855:
	jr Logged_0x0834

Logged_0x0857:
	push bc
	ld hl,$FF47
	ld a,[$D24C]
	call Logged_0x08D7
	inc hl
	ld a,[$D24D]
	call Logged_0x08D7
	inc hl
	ld a,[$D24E]
	call Logged_0x08D7
	pop bc
	dec c
	jr nz,Logged_0x0832
	ret

Unknown_0x0874:
	ld hl,$C181
	xor a
	ld c,$10
	call Logged_0x091D
	ld hl,$C161
	ld de,$C182
	ld c,$08
	call Logged_0x092B
	ld hl,$C181
	ld a,$51
	ld [hli],a
	call Unknown_0x08FF
	ld hl,$C182
	call Unknown_0x08FF
	ld hl,$C181
	call Unknown_0x16A4
	ld hl,$FF47
	ld de,$D24C
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	xor a
	call Logged_0x1629
	ld hl,$C161
	ld de,$C182
	ld c,$08
	call Logged_0x092B
	ld hl,$C182
	call Unknown_0x08FF
	ld hl,$C181
	call Unknown_0x16A4
	ld hl,$C161
	ld de,$C182
	ld c,$08
	call Logged_0x092B
	ld hl,$C181
	jp Unknown_0x16A4

Logged_0x08D7:
	ld [$D24B],a
	ld b,$00
	ld d,$C0
	ld e,$40
	ld c,$04

Logged_0x08E2:
	push bc
	ld a,[hl]
	and d
	ld c,a
	ld a,[$D24B]
	and d
	cp c
	jr z,Logged_0x08EF
	ld a,c
	add a,e

Logged_0x08EF:
	pop bc
	or b
	ld b,a
	srl d
	srl d
	srl e
	srl e
	dec c
	jr nz,Logged_0x08E2
	ld [hl],b
	ret

Unknown_0x08FF:
	ld c,$04

Unknown_0x0901:
	ld a,[hli]
	ld d,[hl]
	ld e,a
	push hl
	ld hl,$00AA
	add hl,de
	ld e,l
	ld a,h
	pop hl
	ld [hld],a
	ld [hl],e
	inc hl
	inc hl
	dec c
	jr nz,Unknown_0x0901
	ret

Logged_0x0914:
	ld [hli],a
	ld d,a
	dec bc
	ld a,b
	or c
	ld a,d
	jr nz,Logged_0x0914
	ret

Logged_0x091D:
	ld [hli],a
	dec c
	jr nz,Logged_0x091D
	ret

Logged_0x0922:
	ld a,[hli]
	ld [de],a
	inc de
	dec bc
	ld a,b
	or c
	jr nz,Logged_0x0922
	ret

Logged_0x092B:
	ld a,[hli]
	ld [de],a
	inc de
	dec c
	jr nz,Logged_0x092B
	ret

Logged_0x0932:
	pop hl
	push de
	ld e,a
	ld d,$00
	add hl,de
	add hl,de
	pop de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

Logged_0x093E:
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	push de
	ld a,[hli]
	ld b,a
	ld a,[hli]
	ld c,a
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	pop hl

Logged_0x094C:
	push bc
	push hl

Logged_0x094E:
	ld a,[de]
	inc de
	ld [hli],a
	dec c
	jr nz,Logged_0x094E
	pop hl
	ld b,$00
	ld c,$20
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x094C
	ret

Logged_0x095F:
	ld hl,$C708
	ld a,[hli]
	add a,a
	ld d,$00
	ld e,a
	add hl,de
	add hl,de
	add hl,de
	inc hl
	ld d,h
	ld e,l
	ld a,[hld]
	or a
	jr nz,Logged_0x0977
	ld hl,$D129
	res 0,[hl]
	ret

Logged_0x0977:
	inc de
	ld a,[de]
	or a
	ret z
	inc de
	ld a,[$D129]
	set 0,a
	ld [$D129],a
	ld a,[$FF00+$41]
	bit 1,a
	ret nz
	ld a,[$C707]
	and a
	ret nz
	push hl
	call Logged_0x093E
	ld hl,$C708
	ld a,[hl]
	inc a
	and $1F
	ld [hl],a
	pop hl
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ret

Logged_0x09A3:
	ld hl,$C707
	ld a,$01
	ld [hld],a
	ld a,[hl]
	ld c,a
	inc a
	and $1F
	ld [hli],a
	ld a,c
	add a,a
	ld b,$00
	ld c,a
	add hl,bc
	add hl,bc
	add hl,bc
	ld bc,$0007
	add hl,bc
	inc de
	inc de
	inc de
	inc de
	inc de
	ld b,$06

Logged_0x09C2:
	ld a,[de]
	dec de
	ld [hld],a
	dec b
	jr nz,Logged_0x09C2
	ret

Logged_0x09C9:
	push af
	ld hl,$9800
	ld a,$01
	ld bc,$0400
	call Logged_0x0914
	ld hl,$48AA
	pop af
	ld d,$00
	add a,a
	ld e,a
	add hl,de
	ld a,[$FF00+$8C]
	push af
	ld a,$02
	rst BankSwitch
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hli]
	ld c,a

Logged_0x09E9:
	push hl
	ld a,[hli]
	ld h,[hl]
	ld l,a
	push bc
	call Logged_0x093E
	pop bc
	pop hl
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x09E9
	ld a,$0A
	rst BankSwitch
	ld de,$9867
	ld hl,$CA44
	ld b,$07

Logged_0x0A03:
	ld c,$09

Logged_0x0A05:
	push bc
	ld a,[hli]
	push hl
	push de
	push de
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$4000
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hld],a
	inc de
	ld bc,$0020
	add hl,bc
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	pop de
	inc de
	inc de
	pop hl
	inc hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz,Logged_0x0A05
	push bc
	push hl
	ld hl,$002E
	add hl,de
	ld e,l
	ld d,h
	pop hl
	ld bc,$001C
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x0A03
	ld de,$9C67
	ld hl,$CA44
	ld b,$07

Logged_0x0A49:
	ld c,$09

Logged_0x0A4B:
	push bc
	ld a,[hli]
	inc hl
	ld b,[hl]
	cp $10
	jr c,Logged_0x0A59
	cp $20
	jr nc,Logged_0x0A59
	ld b,$43

Logged_0x0A59:
	ld a,b
	push hl
	push de
	push de
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld bc,$4200
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hld],a
	inc de
	ld bc,$0020
	add hl,bc
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	pop de
	inc de
	inc de
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz,Logged_0x0A4B
	push bc
	push hl
	ld hl,$002E
	add hl,de
	ld e,l
	ld d,h
	pop hl
	ld bc,$001C
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x0A49
	pop af
	rst BankSwitch
	ret

Logged_0x0A96:
	ld b,a
	ld a,[$FF00+$8C]
	push af
	ld a,$02
	rst BankSwitch
	ld h,$00
	ld l,b
	add hl,hl
	ld de,$4CDC
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hli]
	ld c,a

Logged_0x0AAA:
	push bc
	ld a,$02
	rst BankSwitch
	push hl
	ld a,[hli]
	ld b,a
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	push de
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld c,a
	ld a,[hli]
	push af
	ld a,b
	rst BankSwitch
	pop af
	ld b,a
	pop hl
	call Logged_0x0922
	pop hl
	ld de,$0007
	add hl,de
	pop bc
	dec c
	jr nz,Logged_0x0AAA
	pop af
	rst BankSwitch
	ret

Logged_0x0AD2:
	ld hl,$C200
	ld bc,$0400
	xor a
	call Logged_0x0914

Logged_0x0ADC:
	ld hl,$C000
	ld c,$A0
	xor a
	jp Logged_0x091D

Logged_0x0AE5:
	call Logged_0x0B1B
	ld a,$01
	ld [$D245],a
	ld a,$0F
	ld [$D246],a
	ld c,$01
	jp Logged_0x0B1B

Logged_0x0AF7:
	ld hl,$D245
	set 1,[hl]
	call Logged_0x0B1B
	ld a,$0F
	ld [$D246],a
	ld c,$01
	jp Logged_0x0B1B

Logged_0x0B09:
	call Logged_0x0B1B
	ld a,$04
	ld [$D245],a
	ld a,$0F
	ld [$D246],a
	ld c,$01
	jp Logged_0x0B1B

Logged_0x0B1B:
	ld a,[$C0FE]
	rst JumpList
	dw Logged_0x0B23
	dw Unknown_0x0B2F

Logged_0x0B23:
	db $76;halt
	ld hl,$C0A5

Logged_0x0B27:
	bit 0,[hl]
	jr z,Logged_0x0B27
	res 0,[hl]
	jr Logged_0x0B39

Unknown_0x0B2F:
	db $76;halt
	ld hl,$C0FA

Unknown_0x0B33:
	ld a,[hl]
	and a
	jr z,Unknown_0x0B33
	xor a
	ld [hl],a

Logged_0x0B39:
	push bc
	ld hl,$0B4B
	push hl
	ld a,b
	add a,a
	ld c,a
	ld b,$00
	ld hl,$0B50
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	pop bc
	dec c
	jr nz,Logged_0x0B1B
	ret

LoggedData_0x0B50:
INCBIN "baserom.gb", $0B50, $0B56 - $0B50
	call Logged_0x2958
	jp Logged_0x0B60
	ret
	jp Logged_0x0ED4

Logged_0x0B60:
	xor a
	ld [$C701],a
	ld de,$C000
	ld hl,$C200
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C220
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C240
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C260
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C280
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C2A0
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C2C0
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C2E0
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C300
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	ld hl,$C320
	ld a,[hli]
	and a
	call nz,Logged_0x0C23
	jp Logged_0x0BF4

Unknown_0x0BBA:
	xor a
	ld [$C701],a
	ld de,$C000
	ld hl,$C200
	ld a,[hli]
	and a
	call nz,Unknown_0x0CF7
	ld hl,$C220
	ld a,[hli]
	and a
	call nz,Unknown_0x0CF7
	ld hl,$C240
	ld a,[hli]
	and a
	call nz,Unknown_0x0CF7
	ld hl,$C260
	ld a,[hli]
	and a
	call nz,Unknown_0x0CF7
	ld hl,$C280
	ld a,[hli]
	and a
	call nz,Unknown_0x0CF7
	ld hl,$C2A0
	ld a,[hli]
	and a
	call nz,Unknown_0x0CF7
	jp Logged_0x0BF4

Logged_0x0BF4:
	ld h,d
	ld l,e
	ld b,$A0

Logged_0x0BF8:
	ld a,l
	cp b
	jr z,Logged_0x0C03
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	jr Logged_0x0BF8

Logged_0x0C03:
	xor a
	ld [$C701],a
	ret

UnknownData_0x0C08:
INCBIN "baserom.gb", $0C08, $0C23 - $0C08

Logged_0x0C23:
	push bc
	push hl
	ld a,[hli]
	ld [$C700],a
	ld c,a
	ld a,[hli]
	add a,a
	ld b,a
	push hl
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc hl
	ld a,[hld]
	add a,e
	ld e,a
	ld a,d
	adc a,[hl]
	pop hl
	ld [hli],a
	ld [$C702],a
	ld a,e
	ld [hli],a
	inc hl
	inc hl
	push hl
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	push hl
	inc hl
	ld a,[hli]
	inc [hl]
	add a,e
	ld e,a
	ld a,d
	pop hl
	adc a,[hl]
	pop hl
	ld [hli],a
	ld [$C703],a
	ld [hl],e

Logged_0x0C55:
	ld d,$0D
	ld hl,$4000
	ld e,c
	ld a,e
	cp $A8
	jr c,Logged_0x0C68
	sub $A8
	ld e,a
	ld d,$1A
	ld hl,$6900

Logged_0x0C68:
	ld a,[$FF00+$8C]
	push af
	ld a,d
	rst BankSwitch
	ld d,$00
	add hl,de
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld e,b
	add hl,de
	ld a,[hli]
	ld e,a
	ld a,[hl]
	cp $F0
	jr z,Unknown_0x0C8D
	cp $F1
	jp nz,Logged_0x0C9A
	pop af
	rst BankSwitch
	ld a,e
	pop de
	push de
	inc de
	ld [de],a
	add a,a
	ld b,a
	jr Logged_0x0C55

Unknown_0x0C8D:
	pop af
	rst BankSwitch
	ld a,e
	pop de
	push de
	ld [de],a
	inc de
	ld c,a
	xor a
	ld b,a
	ld [de],a
	jr Logged_0x0C55

Logged_0x0C9A:
	ld d,a
	push de
	ld hl,$C600
	ld d,$00
	ld a,[$C700]
	ld e,a
	add hl,de
	ld a,[hl]
	ld [$C700],a
	pop hl
	ld d,$C0
	ld a,[$C701]
	ld e,a
	ld a,[hli]
	ld b,a

Logged_0x0CB3:
	ld a,b
	or a
	jr z,Logged_0x0CEE
	dec b
	ld a,e
	cp $A0
	jr nz,Logged_0x0CCA
	jr Logged_0x0CEE

UnknownData_0x0CBF:
INCBIN "baserom.gb", $0CBF, $0CCA - $0CBF

Logged_0x0CCA:
	ld a,[$C0DE]
	ld c,a
	ld a,[$C702]
	add a,[hl]
	sub c
	ld [de],a
	inc hl
	inc de
	ld a,[$C0DF]
	ld c,a
	ld a,[$C703]
	add a,[hl]
	sub c
	ld [de],a
	inc hl
	inc de
	ld a,[$C700]
	add a,[hl]
	inc hl
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	jr Logged_0x0CB3

Logged_0x0CEE:
	ld a,e
	ld [$C701],a
	pop af
	rst BankSwitch
	pop hl
	pop bc
	ret

Unknown_0x0CF7:
	push bc
	push hl
	ld a,[hli]
	ld [$C700],a
	ld c,a
	ld a,[hli]
	add a,a
	ld b,a
	ld a,[hli]
	ld [$C702],a
	inc hl
	inc hl
	inc hl
	ld a,[hli]
	ld [$C703],a
	inc hl
	inc hl
	inc hl
	inc [hl]

Unknown_0x0D10:
	ld d,$0D
	ld hl,$4000
	ld e,c
	ld a,e
	cp $A8
	jr c,Unknown_0x0D23
	sub $A8
	ld e,a
	ld d,$1A
	ld hl,$6900

Unknown_0x0D23:
	ld a,[$FF00+$8C]
	push af
	ld a,d
	rst BankSwitch
	ld d,$00
	add hl,de
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld e,b
	add hl,de
	ld a,[hli]
	ld e,a
	ld a,[hl]
	cp $F0
	jp z,Unknown_0x0C8D
	cp $F1
	jp nz,Logged_0x0C9A
	pop af
	rst BankSwitch
	ld a,e
	pop de
	push de
	inc de
	ld [de],a
	add a,a
	ld b,a
	jr Unknown_0x0D10

Logged_0x0D49:
	push bc
	push hl
	ld a,[hli]
	ld [$C700],a
	ld c,a
	ld a,[hli]
	add a,a
	ld b,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc hl
	ld a,[hld]
	add a,e
	ld e,a
	ld a,d
	adc a,[hl]
	dec l
	dec l
	ld [hli],a
	ld d,a
	ld a,[$C0DE]
	sub d
	cpl
	inc a
	ld [$C702],a
	ld a,e
	ld [hli],a
	inc l
	inc l
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc l
	ld a,[hli]
	inc [hl]
	add a,e
	ld e,a
	dec l
	dec l
	ld a,d
	adc a,[hl]
	dec l
	dec l
	ld [hli],a
	ld d,a
	ld a,[$C0DF]
	sub d
	cpl
	inc a
	ld [$C703],a
	ld [hl],e

Logged_0x0D89:
	ld d,$03
	ld hl,$4000
	ld e,c
	ld a,e
	cp $80
	jr c,Logged_0x0DA8
	sub $80
	ld e,a
	ld d,$0E
	ld hl,$4000
	cp $28
	jr c,Logged_0x0DA8
	sub $28
	ld e,a
	ld d,$19
	ld hl,$4000

Logged_0x0DA8:
	ld a,[$FF00+$8C]
	push af
	ld a,d
	rst BankSwitch
	ld d,$00
	add hl,de
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld e,b
	add hl,de
	ld a,[hli]
	ld e,a
	ld a,[hl]
	cp $F1
	jr nz,Logged_0x0DC8
	pop af
	rst BankSwitch
	ld a,e
	pop de
	push de
	inc de
	ld [de],a
	add a,a
	ld b,a
	jr Logged_0x0D89

Logged_0x0DC8:
	ld d,a
	ld hl,$C600
	ld b,$00
	ld a,[$C700]
	ld c,a
	add hl,bc
	ld a,[hl]
	ld [$C700],a
	ld l,e
	ld h,d
	ld d,$C0
	ld a,[$C701]
	ld e,a
	ld a,[hli]
	ld b,a

Logged_0x0DE1:
	ld a,b
	or a
	jr z,Logged_0x0E12
	dec b
	ld a,e
	cp $A0
	jr nz,Logged_0x0DF8
	jr Logged_0x0E12

UnknownData_0x0DED:
INCBIN "baserom.gb", $0DED, $0DF8 - $0DED

Logged_0x0DF8:
	ld a,[$C702]
	add a,[hl]
	ld [de],a
	inc hl
	inc e
	ld a,[$C703]
	add a,[hl]
	ld [de],a
	inc hl
	inc e
	ld a,[$C700]
	add a,[hl]
	inc hl
	ld [de],a
	inc e
	ld a,[hli]
	ld [de],a
	inc e
	jr Logged_0x0DE1

Logged_0x0E12:
	ld a,e
	ld [$C701],a
	pop af
	rst BankSwitch
	pop hl
	pop bc
	ret

Logged_0x0E1B:
	push bc
	push hl
	ld a,[hli]
	ld [$C700],a
	ld c,a
	ld a,[hli]
	add a,a
	ld b,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc hl
	ld a,[hld]
	add a,e
	ld e,a
	ld a,d
	adc a,[hl]
	dec l
	dec l
	ld [hli],a
	ld [$C702],a
	ld a,e
	ld [hli],a
	inc l
	inc l
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc l
	ld a,[hli]
	inc [hl]
	add a,e
	ld e,a
	dec l
	dec l
	ld a,d
	adc a,[hl]
	dec l
	dec l
	ld [hli],a
	ld [$C703],a
	ld [hl],e

Logged_0x0E4D:
	ld d,$03
	ld hl,$4000
	ld e,c
	ld a,e
	cp $80
	jr c,Logged_0x0E6C
	sub $80
	ld e,a
	ld d,$0E
	ld hl,$4000
	cp $28
	jr c,Logged_0x0E6C
	sub $28
	ld e,a
	ld d,$19
	ld hl,$4000

Logged_0x0E6C:
	ld a,[$FF00+$8C]
	push af
	ld a,d
	rst BankSwitch
	ld d,$00
	add hl,de
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld e,b
	add hl,de
	ld a,[hli]
	ld e,a
	ld a,[hl]
	cp $F1
	jr nz,Logged_0x0E8C
	pop af
	rst BankSwitch
	ld a,e
	pop de
	push de
	inc de
	ld [de],a
	add a,a
	ld b,a
	jr Logged_0x0E4D

Logged_0x0E8C:
	ld d,a
	ld hl,$C600
	ld b,$00
	ld a,[$C700]
	ld c,a
	add hl,bc
	ld a,[hl]
	ld [$C700],a
	ld l,e
	ld h,d
	ld d,$C0
	ld a,[$C701]
	ld e,a
	ld a,[hli]
	ld b,a

Logged_0x0EA5:
	ld a,b
	or a
	jr z,Logged_0x0ECB
	dec b
	ld a,e
	cp $A0
	jr nz,Logged_0x0EB1
	jr Logged_0x0ECB

Logged_0x0EB1:
	ld a,[$C702]
	add a,[hl]
	ld [de],a
	inc hl
	inc e
	ld a,[$C703]
	add a,[hl]
	ld [de],a
	inc hl
	inc e
	ld a,[$C700]
	add a,[hl]
	inc hl
	ld [de],a
	inc e
	ld a,[hli]
	ld [de],a
	inc e
	jr Logged_0x0EA5

Logged_0x0ECB:
	ld a,e
	ld [$C701],a
	pop af
	rst BankSwitch
	pop hl
	pop bc
	ret

Logged_0x0ED4:
	ld a,[$FF00+$8C]
	push af
	ld a,$0D
	rst BankSwitch
	ld de,$C000
	ld hl,$C0DE
	ld a,[hli]
	ld c,[hl]
	ld b,a
	push bc
	xor a
	ld [hld],a
	ld [hl],a
	ld hl,$C580
	ld b,$03

Logged_0x0EEC:
	ld a,[hli]
	or a
	call nz,Logged_0x0C23
	ld a,l
	add a,$1F
	ld l,a
	ld a,h
	adc a,$00
	ld h,a
	dec b
	jr nz,Logged_0x0EEC
	pop bc
	ld hl,$C0DE
	ld a,b
	ld [hli],a
	ld [hl],c
	call Logged_0x0BF4
	pop af
	rst BankSwitch
	ret

Logged_0x0F09:
	ld a,[$FF00+$92]
	rrca
	jp nc,Logged_0x0F5E
	xor a
	ld [$C701],a
	ld de,$C000
	ld hl,$C200
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C220
	ld a,[hli]
	and a
	jr z,Logged_0x0F2A
	call Logged_0x1284
	jr Logged_0x0F2D

Logged_0x0F2A:
	call Logged_0x1212

Logged_0x0F2D:
	ld hl,$C240
	ld b,$0E

Logged_0x0F32:
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld a,l
	add a,$1F
	ld l,a
	ld a,h
	adc a,$00
	ld h,a
	dec b
	jr nz,Logged_0x0F32
	call Logged_0x11CA

Logged_0x0F45:
	call Logged_0x0BF4
	ld hl,$C400
	ld b,$08

Logged_0x0F4D:
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld a,l
	add a,$1F
	ld l,a
	ld a,h
	adc a,$00
	ld h,a
	dec b
	jr nz,Logged_0x0F4D
	ret

Logged_0x0F5E:
	xor a
	ld [$C701],a
	ld de,$C000
	ld hl,$C200
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C220
	ld a,[hli]
	and a
	jr z,Logged_0x0F79
	call Logged_0x1284
	jr Logged_0x0F7C

Logged_0x0F79:
	call Logged_0x1212

Logged_0x0F7C:
	call Logged_0x11CA
	ld hl,$C3E0
	ld b,$0E

Logged_0x0F84:
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld a,l
	sub $21
	ld l,a
	ld a,h
	sbc a,$00
	ld h,a
	dec b
	jr nz,Logged_0x0F84
	jp Logged_0x0F45

Logged_0x0F97:
	ld a,[$FF00+$92]
	rrca
	jp nc,Logged_0x1034
	xor a
	ld [$C701],a
	ld de,$C000
	ld hl,$C200
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C220
	ld a,[hli]
	and a
	jr z,Logged_0x0FB8
	call Logged_0x1284
	jr Logged_0x0FBB

Logged_0x0FB8:
	call Logged_0x1212

Logged_0x0FBB:
	ld hl,$C240
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C260
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C280
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C2A0
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C2C0
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C2E0
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C300
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C320
	ld a,[hli]
	or a
	call nz,Logged_0x0D49

Logged_0x0FFB:
	ld hl,$C580
	ld a,[hli]
	or a
	call nz,Logged_0x0E1B
	ld hl,$C5A0
	ld a,[hli]
	or a
	call nz,Logged_0x0E1B
	ld hl,$C5C0
	ld a,[hli]
	or a
	call nz,Logged_0x0E1B
	ld hl,$C5E0
	ld a,[hli]
	or a
	call nz,Logged_0x0E1B
	ld h,d
	ld l,e
	ld b,$A0

Logged_0x101F:
	ld a,l
	cp b
	jr z,Logged_0x102A
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	jr Logged_0x101F

Logged_0x102A:
	xor a
	ld [$C701],a
	ld hl,$C421
	jp Logged_0x1212

Logged_0x1034:
	xor a
	ld [$C701],a
	ld de,$C000
	ld hl,$C200
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C220
	ld a,[hli]
	and a
	jr z,Logged_0x104F
	call Logged_0x1284
	jr Logged_0x1052

Logged_0x104F:
	call Logged_0x1212

Logged_0x1052:
	ld hl,$C320
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C300
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C2E0
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C2C0
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C2A0
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C280
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C260
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C240
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	jp Logged_0x0FFB

Logged_0x1095:
	ld a,[$FF00+$92]
	rrca
	jp nc,Logged_0x115B
	call Logged_0x10D3
	ld de,$C000
	ld hl,$C400
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C420
	ld a,[hli]
	and a
	jr z,Logged_0x10B5
	call Logged_0x1284
	jr Logged_0x10B8

Logged_0x10B5:
	call Logged_0x1212

Logged_0x10B8:
	ld hl,$C440
	ld b,$06

Logged_0x10BD:
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld a,l
	add a,$1F
	ld l,a
	ld a,h
	adc a,$00
	ld h,a
	dec b
	jr nz,Logged_0x10BD
	call Logged_0x11CA
	jp Logged_0x0BF4

Logged_0x10D3:
	xor a
	ld [$C701],a
	ld de,$C000
	ld hl,$C200
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C220
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C240
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C260
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C280
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C2A0
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C2C0
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C2E0
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C300
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C320
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C340
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C360
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C380
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C3A0
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C3C0
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ld hl,$C3E0
	ld a,[hli]
	or a
	call nz,Logged_0x1212
	ret

Logged_0x115B:
	call Logged_0x10D3
	ld de,$C000
	ld hl,$C400
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld hl,$C420
	ld a,[hli]
	and a
	jr z,Logged_0x1175
	call Logged_0x1284
	jr Logged_0x1178

Logged_0x1175:
	call Logged_0x1212

Logged_0x1178:
	ld hl,$C4E0
	ld b,$06

Logged_0x117D:
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld a,l
	sub $21
	ld l,a
	ld a,h
	sbc a,$00
	ld h,a
	dec b
	jr nz,Logged_0x117D
	call Logged_0x11CA
	jp Logged_0x0BF4

Logged_0x1193:
	ld a,[$FF00+$92]
	rrca
	jr nc,Logged_0x11B3
	call Logged_0x10D3
	ld de,$C000
	ld hl,$C420
	ld a,[hli]
	and a
	jr z,Logged_0x11AA
	call Logged_0x1284
	jr Logged_0x11AD

Logged_0x11AA:
	call Logged_0x1212

Logged_0x11AD:
	call Logged_0x11F1
	jp Logged_0x0BF4

Logged_0x11B3:
	call Logged_0x10D3
	ld de,$C000
	ld hl,$C420
	ld a,[hli]
	and a
	jr z,Logged_0x11C5
	call Logged_0x1284
	jr Logged_0x11AD

Logged_0x11C5:
	call Logged_0x1212
	jr Logged_0x11AD

Logged_0x11CA:
	ld hl,$C0DE
	ld a,[hli]
	ld c,[hl]
	ld b,a
	push bc
	xor a
	ld [hld],a
	ld [hl],a
	ld hl,$C500
	ld b,$08

Logged_0x11D9:
	ld a,[hli]
	or a
	call nz,Logged_0x0D49
	ld a,l
	add a,$1F
	ld l,a
	ld a,h
	adc a,$00
	ld h,a
	dec b
	jr nz,Logged_0x11D9
	pop bc
	ld hl,$C0DE
	ld a,b
	ld [hli],a
	ld [hl],c
	ret

Logged_0x11F1:
	ld hl,$C580
	ld a,[hli]
	or a
	call nz,Logged_0x0E1B
	ld hl,$C5A0
	ld a,[hli]
	or a
	call nz,Logged_0x0E1B
	ld hl,$C5C0
	ld a,[hli]
	or a
	call nz,Logged_0x0E1B
	ld hl,$C5E0
	ld a,[hli]
	or a
	call nz,Logged_0x0E1B
	ret

Logged_0x1212:
	push de
	push bc
	push hl
	ld a,[hli]
	ld [$C700],a
	ld c,a
	ld a,[hli]
	add a,a
	ld b,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc hl
	ld a,[hld]
	add a,e
	ld e,a
	ld a,d
	adc a,[hl]
	dec l
	dec l
	ld [hli],a
	ld a,e
	ld [hli],a
	inc l
	inc l
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc l
	ld a,[hli]
	inc [hl]
	add a,e
	ld e,a
	dec l
	dec l
	ld a,d
	adc a,[hl]
	dec l
	dec l
	ld [hli],a
	ld [hl],e

Logged_0x123F:
	ld d,$03
	ld hl,$4000
	ld e,c
	ld a,e
	cp $80
	jr c,Logged_0x125E
	sub $80
	ld e,a
	ld d,$0E
	ld hl,$4000
	cp $28
	jr c,Logged_0x125E
	sub $28
	ld e,a
	ld d,$19
	ld hl,$4000

Logged_0x125E:
	ld a,[$FF00+$8C]
	push af
	ld a,d
	rst BankSwitch
	ld d,$00
	add hl,de
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld e,b
	add hl,de
	ld a,[hli]
	ld e,a
	ld a,[hl]
	cp $F1
	jr nz,Logged_0x127E
	pop af
	rst BankSwitch
	ld a,e
	pop de
	push de
	inc de
	ld [de],a
	add a,a
	ld b,a
	jr Logged_0x123F

Logged_0x127E:
	pop af
	rst BankSwitch
	pop hl
	pop bc
	pop de
	ret

Logged_0x1284:
	push bc
	push hl
	inc l
	inc l
	ld a,[$C0F1]
	ld c,a
	ld a,[$C0F2]
	add a,a
	ld b,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc hl
	ld a,[hld]
	add a,e
	ld e,a
	ld a,d
	adc a,[hl]
	dec l
	dec l
	ld [hli],a
	ld d,a
	ld a,[$C0DE]
	sub d
	cpl
	inc a
	ld [$C702],a
	ld a,e
	ld [hli],a
	inc l
	inc l
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	inc l
	ld a,[hli]
	inc [hl]
	add a,e
	ld e,a
	dec l
	dec l
	ld a,d
	adc a,[hl]
	dec l
	dec l
	ld [hli],a
	ld d,a
	ld a,[$C0DF]
	sub d
	cpl
	inc a
	ld [$C703],a
	ld [hl],e
	ld e,c
	ld a,[$FF00+$8C]
	push af
	ld a,$03
	rst BankSwitch
	ld hl,$4000
	ld d,$00
	add hl,de
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld e,b
	add hl,de
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ld h,d
	ld l,e
	ld a,[$C0EE]
	xor $01
	swap a
	rrca
	add a,$70
	ld [$C700],a
	ld d,$C0
	ld a,[$C701]
	ld e,a
	ld a,[hli]
	ld b,a

Logged_0x12F5:
	ld a,b
	or a
	jr z,Logged_0x131B
	dec b
	ld a,[$C702]
	add a,[hl]
	ld [de],a
	inc hl
	inc e
	ld a,[$C703]
	add a,[hl]
	ld [de],a
	inc hl
	inc e
	ld a,[$C700]
	ld [de],a
	inc e
	inc a
	ld [$C700],a
	inc hl
	ld a,[$C705]

Unknown_0x1313:
	or [hl]
	inc hl
	ld [de],a
	inc e
	jr Logged_0x12F5

Logged_0x131B:
	ld a,e
	ld [$C701],a
	pop af
	rst BankSwitch
	pop hl
	pop bc
	ret

Logged_0x1324:
	ld hl,$FF90
	inc [hl]
	xor a
	ld [$FF00+$91],a
	ret

Logged_0x132C:
	ld hl,$FF91
	inc [hl]
	ret

Logged_0x1331:
	ld h,$00
	ld l,a

Logged_0x1334:
	push bc
	push de
	ld d,h
	ld e,l
	ld a,[$C0A8]
	ld c,a
	ld l,a
	ld a,[$C0A9]
	ld b,a
	ld h,a
	add hl,hl
	add hl,bc
	add hl,hl
	add hl,bc
	add hl,hl
	add hl,bc
	add hl,hl
	add hl,hl
	add hl,bc
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,bc
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,bc
	ld a,l
	sub $01
	ld l,a
	ld a,h
	sbc a,$00
	ld h,a
	ld a,l
	ld [$C0A8],a
	ld a,h
	ld [$C0A9],a
	ld b,h
	ld c,l
	ld hl,$0000
	ld a,$10

Logged_0x136C:
	push af
	add hl,hl
	ld a,e
	adc a,a
	ld e,a
	ld a,d
	adc a,a
	ld d,a
	jr nc,Logged_0x137A
	add hl,bc
	jr nc,Logged_0x137A
	inc de

Logged_0x137A:
	pop af
	dec a
	jr nz,Logged_0x136C
	ld h,d
	ld l,e
	ld a,e
	pop de
	pop bc
	ret

Logged_0x1384:
	ld hl,$C0E6
	ld c,$04

Logged_0x1389:
	ld a,$EE
	ld [hli],a
	ld a,$C0
	ld [hli],a
	dec c
	jr nz,Logged_0x1389
	ret

Logged_0x1393:
	ld a,[$FF00+$8C]
	push af
	ld a,$06
	rst BankSwitch
	ld hl,$C0E6
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	ld [hl],a
	ld hl,$C0EA
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	ld [hl],a
	pop af
	rst BankSwitch
	ret

Logged_0x140E:
	ld a,[$FF00+$8C]
	push af
	ld a,$06
	rst BankSwitch
	ld de,$C421
	ld a,[$D141]
	rla
	jr nc,Logged_0x1420
	ld de,$C221

Logged_0x1420:
	ld hl,$C0EF
	ld a,[de]
	inc de
	ld c,a
	ld a,[de]
	ld b,a
	ld a,[hli]
	cp c
	jr nz,Logged_0x1487
	ld a,b
	cp [hl]
	jr nz,Logged_0x1487
	ld hl,$C0F3
	ld a,[hli]
	cp [hl]
	jp z,Logged_0x14E8
	ld e,[hl]
	dec a
	dec a
	cp [hl]
	jr nz,Logged_0x144C
	push hl
	ld hl,$C0EE
	ld a,[hl]
	xor $01
	ld [hli],a
	ld a,[hli]
	ld d,[hl]
	inc hl
	ld [hli],a
	ld [hl],d
	pop hl

Logged_0x144C:
	ld a,e
	add a,a
	push af
	inc [hl]
	inc [hl]
	ld hl,$5870
	ld a,c
	sub $20
	add a,a
	ld d,$00
	ld e,a
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,b
	add a,a
	ld e,a
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	pop af
	inc hl
	ld d,$00
	ld e,a
	add hl,de
	ld d,h
	ld e,l
	ld hl,$C0E6
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[hl]
	add a,$20
	ld [hli],a
	inc hl
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	ld [hli],a
	ld a,[hl]
	add a,$20
	ld [hl],a
	jr Logged_0x14E8

Logged_0x1487:
	ld hl,$C0F0
	ld a,b
	ld [hld],a
	ld [hl],c
	push de
	ld hl,$5870
	ld a,c
	sub $20
	add a,a
	ld d,$00
	ld e,a
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,b
	add a,a
	ld e,a
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	pop de
	ld a,h
	cp $F0
	jr z,Unknown_0x14B2
	cp $F1
	jr nz,Logged_0x14BC
	ld b,l
	ld a,l
	ld [de],a
	jr Logged_0x1487

Unknown_0x14B2:
	ld c,l
	xor a
	ld b,a
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	inc de
	jr Logged_0x1487

Logged_0x14BC:
	ld a,[hli]
	push hl
	ld hl,$C0F3
	ld [hli],a
	ld [hl],$02
	pop de
	ld hl,$C0E6
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld bc,$8700
	ld a,[$C0EE]
	or a
	jr z,Logged_0x14D9
	ld c,$80

Logged_0x14D9:
	ld a,c
	ld [hli],a
	ld a,b
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,c
	add a,$10
	ld [hli],a
	ld [hl],b

Logged_0x14E8:
	pop af
	rst BankSwitch
	ret

Logged_0x14EB:
	push hl
	xor a
	ld hl,$C14D
	push hl
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	pop bc
	pop hl
	ld de,$D8F0

Logged_0x14FB:
	add hl,de
	bit 7,h
	jr nz,Logged_0x1505
	ld a,[bc]
	inc a
	ld [bc],a
	jr Logged_0x14FB

Logged_0x1505:
	inc bc
	ld de,$2710
	add hl,de
	ld de,$FC18

Logged_0x150D:
	add hl,de
	bit 7,h
	jr nz,Logged_0x1517
	ld a,[bc]
	inc a
	ld [bc],a
	jr Logged_0x150D

Logged_0x1517:
	inc bc
	ld de,$03E8
	add hl,de
	ld de,$FF9C

Logged_0x151F:
	add hl,de
	bit 7,h
	jr nz,Logged_0x1529
	ld a,[bc]
	inc a
	ld [bc],a
	jr Logged_0x151F

Logged_0x1529:
	inc bc
	ld de,$0064
	add hl,de
	ld de,$FFF6

Logged_0x1531:
	add hl,de
	bit 7,h
	jr nz,Logged_0x153B
	ld a,[bc]
	inc a
	ld [bc],a
	jr Logged_0x1531

Logged_0x153B:
	inc bc
	ld de,$000A
	add hl,de
	ld a,l
	ld [bc],a
	ret

Logged_0x1543:
	ld a,[$FF00+$FF]
	set 0,a
	ei
	ld a,$0A
	call Logged_0x1626
	ld a,[$FF00+$00]
	cp $FF
	jr nz,Unknown_0x1568
	call Logged_0x16DD
	ld a,[$FF00+$00]
	cp $FF
	jr nz,Unknown_0x1568
	ld a,$09
	call Logged_0x1626
	ld hl,$C0A0
	res 7,[hl]
	di
	ret

Unknown_0x1568:
	ld hl,$C0A0
	set 7,[hl]
	call Unknown_0x16CD
	ld a,$0B
	call Unknown_0x16B1
	ld a,$0F
	call Unknown_0x16B1
	ld a,$03
	call Logged_0x1629
	di
	call Logged_0x1704
	ld a,$E4
	ld [$FF00+$47],a
	ld hl,$9800
	ld de,$000C
	ld a,$80
	ld b,$0D

Unknown_0x1591:
	ld c,$14

Unknown_0x1593:
	ld [hli],a
	inc a
	dec c
	jr nz,Unknown_0x1593
	add hl,de
	dec b
	jr nz,Unknown_0x1591
	ld a,$0F
	rst BankSwitch
	ld hl,$5AE6
	ld de,$8800
	ld bc,$1000
	call Logged_0x0922
	ld a,$81
	ld [$FF00+$40],a
	ld a,$18
	call Unknown_0x16B1
	ei
	di
	call Logged_0x1704
	ld hl,$6AE6
	ld de,$8800
	ld bc,$1000
	call Logged_0x0922
	ld a,$81
	ld [$FF00+$40],a
	ld a,$19
	call Unknown_0x16B1
	ei
	di
	call Logged_0x1704
	ld hl,$70C6
	ld de,$8800
	ld bc,$0860
	call Logged_0x0922
	ld a,$81
	ld [$FF00+$40],a
	ld a,$1A
	call Unknown_0x16B1
	ei
	di
	call Logged_0x1704
	ld hl,$4000
	ld de,$8800
	ld bc,$1000
	call Logged_0x0922
	ld a,$81
	ld [$FF00+$40],a
	ld a,$04
	call Unknown_0x16B1
	call Logged_0x1704
	ld hl,$5000
	ld de,$8800
	ld bc,$0FD2
	call Logged_0x0922
	ld a,$81
	ld [$FF00+$40],a
	ld a,$05
	call Unknown_0x16B1
	ei
	ld a,$06
	call Logged_0x1629
	ld a,$09
	call Logged_0x1629
	ret

Logged_0x1626:
	ld b,a
	jr Logged_0x1630

Logged_0x1629:
	ld b,a
	ld a,[$C0A0]
	bit 7,a
	ret z

Logged_0x1630:
	ld a,[$FF00+$8C]
	push af
	ld a,$02
	rst BankSwitch
	ld hl,$4000
	ld a,b
	add a,a
	ld d,$00
	ld e,a
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	call Logged_0x166F
	call Logged_0x16B8
	pop af
	rst BankSwitch
	ret

Logged_0x164B:
	ld b,a
	ld a,[$C0A0]
	bit 7,a
	ret z
	ld a,[$FF00+$8C]
	push af
	ld a,$02
	rst BankSwitch
	ld hl,$4000
	ld a,b
	add a,a
	ld d,$00
	ld e,a
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$04
	ld [$C0AC],a
	call Logged_0x166F
	pop af
	rst BankSwitch
	ret

Logged_0x166F:
	ld a,[hl]
	and $07
	ld b,a
	ld c,$00
	push bc

Logged_0x1676:
	xor a
	ld [$FF00+c],a
	ld a,$30
	ld [$FF00+c],a
	ld b,$10

Logged_0x167D:
	ld e,$08
	ld a,[hli]
	ld d,a

Logged_0x1681:
	bit 0,d
	ld a,$10
	jr nz,Logged_0x1689
	ld a,$20

Logged_0x1689:
	ld [$FF00+c],a
	ld a,$30
	ld [$FF00+c],a
	rr d
	dec e
	jr nz,Logged_0x1681
	dec b
	jr nz,Logged_0x167D
	ld a,$20
	ld [$FF00+c],a
	ld a,$30
	ld [$FF00+c],a
	pop bc
	dec b
	ret z
	push bc
	call Logged_0x16B8
	jr Logged_0x1676

Unknown_0x16A4:
	ld b,a
	ld a,[$C0A0]
	bit 7,a
	ret z
	call Logged_0x166F
	jp Logged_0x16B8

Unknown_0x16B1:
	call Logged_0x1629
	ld b,$08
	jr Logged_0x16BA

Logged_0x16B8:
	ld b,$04

Logged_0x16BA:
	ld de,$0900
	call Logged_0x16C4
	dec b
	jr nz,Logged_0x16BA
	ret

Logged_0x16C4:
	nop
	nop
	nop
	dec de
	ld a,d
	or e
	jr nz,Logged_0x16C4
	ret

Unknown_0x16CD:
	ld c,$08
	ld a,$10

Unknown_0x16D1:
	push af
	push bc
	call Logged_0x1629
	pop bc
	pop af
	inc a
	dec c
	jr nz,Unknown_0x16D1
	ret

Logged_0x16DD:
	ld a,$20
	ld [$FF00+$00],a
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	cpl
	and $0F
	swap a
	ld b,a
	ld a,$30
	ld [$FF00+$00],a
	ld a,$10
	ld [$FF00+$00],a
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,[$FF00+$00]
	ld a,$30
	ld [$FF00+$00],a
	ret

Logged_0x1704:
	ld a,[$FF00+$FF]
	ld [$C0A6],a
	res 0,a
	ld [$FF00+$FF],a

Logged_0x170D:
	ld a,[$FF00+$44]
	cp $91
	jr c,Logged_0x170D
	ld a,[$FF00+$40]
	and $7F
	ld [$FF00+$40],a
	ld a,[$C0A6]
	ld [$FF00+$FF],a
	ret
	ld a,[$FF00+$91]
	rst JumpList
	dw Logged_0x1910
	dw Logged_0x1C47
	dw Unknown_0x175A
	dw Unknown_0x2558
	dw Logged_0x1D1E
	dw Logged_0x2514
	dw Logged_0x251A
	dw Logged_0x2552
	dw Logged_0x1A89
	dw Unknown_0x1BB0
	dw Logged_0x1B84
	dw Logged_0x1A89
	dw Logged_0x1ABA
	dw Unknown_0x1BB0
	dw Logged_0x1B84
	dw Logged_0x1ABA
	dw Logged_0x378A
	dw Logged_0x1AEB
	dw Logged_0x1AF1
	dw Logged_0x1BE2
	dw Logged_0x1C2F
	dw Logged_0x1C3B
	dw Logged_0x1AFD
	dw Logged_0x1B13
	dw Logged_0x1B2D
	dw Unknown_0x1B77
	dw Logged_0x1B78
	dw $45A3 ;Unknown bank

Unknown_0x175A:
	call Logged_0x0F09
	ld a,[$FF00+$8B]
	bit 2,a
	jr z,Unknown_0x1768
	ld a,$0C
	ld [$FF00+$91],a
	ret

Unknown_0x1768:
	ld hl,$C223
	rla
	jr nc,Unknown_0x1773
	ld a,[hl]
	add a,$10
	ld [hl],a
	ret

Unknown_0x1773:
	rla
	jr nc,Unknown_0x177B
	ld a,[hl]
	sub $10
	ld [hl],a
	ret

Unknown_0x177B:
	ld hl,$C227
	rla
	jr nc,Unknown_0x1786
	ld a,[hl]
	sub $10
	ld [hl],a
	ret

Unknown_0x1786:
	rla
	ret nc
	ld a,[hl]
	add a,$10
	ld [hl],a
	ret
	ld a,[$FF00+$91]
	rst JumpList
	dw Logged_0x17B8
	dw Logged_0x132C
	dw Unknown_0x3C07
	dw Logged_0x1831
	dw Logged_0x189A
	dw Logged_0x1831
	dw Logged_0x1831
	dw Logged_0x1831
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x3D1A
	dw Logged_0x17FF
	dw Unknown_0x186B
	dw Logged_0x17FF
	dw Logged_0x17FF
	dw Logged_0x17FF
	dw $44E0 ;Unknown bank
	dw $44FE ;Unknown bank
	dw $4540 ;Unknown bank
	dw $454C ;Unknown bank

Logged_0x17B8:
	call Logged_0x05CC
	call Logged_0x0AD2
	ld a,$7C
	call Logged_0x1629
	ld a,$7C
	call Logged_0x3262
	xor a
	ld [$C157],a
	ld hl,$C0DE
	xor a
	ld [hli],a
	ld [hl],a
	call Logged_0x1CDD
	call Logged_0x1CE9
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x5279C
	farcall Logged_0x53B2
	farcall Logged_0x53CAE
	pop af
	rst BankSwitch
	ld a,$01
	ld [$D120],a
	ld a,$08
	ld [$FF00+$91],a
	xor a
	ld [$D25D],a
	jp Logged_0x060E

Logged_0x17FF:
	call Logged_0x2688
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x53CC2
	farcall Logged_0x527BA
	farcall Logged_0x50000
	pop af
	rst BankSwitch
	call Logged_0x3BBE
	call Logged_0x3BB7
	call Logged_0x2960
	call Logged_0x140E
	call Logged_0x2B17
	call Logged_0x1CB6
	call Logged_0x1863
	jp Logged_0x1193

Logged_0x1831:
	call Logged_0x2677
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x53CC2
	farcall Logged_0x527BA
	farcall Logged_0x50000
	pop af
	rst BankSwitch
	call Logged_0x3BBE
	call Logged_0x3BB7
	call Logged_0x2960
	call Logged_0x140E
	call Logged_0x2B17
	call Logged_0x1CB6
	call Logged_0x1863
	jp Logged_0x0F97

Logged_0x1863:
	ld a,[$FF00+$91]
	cp $20
	ret c
	jp Logged_0x44B1

Unknown_0x186B:
	call Logged_0x2688
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x53CC2
	farcall Logged_0x527BA
	farcall Logged_0x50000
	pop af
	rst BankSwitch
	call Logged_0x3BBE
	call Logged_0x3BB7
	call Logged_0x2960
	call Logged_0x140E
	call Logged_0x2B17
	call Logged_0x1863
	jp Logged_0x1193

Logged_0x189A:
	call Logged_0x2677
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x53CC2
	farcall Logged_0x527BA
	farcall Logged_0x50000
	pop af
	rst BankSwitch
	call Logged_0x3BBE
	call Logged_0x3BB7
	call Logged_0x2960
	call Logged_0x140E
	call Logged_0x2B17
	call Logged_0x1863
	jp Logged_0x0F97

UnknownData_0x18C9:
INCBIN "baserom.gb", $18C9, $1910 - $18C9

Logged_0x1910:
	call Logged_0x4F37
	ld hl,$C9E4
	ld a,[hl]
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,WorldPointers
	add hl,bc
	ld a,[$FF00+$8C]
	push af
	ld a,[hli]
	rst BankSwitch
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hli]
	ld h,[hl]
	ld l,a
	push hl
	ld a,[$C922]
	and a
	jr nz,Logged_0x1942
	ld bc,$0007
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hli]
	add a,a
	ld c,a
	ld de,$CDC2
	call Logged_0x092B

Logged_0x1942:
	pop hl
	ld a,[$C922]
	and a
	jr z,Logged_0x1961
	ld a,[$CE70]
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$C920
	add hl,bc
	ld a,[hli]
	ld [$CFDB],a
	ld a,[hli]
	ld c,[hl]
	ld b,a
	ld d,$01
	jr Logged_0x199C

Logged_0x1961:
	inc a
	ld [$C922],a
	ld [$CE70],a
	ld a,[hli]
	ld [$CFDB],a
	ld [$C923],a
	ld a,[hli]
	ld b,a
	ld [$C924],a
	ld a,[hli]
	ld c,a
	ld [$C925],a
	ld d,[hl]
	inc hl
	ld a,[hli]
	ld [$C9E5],a
	ld a,[hli]
	ld [$C9E6],a
	ld a,[hli]
	ld [$CEB4],a
	push bc
	push de
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$19AE
	add hl,bc
	ld a,[hl]
	ld [$CFDD],a
	call Logged_0x3224
	pop de
	pop bc

Logged_0x199C:
	xor a
	ld [$C0EF],a
	farcall Logged_0x24000
	pop af
	rst BankSwitch
	call Logged_0x132C
	jp Logged_0x27E6

LoggedData_0x19AE:
INCBIN "baserom.gb", $19AE, $19B6 - $19AE

UnknownData_0x19B6:
INCBIN "baserom.gb", $19B6, $19FF - $19B6

Logged_0x19FF:
	ld hl,$CA00
	xor a
	ld bc,$0240
	call Logged_0x0914
	ld a,[$FF00+$8C]
	push af
	ld a,$02
	rst BankSwitch
	ld hl,$59F1
	ld a,[$CFDB]
	add a,a
	ld d,$00
	ld e,a
	add hl,de
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hli]
	push hl
	ld d,[hl]
	ld e,a
	ld hl,$CA46
	call Logged_0x1A52
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld d,[hl]
	ld e,a
	ld hl,$CA44
	call Logged_0x1A52
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld d,[hl]
	ld e,a
	ld hl,$CA46
	call Logged_0x1A6B
	pop hl
	inc hl
	ld a,[hli]
	ld d,[hl]
	ld e,a
	ld hl,$CA44
	call Logged_0x1A6B
	ld a,$08
	ld [$D128],a
	pop af
	rst BankSwitch
	ret

Logged_0x1A52:
	ld b,$07

Logged_0x1A54:
	ld c,$09

Logged_0x1A56:
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x1A56
	push de
	ld de,$001C
	add hl,de
	pop de
	dec b
	jr nz,Logged_0x1A54
	ret

Logged_0x1A6B:
	ld a,[de]
	cp $FF
	ret z
	push hl
	push hl
	swap a
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	inc de
	ld a,[de]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	pop bc
	add hl,bc
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	pop hl
	jr Logged_0x1A6B

Logged_0x1A89:
	ld a,$01
	ld [$D249],a
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x24040
	pop af
	rst BankSwitch
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x140E
	call Logged_0x2B17
	call Logged_0x2564
	ld a,[$FF00+$40]
	bit 6,a
	jr nz,Logged_0x1AB4
	call Logged_0x1095
	jp Logged_0x2960

Logged_0x1AB4:
	call Logged_0x0F09
	jp Logged_0x2960

Logged_0x1ABA:
	ld a,$01
	ld [$D249],a
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x24040
	pop af
	rst BankSwitch

Logged_0x1ACA:
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x140E
	call Logged_0x2B17
	call Logged_0x2564
	ld a,[$FF00+$40]
	bit 6,a
	jr nz,Logged_0x1AE5
	call Logged_0x1095
	jp Logged_0x2960

Logged_0x1AE5:
	call Logged_0x0F09
	jp Logged_0x2960

Logged_0x1AEB:
	call Logged_0x3774
	jp Logged_0x0ED4

Logged_0x1AF1:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x216C0
	pop af
	rst BankSwitch
	ret

Logged_0x1AFD:
	ld hl,$D12A
	set 7,[hl]
	set 2,[hl]
	xor a
	ld [$C922],a
	ld [$C154],a
	ld [$D12B],a
	ld a,$12
	ld [$FF00+$91],a
	ret

Logged_0x1B13:
	ld hl,$D142
	bit 4,[hl]
	jp nz,Logged_0x1ACA
	ld a,$04
	ld [$FF00+$91],a
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x26C81
	pop af
	rst BankSwitch
	jp Logged_0x1ACA

Logged_0x1B2D:
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A00A
	add hl,bc
	ld a,[hl]
	ld [$C9E4],a
	ld a,$00
	ld [$0000],a
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x209F4
	pop af
	rst BankSwitch
	xor a
	ld [$D12B],a
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$1B6F
	add hl,bc
	ld b,$00
	ld a,[$CC41]
	and [hl]
	jr z,Logged_0x1B6B
	ld b,$16

Logged_0x1B6B:
	ld a,b
	ld [$FF00+$91],a
	ret

UnknownData_0x1B6F:
INCBIN "baserom.gb", $1B6F, $1B72 - $1B6F

LoggedData_0x1B72:
INCBIN "baserom.gb", $1B72, $1B77 - $1B72

Unknown_0x1B77:
	ret

Logged_0x1B78:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x4E41
	pop af
	rst BankSwitch
	ret

Logged_0x1B84:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x6BD13
	pop af
	rst BankSwitch
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x140E
	call Logged_0x2B17
	call Logged_0x2564
	ld a,[$FF00+$40]
	bit 6,a
	jr nz,Logged_0x1BAA
	call Logged_0x1095
	jp Logged_0x2960

Logged_0x1BAA:
	call Logged_0x0F09
	jp Logged_0x2960

Unknown_0x1BB0:
	ld a,[$FF00+$8C]
	push af
	ld a,$1A
	rst $10
	call $7D13 ;Unknown bank
	ld a,$09
	rst $10
	call $4040 ;Unknown bank
	pop af
	rst BankSwitch
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x140E
	call Logged_0x2B17
	call Logged_0x2564
	ld a,[$FF00+$40]
	bit 6,a
	jr nz,Unknown_0x1BDC
	call Logged_0x1095
	jp Logged_0x2960

Unknown_0x1BDC:
	call Logged_0x0F09
	jp Logged_0x2960

Logged_0x1BE2:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x24040
	ld a,$01
	rst BankSwitch
	ld hl,$1C0C
	push hl
	ld a,[$C154]
	rst JumpList
	dw Logged_0x497D
	dw Logged_0x4B08
	dw Logged_0x4B83
	dw Logged_0x4B8E
	dw Logged_0x4BE9
	dw Logged_0x4C4E
	dw Logged_0x4CAE
	dw Logged_0x4DE1
	dw Logged_0x4D41
	dw Logged_0x4D42
	dw Logged_0x4D52
	call Logged_0x4DF8
	pop af
	rst BankSwitch
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x140E
	call Logged_0x2B17
	ld a,[$FF00+$40]
	bit 6,a
	jr nz,Logged_0x1C29
	call Logged_0x1095
	jp Logged_0x2960

Logged_0x1C29:
	call Logged_0x0F09
	jp Logged_0x2960

Logged_0x1C2F:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x415F
	pop af
	rst BankSwitch
	ret

Logged_0x1C3B:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x21070
	pop af
	rst BankSwitch
	ret

Logged_0x1C47:
	call Logged_0x140E
	call Logged_0x0F09
	ld hl,$CE75
	dec [hl]
	ret nz
	xor a
	ld hl,$CE75
	ld [hli],a
	ld [hl],a
	ld a,$02
	ld [$CE7A],a
	ld a,$04
	ld [$FF00+$91],a
	ld hl,$C0A7
	set 1,[hl]
	ld hl,$FF40
	set 1,[hl]
	ret

UnknownData_0x1C6C:
INCBIN "baserom.gb", $1C6C, $1CB6 - $1C6C

Logged_0x1CB6:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x52ED
	pop af
	rst BankSwitch
	ret

UnknownData_0x1CC2:
INCBIN "baserom.gb", $1CC2, $1CDD - $1CC2

Logged_0x1CDD:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x527F
	pop af
	rst BankSwitch
	ret

Logged_0x1CE9:
	ld hl,$C580
	ld de,$1D01
	ld bc,$1020
	call Logged_0x309F
	ld hl,$C5A0
	ld de,$1D0F
	ld bc,$1030
	jp Logged_0x309F

LoggedData_0x1D01:
INCBIN "baserom.gb", $1D01, $1D1D - $1D01

UnknownData_0x1D1D:
INCBIN "baserom.gb", $1D1D, $1D1E - $1D1D

Logged_0x1D1E:
	ld hl,$1D38
	push hl
	ld a,[$CE7A]
	rst JumpList
	dw Logged_0x1D51
	dw Logged_0x1E96
	dw Logged_0x1EA2
	dw Logged_0x2122
	dw Logged_0x226E
	dw Logged_0x22AD
	dw Logged_0x236F
	dw Logged_0x23FF
	dw Logged_0x243F
	call Logged_0x24BF
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x2960
	call Logged_0x140E
	ld a,[$D141]
	rra
	jp c,Logged_0x1095
	jp Logged_0x0F09

Logged_0x1D51:
	ld hl,$DC03
	set 2,[hl]
	ld hl,$C240
	xor a
	ld bc,$01C0
	call Logged_0x0914
	ld hl,$C440
	xor a
	ld bc,$0120
	call Logged_0x0914
	ld hl,$CA00
	xor a
	ld bc,$0240
	call Logged_0x0914
	xor a
	ld [$C158],a
	ld hl,$CE75
	ld a,$04
	ld [hli],a
	ld a,$03
	ld [hl],a
	ld a,$01
	ld [$CE7A],a
	ld hl,$D12B
	res 7,[hl]
	res 5,[hl]
	ld a,[$C9E4]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$1E06
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	push hl
	ld bc,$0006

Logged_0x1D9F:
	ld a,[hl]
	cp $FF
	jr z,Logged_0x1DC1
	ld a,[$CFDB]
	cp [hl]
	jr z,Logged_0x1DAD
	add hl,bc
	jr Logged_0x1D9F

Logged_0x1DAD:
	inc hl
	inc hl
	ld a,[$CE7B]
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[hl]
	ld [$CFDD],a
	ld hl,$D12B
	set 7,[hl]
	set 5,[hl]

Logged_0x1DC1:
	ld de,$CFDB
	ld a,[$CE7B]
	rst JumpList
	dw Logged_0x1DD0
	dw Logged_0x1DD8
	dw Logged_0x1DE0
	dw Logged_0x1DE6

Logged_0x1DD0:
	ld hl,$C9E6
	ld a,[de]
	sub [hl]
	ld [de],a
	jr Logged_0x1DEA

Logged_0x1DD8:
	ld hl,$C9E6
	ld a,[de]
	add a,[hl]
	ld [de],a
	jr Logged_0x1DEA

Logged_0x1DE0:
	ld hl,$CFDB
	dec [hl]
	jr Logged_0x1DEA

Logged_0x1DE6:
	ld hl,$CFDB
	inc [hl]

Logged_0x1DEA:
	pop hl
	ld bc,$0006

Logged_0x1DEE:
	ld a,[hl]
	cp $FF
	ret z
	ld a,[$CFDB]
	cp [hl]
	jr z,Logged_0x1DFB
	add hl,bc
	jr Logged_0x1DEE

Logged_0x1DFB:
	inc hl
	ld a,[hl]
	ld [$CFDD],a
	ld hl,$D12B
	set 7,[hl]
	ret

LoggedData_0x1E06:
INCBIN "baserom.gb", $1E06, $1E18 - $1E06

UnknownData_0x1E18:
INCBIN "baserom.gb", $1E18, $1E1B - $1E18

LoggedData_0x1E1B:
INCBIN "baserom.gb", $1E1B, $1E20 - $1E1B

UnknownData_0x1E20:
INCBIN "baserom.gb", $1E20, $1E21 - $1E20

LoggedData_0x1E21:
INCBIN "baserom.gb", $1E21, $1E25 - $1E21

UnknownData_0x1E25:
INCBIN "baserom.gb", $1E25, $1E27 - $1E25

LoggedData_0x1E27:
INCBIN "baserom.gb", $1E27, $1E2C - $1E27

UnknownData_0x1E2C:
INCBIN "baserom.gb", $1E2C, $1E2F - $1E2C

LoggedData_0x1E2F:
INCBIN "baserom.gb", $1E2F, $1E32 - $1E2F

UnknownData_0x1E32:
INCBIN "baserom.gb", $1E32, $1E34 - $1E32

LoggedData_0x1E34:
INCBIN "baserom.gb", $1E34, $1E35 - $1E34

UnknownData_0x1E35:
INCBIN "baserom.gb", $1E35, $1E36 - $1E35

LoggedData_0x1E36:
INCBIN "baserom.gb", $1E36, $1E39 - $1E36

UnknownData_0x1E39:
INCBIN "baserom.gb", $1E39, $1E3A - $1E39

LoggedData_0x1E3A:
INCBIN "baserom.gb", $1E3A, $1E3B - $1E3A

UnknownData_0x1E3B:
INCBIN "baserom.gb", $1E3B, $1E3D - $1E3B

LoggedData_0x1E3D:
INCBIN "baserom.gb", $1E3D, $1E3F - $1E3D

UnknownData_0x1E3F:
INCBIN "baserom.gb", $1E3F, $1E42 - $1E3F

LoggedData_0x1E42:
INCBIN "baserom.gb", $1E42, $1E45 - $1E42

UnknownData_0x1E45:
INCBIN "baserom.gb", $1E45, $1E47 - $1E45

LoggedData_0x1E47:
INCBIN "baserom.gb", $1E47, $1E48 - $1E47

UnknownData_0x1E48:
INCBIN "baserom.gb", $1E48, $1E49 - $1E48

LoggedData_0x1E49:
INCBIN "baserom.gb", $1E49, $1E4C - $1E49

UnknownData_0x1E4C:
INCBIN "baserom.gb", $1E4C, $1E4F - $1E4C

LoggedData_0x1E4F:
INCBIN "baserom.gb", $1E4F, $1E52 - $1E4F

UnknownData_0x1E52:
INCBIN "baserom.gb", $1E52, $1E54 - $1E52

LoggedData_0x1E54:
INCBIN "baserom.gb", $1E54, $1E58 - $1E54

UnknownData_0x1E58:
INCBIN "baserom.gb", $1E58, $1E5A - $1E58

LoggedData_0x1E5A:
INCBIN "baserom.gb", $1E5A, $1E5B - $1E5A

UnknownData_0x1E5B:
INCBIN "baserom.gb", $1E5B, $1E5C - $1E5B

LoggedData_0x1E5C:
INCBIN "baserom.gb", $1E5C, $1E5F - $1E5C

UnknownData_0x1E5F:
INCBIN "baserom.gb", $1E5F, $1E60 - $1E5F

LoggedData_0x1E60:
INCBIN "baserom.gb", $1E60, $1E61 - $1E60

UnknownData_0x1E61:
INCBIN "baserom.gb", $1E61, $1E63 - $1E61

LoggedData_0x1E63:
INCBIN "baserom.gb", $1E63, $1E66 - $1E63

UnknownData_0x1E66:
INCBIN "baserom.gb", $1E66, $1E68 - $1E66

LoggedData_0x1E68:
INCBIN "baserom.gb", $1E68, $1E6C - $1E68

UnknownData_0x1E6C:
INCBIN "baserom.gb", $1E6C, $1E6D - $1E6C

LoggedData_0x1E6D:
INCBIN "baserom.gb", $1E6D, $1E6E - $1E6D

UnknownData_0x1E6E:
INCBIN "baserom.gb", $1E6E, $1E6F - $1E6E

LoggedData_0x1E6F:
INCBIN "baserom.gb", $1E6F, $1E71 - $1E6F

UnknownData_0x1E71:
INCBIN "baserom.gb", $1E71, $1E74 - $1E71

LoggedData_0x1E74:
INCBIN "baserom.gb", $1E74, $1E77 - $1E74

UnknownData_0x1E77:
INCBIN "baserom.gb", $1E77, $1E78 - $1E77

LoggedData_0x1E78:
INCBIN "baserom.gb", $1E78, $1E79 - $1E78

UnknownData_0x1E79:
INCBIN "baserom.gb", $1E79, $1E7B - $1E79

LoggedData_0x1E7B:
INCBIN "baserom.gb", $1E7B, $1E7E - $1E7B

UnknownData_0x1E7E:
INCBIN "baserom.gb", $1E7E, $1E80 - $1E7E

LoggedData_0x1E80:
INCBIN "baserom.gb", $1E80, $1E81 - $1E80

UnknownData_0x1E81:
INCBIN "baserom.gb", $1E81, $1E82 - $1E81

LoggedData_0x1E82:
INCBIN "baserom.gb", $1E82, $1E84 - $1E82

UnknownData_0x1E84:
INCBIN "baserom.gb", $1E84, $1E86 - $1E84

LoggedData_0x1E86:
INCBIN "baserom.gb", $1E86, $1E87 - $1E86

UnknownData_0x1E87:
INCBIN "baserom.gb", $1E87, $1E88 - $1E87

LoggedData_0x1E88:
INCBIN "baserom.gb", $1E88, $1E8B - $1E88

UnknownData_0x1E8B:
INCBIN "baserom.gb", $1E8B, $1E8E - $1E8B

LoggedData_0x1E8E:
INCBIN "baserom.gb", $1E8E, $1E91 - $1E8E

UnknownData_0x1E91:
INCBIN "baserom.gb", $1E91, $1E92 - $1E91

LoggedData_0x1E92:
INCBIN "baserom.gb", $1E92, $1E93 - $1E92

UnknownData_0x1E93:
INCBIN "baserom.gb", $1E93, $1E94 - $1E93

LoggedData_0x1E94:
INCBIN "baserom.gb", $1E94, $1E96 - $1E94

Logged_0x1E96:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x5089
	pop af
	rst BankSwitch
	ret

Logged_0x1EA2:
	ld hl,$C9E4;world number
	ld a,[hl]
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,WorldPointers
	add hl,bc
	ld a,[$FF00+$8C]
	push af
	ld a,[hli]
	rst BankSwitch
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld bc,$0009
	add hl,bc
	ld a,[$CFDB];level room number
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hli]
	push hl
	ld h,[hl]
	ld l,a
	ld b,$00

Logged_0x1ECF:
	ld c,$00

Logged_0x1ED1:
	ld a,[hl]
	push bc
	push hl
	push af
	swap b
	ld a,b
	add a,c
	ld h,$00
	ld l,a
	add hl,hl
	add hl,hl
	ld bc,$CA02
	add hl,bc
	pop af
	ld [hl],a
	pop hl
	pop bc
	inc hl
	inc c
	ld a,c
	cp $0A
	jr nz,Logged_0x1ED1
	inc b
	ld a,b
	cp $09
	jr nz,Logged_0x1ECF
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld h,[hl]
	ld l,a
	ld b,$00

Logged_0x1EFB:
	ld c,$00

Logged_0x1EFD:
	ld a,[hl]
	push hl
	push bc
	push af
	swap b
	ld a,b
	add a,c
	ld h,$00
	ld l,a
	add hl,hl
	add hl,hl
	ld bc,$CA00
	add hl,bc
	pop af
	pop bc
	ld [hl],a
	pop hl
	inc hl
	inc c
	ld a,c
	cp $0A
	jr nz,Logged_0x1EFD
	inc b
	ld a,b
	cp $09
	jr nz,Logged_0x1EFB
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld b,a
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x1F75
	ld h,[hl]
	ld l,b
	ld a,[hli]
	ld d,a
	push hl
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld b,[hl]
	ld a,b
	ld [$D24C],a
	push bc
	push hl
	ld a,d
	ld c,a
	ld b,$00
	ld hl,$2119
	add hl,bc
	ld a,[hl]
	pop hl
	or [hl]
	ld [hl],a
	pop bc
	pop hl
	ld c,d
	ld a,$60
	ld [$D24B],a

Logged_0x1F55:
	ld a,[hli]
	cp $FF
	jr z,Logged_0x1F6C
	ld d,a
	ld a,[hli]
	ld e,a
	push hl
	call Logged_0x2FD4
	ld a,[$D24B]
	srl b
	jr nc,Logged_0x1F6A
	ld a,$14

Logged_0x1F6A:
	ld [hl],a
	pop hl

Logged_0x1F6C:
	ld de,$D24B
	ld a,[de]
	inc a
	ld [de],a
	dec c
	jr nz,Logged_0x1F55

Logged_0x1F75:
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld h,[hl]
	ld l,a
	ld a,[hli]
	ld c,a

Logged_0x1F7D:
	ld a,[hli]
	cp $FF
	jr z,Logged_0x1FA4
	push bc
	ld d,a
	ld a,[hli]
	push hl
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld a,[hl]
	and d
	ld b,a
	pop hl
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	push hl
	call Logged_0x2FD4
	ld a,b
	and a
	ld a,$11
	jr z,Logged_0x1FA1
	ld a,$12

Logged_0x1FA1:
	ld [hl],a
	pop hl
	pop bc

Logged_0x1FA4:
	dec c
	jr nz,Logged_0x1F7D
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld b,a
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x1FEA
	ld h,[hl]
	ld l,b
	ld a,[hli]
	ld d,a
	push hl
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC82
	add hl,bc
	ld b,[hl]
	pop hl
	ld c,d
	ld a,$70
	ld [$D24B],a

Logged_0x1FCA:
	ld a,[hli]
	cp $FF
	jr z,Logged_0x1FEA
	ld d,a
	ld a,[hli]
	ld e,a
	srl b
	jr c,Logged_0x1FE1
	push hl
	call Logged_0x2FD4
	ld a,[hli]
	ld [hld],a
	ld a,[$D24B]
	ld [hl],a
	pop hl

Logged_0x1FE1:
	ld de,$D24B
	ld a,[de]
	inc a
	ld [de],a
	dec c
	jr nz,Logged_0x1FCA

Logged_0x1FEA:
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld b,a
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x2004
	ld h,[hl]
	ld l,b
	ld a,[hli]
	and a
	jr z,Logged_0x2004
	add a,a
	ld c,a
	ld de,$CE42
	call Logged_0x092B

Logged_0x2004:
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld h,[hl]
	ld l,a
	ld a,[hli]
	and a
	jr z,Logged_0x2036
	ld c,a

Logged_0x200F:
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld b,a
	ld a,[$D24C]
	cp $FF
	jr nz,Logged_0x2029
	ld a,b
	cp $78
	jr z,Logged_0x2033
	cp $7B
	jr c,Logged_0x2029
	cp $80
	jr c,Logged_0x2033

Logged_0x2029:
	push hl
	push bc
	call Logged_0x2FD4
	pop bc
	ld a,[hli]
	ld [hld],a
	ld [hl],b
	pop hl

Logged_0x2033:
	dec c
	jr nz,Logged_0x200F

Logged_0x2036:
	pop hl
	inc hl
	ld a,[hli]
	push hl
	ld h,[hl]
	ld l,a
	push hl
	push hl
	ld hl,$C9E7
	xor a
	ld c,$19
	call Logged_0x091D
	pop hl
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x2098
	ld a,[hli]
	and a
	jr z,Logged_0x2098
	ld c,a
	ld de,$C9E7
	ld [de],a
	inc de
	push hl
	push bc
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CD82
	add hl,bc
	ld a,[hl]
	ld [$D24B],a
	pop bc
	pop hl

Logged_0x206B:
	ld a,[$D24B]
	rra
	ld [$D24B],a
	jr nc,Logged_0x2082
	ld a,$FF
	ld [de],a
	inc de
	ld a,$FF
	ld [de],a
	inc de
	inc de
	inc hl
	inc hl
	inc hl
	jr Logged_0x2095

Logged_0x2082:
	ld a,[hli]
	swap a
	add a,$10
	ld [de],a
	inc de
	ld a,[hli]
	swap a
	add a,$08
	ld [de],a
	inc de
	ld a,[hli]
	and $7F
	ld [de],a
	inc de

Logged_0x2095:
	dec c
	jr nz,Logged_0x206B

Logged_0x2098:
	pop hl
	ld a,[hli]
	and a
	jr z,Logged_0x2100
	ld c,a
	push bc
	push hl
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CD82
	add hl,bc
	ld a,[hl]
	ld [$D24B],a
	pop hl
	pop bc

Logged_0x20B0:
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld b,a
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x20E7
	ld a,b
	cp $16
	jr nz,Logged_0x20DE
	push bc
	push hl
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$CE5D
	add hl,bc
	ld a,[hl]
	pop hl
	pop bc
	cp $64
	jr z,Logged_0x20E7
	ld a,[$CE53]
	bit 6,a
	jr nz,Logged_0x20FD
	jr Logged_0x20E7

Logged_0x20DE:
	ld a,[$D24B]
	rra
	ld [$D24B],a
	jr c,Logged_0x20FD

Logged_0x20E7:
	push hl
	push bc
	ld a,b
	rla
	jr c,Logged_0x20F2
	call Logged_0x2FD4
	jr Logged_0x20F5

Logged_0x20F2:
	call Logged_0x2FE4

Logged_0x20F5:
	pop bc
	ld a,[hli]
	ld [hld],a
	ld a,b
	and $7F
	ld [hl],a
	pop hl

Logged_0x20FD:
	dec c
	jr nz,Logged_0x20B0

Logged_0x2100:
	pop hl
	inc hl
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[hli]
	ld [$CEB0],a
	ld de,$CEB1
	ld a,l
	ld [de],a
	inc de
	ld a,h
	ld [de],a
	pop af
	rst BankSwitch
	ld a,$03
	ld [$CE7A],a
	ret

UnknownData_0x2119:
INCBIN "baserom.gb", $2119, $211A - $2119

LoggedData_0x211A:
INCBIN "baserom.gb", $211A, $211C - $211A

UnknownData_0x211C:
INCBIN "baserom.gb", $211C, $211D - $211C

LoggedData_0x211D:
INCBIN "baserom.gb", $211D, $211E - $211D

UnknownData_0x211E:
INCBIN "baserom.gb", $211E, $2122 - $211E

Logged_0x2122:
	ld hl,$D129
	bit 0,[hl]
	ret nz
	ld hl,$2266
	ld de,$CE84
	ld c,$04
	call Logged_0x092B
	ld hl,$226A
	ld de,$CE7E
	ld c,$04
	call Logged_0x092B
	ld a,[$FF00+$8C]
	push af
	ld hl,$CE75
	ld a,[hli]
	ld c,[hl]
	ld b,a
	push bc
	push bc
	ld hl,$CE9C
	ld d,$05

Logged_0x214E:
	push de
	push bc
	push hl
	push hl
	swap b
	ld a,b
	add a,c
	ld h,$00
	ld l,a
	add hl,hl
	add hl,hl
	ld bc,$CA02
	add hl,bc
	ld a,[hl]
	add a,$80
	ld l,a
	ld h,$00
	ld a,$0A
	rst BankSwitch
	add hl,hl
	add hl,hl
	ld de,$4400
	add hl,de
	ld e,l
	ld d,h
	pop hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld bc,$0009
	add hl,bc
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	pop hl
	inc hl
	inc hl
	pop bc
	inc c
	pop de
	dec d
	jr nz,Logged_0x214E
	pop bc
	sla b
	sla c
	ld a,b
	add a,$20
	ld b,a
	ld h,$00
	ld l,b
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld b,$00
	add hl,bc
	ld bc,$9800
	add hl,bc
	ld de,$CE83
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	call Logged_0x09A3
	pop bc
	push bc
	ld hl,$CE88
	ld d,$05

Logged_0x21B3:
	push de
	push bc
	push hl
	push hl
	swap b
	ld a,b
	add a,c
	ld h,$00
	ld l,a
	add hl,hl
	add hl,hl
	ld bc,$CA00
	add hl,bc
	ld a,[hl]
	ld l,a
	ld h,$00
	ld a,$0A
	rst BankSwitch
	add hl,hl
	add hl,hl
	ld de,$4400
	add hl,de
	ld e,l
	ld d,h
	pop hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld bc,$0009
	add hl,bc
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	pop hl
	inc hl
	inc hl
	pop bc
	inc c
	pop de
	dec d
	jr nz,Logged_0x21B3
	pop bc
	sla b
	sla c
	ld h,$00
	ld l,b
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld b,$00
	add hl,bc
	ld bc,$9800
	add hl,bc
	ld de,$CE7D
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	call Logged_0x09A3
	pop af
	rst BankSwitch
	ld hl,$CE76
	ld a,[hl]
	add a,$05
	ld [hl],a
	cp $0A
	ret c
	xor a
	ld [hld],a
	inc [hl]
	ld a,[hl]
	cp $09
	ret c
	ld hl,$CFDB
	ld a,[$CEB4]
	cp [hl]
	jr z,Logged_0x2245
	ld hl,$D12B
	bit 7,[hl]
	jr z,Logged_0x2236
	res 7,[hl]
	ld a,$08
	ld [$CE7A],a
	ret

Logged_0x2236:
	ld hl,$CE75
	ld a,$04
	ld [hli],a
	ld a,$03
	ld [hl],a
	ld a,$04
	ld [$CE7A],a
	ret

Logged_0x2245:
	xor a
	ld [$CE75],a
	ld a,$06
	ld [$CE7A],a
	ld hl,$DC07
	set 4,[hl]
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x2260
	ld a,[$CEB5]
	cp $07
	ret nz

Logged_0x2260:
	ld a,$01
	ld [$D245],a
	ret

LoggedData_0x2266:
INCBIN "baserom.gb", $2266, $226E - $2266

Logged_0x226E:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$04
	ld [hli],a
	ld a,[hl]
	dec a
	ld c,a
	ld b,$00
	ld hl,$22AA
	add hl,bc
	ld a,[hl]
	ld [$FF00+$47],a
	ld hl,$CE76
	dec [hl]
	ret nz

Logged_0x2287:
	ld a,[$CEB0]
	and a
	jp z,Logged_0x231F
	ld a,[$CFDD]
	cp $0F
	jr z,Logged_0x22A4
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld a,[hl]
	cp $FF
	jr z,Logged_0x231F

Logged_0x22A4:
	ld a,$05
	ld [$CE7A],a
	ret

LoggedData_0x22AA:
INCBIN "baserom.gb", $22AA, $22AD - $22AA

Logged_0x22AD:
	ld hl,$C9E4
	ld a,[hl]
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,WorldPointers
	add hl,bc
	ld a,[$FF00+$8C]
	push af
	ld a,[hli]
	rst BankSwitch
	ld hl,$CEB1
	ld a,[hli]
	ld d,[hl]
	ld e,a
	ld a,[de]
	inc de
	ld [hl],d
	dec hl
	ld [hl],e
	and a
	jr nz,Logged_0x22D2
	call Logged_0x3069
	jr Logged_0x22D5

Logged_0x22D2:
	call Logged_0x307D

Logged_0x22D5:
	push hl
	ld c,$20
	xor a
	call Logged_0x091D
	pop hl
	ld a,[$CEB1]
	ld e,a
	ld a,[$CEB2]
	ld d,a
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	swap a
	add a,$10
	ld [hli],a
	inc de
	inc hl
	inc hl
	inc hl
	ld a,[de]
	swap a
	add a,$08
	ld [hl],a
	inc de
	ld a,$0A
	add a,l
	ld l,a
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	push hl
	inc de
	ld hl,$CEB1
	ld a,e
	ld [hli],a
	ld [hl],d
	pop hl
	ld a,$FB
	add a,l
	ld l,a
	call Logged_0x31C3
	pop af
	rst BankSwitch
	ld hl,$CEB0
	dec [hl]
	ret nz

Logged_0x231F:
	ld hl,$CFDB
	ld a,[$CEB4]
	cp [hl]
	jr z,Logged_0x2340

Logged_0x2328:
	ld hl,$CE76
	xor a
	ld [hld],a
	ld [hl],a
	ld [$CE7A],a
	ld b,$08
	ld a,[$D141]
	rra
	jr c,Logged_0x233B
	ld b,$0C

Logged_0x233B:
	ld hl,$FF91
	ld [hl],b
	ret

Logged_0x2340:
	ld a,$D0
	ld [$CE76],a
	ld a,$07
	ld [$CE7A],a
	ld hl,$D12A
	set 0,[hl]
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x235E
	ld a,[$CEB5]
	cp $07
	jr z,Logged_0x2369
	ret

Logged_0x235E:
	ld a,$01
	ld [$D243],a
	ld a,$04
	ld [$D244],a
	ret

Logged_0x2369:
	ld hl,$D12A
	set 3,[hl]
	ret

Logged_0x236F:
	ld hl,$D129
	bit 0,[hl]
	ret nz
	ld hl,$23DB
	ld de,$CE84
	ld c,$04
	call Logged_0x092B
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x238A
	ld a,[$CEB5]

Logged_0x238A:
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$23DF
	add hl,bc
	ld a,[$FF00+$8C]
	push af
	ld a,[hli]
	rst BankSwitch
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	push hl
	ld a,[$CE75]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	push hl
	add hl,de
	ld de,$CE88
	ld c,$20
	call Logged_0x092B
	pop hl
	ld de,$8000
	add hl,de
	ld de,$CE83
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	call Logged_0x09A3
	pop de
	pop af
	rst BankSwitch
	ld hl,$CE75
	inc [hl]
	ld a,[de]
	cp [hl]
	ret nz
	ld hl,$CE75
	ld a,$04
	ld [hli],a
	ld a,$03
	ld [hl],a
	ld a,$04
	ld [$CE7A],a
	ret

LoggedData_0x23DB:
INCBIN "baserom.gb", $23DB, $23FF - $23DB

Logged_0x23FF:
	ld hl,$2412
	push hl
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$242F
	add hl,bc
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	ld hl,$CE76
	dec [hl]
	ret nz
	ld a,[$C9E4]
	cp $07
	jr z,Logged_0x2428
	ld a,$01
	ld [$D243],a
	ld a,$15
	ld [$D244],a

Logged_0x2428:
	xor a
	ld [$CE74],a
	jp Logged_0x2328

LoggedData_0x242F:
INCBIN "baserom.gb", $242F, $243F - $242F

Logged_0x243F:
	ld a,[$CE78]
	and a
	ret nz
	ld bc,$0101
	call Logged_0x0AE5
	ld b,$02
	call Logged_0x16BA
	call Logged_0x05EA
	ld a,[$CFDD]
	add a,$58
	call Logged_0x0A96
	ld b,$48
	ld a,[$D141]
	rra
	jr nc,Logged_0x2463
	inc b

Logged_0x2463:
	ld a,[$CFDD]
	add a,a
	add a,b
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	ld a,[$CFDD]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$249F
	add hl,bc
	ld a,[hli]
	ld [$D243],a
	ld a,[hl]
	ld [$D244],a
	ld a,$1E
	ld [$FF00+$47],a
	call Logged_0x060E
	ld a,[$D12B]
	bit 5,a
	jp nz,Logged_0x2287
	ld a,[$CEB0]
	and a
	jp z,Logged_0x231F
	ld a,$05
	ld [$CE7A],a
	ret

LoggedData_0x249F:
INCBIN "baserom.gb", $249F, $24A3 - $249F

UnknownData_0x24A3:
INCBIN "baserom.gb", $24A3, $24A5 - $24A3

LoggedData_0x24A5:
INCBIN "baserom.gb", $24A5, $24AD - $24A5

UnknownData_0x24AD:
INCBIN "baserom.gb", $24AD, $24AF - $24AD

LoggedData_0x24AF:
INCBIN "baserom.gb", $24AF, $24BF - $24AF

Logged_0x24BF:
	ld hl,$CE78
	ld a,[hl]
	and a
	ret z
	dec [hl]
	ret nz
	ld hl,$C225
	ld a,[$D141]
	rla
	jr c,Logged_0x24D3
	ld hl,$C425

Logged_0x24D3:
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret
	ld a,[$CE74]
	rst JumpList
	dw Logged_0x24E5
	dw Logged_0x2508
	dw Logged_0x2513

Logged_0x24E5:
	ld a,$20
	ld [$CE77],a
	ld hl,$CE74
	inc [hl]
	ld hl,$C225
	ld a,$FF
	ld [hli],a
	ld a,$80
	ld [hl],a
	ld hl,$C22C
	set 7,[hl]
	ld hl,$C221
	ld b,$24
	ld c,$05
	ld d,$00
	jp Logged_0x31B3

Logged_0x2508:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x537F
	pop af
	ret

Logged_0x2513:
	ret

Logged_0x2514:
	call Logged_0x375E
	jp Logged_0x0ED4

Logged_0x251A:
	ld hl,$2526
	push hl
	ld a,[$C154]
	rst JumpList
	dw Logged_0x2536
	dw Logged_0x2541
	call Logged_0x2960
	call Logged_0x140E
	ld a,[$D141]
	rla
	jp nc,Logged_0x1095
	jp Logged_0x0F09

Logged_0x2536:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x5360
	pop af
	ret

Logged_0x2541:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$07
	ld [$FF00+$91],a
	xor a
	ld [$C154],a
	ld [$D179],a
	ret

Logged_0x2552:
	call Logged_0x3769
	jp Logged_0x0ED4

Unknown_0x2558:
	ld a,[$FF00+$8C]
	push af
	farcall UnknownData_0x524D
	pop af
	rst BankSwitch
	ret

Logged_0x2564:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x5225
	pop af
	rst BankSwitch
	ret

Logged_0x2570:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x513A
	pop af
	rst BankSwitch
	ret
	ld a,[$FF00+$91]
	rst JumpList
	dw Logged_0x25A3
	dw Logged_0x1C47
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x2629
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x262E
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x264B
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x132C
	dw Logged_0x1AEB

Logged_0x25A3:
	farcall Logged_0x4FA4
	ld a,[$FF00+$8C]
	push af
	ld a,$1F
	rst BankSwitch
	ld hl,$4004
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld b,$00

Logged_0x25B7:
	ld c,$00

Logged_0x25B9:
	ld a,[hl]
	push bc
	push hl
	push af
	swap b
	ld a,b
	add a,c
	ld h,$00
	ld l,a
	add hl,hl
	add hl,hl
	ld bc,$CA02
	add hl,bc
	pop af
	ld [hl],a
	pop hl
	pop bc
	inc hl
	inc c
	ld a,c
	cp $0A
	jr nz,Logged_0x25B9
	inc b
	ld a,b
	cp $09
	jr nz,Logged_0x25B7
	ld hl,$4002
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld b,$00

Logged_0x25E3:
	ld c,$00

Logged_0x25E5:
	ld a,[hl]
	push hl
	push bc
	push af
	swap b
	ld a,b
	add a,c
	ld h,$00
	ld l,a
	add hl,hl
	add hl,hl
	ld bc,$CA00
	add hl,bc
	pop af
	pop bc
	ld [hl],a
	pop hl
	inc hl
	inc c
	ld a,c
	cp $0A
	jr nz,Logged_0x25E5
	inc b
	ld a,b
	cp $09
	jr nz,Logged_0x25E3
	pop af
	rst BankSwitch
	call Logged_0x502A
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x47CE
	pop af
	rst BankSwitch
	ld hl,$C0A7
	res 1,[hl]
	ld a,$01
	ld [$D243],a
	ld a,$03
	ld [$D244],a
	jp Logged_0x060E

Logged_0x2629:
	ld a,$0C
	ld [$FF00+$91],a
	ret

Logged_0x262E:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x24040
	pop af
	rst BankSwitch
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x2960
	call Logged_0x140E
	call Logged_0x2B17
	jp Logged_0x1095

Logged_0x264B:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x24040
	pop af
	rst BankSwitch
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x2960
	call Logged_0x140E
	call Logged_0x2B17
	jp Logged_0x0F09

UnknownData_0x2668:
INCBIN "baserom.gb", $2668, $2677 - $2668

Logged_0x2677:
	ld a,[$C0F6]
	or a
	jr z,Logged_0x2688
	ld a,[$D120]
	and a
	jr nz,Logged_0x2688
	ld hl,$C207
	jr Logged_0x2694

Logged_0x2688:
	ld hl,$C427
	ld a,[$C420]
	or a
	jr nz,Logged_0x2694
	ld hl,$C227

Logged_0x2694:
	ld a,[hli]
	ld b,a
	ld a,[hli]
	ld c,a
	inc hl
	ld a,[hld]
	add a,c
	ld c,a
	ld a,[hl]
	adc a,b
	ld b,a
	ld hl,$C0E3
	ld de,$FF43
	ld a,[de]
	add a,[hl]
	sub b
	jr c,Logged_0x26B2
	ld c,a
	ld a,[de]
	sub c
	jr c,Logged_0x26B2
	ld [$C0DF],a

Logged_0x26B2:
	inc hl
	inc hl
	ld a,[de]
	add a,[hl]
	sub b
	ret nc
	ld c,a
	ld a,[de]
	sub c
	cp $61
	ret nc
	ld [$C0DF],a
	ret

Logged_0x26C2:
	ld h,$00
	ld l,a
	cp $80
	jr c,Logged_0x26CD
	ld a,b
	add a,$20
	ld b,a

Logged_0x26CD:
	ld a,[$FF00+$8C]
	push af
	ld a,$0A
	rst BankSwitch
	add hl,hl
	add hl,hl
	ld de,$4403
	add hl,de
	push hl
	ld hl,$C7E1
	ld a,[hl]
	and $1F
	inc [hl]
	ld d,$00
	ld h,d
	add a,a
	ld e,a
	ld l,a
	add hl,hl
	add hl,hl
	add hl,de
	ld de,$C7EB
	add hl,de
	ld d,h
	ld e,l
	pop hl
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	dec de
	dec de
	dec de
	dec de
	dec de
	ld h,$00
	ld l,b
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld b,$00
	add hl,bc
	ld bc,$9800
	add hl,bc
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	pop af
	rst BankSwitch
	jp Logged_0x09A3

Logged_0x271A:
	ld h,$00
	ld l,a
	cp $80
	jr c,Logged_0x2725
	ld a,b
	add a,$20
	ld b,a

Logged_0x2725:
	ld a,[$FF00+$8C]
	push af
	ld a,$0A
	rst BankSwitch
	add hl,hl
	add hl,hl
	ld de,$4003
	add hl,de
	push hl
	ld hl,$C7E1
	ld a,[hl]
	and $1F
	inc [hl]
	ld d,$00
	ld h,d
	add a,a
	ld e,a
	ld l,a
	add hl,hl
	add hl,hl
	add hl,de
	ld de,$C7EB
	add hl,de
	ld d,h
	ld e,l
	pop hl
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hld]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	dec de
	dec de
	dec de
	dec de
	dec de
	ld h,$00
	ld l,b
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld b,$00
	add hl,bc
	ld bc,$9800
	add hl,bc
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	pop af
	rst BankSwitch
	jp Logged_0x09A3

UnknownData_0x2772:
INCBIN "baserom.gb", $2772, $27E6 - $2772

Logged_0x27E6:
	ld a,$E3
	ld [$C0A7],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld a,$00
	ld [$FF00+$47],a
	ld a,$1C
	ld [$FF00+$48],a
	ld a,$83
	ld [$FF00+$49],a
	xor a
	ld [$FF00+$42],a
	ld [$FF00+$43],a
	ld hl,$C0DE
	ld [hli],a
	ld [hl],a
	ld hl,$C7E4
	ld c,$20

Logged_0x280E:
	ld a,$02
	ld [hli],a
	ld [hli],a
	ld d,h
	ld e,l
	inc de
	inc de
	ld a,e
	ld [hli],a
	ld a,d
	ld [hli],a
	ld de,$0006
	add hl,de
	dec c
	jr nz,Logged_0x280E
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x282F
	ld a,[$CEB5]
	add a,$48
	jr Logged_0x2834

Logged_0x282F:
	ld a,[$CFDD]
	add a,$58

Logged_0x2834:
	call Logged_0x0A96
	ld hl,$9800
	ld bc,$0400
	ld a,$55
	call Logged_0x0914
	ld hl,$9C00
	ld bc,$0400
	ld a,$54
	call Logged_0x0914
	ld hl,$C0A7
	res 1,[hl]
	ld a,$04
	ld [$CE75],a
	ld a,[$CFDD]
	ld b,a
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x2864
	ld b,$07

Logged_0x2864:
	ld a,b
	add a,a
	ld c,a
	ld b,$00
	ld hl,$2886
	add hl,bc
	ld a,[hli]
	ld [$D243],a
	ld a,[hl]
	ld [$D244],a
	ld a,[$CFDD]
	add a,a
	add a,$48
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	jp Logged_0x060E

LoggedData_0x2886:
INCBIN "baserom.gb", $2886, $28A6 - $2886

Unknown_0x28A6:
	call Logged_0x05CC
	ld a,$E3
	jr Logged_0x28B2

Logged_0x28AD:
	call Logged_0x05CC
	ld a,$AB

Logged_0x28B2:
	ld [$C0A7],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld a,$1E
	ld [$FF00+$47],a
	ld a,$1C
	ld [$FF00+$48],a
	ld a,$83
	ld [$FF00+$49],a
	xor a
	ld [$FF00+$42],a
	ld [$FF00+$43],a
	ld hl,$C7E4
	ld c,$20

Logged_0x28D3:
	ld a,$02
	ld [hli],a
	ld [hli],a
	ld d,h
	ld e,l
	inc de
	inc de
	ld a,e
	ld [hli],a
	ld a,d
	ld [hli],a
	ld de,$0006
	add hl,de
	dec c
	jr nz,Logged_0x28D3
	xor a
	call Logged_0x0A96
	ld hl,$9C00
	ld bc,$0400
	xor a
	call Logged_0x0914
	call Logged_0x19FF
	ld a,[$CFDB]
	call Logged_0x09C9
	ret

Logged_0x28FE:
	ld a,[$FF00+$8C]
	push af
	ld a,$0A
	rst BankSwitch
	ld b,$00
	ld a,h
	cp $9C
	jr c,Logged_0x290D
	ld b,$80

Logged_0x290D:
	ld a,b
	ld [$D24B],a
	ld b,$09

Logged_0x2913:
	push bc
	push hl
	push de
	ld c,$0A

Logged_0x2918:
	push bc
	push hl
	ld hl,$D24B
	ld a,[de]
	add a,[hl]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld bc,$4400
	add hl,bc
	pop bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	push hl
	ld hl,$001F
	add hl,bc
	pop bc
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ld bc,$FFE1
	add hl,bc
	inc de
	inc de
	inc de
	inc de
	pop bc
	dec c
	jr nz,Logged_0x2918
	pop de
	ld hl,$0040
	add hl,de
	ld e,l
	ld d,h
	pop hl
	ld bc,$0040
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x2913
	pop af
	rst BankSwitch
	ret

Logged_0x2958:
	ld hl,$C200
	ld c,$20
	jp Logged_0x2A92

Logged_0x2960:
	ld c,$20
	jr Logged_0x2966

UnknownData_0x2964:
INCBIN "baserom.gb", $2964, $2966 - $2964

Logged_0x2966:
	ld hl,$C200
	call Logged_0x29A0
	ld hl,$D143
	bit 6,[hl]
	jr z,Logged_0x2977
	res 6,[hl]
	jr Logged_0x297C

Logged_0x2977:
	ld a,[$D16B]
	and a
	ret z

Logged_0x297C:
	ld a,[$D141]
	rla
	jr nc,Logged_0x298B
	ld hl,$C220
	ld a,[hl]
	and a
	ret nz
	jp Logged_0x2A1D

Logged_0x298B:
	ld hl,$C420
	ld a,[hl]
	and a
	ret nz
	jp Logged_0x2A1D

UnknownData_0x2994:
INCBIN "baserom.gb", $2994, $299B - $2994

Logged_0x299B:
	ld hl,$C400
	ld c,$10

Logged_0x29A0:
	ld a,[$FF00+$8C]
	push af
	ld a,$02
	rst BankSwitch

Logged_0x29A6:
	push bc
	push hl
	ld a,[hl]
	and a
	jr z,Logged_0x2A11
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	rla
	jr nc,Logged_0x2A11
	dec hl
	ld a,[hl]
	and a
	jr nz,Logged_0x2A11
	ld a,$F7
	add a,l
	ld l,a
	inc [hl]
	ld e,l
	ld d,h
	dec de
	ld a,[de]
	ld l,a
	ld h,$00
	add hl,hl
	ld bc,$7038
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$0C
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	inc de
	ld a,[de]
	inc a
	cp [hl]
	jr c,Logged_0x29F9
	dec de
	dec de
	ld a,[de]
	set 6,a
	ld [de],a
	bit 4,a
	jr z,Logged_0x29F6
	xor a
	ld [de],a
	ld a,$F4
	add a,e
	ld e,a
	xor a
	ld [de],a
	ld a,$0C
	add a,e
	ld e,a

Logged_0x29F6:
	inc de
	inc de
	xor a

Logged_0x29F9:
	ld [de],a
	inc hl
	ld c,a
	add hl,bc
	ld a,$FD
	add a,e
	ld e,a
	ld a,[hl]
	rla
	jr nc,Logged_0x2A0B
	inc de
	ld a,[de]
	set 5,a
	ld [de],a
	dec de

Logged_0x2A0B:
	ld a,[hl]
	and $7F
	cpl
	inc a
	ld [de],a

Logged_0x2A11:
	pop hl
	ld bc,$0020
	add hl,bc
	pop bc
	dec c
	jr nz,Logged_0x29A6
	pop af
	rst BankSwitch
	ret

Logged_0x2A1D:
	ld a,[$FF00+$8C]
	push af
	ld a,$02
	rst BankSwitch
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	rla
	jr nc,Logged_0x2A8F
	dec hl
	ld a,[hl]
	and a
	jr nz,Logged_0x2A8F
	ld a,$F7
	add a,l
	ld l,a
	inc [hl]
	ld a,$FF
	add a,l
	ld e,a
	ld d,h
	ld a,[de]
	ld l,a
	ld h,$00
	add hl,hl
	ld bc,$7038
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$0C
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$01
	add a,e
	ld e,a
	ld a,[de]
	inc a
	cp [hl]
	jr c,Logged_0x2A77
	ld a,$FE
	add a,e
	ld e,a
	ld a,[de]
	set 6,a
	ld [de],a
	bit 4,a
	jr z,Logged_0x2A72
	ld a,$F4
	add a,e
	ld e,a
	xor a
	ld [de],a
	ld a,$0C
	add a,e
	ld e,a

Logged_0x2A72:
	ld a,$02
	add a,e
	ld e,a
	xor a

Logged_0x2A77:
	ld [de],a
	inc hl
	ld c,a
	add hl,bc
	ld a,$FD
	add a,e
	ld e,a
	ld a,[hl]
	rla
	jr nc,Logged_0x2A89
	inc de
	ld a,[de]
	set 5,a
	ld [de],a
	dec de

Logged_0x2A89:
	ld a,[hl]
	and $7F
	cpl
	inc a
	ld [de],a

Logged_0x2A8F:
	pop af
	rst BankSwitch
	ret

Logged_0x2A92:
	ld a,[$FF00+$8C]
	push af
	ld a,$0D
	rst BankSwitch

Logged_0x2A98:
	push bc
	push hl
	ld a,[hl]
	and a
	jr z,Logged_0x2B0B
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	rla
	jr nc,Logged_0x2B0B
	dec hl
	ld a,[hl]
	and a
	jr nz,Logged_0x2B0B
	ld a,$F7
	add a,l
	ld l,a
	inc [hl]
	ld a,$FF
	add a,l
	ld e,a
	ld d,h
	ld a,[de]
	ld l,a
	ld h,$00
	add hl,hl
	ld bc,$7985
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$0C
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$01
	add a,e
	ld e,a
	ld a,[de]
	inc a
	cp [hl]
	jr c,Logged_0x2AF2
	ld a,$FE
	add a,e
	ld e,a
	ld a,[de]
	set 6,a
	ld [de],a
	bit 4,a
	jr z,Logged_0x2AED
	ld a,$F4
	add a,e
	ld e,a
	xor a
	ld [de],a
	ld a,$FE
	add a,e
	ld e,a

Logged_0x2AED:
	ld a,$02
	add a,e
	ld e,a
	xor a

Logged_0x2AF2:
	ld [de],a
	inc hl
	ld c,a
	add hl,bc
	ld a,$FD
	add a,e
	ld e,a
	ld a,[hl]
	rla
	jr nc,Logged_0x2B04
	inc de
	ld a,[de]
	set 5,a
	ld [de],a
	dec de

Logged_0x2B04:
	ld a,[hl]
	and $7F
	xor $FF
	inc a
	ld [de],a

Logged_0x2B0B:
	pop hl
	ld bc,$0020
	add hl,bc
	pop bc
	dec c
	jr nz,Logged_0x2A98
	pop af
	rst BankSwitch
	ret

Logged_0x2B17:
	ld a,[$D12B]
	rra
	ret c
	ld hl,$D20A
	ld c,$04

Logged_0x2B21:
	ld a,[hl]
	and a
	jr z,Logged_0x2B3C
	push bc
	push hl
	ld e,l
	ld d,h
	dec a
	ld hl,$2B3A
	push hl
	add a,a
	ld c,a
	ld b,$00
	ld hl,$2B5A
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

UnknownData_0x2B3A:
INCBIN "baserom.gb", $2B3A, $2B3C - $2B3A

Logged_0x2B3C:
	ld de,$0008
	add hl,de
	dec c
	jr nz,Logged_0x2B21
	ld a,[$D189]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$2B52
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x2B52:
INCBIN "baserom.gb", $2B52, $2B62 - $2B52

UnknownData_0x2B62:
INCBIN "baserom.gb", $2B62, $2B7A - $2B62

LoggedData_0x2B7A:
INCBIN "baserom.gb", $2B7A, $2B80 - $2B7A
	ld hl,$D18A
	jp Logged_0x2B95
	ld hl,$D192
	jp Logged_0x2B95
	ld hl,$D19A
	jp Logged_0x2B95
	ld hl,$D1A2

Logged_0x2B95:
	ld c,$04

Logged_0x2B97:
	ld a,[hl]
	and a
	jr z,Logged_0x2BB2
	push bc
	push hl
	ld e,l
	ld d,h
	dec a
	ld hl,$2BB0
	push hl
	add a,a
	ld c,a
	ld b,$00
	ld hl,$2B5A
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	pop hl
	pop bc

Logged_0x2BB2:
	ld de,$0020
	add hl,de
	dec c
	jr nz,Logged_0x2B97
	ld hl,$D189
	ld a,[hl]
	inc a
	and $03
	ld [hl],a
	ret
	xor a
	ld [de],a
	inc de
	ld a,[de]
	ld b,a
	inc de
	ld a,[de]
	ld c,a
	inc de
	ld a,[de]
	jp Logged_0x271A
	ld bc,$6C25
	inc de
	inc de
	inc de
	ld a,[de]
	rst JumpList
	dw Logged_0x2BE7
	dw Logged_0x2E8F
	dw Unknown_0x3101
	dw Logged_0x136C

UnknownData_0x2BDF:
INCBIN "baserom.gb", $2BDF, $2BE7 - $2BDF

Logged_0x2BE7:
	ld a,[de]
	inc a
	ld [de],a
	inc de
	ld a,$02
	ld [de],a
	jp Logged_0x2E96
	ld bc,$6C39
	inc de
	inc de
	inc de
	ld a,[de]
	rst JumpList
	dw Logged_0x2BFD
	dw Logged_0x2C2A

Logged_0x2BFD:
	push bc
	push de
	dec de
	ld a,[de]
	add a,a
	add a,a
	add a,a
	add a,$08
	ld c,a
	dec de
	ld a,[de]
	add a,a
	add a,a
	add a,a
	add a,$10
	ld d,a
	ld e,c
	ld bc,$0108
	call Logged_0x2EDD
	pop de
	pop bc
	jr z,Logged_0x2C20
	dec de
	dec de
	dec de
	xor a
	ld [de],a
	ret

Logged_0x2C20:
	ld a,[de]
	inc a
	ld [de],a
	inc de
	ld a,$02
	ld [de],a
	jp Logged_0x2E96

Logged_0x2C2A:
	push bc
	push de
	dec de
	ld a,[de]
	add a,a
	add a,a
	add a,a
	add a,$08
	ld c,a
	dec de
	ld a,[de]
	add a,a
	add a,a
	add a,a
	add a,$10
	ld d,a
	ld e,c
	ld bc,$0108
	call Logged_0x2EDD
	pop de
	pop bc
	jr z,Logged_0x2C4D
	dec de
	dec de
	dec de
	xor a
	ld [de],a
	ret

Logged_0x2C4D:
	push de
	call Logged_0x2E8F
	pop hl
	dec hl
	dec hl
	dec hl
	ld a,[hli]
	and a
	ret nz
	inc hl
	ld a,[hld]
	sub $07
	rlca
	rlca
	rlca
	add a,$40
	ld e,a
	ld a,[hl]
	sub $03
	rlca
	rlca
	rlca
	add a,$28
	ld d,a
	push de
	call Logged_0x2F24
	ld c,$00
	ld a,[hl]
	cp $10
	jr c,Logged_0x2C7D
	cp $30
	jr nc,Logged_0x2C7D
	and $F0
	ld c,a

Logged_0x2C7D:
	ld [hl],c
	pop de
	ld hl,$6C49
	ld c,$04

Logged_0x2C84:
	push bc
	push de
	push hl
	ld a,[hli]
	add a,d
	ld d,a
	cp [hl]
	jr z,Logged_0x2CCC
	inc hl
	ld a,[hli]
	add a,e
	ld e,a
	cp [hl]
	jr z,Logged_0x2CCC
	inc hl
	ld b,[hl]
	push de
	push bc
	call Logged_0x2F24
	pop bc
	pop de
	ld a,[hl]
	cp $11
	jr c,Logged_0x2CCC
	cp $20
	jr z,Logged_0x2CCC
	cp $30
	jr nc,Logged_0x2CCC
	ld a,[hl]
	and b
	ld [hl],a
	push af
	dec hl
	dec hl
	ld a,[hl]
	cp $10
	jr c,Logged_0x2CB9
	cp $20
	jr c,Logged_0x2CC6

Logged_0x2CB9:
	call Logged_0x2FF4
	ld c,e
	ld b,d
	pop af
	add a,$80
	call Logged_0x271A
	jr Logged_0x2CCC

Logged_0x2CC6:
	pop af
	inc hl
	inc hl
	ld a,[hl]
	and b
	ld [hl],a

Logged_0x2CCC:
	pop hl
	ld bc,$0005
	add hl,bc
	pop de
	pop bc
	dec c
	jr nz,Logged_0x2C84
	ret
	ld bc,$6C39
	inc de
	inc de
	inc de
	ld a,[de]
	rst JumpList
	dw Logged_0x2CE3
	dw Logged_0x2CED

Logged_0x2CE3:
	ld a,[de]
	inc a
	ld [de],a
	inc de
	ld a,$02
	ld [de],a
	jp Logged_0x2EBD

Logged_0x2CED:
	push de
	call Logged_0x2EB6
	pop hl
	dec hl
	dec hl
	dec hl
	ld a,[hli]
	and a
	ret nz
	inc hl
	ld a,[hld]
	rlca
	rlca
	rlca
	add a,$08
	ld e,a
	ld a,[hl]
	rlca
	rlca
	rlca
	add a,$10
	ld d,a
	push de
	call Logged_0x2FBC
	ld [hl],$00
	pop de
	ld hl,$6C49
	ld c,$04

Logged_0x2D13:
	push bc
	push de
	push hl
	ld a,[hli]
	add a,d
	ld d,a
	cp [hl]
	jr z,Logged_0x2D44
	inc hl
	ld a,[hli]
	add a,e
	ld e,a
	cp [hl]
	jr z,Logged_0x2D44
	inc hl
	ld b,[hl]
	push de
	push bc
	call Logged_0x2FBC
	pop bc
	pop de
	ld a,[hl]
	cp $11
	jr c,Logged_0x2D44
	cp $20
	jr nc,Logged_0x2D44
	ld a,[hl]
	and b
	ld [hl],a
	push af
	call Logged_0x3007
	ld c,e
	ld b,d
	pop af
	add a,$80
	call Logged_0x26C2

Logged_0x2D44:
	pop hl
	ld bc,$0005
	add hl,bc
	pop de
	pop bc
	dec c
	jr nz,Logged_0x2D13
	ret
	inc de
	inc de
	inc de
	ld a,[de]
	rst JumpList
	dw Logged_0x2D58
	dw Logged_0x2D6C

Logged_0x2D58:
	ld l,e
	ld h,d
	dec hl
	dec hl
	ld b,[hl]
	inc hl
	ld c,[hl]
	inc hl
	inc [hl]
	inc hl
	inc hl
	ld a,$80
	ld [hld],a
	ld a,[hl]
	add a,$22
	jp Logged_0x271A

Logged_0x2D6C:
	dec de
	dec de
	dec de
	xor a
	ld [de],a
	ret

UnknownData_0x2D72:
INCBIN "baserom.gb", $2D72, $2E6C - $2D72
	xor a
	ld [de],a
	inc de
	ld a,[de]
	ld b,a
	inc de
	ld a,[de]
	ld c,a
	inc de
	ld a,[de]
	jp Logged_0x26C2
	ld bc,$6C29
	inc de
	inc de
	inc de
	ld a,[de]
	rst JumpList
	dw Logged_0x2E85
	dw Logged_0x2EB6

Logged_0x2E85:
	ld a,[de]
	inc a
	ld [de],a
	inc de
	ld a,$04
	ld [de],a
	jp Logged_0x2EBD

Logged_0x2E8F:
	inc de
	inc de
	ld a,[de]
	dec a
	ld [de],a
	ret nz
	dec de

Logged_0x2E96:
	ld a,[de]
	dec a
	ld [de],a
	add a,a
	ld l,a
	ld h,$00
	add hl,bc
	inc de
	ld a,[hli]
	ld [de],a
	dec de
	ld a,[de]
	dec de
	dec de
	dec de
	dec de
	and a
	jr nz,Logged_0x2EAC
	xor a
	ld [de],a

Logged_0x2EAC:
	inc de
	ld a,[de]
	ld b,a
	inc de
	ld a,[de]
	ld c,a
	ld a,[hl]
	jp Logged_0x271A

Logged_0x2EB6:
	inc de
	inc de
	ld a,[de]
	dec a
	ld [de],a
	ret nz
	dec de

Logged_0x2EBD:
	ld a,[de]
	dec a
	ld [de],a
	add a,a
	ld l,a
	ld h,$00
	add hl,bc
	inc de
	ld a,[hli]
	ld [de],a
	dec de
	ld a,[de]
	dec de
	dec de
	dec de
	dec de
	and a
	jr nz,Logged_0x2ED3
	xor a
	ld [de],a

Logged_0x2ED3:
	inc de
	ld a,[de]
	ld b,a
	inc de
	ld a,[de]
	ld c,a
	ld a,[hl]
	jp Logged_0x26C2

Logged_0x2EDD:
	push bc
	push bc
	call Logged_0x2F0A
	ld a,[hl]
	ld d,a
	add a,a
	add a,[hl]
	pop bc
	add a,b
	ld l,a
	ld h,$00
	ld bc,$3338
	add hl,bc
	pop bc
	ld a,c
	and [hl]
	ret

Logged_0x2EF3:
	push bc
	push bc
	call Logged_0x2F24
	ld e,l
	ld d,h
	ld a,[hl]
	nop
	add a,a
	pop bc
	add a,b
	ld l,a
	ld h,$00
	ld bc,$33CB
	add hl,bc
	pop bc
	ld a,c
	and [hl]
	ret

Logged_0x2F0A:
	ld a,d
	sub $18
	and $F0
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld a,e
	sub $30
	and $F0
	rrca
	rrca
	ld e,a
	ld d,$00
	add hl,de
	ld de,$CA00
	add hl,de
	ret

Logged_0x2F24:
	ld a,d
	sub $18
	and $F0
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld a,e
	sub $30
	and $F0
	swap a
	add a,a
	add a,a
	ld e,a
	ld d,$00
	add hl,de
	ld de,$CA02
	add hl,de
	ret

Logged_0x2F40:
	ld a,d
	and $0F
	swap a
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld a,e
	add a,a
	add a,a
	ld e,a
	ld d,$00
	add hl,de
	ld de,$CA44
	add hl,de
	ret

UnknownData_0x2F56:
INCBIN "baserom.gb", $2F56, $2F6C - $2F56

Logged_0x2F6C:
	push bc
	push bc
	call Logged_0x2FA4
	ld a,[hl]
	ld d,a
	ld l,a
	ld c,a
	ld h,$00
	ld b,$00
	add hl,hl
	add hl,bc
	pop bc
	ld c,b
	ld b,$00
	add hl,bc
	ld bc,$342D
	add hl,bc
	pop bc
	ld a,c
	and [hl]
	ret

Logged_0x2F88:
	push bc
	push bc
	call Logged_0x2FBC
	ld a,[hl]
	ld d,a
	ld l,a
	ld c,a
	ld h,$00
	ld b,$00
	add hl,hl
	add hl,bc
	pop bc
	ld c,b
	ld b,$00
	add hl,bc
	ld bc,$35AD
	add hl,bc
	pop bc
	ld a,c
	and [hl]
	ret

Logged_0x2FA4:
	ld a,d
	sub $10
	and $F0
	ld d,a
	ld a,e
	sub $08
	and $F0
	swap a
	add a,d
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld de,$CA00
	add hl,de
	ret

Logged_0x2FBC:
	ld a,d
	sub $10
	and $F0
	ld d,a
	ld a,e
	sub $08
	and $F0
	swap a
	add a,d
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld de,$CA02
	add hl,de
	ret

Logged_0x2FD4:
	ld a,d
	and $0F
	swap a
	add a,e
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld de,$CA00
	add hl,de
	ret

Logged_0x2FE4:
	ld a,d
	and $0F
	swap a
	add a,e
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld de,$CA02
	add hl,de
	ret

Logged_0x2FF4:
	ld a,d
	sub $10
	and $F8
	rrca
	rrca
	rrca
	ld d,a
	ld a,e
	sub $08
	and $F8
	rrca
	rrca
	rrca
	ld e,a
	ret

Logged_0x3007:
	ld a,d
	sub $10
	and $F8
	rrca
	rrca
	rrca
	ld d,a
	ld a,e
	sub $08
	and $F8
	rrca
	rrca
	rrca
	ld e,a
	ret

Logged_0x301A:
	add a,a
	ld c,a
	ld b,$00
	ld hl,$372D
	add hl,bc
	ld a,d
	add a,[hl]
	ld d,a
	inc hl
	ld a,e
	add a,[hl]
	ld e,a
	ret

Logged_0x302A:
	add a,a
	ld c,a
	ld b,$00
	ld hl,$3735
	add hl,bc
	ld a,d
	add a,[hl]
	ld d,a
	inc hl
	ld a,e
	add a,[hl]
	ld e,a
	ret

Logged_0x303A:
	and $F0
	swap a
	ld c,a
	ld b,$00
	ld hl,$3328
	add hl,bc
	ld a,[hl]
	ret

Logged_0x3047:
	ld hl,$D18A
	ld de,$0008
	ld c,$10

Logged_0x304F:
	ld a,[hl]
	and a
	ret z
	add hl,de
	dec c
	jr nz,Logged_0x304F

Unknown_0x3056:
	jr Unknown_0x3056

UnknownData_0x3058:
INCBIN "baserom.gb", $3058, $3069 - $3058

Logged_0x3069:
	ld hl,$C240
	ld de,$0020
	ld b,$02
	ld c,$0E

Logged_0x3073:
	ld a,[hl]
	and a
	ret z
	add hl,de
	inc b
	dec c
	jr nz,Logged_0x3073
	scf
	ret

Logged_0x307D:
	ld hl,$C440
	ld de,$0020
	ld b,$12
	ld c,$0E

Logged_0x3087:
	ld a,[hl]
	and a
	ret z
	add hl,de
	inc b
	dec c
	jr nz,Logged_0x3087
	scf
	ret

Logged_0x3091:
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,bc
	ld bc,$C200
	add hl,bc
	ret

Logged_0x309F:
	push bc
	push hl
	ld a,[de]
	ld c,a
	push bc
	inc de

Logged_0x30A5:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x30A5
	pop bc
	ld a,$20
	sub c
	jr z,Logged_0x30B6
	ld c,a
	xor a
	call Logged_0x091D

Logged_0x30B6:
	pop hl
	ld a,$03
	add a,l
	ld l,a
	pop bc
	ld [hl],b
	ld a,$04
	add a,l
	ld l,a
	ld [hl],c
	ret

Logged_0x30C3:
	ld b,$10
	inc hl
	inc hl
	ld a,[hl]
	ld c,$10
	cp $10
	jr c,Logged_0x30DB
	cp $30
	jr nc,Logged_0x30DB
	ld c,a
	and $0F
	add a,b
	ld b,a
	ld a,c
	and $F0
	ld c,a

Logged_0x30DB:
	ld a,c
	ld [hld],a
	dec hl
	ld [hl],b
	ret

Logged_0x30E0:
	rst JumpList
	dw Logged_0x30E9
	dw Logged_0x30EF
	dw Logged_0x30F5
	dw Logged_0x30FB

Logged_0x30E9:
	ld a,d
	cp $27
	ret c
	and a
	ret

Logged_0x30EF:
	ld a,$88
	cp d
	ret c
	and a
	ret

Logged_0x30F5:
	ld a,e
	cp $3F
	ret c
	and a
	ret

Logged_0x30FB:
	ld a,$C0
	cp e
	ret c
	and a
	ret

Unknown_0x3101:
	rst JumpList
	dw Unknown_0x310A
	dw Unknown_0x3110
	dw Unknown_0x3116
	dw Unknown_0x311C

Unknown_0x310A:
	ld a,d
	cp $23
	ret c
	and a
	ret

Unknown_0x3110:
	ld a,$88
	cp d
	ret c
	and a
	ret

Unknown_0x3116:
	ld a,e
	cp $08
	ret c
	and a
	ret

Unknown_0x311C:
	ld a,$F8
	cp e
	ret c
	and a
	ret

Logged_0x3122:
	rst JumpList
	dw Logged_0x312B
	dw Logged_0x3131
	dw Logged_0x3137
	dw Logged_0x313D

Logged_0x312B:
	ld a,d
	cp $0F
	ret c
	and a
	ret

Logged_0x3131:
	ld a,$90
	cp d
	ret c
	and a
	ret

Logged_0x3137:
	ld a,$A8
	cp e
	ret c
	and a
	ret

Logged_0x313D:
	ld a,$98
	cp e
	ret c
	and a
	ret

Logged_0x3143:
	rla
	jr nc,Logged_0x314E
	add hl,bc
	ld a,d
	cp $88
	jr nc,Logged_0x3171
	xor a
	ret

Logged_0x314E:
	rla
	jr nc,Logged_0x3158
	ld a,d
	cp $29
	jr c,Logged_0x3171
	xor a
	ret

Logged_0x3158:
	rla
	jr nc,Logged_0x3164
	add hl,bc
	add hl,bc
	ld a,e
	cp $41
	jr c,Logged_0x3171
	xor a
	ret

Logged_0x3164:
	rla
	jr nc,Logged_0x3174
	add hl,bc
	add hl,bc
	add hl,bc
	ld a,e
	cp $C0
	jr nc,Logged_0x3171
	xor a
	ret

Logged_0x3171:
	ld a,$01
	ret

Logged_0x3174:
	ld a,$02
	ret

Logged_0x3177:
	rla
	jr nc,Logged_0x3183
	add hl,bc
	ld a,d
	cp $90
	jp nc,Logged_0x31A9
	jr Logged_0x31A7

Logged_0x3183:
	rla
	jr nc,Logged_0x318E
	ld a,d
	cp $11
	jp c,Logged_0x31A9
	jr Logged_0x31A7

Logged_0x318E:
	rla
	jr nc,Logged_0x319B
	add hl,bc
	add hl,bc
	ld a,e
	cp $09
	jp c,Logged_0x31A9
	jr Logged_0x31A7

Logged_0x319B:
	rla
	jr nc,Logged_0x31AC
	add hl,bc
	add hl,bc
	add hl,bc
	ld a,e
	cp $98
	jp nc,Logged_0x31A9

Logged_0x31A7:
	xor a
	ret

Logged_0x31A9:
	ld a,$01
	ret

Logged_0x31AC:
	ld a,$02
	ret

Logged_0x31AF:
	ld a,b
	cp [hl]
	jr z,Logged_0x31BC

Logged_0x31B3:
	ld a,b
	ld [hli],a
	ld [hl],d
	ld a,$0B
	add a,l
	ld l,a
	jr Logged_0x31C3

Logged_0x31BC:
	ld a,$0C
	add a,l
	ld l,a
	ld a,c
	cp [hl]
	ret z

Logged_0x31C3:
	ld [hl],c
	ld a,$01
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld a,$FE
	add a,l
	ld l,a
	ld a,[hl]
	and $9F
	ld [hl],a
	ld a,$F5
	add a,l
	ld e,a
	ld d,h

Logged_0x31D7:
	ld a,[$FF00+$8C]
	push af
	ld hl,$C157
	ld a,[hl]
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$3212
	add hl,bc
	ld a,[hli]
	ld c,a
	ld a,[hli]
	ld b,a
	ld a,[hl]
	rst BankSwitch
	ld a,[de]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$0C
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	inc hl
	ld a,$FE
	add a,e
	ld e,a
	ld a,[hl]
	and $7F
	xor $FF
	inc a
	ld [de],a
	pop af
	rst BankSwitch
	ret

LoggedData_0x3212:
INCBIN "baserom.gb", $3212, $3218 - $3212

Logged_0x3218:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x31107
	pop af
	rst BankSwitch
	ret

Logged_0x3224:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x20B00
	pop af
	rst BankSwitch
	ret

Logged_0x3230:
	ld b,a
	ld a,[$FF00+$8C]
	push af
	ld a,$08
	rst BankSwitch
	ld a,b
	call Logged_0x20B03
	pop af
	rst BankSwitch
	ret

UnknownData_0x323E:
INCBIN "baserom.gb", $323E, $3256 - $323E

Logged_0x3256:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x4105
	pop af
	rst BankSwitch
	ret

Logged_0x3262:
	ld b,a
	ld a,[$C0A0]
	bit 7,a
	ret z
	ld a,[$FF00+$8C]
	push af
	ld a,$02
	rst BankSwitch
	ld a,b
	add a,a
	ld c,a
	ld b,$00
	ld hl,$4000
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	inc hl
	ld de,$C161
	ld c,$08
	call Logged_0x092B
	pop af
	rst BankSwitch
	ret

Logged_0x3287:
	ld hl,$C200
	ld bc,$0400
	xor a
	jp Logged_0x0914

Logged_0x3291:
	ld hl,$C220
	ld a,[$D141]
	rla
	ret c
	ld hl,$C420
	ret

Logged_0x329D:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x26B11
	pop af
	rst BankSwitch
	ret

UnknownData_0x32A9:
INCBIN "baserom.gb", $32A9, $32B5 - $32A9

Logged_0x32B5:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x26B85
	pop af
	rst BankSwitch
	ret

Logged_0x32C1:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x31162
	pop af
	rst BankSwitch
	ret

Logged_0x32CD:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x32EE4
	pop af
	rst BankSwitch
	ret

Logged_0x32D9:
	xor a
	ld e,a
	ld d,a
	inc b
	dec b
	jr z,Logged_0x32F3
	ld c,$10

Logged_0x32E2:
	sla l
	rl h
	rla
	sub b
	jr nc,Logged_0x32EB
	add a,b

Logged_0x32EB:
	ccf
	rl e
	rl d
	dec c
	jr nz,Logged_0x32E2

Logged_0x32F3:
	ld l,e
	ld h,d
	ret

Logged_0x32F6:
	ld c,l
	ld b,h
	ld hl,$0000
	ld a,$10

Logged_0x32FD:
	srl d
	rr e
	jr nc,Logged_0x3304
	add hl,bc

Logged_0x3304:
	sla c
	rl b
	dec a
	jr nz,Logged_0x32FD
	ret

Logged_0x330C:
	ld d,$00

Logged_0x330E:
	ld a,[hli]
	add a,d
	ld d,a
	dec bc
	ld a,b
	or c
	jr nz,Logged_0x330E
	ld [hl],d
	ret

Logged_0x3318:
	ld a,[$FF00+$8C]
	ld [$D247],a
	farcall Logged_0x5464
	ld a,[$D247]
	rst BankSwitch
	ret

LoggedData_0x3328:
INCBIN "baserom.gb", $3328, $332B - $3328

UnknownData_0x332B:
INCBIN "baserom.gb", $332B, $332C - $332B

LoggedData_0x332C:
INCBIN "baserom.gb", $332C, $332F - $332C

UnknownData_0x332F:
INCBIN "baserom.gb", $332F, $3330 - $332F

LoggedData_0x3330:
INCBIN "baserom.gb", $3330, $3333 - $3330

UnknownData_0x3333:
INCBIN "baserom.gb", $3333, $3338 - $3333

LoggedData_0x3338:
INCBIN "baserom.gb", $3338, $333B - $3338

UnknownData_0x333B:
INCBIN "baserom.gb", $333B, $3368 - $333B

LoggedData_0x3368:
INCBIN "baserom.gb", $3368, $336E - $3368

UnknownData_0x336E:
INCBIN "baserom.gb", $336E, $3371 - $336E

LoggedData_0x3371:
INCBIN "baserom.gb", $3371, $3374 - $3371

UnknownData_0x3374:
INCBIN "baserom.gb", $3374, $3376 - $3374

LoggedData_0x3376:
INCBIN "baserom.gb", $3376, $3377 - $3376

UnknownData_0x3377:
INCBIN "baserom.gb", $3377, $3379 - $3377

LoggedData_0x3379:
INCBIN "baserom.gb", $3379, $337A - $3379

UnknownData_0x337A:
INCBIN "baserom.gb", $337A, $337C - $337A

LoggedData_0x337C:
INCBIN "baserom.gb", $337C, $337D - $337C

UnknownData_0x337D:
INCBIN "baserom.gb", $337D, $3383 - $337D

LoggedData_0x3383:
INCBIN "baserom.gb", $3383, $3386 - $3383

UnknownData_0x3386:
INCBIN "baserom.gb", $3386, $3387 - $3386

LoggedData_0x3387:
INCBIN "baserom.gb", $3387, $3389 - $3387

UnknownData_0x3389:
INCBIN "baserom.gb", $3389, $338A - $3389

LoggedData_0x338A:
INCBIN "baserom.gb", $338A, $338B - $338A

UnknownData_0x338B:
INCBIN "baserom.gb", $338B, $338C - $338B

LoggedData_0x338C:
INCBIN "baserom.gb", $338C, $338F - $338C

UnknownData_0x338F:
INCBIN "baserom.gb", $338F, $3393 - $338F

LoggedData_0x3393:
INCBIN "baserom.gb", $3393, $3395 - $3393

UnknownData_0x3395:
INCBIN "baserom.gb", $3395, $3398 - $3395

LoggedData_0x3398:
INCBIN "baserom.gb", $3398, $339B - $3398

UnknownData_0x339B:
INCBIN "baserom.gb", $339B, $339E - $339B

LoggedData_0x339E:
INCBIN "baserom.gb", $339E, $339F - $339E

UnknownData_0x339F:
INCBIN "baserom.gb", $339F, $33A1 - $339F

LoggedData_0x33A1:
INCBIN "baserom.gb", $33A1, $33A4 - $33A1

UnknownData_0x33A4:
INCBIN "baserom.gb", $33A4, $33CB - $33A4

LoggedData_0x33CB:
INCBIN "baserom.gb", $33CB, $33CC - $33CB

UnknownData_0x33CC:
INCBIN "baserom.gb", $33CC, $33EB - $33CC

LoggedData_0x33EB:
INCBIN "baserom.gb", $33EB, $33EC - $33EB

UnknownData_0x33EC:
INCBIN "baserom.gb", $33EC, $3411 - $33EC

LoggedData_0x3411:
INCBIN "baserom.gb", $3411, $3412 - $3411

UnknownData_0x3412:
INCBIN "baserom.gb", $3412, $341B - $3412

LoggedData_0x341B:
INCBIN "baserom.gb", $341B, $341C - $341B

UnknownData_0x341C:
INCBIN "baserom.gb", $341C, $3423 - $341C

LoggedData_0x3423:
INCBIN "baserom.gb", $3423, $3424 - $3423

UnknownData_0x3424:
INCBIN "baserom.gb", $3424, $3427 - $3424

LoggedData_0x3427:
INCBIN "baserom.gb", $3427, $3428 - $3427

UnknownData_0x3428:
INCBIN "baserom.gb", $3428, $342D - $3428

LoggedData_0x342D:
INCBIN "baserom.gb", $342D, $343C - $342D

UnknownData_0x343C:
INCBIN "baserom.gb", $343C, $3445 - $343C

LoggedData_0x3445:
INCBIN "baserom.gb", $3445, $3448 - $3445

UnknownData_0x3448:
INCBIN "baserom.gb", $3448, $344B - $3448

LoggedData_0x344B:
INCBIN "baserom.gb", $344B, $3455 - $344B

UnknownData_0x3455:
INCBIN "baserom.gb", $3455, $345D - $3455

LoggedData_0x345D:
INCBIN "baserom.gb", $345D, $3460 - $345D

UnknownData_0x3460:
INCBIN "baserom.gb", $3460, $3462 - $3460

LoggedData_0x3462:
INCBIN "baserom.gb", $3462, $346E - $3462

UnknownData_0x346E:
INCBIN "baserom.gb", $346E, $346F - $346E

LoggedData_0x346F:
INCBIN "baserom.gb", $346F, $3471 - $346F

UnknownData_0x3471:
INCBIN "baserom.gb", $3471, $3472 - $3471

LoggedData_0x3472:
INCBIN "baserom.gb", $3472, $3481 - $3472

UnknownData_0x3481:
INCBIN "baserom.gb", $3481, $348A - $3481

LoggedData_0x348A:
INCBIN "baserom.gb", $348A, $348B - $348A

UnknownData_0x348B:
INCBIN "baserom.gb", $348B, $348D - $348B

LoggedData_0x348D:
INCBIN "baserom.gb", $348D, $348E - $348D

UnknownData_0x348E:
INCBIN "baserom.gb", $348E, $34A5 - $348E

LoggedData_0x34A5:
INCBIN "baserom.gb", $34A5, $34A8 - $34A5

UnknownData_0x34A8:
INCBIN "baserom.gb", $34A8, $34AE - $34A8

LoggedData_0x34AE:
INCBIN "baserom.gb", $34AE, $34AF - $34AE

UnknownData_0x34AF:
INCBIN "baserom.gb", $34AF, $34C0 - $34AF

LoggedData_0x34C0:
INCBIN "baserom.gb", $34C0, $34C4 - $34C0

UnknownData_0x34C4:
INCBIN "baserom.gb", $34C4, $34C6 - $34C4

LoggedData_0x34C6:
INCBIN "baserom.gb", $34C6, $34C7 - $34C6

UnknownData_0x34C7:
INCBIN "baserom.gb", $34C7, $34C9 - $34C7

LoggedData_0x34C9:
INCBIN "baserom.gb", $34C9, $34CA - $34C9

UnknownData_0x34CA:
INCBIN "baserom.gb", $34CA, $34CC - $34CA

LoggedData_0x34CC:
INCBIN "baserom.gb", $34CC, $34CD - $34CC

UnknownData_0x34CD:
INCBIN "baserom.gb", $34CD, $34DF - $34CD

LoggedData_0x34DF:
INCBIN "baserom.gb", $34DF, $34E1 - $34DF

UnknownData_0x34E1:
INCBIN "baserom.gb", $34E1, $34E2 - $34E1

LoggedData_0x34E2:
INCBIN "baserom.gb", $34E2, $34E3 - $34E2

UnknownData_0x34E3:
INCBIN "baserom.gb", $34E3, $34E5 - $34E3

LoggedData_0x34E5:
INCBIN "baserom.gb", $34E5, $34E7 - $34E5

UnknownData_0x34E7:
INCBIN "baserom.gb", $34E7, $34E8 - $34E7

LoggedData_0x34E8:
INCBIN "baserom.gb", $34E8, $3518 - $34E8

UnknownData_0x3518:
INCBIN "baserom.gb", $3518, $351A - $3518

LoggedData_0x351A:
INCBIN "baserom.gb", $351A, $351B - $351A

UnknownData_0x351B:
INCBIN "baserom.gb", $351B, $3523 - $351B

LoggedData_0x3523:
INCBIN "baserom.gb", $3523, $3524 - $3523

UnknownData_0x3524:
INCBIN "baserom.gb", $3524, $3526 - $3524

LoggedData_0x3526:
INCBIN "baserom.gb", $3526, $3527 - $3526

UnknownData_0x3527:
INCBIN "baserom.gb", $3527, $3528 - $3527

LoggedData_0x3528:
INCBIN "baserom.gb", $3528, $353F - $3528

UnknownData_0x353F:
INCBIN "baserom.gb", $353F, $3540 - $353F

LoggedData_0x3540:
INCBIN "baserom.gb", $3540, $3555 - $3540

UnknownData_0x3555:
INCBIN "baserom.gb", $3555, $3557 - $3555

LoggedData_0x3557:
INCBIN "baserom.gb", $3557, $3558 - $3557

UnknownData_0x3558:
INCBIN "baserom.gb", $3558, $3577 - $3558

LoggedData_0x3577:
INCBIN "baserom.gb", $3577, $3578 - $3577

UnknownData_0x3578:
INCBIN "baserom.gb", $3578, $357A - $3578

LoggedData_0x357A:
INCBIN "baserom.gb", $357A, $357B - $357A

UnknownData_0x357B:
INCBIN "baserom.gb", $357B, $357C - $357B

LoggedData_0x357C:
INCBIN "baserom.gb", $357C, $3584 - $357C

UnknownData_0x3584:
INCBIN "baserom.gb", $3584, $3585 - $3584

LoggedData_0x3585:
INCBIN "baserom.gb", $3585, $3587 - $3585

UnknownData_0x3587:
INCBIN "baserom.gb", $3587, $3588 - $3587

LoggedData_0x3588:
INCBIN "baserom.gb", $3588, $3589 - $3588

UnknownData_0x3589:
INCBIN "baserom.gb", $3589, $3595 - $3589

LoggedData_0x3595:
INCBIN "baserom.gb", $3595, $359B - $3595

UnknownData_0x359B:
INCBIN "baserom.gb", $359B, $359E - $359B

LoggedData_0x359E:
INCBIN "baserom.gb", $359E, $35AE - $359E

UnknownData_0x35AE:
INCBIN "baserom.gb", $35AE, $35AF - $35AE

LoggedData_0x35AF:
INCBIN "baserom.gb", $35AF, $35B0 - $35AF

UnknownData_0x35B0:
INCBIN "baserom.gb", $35B0, $35C8 - $35B0

LoggedData_0x35C8:
INCBIN "baserom.gb", $35C8, $35C9 - $35C8

UnknownData_0x35C9:
INCBIN "baserom.gb", $35C9, $35CA - $35C9

LoggedData_0x35CA:
INCBIN "baserom.gb", $35CA, $35CB - $35CA

UnknownData_0x35CB:
INCBIN "baserom.gb", $35CB, $35DD - $35CB

LoggedData_0x35DD:
INCBIN "baserom.gb", $35DD, $35DE - $35DD

UnknownData_0x35DE:
INCBIN "baserom.gb", $35DE, $35E0 - $35DE

LoggedData_0x35E0:
INCBIN "baserom.gb", $35E0, $35E1 - $35E0

UnknownData_0x35E1:
INCBIN "baserom.gb", $35E1, $35E2 - $35E1

LoggedData_0x35E2:
INCBIN "baserom.gb", $35E2, $35E4 - $35E2

UnknownData_0x35E4:
INCBIN "baserom.gb", $35E4, $35E5 - $35E4

LoggedData_0x35E5:
INCBIN "baserom.gb", $35E5, $35E7 - $35E5

UnknownData_0x35E7:
INCBIN "baserom.gb", $35E7, $35E8 - $35E7

LoggedData_0x35E8:
INCBIN "baserom.gb", $35E8, $35EA - $35E8

UnknownData_0x35EA:
INCBIN "baserom.gb", $35EA, $35EB - $35EA

LoggedData_0x35EB:
INCBIN "baserom.gb", $35EB, $35ED - $35EB

UnknownData_0x35ED:
INCBIN "baserom.gb", $35ED, $35EE - $35ED

LoggedData_0x35EE:
INCBIN "baserom.gb", $35EE, $35F0 - $35EE

UnknownData_0x35F0:
INCBIN "baserom.gb", $35F0, $35F1 - $35F0

LoggedData_0x35F1:
INCBIN "baserom.gb", $35F1, $35F3 - $35F1

UnknownData_0x35F3:
INCBIN "baserom.gb", $35F3, $35F4 - $35F3

LoggedData_0x35F4:
INCBIN "baserom.gb", $35F4, $35F6 - $35F4

UnknownData_0x35F6:
INCBIN "baserom.gb", $35F6, $35F7 - $35F6

LoggedData_0x35F7:
INCBIN "baserom.gb", $35F7, $35F9 - $35F7

UnknownData_0x35F9:
INCBIN "baserom.gb", $35F9, $35FA - $35F9

LoggedData_0x35FA:
INCBIN "baserom.gb", $35FA, $35FC - $35FA

UnknownData_0x35FC:
INCBIN "baserom.gb", $35FC, $35FD - $35FC

LoggedData_0x35FD:
INCBIN "baserom.gb", $35FD, $35FF - $35FD

UnknownData_0x35FF:
INCBIN "baserom.gb", $35FF, $3600 - $35FF

LoggedData_0x3600:
INCBIN "baserom.gb", $3600, $3602 - $3600

UnknownData_0x3602:
INCBIN "baserom.gb", $3602, $3603 - $3602

LoggedData_0x3603:
INCBIN "baserom.gb", $3603, $3605 - $3603

UnknownData_0x3605:
INCBIN "baserom.gb", $3605, $3606 - $3605

LoggedData_0x3606:
INCBIN "baserom.gb", $3606, $3608 - $3606

UnknownData_0x3608:
INCBIN "baserom.gb", $3608, $3609 - $3608

LoggedData_0x3609:
INCBIN "baserom.gb", $3609, $360B - $3609

UnknownData_0x360B:
INCBIN "baserom.gb", $360B, $360C - $360B

LoggedData_0x360C:
INCBIN "baserom.gb", $360C, $360D - $360C

UnknownData_0x360D:
INCBIN "baserom.gb", $360D, $3640 - $360D

LoggedData_0x3640:
INCBIN "baserom.gb", $3640, $3641 - $3640

UnknownData_0x3641:
INCBIN "baserom.gb", $3641, $3643 - $3641

LoggedData_0x3643:
INCBIN "baserom.gb", $3643, $3644 - $3643

UnknownData_0x3644:
INCBIN "baserom.gb", $3644, $3646 - $3644

LoggedData_0x3646:
INCBIN "baserom.gb", $3646, $3647 - $3646

UnknownData_0x3647:
INCBIN "baserom.gb", $3647, $3649 - $3647

LoggedData_0x3649:
INCBIN "baserom.gb", $3649, $364A - $3649

UnknownData_0x364A:
INCBIN "baserom.gb", $364A, $364C - $364A

LoggedData_0x364C:
INCBIN "baserom.gb", $364C, $364D - $364C

UnknownData_0x364D:
INCBIN "baserom.gb", $364D, $366A - $364D

LoggedData_0x366A:
INCBIN "baserom.gb", $366A, $366B - $366A

UnknownData_0x366B:
INCBIN "baserom.gb", $366B, $3676 - $366B

LoggedData_0x3676:
INCBIN "baserom.gb", $3676, $3677 - $3676

UnknownData_0x3677:
INCBIN "baserom.gb", $3677, $3678 - $3677

LoggedData_0x3678:
INCBIN "baserom.gb", $3678, $3679 - $3678

UnknownData_0x3679:
INCBIN "baserom.gb", $3679, $367C - $3679

LoggedData_0x367C:
INCBIN "baserom.gb", $367C, $367D - $367C

UnknownData_0x367D:
INCBIN "baserom.gb", $367D, $367E - $367D

LoggedData_0x367E:
INCBIN "baserom.gb", $367E, $3680 - $367E

UnknownData_0x3680:
INCBIN "baserom.gb", $3680, $3681 - $3680

LoggedData_0x3681:
INCBIN "baserom.gb", $3681, $3683 - $3681

UnknownData_0x3683:
INCBIN "baserom.gb", $3683, $3684 - $3683

LoggedData_0x3684:
INCBIN "baserom.gb", $3684, $3685 - $3684

UnknownData_0x3685:
INCBIN "baserom.gb", $3685, $3694 - $3685

LoggedData_0x3694:
INCBIN "baserom.gb", $3694, $3695 - $3694

UnknownData_0x3695:
INCBIN "baserom.gb", $3695, $3696 - $3695

LoggedData_0x3696:
INCBIN "baserom.gb", $3696, $3698 - $3696

UnknownData_0x3698:
INCBIN "baserom.gb", $3698, $369A - $3698

LoggedData_0x369A:
INCBIN "baserom.gb", $369A, $369B - $369A

UnknownData_0x369B:
INCBIN "baserom.gb", $369B, $369C - $369B

LoggedData_0x369C:
INCBIN "baserom.gb", $369C, $369E - $369C

UnknownData_0x369E:
INCBIN "baserom.gb", $369E, $369F - $369E

LoggedData_0x369F:
INCBIN "baserom.gb", $369F, $36A1 - $369F

UnknownData_0x36A1:
INCBIN "baserom.gb", $36A1, $36A3 - $36A1

LoggedData_0x36A3:
INCBIN "baserom.gb", $36A3, $36A4 - $36A3

UnknownData_0x36A4:
INCBIN "baserom.gb", $36A4, $36A6 - $36A4

LoggedData_0x36A6:
INCBIN "baserom.gb", $36A6, $36A7 - $36A6

UnknownData_0x36A7:
INCBIN "baserom.gb", $36A7, $36AC - $36A7

LoggedData_0x36AC:
INCBIN "baserom.gb", $36AC, $36AD - $36AC

UnknownData_0x36AD:
INCBIN "baserom.gb", $36AD, $36AE - $36AD

LoggedData_0x36AE:
INCBIN "baserom.gb", $36AE, $36B0 - $36AE

UnknownData_0x36B0:
INCBIN "baserom.gb", $36B0, $36B1 - $36B0

LoggedData_0x36B1:
INCBIN "baserom.gb", $36B1, $36B3 - $36B1

UnknownData_0x36B3:
INCBIN "baserom.gb", $36B3, $36B4 - $36B3

LoggedData_0x36B4:
INCBIN "baserom.gb", $36B4, $36B5 - $36B4

UnknownData_0x36B5:
INCBIN "baserom.gb", $36B5, $36BB - $36B5

LoggedData_0x36BB:
INCBIN "baserom.gb", $36BB, $36BC - $36BB

UnknownData_0x36BC:
INCBIN "baserom.gb", $36BC, $36C4 - $36BC

LoggedData_0x36C4:
INCBIN "baserom.gb", $36C4, $36C5 - $36C4

UnknownData_0x36C5:
INCBIN "baserom.gb", $36C5, $36C7 - $36C5

LoggedData_0x36C7:
INCBIN "baserom.gb", $36C7, $36C8 - $36C7

UnknownData_0x36C8:
INCBIN "baserom.gb", $36C8, $36CA - $36C8

LoggedData_0x36CA:
INCBIN "baserom.gb", $36CA, $36CB - $36CA

UnknownData_0x36CB:
INCBIN "baserom.gb", $36CB, $372D - $36CB

LoggedData_0x372D:
INCBIN "baserom.gb", $372D, $373D - $372D
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x44D8E
	jr Logged_0x379E
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x44000
	jr Logged_0x379E

UnknownData_0x3753:
INCBIN "baserom.gb", $3753, $375E - $3753

Logged_0x375E:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x4443B
	jr Logged_0x379E

Logged_0x3769:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x44E7F
	jr Logged_0x379E

Logged_0x3774:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x441ED
	jr Logged_0x379E

Logged_0x377F:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x44132
	jr Logged_0x379E

Logged_0x378A:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x44BA8
	jr Logged_0x379E

Logged_0x3795:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x4A906

Logged_0x379E:
	pop af
	rst BankSwitch
	ret

Logged_0x37A1:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x48021
	jr Logged_0x379E

Logged_0x37AC:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x48000
	jr Logged_0x379E

Logged_0x37B7:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x209F4
	jr Logged_0x379E

Logged_0x37C2:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x20FDF
	jr Logged_0x37D6

Logged_0x37CD:
	ld a,[$FF00+$8C]
	push af
	farcall Logged_0x20C7A

Logged_0x37D6:
	pop bc
	ld a,b
	rst BankSwitch
	ret

Logged_0x37DA:
	ld a,$01
	rst BankSwitch
	jp Logged_0x404D

Logged_0x37E0:
	ld hl,$D6AE
	ld a,[hli]
	or [hl]
	ret z
	ld a,[$D129]
	bit 0,a
	ret nz
	ld a,[$FF00+$8C]
	push af
	ld a,[$D6A9]
	rst BankSwitch
	ld a,[$D6AA]
	ld e,a
	ld a,[$D6AB]
	ld d,a
	ld hl,$D6B1
	ld c,$20
	ld a,[$D6B0]
	inc a
	dec a
	jr z,Logged_0x3808
	ld c,a

Logged_0x3808:
	ld b,c

Logged_0x3809:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x3809
	ld a,e
	ld [$D6AA],a
	ld a,d
	ld [$D6AB],a
	ld de,$D6AC
	ld hl,$D29F
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	ld a,$01
	ld [hli],a
	ld a,b
	ld [hli],a
	ld a,$B1
	ld [hli],a
	ld a,$D6
	ld [hl],a
	ld de,$D29F
	call Logged_0x09A3
	ld hl,$D6AC
	ld a,[hl]
	add a,$20
	ld [hli],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ld hl,$D6AE
	ld a,[hl]
	sub $20
	ld [hli],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr nc,Logged_0x384E
	xor a
	ld [hld],a
	ld [hl],a

Logged_0x384E:
	pop af
	rst BankSwitch
	ret

Logged_0x3851:
	ld a,[$FF00+$8C]
	push af
	ld a,$16
	rst BankSwitch
	ld hl,$4002
	ld a,[$D6A5]
	ld [$D6A6],a
	sub [hl]
	jr c,Logged_0x3869
	ld [$D6A6],a
	ld a,$05
	rst BankSwitch

Logged_0x3869:
	ld a,[$D6A5]
	cp $6E
	jr nc,Logged_0x38CC
	cp $5A
	jr nc,Logged_0x389D
	ld a,[$D141]
	bit 7,a
	jr nz,Logged_0x388C
	ld de,$0007
	ld hl,$9800
	call Logged_0x37A1
	ld bc,$3AD9
	call Logged_0x3AAC
	jr Logged_0x38D5

Logged_0x388C:
	ld de,$0006
	ld hl,$9800
	call Logged_0x37A1
	ld bc,$3AC5
	call Logged_0x3AAC
	jr Logged_0x38D5

Logged_0x389D:
	ld hl,$D12D
	bit 2,[hl]
	jr z,Logged_0x38C1
	ld a,[$D136]
	add a,$6C
	ld [$D6A5],a
	ld a,$16
	rst BankSwitch
	ld hl,$4002
	ld a,[$D6A5]
	ld [$D6A6],a
	sub [hl]
	jr c,Logged_0x38C1
	ld [$D6A6],a
	ld a,$05
	rst BankSwitch

Logged_0x38C1:
	ld de,$0021
	ld hl,$9800
	call Logged_0x37A1
	jr Logged_0x38D5

Logged_0x38CC:
	ld de,$0022
	ld hl,$9800
	call Logged_0x37A1

Logged_0x38D5:
	ld a,[$D6A6]
	ld l,a
	ld h,$00
	sla l
	rl h
	sla l
	rl h
	ld a,[$4000]
	add a,l
	ld l,a
	ld a,[$4001]
	adc a,h
	ld h,a
	ld b,[hl]
	inc hl
	ld c,[hl]
	inc hl
	ld e,[hl]
	inc hl
	ld d,[hl]
	ld hl,$9842
	xor a
	ld [$D6A8],a
	inc a
	ld [$D6A7],a

Logged_0x38FF:
	push bc
	push hl

Logged_0x3901:
	push bc
	ld a,[$D6A7]
	dec a
	jr nz,Logged_0x3917
	ld a,[de]
	inc de
	cp $7F
	jr nz,Logged_0x391D
	ld a,[de]
	push af
	inc de
	ld a,[de]
	ld [$D6A8],a
	inc de
	pop af

Logged_0x3917:
	ld [$D6A7],a
	ld a,[$D6A8]

Logged_0x391D:
	cp $7E
	jr z,Logged_0x3922
	ld [hl],a

Logged_0x3922:
	inc hl
	pop bc
	dec c
	jr nz,Logged_0x3901
	pop hl
	ld bc,$0020
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x38FF
	ld a,[$D6A5]
	cp $5A
	jr c,Logged_0x393A
	jp Logged_0x3A69

Logged_0x393A:
	sub $51
	jr nc,Logged_0x3941
	jp Logged_0x3A69

Logged_0x3941:
	jr nz,Logged_0x3946
	jp Logged_0x39FD

Logged_0x3946:
	dec a
	ld c,a
	ld b,$00
	push bc
	cp $07
	jr z,Logged_0x39AC
	ld hl,$D000
	add hl,bc
	ld l,[hl]
	ld h,b
	call Logged_0x14EB
	ld hl,$C14F
	ld de,$994D
	ld c,$00
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	pop bc
	push bc
	sla c
	ld hl,$D00A
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	or h
	jr z,Logged_0x398D
	call Logged_0x14EB
	ld hl,$C150
	ld de,$998E
	ld c,$00
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	jr Logged_0x39AC

Logged_0x398D:
	ld de,$9970
	ld a,$7E
	ld [de],a
	ld de,$9962
	ld hl,$3A6F
	ld c,$10

Logged_0x399B:
	ld a,[hli]
	ld [de],a
	inc de
	dec c
	jr nz,Logged_0x399B
	ld hl,$9982
	ld c,$10
	ld a,$7E

Logged_0x39A8:
	ld [hli],a
	dec c
	jr nz,Logged_0x39A8

Logged_0x39AC:
	pop bc
	push bc
	sla c
	ld hl,$D01E
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	call Logged_0x14EB
	ld hl,$C14D
	ld de,$99CB
	ld c,$00
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	pop bc
	ld a,c
	add a,c
	add a,c
	ld c,a
	ld hl,$D034
	add hl,bc
	ld de,$9904
	ld b,$00
	ld c,$00
	call Logged_0x3A7F
	dec hl
	ld de,$9909
	ld c,$00
	call Logged_0x3A7F
	dec hl
	ld de,$990D
	ld c,$00
	call Logged_0x3A95
	jp Logged_0x3A69

Logged_0x39FD:
	ld hl,$D009
	ld de,$994C
	ld c,$00
	call Logged_0x3A95
	dec hl
	call Logged_0x3A95
	ld hl,$D00A
	ld bc,$0700

Logged_0x3A12:
	ld a,[hli]
	or [hl]
	jr z,Logged_0x3A17
	inc c

Logged_0x3A17:
	inc hl
	dec b
	jr nz,Logged_0x3A12
	ld a,c
	ld hl,$D01A
	ld [hl],a
	ld de,$998E
	ld c,$00
	call Logged_0x3A95
	ld hl,$D01A
	ld de,$998E
	ld c,$00
	call Logged_0x3A95
	ld hl,$D030
	ld de,$99CA
	ld c,$00
	call Logged_0x3A95
	dec hl
	call Logged_0x3A95
	dec hl
	call Logged_0x3A95
	ld hl,$D04D
	ld de,$9902
	ld b,$00
	ld c,$00
	call Logged_0x3A95
	dec hl
	call Logged_0x3A7F
	dec hl
	ld de,$9909
	ld c,$00
	call Logged_0x3A7F
	dec hl
	ld de,$990D
	ld c,$00
	call Logged_0x3A95

Logged_0x3A69:
	pop af
	rst BankSwitch
	ld a,[$D6A5]
	ret

LoggedData_0x3A6F:
INCBIN "baserom.gb", $3A6F, $3A7F - $3A6F

Logged_0x3A7F:
	bit 0,b
	jr nz,Logged_0x3A95
	ld a,[hl]
	and a
	jr nz,Logged_0x3A95
	push hl
	push bc
	ld a,$7E
	ld c,$05

Logged_0x3A8D:
	ld [de],a
	inc de
	dec c
	jr nz,Logged_0x3A8D
	pop bc
	pop hl
	ret

Logged_0x3A95:
	ld a,[hl]
	swap a
	call Logged_0x3AA1
	ld a,[hl]
	call Logged_0x3AA1
	ret

Logged_0x3AA0:
	ld a,[hl]

Logged_0x3AA1:
	and $0F
	cp c
	jr z,Logged_0x3AAA
	ld [de],a
	ld c,$FF
	ld b,c

Logged_0x3AAA:
	inc de
	ret

Logged_0x3AAC:
	ld hl,$9A40
	ld d,$0E

Logged_0x3AB1:
	ld e,$20
	push bc
	push hl

Logged_0x3AB5:
	ld a,[bc]
	ld [hli],a
	inc bc
	dec e
	jr nz,Logged_0x3AB5
	pop hl
	ld bc,$0020
	add hl,bc
	pop bc
	dec d
	jr nz,Logged_0x3AB1
	ret

LoggedData_0x3AC5:
INCBIN "baserom.gb", $3AC5, $3AED - $3AC5

Logged_0x3AED:
	ld hl,$C240
	ld c,$0E
	jr Logged_0x3AF9

Logged_0x3AF4:
	ld hl,$C440
	ld c,$0A

Logged_0x3AF9:
	ld a,[$FF00+$8C]
	push af

Logged_0x3AFC:
	bit 7,[hl]
	jr z,Logged_0x3B1D
	push bc
	push hl
	ld e,l
	ld d,h
	ld hl,$3B1B
	push hl
	ld a,[de]
	and $7F
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$3B27
	add hl,bc
	ld a,[hli]
	rst BankSwitch
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	pop hl
	pop bc

Logged_0x3B1D:
	ld de,$0020
	add hl,de
	dec c
	jr nz,Logged_0x3AFC
	pop af
	rst BankSwitch
	ret

LoggedData_0x3B27:
INCBIN "baserom.gb", $3B27, $3B6C - $3B27

UnknownData_0x3B6C:
INCBIN "baserom.gb", $3B6C, $3B84 - $3B6C

LoggedData_0x3B84:
INCBIN "baserom.gb", $3B84, $3B8A - $3B84

UnknownData_0x3B8A:
INCBIN "baserom.gb", $3B8A, $3B8D - $3B8A

LoggedData_0x3B8D:
INCBIN "baserom.gb", $3B8D, $3BB7 - $3B8D

Logged_0x3BB7:
	ld hl,$C440
	ld c,$0A
	jr Logged_0x3BC3

Logged_0x3BBE:
	ld hl,$C240
	ld c,$08

Logged_0x3BC3:
	ld a,[$FF00+$8C]
	push af

Logged_0x3BC6:
	bit 7,[hl]
	jr z,Logged_0x3BE6
	push bc
	push hl
	ld e,l
	ld d,h
	ld hl,$3BE4
	push hl
	ld a,[de]
	and $7F
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$3BF0
	add hl,bc
	ld a,[hli]
	rst BankSwitch
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	pop hl
	pop bc

Logged_0x3BE6:
	ld de,$0020
	add hl,de
	dec c
	jr nz,Logged_0x3BC6
	pop af
	rst BankSwitch
	ret

LoggedData_0x3BF0:
INCBIN "baserom.gb", $3BF0, $3BF3 - $3BF0

UnknownData_0x3BF3:
INCBIN "baserom.gb", $3BF3, $3BF4 - $3BF3

LoggedData_0x3BF4:
INCBIN "baserom.gb", $3BF4, $3BF7 - $3BF4

UnknownData_0x3BF7:
INCBIN "baserom.gb", $3BF7, $3C07 - $3BF7

Unknown_0x3C07:
	call Logged_0x2677
	ld hl,$3C18
	push hl
	ld a,[$D137]
	rst JumpList
	dw Unknown_0x3C1E
	dw Unknown_0x3CAE
	dw Unknown_0x3CF6

UnknownData_0x3C18:
INCBIN "baserom.gb", $3C18, $3C1E - $3C18

Unknown_0x3C1E:
	call Unknown_0x28A6
	ld a,[$D120]
	and a
	ret nz
	ld de,$3DC5
	ld a,[$C0F9]
	and a
	jr nz,Unknown_0x3C32
	ld de,$3DD0

Unknown_0x3C32:
	ld hl,$C203
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	inc hl
	ld a,[de]
	ld [hl],a
	inc de
	ld hl,$C423
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	inc hl
	ld a,[de]
	ld [hl],a
	inc de
	ld hl,$C0E2
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld a,[de]
	ld hl,$C0DE
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld a,[de]
	ld [$C210],a
	xor $01
	ld [$C430],a
	ld hl,$D137
	inc [hl]
	ld a,$03
	ld [$D138],a
	ld hl,$C201
	ld a,[$C210]
	add a,$00
	ld b,a
	ld c,$02
	ld d,$00
	call Logged_0x31AF
	ld hl,$C20C
	set 7,[hl]
	call Unknown_0x3CDC
	call Logged_0x2677
	ld b,$00
	ld a,[$C0F9]
	and a
	jr nz,Unknown_0x3C99
	ld b,$60

Unknown_0x3C99:
	ld a,b
	ld [$FF00+$43],a
	call Logged_0x060E
	ld a,$01
	ld [$D243],a
	ld a,$0C
	ld [$D244],a
	xor a
	ld [$D24A],a
	ret

Unknown_0x3CAE:
	call Logged_0x2677
	ld hl,$D139
	dec [hl]
	ret nz
	dec hl
	dec [hl]
	jr nz,Unknown_0x3CDC
	ld a,$40
	ld [hl],a
	ld hl,$D137
	inc [hl]
	ld hl,$C209
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$C20C
	res 7,[hl]
	ld hl,$C201
	ld a,[$C210]
	add a,$00
	ld b,a
	ld c,$02
	ld d,$00
	jp Logged_0x31AF

Unknown_0x3CDC:
	ld de,$3E23
	ld a,[$C0F9]
	and a
	jr nz,Unknown_0x3CE8
	ld de,$3E25

Unknown_0x3CE8:
	ld hl,$C209
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld a,$10
	ld [$D139],a
	ret

Unknown_0x3CF6:
	ld hl,$D138
	dec [hl]
	ret nz
	ld hl,$C421
	ld a,[$C430]
	add a,$50
	ld b,a
	xor a
	ld c,a
	ld d,a
	call Logged_0x31AF
	ld de,$3ED0
	ld a,[$C0F9]
	and a
	jp nz,Logged_0x3E47
	ld de,$3ED4
	jp Logged_0x3E47

Logged_0x3D1A:
	ld hl,$3D28
	push hl
	ld a,[$D137]
	rst JumpList
	dw Logged_0x3D31
	dw Logged_0x3DDB
	dw Logged_0x3E27
	call Logged_0x299B
	call Logged_0x140E
	jp Logged_0x1095

Logged_0x3D31:
	call Logged_0x28AD
	ld a,[$D120]
	and a
	ret z
	ld de,$3DC5
	ld a,[$C0F9]
	and a
	jr nz,Logged_0x3D45
	ld de,$3DD0

Logged_0x3D45:
	ld hl,$C423
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	inc hl
	ld a,[de]
	ld [hl],a
	inc de
	ld hl,$C203
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	inc hl
	ld a,[de]
	ld [hl],a
	inc de
	ld hl,$C0E2
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld a,[de]
	ld hl,$C0DE
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld a,[de]
	ld [$C430],a
	xor $01
	ld [$C210],a
	ld hl,$D137
	inc [hl]
	ld a,$03
	ld [$D138],a
	ld hl,$C421
	ld a,[$C430]
	add a,$50
	ld b,a
	ld c,$02
	ld d,$00
	call Logged_0x31AF
	ld hl,$C42C
	set 7,[hl]
	call Logged_0x3E09
	call Logged_0x2677
	ld b,$00
	ld a,[$C0F9]
	and a
	jr nz,Logged_0x3DAC
	ld b,$60

Logged_0x3DAC:
	ld a,b
	ld [$FF00+$43],a
	call Logged_0x060E
	xor a
	ld [$C0FA],a
	ld a,$01
	ld [$D243],a
	ld a,$0C
	ld [$D244],a
	xor a
	ld [$D24A],a
	ret

UnknownData_0x3DC5:
INCBIN "baserom.gb", $3DC5, $3DD0 - $3DC5

LoggedData_0x3DD0:
INCBIN "baserom.gb", $3DD0, $3DDB - $3DD0

Logged_0x3DDB:
	call Logged_0x2677
	ld hl,$D139
	dec [hl]
	ret nz
	dec hl
	dec [hl]
	jr nz,Logged_0x3E09
	ld a,$40
	ld [hl],a
	ld hl,$D137
	inc [hl]
	ld hl,$C429
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$C42C
	res 7,[hl]
	ld hl,$C421
	ld a,[$C430]
	add a,$50
	ld b,a
	ld c,$02
	ld d,$00
	jp Logged_0x31AF

Logged_0x3E09:
	ld de,$3E23
	ld a,[$C0F9]
	and a
	jr nz,Logged_0x3E15
	ld de,$3E25

Logged_0x3E15:
	ld hl,$C429
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld a,$10
	ld [$D139],a
	ret

UnknownData_0x3E23:
INCBIN "baserom.gb", $3E23, $3E25 - $3E23

LoggedData_0x3E25:
INCBIN "baserom.gb", $3E25, $3E27 - $3E25

Logged_0x3E27:
	ld hl,$D138
	dec [hl]
	ret nz
	ld hl,$C201
	ld a,[$C210]
	add a,$00
	ld b,a
	xor a
	ld c,a
	ld d,a
	call Logged_0x31AF
	ld de,$3ED0
	ld a,[$C0F9]
	and a
	jr nz,Logged_0x3E47
	ld de,$3ED4

Logged_0x3E47:
	ld hl,$C0E2
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	xor a
	ld [$D24A],a
	ld [$C158],a
	ld hl,$FF91
	inc [hl]
	ld a,[$FF00+$90]
	cp $0C
	jr z,Logged_0x3EC2
	call Unknown_0x0652
	ld a,[$CFDB]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$3ED8
	add hl,bc
	ld a,[hli]
	ld [$D243],a
	ld a,[hl]
	ld [$D244],a
	ld c,$02
	ld hl,$C0FA

Unknown_0x3E81:
	ld a,[hl]
	and a
	jr z,Unknown_0x3E81
	xor a
	ld [hl],a
	dec c
	jr nz,Unknown_0x3E81
	xor a
	ld hl,$C0A8
	ld [hli],a
	ld [hl],a
	ld hl,$D264
	ld [hli],a
	ld [hl],a
	ld hl,$C10A
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$D259
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld [$D25E],a
	ld hl,$D266
	ld [hli],a
	ld [hl],a
	ld [$D26A],a
	ld hl,$D12B
	res 2,[hl]
	ld hl,$D12C
	res 7,[hl]
	ld a,$80
	ld [$D262],a
	ld a,$80
	ld [$D261],a
	ret

Logged_0x3EC2:
	ld a,$02
	ld [$D243],a
	ld a,$03
	ld [$D244],a
	ld [$D25D],a
	ret

UnknownData_0x3ED0:
INCBIN "baserom.gb", $3ED0, $3ED4 - $3ED0

LoggedData_0x3ED4:
INCBIN "baserom.gb", $3ED4, $3ED8 - $3ED4

UnknownData_0x3ED8:
INCBIN "baserom.gb", $3ED8, $3F66 - $3ED8

WorldPointers:
	dbw World1Pointer
	dbw World2Pointer
	dbw World3Pointer
	dbw World4Pointer
	dbw World5Pointer
	dbw World6Pointer
	dbw World7Pointer
	dbw World8Pointer
	dbw World9Pointer

SECTION "Bank01", ROMX, BANK[$01]

Logged_0x4000:
	ld a,$0B
	ld a,[$C0A0]
	push af
	ld hl,$C0A8
	ld a,[hli]
	ld b,a
	ld c,[hl]
	push hl
	push bc
	ld hl,$C000
	ld bc,$00A0
	xor a
	call Logged_0x0914
	ld hl,$C0A0
	ld bc,$11CD
	xor a
	call Logged_0x0914
	ld hl,$D26D
	ld bc,$04C6
	xor a
	call Logged_0x0914
	ld hl,$DB00
	ld bc,$0200
	xor a
	call Logged_0x0914
	pop bc
	pop hl
	ld a,c
	ld [hld],a
	ld [hl],b
	ld hl,$FF8A
	ld c,$20
	xor a
	call Logged_0x091D
	pop af
	ld [$C0A0],a
	call Logged_0x05B4
	jr Logged_0x40C1

Logged_0x404D:
	ld a,$00
	ld [$FF00+$47],a
	ld a,$0B
	call Logged_0x1629
	ld a,$03
	call Logged_0x1629
	ld a,$08
	call Logged_0x1629
	call Logged_0x1704
	ld hl,$9800
	ld a,$80
	ld bc,$0400
	call Logged_0x0914
	ld a,$81
	ld [$FF00+$40],a
	ei
	ld a,$06
	call Logged_0x1629
	ld a,[$C0A0]
	push af
	ld hl,$C0A8
	ld a,[hli]
	ld b,a
	ld c,[hl]
	push hl
	push bc
	ld hl,$C000
	ld bc,$00A0
	xor a
	call Logged_0x0914
	ld hl,$C0A5
	ld bc,$11C8
	xor a
	call Logged_0x0914
	ld hl,$D26D
	ld bc,$04C6
	xor a
	call Logged_0x0914
	ld hl,$DB00
	ld bc,$0200
	xor a
	call Logged_0x0914
	pop bc
	pop hl
	ld a,c
	ld [hld],a
	ld [hl],b
	ld hl,$FF8A
	ld c,$20
	xor a
	call Logged_0x091D
	pop af
	ld [$C0A0],a
	call Logged_0x05B4

Logged_0x40C1:
	call Logged_0x1384
	xor a
	ld [$FF00+$05],a
	ld a,$BB
	ld [$FF00+$06],a
	xor a
	ld [$FF00+$07],a
	ld a,$04
	ld [$FF00+$07],a
	ld a,$01
	ld [$DC02],a
	ld a,$40
	ld [$FF00+$41],a
	ld a,$E3
	ld [$C0A7],a
	xor a
	ld [$FF00+$0F],a
	ld [$C0FE],a
	ld [$FF00+$45],a
	ld a,$09
	ld [$C0A6],a
	ld [$FF00+$FF],a
	xor a
	ld [$FF00+$02],a
	ld a,$80
	ld [$FF00+$02],a
	ld a,$FD
	ld [$FF00+$01],a
	ld a,$FD
	ld [$C109],a
	ld hl,$C0A0
	set 0,[hl]
	ret

Logged_0x4105:
	push hl
	push de
	push bc
	call Logged_0x3007
	push de
	srl d
	srl e
	call Logged_0x2FD4
	ld a,[hli]
	ld [$D24B],a
	ld a,[hld]
	ld [hl],a
	pop bc
	call Logged_0x26C2
	call Logged_0x3069
	push hl
	ld a,$15
	add a,l
	ld l,a
	ld [hl],b
	pop hl
	pop bc
	ld a,b
	ld [hli],a
	inc hl
	inc hl
	pop de
	ld a,d
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,e
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hl],a
	ld a,$04
	add a,l
	ld l,a
	ld a,$0B
	ld [hli],a
	inc hl
	inc hl
	pop af
	ld [hli],a
	ld a,[$D24B]
	ld [hl],a
	ld a,$04
	add a,l
	ld l,a
	set 1,[hl]
	ld a,$E9
	add a,l
	ld l,a
	ld b,c
	ld c,$00
	ld d,$00
	push hl
	call Logged_0x31B3
	pop hl
	ret

Logged_0x415F:
	ld a,$01
	ld [$D245],a
	call Logged_0x05CC
	ld hl,$C240
	ld bc,$01C0
	xor a
	call Logged_0x0914
	ld hl,$C440
	ld bc,$01A0
	xor a
	call Logged_0x0914
	call Logged_0x3291
	ld de,$D144
	ld c,$20
	call Logged_0x092B
	xor a
	ld [$D179],a
	ld a,$04
	ld [$D159],a
	ld a,[$C9E4]
	cp $07
	jp z,Logged_0x439F
	cp $08
	jp z,Logged_0x4272
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld hl,$D23D
	ld a,[$C9E4]
	ld [hli],a
	ld a,[$CFDB]
	ld [hli],a
	ld a,d
	ld [hli],a
	ld a,e
	ld [hli],a
	ld a,[$D141]
	and $81
	ld [hl],a
	ld a,[$D239]
	add a,a
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$444C
	add hl,bc
	ld a,[hli]
	ld [$CFDB],a
	ld a,[hli]
	ld [$D23B],a
	swap a
	add a,$10
	ld d,a
	ld a,[hli]
	ld [$D23C],a
	swap a
	add a,$08
	ld e,a
	ld a,[hli]
	ld [$D23A],a
	ld b,a
	ld a,[hli]
	ld [$D24D],a
	ld a,[hl]
	ld [$D24E],a
	ld hl,$D147
	ld a,d
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld [hl],e
	ld a,b
	and a
	jr z,Unknown_0x420A
	ld hl,$D141
	res 7,[hl]
	set 0,[hl]
	ld a,$AB
	ld [$C0A7],a
	ld a,[$D24E]
	ld [$FF00+$91],a
	jr Unknown_0x421B

Unknown_0x420A:
	ld hl,$D141
	set 7,[hl]
	res 0,[hl]
	ld a,$E3
	ld [$C0A7],a
	ld a,[$D24D]
	ld [$FF00+$91],a

Unknown_0x421B:
	ld a,$08
	ld [$C9E4],a
	ld a,[$CFDB]
	add a,$38
	call Logged_0x0A96
	ld a,$50
	call Logged_0x1629
	ld a,$50
	call Logged_0x3262
	ld hl,$C500
	ld de,$44A0
	ld bc,$1090
	call Logged_0x309F
	ld hl,$C520
	ld de,$44A0
	ld bc,$1098
	call Logged_0x309F
	ld hl,$C14B
	ld a,$1E
	ld b,a
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld h,a
	ld l,b
	call Logged_0x14EB
	ld a,[$C150]
	ld [$C502],a
	ld a,[$C151]
	ld [$C522],a
	ld a,$02
	ld [$D243],a
	ld a,$03
	ld [$D244],a
	jp Logged_0x433F

Logged_0x4272:
	xor a
	ld [$C0DF],a
	ld [$FF00+$43],a
	ld hl,$D23D
	ld a,[hli]
	ld [$C9E4],a
	ld a,[hli]
	ld [$CFDB],a
	ld a,[hli]
	ld [$D147],a
	ld a,[hli]
	ld [$D14B],a
	ld a,[hl]
	ld [$D141],a
	ld hl,$D158
	ld a,[hl]
	and $20
	ld [hl],a
	ld hl,$D12B
	bit 3,[hl]
	jr z,Logged_0x42D3
	res 3,[hl]
	ld hl,$C922
	ld a,[hli]
	ld c,a
	ld b,$00
	ld a,[$CFDB]

Logged_0x42A9:
	cp [hl]
	jr z,Logged_0x42C2
	inc hl
	inc hl
	inc hl
	inc b
	dec c
	jr nz,Logged_0x42A9
	ld a,[$C922]
	inc a
	ld [$C922],a
	ld a,[$CFDB]
	ld [hl],a
	inc a
	ld [$CE73],a

Logged_0x42C2:
	inc hl
	ld a,[$D147]
	ld [hli],a
	ld a,[$D14B]
	ld [hl],a
	ld a,b
	inc a
	ld [$CE70],a
	call Logged_0x3230

Logged_0x42D3:
	ld a,$06
	ld [$CE79],a
	ld a,$1B
	ld [$FF00+$91],a
	xor a
	ld [$D16B],a
	ld [$D143],a
	ld a,[$CFDD]
	add a,$58
	call Logged_0x0A96
	ld a,[$CFDD]
	add a,a
	add a,$48
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	ld hl,$9800
	ld a,$55
	ld bc,$0400
	call Logged_0x0914
	ld hl,$9C00
	ld a,$54
	ld bc,$0400
	call Logged_0x0914
	ld a,[$CFDD]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$2886
	add hl,bc
	ld a,[hli]
	ld [$D243],a
	ld a,[hl]
	ld [$D244],a
	ld hl,$C5E0
	ld de,$44A3
	ld bc,$8E96
	call Logged_0x309F
	ld hl,$C5E1
	ld b,$3F
	ld a,[$CE52]
	ld c,a
	ld d,a
	add a,a
	add a,a
	add a,d
	ld d,a
	call Logged_0x31B3

Logged_0x433F:
	call Logged_0x1EA2
	ld a,[$FF00+$91]
	push af
	ld a,[$CEB0]
	and a
	jr z,Logged_0x436A
	ld a,[$C9E4]
	cp $08
	jr z,Unknown_0x4361
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld a,[hl]
	cp $FF
	jr z,Logged_0x436A

Unknown_0x4361:
	call Logged_0x22AD
	ld a,[$CEB0]
	and a
	jr nz,Unknown_0x4361

Logged_0x436A:
	pop af
	ld [$FF00+$91],a
	xor a
	ld [$CE7A],a
	ld hl,$9800
	ld de,$CA00
	call Logged_0x28FE
	ld hl,$9C00
	ld de,$CA02
	call Logged_0x28FE
	call Logged_0x3291
	ld e,l
	ld d,h
	ld hl,$D144
	ld c,$20
	call Logged_0x092B
	ld hl,$FF47
	ld a,$1E
	ld [hli],a
	ld a,$1C
	ld [hli],a
	ld a,$83
	ld [hl],a
	jp Logged_0x060E

Logged_0x439F:
	ld a,[$D239]
	add a,a
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$444C
	add hl,bc
	ld a,[hli]
	ld [$CFDB],a
	ld a,[hli]
	ld [$D23B],a
	swap a
	add a,$10
	ld d,a
	ld a,[hli]
	ld [$D23C],a
	swap a
	add a,$08
	ld e,a
	ld a,[hli]
	ld [$D23A],a
	ld b,a
	ld a,[hli]
	ld [$D24D],a
	ld a,[hl]
	ld [$D24E],a
	ld a,[$CEB3]
	ld [$CEB4],a
	ld hl,$D147
	ld a,d
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld [hl],e
	push de
	ld a,b
	and a
	jr z,Logged_0x43F7
	ld hl,$D141
	res 7,[hl]
	set 0,[hl]
	ld a,$AB
	ld [$C0A7],a
	ld a,[$D24E]
	ld [$FF00+$91],a
	jr Logged_0x4408

Logged_0x43F7:
	ld hl,$D141
	set 7,[hl]
	res 0,[hl]
	ld a,$E3
	ld [$C0A7],a
	ld a,[$D24D]
	ld [$FF00+$91],a

Logged_0x4408:
	ld hl,$CEB5
	inc [hl]
	ld a,[hl]
	add a,$48
	call Logged_0x0A96
	ld a,[$CEB5]
	add a,a
	add a,$48
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	ld hl,$C922
	ld a,[hl]
	add a,a
	add a,[hl]
	inc [hl]
	ld c,a
	ld b,$00
	ld hl,$C923
	add hl,bc
	ld a,[$CFDB]
	ld [hli],a
	pop de
	ld a,d
	ld [hli],a
	ld [hl],e
	xor a
	ld [$D243],a
	ld a,$04
	ld [$D245],a
	ld a,[$CEB5]
	ld [$CFDD],a
	ld hl,$CEB5
	dec [hl]
	jp Logged_0x433F

UnknownData_0x444C:
INCBIN "baserom.gb", $444C, $4476 - $444C

LoggedData_0x4476:
INCBIN "baserom.gb", $4476, $44A0 - $4476

UnknownData_0x44A0:
INCBIN "baserom.gb", $44A0, $44A3 - $44A0

LoggedData_0x44A3:
INCBIN "baserom.gb", $44A3, $44B1 - $44A3

Logged_0x44B1:
	ld b,$80
	ld a,[$FF00+$91]
	cp $20
	jr z,Logged_0x44D5
	ld a,[$D122]
	cp $08
	jr nz,Logged_0x44CE
	ld b,$04
	ld a,[$D141]
	rra
	jr nc,Logged_0x44CA
	ld b,$0C

Logged_0x44CA:
	ld a,b
	ld [$FF00+$91],a
	ret

Logged_0x44CE:
	ld hl,$DC05
	set 6,[hl]
	ld b,$3C

Logged_0x44D5:
	ld a,[$FF00+$91]
	sub $10
	ld [$FF00+$91],a
	ld a,b
	ld [$CE75],a
	ret
	ld hl,$CE75
	dec [hl]
	ret nz
	ld hl,$CE53
	bit 6,[hl]
	jr nz,Logged_0x44F3
	set 6,[hl]
	ld hl,$D12B
	set 3,[hl]

Logged_0x44F3:
	ld a,$74
	ld [$D6A5],a
	ld a,$13
	ld [$FF00+$91],a
	jr Logged_0x450C
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$75
	ld [$D6A5],a
	ld a,$13
	ld [$FF00+$91],a

Logged_0x450C:
	xor a
	ld [$C200],a
	ld [$C580],a
	ld [$C5A0],a
	ld [$C5C0],a
	ld [$C5E0],a
	ld [$C158],a
	ld hl,$C709
	xor a
	ld c,$C0
	call Logged_0x091D
	ld hl,$D18A
	xor a
	ld c,$80
	call Logged_0x091D
	ld hl,$D20A
	xor a
	ld c,$20
	call Logged_0x091D
	ld bc,$0101
	jp Logged_0x0AE5
	call Logged_0x377F
	ld a,[$D6A5]
	and a
	ret nz
	xor a
	ld [$FF00+$91],a
	ret
	call Logged_0x377F
	ld a,[$D6A5]
	and a
	ret nz
	ld a,$0A
	ld [$FF00+$90],a
	ld a,$14
	ld [$FF00+$91],a
	ld a,$E3
	ld [$C0A7],a
	ld a,$08
	ld [$C9E4],a
	ld hl,$C22C
	ld a,[$D141]
	rla
	jr c,Logged_0x4572
	ld hl,$C42C

Logged_0x4572:
	set 7,[hl]
	res 6,[hl]
	ld a,$07
	add a,l
	ld l,a
	ld a,$13
	ld [hli],a
	set 5,[hl]
	inc hl
	inc hl
	inc hl
	xor a
	ld [hli],a
	inc hl
	inc hl
	ld a,$03
	ld [hli],a
	ld [hl],$00
	ld a,$EA
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$F7
	add a,l
	ld l,a
	ld b,$41
	ld c,$01
	ld d,$00
	jp Logged_0x31AF
	ld hl,$CE79
	dec [hl]
	ret nz
	ld b,$08
	ld a,[$D141]
	rra
	jr c,Logged_0x45B2
	ld b,$0C

Logged_0x45B2:
	ld a,b
	ld [$FF00+$91],a
	ret

UnknownData_0x45B6:
INCBIN "baserom.gb", $45B6, $477B - $45B6

LoggedData_0x477B:
INCBIN "baserom.gb", $477B, $477E - $477B

UnknownData_0x477E:
INCBIN "baserom.gb", $477E, $47CE - $477E

Logged_0x47CE:
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	push bc
	ld hl,$A002
	add hl,bc
	push hl
	ld de,$D000
	ld c,$08
	call Logged_0x092B
	pop hl
	ld a,[hli]
	ld e,a
	ld d,$00
	ld c,$07

Logged_0x47F1:
	ld a,[hli]
	add a,e
	ld e,a
	ld a,d
	adc a,$00
	ld d,a
	dec c
	jr nz,Logged_0x47F1
	ld l,e
	ld h,d
	call Logged_0x14EB
	ld hl,$C14E
	ld a,[hli]
	swap a
	or [hl]
	ld [$D009],a
	inc hl
	ld a,[hli]
	swap a
	or [hl]
	ld [$D008],a
	pop bc
	push bc
	ld hl,$A010
	add hl,bc
	ld de,$D00A
	call Logged_0x4897
	pop bc
	push bc
	ld hl,$A013
	add hl,bc
	ld de,$D01E
	call Logged_0x48C0
	pop bc
	ld hl,$A016
	add hl,bc
	ld de,$D032
	ld b,$00

Logged_0x4834:
	push bc
	push hl
	ld a,b
	add a,a
	ld c,a
	ld b,$00
	ld hl,$4941
	add hl,bc
	ld a,[hli]
	ld b,[hl]
	ld c,a
	pop hl
	add hl,bc
	pop bc
	push hl
	ld c,$03

Logged_0x4848:
	push bc
	ld a,[hli]
	push hl
	push de
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld hl,$C150
	ld a,[hli]
	swap a
	or [hl]
	pop de
	ld [de],a
	inc de
	pop hl
	pop bc
	dec c
	jr nz,Logged_0x4848
	pop hl
	inc b
	ld a,b
	cp $08
	jr c,Logged_0x4834
	ld hl,$D04A
	xor a
	ld c,$04
	call Logged_0x091D
	ld de,$D032
	ld hl,$D04A
	ld c,$08

Logged_0x4879:
	ld b,$00
	call Logged_0x4951
	inc hl
	inc de
	call Logged_0x4951
	inc hl
	inc de
	ld a,[de]
	add a,[hl]
	daa
	add a,b
	daa
	ld [hli],a
	ld a,[hl]
	adc a,$00
	daa
	ld [hld],a
	inc de
	dec hl
	dec hl
	dec c
	jr nz,Logged_0x4879
	ret

Logged_0x4897:
	push de
	push de
	ld bc,$4941
	ld a,$08

Logged_0x489E:
	push af
	push de
	ld a,[bc]
	ld e,a
	inc bc
	ld a,[bc]
	ld d,a
	inc bc
	add hl,de
	pop de
	ld a,[hli]
	bit 6,a
	jr nz,Logged_0x48B3
	xor a
	ld [de],a
	inc de
	ld [de],a
	jr Logged_0x48B8

Logged_0x48B3:
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hld]
	ld [de],a

Logged_0x48B8:
	dec hl
	inc de
	pop af
	dec a
	jr nz,Logged_0x489E
	jr Logged_0x48DB

Logged_0x48C0:
	push de
	push de
	ld bc,$4941
	ld a,$08

Logged_0x48C7:
	push af
	push de
	ld a,[bc]
	ld e,a
	inc bc
	ld a,[bc]
	ld d,a
	inc bc
	add hl,de
	pop de
	ld a,[hl]
	ld [de],a
	inc de
	xor a
	ld [de],a
	inc de
	pop af
	dec a
	jr nz,Logged_0x48C7

Logged_0x48DB:
	ld hl,$D24B
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	pop hl
	ld c,$08

Logged_0x48E8:
	push bc
	ld a,[hli]
	ld d,[hl]
	inc hl
	push hl
	ld l,a
	ld h,d
	call Logged_0x14EB
	ld hl,$C151
	ld de,$D24B
	ld b,$00
	ld c,$05

Logged_0x48FC:
	ld a,[de]
	add a,[hl]
	add a,b
	ld b,$00
	cp $0A
	jr c,Logged_0x4908
	sub $0A
	inc b

Logged_0x4908:
	ld [de],a
	inc de
	dec hl
	dec c
	jr nz,Logged_0x48FC
	ld a,[de]
	add a,b
	ld [de],a
	jr nc,Logged_0x4922
	ld hl,$D24B
	ld a,$09
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	pop hl
	pop bc
	jr Logged_0x4927

Logged_0x4922:
	pop hl
	pop bc
	dec c
	jr nz,Logged_0x48E8

Logged_0x4927:
	pop de
	ld hl,$0013
	add hl,de
	ld e,l
	ld d,h
	ld hl,$D250
	xor a
	ld [de],a
	dec de
	ld c,$03

Logged_0x4936:
	ld a,[hld]
	swap a
	or [hl]
	dec hl
	ld [de],a
	dec de
	dec c
	jr nz,Logged_0x4936
	ret

LoggedData_0x4941:
INCBIN "baserom.gb", $4941, $4951 - $4941

Logged_0x4951:
	xor a
	ld [$D255],a
	ld a,[de]
	add a,[hl]
	daa
	jr nc,Logged_0x4965
	add a,$40
	push af
	ld a,[$D255]
	inc a
	ld [$D255],a
	pop af

Logged_0x4965:
	add a,b
	daa
	ld b,$00
	jr nc,Logged_0x496F
	add a,$40
	jr Logged_0x4975

Logged_0x496F:
	cp $60
	jr c,Logged_0x4976
	sub $60

Logged_0x4975:
	inc b

Logged_0x4976:
	ld [hl],a
	ld a,[$D255]
	add a,b
	ld b,a
	ret

Logged_0x497D:
	ld a,[$C9E4]
	cp $07
	jp nz,Logged_0x4A7C
	ld hl,$CEB5
	ld a,[hl]
	cp $07
	jp z,Logged_0x4A3D
	ld a,[hl]
	inc a
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$4AE8
	add hl,bc
	ld a,[hli]
	ld [$CEB3],a
	ld a,[hli]
	ld [$D23B],a
	ld a,[hl]
	ld [$D23C],a
	ld a,[$DC03]
	set 4,a
	ld [$DC03],a
	xor a
	ld [$D243],a
	ld a,$04
	ld [$D245],a
	ld hl,$C240
	ld c,$0E

Logged_0x49BC:
	ld a,[hl]
	cp $80
	jr z,Logged_0x49CB
	push bc
	push hl
	ld c,$20
	xor a
	call Logged_0x091D
	pop hl
	pop bc

Logged_0x49CB:
	ld de,$0020
	add hl,de
	dec c
	jr nz,Logged_0x49BC
	ld hl,$C440
	ld bc,$0100
	xor a
	call Logged_0x0914
	call Logged_0x3069
	push hl
	ld c,$20
	xor a
	call Logged_0x091D
	ld a,[$D23B]
	swap a
	add a,$10
	ld b,a
	ld a,[$D23C]
	swap a
	add a,$08
	ld c,a
	push bc
	ld d,b
	ld e,c
	call Logged_0x2FA4
	ld [hl],$0A
	pop bc
	pop hl
	ld a,$8D
	ld [hli],a
	ld a,$8F
	ld [hli],a
	inc hl
	ld a,b
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld [hl],c
	ld a,$0A
	add a,l
	ld l,a
	ld a,[$D23B]
	ld [hli],a
	ld a,[$D23C]
	ld [hli],a
	ld a,$16
	ld [hli],a
	xor a
	ld [hl],a
	ld [$D174],a
	ld [$C154],a
	ld b,$0C
	ld a,[$D141]
	rra
	jr nc,Logged_0x4A34
	ld a,[$D141]
	rla
	jr c,Logged_0x4A34
	ld b,$08

Logged_0x4A34:
	ld a,b
	ld [$FF00+$91],a
	ld hl,$D12B
	res 4,[hl]
	ret

Logged_0x4A3D:
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	push bc
	push bc
	ld hl,$A74C
	add hl,bc
	ld c,l
	ld a,h
	add a,$10
	ld b,a
	ld de,$CE5A
	ld a,[de]
	ld [hli],a
	ld [bc],a
	inc bc
	inc de
	ld a,[de]
	ld [hli],a
	ld [bc],a
	inc bc
	inc de
	ld a,[de]
	ld [hl],a
	ld [bc],a
	pop bc
	ld hl,$A746
	add hl,bc
	ld bc,$0091
	call Logged_0x330C
	pop bc
	ld hl,$B7D7
	add hl,bc
	ld [hl],d
	ld a,$00
	ld [$0000],a

Logged_0x4A7C:
	ld hl,$D12A
	set 7,[hl]
	ld hl,$D142
	res 5,[hl]
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$4B00
	add hl,bc
	ld de,$CC41
	ld a,[de]
	and [hl]
	jr nz,Logged_0x4A9A
	ld a,[de]
	or [hl]
	ld [de],a

Logged_0x4A9A:
	ld de,$CC40
	ld a,[de]
	and [hl]
	jr nz,Logged_0x4ABE
	ld a,[de]
	or [hl]
	ld [de],a
	ld hl,$D12A
	set 1,[hl]
	ld a,$01
	ld [$D174],a
	ld a,$01
	ld [$C154],a
	ld a,$01
	ld [$D243],a
	ld a,$07
	ld [$D244],a
	ret

Logged_0x4ABE:
	ld hl,$C922
	ld a,[hli]
	ld c,a
	ld a,[$CFDB]

Logged_0x4AC6:
	cp [hl]
	jr z,Logged_0x4ADA
	inc hl
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x4AC6
	ld a,[$CFDB]
	ld [hli],a
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$C922
	inc [hl]

Logged_0x4ADA:
	ld hl,$D12B
	res 4,[hl]
	ld a,$15
	ld [$FF00+$91],a
	xor a
	ld [$D22E],a
	ret

UnknownData_0x4AE8:
INCBIN "baserom.gb", $4AE8, $4AEB - $4AE8

LoggedData_0x4AEB:
INCBIN "baserom.gb", $4AEB, $4B08 - $4AEB

Logged_0x4B08:
	ld a,[$D174]
	cp $04
	ret nz
	ld hl,$C240
	ld c,$0E
	call Logged_0x4B1B
	ld hl,$C440
	ld c,$06

Logged_0x4B1B:
	ld de,$0020

Logged_0x4B1E:
	ld a,[hl]
	and a
	jr z,Logged_0x4B32
	push bc
	push hl
	ld a,[hl]
	push af
	ld a,$8C
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	xor a
	ld [hl],a
	pop af
	pop hl
	pop bc

Logged_0x4B32:
	add hl,de
	dec c
	jr nz,Logged_0x4B1E
	ld a,$07
	ld [$C154],a
	ld a,[$D141]
	rra
	ret c
	xor a
	ld [$D179],a
	ld [$C233],a
	ld [$C237],a
	ld a,$04
	ld [$C235],a
	ld hl,$C22C
	res 7,[hl]
	ld a,[$C223]
	ld d,a
	ld a,[$C227]
	ld e,a
	ld bc,$0010
	call Logged_0x2F6C
	ld d,$00
	ld b,$24
	jr z,Logged_0x4B76
	ld a,$04
	ld [$C233],a
	ld a,$01
	ld [$C23A],a
	ld d,$09
	ld b,$58

Logged_0x4B76:
	ld hl,$C221
	ld a,[$C230]
	add a,b
	ld b,a
	ld c,$00
	jp Logged_0x31B3

Logged_0x4B83:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$03
	ld [$C154],a
	ret

Logged_0x4B8E:
	ld hl,$CA44
	ld b,$01

Logged_0x4B93:
	ld c,$01

Logged_0x4B95:
	ld a,[hli]
	cp $68
	jr c,Logged_0x4BC7
	cp $80
	jr nc,Logged_0x4BC7
	ld a,[hld]
	ld [hl],a
	push af
	push bc
	push bc
	call Logged_0x3069
	pop bc
	ld a,b
	swap a
	add a,$10
	ld b,a
	ld a,c
	swap a
	add a,$08
	ld c,a
	ld de,$477B
	call Logged_0x309F
	ld a,$0A
	add a,l
	ld l,a
	pop bc
	ld a,b
	ld [hli],a
	ld a,c
	ld [hli],a
	pop af
	ld [hli],a
	set 0,[hl]
	ret

Logged_0x4BC7:
	inc hl
	inc hl
	inc hl
	inc c
	ld a,c
	cp $09
	jr c,Logged_0x4B95
	ld de,$0020
	add hl,de
	inc b
	ld a,b
	cp $08
	jr c,Logged_0x4B93
	ld hl,$CE75
	ld a,$A0
	ld [hli],a
	ld a,$01
	ld [hl],a
	ld a,$04
	ld [$C154],a
	ret

Logged_0x4BE9:
	ld hl,$CE75
	ld a,[hli]
	ld b,[hl]
	ld c,a
	dec bc
	ld a,b
	ld [hld],a
	ld [hl],c
	or c
	ret nz
	ld a,[$C223]
	cp $40
	jr c,Logged_0x4C10
	cp $51
	jr nc,Logged_0x4C10
	ld a,[$D14B]
	cp $48
	jr c,Logged_0x4C10
	cp $59
	jr nc,Logged_0x4C10
	ld a,$06
	ld [$D174],a

Logged_0x4C10:
	ld a,$05
	ld [$C154],a
	ld hl,$DC08
	set 2,[hl]
	ld hl,$C240
	ld de,$4C32
	ld bc,$F850
	call Logged_0x309F
	ld hl,$C260
	ld de,$4C40
	ld bc,$5050
	jp Logged_0x309F

LoggedData_0x4C32:
INCBIN "baserom.gb", $4C32, $4C4E - $4C32

Logged_0x4C4E:
	ld a,[$C243]
	cp $48
	jr z,Logged_0x4C7B
	ld c,$03
	ld hl,$4CAB

Logged_0x4C5A:
	cp [hl]
	jr z,Logged_0x4C63
	inc hl
	dec c
	jr nz,Logged_0x4C5A
	jr Logged_0x4C67

Logged_0x4C63:
	ld hl,$C262
	inc [hl]

Logged_0x4C67:
	ld hl,$C260
	cp $40
	jr nz,Logged_0x4C71
	ld [hl],$00
	ret

Logged_0x4C71:
	bit 7,a
	jr nz,Logged_0x4C76
	ret nc

Logged_0x4C76:
	ld a,[hl]
	xor $01
	ld [hl],a
	ret

Logged_0x4C7B:
	ld a,$06
	ld [$C154],a
	ld a,$01
	ld [$D243],a
	ld a,$11
	ld [$D244],a
	ld hl,$DC08
	set 3,[hl]
	ld a,[$FF00+$42]
	add a,$02
	ld [$FF00+$42],a
	ld hl,$C245
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$C24C
	set 7,[hl]
	ld hl,$C241
	ld bc,$AB02
	ld d,$07
	jp Logged_0x31B3

LoggedData_0x4CAB:
INCBIN "baserom.gb", $4CAB, $4CAE - $4CAB

Logged_0x4CAE:
	ld hl,$C24C
	bit 6,[hl]
	ret z
	res 6,[hl]
	ld de,$4048
	call Logged_0x2FA4
	ld de,$D24B
	ld a,[hl]
	ld [de],a
	inc de
	ld a,$1F
	ld [hli],a
	ld a,[hli]
	ld [de],a
	inc hl
	inc hl
	inc de
	ld a,[hl]
	ld [de],a
	inc de
	ld a,$1F
	ld [hli],a
	ld a,[hld]
	ld [de],a
	ld bc,$003C
	add hl,bc
	inc de
	ld a,[hl]
	ld [de],a
	inc de
	ld a,$1F
	ld [hli],a
	ld a,[hli]
	ld [de],a
	inc hl
	inc hl
	inc de
	ld a,[hl]
	ld [de],a
	inc de
	ld a,$1F
	ld [hli],a
	ld a,[hl]
	ld [de],a
	ld bc,$0608
	ld a,[$D24B]
	cp $10
	jr nz,Logged_0x4CFA
	ld a,[$D24C]
	call Logged_0x26C2

Logged_0x4CFA:
	ld bc,$060A
	ld a,[$D24D]
	cp $10
	jr nz,Logged_0x4D0A
	ld a,[$D24E]
	call Logged_0x26C2

Logged_0x4D0A:
	ld bc,$0808
	ld a,[$D24F]
	cp $10
	jr nz,Logged_0x4D1A
	ld a,[$D250]
	call Logged_0x26C2

Logged_0x4D1A:
	ld bc,$080A
	ld a,[$D251]
	cp $10
	jr nz,Logged_0x4D2A
	ld a,[$D252]
	call Logged_0x26C2

Logged_0x4D2A:
	ld a,$08
	ld [$C154],a
	xor a
	ld [$D174],a
	ld hl,$C234
	res 5,[hl]
	ld a,[$C233]
	cp $04
	ret nz
	set 5,[hl]
	ret

Logged_0x4D41:
	ret

Logged_0x4D42:
	ld a,$0A
	ld [$C154],a
	ld hl,$C241
	ld bc,$AB03
	ld d,$0C
	jp Logged_0x31B3

Logged_0x4D52:
	ld hl,$C24C
	bit 5,[hl]
	jr z,Logged_0x4D7E
	res 5,[hl]
	ld a,$01
	ld [$D243],a
	ld a,$0C
	ld [$D244],a
	ld hl,$DC07
	set 5,[hl]
	ld hl,$DC03
	set 7,[hl]
	ld a,[$C230]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C221
	jp Logged_0x31B3

Logged_0x4D7E:
	bit 6,[hl]
	ret z
	ld hl,$D12A
	res 0,[hl]
	ld a,[$C9E4]
	ld hl,$CE58
	cp [hl]
	jr c,Logged_0x4D94
	ld hl,$D12A
	set 1,[hl]

Logged_0x4D94:
	xor a
	ld [$C154],a
	ld [$D174],a
	ld a,$10
	ld [$FF00+$91],a
	ld hl,$D142
	res 7,[hl]
	ld hl,$D12B
	res 4,[hl]
	call Logged_0x3287
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$CE68
	add hl,bc
	ld a,[$CE67]
	ld [hl],a
	ld hl,$C922
	ld a,[hli]
	ld c,a
	ld a,[$CFDB]

Logged_0x4DC2:
	cp [hl]
	jr z,Logged_0x4DD6
	inc hl
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x4DC2
	ld a,[$CFDB]
	ld [hli],a
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$C922
	inc [hl]

Logged_0x4DD6:
	ld hl,$D142
	res 5,[hl]
	ld bc,$0108
	jp Logged_0x0AE5

Logged_0x4DE1:
	ld a,[$D174]
	cp $04
	ret nz
	ld a,$02
	ld [$C154],a
	ld a,$01
	ld [$CE75],a
	ld a,$34
	ld [$CEB6],a
	ret

UnknownData_0x4DF7:
INCBIN "baserom.gb", $4DF7, $4DF8 - $4DF7

Logged_0x4DF8:
	ld a,[$D129]
	rra
	ret c
	ld hl,$CEB6
	ld a,[hl]
	and a
	ret z
	dec [hl]
	ld a,[hl]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	push hl
	ld bc,$6CFD
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x4E1A
	ld bc,$700D

Logged_0x4E1A:
	add hl,bc
	ld de,$CE88
	ld c,$10
	call Logged_0x092B
	pop hl
	ld bc,$8000
	add hl,bc
	ld e,l
	ld d,h
	ld hl,$CE81
	ld a,$CE
	ld [hld],a
	ld a,$88
	ld [hld],a
	ld a,$10
	ld [hld],a
	ld a,$01
	ld [hld],a
	ld [hl],d
	dec hl
	ld [hl],e
	ld e,l
	ld d,h
	jp Logged_0x09A3

Logged_0x4E41:
	ld hl,$4E4F
	push hl
	ld a,[$C154]
	rst JumpList
	dw Logged_0x4E6D
	dw Logged_0x4EB1
	dw Logged_0x4F28
	call Logged_0x3AED
	call Logged_0x3AF4
	call Logged_0x140E
	call Logged_0x2B17
	ld a,[$FF00+$40]
	bit 6,a
	jr nz,Logged_0x4E67
	call Logged_0x1095
	jp Logged_0x2960

Logged_0x4E67:
	call Logged_0x0F09
	jp Logged_0x2960

Logged_0x4E6D:
	ld a,$01
	ld [$CE75],a
	ld a,$01
	ld [$C154],a
	ld a,[$D179]
	and a
	ret z
	ld a,[$D17A]
	cp $79
	ret z
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$8C
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld [$D179],a
	ld hl,$C235
	res 3,[hl]
	xor a
	ld [$C237],a
	ld a,$03
	ld [$C23C],a
	ld hl,$C221
	ld a,[$C23D]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF

Logged_0x4EB1:
	ld a,[$D129]
	rra
	ret c
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$05
	ld hl,$CA44
	ld b,$01

Logged_0x4EC2:
	ld c,$01

Logged_0x4EC4:
	ld a,[hli]
	cp $3B
	jr c,Logged_0x4F07
	cp $3F
	jr c,Logged_0x4ED9
	cp $78
	jr z,Logged_0x4ED9
	cp $7B
	jr c,Logged_0x4F07
	cp $80
	jr nc,Logged_0x4F07

Logged_0x4ED9:
	ld a,[hld]
	ld [hl],a
	push af
	push bc
	push bc
	call Logged_0x3069
	pop bc
	ld a,b
	swap a
	add a,$10
	ld b,a
	ld a,c
	swap a
	add a,$08
	ld c,a
	ld de,$4F25
	call Logged_0x309F
	ld a,$0A
	add a,l
	ld l,a
	pop bc
	ld a,b
	ld [hli],a
	ld a,c
	ld [hli],a
	pop af
	ld [hli],a
	set 0,[hl]
	ld hl,$DC06
	set 3,[hl]
	ret

Logged_0x4F07:
	inc hl
	inc hl
	inc hl
	inc c
	ld a,c
	cp $09
	jr c,Logged_0x4EC4
	ld de,$0020
	add hl,de
	inc b
	ld a,b
	cp $08
	jr c,Logged_0x4EC2
	ld a,$04
	ld [$CE75],a
	ld a,$02
	ld [$C154],a
	ret

LoggedData_0x4F25:
INCBIN "baserom.gb", $4F25, $4F28 - $4F25

Logged_0x4F28:
	ld hl,$CE75
	dec [hl]
	ret nz
	xor a
	ld [$C154],a
	ld a,[$C155]
	ld [$FF00+$91],a
	ret

Logged_0x4F37:
	call Logged_0x05CC
	call Logged_0x0AD2
	ld hl,$C0A6
	res 1,[hl]
	xor a
	ld [$C157],a
	ld [$C156],a
	ld [$CE74],a
	ld [$C154],a
	ld hl,$C158
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld [$D12E],a
	ld [$D12D],a
	ld [$D13B],a
	ld [$D142],a
	ld [$D143],a
	ld [$CE65],a
	ld [$CE67],a
	ld [$D174],a
	ld [$D179],a
	ld [$D136],a
	ld [$D16A],a
	ld [$D16B],a
	ld hl,$D18A
	xor a
	ld c,$A0
	call Logged_0x091D
	ld hl,$CEB7
	xor a
	ld c,$0A
	call Logged_0x091D
	ld hl,$D26D
	ld bc,$04C6
	xor a
	call Logged_0x091D
	ld hl,$D12B
	res 1,[hl]
	ld a,[$D12A]
	and $86
	ld [$D12A],a
	ret

Logged_0x4FA4:
	call Logged_0x05CC
	call Logged_0x0AD2
	ld hl,$9800
	ld a,$01
	ld bc,$0400
	call Logged_0x0914
	ld hl,$CEB7
	xor a
	ld c,$0A
	call Logged_0x091D
	ld [$C157],a
	ld [$C156],a
	ld [$CE74],a
	ld hl,$C158
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld [$D12E],a
	ld [$D12D],a
	ld [$D13B],a
	ld [$D142],a
	ld [$CE65],a
	ld [$D179],a
	ld [$FF00+$42],a
	ld [$FF00+$43],a
	ld hl,$C0DE
	ld [hli],a
	ld [hl],a
	ld [$CFDB],a
	ld a,$01
	ld [$FF00+$91],a
	ld a,$06
	ld [$CE75],a
	ld a,$09
	ld [$C9E4],a
	ld a,[$D12A]
	and $86
	ld [$D12A],a
	ld a,$E3
	ld [$C0A7],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld a,$1E
	ld [$FF00+$47],a
	ld a,$1C
	ld [$FF00+$48],a
	ld a,$83
	ld [$FF00+$49],a
	ld a,$38
	call Logged_0x0A96
	ld a,$77
	call Logged_0x1629
	ld a,$77
	jp Logged_0x3262

Logged_0x502A:
	ld hl,$9800
	ld de,$CA00
	call Logged_0x28FE
	ld hl,$9C00
	ld de,$CA02
	call Logged_0x28FE
	ld hl,$C7E4
	ld c,$20

Logged_0x5041:
	ld a,$02
	ld [hli],a
	ld [hli],a
	ld d,h
	ld e,l
	inc de
	inc de
	ld a,e
	ld [hli],a
	ld a,d
	ld [hli],a
	ld de,$0006
	add hl,de
	dec c
	jr nz,Logged_0x5041
	ld bc,$6058
	ld hl,$C220
	ld de,$506B
	call Logged_0x309F
	ld a,$80
	ld [$D141],a
	ld hl,$C705
	res 7,[hl]
	ret

LoggedData_0x506B:
INCBIN "baserom.gb", $506B, $5089 - $506B

Logged_0x5089:
	ld a,[$CE7B]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5112
	add hl,bc
	ld a,[$C0DE]
	add a,[hl]
	ld [$C0DE],a
	inc hl
	ld a,[$C0DF]
	add a,[hl]
	ld [$C0DF],a
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$04
	ld [hli],a
	ld a,[$FF00+$47]
	ld d,a
	ld e,$C0
	ld b,$00
	ld c,$04

Logged_0x50B4:
	ld a,d
	and e
	srl a
	and e
	or b
	ld b,a
	srl e
	srl e
	dec c
	jr nz,Logged_0x50B4
	ld a,b
	ld [$FF00+$47],a
	ld hl,$CE76
	dec [hl]
	ret nz
	xor a
	ld [hld],a
	ld [hl],a
	ld a,$02
	ld [$CE7A],a
	ld de,$C223
	ld a,[$D141]
	rla
	jr c,Logged_0x50DE
	ld de,$C423

Logged_0x50DE:
	ld a,[$CE7B]
	add a,a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$511A
	add hl,bc
	ld a,[de]
	add a,[hl]
	ld [de],a
	inc de
	xor a
	ld [de],a
	inc de
	inc hl
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[de]
	add a,[hl]
	ld [de],a
	inc de
	xor a
	ld [de],a
	inc de
	inc hl
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld a,[hl]
	ld [$CE78],a
	xor a
	ld [$C0DE],a
	ld [$C0DF],a
	ret

LoggedData_0x5112:
INCBIN "baserom.gb", $5112, $5121 - $5112

UnknownData_0x5121:
INCBIN "baserom.gb", $5121, $5122 - $5121

LoggedData_0x5122:
INCBIN "baserom.gb", $5122, $5129 - $5122

UnknownData_0x5129:
INCBIN "baserom.gb", $5129, $512A - $5129

LoggedData_0x512A:
INCBIN "baserom.gb", $512A, $5131 - $512A

UnknownData_0x5131:
INCBIN "baserom.gb", $5131, $5132 - $5131

LoggedData_0x5132:
INCBIN "baserom.gb", $5132, $5139 - $5132

UnknownData_0x5139:
INCBIN "baserom.gb", $5139, $513A - $5139

Logged_0x513A:
	call Logged_0x05CC
	ld hl,$D12D
	bit 0,[hl]
	jr z,Logged_0x5156
	res 0,[hl]
	ld a,[$DC03]
	set 4,a
	ld [$DC03],a
	call Logged_0x3218
	ld a,$05
	ld [$D174],a

Logged_0x5156:
	ld hl,$9800
	ld a,$55
	ld bc,$0400
	call Logged_0x0914
	ld hl,$9800
	ld de,$CA00
	call Logged_0x28FE
	ld a,[$C9E4]
	cp $09
	jr nz,Logged_0x5175
	ld a,$38
	jr Logged_0x518D

Logged_0x5175:
	cp $08
	jr z,Unknown_0x5184
	cp $07
	jr z,Logged_0x5188
	ld a,[$CFDD]
	add a,$18
	jr Logged_0x518D

Unknown_0x5184:
	ld a,$38
	jr Logged_0x518D

Logged_0x5188:
	ld a,[$CEB5]
	add a,$50

Logged_0x518D:
	call Logged_0x0A96
	ld a,[$FF00+$90]
	cp $0E
	jr nz,Logged_0x51A0
	ld a,[$D141]
	and $01
	add a,a
	add a,$77
	jr Logged_0x51AD

Logged_0x51A0:
	ld a,[$D141]
	and $01
	ld b,a
	ld a,[$CFDD]
	add a,a
	add a,$48
	add a,b

Logged_0x51AD:
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	ld a,$1E
	ld [$FF00+$47],a
	xor a
	ld [$C158],a
	ld hl,$CFD7
	ld a,[hli]
	ld [$FF00+$48],a
	ld a,[hl]
	ld [$FF00+$49],a
	ld a,[$CFD9]
	ld [$C0A7],a
	ld c,$01
	ld a,[$D12A]
	rra
	jr nc,Logged_0x51E6
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x5200
	ld a,[$CEB5]
	cp $07
	jr z,Logged_0x5200
	ld c,$00
	jr Logged_0x5200

Logged_0x51E6:
	ld c,$02
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x5200
	ld c,$01
	cp $09
	jr z,Logged_0x5200
	ld a,[$CFDD]
	ld c,a
	ld b,$00
	ld hl,$5215
	add hl,bc
	ld c,[hl]

Logged_0x5200:
	ld a,c
	ld [$D243],a
	ld a,$04
	ld [$D245],a
	ld hl,$D12B
	res 0,[hl]
	xor a
	ld [$C0EF],a
	jp Logged_0x060E

LoggedData_0x5215:
INCBIN "baserom.gb", $5215, $5225 - $5215

Logged_0x5225:
	ld hl,$CE59
	inc [hl]
	ld a,[hl]
	cp $3C
	ret c
	xor a
	ld [hli],a
	ld a,[hl]
	inc a
	ld [hl],a
	cp $3C
	ret c
	xor a
	ld [hli],a
	ld a,[hl]
	inc a
	ld [hl],a
	cp $3C
	ret c
	xor a
	ld [hli],a
	ld a,[hl]
	inc a
	ld [hl],a
	cp $64
	ret c
	ld a,$63
	ld [hld],a
	ld a,$3B
	ld [hld],a
	ld [hl],a
	ret

UnknownData_0x524D:
INCBIN "baserom.gb", $524D, $527F - $524D

Logged_0x527F:
	ld a,[$D120]
	xor $01
	ld c,a
	ld b,$00
	ld hl,$CFDE
	add hl,bc
	ld a,[hl]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$52DF
	add hl,bc
	ld de,$C14A
	xor a
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$C5C0
	ld de,$52D1
	ld bc,$1088
	call Logged_0x309F
	ld hl,$C5E0
	ld de,$52D1
	ld bc,$1090
	call Logged_0x309F
	ld hl,$C14B
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,l
	ld d,$0A
	ld b,$00

Logged_0x52C2:
	sub d
	jr c,Logged_0x52C8
	inc b
	jr Logged_0x52C2

Logged_0x52C8:
	add a,d
	ld [$C5E2],a
	ld a,b
	ld [$C5C2],a
	ret

LoggedData_0x52D1:
INCBIN "baserom.gb", $52D1, $52DF - $52D1

UnknownData_0x52DF:
INCBIN "baserom.gb", $52DF, $52E5 - $52DF

LoggedData_0x52E5:
INCBIN "baserom.gb", $52E5, $52E7 - $52E5

UnknownData_0x52E7:
INCBIN "baserom.gb", $52E7, $52ED - $52E7

Logged_0x52ED:
	ld hl,$C14A
	ld d,[hl]
	inc [hl]
	inc hl
	ld c,[hl]
	inc hl
	ld a,[hld]
	ld b,a
	or c
	jr z,Logged_0x534E
	ld a,d
	cp $3C
	jr nc,Logged_0x5303
	ld h,b
	ld l,c
	jr Logged_0x533A

Logged_0x5303:
	dec hl
	xor a
	ld [hli],a
	dec bc
	ld a,c
	or b
	jr z,Logged_0x534E
	ld a,c
	ld [hli],a
	ld [hl],b
	ld h,b
	ld l,c
	ld a,[$D129]
	bit 1,a
	jr nz,Logged_0x5332
	ld a,h
	and a
	jr nz,Logged_0x533A
	ld a,l
	cp $0B
	jr nc,Logged_0x533A
	ld a,[$D129]
	set 1,a
	ld [$D129],a
	ld a,$01
	ld [$D243],a
	ld a,$0D
	ld [$D244],a

Logged_0x5332:
	ld a,[$DC05]
	set 5,a
	ld [$DC05],a

Logged_0x533A:
	ld a,l
	ld d,$0A
	ld b,$00

Logged_0x533F:
	sub d
	jr c,Logged_0x5345
	inc b
	jr Logged_0x533F

Logged_0x5345:
	add a,d
	ld [$C5E2],a
	ld a,b
	ld [$C5C2],a
	ret

Logged_0x534E:
	ld hl,$C14B
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$21
	ld [$FF00+$91],a
	xor a
	ld [$C5C2],a
	ld [$C5E2],a
	ret

Logged_0x5360:
	ld hl,$C205
	ld de,$0020
	ld c,$28

Logged_0x5368:
	push hl
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	pop hl
	add hl,de
	dec c
	jr nz,Logged_0x5368
	ld a,$B4
	ld [$CE75],a
	ld hl,$C154
	inc [hl]
	ret

Logged_0x537F:
	ld hl,$CE77
	dec [hl]
	ret nz
	ld hl,$C225
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$C22C
	res 7,[hl]
	xor a
	ld [$C222],a
	ld hl,$CE74
	inc [hl]
	ld hl,$C240
	ld de,$0020

Logged_0x539D:
	ld a,[hl]
	cp $8E
	jr z,Logged_0x53A5
	add hl,de
	jr Logged_0x539D

Logged_0x53A5:
	ld a,$10
	add a,l
	ld l,a
	inc [hl]
	inc hl
	ld a,$01
	ld [hli],a
	ld a,$03
	ld [hl],a
	ret

Logged_0x53B2:
	ld hl,$53D7
	ld de,$C420
	ld c,$20
	call Logged_0x092B
	ld hl,$D141
	set 0,[hl]
	ld hl,$C705
	res 7,[hl]
	ld a,[$D121]
	rra
	ret c
	xor a
	ld hl,$D122
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ret

LoggedData_0x53D7:
INCBIN "baserom.gb", $53D7, $53F7 - $53D7

UnknownData_0x53F7:
INCBIN "baserom.gb", $53F7, $5464 - $53F7

Logged_0x5464:
	ld a,[$C203]
	ld b,a
	sub $0C
	cp d
	ret nc
	ld a,$0C
	add a,b
	cp d
	jr c,Logged_0x5482
	ld a,[$C207]
	ld b,a
	sub $0C
	cp e
	ret nc
	ld a,$0C
	add a,b
	cp e
	jr c,Logged_0x5482
	scf
	ret

Logged_0x5482:
	and a
	ret

UnknownData_0x5484:
INCBIN "baserom.gb", $5484, $54E6 - $5484
	push de
	ld l,e
	ld h,d
	ld de,$C200
	ld c,$20
	call Logged_0x092B
	ld hl,$5504
	push hl
	ld a,[$CEB7]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5512
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	pop de
	ld hl,$C200
	ld c,$20
	call Logged_0x092B
	xor a
	ld [$C200],a
	ret

LoggedData_0x5512:
INCBIN "baserom.gb", $5512, $551E - $5512
	ld a,$02
	ld [$CEBA],a
	ld hl,$C211
	ld a,$80
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld hl,$C214
	set 5,[hl]
	ld a,$04
	ld [$D174],a
	ld hl,$D12B
	set 1,[hl]
	ld a,$C1
	ld [$C201],a
	ld a,$01
	ld [$C210],a
	ld a,$01
	ld [$CEB7],a
	ret
	ld hl,$C211
	ld a,[hli]
	ld d,[hl]
	ld e,a
	dec de
	ld a,d
	ld [hld],a
	ld [hl],e
	or e
	ret nz
	ld [hl],$08
	ld a,$02
	ld [$CEB7],a
	ld hl,$DC08
	set 3,[hl]
	call Logged_0x3069
	push hl
	ld de,$5591
	ld bc,$1A58
	call Logged_0x309F
	pop hl
	ld a,$0D
	add a,l
	ld l,a
	ld c,$00
	call Logged_0x31C3
	call Logged_0x3069
	push hl
	ld de,$5591
	ld bc,$2458
	call Logged_0x309F
	pop hl
	ld a,$0D
	add a,l
	ld l,a
	ld c,$00
	jp Logged_0x31C3

LoggedData_0x5591:
INCBIN "baserom.gb", $5591, $559F - $5591
	ld hl,$C211
	dec [hl]
	ret nz
	ld [hl],$30
	ld a,$01
	ld [$D243],a
	ld a,$04
	ld [$D244],a
	ld a,$03
	ld [$CEB7],a
	ld hl,$C203
	ld a,$24
	ld [hli],a
	xor a
	ld [hli],a
	ld a,$00
	ld [hli],a
	ld a,$40
	ld [hli],a
	ld a,$58
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$C20C
	set 7,[hl]
	ld hl,$C20D
	ld c,$01
	call Logged_0x31C3
	ld de,$1058
	call Logged_0x2FA4
	ld [hl],$48
	ld bc,$0040
	add hl,bc
	ld [hl],$4C
	ld bc,$000A
	ld a,$48
	call Logged_0x26C2
	ld bc,$020A
	ld a,$4C
	jp Logged_0x26C2
	ld hl,$C211
	dec [hl]
	ret nz
	ld [hl],$A0
	ld hl,$C203
	ld a,$30
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld hl,$C20C
	res 7,[hl]
	ld a,$04
	ld [$CEB7],a
	ret
	ld hl,$C211
	dec [hl]
	ret nz
	ld a,$05
	ld [$CEB7],a
	ld a,$01
	ld [$CEBB],a
	ld a,$02
	ld [$CEB9],a
	ld a,$03
	ld [$C210],a
	ld a,$20
	ld [$CEC0],a
	xor a
	ld [$D13C],a
	xor a
	ld [$D174],a
	ld hl,$C214
	set 2,[hl]
	ld hl,$D12B
	res 1,[hl]
	ld a,$01
	ld [$D243],a
	ld a,$0A
	ld [$D244],a
	ret
	ld hl,$C21F
	bit 7,[hl]
	jr z,Logged_0x5670
	res 7,[hl]
	ld hl,$C213
	ld a,[hl]
	cp $02
	jr nc,Logged_0x5670
	ld a,$09
	ld [hl],a
	xor a
	ld [$C21B],a
	ld a,[$C21E]
	and $0F
	ld [$D22A],a

Logged_0x5670:
	call Logged_0x5679
	call Logged_0x5852
	jp Logged_0x5F2C

Logged_0x5679:
	ld a,[$C214]
	rra
	ret c
	ld a,[$D13C]
	rst JumpList
	dw Logged_0x5686
	dw Logged_0x5783

Logged_0x5686:
	call Logged_0x6063
	ld a,[$CEBF]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$66D6
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld bc,$0009
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld a,[$FF00+$93]
	push de
	call Logged_0x669E
	pop bc
	ld e,l
	ld d,h
	and a
	jr z,Logged_0x56C4
	cp $02
	jp nz,Logged_0x576C
	ld hl,$C210
	ld a,[hl]
	add a,a
	add a,a
	add a,a
	add a,[hl]
	ld l,a
	ld h,$00
	add hl,de
	ld e,l
	ld d,h
	jp Logged_0x5777

Logged_0x56C4:
	push de
	ld a,[de]
	ld e,c
	ld d,b
	call Logged_0x301A
	ld bc,$0201
	call Logged_0x2F6C
	ld a,d
	ld [$D250],a
	pop de
	jp nz,Logged_0x576C
	ld a,[de]
	ld hl,$C210
	cp [hl]
	jr z,Logged_0x56E8
	ld a,$03
	ld [$C216],a
	jp Logged_0x5777

Logged_0x56E8:
	ld hl,$C216
	ld a,[hl]
	and a
	jr z,Logged_0x56F1
	dec [hl]
	ret

Logged_0x56F1:
	ld a,[de]
	ld [$C210],a
	inc de
	xor a
	ld [$D13D],a
	ld hl,$C20C
	set 7,[hl]
	ld a,$01
	ld [$C213],a
	ld a,$01
	ld [$D13C],a
	ld a,[$CEBF]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6794
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C210]
	swap a
	ld c,a
	ld a,[de]
	add a,a
	add a,a
	add a,c
	ld c,a
	ld b,$00
	add hl,bc
	push de
	ld bc,$C205
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	inc bc
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hl]
	ld [bc],a
	pop de

Logged_0x5738:
	ld hl,$C215
	ld a,[hl]
	ld [$D24B],a
	ld a,[de]
	ld [hl],a
	inc de
	ld a,[de]
	ld [$C21C],a
	inc de
	ld a,[$C214]
	bit 2,a
	jr z,Logged_0x5756
	ld a,[$CEBB]
	add a,$C0
	ld b,a
	jr Logged_0x5758

Logged_0x5756:
	ld a,[de]
	ld b,a

Logged_0x5758:
	inc de
	ld a,[de]
	ld d,a
	ld hl,$C201
	ld a,[$C215]
	ld c,a
	ld a,[$D24B]
	cp c
	jp z,Logged_0x31AF
	jp Logged_0x31B3

Logged_0x576C:
	ld a,[$C210]
	call Logged_0x604C
	ld hl,$C214
	set 5,[hl]

Logged_0x5777:
	ld a,[de]
	ld [$C210],a
	ld hl,$0005
	add hl,de
	ld e,l
	ld d,h
	jr Logged_0x5738

Logged_0x5783:
	ld a,[$FF00+$94]
	and $03
	rlca
	rlca
	rlca
	ld hl,$C214
	or [hl]
	ld [hl],a
	ld hl,$C21C
	dec [hl]
	jp nz,Logged_0x57B8
	ld hl,$C204
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$C20C
	res 7,[hl]
	xor a
	ld [$C20D],a
	xor a
	ld [$D13C],a
	xor a
	ld [$C213],a
	ld hl,$C214
	set 5,[hl]
	ret

Logged_0x57B8:
	ld a,[hl]
	cp $01
	ret nz
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld hl,$57D4
	push hl
	ld a,[$C210]
	rst JumpList
	dw Logged_0x5830
	dw Logged_0x5835
	dw Logged_0x583C
	dw Logged_0x5845
	ld bc,$0201
	call Logged_0x2F6C
	jr z,Logged_0x57FE
	ld a,$09
	ld [$C213],a
	xor a
	ld [$C21B],a
	ld a,[$C210]
	ld c,a
	ld b,$00
	ld hl,$584E
	add hl,bc
	ld a,[hl]
	ld [$D22A],a
	ld hl,$C205
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret

Logged_0x57FE:
	ld a,[$CEBF]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6796
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C210]
	and $0F
	swap a
	ld c,a
	ld a,[$C215]
	add a,a
	add a,a
	add a,c
	ld c,a
	ld b,$00
	add hl,bc
	ld de,$C205
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld de,$C209
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x5830:
	ld a,d
	and $F0
	ld d,a
	ret

Logged_0x5835:
	ld a,d
	and $F0
	add a,$10
	ld d,a
	ret

Logged_0x583C:
	ld a,e
	add a,$08
	and $F0
	sub $08
	ld e,a
	ret

Logged_0x5845:
	ld a,e
	add a,$08
	and $F0
	add a,$08
	ld e,a
	ret

UnknownData_0x584E:
INCBIN "baserom.gb", $584E, $5850 - $584E

LoggedData_0x5850:
INCBIN "baserom.gb", $5850, $5851 - $5850

UnknownData_0x5851:
INCBIN "baserom.gb", $5851, $5852 - $5851

Logged_0x5852:
	ld a,[$C213]
	rst JumpList
	dw Logged_0x586E
	dw Logged_0x5914
	dw Logged_0x5915
	dw Logged_0x5934
	dw Logged_0x5A16
	dw Unknown_0x5A9D
	dw Unknown_0x5AEA
	dw Logged_0x5B6B
	dw Logged_0x5BE7
	dw Logged_0x5C56
	dw Logged_0x5DAC
	dw Logged_0x5EB1

Logged_0x586E:
	ld a,[$FF00+$94]
	rra
	jp c,Logged_0x5879
	rra
	jp c,Unknown_0x58F6
	ret

Logged_0x5879:
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld a,[$C210]
	call Logged_0x301A
	ld bc,$020E
	call Logged_0x2F6C
	ret z
	bit 2,a
	jr nz,Logged_0x58B5
	bit 3,a
	jr nz,Unknown_0x58D4
	ld a,$04
	ld [$C213],a
	ld hl,$C20C
	set 7,[hl]
	ld hl,$C214
	set 0,[hl]
	ld a,[$C210]
	add a,$C0
	ld b,a
	ld c,$06
	ld d,$08
	ld hl,$C201
	jp Logged_0x31B3

Logged_0x58B5:
	ld a,$08
	ld [$C213],a
	ld hl,$C20C
	set 7,[hl]
	ld hl,$C214
	set 0,[hl]
	ld a,[$C210]
	add a,$C0
	ld b,a
	ld c,$04
	ld d,$08
	ld hl,$C201
	jp Logged_0x31B3

Unknown_0x58D4:
	ld a,$05
	ld [$C213],a
	xor a
	ld [$C21B],a
	ld hl,$C20C
	set 7,[hl]
	ld hl,$C214
	set 0,[hl]
	ld a,[$C210]
	add a,$C4
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31AF

Unknown_0x58F6:
	ld a,$06
	ld [$C213],a
	ld hl,$C20C
	set 7,[hl]
	ld hl,$C214
	set 0,[hl]
	ld a,[$C210]
	add a,$C8
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31AF

Logged_0x5914:
	ret

Logged_0x5915:
	ld a,$07
	ld [$C213],a
	ld hl,$C20C
	set 7,[hl]
	ld hl,$C214
	set 0,[hl]
	ld a,[$CEBB]
	add a,$C8
	ld b,a
	ld c,$01
	ld d,$00
	ld hl,$C201
	jp Logged_0x31AF

Logged_0x5934:
	ld a,[$C21B]
	rst JumpList
	dw Logged_0x593C
	dw Logged_0x595B

Logged_0x593C:
	ld a,$01
	ld [$C21B],a
	ld hl,$C20C
	set 7,[hl]
	ld hl,$C214
	set 0,[hl]
	ld a,[$C210]
	add a,$C0
	ld b,a
	ld c,$04
	ld d,$08
	ld hl,$C201
	jp Logged_0x31B3

Logged_0x595B:
	ld hl,$C20C
	bit 6,[hl]
	jr z,Logged_0x597C
	res 7,[hl]
	ld hl,$C214
	res 0,[hl]
	xor a
	ld [$C213],a
	ld a,[$CEBB]
	add a,$C0
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31B3

Logged_0x597C:
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld hl,$C203
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,[$C210]
	call Logged_0x301A
	push de
	call Logged_0x2FA4
	pop de
	ld a,[hl]
	cp $70
	ret c
	cp $78
	ret nc
	ld b,$00
	ld a,d
	cp $70
	jr z,Logged_0x59AF
	inc b
	cp $30
	jr z,Logged_0x59AF
	inc b
	ld a,e
	cp $88
	jr z,Logged_0x59AF
	inc b

Logged_0x59AF:
	ld a,b
	ld [$D24B],a
	push de
	call Logged_0x3007
	push de
	srl d
	srl e
	call Logged_0x2FD4
	ld a,[hli]
	ld [$D24C],a
	ld a,[hld]
	ld [hl],a
	pop bc
	call Logged_0x26C2
	pop de
	push de
	call Logged_0x3069
	push hl
	ld c,$20
	xor a
	call Logged_0x091D
	pop hl
	push hl
	ld a,$15
	add a,l
	ld l,a
	ld [hl],b
	pop hl
	ld a,$80
	ld [hli],a
	inc hl
	inc hl
	pop de
	ld a,d
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,e
	ld [hl],a
	ld a,$09
	add a,l
	ld l,a
	ld a,$0B
	ld [hli],a
	inc hl
	inc hl
	ld a,[$D24B]
	ld [hli],a
	ld a,[$D24C]
	ld [hl],a
	ld a,$04
	add a,l
	ld l,a
	set 1,[hl]
	ld a,[$DC04]
	set 6,a
	ld [$DC04],a
	ld a,$E9
	add a,l
	ld l,a
	ld b,$80
	ld c,$00
	ld d,$00
	jp Logged_0x31B3

Logged_0x5A16:
	ld hl,$C20C
	ld a,[hl]
	rla
	rla
	jr nc,Logged_0x5A38
	res 7,[hl]
	ld hl,$C214
	res 0,[hl]
	xor a
	ld [$C213],a
	ld a,[$C210]
	add a,$C0
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31B3

Logged_0x5A38:
	rla
	ret nc
	res 5,[hl]
	call Logged_0x5FD9
	jr nc,Logged_0x5A46
	ld a,[$D141]
	rra
	ret nc

Logged_0x5A46:
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld a,[$C210]
	call Logged_0x301A
	push de
	ld bc,$0202
	call Logged_0x2F6C
	pop de
	ret z
	ld hl,$DC03
	set 0,[hl]
	push de
	push de
	call Logged_0x3069
	pop bc
	ld de,$5591
	call Logged_0x309F
	ld a,$FA
	add a,l
	ld e,a
	ld d,h
	call Logged_0x31D7
	pop de
	push de
	call Logged_0x2FA4
	ld a,[hli]
	ld [hld],a
	ld a,$10
	ld [hli],a
	inc hl
	ld [hl],$43
	pop de
	call Logged_0x2FF4
	push de
	ld b,d
	ld c,e
	ld a,$10
	call Logged_0x26C2
	call Logged_0x3047
	pop de
	ld a,$12
	ld [hli],a
	ld [hl],d
	inc hl
	ld [hl],e
	inc hl
	xor a
	ld [hl],a
	ret

Unknown_0x5A9D:
	ld a,[$C21B]
	rst JumpList
	dw Unknown_0x5AA5
	dw Unknown_0x5AC8

Unknown_0x5AA5:
	ld a,[$C20C]
	bit 6,a
	ret z
	call Logged_0x5FD9
	ld a,$01
	ld [$C21B],a
	ld a,$18
	ld [$C211],a
	ld a,[$C210]
	add a,$C4
	ld b,a
	ld c,$01
	ld d,$03
	ld hl,$C201
	jp Logged_0x31B3

Unknown_0x5AC8:
	ld hl,$C211
	dec [hl]
	ret nz
	ld hl,$C20C
	res 7,[hl]
	ld hl,$C214
	res 0,[hl]
	xor a
	ld [$C213],a
	ld a,[$C210]
	add a,$C0
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31B3

Unknown_0x5AEA:
	ld hl,$C20C
	bit 6,[hl]
	jr z,Unknown_0x5B10
	res 6,[hl]
	xor a
	ld [$C213],a
	ld hl,$C20C
	res 7,[hl]
	ld hl,$C214
	res 0,[hl]
	ld a,[$C210]
	add a,$C0
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31AF

Unknown_0x5B10:
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld a,[$C210]
	call Logged_0x301A
	push de
	ld bc,$0210
	call Logged_0x2F6C
	pop bc
	jr z,Unknown_0x5B32
	ld hl,$6A70
	jr Unknown_0x5B3A

Unknown_0x5B32:
	ld hl,$DC04
	set 4,[hl]
	ld hl,$6A68

Unknown_0x5B3A:
	ld a,[$C210]
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[$C203]
	add a,[hl]
	ld d,a
	inc hl
	ld a,[$C207]
	add a,[hl]
	ld e,a
	push de
	call Logged_0x3069
	pop bc
	ld de,$6A5A
	call Logged_0x309F
	ld a,$0A
	add a,l
	ld l,a
	ld a,[$C210]
	ld [hl],a
	add a,$CE
	ld b,a
	ld a,$F0
	add a,l
	ld e,a
	ld d,h
	jp Logged_0x31D7

Logged_0x5B6B:
	ld hl,$C20C
	bit 6,[hl]
	jr z,Logged_0x5B91
	res 6,[hl]
	xor a
	ld [$C213],a
	ld hl,$C20C
	res 7,[hl]
	ld hl,$C214
	res 0,[hl]
	ld a,[$CEBB]
	add a,$C0
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31AF

Logged_0x5B91:
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld a,[$CEBB]
	call Logged_0x301A
	push de
	ld bc,$0210
	call Logged_0x2F6C
	pop bc
	jr z,Logged_0x5BB3
	ld hl,$6A70
	jr Logged_0x5BBB

Logged_0x5BB3:
	ld hl,$DC04
	set 4,[hl]
	ld hl,$6A68

Logged_0x5BBB:
	ld a,[$CEBB]
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[$C203]
	add a,[hl]
	ld d,a
	inc hl
	ld a,[$C207]
	add a,[hl]
	ld e,a
	push de
	call Logged_0x3069
	pop bc
	ld de,$6A5A
	call Logged_0x309F
	ld a,[$CEBB]
	add a,$CE
	ld b,a
	ld a,$FA
	add a,l
	ld e,a
	ld d,h
	jp Logged_0x31D7

Logged_0x5BE7:
	ld hl,$C20C
	ld a,[hl]
	rla
	rla
	jr nc,Logged_0x5C09
	res 7,[hl]
	ld hl,$C214
	res 0,[hl]
	xor a
	ld [$C213],a
	ld a,[$C210]
	add a,$C0
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31B3

Logged_0x5C09:
	rla
	ret nc
	res 5,[hl]
	call Logged_0x5FD9
	jr nc,Logged_0x5C17
	ld a,[$D141]
	rra
	ret nc

Logged_0x5C17:
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld a,[$C210]
	call Logged_0x301A
	push de
	ld bc,$0204
	call Logged_0x2F6C
	pop de
	ret z
	ld hl,$DC03
	set 0,[hl]
	push de
	call Logged_0x2FA4
	inc hl
	ld a,[hld]
	ld [hl],a
	pop de
	push af
	call Logged_0x2FF4
	pop af
	add a,$00
	ld c,e
	ld b,d
	push de
	call Logged_0x26C2
	call Logged_0x3047
	pop de
	ld a,$13
	ld [hli],a
	ld [hl],d
	inc hl
	ld [hl],e
	inc hl
	xor a
	ld [hl],a
	ret

Logged_0x5C56:
	ld a,[$C21B]
	rst JumpList
	dw Logged_0x5C60
	dw Logged_0x5D31
	dw Unknown_0x5D80

Logged_0x5C60:
	ld hl,$DC05
	set 0,[hl]
	ld hl,$D13B
	set 3,[hl]
	ld a,[$C210]
	ld d,a
	ld c,a
	ld b,$00
	ld hl,$6A28
	add hl,bc
	ld a,[hl]
	ld hl,$D22A
	and [hl]
	jr nz,Logged_0x5C80
	ld a,d
	xor $01
	ld d,a

Logged_0x5C80:
	ld a,d
	push af
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6A2C
	add hl,bc
	ld de,$C205
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$C214
	set 0,[hl]
	ld hl,$C21B
	inc [hl]
	pop af
	ld [$D24B],a
	rst JumpList
	dw Logged_0x5CB1
	dw Logged_0x5CBC
	dw Logged_0x5CC7
	dw Logged_0x5CD4

Logged_0x5CB1:
	ld a,[$C203]
	and $0F
	jr nz,Logged_0x5CDF
	ld a,$10
	jr Logged_0x5CDF

Logged_0x5CBC:
	ld a,[$C203]
	and $0F
	ld b,a
	ld a,$10
	sub b
	jr Logged_0x5CDF

Logged_0x5CC7:
	ld a,[$C207]
	sub $08
	and $0F
	jr nz,Logged_0x5CDF
	ld a,$10
	jr Logged_0x5CDF

Logged_0x5CD4:
	ld a,[$C207]
	sub $08
	and $0F
	ld b,a
	ld a,$10
	sub b

Logged_0x5CDF:
	ld [$C211],a
	cp $10
	ret c
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld a,[$D24B]
	call Logged_0x301A
	ld a,[$D24B]
	rst JumpList
	dw Unknown_0x5CFF
	dw Unknown_0x5D06
	dw Unknown_0x5D0D
	dw Logged_0x5D14

Unknown_0x5CFF:
	ld a,d
	cp $2F
	jr c,Unknown_0x5D20
	jr Logged_0x5D19

Unknown_0x5D06:
	ld a,$70
	cp d
	jr c,Unknown_0x5D20
	jr Logged_0x5D19

Unknown_0x5D0D:
	ld a,$A8
	cp e
	jr c,Unknown_0x5D20
	jr Logged_0x5D19

Logged_0x5D14:
	ld a,$98
	cp e
	jr c,Unknown_0x5D20

Logged_0x5D19:
	ld bc,$0201
	call Logged_0x2F6C
	ret z

Unknown_0x5D20:
	ld a,$04
	ld [$C211],a
	ld a,$02
	ld [$C21B],a
	ld a,[$D24B]
	ld [$D22C],a
	ret

Logged_0x5D31:
	ld hl,$C211
	dec [hl]
	ret nz
	ld hl,$D13B
	res 3,[hl]
	ld hl,$C204
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hli],a
	ld [hli],a
	ld [hl],a
	xor a
	ld [$C213],a
	ld [$D13C],a
	ld hl,$C214
	res 0,[hl]
	set 5,[hl]
	ld hl,$C20C
	res 7,[hl]
	ld a,[$CEBC]
	bit 2,a
	ret nz
	ld hl,$CEBC
	ld a,[hl]
	xor $01
	ld [hl],a
	ld hl,$C210
	ld a,[hl]
	xor $01
	ld [hl],a
	ld hl,$CEB9
	ld a,[hl]
	cp $05
	jr z,Unknown_0x5D78
	ld [hl],$07
	ret

Unknown_0x5D78:
	ld hl,$CEBB
	ld a,[hl]
	xor $01
	ld [hl],a
	ret

Unknown_0x5D80:
	ld hl,$C211
	dec [hl]
	ret nz
	ld a,$04
	ld [hl],a
	ld a,[$D22C]
	xor $01
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6A2C
	add hl,bc
	ld de,$C205
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$01
	ld [$C21B],a
	ret

Logged_0x5DAC:
	ld a,[$C21B]
	rst JumpList
	dw Logged_0x5DB8
	dw Logged_0x5E53
	dw Logged_0x5E6A
	dw Logged_0x5E87

Logged_0x5DB8:
	ld hl,$C20C
	set 7,[hl]
	ld hl,$C214
	set 0,[hl]
	ld a,$1E
	ld [$C211],a
	ld a,[$C214]
	and $02
	rrca
	add a,$CC
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	call Logged_0x31AF
	ld a,[$D13C]
	and a
	jr nz,Logged_0x5DEF

Logged_0x5DDF:
	ld hl,$C205
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$02
	ld [$C21B],a
	ret

Logged_0x5DEF:
	ld a,[$C210]
	xor $01
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6A2C
	add hl,bc
	ld de,$C205
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld a,[$C210]
	xor $01
	rst JumpList
	dw Logged_0x5E1B
	dw Logged_0x5E24
	dw Unknown_0x5E31
	dw Logged_0x5E3C

Logged_0x5E1B:
	ld a,[$C203]
	and $0F
	jr z,Logged_0x5DDF
	jr Logged_0x5E4A

Logged_0x5E24:
	ld a,[$C203]
	and $0F
	jr z,Logged_0x5DDF
	ld b,a
	ld a,$10
	sub b
	jr Logged_0x5E4A

Unknown_0x5E31:
	ld a,[$C207]
	sub $08
	and $0F
	jr z,Logged_0x5DDF
	jr Logged_0x5E4A

Logged_0x5E3C:
	ld a,[$C207]
	sub $08
	and $0F
	jp z,Logged_0x5DDF
	ld b,a
	ld a,$10
	sub b

Logged_0x5E4A:
	ld [$C212],a
	ld a,$01
	ld [$C21B],a
	ret

Logged_0x5E53:
	ld hl,$C211
	dec [hl]
	inc hl
	dec [hl]
	ret nz
	ld hl,$C205
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$02
	ld [$C21B],a
	ret

Logged_0x5E6A:
	ld hl,$C211
	dec [hl]
	ret nz
	ld a,$78
	ld [hl],a
	ld a,$03
	ld [$C21B],a
	ld a,$03
	ld [$C202],a
	ld a,$01
	ld [$C20D],a
	ld de,$C201
	jp Logged_0x31D7

Logged_0x5E87:
	ld hl,$C211
	dec [hl]
	ret nz
	ld a,$03
	ld [$CEB9],a
	xor a
	ld [$C213],a
	ld [$D13C],a
	ld hl,$C20C
	res 7,[hl]
	ld hl,$C214
	res 0,[hl]
	ld a,[$C210]
	add a,$C0
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31AF

Logged_0x5EB1:
	ld a,[$C21B]
	rst JumpList
	dw Logged_0x5EBB
	dw Logged_0x5EFA
	dw Logged_0x5F17

Logged_0x5EBB:
	ld a,[$DC07]
	set 7,a
	ld [$DC07],a
	ld a,$01
	ld [$D245],a
	ld a,[$D12B]
	set 4,a
	ld [$D12B],a
	ld hl,$C205
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$01
	ld [$C21B],a
	ld a,$3C
	ld [$C211],a
	ld a,$01
	ld [$D174],a
	xor a
	ld [$FF00+$93],a
	xor a
	ld [$FF00+$94],a
	ld b,$CC
	xor a
	ld c,a
	ld d,a
	ld hl,$C201
	jp Logged_0x31B3

Logged_0x5EFA:
	ld hl,$C211
	dec [hl]
	ret nz
	ld a,$F0
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld a,$02
	ld [$C21B],a
	ld a,$03
	ld [$C202],a
	ld c,$01
	ld hl,$C20D
	jp Logged_0x31C3

Logged_0x5F17:
	ld hl,$C211
	ld a,[hli]
	ld e,a
	ld d,[hl]
	dec de
	ld a,d
	ld [hld],a
	ld [hl],e
	or e
	ret nz
	xor a
	ld [$C200],a
	ld a,$13
	ld [$FF00+$91],a
	ret

Logged_0x5F2C:
	ld a,[$C213]
	cp $09
	ret z
	ld a,[$D141]
	rra
	ret c
	ld hl,$D16B
	ld a,[$D16A]
	or [hl]
	ret nz
	ld hl,$6A3C
	ld e,l
	ld d,h
	ld hl,$C223
	ld a,[$C203]
	ld c,a
	ld a,[de]
	add a,c
	sub [hl]
	ret c
	push af
	inc de
	ld a,[de]
	ld c,a
	pop af
	cp c
	ret nc
	ld b,$01
	ld a,[$C203]
	cp [hl]
	jr c,Logged_0x5F60
	ld b,$02

Logged_0x5F60:
	inc hl
	inc hl
	inc hl
	inc hl
	inc de
	ld a,[de]
	ld c,a
	push bc
	ld a,[$C207]
	ld c,a
	inc de
	ld a,[de]
	add a,c
	pop bc
	jr nc,Logged_0x5F77
	inc de
	ld a,[de]
	ld c,a
	inc de
	ld a,[de]

Logged_0x5F77:
	sub [hl]
	ret c
	cp c
	ret nc
	ld a,$04
	or b
	ld b,a
	ld a,[$C207]
	cp [hl]
	jr c,Logged_0x5F89
	ld a,$0C
	xor b
	ld b,a

Logged_0x5F89:
	ld hl,$D22A
	ld a,b
	ld [hli],a
	xor $0F
	ld [hl],a
	ld hl,$C213
	ld a,[hl]
	cp $02
	jr nc,Logged_0x5FAB
	ld a,[$CEB9]
	cp $04
	jr z,Logged_0x5FAB
	cp $05
	jr z,Logged_0x5FAB
	ld a,$09
	ld [hl],a
	xor a
	ld [$C21B],a

Logged_0x5FAB:
	ld a,[$D141]
	and $40
	ld b,a
	ld a,[$D16A]
	or b
	ld b,a
	ld a,[$D16B]
	or b
	ret nz
	ld hl,$C233
	ld a,[hl]
	cp $10
	ret z
	cp $0D
	jr nz,Logged_0x5FCC
	ld a,[$C23A]
	cp $02
	ret z

Logged_0x5FCC:
	ld a,$10
	ld [hl],a
	xor a
	ld [$C23B],a
	ld hl,$C234
	set 5,[hl]
	ret

Logged_0x5FD9:
	ld hl,$C420
	ld a,[hli]
	and a
	jr nz,Logged_0x5FE6
	ld hl,$C220
	ld a,[hli]
	and a
	ret z

Logged_0x5FE6:
	inc hl
	inc hl
	ld a,[$C203]
	ld d,a
	ld a,[$C207]
	ld e,a
	ld a,[$C210]
	push hl
	call Logged_0x301A
	pop hl
	ld a,d
	add a,$04
	sub [hl]
	jr c,Logged_0x604A
	cp $09
	ret nc
	inc hl
	inc hl
	inc hl
	inc hl
	ld c,$09
	ld a,e
	add a,$04
	jr nc,Logged_0x6010
	ld a,$F8
	ld c,$03

Logged_0x6010:
	sub [hl]
	jr c,Logged_0x604A
	cp c
	ret nc
	ld d,[hl]
	ld a,$0C
	add a,l
	ld l,a
	ld a,[$D141]
	and $40
	ld b,a
	ld a,[$D16A]
	or b
	ld b,a
	ld a,[$D16B]
	or b
	jr nz,Logged_0x6048
	ld a,[hl]
	cp $10
	jr z,Logged_0x6048
	ld b,$00
	ld a,[$C207]
	cp d
	jr c,Unknown_0x6039
	inc b

Unknown_0x6039:
	ld a,$10
	ld [hl],a
	ld a,$08
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld hl,$D142
	ld a,[hl]
	or b
	ld [hl],a

Logged_0x6048:
	scf
	ret

Logged_0x604A:
	and a
	ret

Logged_0x604C:
	ld b,a
	ld hl,$D13D
	ld a,[hl]
	and a
	jr nz,Logged_0x6057
	inc [hl]
	jr Logged_0x605C

Logged_0x6057:
	ld a,[$FF00+$94]
	and $F0
	ret z

Logged_0x605C:
	ld hl,$DC03
	set 3,[hl]
	ret

UnknownData_0x6062:
INCBIN "baserom.gb", $6062, $6063 - $6062

Logged_0x6063:
	xor a
	ld [$FF00+$94],a
	ld a,[$C214]
	bit 5,a
	ret z
	ld hl,$D13B
	bit 0,[hl]
	jr z,Logged_0x6079
	res 0,[hl]
	ld hl,$CEB8
	inc [hl]

Logged_0x6079:
	ld a,[$CEB8]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6088
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x6088:
INCBIN "baserom.gb", $6088, $6090 - $6088

UnknownData_0x6090:
INCBIN "baserom.gb", $6090, $6092 - $6090
	ld hl,$CEC0
	dec [hl]
	jr nz,Logged_0x609E
	ld [hl],$20
	call Logged_0x6683
	ret nc

Logged_0x609E:
	ld a,[$CEB9]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$60AD
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x60AD:
INCBIN "baserom.gb", $60AD, $60AF - $60AD

UnknownData_0x60AF:
INCBIN "baserom.gb", $60AF, $60B1 - $60AF

LoggedData_0x60B1:
INCBIN "baserom.gb", $60B1, $60BD - $60B1
	ld hl,$CEC0
	dec [hl]
	jr nz,Logged_0x60C9
	ld [hl],$18
	call Logged_0x6683
	ret nc

Logged_0x60C9:
	ld a,[$CEB9]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$60AD
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	ld hl,$CEC0
	dec [hl]
	jr nz,Logged_0x60E4
	ld [hl],$20
	call Logged_0x6683
	ret nc

Logged_0x60E4:
	ld a,[$CEB9]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$60AD
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	ld hl,$CEC0
	dec [hl]
	jr nz,Logged_0x60FF
	ld [hl],$18
	call Logged_0x6683
	ret nc

Logged_0x60FF:
	ld a,[$CEB9]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$60AD
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

UnknownData_0x610E:
INCBIN "baserom.gb", $610E, $6129 - $610E

Logged_0x6129:
	ld a,[$D141]
	rra
	jr nc,Logged_0x613A
	ld a,$06
	ld [$CEB9],a
	xor a
	ld [$FF00+$93],a
	jp Logged_0x642B

Logged_0x613A:
	ld hl,$CEC1
	dec [hl]
	jr nz,Logged_0x6149
	xor a
	ld [$FF00+$93],a
	ld a,$04
	ld [$CEB9],a
	ret

Logged_0x6149:
	xor a
	ld [$D24C],a
	ld b,$00
	ld hl,$C223
	ld a,[$C203]
	sub [hl]
	jr nc,Logged_0x615B
	inc b
	cpl
	inc a

Logged_0x615B:
	ld d,a
	ld hl,$C227
	ld a,[$C207]
	sub [hl]
	jr nc,Logged_0x6169
	inc b
	inc b
	cpl
	inc a

Logged_0x6169:
	ld e,a
	cp d
	jr nc,Logged_0x6177
	ld a,b
	and $01
	ld c,a
	xor a
	ld [$D24B],a
	jr Logged_0x6183

Logged_0x6177:
	ld a,b
	and $02
	rrca
	add a,$02
	ld c,a
	ld a,$01
	ld [$D24B],a

Logged_0x6183:
	ld hl,$C203
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	push bc
	ld a,c
	call Logged_0x301A
	ld a,d
	cp $30
	jr c,Logged_0x61A3
	cp $71
	jr nc,Logged_0x61A3
	ld a,e
	cp $18
	jr c,Logged_0x61A3
	cp $89
	jr c,Logged_0x61AC

Logged_0x61A3:
	pop bc
	ld a,c
	xor $01
	ld c,a
	push bc
	call Logged_0x301A

Logged_0x61AC:
	ld bc,$0201
	call Logged_0x2F6C
	pop bc
	jr z,Logged_0x61D7
	ld a,d
	cp $10
	jr z,Logged_0x61EC
	ld hl,$D24C
	ld a,[hl]
	and a
	jr nz,Logged_0x61D7
	inc [hl]
	ld a,[$D24B]
	and a
	jr nz,Logged_0x61D1
	ld a,b
	and $02
	rrca
	add a,$02
	ld c,a
	jr Logged_0x6183

Logged_0x61D1:
	ld a,b
	and $01
	ld c,a
	jr Logged_0x6183

Logged_0x61D7:
	ld a,c
	ld c,a
	ld b,$00
	ld hl,$61FD
	add hl,bc
	ld a,[$FF00+$93]
	and $0F
	or [hl]
	ld [$FF00+$93],a
	ld hl,$C214
	res 5,[hl]
	ret

Logged_0x61EC:
	ld hl,$C210
	ld [hl],c
	ld hl,$FF93
	ld a,[hl]
	and $0F
	ld [hl],a
	ld hl,$FF94
	set 0,[hl]
	ret

LoggedData_0x61FD:
INCBIN "baserom.gb", $61FD, $6201 - $61FD

UnknownData_0x6201:
INCBIN "baserom.gb", $6201, $62BA - $6201
	call Logged_0x658F
	ld a,b
	ld c,a
	ld b,$00
	ld hl,$634B
	add hl,bc
	ld e,l
	ld d,h
	call Logged_0x657C
	ld a,b
	ld c,a
	ld b,$00
	ld hl,$634B
	add hl,bc
	ld a,[de]
	cp [hl]
	jr z,Logged_0x630B
	push hl
	ld a,[de]
	add a,a
	add a,a
	ld b,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$634F
	add hl,bc
	ld a,[$CEBC]
	and $01
	cp [hl]
	jr z,Logged_0x62FC
	ld a,[$CEBC]
	and $FE
	or [hl]
	ld [$CEBC],a
	ld a,[$C210]
	xor $01
	ld [$C210],a

Logged_0x62FC:
	pop hl
	ld a,[hl]
	ld [$CEBD],a
	ld hl,$CEBC
	set 1,[hl]
	ld a,$03
	ld [$CEBF],a

Logged_0x630B:
	ld a,[$CEBD]
	add a,a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$635F
	add hl,bc
	ld c,$02

Logged_0x631A:
	ld a,[$C203]
	cp [hl]
	jr nz,Logged_0x6328
	inc hl
	ld a,[$C207]
	cp [hl]
	jr z,Logged_0x6331
	dec hl

Logged_0x6328:
	inc hl
	inc hl
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x631A
	jr Logged_0x6348

Logged_0x6331:
	inc hl
	ld a,[hli]
	ld [$C210],a
	ld a,[$CEBC]
	and $FE
	or [hl]
	ld [$CEBC],a
	ld hl,$CEBC
	res 1,[hl]
	xor a
	ld [$CEBF],a

Logged_0x6348:
	jp Logged_0x64F1

LoggedData_0x634B:
INCBIN "baserom.gb", $634B, $634F - $634B

UnknownData_0x634F:
INCBIN "baserom.gb", $634F, $6350 - $634F

LoggedData_0x6350:
INCBIN "baserom.gb", $6350, $6354 - $6350

UnknownData_0x6354:
INCBIN "baserom.gb", $6354, $6355 - $6354

LoggedData_0x6355:
INCBIN "baserom.gb", $6355, $6359 - $6355

UnknownData_0x6359:
INCBIN "baserom.gb", $6359, $635A - $6359

LoggedData_0x635A:
INCBIN "baserom.gb", $635A, $635E - $635A

UnknownData_0x635E:
INCBIN "baserom.gb", $635E, $635F - $635E

LoggedData_0x635F:
INCBIN "baserom.gb", $635F, $637F - $635F
	ld hl,$C214
	res 2,[hl]
	ld hl,$CEBC
	set 2,[hl]
	xor a
	ld [$CEBE],a
	ld a,$01
	ld [$CEC2],a
	ld a,$40
	ld [$CEC1],a
	xor a
	ld [$CEBF],a
	xor a
	ld [$CEB9],a
	ret
	ld hl,$C214
	set 2,[hl]
	ld hl,$CEBC
	res 2,[hl]
	ld a,[$C207]
	cp $58
	jr nc,Logged_0x63BB
	ld b,$03
	cp $18
	jr z,Unknown_0x63D5
	ld b,$03
	jr Logged_0x63C3

Logged_0x63BB:
	ld b,$02
	cp $88
	jr z,Unknown_0x63D5
	ld b,$02

Logged_0x63C3:
	ld a,b
	ld [$CEBB],a
	xor a
	ld [$FF00+$93],a
	ld a,$03
	ld [$CEBF],a
	ld a,$05
	ld [$CEB9],a
	ret

Unknown_0x63D5:
	ld a,b
	ld [$CEBB],a
	jr Logged_0x63FD
	ld a,[$CEBB]
	cp $02
	jr z,Logged_0x63EF
	ld a,[$C207]
	cp $18
	jr z,Logged_0x63FD
	ld a,$20
	ld [$FF00+$93],a
	jr Logged_0x63FA

Logged_0x63EF:
	ld a,[$C207]
	cp $88
	jr z,Logged_0x63FD
	ld a,$10
	ld [$FF00+$93],a

Logged_0x63FA:
	jp Logged_0x652A

Logged_0x63FD:
	xor a
	ld [$FF00+$93],a
	ld a,$02
	ld [$CEB9],a
	ld bc,$0000
	ld a,[$C203]
	cp $50
	jr nc,Logged_0x6412
	inc b
	ld c,$01

Logged_0x6412:
	ld a,b
	ld [$C210],a
	ld a,[$C207]
	cp $18
	jr z,Logged_0x6421
	ld a,c
	xor $01
	ld c,a

Logged_0x6421:
	ld a,[$CEBC]
	and $FE
	or c
	ld [$CEBC],a
	ret

Logged_0x642B:
	ld a,[$D141]
	rra
	jr c,Logged_0x6438
	xor a
	ld [$CEB9],a
	jp Logged_0x6129

Logged_0x6438:
	ld hl,$CEC1
	dec [hl]
	jr nz,Logged_0x6444
	ld a,$04
	ld [$CEB9],a
	ret

Logged_0x6444:
	ld a,[$CEBE]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6453
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x6453:
INCBIN "baserom.gb", $6453, $6459 - $6453
	ld a,$04
	call Logged_0x1331
	and $03
	ld b,a
	ld hl,$C203
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld c,$04

Logged_0x646C:
	push de
	push bc
	ld a,b
	call Logged_0x301A
	ld a,d
	cp $30
	jr c,Logged_0x6484
	cp $71
	jr nc,Logged_0x6484
	ld a,e
	cp $18
	jr c,Logged_0x6484
	cp $89
	jr c,Logged_0x6488

Logged_0x6484:
	pop bc
	pop de
	jr Logged_0x6497

Logged_0x6488:
	ld bc,$0201
	call Logged_0x2F6C
	pop bc
	pop de
	jr z,Logged_0x64A0
	ld a,d
	cp $10
	jr z,Unknown_0x64C1

Logged_0x6497:
	ld a,b
	inc a
	and $03
	ld b,a
	dec c
	jr nz,Logged_0x646C
	ret

Logged_0x64A0:
	ld a,b
	ld c,a
	ld b,$00
	ld hl,$61FD
	add hl,bc
	ld a,[$FF00+$93]
	and $0F
	or [hl]
	ld [$FF00+$93],a
	ld hl,$C214
	res 5,[hl]
	ld hl,$CEC2
	dec [hl]
	ret nz
	ld [hl],$01
	ld a,$01
	ld [$CEBE],a
	ret

Unknown_0x64C1:
	ld hl,$C210
	ld [hl],b
	xor a
	ld [$FF00+$93],a
	ld hl,$FF94
	set 0,[hl]
	ret
	ld a,$02
	ld [$CEBE],a
	xor a
	ld [$FF00+$93],a
	ld hl,$FF94
	set 0,[hl]
	ret
	xor a
	ld [$CEBE],a
	xor a
	ld [$FF00+$93],a
	ld hl,$FF94
	set 0,[hl]
	ret
	ld a,$02
	ld [$CEB9],a
	jp Logged_0x64F1

Logged_0x64F1:
	ld a,[$CEBC]
	and $01
	swap a
	ld b,a
	ld hl,$C210
	ld a,[hl]
	add a,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$655C
	add hl,bc
	ld a,[$C203]
	cp [hl]
	jr nz,Logged_0x651D
	inc hl
	ld a,[$C207]
	cp [hl]
	jr nz,Logged_0x651D
	inc hl
	ld a,[hli]
	ld [$C210],a
	ld a,[hl]
	ld [$CEBB],a

Logged_0x651D:
	ld a,[$C210]
	ld c,a
	ld b,$00
	ld hl,$61FD
	add hl,bc
	ld a,[hl]
	ld [$FF00+$93],a

Logged_0x652A:
	ld hl,$C203
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,[$C210]
	call Logged_0x301A
	ld bc,$0201
	call Logged_0x2F6C
	ret z
	ld a,d
	cp $70
	jr c,Logged_0x6553
	cp $78
	jr nc,Logged_0x6553
	ld a,$03
	ld [$C213],a
	xor a
	ld [$C21B],a
	ret

Logged_0x6553:
	cp $10
	ret nz
	ld hl,$FF94
	set 0,[hl]
	ret

LoggedData_0x655C:
INCBIN "baserom.gb", $655C, $657C - $655C

Logged_0x657C:
	ld b,$00
	ld a,[$C223]
	cp $50
	jr c,Logged_0x6586
	inc b

Logged_0x6586:
	ld a,[$C227]
	cp $50
	ret c
	inc b
	inc b
	ret

Logged_0x658F:
	ld b,$00
	ld a,[$C203]
	cp $50
	jr c,Logged_0x6599
	inc b

Logged_0x6599:
	ld a,[$C207]
	cp $50
	ret c
	inc b
	inc b
	ret

UnknownData_0x65A2:
INCBIN "baserom.gb", $65A2, $6683 - $65A2

Logged_0x6683:
	ld a,[$CEBC]
	and $06
	jr z,Logged_0x6691
	ld a,$01
	ld [$CEC0],a
	scf
	ret

Logged_0x6691:
	xor a
	ld [$FF00+$93],a
	ld [$C21B],a
	ld a,$02
	ld [$C213],a
	and a
	ret

Logged_0x669E:
	rla
	jr nc,Logged_0x66AA
	add hl,bc
	ld a,d
	cp $70
	jp nc,Unknown_0x66D0
	jr Logged_0x66CE

Logged_0x66AA:
	rla
	jr nc,Logged_0x66B5
	ld a,d
	cp $31
	jp c,Unknown_0x66D0
	jr Logged_0x66CE

Logged_0x66B5:
	rla
	jr nc,Logged_0x66C2
	add hl,bc
	add hl,bc
	ld a,e
	cp $19
	jp c,Unknown_0x66D0
	jr Logged_0x66CE

Logged_0x66C2:
	rla
	jr nc,Logged_0x66D3
	add hl,bc
	add hl,bc
	add hl,bc
	ld a,e
	cp $88
	jp nc,Unknown_0x66D0

Logged_0x66CE:
	xor a
	ret

Unknown_0x66D0:
	ld a,$01
	ret

Logged_0x66D3:
	ld a,$02
	ret

LoggedData_0x66D6:
INCBIN "baserom.gb", $66D6, $66D8 - $66D6

UnknownData_0x66D8:
INCBIN "baserom.gb", $66D8, $66DC - $66D8

LoggedData_0x66DC:
INCBIN "baserom.gb", $66DC, $66DE - $66DC

UnknownData_0x66DE:
INCBIN "baserom.gb", $66DE, $6728 - $66DE

LoggedData_0x6728:
INCBIN "baserom.gb", $6728, $674F - $6728

UnknownData_0x674F:
INCBIN "baserom.gb", $674F, $6750 - $674F

LoggedData_0x6750:
INCBIN "baserom.gb", $6750, $6753 - $6750

UnknownData_0x6753:
INCBIN "baserom.gb", $6753, $6754 - $6753

LoggedData_0x6754:
INCBIN "baserom.gb", $6754, $6758 - $6754

UnknownData_0x6758:
INCBIN "baserom.gb", $6758, $6759 - $6758

LoggedData_0x6759:
INCBIN "baserom.gb", $6759, $675C - $6759

UnknownData_0x675C:
INCBIN "baserom.gb", $675C, $675D - $675C

LoggedData_0x675D:
INCBIN "baserom.gb", $675D, $6761 - $675D

UnknownData_0x6761:
INCBIN "baserom.gb", $6761, $6762 - $6761

LoggedData_0x6762:
INCBIN "baserom.gb", $6762, $6765 - $6762

UnknownData_0x6765:
INCBIN "baserom.gb", $6765, $6766 - $6765

LoggedData_0x6766:
INCBIN "baserom.gb", $6766, $676A - $6766

UnknownData_0x676A:
INCBIN "baserom.gb", $676A, $676B - $676A

LoggedData_0x676B:
INCBIN "baserom.gb", $676B, $676E - $676B

UnknownData_0x676E:
INCBIN "baserom.gb", $676E, $676F - $676E

LoggedData_0x676F:
INCBIN "baserom.gb", $676F, $6770 - $676F

UnknownData_0x6770:
INCBIN "baserom.gb", $6770, $6794 - $6770

LoggedData_0x6794:
INCBIN "baserom.gb", $6794, $6798 - $6794

UnknownData_0x6798:
INCBIN "baserom.gb", $6798, $67A0 - $6798

LoggedData_0x67A0:
INCBIN "baserom.gb", $67A0, $67A4 - $67A0

UnknownData_0x67A4:
INCBIN "baserom.gb", $67A4, $68B0 - $67A4

LoggedData_0x68B0:
INCBIN "baserom.gb", $68B0, $68B4 - $68B0

UnknownData_0x68B4:
INCBIN "baserom.gb", $68B4, $68C0 - $68B4

LoggedData_0x68C0:
INCBIN "baserom.gb", $68C0, $68C4 - $68C0

UnknownData_0x68C4:
INCBIN "baserom.gb", $68C4, $68D0 - $68C4

LoggedData_0x68D0:
INCBIN "baserom.gb", $68D0, $68D4 - $68D0

UnknownData_0x68D4:
INCBIN "baserom.gb", $68D4, $68E0 - $68D4

LoggedData_0x68E0:
INCBIN "baserom.gb", $68E0, $68E4 - $68E0

UnknownData_0x68E4:
INCBIN "baserom.gb", $68E4, $68F0 - $68E4

LoggedData_0x68F0:
INCBIN "baserom.gb", $68F0, $68F4 - $68F0

UnknownData_0x68F4:
INCBIN "baserom.gb", $68F4, $6900 - $68F4

LoggedData_0x6900:
INCBIN "baserom.gb", $6900, $6904 - $6900

UnknownData_0x6904:
INCBIN "baserom.gb", $6904, $6910 - $6904

LoggedData_0x6910:
INCBIN "baserom.gb", $6910, $6914 - $6910

UnknownData_0x6914:
INCBIN "baserom.gb", $6914, $6920 - $6914

LoggedData_0x6920:
INCBIN "baserom.gb", $6920, $6924 - $6920

UnknownData_0x6924:
INCBIN "baserom.gb", $6924, $6934 - $6924

LoggedData_0x6934:
INCBIN "baserom.gb", $6934, $6938 - $6934

UnknownData_0x6938:
INCBIN "baserom.gb", $6938, $6944 - $6938

LoggedData_0x6944:
INCBIN "baserom.gb", $6944, $6948 - $6944

UnknownData_0x6948:
INCBIN "baserom.gb", $6948, $6954 - $6948

LoggedData_0x6954:
INCBIN "baserom.gb", $6954, $6958 - $6954

UnknownData_0x6958:
INCBIN "baserom.gb", $6958, $6964 - $6958

LoggedData_0x6964:
INCBIN "baserom.gb", $6964, $6968 - $6964

UnknownData_0x6968:
INCBIN "baserom.gb", $6968, $6974 - $6968

LoggedData_0x6974:
INCBIN "baserom.gb", $6974, $6978 - $6974

UnknownData_0x6978:
INCBIN "baserom.gb", $6978, $6984 - $6978

LoggedData_0x6984:
INCBIN "baserom.gb", $6984, $6988 - $6984

UnknownData_0x6988:
INCBIN "baserom.gb", $6988, $6994 - $6988

LoggedData_0x6994:
INCBIN "baserom.gb", $6994, $6998 - $6994

UnknownData_0x6998:
INCBIN "baserom.gb", $6998, $69A4 - $6998

LoggedData_0x69A4:
INCBIN "baserom.gb", $69A4, $69A8 - $69A4

UnknownData_0x69A8:
INCBIN "baserom.gb", $69A8, $6A28 - $69A8

LoggedData_0x6A28:
INCBIN "baserom.gb", $6A28, $6A40 - $6A28

UnknownData_0x6A40:
INCBIN "baserom.gb", $6A40, $6A5A - $6A40

LoggedData_0x6A5A:
INCBIN "baserom.gb", $6A5A, $6A70 - $6A5A

UnknownData_0x6A70:
INCBIN "baserom.gb", $6A70, $6C25 - $6A70

LoggedData_0x6C25:
INCBIN "baserom.gb", $6C25, $6C31 - $6C25

UnknownData_0x6C31:
INCBIN "baserom.gb", $6C31, $6C39 - $6C31

LoggedData_0x6C39:
INCBIN "baserom.gb", $6C39, $6C3D - $6C39

UnknownData_0x6C3D:
INCBIN "baserom.gb", $6C3D, $6C49 - $6C3D

LoggedData_0x6C49:
INCBIN "baserom.gb", $6C49, $6C5D - $6C49

UnknownData_0x6C5D:
INCBIN "baserom.gb", $6C5D, $6CFD - $6C5D

LoggedData_0x6CFD:
INCBIN "baserom.gb", $6CFD, $734D - $6CFD

UnknownData_0x734D:
INCBIN "baserom.gb", $734D, $8000 - $734D

SECTION "Bank02", ROMX, BANK[$02]

UnknownData_0x8000:
INCBIN "baserom.gb", $8000, $8004 - $8000

LoggedData_0x8004:
INCBIN "baserom.gb", $8004, $8006 - $8004

UnknownData_0x8006:
INCBIN "baserom.gb", $8006, $8012 - $8006

LoggedData_0x8012:
INCBIN "baserom.gb", $8012, $8016 - $8012

UnknownData_0x8016:
INCBIN "baserom.gb", $8016, $811A - $8016

LoggedData_0x811A:
INCBIN "baserom.gb", $811A, $812A - $811A

UnknownData_0x812A:
INCBIN "baserom.gb", $812A, $818A - $812A

LoggedData_0x818A:
INCBIN "baserom.gb", $818A, $81AA - $818A

UnknownData_0x81AA:
INCBIN "baserom.gb", $81AA, $88AC - $81AA

LoggedData_0x88AC:
INCBIN "baserom.gb", $88AC, $88AE - $88AC

UnknownData_0x88AE:
INCBIN "baserom.gb", $88AE, $88C8 - $88AE

LoggedData_0x88C8:
INCBIN "baserom.gb", $88C8, $88CA - $88C8

UnknownData_0x88CA:
INCBIN "baserom.gb", $88CA, $88DB - $88CA

LoggedData_0x88DB:
INCBIN "baserom.gb", $88DB, $88EC - $88DB

UnknownData_0x88EC:
INCBIN "baserom.gb", $88EC, $89C9 - $88EC

LoggedData_0x89C9:
INCBIN "baserom.gb", $89C9, $89DA - $89C9

UnknownData_0x89DA:
INCBIN "baserom.gb", $89DA, $89E0 - $89DA

LoggedData_0x89E0:
INCBIN "baserom.gb", $89E0, $89F8 - $89E0

UnknownData_0x89F8:
INCBIN "baserom.gb", $89F8, $8A0A - $89F8

LoggedData_0x8A0A:
INCBIN "baserom.gb", $8A0A, $8A22 - $8A0A

UnknownData_0x8A22:
INCBIN "baserom.gb", $8A22, $8A7C - $8A22

LoggedData_0x8A7C:
INCBIN "baserom.gb", $8A7C, $8B9C - $8A7C

UnknownData_0x8B9C:
INCBIN "baserom.gb", $8B9C, $8C62 - $8B9C

LoggedData_0x8C62:
INCBIN "baserom.gb", $8C62, $8CDE - $8C62

UnknownData_0x8CDE:
INCBIN "baserom.gb", $8CDE, $8CE0 - $8CDE

LoggedData_0x8CE0:
INCBIN "baserom.gb", $8CE0, $8CE4 - $8CE0

UnknownData_0x8CE4:
INCBIN "baserom.gb", $8CE4, $8CF0 - $8CE4

LoggedData_0x8CF0:
INCBIN "baserom.gb", $8CF0, $8CF2 - $8CF0

UnknownData_0x8CF2:
INCBIN "baserom.gb", $8CF2, $8CF4 - $8CF2

LoggedData_0x8CF4:
INCBIN "baserom.gb", $8CF4, $8D1A - $8CF4

UnknownData_0x8D1A:
INCBIN "baserom.gb", $8D1A, $8D1C - $8D1A

LoggedData_0x8D1C:
INCBIN "baserom.gb", $8D1C, $8D32 - $8D1C

UnknownData_0x8D32:
INCBIN "baserom.gb", $8D32, $8D38 - $8D32

LoggedData_0x8D38:
INCBIN "baserom.gb", $8D38, $8D44 - $8D38

UnknownData_0x8D44:
INCBIN "baserom.gb", $8D44, $8D4C - $8D44

LoggedData_0x8D4C:
INCBIN "baserom.gb", $8D4C, $8D4E - $8D4C

UnknownData_0x8D4E:
INCBIN "baserom.gb", $8D4E, $8D6C - $8D4E

LoggedData_0x8D6C:
INCBIN "baserom.gb", $8D6C, $8D7E - $8D6C

UnknownData_0x8D7E:
INCBIN "baserom.gb", $8D7E, $8D84 - $8D7E

LoggedData_0x8D84:
INCBIN "baserom.gb", $8D84, $8D9A - $8D84

UnknownData_0x8D9A:
INCBIN "baserom.gb", $8D9A, $8D9C - $8D9A

LoggedData_0x8D9C:
INCBIN "baserom.gb", $8D9C, $8DD2 - $8D9C

UnknownData_0x8DD2:
INCBIN "baserom.gb", $8DD2, $8F28 - $8DD2

LoggedData_0x8F28:
INCBIN "baserom.gb", $8F28, $8F37 - $8F28

UnknownData_0x8F37:
INCBIN "baserom.gb", $8F37, $8F4D - $8F37

LoggedData_0x8F4D:
INCBIN "baserom.gb", $8F4D, $9143 - $8F4D

UnknownData_0x9143:
INCBIN "baserom.gb", $9143, $9160 - $9143

LoggedData_0x9160:
INCBIN "baserom.gb", $9160, $9418 - $9160

UnknownData_0x9418:
INCBIN "baserom.gb", $9418, $9454 - $9418

LoggedData_0x9454:
INCBIN "baserom.gb", $9454, $975D - $9454

UnknownData_0x975D:
INCBIN "baserom.gb", $975D, $978F - $975D

LoggedData_0x978F:
INCBIN "baserom.gb", $978F, $99F1 - $978F

UnknownData_0x99F1:
INCBIN "baserom.gb", $99F1, $99F3 - $99F1

LoggedData_0x99F3:
INCBIN "baserom.gb", $99F3, $99F5 - $99F3

UnknownData_0x99F5:
INCBIN "baserom.gb", $99F5, $9A0F - $99F5

LoggedData_0x9A0F:
INCBIN "baserom.gb", $9A0F, $9A11 - $9A0F

UnknownData_0x9A11:
INCBIN "baserom.gb", $9A11, $9A19 - $9A11

LoggedData_0x9A19:
INCBIN "baserom.gb", $9A19, $9A21 - $9A19

UnknownData_0x9A21:
INCBIN "baserom.gb", $9A21, $9A89 - $9A21

LoggedData_0x9A89:
INCBIN "baserom.gb", $9A89, $9A91 - $9A89

UnknownData_0x9A91:
INCBIN "baserom.gb", $9A91, $9B0F - $9A91

LoggedData_0x9B0F:
INCBIN "baserom.gb", $9B0F, $9B8D - $9B0F

UnknownData_0x9B8D:
INCBIN "baserom.gb", $9B8D, $A1F3 - $9B8D

LoggedData_0xA1F3:
INCBIN "baserom.gb", $A1F3, $A271 - $A1F3

UnknownData_0xA271:
INCBIN "baserom.gb", $A271, $A2EF - $A271

LoggedData_0xA2EF:
INCBIN "baserom.gb", $A2EF, $A36D - $A2EF

UnknownData_0xA36D:
INCBIN "baserom.gb", $A36D, $A9D3 - $A36D

LoggedData_0xA9D3:
INCBIN "baserom.gb", $A9D3, $AA51 - $A9D3

UnknownData_0xAA51:
INCBIN "baserom.gb", $AA51, $AA76 - $AA51

LoggedData_0xAA76:
INCBIN "baserom.gb", $AA76, $AA8F - $AA76

UnknownData_0xAA8F:
INCBIN "baserom.gb", $AA8F, $AC04 - $AA8F

LoggedData_0xAC04:
INCBIN "baserom.gb", $AC04, $AC38 - $AC04

UnknownData_0xAC38:
INCBIN "baserom.gb", $AC38, $AC6F - $AC38

LoggedData_0xAC6F:
INCBIN "baserom.gb", $AC6F, $ACB2 - $AC6F

UnknownData_0xACB2:
INCBIN "baserom.gb", $ACB2, $AFDA - $ACB2

LoggedData_0xAFDA:
INCBIN "baserom.gb", $AFDA, $B040 - $AFDA

UnknownData_0xB040:
INCBIN "baserom.gb", $B040, $B060 - $B040

LoggedData_0xB060:
INCBIN "baserom.gb", $B060, $B062 - $B060

UnknownData_0xB062:
INCBIN "baserom.gb", $B062, $B06C - $B062

LoggedData_0xB06C:
INCBIN "baserom.gb", $B06C, $B06E - $B06C

UnknownData_0xB06E:
INCBIN "baserom.gb", $B06E, $B070 - $B06E

LoggedData_0xB070:
INCBIN "baserom.gb", $B070, $B072 - $B070

UnknownData_0xB072:
INCBIN "baserom.gb", $B072, $B074 - $B072

LoggedData_0xB074:
INCBIN "baserom.gb", $B074, $B090 - $B074

UnknownData_0xB090:
INCBIN "baserom.gb", $B090, $B0B6 - $B090

LoggedData_0xB0B6:
INCBIN "baserom.gb", $B0B6, $B0B8 - $B0B6

UnknownData_0xB0B8:
INCBIN "baserom.gb", $B0B8, $B0BA - $B0B8

LoggedData_0xB0BA:
INCBIN "baserom.gb", $B0BA, $B0C2 - $B0BA

UnknownData_0xB0C2:
INCBIN "baserom.gb", $B0C2, $B0D0 - $B0C2

LoggedData_0xB0D0:
INCBIN "baserom.gb", $B0D0, $B0F8 - $B0D0

UnknownData_0xB0F8:
INCBIN "baserom.gb", $B0F8, $B108 - $B0F8

LoggedData_0xB108:
INCBIN "baserom.gb", $B108, $B110 - $B108

UnknownData_0xB110:
INCBIN "baserom.gb", $B110, $B138 - $B110

LoggedData_0xB138:
INCBIN "baserom.gb", $B138, $B148 - $B138

UnknownData_0xB148:
INCBIN "baserom.gb", $B148, $B14C - $B148

LoggedData_0xB14C:
INCBIN "baserom.gb", $B14C, $B152 - $B14C

UnknownData_0xB152:
INCBIN "baserom.gb", $B152, $B154 - $B152

LoggedData_0xB154:
INCBIN "baserom.gb", $B154, $B164 - $B154

UnknownData_0xB164:
INCBIN "baserom.gb", $B164, $B178 - $B164

LoggedData_0xB178:
INCBIN "baserom.gb", $B178, $B17A - $B178

UnknownData_0xB17A:
INCBIN "baserom.gb", $B17A, $B17C - $B17A

LoggedData_0xB17C:
INCBIN "baserom.gb", $B17C, $B190 - $B17C

UnknownData_0xB190:
INCBIN "baserom.gb", $B190, $B198 - $B190

LoggedData_0xB198:
INCBIN "baserom.gb", $B198, $B1A6 - $B198

UnknownData_0xB1A6:
INCBIN "baserom.gb", $B1A6, $B1B8 - $B1A6

LoggedData_0xB1B8:
INCBIN "baserom.gb", $B1B8, $B1C0 - $B1B8

UnknownData_0xB1C0:
INCBIN "baserom.gb", $B1C0, $B1C8 - $B1C0

LoggedData_0xB1C8:
INCBIN "baserom.gb", $B1C8, $B1D2 - $B1C8

UnknownData_0xB1D2:
INCBIN "baserom.gb", $B1D2, $B1D4 - $B1D2

LoggedData_0xB1D4:
INCBIN "baserom.gb", $B1D4, $B1E0 - $B1D4

UnknownData_0xB1E0:
INCBIN "baserom.gb", $B1E0, $B1E2 - $B1E0

LoggedData_0xB1E2:
INCBIN "baserom.gb", $B1E2, $B1E8 - $B1E2

UnknownData_0xB1E8:
INCBIN "baserom.gb", $B1E8, $B1EA - $B1E8

LoggedData_0xB1EA:
INCBIN "baserom.gb", $B1EA, $B1F2 - $B1EA

UnknownData_0xB1F2:
INCBIN "baserom.gb", $B1F2, $B1F4 - $B1F2

LoggedData_0xB1F4:
INCBIN "baserom.gb", $B1F4, $B1F8 - $B1F4

UnknownData_0xB1F8:
INCBIN "baserom.gb", $B1F8, $B1FA - $B1F8

LoggedData_0xB1FA:
INCBIN "baserom.gb", $B1FA, $B204 - $B1FA

UnknownData_0xB204:
INCBIN "baserom.gb", $B204, $B210 - $B204

LoggedData_0xB210:
INCBIN "baserom.gb", $B210, $B212 - $B210

UnknownData_0xB212:
INCBIN "baserom.gb", $B212, $B218 - $B212

LoggedData_0xB218:
INCBIN "baserom.gb", $B218, $B21C - $B218

UnknownData_0xB21C:
INCBIN "baserom.gb", $B21C, $B224 - $B21C

LoggedData_0xB224:
INCBIN "baserom.gb", $B224, $B226 - $B224

UnknownData_0xB226:
INCBIN "baserom.gb", $B226, $B228 - $B226

LoggedData_0xB228:
INCBIN "baserom.gb", $B228, $B22C - $B228

UnknownData_0xB22C:
INCBIN "baserom.gb", $B22C, $B230 - $B22C

LoggedData_0xB230:
INCBIN "baserom.gb", $B230, $B238 - $B230

UnknownData_0xB238:
INCBIN "baserom.gb", $B238, $B23A - $B238

LoggedData_0xB23A:
INCBIN "baserom.gb", $B23A, $B23C - $B23A

UnknownData_0xB23C:
INCBIN "baserom.gb", $B23C, $B23E - $B23C

LoggedData_0xB23E:
INCBIN "baserom.gb", $B23E, $B242 - $B23E

UnknownData_0xB242:
INCBIN "baserom.gb", $B242, $B24E - $B242

LoggedData_0xB24E:
INCBIN "baserom.gb", $B24E, $B250 - $B24E

UnknownData_0xB250:
INCBIN "baserom.gb", $B250, $B256 - $B250

LoggedData_0xB256:
INCBIN "baserom.gb", $B256, $B258 - $B256

UnknownData_0xB258:
INCBIN "baserom.gb", $B258, $B25A - $B258

LoggedData_0xB25A:
INCBIN "baserom.gb", $B25A, $B268 - $B25A

UnknownData_0xB268:
INCBIN "baserom.gb", $B268, $B26A - $B268

LoggedData_0xB26A:
INCBIN "baserom.gb", $B26A, $B26C - $B26A

UnknownData_0xB26C:
INCBIN "baserom.gb", $B26C, $B270 - $B26C

LoggedData_0xB270:
INCBIN "baserom.gb", $B270, $B272 - $B270

UnknownData_0xB272:
INCBIN "baserom.gb", $B272, $B278 - $B272

LoggedData_0xB278:
INCBIN "baserom.gb", $B278, $B27A - $B278

UnknownData_0xB27A:
INCBIN "baserom.gb", $B27A, $B27E - $B27A

LoggedData_0xB27E:
INCBIN "baserom.gb", $B27E, $B290 - $B27E

UnknownData_0xB290:
INCBIN "baserom.gb", $B290, $B292 - $B290

LoggedData_0xB292:
INCBIN "baserom.gb", $B292, $B29E - $B292

UnknownData_0xB29E:
INCBIN "baserom.gb", $B29E, $B2A0 - $B29E

LoggedData_0xB2A0:
INCBIN "baserom.gb", $B2A0, $B2DC - $B2A0

UnknownData_0xB2DC:
INCBIN "baserom.gb", $B2DC, $B2DE - $B2DC

LoggedData_0xB2DE:
INCBIN "baserom.gb", $B2DE, $B2F2 - $B2DE

UnknownData_0xB2F2:
INCBIN "baserom.gb", $B2F2, $B2F6 - $B2F2

LoggedData_0xB2F6:
INCBIN "baserom.gb", $B2F6, $B2FA - $B2F6

UnknownData_0xB2FA:
INCBIN "baserom.gb", $B2FA, $B309 - $B2FA

LoggedData_0xB309:
INCBIN "baserom.gb", $B309, $B31F - $B309

UnknownData_0xB31F:
INCBIN "baserom.gb", $B31F, $B322 - $B31F

LoggedData_0xB322:
INCBIN "baserom.gb", $B322, $B328 - $B322

UnknownData_0xB328:
INCBIN "baserom.gb", $B328, $B32B - $B328

LoggedData_0xB32B:
INCBIN "baserom.gb", $B32B, $B32E - $B32B

UnknownData_0xB32E:
INCBIN "baserom.gb", $B32E, $B334 - $B32E

LoggedData_0xB334:
INCBIN "baserom.gb", $B334, $B342 - $B334

UnknownData_0xB342:
INCBIN "baserom.gb", $B342, $B347 - $B342

LoggedData_0xB347:
INCBIN "baserom.gb", $B347, $B35D - $B347

UnknownData_0xB35D:
INCBIN "baserom.gb", $B35D, $B362 - $B35D

LoggedData_0xB362:
INCBIN "baserom.gb", $B362, $B364 - $B362

UnknownData_0xB364:
INCBIN "baserom.gb", $B364, $B372 - $B364

LoggedData_0xB372:
INCBIN "baserom.gb", $B372, $B3A0 - $B372

UnknownData_0xB3A0:
INCBIN "baserom.gb", $B3A0, $B3A3 - $B3A0

LoggedData_0xB3A3:
INCBIN "baserom.gb", $B3A3, $B3B4 - $B3A3

UnknownData_0xB3B4:
INCBIN "baserom.gb", $B3B4, $B3C5 - $B3B4

LoggedData_0xB3C5:
INCBIN "baserom.gb", $B3C5, $B3D7 - $B3C5

UnknownData_0xB3D7:
INCBIN "baserom.gb", $B3D7, $B3DC - $B3D7

LoggedData_0xB3DC:
INCBIN "baserom.gb", $B3DC, $B3E1 - $B3DC

UnknownData_0xB3E1:
INCBIN "baserom.gb", $B3E1, $B3F7 - $B3E1

LoggedData_0xB3F7:
INCBIN "baserom.gb", $B3F7, $B4E8 - $B3F7

UnknownData_0xB4E8:
INCBIN "baserom.gb", $B4E8, $B4E9 - $B4E8

LoggedData_0xB4E9:
INCBIN "baserom.gb", $B4E9, $B537 - $B4E9

UnknownData_0xB537:
INCBIN "baserom.gb", $B537, $B53B - $B537

LoggedData_0xB53B:
INCBIN "baserom.gb", $B53B, $B583 - $B53B

UnknownData_0xB583:
INCBIN "baserom.gb", $B583, $B584 - $B583

LoggedData_0xB584:
INCBIN "baserom.gb", $B584, $B596 - $B584

UnknownData_0xB596:
INCBIN "baserom.gb", $B596, $B5B0 - $B596

LoggedData_0xB5B0:
INCBIN "baserom.gb", $B5B0, $B5C0 - $B5B0

UnknownData_0xB5C0:
INCBIN "baserom.gb", $B5C0, $B5C2 - $B5C0

LoggedData_0xB5C2:
INCBIN "baserom.gb", $B5C2, $B5CC - $B5C2

UnknownData_0xB5CC:
INCBIN "baserom.gb", $B5CC, $B5CE - $B5CC

LoggedData_0xB5CE:
INCBIN "baserom.gb", $B5CE, $B5D4 - $B5CE

UnknownData_0xB5D4:
INCBIN "baserom.gb", $B5D4, $B5D6 - $B5D4

LoggedData_0xB5D6:
INCBIN "baserom.gb", $B5D6, $B5DA - $B5D6

UnknownData_0xB5DA:
INCBIN "baserom.gb", $B5DA, $B5DC - $B5DA

LoggedData_0xB5DC:
INCBIN "baserom.gb", $B5DC, $B5E2 - $B5DC

UnknownData_0xB5E2:
INCBIN "baserom.gb", $B5E2, $B5E4 - $B5E2

LoggedData_0xB5E4:
INCBIN "baserom.gb", $B5E4, $B5E6 - $B5E4

UnknownData_0xB5E6:
INCBIN "baserom.gb", $B5E6, $B5EE - $B5E6

LoggedData_0xB5EE:
INCBIN "baserom.gb", $B5EE, $B600 - $B5EE

UnknownData_0xB600:
INCBIN "baserom.gb", $B600, $B602 - $B600

LoggedData_0xB602:
INCBIN "baserom.gb", $B602, $B604 - $B602

UnknownData_0xB604:
INCBIN "baserom.gb", $B604, $B612 - $B604

LoggedData_0xB612:
INCBIN "baserom.gb", $B612, $B61E - $B612

UnknownData_0xB61E:
INCBIN "baserom.gb", $B61E, $B620 - $B61E

LoggedData_0xB620:
INCBIN "baserom.gb", $B620, $B622 - $B620

UnknownData_0xB622:
INCBIN "baserom.gb", $B622, $B628 - $B622

LoggedData_0xB628:
INCBIN "baserom.gb", $B628, $B62A - $B628

UnknownData_0xB62A:
INCBIN "baserom.gb", $B62A, $B630 - $B62A

LoggedData_0xB630:
INCBIN "baserom.gb", $B630, $B634 - $B630

UnknownData_0xB634:
INCBIN "baserom.gb", $B634, $B636 - $B634

LoggedData_0xB636:
INCBIN "baserom.gb", $B636, $B665 - $B636

UnknownData_0xB665:
INCBIN "baserom.gb", $B665, $B66E - $B665

LoggedData_0xB66E:
INCBIN "baserom.gb", $B66E, $B685 - $B66E

UnknownData_0xB685:
INCBIN "baserom.gb", $B685, $B68B - $B685

LoggedData_0xB68B:
INCBIN "baserom.gb", $B68B, $B69A - $B68B

UnknownData_0xB69A:
INCBIN "baserom.gb", $B69A, $B69F - $B69A

LoggedData_0xB69F:
INCBIN "baserom.gb", $B69F, $B6A9 - $B69F

UnknownData_0xB6A9:
INCBIN "baserom.gb", $B6A9, $B6AC - $B6A9

LoggedData_0xB6AC:
INCBIN "baserom.gb", $B6AC, $B6B8 - $B6AC

UnknownData_0xB6B8:
INCBIN "baserom.gb", $B6B8, $B6BC - $B6B8

LoggedData_0xB6BC:
INCBIN "baserom.gb", $B6BC, $B6BD - $B6BC

UnknownData_0xB6BD:
INCBIN "baserom.gb", $B6BD, $B6CF - $B6BD

LoggedData_0xB6CF:
INCBIN "baserom.gb", $B6CF, $B6E3 - $B6CF

UnknownData_0xB6E3:
INCBIN "baserom.gb", $B6E3, $B6E4 - $B6E3

LoggedData_0xB6E4:
INCBIN "baserom.gb", $B6E4, $B6E5 - $B6E4

UnknownData_0xB6E5:
INCBIN "baserom.gb", $B6E5, $B6E9 - $B6E5

LoggedData_0xB6E9:
INCBIN "baserom.gb", $B6E9, $B6F0 - $B6E9

UnknownData_0xB6F0:
INCBIN "baserom.gb", $B6F0, $B6F1 - $B6F0

LoggedData_0xB6F1:
INCBIN "baserom.gb", $B6F1, $B703 - $B6F1

UnknownData_0xB703:
INCBIN "baserom.gb", $B703, $B706 - $B703

LoggedData_0xB706:
INCBIN "baserom.gb", $B706, $B715 - $B706

UnknownData_0xB715:
INCBIN "baserom.gb", $B715, $B716 - $B715

LoggedData_0xB716:
INCBIN "baserom.gb", $B716, $B71F - $B716

UnknownData_0xB71F:
INCBIN "baserom.gb", $B71F, $B720 - $B71F

LoggedData_0xB720:
INCBIN "baserom.gb", $B720, $B721 - $B720

UnknownData_0xB721:
INCBIN "baserom.gb", $B721, $B723 - $B721

LoggedData_0xB723:
INCBIN "baserom.gb", $B723, $B728 - $B723

UnknownData_0xB728:
INCBIN "baserom.gb", $B728, $B72D - $B728

LoggedData_0xB72D:
INCBIN "baserom.gb", $B72D, $B733 - $B72D

UnknownData_0xB733:
INCBIN "baserom.gb", $B733, $B735 - $B733

LoggedData_0xB735:
INCBIN "baserom.gb", $B735, $B73D - $B735

UnknownData_0xB73D:
INCBIN "baserom.gb", $B73D, $B73F - $B73D

LoggedData_0xB73F:
INCBIN "baserom.gb", $B73F, $B74D - $B73F

UnknownData_0xB74D:
INCBIN "baserom.gb", $B74D, $C000 - $B74D

SECTION "Bank03", ROMX, BANK[$03]

LoggedData_0xC000:
INCBIN "baserom.gb", $C000, $C008 - $C000

UnknownData_0xC008:
INCBIN "baserom.gb", $C008, $C028 - $C008

LoggedData_0xC028:
INCBIN "baserom.gb", $C028, $C02A - $C028

UnknownData_0xC02A:
INCBIN "baserom.gb", $C02A, $C034 - $C02A

LoggedData_0xC034:
INCBIN "baserom.gb", $C034, $C036 - $C034

UnknownData_0xC036:
INCBIN "baserom.gb", $C036, $C038 - $C036

LoggedData_0xC038:
INCBIN "baserom.gb", $C038, $C03A - $C038

UnknownData_0xC03A:
INCBIN "baserom.gb", $C03A, $C03C - $C03A

LoggedData_0xC03C:
INCBIN "baserom.gb", $C03C, $C058 - $C03C

UnknownData_0xC058:
INCBIN "baserom.gb", $C058, $C07C - $C058

LoggedData_0xC07C:
INCBIN "baserom.gb", $C07C, $C080 - $C07C

UnknownData_0xC080:
INCBIN "baserom.gb", $C080, $C082 - $C080

LoggedData_0xC082:
INCBIN "baserom.gb", $C082, $C08A - $C082

UnknownData_0xC08A:
INCBIN "baserom.gb", $C08A, $C098 - $C08A

LoggedData_0xC098:
INCBIN "baserom.gb", $C098, $C0C0 - $C098

UnknownData_0xC0C0:
INCBIN "baserom.gb", $C0C0, $C0D0 - $C0C0

LoggedData_0xC0D0:
INCBIN "baserom.gb", $C0D0, $C0D8 - $C0D0

UnknownData_0xC0D8:
INCBIN "baserom.gb", $C0D8, $C12C - $C0D8

LoggedData_0xC12C:
INCBIN "baserom.gb", $C12C, $C140 - $C12C

UnknownData_0xC140:
INCBIN "baserom.gb", $C140, $C142 - $C140

LoggedData_0xC142:
INCBIN "baserom.gb", $C142, $C144 - $C142

UnknownData_0xC144:
INCBIN "baserom.gb", $C144, $C14A - $C144

LoggedData_0xC14A:
INCBIN "baserom.gb", $C14A, $C1B9 - $C14A

UnknownData_0xC1B9:
INCBIN "baserom.gb", $C1B9, $C1C2 - $C1B9

LoggedData_0xC1C2:
INCBIN "baserom.gb", $C1C2, $C1CC - $C1C2

UnknownData_0xC1CC:
INCBIN "baserom.gb", $C1CC, $C1D2 - $C1CC

LoggedData_0xC1D2:
INCBIN "baserom.gb", $C1D2, $C23C - $C1D2

UnknownData_0xC23C:
INCBIN "baserom.gb", $C23C, $C26E - $C23C

LoggedData_0xC26E:
INCBIN "baserom.gb", $C26E, $C37A - $C26E

UnknownData_0xC37A:
INCBIN "baserom.gb", $C37A, $C382 - $C37A

LoggedData_0xC382:
INCBIN "baserom.gb", $C382, $C3EC - $C382

UnknownData_0xC3EC:
INCBIN "baserom.gb", $C3EC, $C41E - $C3EC

LoggedData_0xC41E:
INCBIN "baserom.gb", $C41E, $C458 - $C41E

UnknownData_0xC458:
INCBIN "baserom.gb", $C458, $C45A - $C458

LoggedData_0xC45A:
INCBIN "baserom.gb", $C45A, $C52E - $C45A

UnknownData_0xC52E:
INCBIN "baserom.gb", $C52E, $C7C6 - $C52E

LoggedData_0xC7C6:
INCBIN "baserom.gb", $C7C6, $C836 - $C7C6

UnknownData_0xC836:
INCBIN "baserom.gb", $C836, $CC12 - $C836

LoggedData_0xCC12:
INCBIN "baserom.gb", $CC12, $CC18 - $CC12

UnknownData_0xCC18:
INCBIN "baserom.gb", $CC18, $CC1A - $CC18

LoggedData_0xCC1A:
INCBIN "baserom.gb", $CC1A, $CC5F - $CC1A

UnknownData_0xCC5F:
INCBIN "baserom.gb", $CC5F, $CC61 - $CC5F

LoggedData_0xCC61:
INCBIN "baserom.gb", $CC61, $CC72 - $CC61

UnknownData_0xCC72:
INCBIN "baserom.gb", $CC72, $CD15 - $CC72

LoggedData_0xCD15:
INCBIN "baserom.gb", $CD15, $CD63 - $CD15

UnknownData_0xCD63:
INCBIN "baserom.gb", $CD63, $CDB1 - $CD63

LoggedData_0xCDB1:
INCBIN "baserom.gb", $CDB1, $CE07 - $CDB1

UnknownData_0xCE07:
INCBIN "baserom.gb", $CE07, $CE09 - $CE07

LoggedData_0xCE09:
INCBIN "baserom.gb", $CE09, $CE65 - $CE09

UnknownData_0xCE65:
INCBIN "baserom.gb", $CE65, $CE67 - $CE65

LoggedData_0xCE67:
INCBIN "baserom.gb", $CE67, $CF33 - $CE67

UnknownData_0xCF33:
INCBIN "baserom.gb", $CF33, $CF9C - $CF33

LoggedData_0xCF9C:
INCBIN "baserom.gb", $CF9C, $CFA4 - $CF9C

UnknownData_0xCFA4:
INCBIN "baserom.gb", $CFA4, $CFDA - $CFA4

LoggedData_0xCFDA:
INCBIN "baserom.gb", $CFDA, $CFE2 - $CFDA

UnknownData_0xCFE2:
INCBIN "baserom.gb", $CFE2, $D018 - $CFE2

LoggedData_0xD018:
INCBIN "baserom.gb", $D018, $D020 - $D018

UnknownData_0xD020:
INCBIN "baserom.gb", $D020, $D04E - $D020

LoggedData_0xD04E:
INCBIN "baserom.gb", $D04E, $D056 - $D04E

UnknownData_0xD056:
INCBIN "baserom.gb", $D056, $D084 - $D056

LoggedData_0xD084:
INCBIN "baserom.gb", $D084, $D08C - $D084

UnknownData_0xD08C:
INCBIN "baserom.gb", $D08C, $D08E - $D08C

LoggedData_0xD08E:
INCBIN "baserom.gb", $D08E, $D091 - $D08E

UnknownData_0xD091:
INCBIN "baserom.gb", $D091, $D092 - $D091

LoggedData_0xD092:
INCBIN "baserom.gb", $D092, $D095 - $D092

UnknownData_0xD095:
INCBIN "baserom.gb", $D095, $D096 - $D095

LoggedData_0xD096:
INCBIN "baserom.gb", $D096, $D099 - $D096

UnknownData_0xD099:
INCBIN "baserom.gb", $D099, $D09A - $D099

LoggedData_0xD09A:
INCBIN "baserom.gb", $D09A, $D09D - $D09A

UnknownData_0xD09D:
INCBIN "baserom.gb", $D09D, $D09E - $D09D

LoggedData_0xD09E:
INCBIN "baserom.gb", $D09E, $D0A2 - $D09E

UnknownData_0xD0A2:
INCBIN "baserom.gb", $D0A2, $D0A3 - $D0A2

LoggedData_0xD0A3:
INCBIN "baserom.gb", $D0A3, $D0A6 - $D0A3

UnknownData_0xD0A6:
INCBIN "baserom.gb", $D0A6, $D0A7 - $D0A6

LoggedData_0xD0A7:
INCBIN "baserom.gb", $D0A7, $D0AA - $D0A7

UnknownData_0xD0AA:
INCBIN "baserom.gb", $D0AA, $D0AB - $D0AA

LoggedData_0xD0AB:
INCBIN "baserom.gb", $D0AB, $D0AE - $D0AB

UnknownData_0xD0AE:
INCBIN "baserom.gb", $D0AE, $D0AF - $D0AE

LoggedData_0xD0AF:
INCBIN "baserom.gb", $D0AF, $D0B3 - $D0AF

UnknownData_0xD0B3:
INCBIN "baserom.gb", $D0B3, $D0B4 - $D0B3

LoggedData_0xD0B4:
INCBIN "baserom.gb", $D0B4, $D0B7 - $D0B4

UnknownData_0xD0B7:
INCBIN "baserom.gb", $D0B7, $D0B8 - $D0B7

LoggedData_0xD0B8:
INCBIN "baserom.gb", $D0B8, $D0BB - $D0B8

UnknownData_0xD0BB:
INCBIN "baserom.gb", $D0BB, $D0BC - $D0BB

LoggedData_0xD0BC:
INCBIN "baserom.gb", $D0BC, $D0BF - $D0BC

UnknownData_0xD0BF:
INCBIN "baserom.gb", $D0BF, $D0C0 - $D0BF

LoggedData_0xD0C0:
INCBIN "baserom.gb", $D0C0, $D0C4 - $D0C0

UnknownData_0xD0C4:
INCBIN "baserom.gb", $D0C4, $D0C5 - $D0C4

LoggedData_0xD0C5:
INCBIN "baserom.gb", $D0C5, $D0C8 - $D0C5

UnknownData_0xD0C8:
INCBIN "baserom.gb", $D0C8, $D0C9 - $D0C8

LoggedData_0xD0C9:
INCBIN "baserom.gb", $D0C9, $D0CC - $D0C9

UnknownData_0xD0CC:
INCBIN "baserom.gb", $D0CC, $D0CD - $D0CC

LoggedData_0xD0CD:
INCBIN "baserom.gb", $D0CD, $D0D0 - $D0CD

UnknownData_0xD0D0:
INCBIN "baserom.gb", $D0D0, $D0D1 - $D0D0

LoggedData_0xD0D1:
INCBIN "baserom.gb", $D0D1, $D0DA - $D0D1

UnknownData_0xD0DA:
INCBIN "baserom.gb", $D0DA, $D0DC - $D0DA

LoggedData_0xD0DC:
INCBIN "baserom.gb", $D0DC, $D0DF - $D0DC

UnknownData_0xD0DF:
INCBIN "baserom.gb", $D0DF, $D0E0 - $D0DF

LoggedData_0xD0E0:
INCBIN "baserom.gb", $D0E0, $D0E3 - $D0E0

UnknownData_0xD0E3:
INCBIN "baserom.gb", $D0E3, $D0E4 - $D0E3

LoggedData_0xD0E4:
INCBIN "baserom.gb", $D0E4, $D0E7 - $D0E4

UnknownData_0xD0E7:
INCBIN "baserom.gb", $D0E7, $D0E8 - $D0E7

LoggedData_0xD0E8:
INCBIN "baserom.gb", $D0E8, $D0EB - $D0E8

UnknownData_0xD0EB:
INCBIN "baserom.gb", $D0EB, $D0EC - $D0EB

LoggedData_0xD0EC:
INCBIN "baserom.gb", $D0EC, $D0F0 - $D0EC

UnknownData_0xD0F0:
INCBIN "baserom.gb", $D0F0, $D0F1 - $D0F0

LoggedData_0xD0F1:
INCBIN "baserom.gb", $D0F1, $D0F4 - $D0F1

UnknownData_0xD0F4:
INCBIN "baserom.gb", $D0F4, $D0F5 - $D0F4

LoggedData_0xD0F5:
INCBIN "baserom.gb", $D0F5, $D0F8 - $D0F5

UnknownData_0xD0F8:
INCBIN "baserom.gb", $D0F8, $D0F9 - $D0F8

LoggedData_0xD0F9:
INCBIN "baserom.gb", $D0F9, $D0FC - $D0F9

UnknownData_0xD0FC:
INCBIN "baserom.gb", $D0FC, $D0FD - $D0FC

LoggedData_0xD0FD:
INCBIN "baserom.gb", $D0FD, $D101 - $D0FD

UnknownData_0xD101:
INCBIN "baserom.gb", $D101, $D102 - $D101

LoggedData_0xD102:
INCBIN "baserom.gb", $D102, $D105 - $D102

UnknownData_0xD105:
INCBIN "baserom.gb", $D105, $D106 - $D105

LoggedData_0xD106:
INCBIN "baserom.gb", $D106, $D109 - $D106

UnknownData_0xD109:
INCBIN "baserom.gb", $D109, $D10A - $D109

LoggedData_0xD10A:
INCBIN "baserom.gb", $D10A, $D10D - $D10A

UnknownData_0xD10D:
INCBIN "baserom.gb", $D10D, $D10E - $D10D

LoggedData_0xD10E:
INCBIN "baserom.gb", $D10E, $D112 - $D10E

UnknownData_0xD112:
INCBIN "baserom.gb", $D112, $D113 - $D112

LoggedData_0xD113:
INCBIN "baserom.gb", $D113, $D116 - $D113

UnknownData_0xD116:
INCBIN "baserom.gb", $D116, $D117 - $D116

LoggedData_0xD117:
INCBIN "baserom.gb", $D117, $D11A - $D117

UnknownData_0xD11A:
INCBIN "baserom.gb", $D11A, $D11B - $D11A

LoggedData_0xD11B:
INCBIN "baserom.gb", $D11B, $D11E - $D11B

UnknownData_0xD11E:
INCBIN "baserom.gb", $D11E, $D11F - $D11E

LoggedData_0xD11F:
INCBIN "baserom.gb", $D11F, $D128 - $D11F

UnknownData_0xD128:
INCBIN "baserom.gb", $D128, $D12A - $D128

LoggedData_0xD12A:
INCBIN "baserom.gb", $D12A, $D12D - $D12A

UnknownData_0xD12D:
INCBIN "baserom.gb", $D12D, $D12E - $D12D

LoggedData_0xD12E:
INCBIN "baserom.gb", $D12E, $D131 - $D12E

UnknownData_0xD131:
INCBIN "baserom.gb", $D131, $D132 - $D131

LoggedData_0xD132:
INCBIN "baserom.gb", $D132, $D135 - $D132

UnknownData_0xD135:
INCBIN "baserom.gb", $D135, $D136 - $D135

LoggedData_0xD136:
INCBIN "baserom.gb", $D136, $D139 - $D136

UnknownData_0xD139:
INCBIN "baserom.gb", $D139, $D13A - $D139

LoggedData_0xD13A:
INCBIN "baserom.gb", $D13A, $D13E - $D13A

UnknownData_0xD13E:
INCBIN "baserom.gb", $D13E, $D13F - $D13E

LoggedData_0xD13F:
INCBIN "baserom.gb", $D13F, $D142 - $D13F

UnknownData_0xD142:
INCBIN "baserom.gb", $D142, $D143 - $D142

LoggedData_0xD143:
INCBIN "baserom.gb", $D143, $D146 - $D143

UnknownData_0xD146:
INCBIN "baserom.gb", $D146, $D147 - $D146

LoggedData_0xD147:
INCBIN "baserom.gb", $D147, $D14A - $D147

UnknownData_0xD14A:
INCBIN "baserom.gb", $D14A, $D14B - $D14A

LoggedData_0xD14B:
INCBIN "baserom.gb", $D14B, $D14F - $D14B

UnknownData_0xD14F:
INCBIN "baserom.gb", $D14F, $D150 - $D14F

LoggedData_0xD150:
INCBIN "baserom.gb", $D150, $D153 - $D150

UnknownData_0xD153:
INCBIN "baserom.gb", $D153, $D154 - $D153

LoggedData_0xD154:
INCBIN "baserom.gb", $D154, $D157 - $D154

UnknownData_0xD157:
INCBIN "baserom.gb", $D157, $D158 - $D157

LoggedData_0xD158:
INCBIN "baserom.gb", $D158, $D15B - $D158

UnknownData_0xD15B:
INCBIN "baserom.gb", $D15B, $D15C - $D15B

LoggedData_0xD15C:
INCBIN "baserom.gb", $D15C, $D160 - $D15C

UnknownData_0xD160:
INCBIN "baserom.gb", $D160, $D161 - $D160

LoggedData_0xD161:
INCBIN "baserom.gb", $D161, $D164 - $D161

UnknownData_0xD164:
INCBIN "baserom.gb", $D164, $D165 - $D164

LoggedData_0xD165:
INCBIN "baserom.gb", $D165, $D168 - $D165

UnknownData_0xD168:
INCBIN "baserom.gb", $D168, $D169 - $D168

LoggedData_0xD169:
INCBIN "baserom.gb", $D169, $D16C - $D169

UnknownData_0xD16C:
INCBIN "baserom.gb", $D16C, $D16D - $D16C

LoggedData_0xD16D:
INCBIN "baserom.gb", $D16D, $D176 - $D16D

UnknownData_0xD176:
INCBIN "baserom.gb", $D176, $D178 - $D176

LoggedData_0xD178:
INCBIN "baserom.gb", $D178, $D17B - $D178

UnknownData_0xD17B:
INCBIN "baserom.gb", $D17B, $D17C - $D17B

LoggedData_0xD17C:
INCBIN "baserom.gb", $D17C, $D17F - $D17C

UnknownData_0xD17F:
INCBIN "baserom.gb", $D17F, $D180 - $D17F

LoggedData_0xD180:
INCBIN "baserom.gb", $D180, $D183 - $D180

UnknownData_0xD183:
INCBIN "baserom.gb", $D183, $D184 - $D183

LoggedData_0xD184:
INCBIN "baserom.gb", $D184, $D187 - $D184

UnknownData_0xD187:
INCBIN "baserom.gb", $D187, $D188 - $D187

LoggedData_0xD188:
INCBIN "baserom.gb", $D188, $D18C - $D188

UnknownData_0xD18C:
INCBIN "baserom.gb", $D18C, $D18D - $D18C

LoggedData_0xD18D:
INCBIN "baserom.gb", $D18D, $D190 - $D18D

UnknownData_0xD190:
INCBIN "baserom.gb", $D190, $D191 - $D190

LoggedData_0xD191:
INCBIN "baserom.gb", $D191, $D194 - $D191

UnknownData_0xD194:
INCBIN "baserom.gb", $D194, $D195 - $D194

LoggedData_0xD195:
INCBIN "baserom.gb", $D195, $D198 - $D195

UnknownData_0xD198:
INCBIN "baserom.gb", $D198, $D199 - $D198

LoggedData_0xD199:
INCBIN "baserom.gb", $D199, $D19D - $D199

UnknownData_0xD19D:
INCBIN "baserom.gb", $D19D, $D19E - $D19D

LoggedData_0xD19E:
INCBIN "baserom.gb", $D19E, $D1A1 - $D19E

UnknownData_0xD1A1:
INCBIN "baserom.gb", $D1A1, $D1A2 - $D1A1

LoggedData_0xD1A2:
INCBIN "baserom.gb", $D1A2, $D1A5 - $D1A2

UnknownData_0xD1A5:
INCBIN "baserom.gb", $D1A5, $D1A6 - $D1A5

LoggedData_0xD1A6:
INCBIN "baserom.gb", $D1A6, $D1A9 - $D1A6

UnknownData_0xD1A9:
INCBIN "baserom.gb", $D1A9, $D1AA - $D1A9

LoggedData_0xD1AA:
INCBIN "baserom.gb", $D1AA, $D1AE - $D1AA

UnknownData_0xD1AE:
INCBIN "baserom.gb", $D1AE, $D1AF - $D1AE

LoggedData_0xD1AF:
INCBIN "baserom.gb", $D1AF, $D1B2 - $D1AF

UnknownData_0xD1B2:
INCBIN "baserom.gb", $D1B2, $D1B3 - $D1B2

LoggedData_0xD1B3:
INCBIN "baserom.gb", $D1B3, $D1B6 - $D1B3

UnknownData_0xD1B6:
INCBIN "baserom.gb", $D1B6, $D1B7 - $D1B6

LoggedData_0xD1B7:
INCBIN "baserom.gb", $D1B7, $D1BA - $D1B7

UnknownData_0xD1BA:
INCBIN "baserom.gb", $D1BA, $D1BB - $D1BA

LoggedData_0xD1BB:
INCBIN "baserom.gb", $D1BB, $D1C4 - $D1BB

UnknownData_0xD1C4:
INCBIN "baserom.gb", $D1C4, $D1C6 - $D1C4

LoggedData_0xD1C6:
INCBIN "baserom.gb", $D1C6, $D1C9 - $D1C6

UnknownData_0xD1C9:
INCBIN "baserom.gb", $D1C9, $D1CA - $D1C9

LoggedData_0xD1CA:
INCBIN "baserom.gb", $D1CA, $D1CD - $D1CA

UnknownData_0xD1CD:
INCBIN "baserom.gb", $D1CD, $D1CE - $D1CD

LoggedData_0xD1CE:
INCBIN "baserom.gb", $D1CE, $D1D1 - $D1CE

UnknownData_0xD1D1:
INCBIN "baserom.gb", $D1D1, $D1D2 - $D1D1

LoggedData_0xD1D2:
INCBIN "baserom.gb", $D1D2, $D1D5 - $D1D2

UnknownData_0xD1D5:
INCBIN "baserom.gb", $D1D5, $D1D6 - $D1D5

LoggedData_0xD1D6:
INCBIN "baserom.gb", $D1D6, $D1DA - $D1D6

UnknownData_0xD1DA:
INCBIN "baserom.gb", $D1DA, $D1DB - $D1DA

LoggedData_0xD1DB:
INCBIN "baserom.gb", $D1DB, $D1DE - $D1DB

UnknownData_0xD1DE:
INCBIN "baserom.gb", $D1DE, $D1DF - $D1DE

LoggedData_0xD1DF:
INCBIN "baserom.gb", $D1DF, $D1E2 - $D1DF

UnknownData_0xD1E2:
INCBIN "baserom.gb", $D1E2, $D1E3 - $D1E2

LoggedData_0xD1E3:
INCBIN "baserom.gb", $D1E3, $D1E6 - $D1E3

UnknownData_0xD1E6:
INCBIN "baserom.gb", $D1E6, $D1E7 - $D1E6

LoggedData_0xD1E7:
INCBIN "baserom.gb", $D1E7, $D1EA - $D1E7

UnknownData_0xD1EA:
INCBIN "baserom.gb", $D1EA, $D1EB - $D1EA

LoggedData_0xD1EB:
INCBIN "baserom.gb", $D1EB, $D1EF - $D1EB

UnknownData_0xD1EF:
INCBIN "baserom.gb", $D1EF, $D1F0 - $D1EF

LoggedData_0xD1F0:
INCBIN "baserom.gb", $D1F0, $D1F3 - $D1F0

UnknownData_0xD1F3:
INCBIN "baserom.gb", $D1F3, $D1F4 - $D1F3

LoggedData_0xD1F4:
INCBIN "baserom.gb", $D1F4, $D1F7 - $D1F4

UnknownData_0xD1F7:
INCBIN "baserom.gb", $D1F7, $D1F8 - $D1F7

LoggedData_0xD1F8:
INCBIN "baserom.gb", $D1F8, $D1FB - $D1F8

UnknownData_0xD1FB:
INCBIN "baserom.gb", $D1FB, $D1FC - $D1FB

LoggedData_0xD1FC:
INCBIN "baserom.gb", $D1FC, $D200 - $D1FC

UnknownData_0xD200:
INCBIN "baserom.gb", $D200, $D201 - $D200

LoggedData_0xD201:
INCBIN "baserom.gb", $D201, $D204 - $D201

UnknownData_0xD204:
INCBIN "baserom.gb", $D204, $D205 - $D204

LoggedData_0xD205:
INCBIN "baserom.gb", $D205, $D208 - $D205

UnknownData_0xD208:
INCBIN "baserom.gb", $D208, $D209 - $D208

LoggedData_0xD209:
INCBIN "baserom.gb", $D209, $D20C - $D209

UnknownData_0xD20C:
INCBIN "baserom.gb", $D20C, $D20D - $D20C

LoggedData_0xD20D:
INCBIN "baserom.gb", $D20D, $D210 - $D20D

UnknownData_0xD210:
INCBIN "baserom.gb", $D210, $D211 - $D210

LoggedData_0xD211:
INCBIN "baserom.gb", $D211, $D21A - $D211

UnknownData_0xD21A:
INCBIN "baserom.gb", $D21A, $D21C - $D21A

LoggedData_0xD21C:
INCBIN "baserom.gb", $D21C, $D21F - $D21C

UnknownData_0xD21F:
INCBIN "baserom.gb", $D21F, $D220 - $D21F

LoggedData_0xD220:
INCBIN "baserom.gb", $D220, $D223 - $D220

UnknownData_0xD223:
INCBIN "baserom.gb", $D223, $D224 - $D223

LoggedData_0xD224:
INCBIN "baserom.gb", $D224, $D227 - $D224

UnknownData_0xD227:
INCBIN "baserom.gb", $D227, $D228 - $D227

LoggedData_0xD228:
INCBIN "baserom.gb", $D228, $D22B - $D228

UnknownData_0xD22B:
INCBIN "baserom.gb", $D22B, $D22C - $D22B

LoggedData_0xD22C:
INCBIN "baserom.gb", $D22C, $D230 - $D22C

UnknownData_0xD230:
INCBIN "baserom.gb", $D230, $D231 - $D230

LoggedData_0xD231:
INCBIN "baserom.gb", $D231, $D234 - $D231

UnknownData_0xD234:
INCBIN "baserom.gb", $D234, $D235 - $D234

LoggedData_0xD235:
INCBIN "baserom.gb", $D235, $D238 - $D235

UnknownData_0xD238:
INCBIN "baserom.gb", $D238, $D239 - $D238

LoggedData_0xD239:
INCBIN "baserom.gb", $D239, $D23C - $D239

UnknownData_0xD23C:
INCBIN "baserom.gb", $D23C, $D23D - $D23C

LoggedData_0xD23D:
INCBIN "baserom.gb", $D23D, $D240 - $D23D

UnknownData_0xD240:
INCBIN "baserom.gb", $D240, $D241 - $D240

LoggedData_0xD241:
INCBIN "baserom.gb", $D241, $D245 - $D241

UnknownData_0xD245:
INCBIN "baserom.gb", $D245, $D246 - $D245

LoggedData_0xD246:
INCBIN "baserom.gb", $D246, $D249 - $D246

UnknownData_0xD249:
INCBIN "baserom.gb", $D249, $D24A - $D249

LoggedData_0xD24A:
INCBIN "baserom.gb", $D24A, $D24D - $D24A

UnknownData_0xD24D:
INCBIN "baserom.gb", $D24D, $D24E - $D24D

LoggedData_0xD24E:
INCBIN "baserom.gb", $D24E, $D251 - $D24E

UnknownData_0xD251:
INCBIN "baserom.gb", $D251, $D252 - $D251

LoggedData_0xD252:
INCBIN "baserom.gb", $D252, $D256 - $D252

UnknownData_0xD256:
INCBIN "baserom.gb", $D256, $D257 - $D256

LoggedData_0xD257:
INCBIN "baserom.gb", $D257, $D25A - $D257

UnknownData_0xD25A:
INCBIN "baserom.gb", $D25A, $D25B - $D25A

LoggedData_0xD25B:
INCBIN "baserom.gb", $D25B, $D25E - $D25B

UnknownData_0xD25E:
INCBIN "baserom.gb", $D25E, $D25F - $D25E

LoggedData_0xD25F:
INCBIN "baserom.gb", $D25F, $D262 - $D25F

UnknownData_0xD262:
INCBIN "baserom.gb", $D262, $D263 - $D262

LoggedData_0xD263:
INCBIN "baserom.gb", $D263, $D266 - $D263

UnknownData_0xD266:
INCBIN "baserom.gb", $D266, $D267 - $D266

LoggedData_0xD267:
INCBIN "baserom.gb", $D267, $D270 - $D267

UnknownData_0xD270:
INCBIN "baserom.gb", $D270, $D272 - $D270

LoggedData_0xD272:
INCBIN "baserom.gb", $D272, $D275 - $D272

UnknownData_0xD275:
INCBIN "baserom.gb", $D275, $D276 - $D275

LoggedData_0xD276:
INCBIN "baserom.gb", $D276, $D279 - $D276

UnknownData_0xD279:
INCBIN "baserom.gb", $D279, $D27A - $D279

LoggedData_0xD27A:
INCBIN "baserom.gb", $D27A, $D27D - $D27A

UnknownData_0xD27D:
INCBIN "baserom.gb", $D27D, $D27E - $D27D

LoggedData_0xD27E:
INCBIN "baserom.gb", $D27E, $D281 - $D27E

UnknownData_0xD281:
INCBIN "baserom.gb", $D281, $D282 - $D281

LoggedData_0xD282:
INCBIN "baserom.gb", $D282, $D286 - $D282

UnknownData_0xD286:
INCBIN "baserom.gb", $D286, $D287 - $D286

LoggedData_0xD287:
INCBIN "baserom.gb", $D287, $D28A - $D287

UnknownData_0xD28A:
INCBIN "baserom.gb", $D28A, $D28B - $D28A

LoggedData_0xD28B:
INCBIN "baserom.gb", $D28B, $D28E - $D28B

UnknownData_0xD28E:
INCBIN "baserom.gb", $D28E, $D28F - $D28E

LoggedData_0xD28F:
INCBIN "baserom.gb", $D28F, $D292 - $D28F

UnknownData_0xD292:
INCBIN "baserom.gb", $D292, $D293 - $D292

LoggedData_0xD293:
INCBIN "baserom.gb", $D293, $D296 - $D293

UnknownData_0xD296:
INCBIN "baserom.gb", $D296, $D297 - $D296

LoggedData_0xD297:
INCBIN "baserom.gb", $D297, $D29B - $D297

UnknownData_0xD29B:
INCBIN "baserom.gb", $D29B, $D29C - $D29B

LoggedData_0xD29C:
INCBIN "baserom.gb", $D29C, $D29F - $D29C

UnknownData_0xD29F:
INCBIN "baserom.gb", $D29F, $D2A0 - $D29F

LoggedData_0xD2A0:
INCBIN "baserom.gb", $D2A0, $D2A3 - $D2A0

UnknownData_0xD2A3:
INCBIN "baserom.gb", $D2A3, $D2A4 - $D2A3

LoggedData_0xD2A4:
INCBIN "baserom.gb", $D2A4, $D2A7 - $D2A4

UnknownData_0xD2A7:
INCBIN "baserom.gb", $D2A7, $D2A8 - $D2A7

LoggedData_0xD2A8:
INCBIN "baserom.gb", $D2A8, $D2AC - $D2A8

UnknownData_0xD2AC:
INCBIN "baserom.gb", $D2AC, $D2AD - $D2AC

LoggedData_0xD2AD:
INCBIN "baserom.gb", $D2AD, $D2B0 - $D2AD

UnknownData_0xD2B0:
INCBIN "baserom.gb", $D2B0, $D2B1 - $D2B0

LoggedData_0xD2B1:
INCBIN "baserom.gb", $D2B1, $D2B4 - $D2B1

UnknownData_0xD2B4:
INCBIN "baserom.gb", $D2B4, $D2B5 - $D2B4

LoggedData_0xD2B5:
INCBIN "baserom.gb", $D2B5, $D2B8 - $D2B5

UnknownData_0xD2B8:
INCBIN "baserom.gb", $D2B8, $D2B9 - $D2B8

LoggedData_0xD2B9:
INCBIN "baserom.gb", $D2B9, $D2BC - $D2B9

UnknownData_0xD2BC:
INCBIN "baserom.gb", $D2BC, $D2BD - $D2BC

LoggedData_0xD2BD:
INCBIN "baserom.gb", $D2BD, $D2C6 - $D2BD

UnknownData_0xD2C6:
INCBIN "baserom.gb", $D2C6, $D2C8 - $D2C6

LoggedData_0xD2C8:
INCBIN "baserom.gb", $D2C8, $D2CB - $D2C8

UnknownData_0xD2CB:
INCBIN "baserom.gb", $D2CB, $D2CC - $D2CB

LoggedData_0xD2CC:
INCBIN "baserom.gb", $D2CC, $D2CF - $D2CC

UnknownData_0xD2CF:
INCBIN "baserom.gb", $D2CF, $D2D0 - $D2CF

LoggedData_0xD2D0:
INCBIN "baserom.gb", $D2D0, $D2D3 - $D2D0

UnknownData_0xD2D3:
INCBIN "baserom.gb", $D2D3, $D2D4 - $D2D3

LoggedData_0xD2D4:
INCBIN "baserom.gb", $D2D4, $D2D7 - $D2D4

UnknownData_0xD2D7:
INCBIN "baserom.gb", $D2D7, $D2D8 - $D2D7

LoggedData_0xD2D8:
INCBIN "baserom.gb", $D2D8, $D2DC - $D2D8

UnknownData_0xD2DC:
INCBIN "baserom.gb", $D2DC, $D2DD - $D2DC

LoggedData_0xD2DD:
INCBIN "baserom.gb", $D2DD, $D2E0 - $D2DD

UnknownData_0xD2E0:
INCBIN "baserom.gb", $D2E0, $D2E1 - $D2E0

LoggedData_0xD2E1:
INCBIN "baserom.gb", $D2E1, $D2E4 - $D2E1

UnknownData_0xD2E4:
INCBIN "baserom.gb", $D2E4, $D2E5 - $D2E4

LoggedData_0xD2E5:
INCBIN "baserom.gb", $D2E5, $D2E8 - $D2E5

UnknownData_0xD2E8:
INCBIN "baserom.gb", $D2E8, $D2E9 - $D2E8

LoggedData_0xD2E9:
INCBIN "baserom.gb", $D2E9, $D2EC - $D2E9

UnknownData_0xD2EC:
INCBIN "baserom.gb", $D2EC, $D2ED - $D2EC

LoggedData_0xD2ED:
INCBIN "baserom.gb", $D2ED, $D2F1 - $D2ED

UnknownData_0xD2F1:
INCBIN "baserom.gb", $D2F1, $D2F2 - $D2F1

LoggedData_0xD2F2:
INCBIN "baserom.gb", $D2F2, $D2F5 - $D2F2

UnknownData_0xD2F5:
INCBIN "baserom.gb", $D2F5, $D2F6 - $D2F5

LoggedData_0xD2F6:
INCBIN "baserom.gb", $D2F6, $D2F9 - $D2F6

UnknownData_0xD2F9:
INCBIN "baserom.gb", $D2F9, $D2FA - $D2F9

LoggedData_0xD2FA:
INCBIN "baserom.gb", $D2FA, $D2FD - $D2FA

UnknownData_0xD2FD:
INCBIN "baserom.gb", $D2FD, $D2FE - $D2FD

LoggedData_0xD2FE:
INCBIN "baserom.gb", $D2FE, $D302 - $D2FE

UnknownData_0xD302:
INCBIN "baserom.gb", $D302, $D303 - $D302

LoggedData_0xD303:
INCBIN "baserom.gb", $D303, $D306 - $D303

UnknownData_0xD306:
INCBIN "baserom.gb", $D306, $D307 - $D306

LoggedData_0xD307:
INCBIN "baserom.gb", $D307, $D30A - $D307

UnknownData_0xD30A:
INCBIN "baserom.gb", $D30A, $D30B - $D30A

LoggedData_0xD30B:
INCBIN "baserom.gb", $D30B, $D30E - $D30B

UnknownData_0xD30E:
INCBIN "baserom.gb", $D30E, $D30F - $D30E

LoggedData_0xD30F:
INCBIN "baserom.gb", $D30F, $D312 - $D30F

UnknownData_0xD312:
INCBIN "baserom.gb", $D312, $D313 - $D312

LoggedData_0xD313:
INCBIN "baserom.gb", $D313, $D31C - $D313

UnknownData_0xD31C:
INCBIN "baserom.gb", $D31C, $D31E - $D31C

LoggedData_0xD31E:
INCBIN "baserom.gb", $D31E, $D321 - $D31E

UnknownData_0xD321:
INCBIN "baserom.gb", $D321, $D322 - $D321

LoggedData_0xD322:
INCBIN "baserom.gb", $D322, $D325 - $D322

UnknownData_0xD325:
INCBIN "baserom.gb", $D325, $D326 - $D325

LoggedData_0xD326:
INCBIN "baserom.gb", $D326, $D329 - $D326

UnknownData_0xD329:
INCBIN "baserom.gb", $D329, $D32A - $D329

LoggedData_0xD32A:
INCBIN "baserom.gb", $D32A, $D32D - $D32A

UnknownData_0xD32D:
INCBIN "baserom.gb", $D32D, $D32E - $D32D

LoggedData_0xD32E:
INCBIN "baserom.gb", $D32E, $D332 - $D32E

UnknownData_0xD332:
INCBIN "baserom.gb", $D332, $D333 - $D332

LoggedData_0xD333:
INCBIN "baserom.gb", $D333, $D336 - $D333

UnknownData_0xD336:
INCBIN "baserom.gb", $D336, $D337 - $D336

LoggedData_0xD337:
INCBIN "baserom.gb", $D337, $D33A - $D337

UnknownData_0xD33A:
INCBIN "baserom.gb", $D33A, $D33B - $D33A

LoggedData_0xD33B:
INCBIN "baserom.gb", $D33B, $D33E - $D33B

UnknownData_0xD33E:
INCBIN "baserom.gb", $D33E, $D33F - $D33E

LoggedData_0xD33F:
INCBIN "baserom.gb", $D33F, $D343 - $D33F

UnknownData_0xD343:
INCBIN "baserom.gb", $D343, $D344 - $D343

LoggedData_0xD344:
INCBIN "baserom.gb", $D344, $D347 - $D344

UnknownData_0xD347:
INCBIN "baserom.gb", $D347, $D348 - $D347

LoggedData_0xD348:
INCBIN "baserom.gb", $D348, $D34B - $D348

UnknownData_0xD34B:
INCBIN "baserom.gb", $D34B, $D34C - $D34B

LoggedData_0xD34C:
INCBIN "baserom.gb", $D34C, $D34F - $D34C

UnknownData_0xD34F:
INCBIN "baserom.gb", $D34F, $D350 - $D34F

LoggedData_0xD350:
INCBIN "baserom.gb", $D350, $D354 - $D350

UnknownData_0xD354:
INCBIN "baserom.gb", $D354, $D355 - $D354

LoggedData_0xD355:
INCBIN "baserom.gb", $D355, $D358 - $D355

UnknownData_0xD358:
INCBIN "baserom.gb", $D358, $D359 - $D358

LoggedData_0xD359:
INCBIN "baserom.gb", $D359, $D35C - $D359

UnknownData_0xD35C:
INCBIN "baserom.gb", $D35C, $D35D - $D35C

LoggedData_0xD35D:
INCBIN "baserom.gb", $D35D, $D360 - $D35D

UnknownData_0xD360:
INCBIN "baserom.gb", $D360, $D361 - $D360

LoggedData_0xD361:
INCBIN "baserom.gb", $D361, $D36A - $D361

UnknownData_0xD36A:
INCBIN "baserom.gb", $D36A, $D36C - $D36A

LoggedData_0xD36C:
INCBIN "baserom.gb", $D36C, $D36F - $D36C

UnknownData_0xD36F:
INCBIN "baserom.gb", $D36F, $D370 - $D36F

LoggedData_0xD370:
INCBIN "baserom.gb", $D370, $D373 - $D370

UnknownData_0xD373:
INCBIN "baserom.gb", $D373, $D374 - $D373

LoggedData_0xD374:
INCBIN "baserom.gb", $D374, $D377 - $D374

UnknownData_0xD377:
INCBIN "baserom.gb", $D377, $D378 - $D377

LoggedData_0xD378:
INCBIN "baserom.gb", $D378, $D37B - $D378

UnknownData_0xD37B:
INCBIN "baserom.gb", $D37B, $D37C - $D37B

LoggedData_0xD37C:
INCBIN "baserom.gb", $D37C, $D380 - $D37C

UnknownData_0xD380:
INCBIN "baserom.gb", $D380, $D381 - $D380

LoggedData_0xD381:
INCBIN "baserom.gb", $D381, $D384 - $D381

UnknownData_0xD384:
INCBIN "baserom.gb", $D384, $D385 - $D384

LoggedData_0xD385:
INCBIN "baserom.gb", $D385, $D388 - $D385

UnknownData_0xD388:
INCBIN "baserom.gb", $D388, $D389 - $D388

LoggedData_0xD389:
INCBIN "baserom.gb", $D389, $D38C - $D389

UnknownData_0xD38C:
INCBIN "baserom.gb", $D38C, $D38D - $D38C

LoggedData_0xD38D:
INCBIN "baserom.gb", $D38D, $D391 - $D38D

UnknownData_0xD391:
INCBIN "baserom.gb", $D391, $D392 - $D391

LoggedData_0xD392:
INCBIN "baserom.gb", $D392, $D395 - $D392

UnknownData_0xD395:
INCBIN "baserom.gb", $D395, $D396 - $D395

LoggedData_0xD396:
INCBIN "baserom.gb", $D396, $D399 - $D396

UnknownData_0xD399:
INCBIN "baserom.gb", $D399, $D39A - $D399

LoggedData_0xD39A:
INCBIN "baserom.gb", $D39A, $D39D - $D39A

UnknownData_0xD39D:
INCBIN "baserom.gb", $D39D, $D39E - $D39D

LoggedData_0xD39E:
INCBIN "baserom.gb", $D39E, $D3A2 - $D39E

UnknownData_0xD3A2:
INCBIN "baserom.gb", $D3A2, $D3A3 - $D3A2

LoggedData_0xD3A3:
INCBIN "baserom.gb", $D3A3, $D3A6 - $D3A3

UnknownData_0xD3A6:
INCBIN "baserom.gb", $D3A6, $D3A7 - $D3A6

LoggedData_0xD3A7:
INCBIN "baserom.gb", $D3A7, $D3AA - $D3A7

UnknownData_0xD3AA:
INCBIN "baserom.gb", $D3AA, $D3AB - $D3AA

LoggedData_0xD3AB:
INCBIN "baserom.gb", $D3AB, $D3AE - $D3AB

UnknownData_0xD3AE:
INCBIN "baserom.gb", $D3AE, $D3AF - $D3AE

LoggedData_0xD3AF:
INCBIN "baserom.gb", $D3AF, $D3B8 - $D3AF

UnknownData_0xD3B8:
INCBIN "baserom.gb", $D3B8, $D3BA - $D3B8

LoggedData_0xD3BA:
INCBIN "baserom.gb", $D3BA, $D3BD - $D3BA

UnknownData_0xD3BD:
INCBIN "baserom.gb", $D3BD, $D3BE - $D3BD

LoggedData_0xD3BE:
INCBIN "baserom.gb", $D3BE, $D3C1 - $D3BE

UnknownData_0xD3C1:
INCBIN "baserom.gb", $D3C1, $D3C2 - $D3C1

LoggedData_0xD3C2:
INCBIN "baserom.gb", $D3C2, $D3C5 - $D3C2

UnknownData_0xD3C5:
INCBIN "baserom.gb", $D3C5, $D3C6 - $D3C5

LoggedData_0xD3C6:
INCBIN "baserom.gb", $D3C6, $D3C9 - $D3C6

UnknownData_0xD3C9:
INCBIN "baserom.gb", $D3C9, $D3CA - $D3C9

LoggedData_0xD3CA:
INCBIN "baserom.gb", $D3CA, $D3CE - $D3CA

UnknownData_0xD3CE:
INCBIN "baserom.gb", $D3CE, $D3CF - $D3CE

LoggedData_0xD3CF:
INCBIN "baserom.gb", $D3CF, $D3D2 - $D3CF

UnknownData_0xD3D2:
INCBIN "baserom.gb", $D3D2, $D3D3 - $D3D2

LoggedData_0xD3D3:
INCBIN "baserom.gb", $D3D3, $D3D6 - $D3D3

UnknownData_0xD3D6:
INCBIN "baserom.gb", $D3D6, $D3D7 - $D3D6

LoggedData_0xD3D7:
INCBIN "baserom.gb", $D3D7, $D3DA - $D3D7

UnknownData_0xD3DA:
INCBIN "baserom.gb", $D3DA, $D3DB - $D3DA

LoggedData_0xD3DB:
INCBIN "baserom.gb", $D3DB, $D3DF - $D3DB

UnknownData_0xD3DF:
INCBIN "baserom.gb", $D3DF, $D3E0 - $D3DF

LoggedData_0xD3E0:
INCBIN "baserom.gb", $D3E0, $D3E3 - $D3E0

UnknownData_0xD3E3:
INCBIN "baserom.gb", $D3E3, $D3E4 - $D3E3

LoggedData_0xD3E4:
INCBIN "baserom.gb", $D3E4, $D3E7 - $D3E4

UnknownData_0xD3E7:
INCBIN "baserom.gb", $D3E7, $D3E8 - $D3E7

LoggedData_0xD3E8:
INCBIN "baserom.gb", $D3E8, $D3EB - $D3E8

UnknownData_0xD3EB:
INCBIN "baserom.gb", $D3EB, $D3EC - $D3EB

LoggedData_0xD3EC:
INCBIN "baserom.gb", $D3EC, $D3F0 - $D3EC

UnknownData_0xD3F0:
INCBIN "baserom.gb", $D3F0, $D3F1 - $D3F0

LoggedData_0xD3F1:
INCBIN "baserom.gb", $D3F1, $D3F4 - $D3F1

UnknownData_0xD3F4:
INCBIN "baserom.gb", $D3F4, $D3F5 - $D3F4

LoggedData_0xD3F5:
INCBIN "baserom.gb", $D3F5, $D3F8 - $D3F5

UnknownData_0xD3F8:
INCBIN "baserom.gb", $D3F8, $D3F9 - $D3F8

LoggedData_0xD3F9:
INCBIN "baserom.gb", $D3F9, $D3FC - $D3F9

UnknownData_0xD3FC:
INCBIN "baserom.gb", $D3FC, $D3FD - $D3FC

LoggedData_0xD3FD:
INCBIN "baserom.gb", $D3FD, $D406 - $D3FD

UnknownData_0xD406:
INCBIN "baserom.gb", $D406, $D408 - $D406

LoggedData_0xD408:
INCBIN "baserom.gb", $D408, $D40B - $D408

UnknownData_0xD40B:
INCBIN "baserom.gb", $D40B, $D40C - $D40B

LoggedData_0xD40C:
INCBIN "baserom.gb", $D40C, $D40F - $D40C

UnknownData_0xD40F:
INCBIN "baserom.gb", $D40F, $D410 - $D40F

LoggedData_0xD410:
INCBIN "baserom.gb", $D410, $D413 - $D410

UnknownData_0xD413:
INCBIN "baserom.gb", $D413, $D414 - $D413

LoggedData_0xD414:
INCBIN "baserom.gb", $D414, $D417 - $D414

UnknownData_0xD417:
INCBIN "baserom.gb", $D417, $D418 - $D417

LoggedData_0xD418:
INCBIN "baserom.gb", $D418, $D41C - $D418

UnknownData_0xD41C:
INCBIN "baserom.gb", $D41C, $D41D - $D41C

LoggedData_0xD41D:
INCBIN "baserom.gb", $D41D, $D420 - $D41D

UnknownData_0xD420:
INCBIN "baserom.gb", $D420, $D421 - $D420

LoggedData_0xD421:
INCBIN "baserom.gb", $D421, $D424 - $D421

UnknownData_0xD424:
INCBIN "baserom.gb", $D424, $D425 - $D424

LoggedData_0xD425:
INCBIN "baserom.gb", $D425, $D428 - $D425

UnknownData_0xD428:
INCBIN "baserom.gb", $D428, $D429 - $D428

LoggedData_0xD429:
INCBIN "baserom.gb", $D429, $D42D - $D429

UnknownData_0xD42D:
INCBIN "baserom.gb", $D42D, $D42E - $D42D

LoggedData_0xD42E:
INCBIN "baserom.gb", $D42E, $D431 - $D42E

UnknownData_0xD431:
INCBIN "baserom.gb", $D431, $D432 - $D431

LoggedData_0xD432:
INCBIN "baserom.gb", $D432, $D435 - $D432

UnknownData_0xD435:
INCBIN "baserom.gb", $D435, $D436 - $D435

LoggedData_0xD436:
INCBIN "baserom.gb", $D436, $D439 - $D436

UnknownData_0xD439:
INCBIN "baserom.gb", $D439, $D43A - $D439

LoggedData_0xD43A:
INCBIN "baserom.gb", $D43A, $D43E - $D43A

UnknownData_0xD43E:
INCBIN "baserom.gb", $D43E, $D43F - $D43E

LoggedData_0xD43F:
INCBIN "baserom.gb", $D43F, $D442 - $D43F

UnknownData_0xD442:
INCBIN "baserom.gb", $D442, $D443 - $D442

LoggedData_0xD443:
INCBIN "baserom.gb", $D443, $D446 - $D443

UnknownData_0xD446:
INCBIN "baserom.gb", $D446, $D447 - $D446

LoggedData_0xD447:
INCBIN "baserom.gb", $D447, $D44A - $D447

UnknownData_0xD44A:
INCBIN "baserom.gb", $D44A, $D44B - $D44A

LoggedData_0xD44B:
INCBIN "baserom.gb", $D44B, $D454 - $D44B

UnknownData_0xD454:
INCBIN "baserom.gb", $D454, $D456 - $D454

LoggedData_0xD456:
INCBIN "baserom.gb", $D456, $D459 - $D456

UnknownData_0xD459:
INCBIN "baserom.gb", $D459, $D45A - $D459

LoggedData_0xD45A:
INCBIN "baserom.gb", $D45A, $D45D - $D45A

UnknownData_0xD45D:
INCBIN "baserom.gb", $D45D, $D45E - $D45D

LoggedData_0xD45E:
INCBIN "baserom.gb", $D45E, $D461 - $D45E

UnknownData_0xD461:
INCBIN "baserom.gb", $D461, $D462 - $D461

LoggedData_0xD462:
INCBIN "baserom.gb", $D462, $D465 - $D462

UnknownData_0xD465:
INCBIN "baserom.gb", $D465, $D466 - $D465

LoggedData_0xD466:
INCBIN "baserom.gb", $D466, $D469 - $D466

UnknownData_0xD469:
INCBIN "baserom.gb", $D469, $D46A - $D469

LoggedData_0xD46A:
INCBIN "baserom.gb", $D46A, $D46D - $D46A

UnknownData_0xD46D:
INCBIN "baserom.gb", $D46D, $D46E - $D46D

LoggedData_0xD46E:
INCBIN "baserom.gb", $D46E, $D472 - $D46E

UnknownData_0xD472:
INCBIN "baserom.gb", $D472, $D473 - $D472

LoggedData_0xD473:
INCBIN "baserom.gb", $D473, $D476 - $D473

UnknownData_0xD476:
INCBIN "baserom.gb", $D476, $D477 - $D476

LoggedData_0xD477:
INCBIN "baserom.gb", $D477, $D47A - $D477

UnknownData_0xD47A:
INCBIN "baserom.gb", $D47A, $D47B - $D47A

LoggedData_0xD47B:
INCBIN "baserom.gb", $D47B, $D47E - $D47B

UnknownData_0xD47E:
INCBIN "baserom.gb", $D47E, $D47F - $D47E

LoggedData_0xD47F:
INCBIN "baserom.gb", $D47F, $D483 - $D47F

UnknownData_0xD483:
INCBIN "baserom.gb", $D483, $D484 - $D483

LoggedData_0xD484:
INCBIN "baserom.gb", $D484, $D487 - $D484

UnknownData_0xD487:
INCBIN "baserom.gb", $D487, $D488 - $D487

LoggedData_0xD488:
INCBIN "baserom.gb", $D488, $D48B - $D488

UnknownData_0xD48B:
INCBIN "baserom.gb", $D48B, $D48C - $D48B

LoggedData_0xD48C:
INCBIN "baserom.gb", $D48C, $D48F - $D48C

UnknownData_0xD48F:
INCBIN "baserom.gb", $D48F, $D490 - $D48F

LoggedData_0xD490:
INCBIN "baserom.gb", $D490, $D494 - $D490

UnknownData_0xD494:
INCBIN "baserom.gb", $D494, $D495 - $D494

LoggedData_0xD495:
INCBIN "baserom.gb", $D495, $D498 - $D495

UnknownData_0xD498:
INCBIN "baserom.gb", $D498, $D499 - $D498

LoggedData_0xD499:
INCBIN "baserom.gb", $D499, $D49C - $D499

UnknownData_0xD49C:
INCBIN "baserom.gb", $D49C, $D49D - $D49C

LoggedData_0xD49D:
INCBIN "baserom.gb", $D49D, $D4A0 - $D49D

UnknownData_0xD4A0:
INCBIN "baserom.gb", $D4A0, $D4A1 - $D4A0

LoggedData_0xD4A1:
INCBIN "baserom.gb", $D4A1, $D4AA - $D4A1

UnknownData_0xD4AA:
INCBIN "baserom.gb", $D4AA, $D4AC - $D4AA

LoggedData_0xD4AC:
INCBIN "baserom.gb", $D4AC, $D4AF - $D4AC

UnknownData_0xD4AF:
INCBIN "baserom.gb", $D4AF, $D4B0 - $D4AF

LoggedData_0xD4B0:
INCBIN "baserom.gb", $D4B0, $D4B3 - $D4B0

UnknownData_0xD4B3:
INCBIN "baserom.gb", $D4B3, $D4B4 - $D4B3

LoggedData_0xD4B4:
INCBIN "baserom.gb", $D4B4, $D4B7 - $D4B4

UnknownData_0xD4B7:
INCBIN "baserom.gb", $D4B7, $D4B8 - $D4B7

LoggedData_0xD4B8:
INCBIN "baserom.gb", $D4B8, $D4BB - $D4B8

UnknownData_0xD4BB:
INCBIN "baserom.gb", $D4BB, $D4BC - $D4BB

LoggedData_0xD4BC:
INCBIN "baserom.gb", $D4BC, $D4BF - $D4BC

UnknownData_0xD4BF:
INCBIN "baserom.gb", $D4BF, $D4C0 - $D4BF

LoggedData_0xD4C0:
INCBIN "baserom.gb", $D4C0, $D4C3 - $D4C0

UnknownData_0xD4C3:
INCBIN "baserom.gb", $D4C3, $D4C4 - $D4C3

LoggedData_0xD4C4:
INCBIN "baserom.gb", $D4C4, $D4C8 - $D4C4

UnknownData_0xD4C8:
INCBIN "baserom.gb", $D4C8, $D4C9 - $D4C8

LoggedData_0xD4C9:
INCBIN "baserom.gb", $D4C9, $D4CC - $D4C9

UnknownData_0xD4CC:
INCBIN "baserom.gb", $D4CC, $D4CD - $D4CC

LoggedData_0xD4CD:
INCBIN "baserom.gb", $D4CD, $D4D0 - $D4CD

UnknownData_0xD4D0:
INCBIN "baserom.gb", $D4D0, $D4D1 - $D4D0

LoggedData_0xD4D1:
INCBIN "baserom.gb", $D4D1, $D4D4 - $D4D1

UnknownData_0xD4D4:
INCBIN "baserom.gb", $D4D4, $D4D5 - $D4D4

LoggedData_0xD4D5:
INCBIN "baserom.gb", $D4D5, $D4D9 - $D4D5

UnknownData_0xD4D9:
INCBIN "baserom.gb", $D4D9, $D4DA - $D4D9

LoggedData_0xD4DA:
INCBIN "baserom.gb", $D4DA, $D4DD - $D4DA

UnknownData_0xD4DD:
INCBIN "baserom.gb", $D4DD, $D4DE - $D4DD

LoggedData_0xD4DE:
INCBIN "baserom.gb", $D4DE, $D4E1 - $D4DE

UnknownData_0xD4E1:
INCBIN "baserom.gb", $D4E1, $D4E2 - $D4E1

LoggedData_0xD4E2:
INCBIN "baserom.gb", $D4E2, $D4E5 - $D4E2

UnknownData_0xD4E5:
INCBIN "baserom.gb", $D4E5, $D4E6 - $D4E5

LoggedData_0xD4E6:
INCBIN "baserom.gb", $D4E6, $D4EA - $D4E6

UnknownData_0xD4EA:
INCBIN "baserom.gb", $D4EA, $D4EB - $D4EA

LoggedData_0xD4EB:
INCBIN "baserom.gb", $D4EB, $D4EE - $D4EB

UnknownData_0xD4EE:
INCBIN "baserom.gb", $D4EE, $D4EF - $D4EE

LoggedData_0xD4EF:
INCBIN "baserom.gb", $D4EF, $D4F2 - $D4EF

UnknownData_0xD4F2:
INCBIN "baserom.gb", $D4F2, $D4F3 - $D4F2

LoggedData_0xD4F3:
INCBIN "baserom.gb", $D4F3, $D4F6 - $D4F3

UnknownData_0xD4F6:
INCBIN "baserom.gb", $D4F6, $D4F7 - $D4F6

LoggedData_0xD4F7:
INCBIN "baserom.gb", $D4F7, $D4FA - $D4F7

UnknownData_0xD4FA:
INCBIN "baserom.gb", $D4FA, $D4FC - $D4FA

LoggedData_0xD4FC:
INCBIN "baserom.gb", $D4FC, $D4FF - $D4FC

UnknownData_0xD4FF:
INCBIN "baserom.gb", $D4FF, $D500 - $D4FF

LoggedData_0xD500:
INCBIN "baserom.gb", $D500, $D503 - $D500

UnknownData_0xD503:
INCBIN "baserom.gb", $D503, $D504 - $D503

LoggedData_0xD504:
INCBIN "baserom.gb", $D504, $D507 - $D504

UnknownData_0xD507:
INCBIN "baserom.gb", $D507, $D508 - $D507

LoggedData_0xD508:
INCBIN "baserom.gb", $D508, $D50B - $D508

UnknownData_0xD50B:
INCBIN "baserom.gb", $D50B, $D50C - $D50B

LoggedData_0xD50C:
INCBIN "baserom.gb", $D50C, $D50F - $D50C

UnknownData_0xD50F:
INCBIN "baserom.gb", $D50F, $D510 - $D50F

LoggedData_0xD510:
INCBIN "baserom.gb", $D510, $D513 - $D510

UnknownData_0xD513:
INCBIN "baserom.gb", $D513, $D514 - $D513

LoggedData_0xD514:
INCBIN "baserom.gb", $D514, $D517 - $D514

UnknownData_0xD517:
INCBIN "baserom.gb", $D517, $D518 - $D517

LoggedData_0xD518:
INCBIN "baserom.gb", $D518, $D51B - $D518

UnknownData_0xD51B:
INCBIN "baserom.gb", $D51B, $D51D - $D51B

LoggedData_0xD51D:
INCBIN "baserom.gb", $D51D, $D520 - $D51D

UnknownData_0xD520:
INCBIN "baserom.gb", $D520, $D521 - $D520

LoggedData_0xD521:
INCBIN "baserom.gb", $D521, $D524 - $D521

UnknownData_0xD524:
INCBIN "baserom.gb", $D524, $D525 - $D524

LoggedData_0xD525:
INCBIN "baserom.gb", $D525, $D528 - $D525

UnknownData_0xD528:
INCBIN "baserom.gb", $D528, $D529 - $D528

LoggedData_0xD529:
INCBIN "baserom.gb", $D529, $D52C - $D529

UnknownData_0xD52C:
INCBIN "baserom.gb", $D52C, $D52D - $D52C

LoggedData_0xD52D:
INCBIN "baserom.gb", $D52D, $D530 - $D52D

UnknownData_0xD530:
INCBIN "baserom.gb", $D530, $D531 - $D530

LoggedData_0xD531:
INCBIN "baserom.gb", $D531, $D534 - $D531

UnknownData_0xD534:
INCBIN "baserom.gb", $D534, $D535 - $D534

LoggedData_0xD535:
INCBIN "baserom.gb", $D535, $D538 - $D535

UnknownData_0xD538:
INCBIN "baserom.gb", $D538, $D539 - $D538

LoggedData_0xD539:
INCBIN "baserom.gb", $D539, $D53C - $D539

UnknownData_0xD53C:
INCBIN "baserom.gb", $D53C, $D53E - $D53C

LoggedData_0xD53E:
INCBIN "baserom.gb", $D53E, $D541 - $D53E

UnknownData_0xD541:
INCBIN "baserom.gb", $D541, $D542 - $D541

LoggedData_0xD542:
INCBIN "baserom.gb", $D542, $D545 - $D542

UnknownData_0xD545:
INCBIN "baserom.gb", $D545, $D546 - $D545

LoggedData_0xD546:
INCBIN "baserom.gb", $D546, $D549 - $D546

UnknownData_0xD549:
INCBIN "baserom.gb", $D549, $D54A - $D549

LoggedData_0xD54A:
INCBIN "baserom.gb", $D54A, $D54D - $D54A

UnknownData_0xD54D:
INCBIN "baserom.gb", $D54D, $D54E - $D54D

LoggedData_0xD54E:
INCBIN "baserom.gb", $D54E, $D551 - $D54E

UnknownData_0xD551:
INCBIN "baserom.gb", $D551, $D552 - $D551

LoggedData_0xD552:
INCBIN "baserom.gb", $D552, $D555 - $D552

UnknownData_0xD555:
INCBIN "baserom.gb", $D555, $D556 - $D555

LoggedData_0xD556:
INCBIN "baserom.gb", $D556, $D559 - $D556

UnknownData_0xD559:
INCBIN "baserom.gb", $D559, $D55A - $D559

LoggedData_0xD55A:
INCBIN "baserom.gb", $D55A, $D55D - $D55A

UnknownData_0xD55D:
INCBIN "baserom.gb", $D55D, $D55F - $D55D

LoggedData_0xD55F:
INCBIN "baserom.gb", $D55F, $D562 - $D55F

UnknownData_0xD562:
INCBIN "baserom.gb", $D562, $D563 - $D562

LoggedData_0xD563:
INCBIN "baserom.gb", $D563, $D566 - $D563

UnknownData_0xD566:
INCBIN "baserom.gb", $D566, $D567 - $D566

LoggedData_0xD567:
INCBIN "baserom.gb", $D567, $D56A - $D567

UnknownData_0xD56A:
INCBIN "baserom.gb", $D56A, $D56B - $D56A

LoggedData_0xD56B:
INCBIN "baserom.gb", $D56B, $D56E - $D56B

UnknownData_0xD56E:
INCBIN "baserom.gb", $D56E, $D56F - $D56E

LoggedData_0xD56F:
INCBIN "baserom.gb", $D56F, $D572 - $D56F

UnknownData_0xD572:
INCBIN "baserom.gb", $D572, $D573 - $D572

LoggedData_0xD573:
INCBIN "baserom.gb", $D573, $D576 - $D573

UnknownData_0xD576:
INCBIN "baserom.gb", $D576, $D577 - $D576

LoggedData_0xD577:
INCBIN "baserom.gb", $D577, $D57A - $D577

UnknownData_0xD57A:
INCBIN "baserom.gb", $D57A, $D57B - $D57A

LoggedData_0xD57B:
INCBIN "baserom.gb", $D57B, $D584 - $D57B

UnknownData_0xD584:
INCBIN "baserom.gb", $D584, $D586 - $D584

LoggedData_0xD586:
INCBIN "baserom.gb", $D586, $D58E - $D586

UnknownData_0xD58E:
INCBIN "baserom.gb", $D58E, $D590 - $D58E

LoggedData_0xD590:
INCBIN "baserom.gb", $D590, $D598 - $D590

UnknownData_0xD598:
INCBIN "baserom.gb", $D598, $D59A - $D598

LoggedData_0xD59A:
INCBIN "baserom.gb", $D59A, $D5A2 - $D59A

UnknownData_0xD5A2:
INCBIN "baserom.gb", $D5A2, $D5A4 - $D5A2

LoggedData_0xD5A4:
INCBIN "baserom.gb", $D5A4, $D5AC - $D5A4

UnknownData_0xD5AC:
INCBIN "baserom.gb", $D5AC, $D5AE - $D5AC

LoggedData_0xD5AE:
INCBIN "baserom.gb", $D5AE, $D5B6 - $D5AE

UnknownData_0xD5B6:
INCBIN "baserom.gb", $D5B6, $D5B8 - $D5B6

LoggedData_0xD5B8:
INCBIN "baserom.gb", $D5B8, $D5C0 - $D5B8

UnknownData_0xD5C0:
INCBIN "baserom.gb", $D5C0, $D5C2 - $D5C0

LoggedData_0xD5C2:
INCBIN "baserom.gb", $D5C2, $D5C5 - $D5C2

UnknownData_0xD5C5:
INCBIN "baserom.gb", $D5C5, $D5C6 - $D5C5

LoggedData_0xD5C6:
INCBIN "baserom.gb", $D5C6, $D5C9 - $D5C6

UnknownData_0xD5C9:
INCBIN "baserom.gb", $D5C9, $D5CA - $D5C9

LoggedData_0xD5CA:
INCBIN "baserom.gb", $D5CA, $D5CD - $D5CA

UnknownData_0xD5CD:
INCBIN "baserom.gb", $D5CD, $D5CE - $D5CD

LoggedData_0xD5CE:
INCBIN "baserom.gb", $D5CE, $D5D1 - $D5CE

UnknownData_0xD5D1:
INCBIN "baserom.gb", $D5D1, $D5D2 - $D5D1

LoggedData_0xD5D2:
INCBIN "baserom.gb", $D5D2, $D5D6 - $D5D2

UnknownData_0xD5D6:
INCBIN "baserom.gb", $D5D6, $D5D7 - $D5D6

LoggedData_0xD5D7:
INCBIN "baserom.gb", $D5D7, $D5DA - $D5D7

UnknownData_0xD5DA:
INCBIN "baserom.gb", $D5DA, $D5DB - $D5DA

LoggedData_0xD5DB:
INCBIN "baserom.gb", $D5DB, $D5DE - $D5DB

UnknownData_0xD5DE:
INCBIN "baserom.gb", $D5DE, $D5DF - $D5DE

LoggedData_0xD5DF:
INCBIN "baserom.gb", $D5DF, $D5E2 - $D5DF

UnknownData_0xD5E2:
INCBIN "baserom.gb", $D5E2, $D5E3 - $D5E2

LoggedData_0xD5E3:
INCBIN "baserom.gb", $D5E3, $D5E7 - $D5E3

UnknownData_0xD5E7:
INCBIN "baserom.gb", $D5E7, $D5E8 - $D5E7

LoggedData_0xD5E8:
INCBIN "baserom.gb", $D5E8, $D5EB - $D5E8

UnknownData_0xD5EB:
INCBIN "baserom.gb", $D5EB, $D5EC - $D5EB

LoggedData_0xD5EC:
INCBIN "baserom.gb", $D5EC, $D5EF - $D5EC

UnknownData_0xD5EF:
INCBIN "baserom.gb", $D5EF, $D5F0 - $D5EF

LoggedData_0xD5F0:
INCBIN "baserom.gb", $D5F0, $D5F3 - $D5F0

UnknownData_0xD5F3:
INCBIN "baserom.gb", $D5F3, $D5F4 - $D5F3

LoggedData_0xD5F4:
INCBIN "baserom.gb", $D5F4, $D5F8 - $D5F4

UnknownData_0xD5F8:
INCBIN "baserom.gb", $D5F8, $D5F9 - $D5F8

LoggedData_0xD5F9:
INCBIN "baserom.gb", $D5F9, $D5FC - $D5F9

UnknownData_0xD5FC:
INCBIN "baserom.gb", $D5FC, $D5FD - $D5FC

LoggedData_0xD5FD:
INCBIN "baserom.gb", $D5FD, $D600 - $D5FD

UnknownData_0xD600:
INCBIN "baserom.gb", $D600, $D601 - $D600

LoggedData_0xD601:
INCBIN "baserom.gb", $D601, $D604 - $D601

UnknownData_0xD604:
INCBIN "baserom.gb", $D604, $D605 - $D604

LoggedData_0xD605:
INCBIN "baserom.gb", $D605, $D609 - $D605

UnknownData_0xD609:
INCBIN "baserom.gb", $D609, $D60A - $D609

LoggedData_0xD60A:
INCBIN "baserom.gb", $D60A, $D60D - $D60A

UnknownData_0xD60D:
INCBIN "baserom.gb", $D60D, $D60E - $D60D

LoggedData_0xD60E:
INCBIN "baserom.gb", $D60E, $D611 - $D60E

UnknownData_0xD611:
INCBIN "baserom.gb", $D611, $D612 - $D611

LoggedData_0xD612:
INCBIN "baserom.gb", $D612, $D615 - $D612

UnknownData_0xD615:
INCBIN "baserom.gb", $D615, $D616 - $D615

LoggedData_0xD616:
INCBIN "baserom.gb", $D616, $D61A - $D616

UnknownData_0xD61A:
INCBIN "baserom.gb", $D61A, $D61B - $D61A

LoggedData_0xD61B:
INCBIN "baserom.gb", $D61B, $D61E - $D61B

UnknownData_0xD61E:
INCBIN "baserom.gb", $D61E, $D61F - $D61E

LoggedData_0xD61F:
INCBIN "baserom.gb", $D61F, $D622 - $D61F

UnknownData_0xD622:
INCBIN "baserom.gb", $D622, $D623 - $D622

LoggedData_0xD623:
INCBIN "baserom.gb", $D623, $D626 - $D623

UnknownData_0xD626:
INCBIN "baserom.gb", $D626, $D627 - $D626

LoggedData_0xD627:
INCBIN "baserom.gb", $D627, $D62B - $D627

UnknownData_0xD62B:
INCBIN "baserom.gb", $D62B, $D62C - $D62B

LoggedData_0xD62C:
INCBIN "baserom.gb", $D62C, $D62F - $D62C

UnknownData_0xD62F:
INCBIN "baserom.gb", $D62F, $D630 - $D62F

LoggedData_0xD630:
INCBIN "baserom.gb", $D630, $D633 - $D630

UnknownData_0xD633:
INCBIN "baserom.gb", $D633, $D634 - $D633

LoggedData_0xD634:
INCBIN "baserom.gb", $D634, $D637 - $D634

UnknownData_0xD637:
INCBIN "baserom.gb", $D637, $D638 - $D637

LoggedData_0xD638:
INCBIN "baserom.gb", $D638, $D63C - $D638

UnknownData_0xD63C:
INCBIN "baserom.gb", $D63C, $D63D - $D63C

LoggedData_0xD63D:
INCBIN "baserom.gb", $D63D, $D640 - $D63D

UnknownData_0xD640:
INCBIN "baserom.gb", $D640, $D641 - $D640

LoggedData_0xD641:
INCBIN "baserom.gb", $D641, $D644 - $D641

UnknownData_0xD644:
INCBIN "baserom.gb", $D644, $D645 - $D644

LoggedData_0xD645:
INCBIN "baserom.gb", $D645, $D648 - $D645

UnknownData_0xD648:
INCBIN "baserom.gb", $D648, $D649 - $D648

LoggedData_0xD649:
INCBIN "baserom.gb", $D649, $D64D - $D649

UnknownData_0xD64D:
INCBIN "baserom.gb", $D64D, $D64E - $D64D

LoggedData_0xD64E:
INCBIN "baserom.gb", $D64E, $D651 - $D64E

UnknownData_0xD651:
INCBIN "baserom.gb", $D651, $D652 - $D651

LoggedData_0xD652:
INCBIN "baserom.gb", $D652, $D655 - $D652

UnknownData_0xD655:
INCBIN "baserom.gb", $D655, $D656 - $D655

LoggedData_0xD656:
INCBIN "baserom.gb", $D656, $D659 - $D656

UnknownData_0xD659:
INCBIN "baserom.gb", $D659, $D65A - $D659

LoggedData_0xD65A:
INCBIN "baserom.gb", $D65A, $D65E - $D65A

UnknownData_0xD65E:
INCBIN "baserom.gb", $D65E, $D65F - $D65E

LoggedData_0xD65F:
INCBIN "baserom.gb", $D65F, $D662 - $D65F

UnknownData_0xD662:
INCBIN "baserom.gb", $D662, $D663 - $D662

LoggedData_0xD663:
INCBIN "baserom.gb", $D663, $D666 - $D663

UnknownData_0xD666:
INCBIN "baserom.gb", $D666, $D667 - $D666

LoggedData_0xD667:
INCBIN "baserom.gb", $D667, $D66A - $D667

UnknownData_0xD66A:
INCBIN "baserom.gb", $D66A, $D66B - $D66A

LoggedData_0xD66B:
INCBIN "baserom.gb", $D66B, $D66F - $D66B

UnknownData_0xD66F:
INCBIN "baserom.gb", $D66F, $D670 - $D66F

LoggedData_0xD670:
INCBIN "baserom.gb", $D670, $D673 - $D670

UnknownData_0xD673:
INCBIN "baserom.gb", $D673, $D674 - $D673

LoggedData_0xD674:
INCBIN "baserom.gb", $D674, $D677 - $D674

UnknownData_0xD677:
INCBIN "baserom.gb", $D677, $D678 - $D677

LoggedData_0xD678:
INCBIN "baserom.gb", $D678, $D67B - $D678

UnknownData_0xD67B:
INCBIN "baserom.gb", $D67B, $D67C - $D67B

LoggedData_0xD67C:
INCBIN "baserom.gb", $D67C, $D680 - $D67C

UnknownData_0xD680:
INCBIN "baserom.gb", $D680, $D681 - $D680

LoggedData_0xD681:
INCBIN "baserom.gb", $D681, $D684 - $D681

UnknownData_0xD684:
INCBIN "baserom.gb", $D684, $D685 - $D684

LoggedData_0xD685:
INCBIN "baserom.gb", $D685, $D688 - $D685

UnknownData_0xD688:
INCBIN "baserom.gb", $D688, $D689 - $D688

LoggedData_0xD689:
INCBIN "baserom.gb", $D689, $D68C - $D689

UnknownData_0xD68C:
INCBIN "baserom.gb", $D68C, $D68D - $D68C

LoggedData_0xD68D:
INCBIN "baserom.gb", $D68D, $D691 - $D68D

UnknownData_0xD691:
INCBIN "baserom.gb", $D691, $D692 - $D691

LoggedData_0xD692:
INCBIN "baserom.gb", $D692, $D695 - $D692

UnknownData_0xD695:
INCBIN "baserom.gb", $D695, $D696 - $D695

LoggedData_0xD696:
INCBIN "baserom.gb", $D696, $D699 - $D696

UnknownData_0xD699:
INCBIN "baserom.gb", $D699, $D69A - $D699

LoggedData_0xD69A:
INCBIN "baserom.gb", $D69A, $D69D - $D69A

UnknownData_0xD69D:
INCBIN "baserom.gb", $D69D, $D69E - $D69D

LoggedData_0xD69E:
INCBIN "baserom.gb", $D69E, $D6A1 - $D69E

UnknownData_0xD6A1:
INCBIN "baserom.gb", $D6A1, $D6A2 - $D6A1

LoggedData_0xD6A2:
INCBIN "baserom.gb", $D6A2, $D6A6 - $D6A2

UnknownData_0xD6A6:
INCBIN "baserom.gb", $D6A6, $D6A7 - $D6A6

LoggedData_0xD6A7:
INCBIN "baserom.gb", $D6A7, $D6AA - $D6A7

UnknownData_0xD6AA:
INCBIN "baserom.gb", $D6AA, $D6AB - $D6AA

LoggedData_0xD6AB:
INCBIN "baserom.gb", $D6AB, $D6AE - $D6AB

UnknownData_0xD6AE:
INCBIN "baserom.gb", $D6AE, $D6AF - $D6AE

LoggedData_0xD6AF:
INCBIN "baserom.gb", $D6AF, $D6B2 - $D6AF

UnknownData_0xD6B2:
INCBIN "baserom.gb", $D6B2, $D6B3 - $D6B2

LoggedData_0xD6B3:
INCBIN "baserom.gb", $D6B3, $D6B6 - $D6B3

UnknownData_0xD6B6:
INCBIN "baserom.gb", $D6B6, $D6B7 - $D6B6

LoggedData_0xD6B7:
INCBIN "baserom.gb", $D6B7, $D6BA - $D6B7

UnknownData_0xD6BA:
INCBIN "baserom.gb", $D6BA, $D6BB - $D6BA

LoggedData_0xD6BB:
INCBIN "baserom.gb", $D6BB, $D6BF - $D6BB

UnknownData_0xD6BF:
INCBIN "baserom.gb", $D6BF, $D6C0 - $D6BF

LoggedData_0xD6C0:
INCBIN "baserom.gb", $D6C0, $D6C3 - $D6C0

UnknownData_0xD6C3:
INCBIN "baserom.gb", $D6C3, $D6C4 - $D6C3

LoggedData_0xD6C4:
INCBIN "baserom.gb", $D6C4, $D6C7 - $D6C4

UnknownData_0xD6C7:
INCBIN "baserom.gb", $D6C7, $D6C8 - $D6C7

LoggedData_0xD6C8:
INCBIN "baserom.gb", $D6C8, $D6CB - $D6C8

UnknownData_0xD6CB:
INCBIN "baserom.gb", $D6CB, $D6CC - $D6CB

LoggedData_0xD6CC:
INCBIN "baserom.gb", $D6CC, $D6CF - $D6CC

UnknownData_0xD6CF:
INCBIN "baserom.gb", $D6CF, $D6D0 - $D6CF

LoggedData_0xD6D0:
INCBIN "baserom.gb", $D6D0, $D6D3 - $D6D0

UnknownData_0xD6D3:
INCBIN "baserom.gb", $D6D3, $D6D4 - $D6D3

LoggedData_0xD6D4:
INCBIN "baserom.gb", $D6D4, $D6D8 - $D6D4

UnknownData_0xD6D8:
INCBIN "baserom.gb", $D6D8, $D6D9 - $D6D8

LoggedData_0xD6D9:
INCBIN "baserom.gb", $D6D9, $D6DC - $D6D9

UnknownData_0xD6DC:
INCBIN "baserom.gb", $D6DC, $D6DD - $D6DC

LoggedData_0xD6DD:
INCBIN "baserom.gb", $D6DD, $D6E0 - $D6DD

UnknownData_0xD6E0:
INCBIN "baserom.gb", $D6E0, $D6E1 - $D6E0

LoggedData_0xD6E1:
INCBIN "baserom.gb", $D6E1, $D6E4 - $D6E1

UnknownData_0xD6E4:
INCBIN "baserom.gb", $D6E4, $D6E5 - $D6E4

LoggedData_0xD6E5:
INCBIN "baserom.gb", $D6E5, $D6E8 - $D6E5

UnknownData_0xD6E8:
INCBIN "baserom.gb", $D6E8, $D6E9 - $D6E8

LoggedData_0xD6E9:
INCBIN "baserom.gb", $D6E9, $D6ED - $D6E9

UnknownData_0xD6ED:
INCBIN "baserom.gb", $D6ED, $D6EE - $D6ED

LoggedData_0xD6EE:
INCBIN "baserom.gb", $D6EE, $D6F1 - $D6EE

UnknownData_0xD6F1:
INCBIN "baserom.gb", $D6F1, $D6F2 - $D6F1

LoggedData_0xD6F2:
INCBIN "baserom.gb", $D6F2, $D6F5 - $D6F2

UnknownData_0xD6F5:
INCBIN "baserom.gb", $D6F5, $D6F6 - $D6F5

LoggedData_0xD6F6:
INCBIN "baserom.gb", $D6F6, $D6F9 - $D6F6

UnknownData_0xD6F9:
INCBIN "baserom.gb", $D6F9, $D6FA - $D6F9

LoggedData_0xD6FA:
INCBIN "baserom.gb", $D6FA, $D6FD - $D6FA

UnknownData_0xD6FD:
INCBIN "baserom.gb", $D6FD, $D6FE - $D6FD

LoggedData_0xD6FE:
INCBIN "baserom.gb", $D6FE, $D702 - $D6FE

UnknownData_0xD702:
INCBIN "baserom.gb", $D702, $D703 - $D702

LoggedData_0xD703:
INCBIN "baserom.gb", $D703, $D706 - $D703

UnknownData_0xD706:
INCBIN "baserom.gb", $D706, $D707 - $D706

LoggedData_0xD707:
INCBIN "baserom.gb", $D707, $D70A - $D707

UnknownData_0xD70A:
INCBIN "baserom.gb", $D70A, $D70B - $D70A

LoggedData_0xD70B:
INCBIN "baserom.gb", $D70B, $D70E - $D70B

UnknownData_0xD70E:
INCBIN "baserom.gb", $D70E, $D70F - $D70E

LoggedData_0xD70F:
INCBIN "baserom.gb", $D70F, $D712 - $D70F

UnknownData_0xD712:
INCBIN "baserom.gb", $D712, $D713 - $D712

LoggedData_0xD713:
INCBIN "baserom.gb", $D713, $D716 - $D713

UnknownData_0xD716:
INCBIN "baserom.gb", $D716, $D717 - $D716

LoggedData_0xD717:
INCBIN "baserom.gb", $D717, $D71B - $D717

UnknownData_0xD71B:
INCBIN "baserom.gb", $D71B, $D71C - $D71B

LoggedData_0xD71C:
INCBIN "baserom.gb", $D71C, $D71F - $D71C

UnknownData_0xD71F:
INCBIN "baserom.gb", $D71F, $D720 - $D71F

LoggedData_0xD720:
INCBIN "baserom.gb", $D720, $D723 - $D720

UnknownData_0xD723:
INCBIN "baserom.gb", $D723, $D724 - $D723

LoggedData_0xD724:
INCBIN "baserom.gb", $D724, $D727 - $D724

UnknownData_0xD727:
INCBIN "baserom.gb", $D727, $D728 - $D727

LoggedData_0xD728:
INCBIN "baserom.gb", $D728, $D72B - $D728

UnknownData_0xD72B:
INCBIN "baserom.gb", $D72B, $D72C - $D72B

LoggedData_0xD72C:
INCBIN "baserom.gb", $D72C, $D72F - $D72C

UnknownData_0xD72F:
INCBIN "baserom.gb", $D72F, $D730 - $D72F

LoggedData_0xD730:
INCBIN "baserom.gb", $D730, $D734 - $D730

UnknownData_0xD734:
INCBIN "baserom.gb", $D734, $D735 - $D734

LoggedData_0xD735:
INCBIN "baserom.gb", $D735, $D738 - $D735

UnknownData_0xD738:
INCBIN "baserom.gb", $D738, $D739 - $D738

LoggedData_0xD739:
INCBIN "baserom.gb", $D739, $D73C - $D739

UnknownData_0xD73C:
INCBIN "baserom.gb", $D73C, $D73D - $D73C

LoggedData_0xD73D:
INCBIN "baserom.gb", $D73D, $D740 - $D73D

UnknownData_0xD740:
INCBIN "baserom.gb", $D740, $D741 - $D740

LoggedData_0xD741:
INCBIN "baserom.gb", $D741, $D744 - $D741

UnknownData_0xD744:
INCBIN "baserom.gb", $D744, $D745 - $D744

LoggedData_0xD745:
INCBIN "baserom.gb", $D745, $D749 - $D745

UnknownData_0xD749:
INCBIN "baserom.gb", $D749, $D74A - $D749

LoggedData_0xD74A:
INCBIN "baserom.gb", $D74A, $D74D - $D74A

UnknownData_0xD74D:
INCBIN "baserom.gb", $D74D, $D74E - $D74D

LoggedData_0xD74E:
INCBIN "baserom.gb", $D74E, $D751 - $D74E

UnknownData_0xD751:
INCBIN "baserom.gb", $D751, $D752 - $D751

LoggedData_0xD752:
INCBIN "baserom.gb", $D752, $D755 - $D752

UnknownData_0xD755:
INCBIN "baserom.gb", $D755, $D756 - $D755

LoggedData_0xD756:
INCBIN "baserom.gb", $D756, $D75A - $D756

UnknownData_0xD75A:
INCBIN "baserom.gb", $D75A, $D75B - $D75A

LoggedData_0xD75B:
INCBIN "baserom.gb", $D75B, $D75E - $D75B

UnknownData_0xD75E:
INCBIN "baserom.gb", $D75E, $D75F - $D75E

LoggedData_0xD75F:
INCBIN "baserom.gb", $D75F, $D762 - $D75F

UnknownData_0xD762:
INCBIN "baserom.gb", $D762, $D763 - $D762

LoggedData_0xD763:
INCBIN "baserom.gb", $D763, $D766 - $D763

UnknownData_0xD766:
INCBIN "baserom.gb", $D766, $D767 - $D766

LoggedData_0xD767:
INCBIN "baserom.gb", $D767, $D76B - $D767

UnknownData_0xD76B:
INCBIN "baserom.gb", $D76B, $D76C - $D76B

LoggedData_0xD76C:
INCBIN "baserom.gb", $D76C, $D76F - $D76C

UnknownData_0xD76F:
INCBIN "baserom.gb", $D76F, $D770 - $D76F

LoggedData_0xD770:
INCBIN "baserom.gb", $D770, $D773 - $D770

UnknownData_0xD773:
INCBIN "baserom.gb", $D773, $D774 - $D773

LoggedData_0xD774:
INCBIN "baserom.gb", $D774, $D777 - $D774

UnknownData_0xD777:
INCBIN "baserom.gb", $D777, $D778 - $D777

LoggedData_0xD778:
INCBIN "baserom.gb", $D778, $D77C - $D778

UnknownData_0xD77C:
INCBIN "baserom.gb", $D77C, $D77D - $D77C

LoggedData_0xD77D:
INCBIN "baserom.gb", $D77D, $D780 - $D77D

UnknownData_0xD780:
INCBIN "baserom.gb", $D780, $D781 - $D780

LoggedData_0xD781:
INCBIN "baserom.gb", $D781, $D784 - $D781

UnknownData_0xD784:
INCBIN "baserom.gb", $D784, $D785 - $D784

LoggedData_0xD785:
INCBIN "baserom.gb", $D785, $D788 - $D785

UnknownData_0xD788:
INCBIN "baserom.gb", $D788, $D789 - $D788

LoggedData_0xD789:
INCBIN "baserom.gb", $D789, $D78D - $D789

UnknownData_0xD78D:
INCBIN "baserom.gb", $D78D, $D78E - $D78D

LoggedData_0xD78E:
INCBIN "baserom.gb", $D78E, $D791 - $D78E

UnknownData_0xD791:
INCBIN "baserom.gb", $D791, $D792 - $D791

LoggedData_0xD792:
INCBIN "baserom.gb", $D792, $D795 - $D792

UnknownData_0xD795:
INCBIN "baserom.gb", $D795, $D796 - $D795

LoggedData_0xD796:
INCBIN "baserom.gb", $D796, $D799 - $D796

UnknownData_0xD799:
INCBIN "baserom.gb", $D799, $D79A - $D799

LoggedData_0xD79A:
INCBIN "baserom.gb", $D79A, $D79E - $D79A

UnknownData_0xD79E:
INCBIN "baserom.gb", $D79E, $D79F - $D79E

LoggedData_0xD79F:
INCBIN "baserom.gb", $D79F, $D7A2 - $D79F

UnknownData_0xD7A2:
INCBIN "baserom.gb", $D7A2, $D7A3 - $D7A2

LoggedData_0xD7A3:
INCBIN "baserom.gb", $D7A3, $D7A6 - $D7A3

UnknownData_0xD7A6:
INCBIN "baserom.gb", $D7A6, $D7A7 - $D7A6

LoggedData_0xD7A7:
INCBIN "baserom.gb", $D7A7, $D7AA - $D7A7

UnknownData_0xD7AA:
INCBIN "baserom.gb", $D7AA, $D7AB - $D7AA

LoggedData_0xD7AB:
INCBIN "baserom.gb", $D7AB, $D7AF - $D7AB

UnknownData_0xD7AF:
INCBIN "baserom.gb", $D7AF, $D7B0 - $D7AF

LoggedData_0xD7B0:
INCBIN "baserom.gb", $D7B0, $D7B3 - $D7B0

UnknownData_0xD7B3:
INCBIN "baserom.gb", $D7B3, $D7B4 - $D7B3

LoggedData_0xD7B4:
INCBIN "baserom.gb", $D7B4, $D7B7 - $D7B4

UnknownData_0xD7B7:
INCBIN "baserom.gb", $D7B7, $D7B8 - $D7B7

LoggedData_0xD7B8:
INCBIN "baserom.gb", $D7B8, $D7BB - $D7B8

UnknownData_0xD7BB:
INCBIN "baserom.gb", $D7BB, $D7BC - $D7BB

LoggedData_0xD7BC:
INCBIN "baserom.gb", $D7BC, $D7C0 - $D7BC

UnknownData_0xD7C0:
INCBIN "baserom.gb", $D7C0, $D7C1 - $D7C0

LoggedData_0xD7C1:
INCBIN "baserom.gb", $D7C1, $D7C4 - $D7C1

UnknownData_0xD7C4:
INCBIN "baserom.gb", $D7C4, $D7C5 - $D7C4

LoggedData_0xD7C5:
INCBIN "baserom.gb", $D7C5, $D7C8 - $D7C5

UnknownData_0xD7C8:
INCBIN "baserom.gb", $D7C8, $D7C9 - $D7C8

LoggedData_0xD7C9:
INCBIN "baserom.gb", $D7C9, $D7CC - $D7C9

UnknownData_0xD7CC:
INCBIN "baserom.gb", $D7CC, $D7CD - $D7CC

LoggedData_0xD7CD:
INCBIN "baserom.gb", $D7CD, $D7D6 - $D7CD

UnknownData_0xD7D6:
INCBIN "baserom.gb", $D7D6, $D7D8 - $D7D6

LoggedData_0xD7D8:
INCBIN "baserom.gb", $D7D8, $D7E0 - $D7D8

UnknownData_0xD7E0:
INCBIN "baserom.gb", $D7E0, $D7E2 - $D7E0

LoggedData_0xD7E2:
INCBIN "baserom.gb", $D7E2, $D7EA - $D7E2

UnknownData_0xD7EA:
INCBIN "baserom.gb", $D7EA, $D7EC - $D7EA

LoggedData_0xD7EC:
INCBIN "baserom.gb", $D7EC, $D7F4 - $D7EC

UnknownData_0xD7F4:
INCBIN "baserom.gb", $D7F4, $D7F6 - $D7F4

LoggedData_0xD7F6:
INCBIN "baserom.gb", $D7F6, $D7FE - $D7F6

UnknownData_0xD7FE:
INCBIN "baserom.gb", $D7FE, $D800 - $D7FE

LoggedData_0xD800:
INCBIN "baserom.gb", $D800, $D808 - $D800

UnknownData_0xD808:
INCBIN "baserom.gb", $D808, $D80A - $D808

LoggedData_0xD80A:
INCBIN "baserom.gb", $D80A, $D812 - $D80A

UnknownData_0xD812:
INCBIN "baserom.gb", $D812, $D814 - $D812

LoggedData_0xD814:
INCBIN "baserom.gb", $D814, $D817 - $D814

UnknownData_0xD817:
INCBIN "baserom.gb", $D817, $D818 - $D817

LoggedData_0xD818:
INCBIN "baserom.gb", $D818, $D81B - $D818

UnknownData_0xD81B:
INCBIN "baserom.gb", $D81B, $D81C - $D81B

LoggedData_0xD81C:
INCBIN "baserom.gb", $D81C, $D81F - $D81C

UnknownData_0xD81F:
INCBIN "baserom.gb", $D81F, $D820 - $D81F

LoggedData_0xD820:
INCBIN "baserom.gb", $D820, $D823 - $D820

UnknownData_0xD823:
INCBIN "baserom.gb", $D823, $D824 - $D823

LoggedData_0xD824:
INCBIN "baserom.gb", $D824, $D828 - $D824

UnknownData_0xD828:
INCBIN "baserom.gb", $D828, $D829 - $D828

LoggedData_0xD829:
INCBIN "baserom.gb", $D829, $D82C - $D829

UnknownData_0xD82C:
INCBIN "baserom.gb", $D82C, $D82D - $D82C

LoggedData_0xD82D:
INCBIN "baserom.gb", $D82D, $D830 - $D82D

UnknownData_0xD830:
INCBIN "baserom.gb", $D830, $D831 - $D830

LoggedData_0xD831:
INCBIN "baserom.gb", $D831, $D834 - $D831

UnknownData_0xD834:
INCBIN "baserom.gb", $D834, $D835 - $D834

LoggedData_0xD835:
INCBIN "baserom.gb", $D835, $D839 - $D835

UnknownData_0xD839:
INCBIN "baserom.gb", $D839, $D83A - $D839

LoggedData_0xD83A:
INCBIN "baserom.gb", $D83A, $D83D - $D83A

UnknownData_0xD83D:
INCBIN "baserom.gb", $D83D, $D83E - $D83D

LoggedData_0xD83E:
INCBIN "baserom.gb", $D83E, $D841 - $D83E

UnknownData_0xD841:
INCBIN "baserom.gb", $D841, $D842 - $D841

LoggedData_0xD842:
INCBIN "baserom.gb", $D842, $D845 - $D842

UnknownData_0xD845:
INCBIN "baserom.gb", $D845, $D846 - $D845

LoggedData_0xD846:
INCBIN "baserom.gb", $D846, $D84A - $D846

UnknownData_0xD84A:
INCBIN "baserom.gb", $D84A, $D84B - $D84A

LoggedData_0xD84B:
INCBIN "baserom.gb", $D84B, $D84E - $D84B

UnknownData_0xD84E:
INCBIN "baserom.gb", $D84E, $D84F - $D84E

LoggedData_0xD84F:
INCBIN "baserom.gb", $D84F, $D852 - $D84F

UnknownData_0xD852:
INCBIN "baserom.gb", $D852, $D853 - $D852

LoggedData_0xD853:
INCBIN "baserom.gb", $D853, $D856 - $D853

UnknownData_0xD856:
INCBIN "baserom.gb", $D856, $D857 - $D856

LoggedData_0xD857:
INCBIN "baserom.gb", $D857, $D85B - $D857

UnknownData_0xD85B:
INCBIN "baserom.gb", $D85B, $D85C - $D85B

LoggedData_0xD85C:
INCBIN "baserom.gb", $D85C, $D85F - $D85C

UnknownData_0xD85F:
INCBIN "baserom.gb", $D85F, $D860 - $D85F

LoggedData_0xD860:
INCBIN "baserom.gb", $D860, $D863 - $D860

UnknownData_0xD863:
INCBIN "baserom.gb", $D863, $D864 - $D863

LoggedData_0xD864:
INCBIN "baserom.gb", $D864, $D867 - $D864

UnknownData_0xD867:
INCBIN "baserom.gb", $D867, $D868 - $D867

LoggedData_0xD868:
INCBIN "baserom.gb", $D868, $D86C - $D868

UnknownData_0xD86C:
INCBIN "baserom.gb", $D86C, $D86D - $D86C

LoggedData_0xD86D:
INCBIN "baserom.gb", $D86D, $D870 - $D86D

UnknownData_0xD870:
INCBIN "baserom.gb", $D870, $D871 - $D870

LoggedData_0xD871:
INCBIN "baserom.gb", $D871, $D874 - $D871

UnknownData_0xD874:
INCBIN "baserom.gb", $D874, $D875 - $D874

LoggedData_0xD875:
INCBIN "baserom.gb", $D875, $D878 - $D875

UnknownData_0xD878:
INCBIN "baserom.gb", $D878, $D879 - $D878

LoggedData_0xD879:
INCBIN "baserom.gb", $D879, $D87D - $D879

UnknownData_0xD87D:
INCBIN "baserom.gb", $D87D, $D87E - $D87D

LoggedData_0xD87E:
INCBIN "baserom.gb", $D87E, $D881 - $D87E

UnknownData_0xD881:
INCBIN "baserom.gb", $D881, $D882 - $D881

LoggedData_0xD882:
INCBIN "baserom.gb", $D882, $D885 - $D882

UnknownData_0xD885:
INCBIN "baserom.gb", $D885, $D886 - $D885

LoggedData_0xD886:
INCBIN "baserom.gb", $D886, $D889 - $D886

UnknownData_0xD889:
INCBIN "baserom.gb", $D889, $D88A - $D889

LoggedData_0xD88A:
INCBIN "baserom.gb", $D88A, $D88E - $D88A

UnknownData_0xD88E:
INCBIN "baserom.gb", $D88E, $D88F - $D88E

LoggedData_0xD88F:
INCBIN "baserom.gb", $D88F, $D892 - $D88F

UnknownData_0xD892:
INCBIN "baserom.gb", $D892, $D893 - $D892

LoggedData_0xD893:
INCBIN "baserom.gb", $D893, $D896 - $D893

UnknownData_0xD896:
INCBIN "baserom.gb", $D896, $D897 - $D896

LoggedData_0xD897:
INCBIN "baserom.gb", $D897, $D89A - $D897

UnknownData_0xD89A:
INCBIN "baserom.gb", $D89A, $D89B - $D89A

LoggedData_0xD89B:
INCBIN "baserom.gb", $D89B, $D89F - $D89B

UnknownData_0xD89F:
INCBIN "baserom.gb", $D89F, $D8A0 - $D89F

LoggedData_0xD8A0:
INCBIN "baserom.gb", $D8A0, $D8A3 - $D8A0

UnknownData_0xD8A3:
INCBIN "baserom.gb", $D8A3, $D8A4 - $D8A3

LoggedData_0xD8A4:
INCBIN "baserom.gb", $D8A4, $D8A7 - $D8A4

UnknownData_0xD8A7:
INCBIN "baserom.gb", $D8A7, $D8A8 - $D8A7

LoggedData_0xD8A8:
INCBIN "baserom.gb", $D8A8, $D8AB - $D8A8

UnknownData_0xD8AB:
INCBIN "baserom.gb", $D8AB, $D8AC - $D8AB

LoggedData_0xD8AC:
INCBIN "baserom.gb", $D8AC, $D8B0 - $D8AC

UnknownData_0xD8B0:
INCBIN "baserom.gb", $D8B0, $D8B1 - $D8B0

LoggedData_0xD8B1:
INCBIN "baserom.gb", $D8B1, $D8B4 - $D8B1

UnknownData_0xD8B4:
INCBIN "baserom.gb", $D8B4, $D8B5 - $D8B4

LoggedData_0xD8B5:
INCBIN "baserom.gb", $D8B5, $D8B8 - $D8B5

UnknownData_0xD8B8:
INCBIN "baserom.gb", $D8B8, $D8B9 - $D8B8

LoggedData_0xD8B9:
INCBIN "baserom.gb", $D8B9, $D8BC - $D8B9

UnknownData_0xD8BC:
INCBIN "baserom.gb", $D8BC, $D8BD - $D8BC

LoggedData_0xD8BD:
INCBIN "baserom.gb", $D8BD, $D8C1 - $D8BD

UnknownData_0xD8C1:
INCBIN "baserom.gb", $D8C1, $D8C2 - $D8C1

LoggedData_0xD8C2:
INCBIN "baserom.gb", $D8C2, $D8C5 - $D8C2

UnknownData_0xD8C5:
INCBIN "baserom.gb", $D8C5, $D8C6 - $D8C5

LoggedData_0xD8C6:
INCBIN "baserom.gb", $D8C6, $D8C9 - $D8C6

UnknownData_0xD8C9:
INCBIN "baserom.gb", $D8C9, $D8CA - $D8C9

LoggedData_0xD8CA:
INCBIN "baserom.gb", $D8CA, $D8CD - $D8CA

UnknownData_0xD8CD:
INCBIN "baserom.gb", $D8CD, $D8CE - $D8CD

LoggedData_0xD8CE:
INCBIN "baserom.gb", $D8CE, $D8D2 - $D8CE

UnknownData_0xD8D2:
INCBIN "baserom.gb", $D8D2, $D8D3 - $D8D2

LoggedData_0xD8D3:
INCBIN "baserom.gb", $D8D3, $D8D6 - $D8D3

UnknownData_0xD8D6:
INCBIN "baserom.gb", $D8D6, $D8D7 - $D8D6

LoggedData_0xD8D7:
INCBIN "baserom.gb", $D8D7, $D8DA - $D8D7

UnknownData_0xD8DA:
INCBIN "baserom.gb", $D8DA, $D8DB - $D8DA

LoggedData_0xD8DB:
INCBIN "baserom.gb", $D8DB, $D8DE - $D8DB

UnknownData_0xD8DE:
INCBIN "baserom.gb", $D8DE, $D8DF - $D8DE

LoggedData_0xD8DF:
INCBIN "baserom.gb", $D8DF, $D8E3 - $D8DF

UnknownData_0xD8E3:
INCBIN "baserom.gb", $D8E3, $D8E4 - $D8E3

LoggedData_0xD8E4:
INCBIN "baserom.gb", $D8E4, $D8E7 - $D8E4

UnknownData_0xD8E7:
INCBIN "baserom.gb", $D8E7, $D8E8 - $D8E7

LoggedData_0xD8E8:
INCBIN "baserom.gb", $D8E8, $D8EB - $D8E8

UnknownData_0xD8EB:
INCBIN "baserom.gb", $D8EB, $D8EC - $D8EB

LoggedData_0xD8EC:
INCBIN "baserom.gb", $D8EC, $D8EF - $D8EC

UnknownData_0xD8EF:
INCBIN "baserom.gb", $D8EF, $D8F0 - $D8EF

LoggedData_0xD8F0:
INCBIN "baserom.gb", $D8F0, $D8F3 - $D8F0

UnknownData_0xD8F3:
INCBIN "baserom.gb", $D8F3, $D8F4 - $D8F3

LoggedData_0xD8F4:
INCBIN "baserom.gb", $D8F4, $D8F8 - $D8F4

UnknownData_0xD8F8:
INCBIN "baserom.gb", $D8F8, $D8F9 - $D8F8

LoggedData_0xD8F9:
INCBIN "baserom.gb", $D8F9, $D8FC - $D8F9

UnknownData_0xD8FC:
INCBIN "baserom.gb", $D8FC, $D8FD - $D8FC

LoggedData_0xD8FD:
INCBIN "baserom.gb", $D8FD, $D900 - $D8FD

UnknownData_0xD900:
INCBIN "baserom.gb", $D900, $D901 - $D900

LoggedData_0xD901:
INCBIN "baserom.gb", $D901, $D904 - $D901

UnknownData_0xD904:
INCBIN "baserom.gb", $D904, $D905 - $D904

LoggedData_0xD905:
INCBIN "baserom.gb", $D905, $D908 - $D905

UnknownData_0xD908:
INCBIN "baserom.gb", $D908, $D909 - $D908

LoggedData_0xD909:
INCBIN "baserom.gb", $D909, $D90C - $D909

UnknownData_0xD90C:
INCBIN "baserom.gb", $D90C, $D90D - $D90C

LoggedData_0xD90D:
INCBIN "baserom.gb", $D90D, $D911 - $D90D

UnknownData_0xD911:
INCBIN "baserom.gb", $D911, $D912 - $D911

LoggedData_0xD912:
INCBIN "baserom.gb", $D912, $D915 - $D912

UnknownData_0xD915:
INCBIN "baserom.gb", $D915, $D916 - $D915

LoggedData_0xD916:
INCBIN "baserom.gb", $D916, $D919 - $D916

UnknownData_0xD919:
INCBIN "baserom.gb", $D919, $D91A - $D919

LoggedData_0xD91A:
INCBIN "baserom.gb", $D91A, $D91D - $D91A

UnknownData_0xD91D:
INCBIN "baserom.gb", $D91D, $D91E - $D91D

LoggedData_0xD91E:
INCBIN "baserom.gb", $D91E, $D921 - $D91E

UnknownData_0xD921:
INCBIN "baserom.gb", $D921, $D922 - $D921

LoggedData_0xD922:
INCBIN "baserom.gb", $D922, $D925 - $D922

UnknownData_0xD925:
INCBIN "baserom.gb", $D925, $D926 - $D925

LoggedData_0xD926:
INCBIN "baserom.gb", $D926, $D92A - $D926

UnknownData_0xD92A:
INCBIN "baserom.gb", $D92A, $D92B - $D92A

LoggedData_0xD92B:
INCBIN "baserom.gb", $D92B, $D92E - $D92B

UnknownData_0xD92E:
INCBIN "baserom.gb", $D92E, $D92F - $D92E

LoggedData_0xD92F:
INCBIN "baserom.gb", $D92F, $D932 - $D92F

UnknownData_0xD932:
INCBIN "baserom.gb", $D932, $D933 - $D932

LoggedData_0xD933:
INCBIN "baserom.gb", $D933, $D936 - $D933

UnknownData_0xD936:
INCBIN "baserom.gb", $D936, $D937 - $D936

LoggedData_0xD937:
INCBIN "baserom.gb", $D937, $D93A - $D937

UnknownData_0xD93A:
INCBIN "baserom.gb", $D93A, $D93B - $D93A

LoggedData_0xD93B:
INCBIN "baserom.gb", $D93B, $D93F - $D93B

UnknownData_0xD93F:
INCBIN "baserom.gb", $D93F, $D940 - $D93F

LoggedData_0xD940:
INCBIN "baserom.gb", $D940, $D943 - $D940

UnknownData_0xD943:
INCBIN "baserom.gb", $D943, $D944 - $D943

LoggedData_0xD944:
INCBIN "baserom.gb", $D944, $D947 - $D944

UnknownData_0xD947:
INCBIN "baserom.gb", $D947, $D948 - $D947

LoggedData_0xD948:
INCBIN "baserom.gb", $D948, $D94B - $D948

UnknownData_0xD94B:
INCBIN "baserom.gb", $D94B, $D94C - $D94B

LoggedData_0xD94C:
INCBIN "baserom.gb", $D94C, $D94F - $D94C

UnknownData_0xD94F:
INCBIN "baserom.gb", $D94F, $D950 - $D94F

LoggedData_0xD950:
INCBIN "baserom.gb", $D950, $D954 - $D950

UnknownData_0xD954:
INCBIN "baserom.gb", $D954, $D955 - $D954

LoggedData_0xD955:
INCBIN "baserom.gb", $D955, $D958 - $D955

UnknownData_0xD958:
INCBIN "baserom.gb", $D958, $D959 - $D958

LoggedData_0xD959:
INCBIN "baserom.gb", $D959, $D95C - $D959

UnknownData_0xD95C:
INCBIN "baserom.gb", $D95C, $D95D - $D95C

LoggedData_0xD95D:
INCBIN "baserom.gb", $D95D, $D960 - $D95D

UnknownData_0xD960:
INCBIN "baserom.gb", $D960, $D961 - $D960

LoggedData_0xD961:
INCBIN "baserom.gb", $D961, $D964 - $D961

UnknownData_0xD964:
INCBIN "baserom.gb", $D964, $D965 - $D964

LoggedData_0xD965:
INCBIN "baserom.gb", $D965, $D968 - $D965

UnknownData_0xD968:
INCBIN "baserom.gb", $D968, $D969 - $D968

LoggedData_0xD969:
INCBIN "baserom.gb", $D969, $D96D - $D969

UnknownData_0xD96D:
INCBIN "baserom.gb", $D96D, $D96E - $D96D

LoggedData_0xD96E:
INCBIN "baserom.gb", $D96E, $D971 - $D96E

UnknownData_0xD971:
INCBIN "baserom.gb", $D971, $D972 - $D971

LoggedData_0xD972:
INCBIN "baserom.gb", $D972, $D975 - $D972

UnknownData_0xD975:
INCBIN "baserom.gb", $D975, $D976 - $D975

LoggedData_0xD976:
INCBIN "baserom.gb", $D976, $D979 - $D976

UnknownData_0xD979:
INCBIN "baserom.gb", $D979, $D97A - $D979

LoggedData_0xD97A:
INCBIN "baserom.gb", $D97A, $D97D - $D97A

UnknownData_0xD97D:
INCBIN "baserom.gb", $D97D, $D97E - $D97D

LoggedData_0xD97E:
INCBIN "baserom.gb", $D97E, $D981 - $D97E

UnknownData_0xD981:
INCBIN "baserom.gb", $D981, $D982 - $D981

LoggedData_0xD982:
INCBIN "baserom.gb", $D982, $D986 - $D982

UnknownData_0xD986:
INCBIN "baserom.gb", $D986, $D987 - $D986

LoggedData_0xD987:
INCBIN "baserom.gb", $D987, $D98A - $D987

UnknownData_0xD98A:
INCBIN "baserom.gb", $D98A, $D98B - $D98A

LoggedData_0xD98B:
INCBIN "baserom.gb", $D98B, $D98E - $D98B

UnknownData_0xD98E:
INCBIN "baserom.gb", $D98E, $D98F - $D98E

LoggedData_0xD98F:
INCBIN "baserom.gb", $D98F, $D992 - $D98F

UnknownData_0xD992:
INCBIN "baserom.gb", $D992, $D993 - $D992

LoggedData_0xD993:
INCBIN "baserom.gb", $D993, $D996 - $D993

UnknownData_0xD996:
INCBIN "baserom.gb", $D996, $D997 - $D996

LoggedData_0xD997:
INCBIN "baserom.gb", $D997, $D99B - $D997

UnknownData_0xD99B:
INCBIN "baserom.gb", $D99B, $D99C - $D99B

LoggedData_0xD99C:
INCBIN "baserom.gb", $D99C, $D99F - $D99C

UnknownData_0xD99F:
INCBIN "baserom.gb", $D99F, $D9A0 - $D99F

LoggedData_0xD9A0:
INCBIN "baserom.gb", $D9A0, $D9A3 - $D9A0

UnknownData_0xD9A3:
INCBIN "baserom.gb", $D9A3, $D9A4 - $D9A3

LoggedData_0xD9A4:
INCBIN "baserom.gb", $D9A4, $D9A7 - $D9A4

UnknownData_0xD9A7:
INCBIN "baserom.gb", $D9A7, $D9A8 - $D9A7

LoggedData_0xD9A8:
INCBIN "baserom.gb", $D9A8, $D9AC - $D9A8

UnknownData_0xD9AC:
INCBIN "baserom.gb", $D9AC, $D9AD - $D9AC

LoggedData_0xD9AD:
INCBIN "baserom.gb", $D9AD, $D9B0 - $D9AD

UnknownData_0xD9B0:
INCBIN "baserom.gb", $D9B0, $D9B1 - $D9B0

LoggedData_0xD9B1:
INCBIN "baserom.gb", $D9B1, $D9B4 - $D9B1

UnknownData_0xD9B4:
INCBIN "baserom.gb", $D9B4, $D9B5 - $D9B4

LoggedData_0xD9B5:
INCBIN "baserom.gb", $D9B5, $D9B8 - $D9B5

UnknownData_0xD9B8:
INCBIN "baserom.gb", $D9B8, $D9B9 - $D9B8

LoggedData_0xD9B9:
INCBIN "baserom.gb", $D9B9, $D9BD - $D9B9

UnknownData_0xD9BD:
INCBIN "baserom.gb", $D9BD, $D9BE - $D9BD

LoggedData_0xD9BE:
INCBIN "baserom.gb", $D9BE, $D9C1 - $D9BE

UnknownData_0xD9C1:
INCBIN "baserom.gb", $D9C1, $D9C2 - $D9C1

LoggedData_0xD9C2:
INCBIN "baserom.gb", $D9C2, $D9C5 - $D9C2

UnknownData_0xD9C5:
INCBIN "baserom.gb", $D9C5, $D9C6 - $D9C5

LoggedData_0xD9C6:
INCBIN "baserom.gb", $D9C6, $D9C9 - $D9C6

UnknownData_0xD9C9:
INCBIN "baserom.gb", $D9C9, $D9CA - $D9C9

LoggedData_0xD9CA:
INCBIN "baserom.gb", $D9CA, $D9CE - $D9CA

UnknownData_0xD9CE:
INCBIN "baserom.gb", $D9CE, $D9CF - $D9CE

LoggedData_0xD9CF:
INCBIN "baserom.gb", $D9CF, $D9D2 - $D9CF

UnknownData_0xD9D2:
INCBIN "baserom.gb", $D9D2, $D9D3 - $D9D2

LoggedData_0xD9D3:
INCBIN "baserom.gb", $D9D3, $D9D6 - $D9D3

UnknownData_0xD9D6:
INCBIN "baserom.gb", $D9D6, $D9D7 - $D9D6

LoggedData_0xD9D7:
INCBIN "baserom.gb", $D9D7, $D9DA - $D9D7

UnknownData_0xD9DA:
INCBIN "baserom.gb", $D9DA, $D9DB - $D9DA

LoggedData_0xD9DB:
INCBIN "baserom.gb", $D9DB, $D9DF - $D9DB

UnknownData_0xD9DF:
INCBIN "baserom.gb", $D9DF, $D9E0 - $D9DF

LoggedData_0xD9E0:
INCBIN "baserom.gb", $D9E0, $D9E3 - $D9E0

UnknownData_0xD9E3:
INCBIN "baserom.gb", $D9E3, $D9E4 - $D9E3

LoggedData_0xD9E4:
INCBIN "baserom.gb", $D9E4, $D9E7 - $D9E4

UnknownData_0xD9E7:
INCBIN "baserom.gb", $D9E7, $D9E8 - $D9E7

LoggedData_0xD9E8:
INCBIN "baserom.gb", $D9E8, $D9EB - $D9E8

UnknownData_0xD9EB:
INCBIN "baserom.gb", $D9EB, $D9EC - $D9EB

LoggedData_0xD9EC:
INCBIN "baserom.gb", $D9EC, $D9F0 - $D9EC

UnknownData_0xD9F0:
INCBIN "baserom.gb", $D9F0, $D9F1 - $D9F0

LoggedData_0xD9F1:
INCBIN "baserom.gb", $D9F1, $D9F4 - $D9F1

UnknownData_0xD9F4:
INCBIN "baserom.gb", $D9F4, $D9F5 - $D9F4

LoggedData_0xD9F5:
INCBIN "baserom.gb", $D9F5, $D9F8 - $D9F5

UnknownData_0xD9F8:
INCBIN "baserom.gb", $D9F8, $D9F9 - $D9F8

LoggedData_0xD9F9:
INCBIN "baserom.gb", $D9F9, $D9FC - $D9F9

UnknownData_0xD9FC:
INCBIN "baserom.gb", $D9FC, $D9FD - $D9FC

LoggedData_0xD9FD:
INCBIN "baserom.gb", $D9FD, $DA01 - $D9FD

UnknownData_0xDA01:
INCBIN "baserom.gb", $DA01, $DA02 - $DA01

LoggedData_0xDA02:
INCBIN "baserom.gb", $DA02, $DA05 - $DA02

UnknownData_0xDA05:
INCBIN "baserom.gb", $DA05, $DA06 - $DA05

LoggedData_0xDA06:
INCBIN "baserom.gb", $DA06, $DA09 - $DA06

UnknownData_0xDA09:
INCBIN "baserom.gb", $DA09, $DA0A - $DA09

LoggedData_0xDA0A:
INCBIN "baserom.gb", $DA0A, $DA0D - $DA0A

UnknownData_0xDA0D:
INCBIN "baserom.gb", $DA0D, $DA0E - $DA0D

LoggedData_0xDA0E:
INCBIN "baserom.gb", $DA0E, $DA12 - $DA0E

UnknownData_0xDA12:
INCBIN "baserom.gb", $DA12, $DA13 - $DA12

LoggedData_0xDA13:
INCBIN "baserom.gb", $DA13, $DA16 - $DA13

UnknownData_0xDA16:
INCBIN "baserom.gb", $DA16, $DA17 - $DA16

LoggedData_0xDA17:
INCBIN "baserom.gb", $DA17, $DA1A - $DA17

UnknownData_0xDA1A:
INCBIN "baserom.gb", $DA1A, $DA1B - $DA1A

LoggedData_0xDA1B:
INCBIN "baserom.gb", $DA1B, $DA1E - $DA1B

UnknownData_0xDA1E:
INCBIN "baserom.gb", $DA1E, $DA1F - $DA1E

LoggedData_0xDA1F:
INCBIN "baserom.gb", $DA1F, $DA28 - $DA1F

UnknownData_0xDA28:
INCBIN "baserom.gb", $DA28, $DA2A - $DA28

LoggedData_0xDA2A:
INCBIN "baserom.gb", $DA2A, $DA32 - $DA2A

UnknownData_0xDA32:
INCBIN "baserom.gb", $DA32, $DA34 - $DA32

LoggedData_0xDA34:
INCBIN "baserom.gb", $DA34, $DA3C - $DA34

UnknownData_0xDA3C:
INCBIN "baserom.gb", $DA3C, $DA3E - $DA3C

LoggedData_0xDA3E:
INCBIN "baserom.gb", $DA3E, $DA46 - $DA3E

UnknownData_0xDA46:
INCBIN "baserom.gb", $DA46, $DA48 - $DA46

LoggedData_0xDA48:
INCBIN "baserom.gb", $DA48, $DA50 - $DA48

UnknownData_0xDA50:
INCBIN "baserom.gb", $DA50, $DA52 - $DA50

LoggedData_0xDA52:
INCBIN "baserom.gb", $DA52, $DA5A - $DA52

UnknownData_0xDA5A:
INCBIN "baserom.gb", $DA5A, $DA5C - $DA5A

LoggedData_0xDA5C:
INCBIN "baserom.gb", $DA5C, $DA64 - $DA5C

UnknownData_0xDA64:
INCBIN "baserom.gb", $DA64, $DA66 - $DA64

LoggedData_0xDA66:
INCBIN "baserom.gb", $DA66, $DA69 - $DA66

UnknownData_0xDA69:
INCBIN "baserom.gb", $DA69, $DA6A - $DA69

LoggedData_0xDA6A:
INCBIN "baserom.gb", $DA6A, $DA6D - $DA6A

UnknownData_0xDA6D:
INCBIN "baserom.gb", $DA6D, $DA6E - $DA6D

LoggedData_0xDA6E:
INCBIN "baserom.gb", $DA6E, $DA71 - $DA6E

UnknownData_0xDA71:
INCBIN "baserom.gb", $DA71, $DA72 - $DA71

LoggedData_0xDA72:
INCBIN "baserom.gb", $DA72, $DA75 - $DA72

UnknownData_0xDA75:
INCBIN "baserom.gb", $DA75, $DA76 - $DA75

LoggedData_0xDA76:
INCBIN "baserom.gb", $DA76, $DA7A - $DA76

UnknownData_0xDA7A:
INCBIN "baserom.gb", $DA7A, $DA7B - $DA7A

LoggedData_0xDA7B:
INCBIN "baserom.gb", $DA7B, $DA7E - $DA7B

UnknownData_0xDA7E:
INCBIN "baserom.gb", $DA7E, $DA7F - $DA7E

LoggedData_0xDA7F:
INCBIN "baserom.gb", $DA7F, $DA82 - $DA7F

UnknownData_0xDA82:
INCBIN "baserom.gb", $DA82, $DA83 - $DA82

LoggedData_0xDA83:
INCBIN "baserom.gb", $DA83, $DA86 - $DA83

UnknownData_0xDA86:
INCBIN "baserom.gb", $DA86, $DA87 - $DA86

LoggedData_0xDA87:
INCBIN "baserom.gb", $DA87, $DA8B - $DA87

UnknownData_0xDA8B:
INCBIN "baserom.gb", $DA8B, $DA8C - $DA8B

LoggedData_0xDA8C:
INCBIN "baserom.gb", $DA8C, $DA8F - $DA8C

UnknownData_0xDA8F:
INCBIN "baserom.gb", $DA8F, $DA90 - $DA8F

LoggedData_0xDA90:
INCBIN "baserom.gb", $DA90, $DA93 - $DA90

UnknownData_0xDA93:
INCBIN "baserom.gb", $DA93, $DA94 - $DA93

LoggedData_0xDA94:
INCBIN "baserom.gb", $DA94, $DA97 - $DA94

UnknownData_0xDA97:
INCBIN "baserom.gb", $DA97, $DA98 - $DA97

LoggedData_0xDA98:
INCBIN "baserom.gb", $DA98, $DA9C - $DA98

UnknownData_0xDA9C:
INCBIN "baserom.gb", $DA9C, $DA9D - $DA9C

LoggedData_0xDA9D:
INCBIN "baserom.gb", $DA9D, $DAA0 - $DA9D

UnknownData_0xDAA0:
INCBIN "baserom.gb", $DAA0, $DAA1 - $DAA0

LoggedData_0xDAA1:
INCBIN "baserom.gb", $DAA1, $DAA4 - $DAA1

UnknownData_0xDAA4:
INCBIN "baserom.gb", $DAA4, $DAA5 - $DAA4

LoggedData_0xDAA5:
INCBIN "baserom.gb", $DAA5, $DAA8 - $DAA5

UnknownData_0xDAA8:
INCBIN "baserom.gb", $DAA8, $DAA9 - $DAA8

LoggedData_0xDAA9:
INCBIN "baserom.gb", $DAA9, $DAAD - $DAA9

UnknownData_0xDAAD:
INCBIN "baserom.gb", $DAAD, $DAAE - $DAAD

LoggedData_0xDAAE:
INCBIN "baserom.gb", $DAAE, $DAB1 - $DAAE

UnknownData_0xDAB1:
INCBIN "baserom.gb", $DAB1, $DAB2 - $DAB1

LoggedData_0xDAB2:
INCBIN "baserom.gb", $DAB2, $DAB5 - $DAB2

UnknownData_0xDAB5:
INCBIN "baserom.gb", $DAB5, $DAB6 - $DAB5

LoggedData_0xDAB6:
INCBIN "baserom.gb", $DAB6, $DAB9 - $DAB6

UnknownData_0xDAB9:
INCBIN "baserom.gb", $DAB9, $DABA - $DAB9

LoggedData_0xDABA:
INCBIN "baserom.gb", $DABA, $DABE - $DABA

UnknownData_0xDABE:
INCBIN "baserom.gb", $DABE, $DABF - $DABE

LoggedData_0xDABF:
INCBIN "baserom.gb", $DABF, $DAC2 - $DABF

UnknownData_0xDAC2:
INCBIN "baserom.gb", $DAC2, $DAC3 - $DAC2

LoggedData_0xDAC3:
INCBIN "baserom.gb", $DAC3, $DAC6 - $DAC3

UnknownData_0xDAC6:
INCBIN "baserom.gb", $DAC6, $DAC7 - $DAC6

LoggedData_0xDAC7:
INCBIN "baserom.gb", $DAC7, $DACA - $DAC7

UnknownData_0xDACA:
INCBIN "baserom.gb", $DACA, $DACB - $DACA

LoggedData_0xDACB:
INCBIN "baserom.gb", $DACB, $DACF - $DACB

UnknownData_0xDACF:
INCBIN "baserom.gb", $DACF, $DAD0 - $DACF

LoggedData_0xDAD0:
INCBIN "baserom.gb", $DAD0, $DAD3 - $DAD0

UnknownData_0xDAD3:
INCBIN "baserom.gb", $DAD3, $DAD4 - $DAD3

LoggedData_0xDAD4:
INCBIN "baserom.gb", $DAD4, $DAD7 - $DAD4

UnknownData_0xDAD7:
INCBIN "baserom.gb", $DAD7, $DAD8 - $DAD7

LoggedData_0xDAD8:
INCBIN "baserom.gb", $DAD8, $DADB - $DAD8

UnknownData_0xDADB:
INCBIN "baserom.gb", $DADB, $DADC - $DADB

LoggedData_0xDADC:
INCBIN "baserom.gb", $DADC, $DAE0 - $DADC

UnknownData_0xDAE0:
INCBIN "baserom.gb", $DAE0, $DAE1 - $DAE0

LoggedData_0xDAE1:
INCBIN "baserom.gb", $DAE1, $DAE4 - $DAE1

UnknownData_0xDAE4:
INCBIN "baserom.gb", $DAE4, $DAE5 - $DAE4

LoggedData_0xDAE5:
INCBIN "baserom.gb", $DAE5, $DAE8 - $DAE5

UnknownData_0xDAE8:
INCBIN "baserom.gb", $DAE8, $DAE9 - $DAE8

LoggedData_0xDAE9:
INCBIN "baserom.gb", $DAE9, $DAEC - $DAE9

UnknownData_0xDAEC:
INCBIN "baserom.gb", $DAEC, $DAED - $DAEC

LoggedData_0xDAED:
INCBIN "baserom.gb", $DAED, $DAF1 - $DAED

UnknownData_0xDAF1:
INCBIN "baserom.gb", $DAF1, $DAF2 - $DAF1

LoggedData_0xDAF2:
INCBIN "baserom.gb", $DAF2, $DAF5 - $DAF2

UnknownData_0xDAF5:
INCBIN "baserom.gb", $DAF5, $DAF6 - $DAF5

LoggedData_0xDAF6:
INCBIN "baserom.gb", $DAF6, $DAF9 - $DAF6

UnknownData_0xDAF9:
INCBIN "baserom.gb", $DAF9, $DAFA - $DAF9

LoggedData_0xDAFA:
INCBIN "baserom.gb", $DAFA, $DAFD - $DAFA

UnknownData_0xDAFD:
INCBIN "baserom.gb", $DAFD, $DAFE - $DAFD

LoggedData_0xDAFE:
INCBIN "baserom.gb", $DAFE, $DB02 - $DAFE

UnknownData_0xDB02:
INCBIN "baserom.gb", $DB02, $DB03 - $DB02

LoggedData_0xDB03:
INCBIN "baserom.gb", $DB03, $DB06 - $DB03

UnknownData_0xDB06:
INCBIN "baserom.gb", $DB06, $DB07 - $DB06

LoggedData_0xDB07:
INCBIN "baserom.gb", $DB07, $DB0A - $DB07

UnknownData_0xDB0A:
INCBIN "baserom.gb", $DB0A, $DB0B - $DB0A

LoggedData_0xDB0B:
INCBIN "baserom.gb", $DB0B, $DB0E - $DB0B

UnknownData_0xDB0E:
INCBIN "baserom.gb", $DB0E, $DB0F - $DB0E

LoggedData_0xDB0F:
INCBIN "baserom.gb", $DB0F, $DB13 - $DB0F

UnknownData_0xDB13:
INCBIN "baserom.gb", $DB13, $DB14 - $DB13

LoggedData_0xDB14:
INCBIN "baserom.gb", $DB14, $DB17 - $DB14

UnknownData_0xDB17:
INCBIN "baserom.gb", $DB17, $DB18 - $DB17

LoggedData_0xDB18:
INCBIN "baserom.gb", $DB18, $DB1B - $DB18

UnknownData_0xDB1B:
INCBIN "baserom.gb", $DB1B, $DB1C - $DB1B

LoggedData_0xDB1C:
INCBIN "baserom.gb", $DB1C, $DB1F - $DB1C

UnknownData_0xDB1F:
INCBIN "baserom.gb", $DB1F, $DB20 - $DB1F

LoggedData_0xDB20:
INCBIN "baserom.gb", $DB20, $DB24 - $DB20

UnknownData_0xDB24:
INCBIN "baserom.gb", $DB24, $DB25 - $DB24

LoggedData_0xDB25:
INCBIN "baserom.gb", $DB25, $DB28 - $DB25

UnknownData_0xDB28:
INCBIN "baserom.gb", $DB28, $DB29 - $DB28

LoggedData_0xDB29:
INCBIN "baserom.gb", $DB29, $DB2C - $DB29

UnknownData_0xDB2C:
INCBIN "baserom.gb", $DB2C, $DB2D - $DB2C

LoggedData_0xDB2D:
INCBIN "baserom.gb", $DB2D, $DB30 - $DB2D

UnknownData_0xDB30:
INCBIN "baserom.gb", $DB30, $DB31 - $DB30

LoggedData_0xDB31:
INCBIN "baserom.gb", $DB31, $DB35 - $DB31

UnknownData_0xDB35:
INCBIN "baserom.gb", $DB35, $DB36 - $DB35

LoggedData_0xDB36:
INCBIN "baserom.gb", $DB36, $DB39 - $DB36

UnknownData_0xDB39:
INCBIN "baserom.gb", $DB39, $DB3A - $DB39

LoggedData_0xDB3A:
INCBIN "baserom.gb", $DB3A, $DB3D - $DB3A

UnknownData_0xDB3D:
INCBIN "baserom.gb", $DB3D, $DB3E - $DB3D

LoggedData_0xDB3E:
INCBIN "baserom.gb", $DB3E, $DB41 - $DB3E

UnknownData_0xDB41:
INCBIN "baserom.gb", $DB41, $DB42 - $DB41

LoggedData_0xDB42:
INCBIN "baserom.gb", $DB42, $DB45 - $DB42

UnknownData_0xDB45:
INCBIN "baserom.gb", $DB45, $DB46 - $DB45

LoggedData_0xDB46:
INCBIN "baserom.gb", $DB46, $DB4A - $DB46

UnknownData_0xDB4A:
INCBIN "baserom.gb", $DB4A, $DB4B - $DB4A

LoggedData_0xDB4B:
INCBIN "baserom.gb", $DB4B, $DB4E - $DB4B

UnknownData_0xDB4E:
INCBIN "baserom.gb", $DB4E, $DB4F - $DB4E

LoggedData_0xDB4F:
INCBIN "baserom.gb", $DB4F, $DB52 - $DB4F

UnknownData_0xDB52:
INCBIN "baserom.gb", $DB52, $DB53 - $DB52

LoggedData_0xDB53:
INCBIN "baserom.gb", $DB53, $DB56 - $DB53

UnknownData_0xDB56:
INCBIN "baserom.gb", $DB56, $DB57 - $DB56

LoggedData_0xDB57:
INCBIN "baserom.gb", $DB57, $DB5A - $DB57

UnknownData_0xDB5A:
INCBIN "baserom.gb", $DB5A, $DB5B - $DB5A

LoggedData_0xDB5B:
INCBIN "baserom.gb", $DB5B, $DB5E - $DB5B

UnknownData_0xDB5E:
INCBIN "baserom.gb", $DB5E, $DB5F - $DB5E

LoggedData_0xDB5F:
INCBIN "baserom.gb", $DB5F, $DB63 - $DB5F

UnknownData_0xDB63:
INCBIN "baserom.gb", $DB63, $DB64 - $DB63

LoggedData_0xDB64:
INCBIN "baserom.gb", $DB64, $DB67 - $DB64

UnknownData_0xDB67:
INCBIN "baserom.gb", $DB67, $DB68 - $DB67

LoggedData_0xDB68:
INCBIN "baserom.gb", $DB68, $DB6B - $DB68

UnknownData_0xDB6B:
INCBIN "baserom.gb", $DB6B, $DB6C - $DB6B

LoggedData_0xDB6C:
INCBIN "baserom.gb", $DB6C, $DB6F - $DB6C

UnknownData_0xDB6F:
INCBIN "baserom.gb", $DB6F, $DB70 - $DB6F

LoggedData_0xDB70:
INCBIN "baserom.gb", $DB70, $DB73 - $DB70

UnknownData_0xDB73:
INCBIN "baserom.gb", $DB73, $DB74 - $DB73

LoggedData_0xDB74:
INCBIN "baserom.gb", $DB74, $DB78 - $DB74

UnknownData_0xDB78:
INCBIN "baserom.gb", $DB78, $DB79 - $DB78

LoggedData_0xDB79:
INCBIN "baserom.gb", $DB79, $DB7C - $DB79

UnknownData_0xDB7C:
INCBIN "baserom.gb", $DB7C, $DB7D - $DB7C

LoggedData_0xDB7D:
INCBIN "baserom.gb", $DB7D, $DB80 - $DB7D

UnknownData_0xDB80:
INCBIN "baserom.gb", $DB80, $DB81 - $DB80

LoggedData_0xDB81:
INCBIN "baserom.gb", $DB81, $DB84 - $DB81

UnknownData_0xDB84:
INCBIN "baserom.gb", $DB84, $DB85 - $DB84

LoggedData_0xDB85:
INCBIN "baserom.gb", $DB85, $DB89 - $DB85

UnknownData_0xDB89:
INCBIN "baserom.gb", $DB89, $DB8A - $DB89

LoggedData_0xDB8A:
INCBIN "baserom.gb", $DB8A, $DB8D - $DB8A

UnknownData_0xDB8D:
INCBIN "baserom.gb", $DB8D, $DB8E - $DB8D

LoggedData_0xDB8E:
INCBIN "baserom.gb", $DB8E, $DB91 - $DB8E

UnknownData_0xDB91:
INCBIN "baserom.gb", $DB91, $DB92 - $DB91

LoggedData_0xDB92:
INCBIN "baserom.gb", $DB92, $DB95 - $DB92

UnknownData_0xDB95:
INCBIN "baserom.gb", $DB95, $DB96 - $DB95

LoggedData_0xDB96:
INCBIN "baserom.gb", $DB96, $DB99 - $DB96

UnknownData_0xDB99:
INCBIN "baserom.gb", $DB99, $DB9A - $DB99

LoggedData_0xDB9A:
INCBIN "baserom.gb", $DB9A, $DB9E - $DB9A

UnknownData_0xDB9E:
INCBIN "baserom.gb", $DB9E, $DB9F - $DB9E

LoggedData_0xDB9F:
INCBIN "baserom.gb", $DB9F, $DBA2 - $DB9F

UnknownData_0xDBA2:
INCBIN "baserom.gb", $DBA2, $DBA3 - $DBA2

LoggedData_0xDBA3:
INCBIN "baserom.gb", $DBA3, $DBA6 - $DBA3

UnknownData_0xDBA6:
INCBIN "baserom.gb", $DBA6, $DBA7 - $DBA6

LoggedData_0xDBA7:
INCBIN "baserom.gb", $DBA7, $DBAA - $DBA7

UnknownData_0xDBAA:
INCBIN "baserom.gb", $DBAA, $DBAB - $DBAA

LoggedData_0xDBAB:
INCBIN "baserom.gb", $DBAB, $DBAE - $DBAB

UnknownData_0xDBAE:
INCBIN "baserom.gb", $DBAE, $DBAF - $DBAE

LoggedData_0xDBAF:
INCBIN "baserom.gb", $DBAF, $DBB2 - $DBAF

UnknownData_0xDBB2:
INCBIN "baserom.gb", $DBB2, $DBB3 - $DBB2

LoggedData_0xDBB3:
INCBIN "baserom.gb", $DBB3, $DBB7 - $DBB3

UnknownData_0xDBB7:
INCBIN "baserom.gb", $DBB7, $DBB8 - $DBB7

LoggedData_0xDBB8:
INCBIN "baserom.gb", $DBB8, $DBBB - $DBB8

UnknownData_0xDBBB:
INCBIN "baserom.gb", $DBBB, $DBBC - $DBBB

LoggedData_0xDBBC:
INCBIN "baserom.gb", $DBBC, $DBBF - $DBBC

UnknownData_0xDBBF:
INCBIN "baserom.gb", $DBBF, $DBC0 - $DBBF

LoggedData_0xDBC0:
INCBIN "baserom.gb", $DBC0, $DBC3 - $DBC0

UnknownData_0xDBC3:
INCBIN "baserom.gb", $DBC3, $DBC4 - $DBC3

LoggedData_0xDBC4:
INCBIN "baserom.gb", $DBC4, $DBC7 - $DBC4

UnknownData_0xDBC7:
INCBIN "baserom.gb", $DBC7, $DBC8 - $DBC7

LoggedData_0xDBC8:
INCBIN "baserom.gb", $DBC8, $DBCC - $DBC8

UnknownData_0xDBCC:
INCBIN "baserom.gb", $DBCC, $DBCD - $DBCC

LoggedData_0xDBCD:
INCBIN "baserom.gb", $DBCD, $DBD0 - $DBCD

UnknownData_0xDBD0:
INCBIN "baserom.gb", $DBD0, $DBD1 - $DBD0

LoggedData_0xDBD1:
INCBIN "baserom.gb", $DBD1, $DBD4 - $DBD1

UnknownData_0xDBD4:
INCBIN "baserom.gb", $DBD4, $DBD5 - $DBD4

LoggedData_0xDBD5:
INCBIN "baserom.gb", $DBD5, $DBD8 - $DBD5

UnknownData_0xDBD8:
INCBIN "baserom.gb", $DBD8, $DBD9 - $DBD8

LoggedData_0xDBD9:
INCBIN "baserom.gb", $DBD9, $DBDD - $DBD9

UnknownData_0xDBDD:
INCBIN "baserom.gb", $DBDD, $DBDE - $DBDD

LoggedData_0xDBDE:
INCBIN "baserom.gb", $DBDE, $DBE1 - $DBDE

UnknownData_0xDBE1:
INCBIN "baserom.gb", $DBE1, $DBE2 - $DBE1

LoggedData_0xDBE2:
INCBIN "baserom.gb", $DBE2, $DBE5 - $DBE2

UnknownData_0xDBE5:
INCBIN "baserom.gb", $DBE5, $DBE6 - $DBE5

LoggedData_0xDBE6:
INCBIN "baserom.gb", $DBE6, $DBE9 - $DBE6

UnknownData_0xDBE9:
INCBIN "baserom.gb", $DBE9, $DBEA - $DBE9

LoggedData_0xDBEA:
INCBIN "baserom.gb", $DBEA, $DBEE - $DBEA

UnknownData_0xDBEE:
INCBIN "baserom.gb", $DBEE, $DBEF - $DBEE

LoggedData_0xDBEF:
INCBIN "baserom.gb", $DBEF, $DBF2 - $DBEF

UnknownData_0xDBF2:
INCBIN "baserom.gb", $DBF2, $DBF3 - $DBF2

LoggedData_0xDBF3:
INCBIN "baserom.gb", $DBF3, $DBF6 - $DBF3

UnknownData_0xDBF6:
INCBIN "baserom.gb", $DBF6, $DBF7 - $DBF6

LoggedData_0xDBF7:
INCBIN "baserom.gb", $DBF7, $DBFA - $DBF7

UnknownData_0xDBFA:
INCBIN "baserom.gb", $DBFA, $DBFB - $DBFA

LoggedData_0xDBFB:
INCBIN "baserom.gb", $DBFB, $DBFF - $DBFB

UnknownData_0xDBFF:
INCBIN "baserom.gb", $DBFF, $DC00 - $DBFF

LoggedData_0xDC00:
INCBIN "baserom.gb", $DC00, $DC03 - $DC00

UnknownData_0xDC03:
INCBIN "baserom.gb", $DC03, $DC04 - $DC03

LoggedData_0xDC04:
INCBIN "baserom.gb", $DC04, $DC07 - $DC04

UnknownData_0xDC07:
INCBIN "baserom.gb", $DC07, $DC08 - $DC07

LoggedData_0xDC08:
INCBIN "baserom.gb", $DC08, $DC0B - $DC08

UnknownData_0xDC0B:
INCBIN "baserom.gb", $DC0B, $DC0C - $DC0B

LoggedData_0xDC0C:
INCBIN "baserom.gb", $DC0C, $DC10 - $DC0C

UnknownData_0xDC10:
INCBIN "baserom.gb", $DC10, $DC11 - $DC10

LoggedData_0xDC11:
INCBIN "baserom.gb", $DC11, $DC14 - $DC11

UnknownData_0xDC14:
INCBIN "baserom.gb", $DC14, $DC15 - $DC14

LoggedData_0xDC15:
INCBIN "baserom.gb", $DC15, $DC18 - $DC15

UnknownData_0xDC18:
INCBIN "baserom.gb", $DC18, $DC19 - $DC18

LoggedData_0xDC19:
INCBIN "baserom.gb", $DC19, $DC1C - $DC19

UnknownData_0xDC1C:
INCBIN "baserom.gb", $DC1C, $DC1D - $DC1C

LoggedData_0xDC1D:
INCBIN "baserom.gb", $DC1D, $DC21 - $DC1D

UnknownData_0xDC21:
INCBIN "baserom.gb", $DC21, $DC22 - $DC21

LoggedData_0xDC22:
INCBIN "baserom.gb", $DC22, $DC25 - $DC22

UnknownData_0xDC25:
INCBIN "baserom.gb", $DC25, $DC26 - $DC25

LoggedData_0xDC26:
INCBIN "baserom.gb", $DC26, $DC29 - $DC26

UnknownData_0xDC29:
INCBIN "baserom.gb", $DC29, $DC2A - $DC29

LoggedData_0xDC2A:
INCBIN "baserom.gb", $DC2A, $DC2D - $DC2A

UnknownData_0xDC2D:
INCBIN "baserom.gb", $DC2D, $DC2E - $DC2D

LoggedData_0xDC2E:
INCBIN "baserom.gb", $DC2E, $DC32 - $DC2E

UnknownData_0xDC32:
INCBIN "baserom.gb", $DC32, $DC33 - $DC32

LoggedData_0xDC33:
INCBIN "baserom.gb", $DC33, $DC36 - $DC33

UnknownData_0xDC36:
INCBIN "baserom.gb", $DC36, $DC37 - $DC36

LoggedData_0xDC37:
INCBIN "baserom.gb", $DC37, $DC3A - $DC37

UnknownData_0xDC3A:
INCBIN "baserom.gb", $DC3A, $DC3B - $DC3A

LoggedData_0xDC3B:
INCBIN "baserom.gb", $DC3B, $DC3E - $DC3B

UnknownData_0xDC3E:
INCBIN "baserom.gb", $DC3E, $DC3F - $DC3E

LoggedData_0xDC3F:
INCBIN "baserom.gb", $DC3F, $DC43 - $DC3F

UnknownData_0xDC43:
INCBIN "baserom.gb", $DC43, $DC44 - $DC43

LoggedData_0xDC44:
INCBIN "baserom.gb", $DC44, $DC47 - $DC44

UnknownData_0xDC47:
INCBIN "baserom.gb", $DC47, $DC48 - $DC47

LoggedData_0xDC48:
INCBIN "baserom.gb", $DC48, $DC4B - $DC48

UnknownData_0xDC4B:
INCBIN "baserom.gb", $DC4B, $DC4C - $DC4B

LoggedData_0xDC4C:
INCBIN "baserom.gb", $DC4C, $DC4F - $DC4C

UnknownData_0xDC4F:
INCBIN "baserom.gb", $DC4F, $DC50 - $DC4F

LoggedData_0xDC50:
INCBIN "baserom.gb", $DC50, $DC54 - $DC50

UnknownData_0xDC54:
INCBIN "baserom.gb", $DC54, $DC55 - $DC54

LoggedData_0xDC55:
INCBIN "baserom.gb", $DC55, $DC58 - $DC55

UnknownData_0xDC58:
INCBIN "baserom.gb", $DC58, $DC59 - $DC58

LoggedData_0xDC59:
INCBIN "baserom.gb", $DC59, $DC5C - $DC59

UnknownData_0xDC5C:
INCBIN "baserom.gb", $DC5C, $DC5D - $DC5C

LoggedData_0xDC5D:
INCBIN "baserom.gb", $DC5D, $DC60 - $DC5D

UnknownData_0xDC60:
INCBIN "baserom.gb", $DC60, $DC61 - $DC60

LoggedData_0xDC61:
INCBIN "baserom.gb", $DC61, $DC6A - $DC61

UnknownData_0xDC6A:
INCBIN "baserom.gb", $DC6A, $DC6C - $DC6A

LoggedData_0xDC6C:
INCBIN "baserom.gb", $DC6C, $DC74 - $DC6C

UnknownData_0xDC74:
INCBIN "baserom.gb", $DC74, $DC76 - $DC74

LoggedData_0xDC76:
INCBIN "baserom.gb", $DC76, $DC7E - $DC76

UnknownData_0xDC7E:
INCBIN "baserom.gb", $DC7E, $DC80 - $DC7E

LoggedData_0xDC80:
INCBIN "baserom.gb", $DC80, $DC86 - $DC80

UnknownData_0xDC86:
INCBIN "baserom.gb", $DC86, $DC8A - $DC86

LoggedData_0xDC8A:
INCBIN "baserom.gb", $DC8A, $DC92 - $DC8A

UnknownData_0xDC92:
INCBIN "baserom.gb", $DC92, $DC94 - $DC92

LoggedData_0xDC94:
INCBIN "baserom.gb", $DC94, $DC9C - $DC94

UnknownData_0xDC9C:
INCBIN "baserom.gb", $DC9C, $DC9E - $DC9C

LoggedData_0xDC9E:
INCBIN "baserom.gb", $DC9E, $DCA6 - $DC9E

UnknownData_0xDCA6:
INCBIN "baserom.gb", $DCA6, $DCA8 - $DCA6

LoggedData_0xDCA8:
INCBIN "baserom.gb", $DCA8, $DCAB - $DCA8

UnknownData_0xDCAB:
INCBIN "baserom.gb", $DCAB, $DCAC - $DCAB

LoggedData_0xDCAC:
INCBIN "baserom.gb", $DCAC, $DCAF - $DCAC

UnknownData_0xDCAF:
INCBIN "baserom.gb", $DCAF, $DCB0 - $DCAF

LoggedData_0xDCB0:
INCBIN "baserom.gb", $DCB0, $DCB3 - $DCB0

UnknownData_0xDCB3:
INCBIN "baserom.gb", $DCB3, $DCB4 - $DCB3

LoggedData_0xDCB4:
INCBIN "baserom.gb", $DCB4, $DCB7 - $DCB4

UnknownData_0xDCB7:
INCBIN "baserom.gb", $DCB7, $DCB8 - $DCB7

LoggedData_0xDCB8:
INCBIN "baserom.gb", $DCB8, $DCBC - $DCB8

UnknownData_0xDCBC:
INCBIN "baserom.gb", $DCBC, $DCBD - $DCBC

LoggedData_0xDCBD:
INCBIN "baserom.gb", $DCBD, $DCC0 - $DCBD

UnknownData_0xDCC0:
INCBIN "baserom.gb", $DCC0, $DCC1 - $DCC0

LoggedData_0xDCC1:
INCBIN "baserom.gb", $DCC1, $DCC4 - $DCC1

UnknownData_0xDCC4:
INCBIN "baserom.gb", $DCC4, $DCC5 - $DCC4

LoggedData_0xDCC5:
INCBIN "baserom.gb", $DCC5, $DCC8 - $DCC5

UnknownData_0xDCC8:
INCBIN "baserom.gb", $DCC8, $DCC9 - $DCC8

LoggedData_0xDCC9:
INCBIN "baserom.gb", $DCC9, $DCCD - $DCC9

UnknownData_0xDCCD:
INCBIN "baserom.gb", $DCCD, $DCCE - $DCCD

LoggedData_0xDCCE:
INCBIN "baserom.gb", $DCCE, $DCD1 - $DCCE

UnknownData_0xDCD1:
INCBIN "baserom.gb", $DCD1, $DCD2 - $DCD1

LoggedData_0xDCD2:
INCBIN "baserom.gb", $DCD2, $DCD5 - $DCD2

UnknownData_0xDCD5:
INCBIN "baserom.gb", $DCD5, $DCD6 - $DCD5

LoggedData_0xDCD6:
INCBIN "baserom.gb", $DCD6, $DCD9 - $DCD6

UnknownData_0xDCD9:
INCBIN "baserom.gb", $DCD9, $DCDA - $DCD9

LoggedData_0xDCDA:
INCBIN "baserom.gb", $DCDA, $DCDE - $DCDA

UnknownData_0xDCDE:
INCBIN "baserom.gb", $DCDE, $DCDF - $DCDE

LoggedData_0xDCDF:
INCBIN "baserom.gb", $DCDF, $DCE2 - $DCDF

UnknownData_0xDCE2:
INCBIN "baserom.gb", $DCE2, $DCE3 - $DCE2

LoggedData_0xDCE3:
INCBIN "baserom.gb", $DCE3, $DCE6 - $DCE3

UnknownData_0xDCE6:
INCBIN "baserom.gb", $DCE6, $DCE7 - $DCE6

LoggedData_0xDCE7:
INCBIN "baserom.gb", $DCE7, $DCEA - $DCE7

UnknownData_0xDCEA:
INCBIN "baserom.gb", $DCEA, $DCEB - $DCEA

LoggedData_0xDCEB:
INCBIN "baserom.gb", $DCEB, $DCEF - $DCEB

UnknownData_0xDCEF:
INCBIN "baserom.gb", $DCEF, $DCF0 - $DCEF

LoggedData_0xDCF0:
INCBIN "baserom.gb", $DCF0, $DCF3 - $DCF0

UnknownData_0xDCF3:
INCBIN "baserom.gb", $DCF3, $DCF4 - $DCF3

LoggedData_0xDCF4:
INCBIN "baserom.gb", $DCF4, $DCF7 - $DCF4

UnknownData_0xDCF7:
INCBIN "baserom.gb", $DCF7, $DCF8 - $DCF7

LoggedData_0xDCF8:
INCBIN "baserom.gb", $DCF8, $DCFB - $DCF8

UnknownData_0xDCFB:
INCBIN "baserom.gb", $DCFB, $DCFC - $DCFB

LoggedData_0xDCFC:
INCBIN "baserom.gb", $DCFC, $DD00 - $DCFC

UnknownData_0xDD00:
INCBIN "baserom.gb", $DD00, $DD01 - $DD00

LoggedData_0xDD01:
INCBIN "baserom.gb", $DD01, $DD04 - $DD01

UnknownData_0xDD04:
INCBIN "baserom.gb", $DD04, $DD05 - $DD04

LoggedData_0xDD05:
INCBIN "baserom.gb", $DD05, $DD08 - $DD05

UnknownData_0xDD08:
INCBIN "baserom.gb", $DD08, $DD09 - $DD08

LoggedData_0xDD09:
INCBIN "baserom.gb", $DD09, $DD0C - $DD09

UnknownData_0xDD0C:
INCBIN "baserom.gb", $DD0C, $DD0D - $DD0C

LoggedData_0xDD0D:
INCBIN "baserom.gb", $DD0D, $DD11 - $DD0D

UnknownData_0xDD11:
INCBIN "baserom.gb", $DD11, $DD12 - $DD11

LoggedData_0xDD12:
INCBIN "baserom.gb", $DD12, $DD15 - $DD12

UnknownData_0xDD15:
INCBIN "baserom.gb", $DD15, $DD16 - $DD15

LoggedData_0xDD16:
INCBIN "baserom.gb", $DD16, $DD19 - $DD16

UnknownData_0xDD19:
INCBIN "baserom.gb", $DD19, $DD1A - $DD19

LoggedData_0xDD1A:
INCBIN "baserom.gb", $DD1A, $DD1D - $DD1A

UnknownData_0xDD1D:
INCBIN "baserom.gb", $DD1D, $DD1E - $DD1D

LoggedData_0xDD1E:
INCBIN "baserom.gb", $DD1E, $DD22 - $DD1E

UnknownData_0xDD22:
INCBIN "baserom.gb", $DD22, $DD23 - $DD22

LoggedData_0xDD23:
INCBIN "baserom.gb", $DD23, $DD26 - $DD23

UnknownData_0xDD26:
INCBIN "baserom.gb", $DD26, $DD27 - $DD26

LoggedData_0xDD27:
INCBIN "baserom.gb", $DD27, $DD2A - $DD27

UnknownData_0xDD2A:
INCBIN "baserom.gb", $DD2A, $DD2B - $DD2A

LoggedData_0xDD2B:
INCBIN "baserom.gb", $DD2B, $DD2E - $DD2B

UnknownData_0xDD2E:
INCBIN "baserom.gb", $DD2E, $DD2F - $DD2E

LoggedData_0xDD2F:
INCBIN "baserom.gb", $DD2F, $DD33 - $DD2F

UnknownData_0xDD33:
INCBIN "baserom.gb", $DD33, $DD34 - $DD33

LoggedData_0xDD34:
INCBIN "baserom.gb", $DD34, $DD37 - $DD34

UnknownData_0xDD37:
INCBIN "baserom.gb", $DD37, $DD38 - $DD37

LoggedData_0xDD38:
INCBIN "baserom.gb", $DD38, $DD3B - $DD38

UnknownData_0xDD3B:
INCBIN "baserom.gb", $DD3B, $DD3C - $DD3B

LoggedData_0xDD3C:
INCBIN "baserom.gb", $DD3C, $DD3F - $DD3C

UnknownData_0xDD3F:
INCBIN "baserom.gb", $DD3F, $DD40 - $DD3F

LoggedData_0xDD40:
INCBIN "baserom.gb", $DD40, $DD44 - $DD40

UnknownData_0xDD44:
INCBIN "baserom.gb", $DD44, $DD45 - $DD44

LoggedData_0xDD45:
INCBIN "baserom.gb", $DD45, $DD48 - $DD45

UnknownData_0xDD48:
INCBIN "baserom.gb", $DD48, $DD49 - $DD48

LoggedData_0xDD49:
INCBIN "baserom.gb", $DD49, $DD4C - $DD49

UnknownData_0xDD4C:
INCBIN "baserom.gb", $DD4C, $DD4D - $DD4C

LoggedData_0xDD4D:
INCBIN "baserom.gb", $DD4D, $DD50 - $DD4D

UnknownData_0xDD50:
INCBIN "baserom.gb", $DD50, $DD51 - $DD50

LoggedData_0xDD51:
INCBIN "baserom.gb", $DD51, $DD55 - $DD51

UnknownData_0xDD55:
INCBIN "baserom.gb", $DD55, $DD56 - $DD55

LoggedData_0xDD56:
INCBIN "baserom.gb", $DD56, $DD59 - $DD56

UnknownData_0xDD59:
INCBIN "baserom.gb", $DD59, $DD5A - $DD59

LoggedData_0xDD5A:
INCBIN "baserom.gb", $DD5A, $DD5D - $DD5A

UnknownData_0xDD5D:
INCBIN "baserom.gb", $DD5D, $DD5E - $DD5D

LoggedData_0xDD5E:
INCBIN "baserom.gb", $DD5E, $DD61 - $DD5E

UnknownData_0xDD61:
INCBIN "baserom.gb", $DD61, $DD62 - $DD61

LoggedData_0xDD62:
INCBIN "baserom.gb", $DD62, $DD66 - $DD62

UnknownData_0xDD66:
INCBIN "baserom.gb", $DD66, $DD67 - $DD66

LoggedData_0xDD67:
INCBIN "baserom.gb", $DD67, $DD6A - $DD67

UnknownData_0xDD6A:
INCBIN "baserom.gb", $DD6A, $DD6B - $DD6A

LoggedData_0xDD6B:
INCBIN "baserom.gb", $DD6B, $DD6E - $DD6B

UnknownData_0xDD6E:
INCBIN "baserom.gb", $DD6E, $DD6F - $DD6E

LoggedData_0xDD6F:
INCBIN "baserom.gb", $DD6F, $DD72 - $DD6F

UnknownData_0xDD72:
INCBIN "baserom.gb", $DD72, $DD73 - $DD72

LoggedData_0xDD73:
INCBIN "baserom.gb", $DD73, $DD77 - $DD73

UnknownData_0xDD77:
INCBIN "baserom.gb", $DD77, $DD78 - $DD77

LoggedData_0xDD78:
INCBIN "baserom.gb", $DD78, $DD7B - $DD78

UnknownData_0xDD7B:
INCBIN "baserom.gb", $DD7B, $DD7C - $DD7B

LoggedData_0xDD7C:
INCBIN "baserom.gb", $DD7C, $DD7F - $DD7C

UnknownData_0xDD7F:
INCBIN "baserom.gb", $DD7F, $DD80 - $DD7F

LoggedData_0xDD80:
INCBIN "baserom.gb", $DD80, $DD83 - $DD80

UnknownData_0xDD83:
INCBIN "baserom.gb", $DD83, $DD84 - $DD83

LoggedData_0xDD84:
INCBIN "baserom.gb", $DD84, $DD87 - $DD84

UnknownData_0xDD87:
INCBIN "baserom.gb", $DD87, $DD88 - $DD87

LoggedData_0xDD88:
INCBIN "baserom.gb", $DD88, $DD8C - $DD88

UnknownData_0xDD8C:
INCBIN "baserom.gb", $DD8C, $DD8D - $DD8C

LoggedData_0xDD8D:
INCBIN "baserom.gb", $DD8D, $DD90 - $DD8D

UnknownData_0xDD90:
INCBIN "baserom.gb", $DD90, $DD91 - $DD90

LoggedData_0xDD91:
INCBIN "baserom.gb", $DD91, $DD94 - $DD91

UnknownData_0xDD94:
INCBIN "baserom.gb", $DD94, $DD95 - $DD94

LoggedData_0xDD95:
INCBIN "baserom.gb", $DD95, $DD98 - $DD95

UnknownData_0xDD98:
INCBIN "baserom.gb", $DD98, $DD99 - $DD98

LoggedData_0xDD99:
INCBIN "baserom.gb", $DD99, $DD9C - $DD99

UnknownData_0xDD9C:
INCBIN "baserom.gb", $DD9C, $DD9D - $DD9C

LoggedData_0xDD9D:
INCBIN "baserom.gb", $DD9D, $DDA0 - $DD9D

UnknownData_0xDDA0:
INCBIN "baserom.gb", $DDA0, $DDA1 - $DDA0

LoggedData_0xDDA1:
INCBIN "baserom.gb", $DDA1, $DDA5 - $DDA1

UnknownData_0xDDA5:
INCBIN "baserom.gb", $DDA5, $DDA6 - $DDA5

LoggedData_0xDDA6:
INCBIN "baserom.gb", $DDA6, $DDA9 - $DDA6

UnknownData_0xDDA9:
INCBIN "baserom.gb", $DDA9, $DDAA - $DDA9

LoggedData_0xDDAA:
INCBIN "baserom.gb", $DDAA, $DDAD - $DDAA

UnknownData_0xDDAD:
INCBIN "baserom.gb", $DDAD, $DDAE - $DDAD

LoggedData_0xDDAE:
INCBIN "baserom.gb", $DDAE, $DDB1 - $DDAE

UnknownData_0xDDB1:
INCBIN "baserom.gb", $DDB1, $DDB2 - $DDB1

LoggedData_0xDDB2:
INCBIN "baserom.gb", $DDB2, $DDB5 - $DDB2

UnknownData_0xDDB5:
INCBIN "baserom.gb", $DDB5, $DDB6 - $DDB5

LoggedData_0xDDB6:
INCBIN "baserom.gb", $DDB6, $DDB7 - $DDB6

UnknownData_0xDDB7:
INCBIN "baserom.gb", $DDB7, $DDC8 - $DDB7

LoggedData_0xDDC8:
INCBIN "baserom.gb", $DDC8, $DDCB - $DDC8

UnknownData_0xDDCB:
INCBIN "baserom.gb", $DDCB, $DDCC - $DDCB

LoggedData_0xDDCC:
INCBIN "baserom.gb", $DDCC, $DDCF - $DDCC

UnknownData_0xDDCF:
INCBIN "baserom.gb", $DDCF, $DDD0 - $DDCF

LoggedData_0xDDD0:
INCBIN "baserom.gb", $DDD0, $DDD3 - $DDD0

UnknownData_0xDDD3:
INCBIN "baserom.gb", $DDD3, $DDD4 - $DDD3

LoggedData_0xDDD4:
INCBIN "baserom.gb", $DDD4, $DDD7 - $DDD4

UnknownData_0xDDD7:
INCBIN "baserom.gb", $DDD7, $DDD8 - $DDD7

LoggedData_0xDDD8:
INCBIN "baserom.gb", $DDD8, $DDDB - $DDD8

UnknownData_0xDDDB:
INCBIN "baserom.gb", $DDDB, $DDDC - $DDDB

LoggedData_0xDDDC:
INCBIN "baserom.gb", $DDDC, $DDE0 - $DDDC

UnknownData_0xDDE0:
INCBIN "baserom.gb", $DDE0, $DDE1 - $DDE0

LoggedData_0xDDE1:
INCBIN "baserom.gb", $DDE1, $DDE4 - $DDE1

UnknownData_0xDDE4:
INCBIN "baserom.gb", $DDE4, $DDE5 - $DDE4

LoggedData_0xDDE5:
INCBIN "baserom.gb", $DDE5, $DDE8 - $DDE5

UnknownData_0xDDE8:
INCBIN "baserom.gb", $DDE8, $DDE9 - $DDE8

LoggedData_0xDDE9:
INCBIN "baserom.gb", $DDE9, $DDEC - $DDE9

UnknownData_0xDDEC:
INCBIN "baserom.gb", $DDEC, $DDED - $DDEC

LoggedData_0xDDED:
INCBIN "baserom.gb", $DDED, $DDF0 - $DDED

UnknownData_0xDDF0:
INCBIN "baserom.gb", $DDF0, $DDF1 - $DDF0

LoggedData_0xDDF1:
INCBIN "baserom.gb", $DDF1, $DDF4 - $DDF1

UnknownData_0xDDF4:
INCBIN "baserom.gb", $DDF4, $DDF5 - $DDF4

LoggedData_0xDDF5:
INCBIN "baserom.gb", $DDF5, $DDF9 - $DDF5

UnknownData_0xDDF9:
INCBIN "baserom.gb", $DDF9, $DDFA - $DDF9

LoggedData_0xDDFA:
INCBIN "baserom.gb", $DDFA, $DDFD - $DDFA

UnknownData_0xDDFD:
INCBIN "baserom.gb", $DDFD, $DDFE - $DDFD

LoggedData_0xDDFE:
INCBIN "baserom.gb", $DDFE, $DE01 - $DDFE

UnknownData_0xDE01:
INCBIN "baserom.gb", $DE01, $DE02 - $DE01

LoggedData_0xDE02:
INCBIN "baserom.gb", $DE02, $DE05 - $DE02

UnknownData_0xDE05:
INCBIN "baserom.gb", $DE05, $DE06 - $DE05

LoggedData_0xDE06:
INCBIN "baserom.gb", $DE06, $DE09 - $DE06

UnknownData_0xDE09:
INCBIN "baserom.gb", $DE09, $DE0A - $DE09

LoggedData_0xDE0A:
INCBIN "baserom.gb", $DE0A, $DE0E - $DE0A

UnknownData_0xDE0E:
INCBIN "baserom.gb", $DE0E, $DE0F - $DE0E

LoggedData_0xDE0F:
INCBIN "baserom.gb", $DE0F, $DE12 - $DE0F

UnknownData_0xDE12:
INCBIN "baserom.gb", $DE12, $DE13 - $DE12

LoggedData_0xDE13:
INCBIN "baserom.gb", $DE13, $DE16 - $DE13

UnknownData_0xDE16:
INCBIN "baserom.gb", $DE16, $DE17 - $DE16

LoggedData_0xDE17:
INCBIN "baserom.gb", $DE17, $DE1A - $DE17

UnknownData_0xDE1A:
INCBIN "baserom.gb", $DE1A, $DE1B - $DE1A

LoggedData_0xDE1B:
INCBIN "baserom.gb", $DE1B, $DE1F - $DE1B

UnknownData_0xDE1F:
INCBIN "baserom.gb", $DE1F, $DE20 - $DE1F

LoggedData_0xDE20:
INCBIN "baserom.gb", $DE20, $DE23 - $DE20

UnknownData_0xDE23:
INCBIN "baserom.gb", $DE23, $DE24 - $DE23

LoggedData_0xDE24:
INCBIN "baserom.gb", $DE24, $DE27 - $DE24

UnknownData_0xDE27:
INCBIN "baserom.gb", $DE27, $DE28 - $DE27

LoggedData_0xDE28:
INCBIN "baserom.gb", $DE28, $DE2B - $DE28

UnknownData_0xDE2B:
INCBIN "baserom.gb", $DE2B, $DE2C - $DE2B

LoggedData_0xDE2C:
INCBIN "baserom.gb", $DE2C, $DE30 - $DE2C

UnknownData_0xDE30:
INCBIN "baserom.gb", $DE30, $DE31 - $DE30

LoggedData_0xDE31:
INCBIN "baserom.gb", $DE31, $DE34 - $DE31

UnknownData_0xDE34:
INCBIN "baserom.gb", $DE34, $DE35 - $DE34

LoggedData_0xDE35:
INCBIN "baserom.gb", $DE35, $DE38 - $DE35

UnknownData_0xDE38:
INCBIN "baserom.gb", $DE38, $DE39 - $DE38

LoggedData_0xDE39:
INCBIN "baserom.gb", $DE39, $DE3C - $DE39

UnknownData_0xDE3C:
INCBIN "baserom.gb", $DE3C, $DE3D - $DE3C

LoggedData_0xDE3D:
INCBIN "baserom.gb", $DE3D, $DE41 - $DE3D

UnknownData_0xDE41:
INCBIN "baserom.gb", $DE41, $DE42 - $DE41

LoggedData_0xDE42:
INCBIN "baserom.gb", $DE42, $DE45 - $DE42

UnknownData_0xDE45:
INCBIN "baserom.gb", $DE45, $DE46 - $DE45

LoggedData_0xDE46:
INCBIN "baserom.gb", $DE46, $DE49 - $DE46

UnknownData_0xDE49:
INCBIN "baserom.gb", $DE49, $DE4A - $DE49

LoggedData_0xDE4A:
INCBIN "baserom.gb", $DE4A, $DE4D - $DE4A

UnknownData_0xDE4D:
INCBIN "baserom.gb", $DE4D, $DE4E - $DE4D

LoggedData_0xDE4E:
INCBIN "baserom.gb", $DE4E, $DE52 - $DE4E

UnknownData_0xDE52:
INCBIN "baserom.gb", $DE52, $DE53 - $DE52

LoggedData_0xDE53:
INCBIN "baserom.gb", $DE53, $DE56 - $DE53

UnknownData_0xDE56:
INCBIN "baserom.gb", $DE56, $DE57 - $DE56

LoggedData_0xDE57:
INCBIN "baserom.gb", $DE57, $DE5A - $DE57

UnknownData_0xDE5A:
INCBIN "baserom.gb", $DE5A, $DE5B - $DE5A

LoggedData_0xDE5B:
INCBIN "baserom.gb", $DE5B, $DE5E - $DE5B

UnknownData_0xDE5E:
INCBIN "baserom.gb", $DE5E, $DE5F - $DE5E

LoggedData_0xDE5F:
INCBIN "baserom.gb", $DE5F, $DE63 - $DE5F

UnknownData_0xDE63:
INCBIN "baserom.gb", $DE63, $DE64 - $DE63

LoggedData_0xDE64:
INCBIN "baserom.gb", $DE64, $DE67 - $DE64

UnknownData_0xDE67:
INCBIN "baserom.gb", $DE67, $DE68 - $DE67

LoggedData_0xDE68:
INCBIN "baserom.gb", $DE68, $DE6B - $DE68

UnknownData_0xDE6B:
INCBIN "baserom.gb", $DE6B, $DE6C - $DE6B

LoggedData_0xDE6C:
INCBIN "baserom.gb", $DE6C, $DE6F - $DE6C

UnknownData_0xDE6F:
INCBIN "baserom.gb", $DE6F, $DE70 - $DE6F

LoggedData_0xDE70:
INCBIN "baserom.gb", $DE70, $DE74 - $DE70

UnknownData_0xDE74:
INCBIN "baserom.gb", $DE74, $DE75 - $DE74

LoggedData_0xDE75:
INCBIN "baserom.gb", $DE75, $DE78 - $DE75

UnknownData_0xDE78:
INCBIN "baserom.gb", $DE78, $DE79 - $DE78

LoggedData_0xDE79:
INCBIN "baserom.gb", $DE79, $DE7C - $DE79

UnknownData_0xDE7C:
INCBIN "baserom.gb", $DE7C, $DE7D - $DE7C

LoggedData_0xDE7D:
INCBIN "baserom.gb", $DE7D, $DE80 - $DE7D

UnknownData_0xDE80:
INCBIN "baserom.gb", $DE80, $DE81 - $DE80

LoggedData_0xDE81:
INCBIN "baserom.gb", $DE81, $DE85 - $DE81

UnknownData_0xDE85:
INCBIN "baserom.gb", $DE85, $DE86 - $DE85

LoggedData_0xDE86:
INCBIN "baserom.gb", $DE86, $DE89 - $DE86

UnknownData_0xDE89:
INCBIN "baserom.gb", $DE89, $DE8A - $DE89

LoggedData_0xDE8A:
INCBIN "baserom.gb", $DE8A, $DE8D - $DE8A

UnknownData_0xDE8D:
INCBIN "baserom.gb", $DE8D, $DE8E - $DE8D

LoggedData_0xDE8E:
INCBIN "baserom.gb", $DE8E, $DE91 - $DE8E

UnknownData_0xDE91:
INCBIN "baserom.gb", $DE91, $DE92 - $DE91

LoggedData_0xDE92:
INCBIN "baserom.gb", $DE92, $DE96 - $DE92

UnknownData_0xDE96:
INCBIN "baserom.gb", $DE96, $DE97 - $DE96

LoggedData_0xDE97:
INCBIN "baserom.gb", $DE97, $DE9A - $DE97

UnknownData_0xDE9A:
INCBIN "baserom.gb", $DE9A, $DE9B - $DE9A

LoggedData_0xDE9B:
INCBIN "baserom.gb", $DE9B, $DE9E - $DE9B

UnknownData_0xDE9E:
INCBIN "baserom.gb", $DE9E, $DE9F - $DE9E

LoggedData_0xDE9F:
INCBIN "baserom.gb", $DE9F, $DEA2 - $DE9F

UnknownData_0xDEA2:
INCBIN "baserom.gb", $DEA2, $DEA3 - $DEA2

LoggedData_0xDEA3:
INCBIN "baserom.gb", $DEA3, $DEB8 - $DEA3

UnknownData_0xDEB8:
INCBIN "baserom.gb", $DEB8, $DEBA - $DEB8

LoggedData_0xDEBA:
INCBIN "baserom.gb", $DEBA, $DEBE - $DEBA

UnknownData_0xDEBE:
INCBIN "baserom.gb", $DEBE, $DEC0 - $DEBE

LoggedData_0xDEC0:
INCBIN "baserom.gb", $DEC0, $DEDA - $DEC0

UnknownData_0xDEDA:
INCBIN "baserom.gb", $DEDA, $DEDC - $DEDA

LoggedData_0xDEDC:
INCBIN "baserom.gb", $DEDC, $DEDF - $DEDC

UnknownData_0xDEDF:
INCBIN "baserom.gb", $DEDF, $DEE0 - $DEDF

LoggedData_0xDEE0:
INCBIN "baserom.gb", $DEE0, $DEE3 - $DEE0

UnknownData_0xDEE3:
INCBIN "baserom.gb", $DEE3, $DEE4 - $DEE3

LoggedData_0xDEE4:
INCBIN "baserom.gb", $DEE4, $DEE7 - $DEE4

UnknownData_0xDEE7:
INCBIN "baserom.gb", $DEE7, $DEE8 - $DEE7

LoggedData_0xDEE8:
INCBIN "baserom.gb", $DEE8, $DEEB - $DEE8

UnknownData_0xDEEB:
INCBIN "baserom.gb", $DEEB, $DEEC - $DEEB

LoggedData_0xDEEC:
INCBIN "baserom.gb", $DEEC, $DEF0 - $DEEC

UnknownData_0xDEF0:
INCBIN "baserom.gb", $DEF0, $DEF1 - $DEF0

LoggedData_0xDEF1:
INCBIN "baserom.gb", $DEF1, $DEF4 - $DEF1

UnknownData_0xDEF4:
INCBIN "baserom.gb", $DEF4, $DEF5 - $DEF4

LoggedData_0xDEF5:
INCBIN "baserom.gb", $DEF5, $DEF8 - $DEF5

UnknownData_0xDEF8:
INCBIN "baserom.gb", $DEF8, $DEF9 - $DEF8

LoggedData_0xDEF9:
INCBIN "baserom.gb", $DEF9, $DEFC - $DEF9

UnknownData_0xDEFC:
INCBIN "baserom.gb", $DEFC, $DEFD - $DEFC

LoggedData_0xDEFD:
INCBIN "baserom.gb", $DEFD, $DF01 - $DEFD

UnknownData_0xDF01:
INCBIN "baserom.gb", $DF01, $DF02 - $DF01

LoggedData_0xDF02:
INCBIN "baserom.gb", $DF02, $DF05 - $DF02

UnknownData_0xDF05:
INCBIN "baserom.gb", $DF05, $DF06 - $DF05

LoggedData_0xDF06:
INCBIN "baserom.gb", $DF06, $DF09 - $DF06

UnknownData_0xDF09:
INCBIN "baserom.gb", $DF09, $DF0A - $DF09

LoggedData_0xDF0A:
INCBIN "baserom.gb", $DF0A, $DF0D - $DF0A

UnknownData_0xDF0D:
INCBIN "baserom.gb", $DF0D, $DF0E - $DF0D

LoggedData_0xDF0E:
INCBIN "baserom.gb", $DF0E, $DF12 - $DF0E

UnknownData_0xDF12:
INCBIN "baserom.gb", $DF12, $DF13 - $DF12

LoggedData_0xDF13:
INCBIN "baserom.gb", $DF13, $DF16 - $DF13

UnknownData_0xDF16:
INCBIN "baserom.gb", $DF16, $DF17 - $DF16

LoggedData_0xDF17:
INCBIN "baserom.gb", $DF17, $DF1A - $DF17

UnknownData_0xDF1A:
INCBIN "baserom.gb", $DF1A, $DF1B - $DF1A

LoggedData_0xDF1B:
INCBIN "baserom.gb", $DF1B, $DF1E - $DF1B

UnknownData_0xDF1E:
INCBIN "baserom.gb", $DF1E, $DF1F - $DF1E

LoggedData_0xDF1F:
INCBIN "baserom.gb", $DF1F, $DF23 - $DF1F

UnknownData_0xDF23:
INCBIN "baserom.gb", $DF23, $DF24 - $DF23

LoggedData_0xDF24:
INCBIN "baserom.gb", $DF24, $DF27 - $DF24

UnknownData_0xDF27:
INCBIN "baserom.gb", $DF27, $DF28 - $DF27

LoggedData_0xDF28:
INCBIN "baserom.gb", $DF28, $DF2B - $DF28

UnknownData_0xDF2B:
INCBIN "baserom.gb", $DF2B, $DF2C - $DF2B

LoggedData_0xDF2C:
INCBIN "baserom.gb", $DF2C, $DF2F - $DF2C

UnknownData_0xDF2F:
INCBIN "baserom.gb", $DF2F, $DF30 - $DF2F

LoggedData_0xDF30:
INCBIN "baserom.gb", $DF30, $DF34 - $DF30

UnknownData_0xDF34:
INCBIN "baserom.gb", $DF34, $DF35 - $DF34

LoggedData_0xDF35:
INCBIN "baserom.gb", $DF35, $DF38 - $DF35

UnknownData_0xDF38:
INCBIN "baserom.gb", $DF38, $DF39 - $DF38

LoggedData_0xDF39:
INCBIN "baserom.gb", $DF39, $DF3C - $DF39

UnknownData_0xDF3C:
INCBIN "baserom.gb", $DF3C, $DF3D - $DF3C

LoggedData_0xDF3D:
INCBIN "baserom.gb", $DF3D, $DF40 - $DF3D

UnknownData_0xDF40:
INCBIN "baserom.gb", $DF40, $DF41 - $DF40

LoggedData_0xDF41:
INCBIN "baserom.gb", $DF41, $DF45 - $DF41

UnknownData_0xDF45:
INCBIN "baserom.gb", $DF45, $DF46 - $DF45

LoggedData_0xDF46:
INCBIN "baserom.gb", $DF46, $DF49 - $DF46

UnknownData_0xDF49:
INCBIN "baserom.gb", $DF49, $DF4A - $DF49

LoggedData_0xDF4A:
INCBIN "baserom.gb", $DF4A, $DF4D - $DF4A

UnknownData_0xDF4D:
INCBIN "baserom.gb", $DF4D, $DF4E - $DF4D

LoggedData_0xDF4E:
INCBIN "baserom.gb", $DF4E, $DF51 - $DF4E

UnknownData_0xDF51:
INCBIN "baserom.gb", $DF51, $DF52 - $DF51

LoggedData_0xDF52:
INCBIN "baserom.gb", $DF52, $DF56 - $DF52

UnknownData_0xDF56:
INCBIN "baserom.gb", $DF56, $DF57 - $DF56

LoggedData_0xDF57:
INCBIN "baserom.gb", $DF57, $DF5A - $DF57

UnknownData_0xDF5A:
INCBIN "baserom.gb", $DF5A, $DF5B - $DF5A

LoggedData_0xDF5B:
INCBIN "baserom.gb", $DF5B, $DF5E - $DF5B

UnknownData_0xDF5E:
INCBIN "baserom.gb", $DF5E, $DF5F - $DF5E

LoggedData_0xDF5F:
INCBIN "baserom.gb", $DF5F, $DF62 - $DF5F

UnknownData_0xDF62:
INCBIN "baserom.gb", $DF62, $DF63 - $DF62

LoggedData_0xDF63:
INCBIN "baserom.gb", $DF63, $DF67 - $DF63

UnknownData_0xDF67:
INCBIN "baserom.gb", $DF67, $DF68 - $DF67

LoggedData_0xDF68:
INCBIN "baserom.gb", $DF68, $DF6B - $DF68

UnknownData_0xDF6B:
INCBIN "baserom.gb", $DF6B, $DF6C - $DF6B

LoggedData_0xDF6C:
INCBIN "baserom.gb", $DF6C, $DF6F - $DF6C

UnknownData_0xDF6F:
INCBIN "baserom.gb", $DF6F, $DF70 - $DF6F

LoggedData_0xDF70:
INCBIN "baserom.gb", $DF70, $DF73 - $DF70

UnknownData_0xDF73:
INCBIN "baserom.gb", $DF73, $DF74 - $DF73

LoggedData_0xDF74:
INCBIN "baserom.gb", $DF74, $DF78 - $DF74

UnknownData_0xDF78:
INCBIN "baserom.gb", $DF78, $DF79 - $DF78

LoggedData_0xDF79:
INCBIN "baserom.gb", $DF79, $DF7C - $DF79

UnknownData_0xDF7C:
INCBIN "baserom.gb", $DF7C, $DF7D - $DF7C

LoggedData_0xDF7D:
INCBIN "baserom.gb", $DF7D, $DF80 - $DF7D

UnknownData_0xDF80:
INCBIN "baserom.gb", $DF80, $DF81 - $DF80

LoggedData_0xDF81:
INCBIN "baserom.gb", $DF81, $DF84 - $DF81

UnknownData_0xDF84:
INCBIN "baserom.gb", $DF84, $DF85 - $DF84

LoggedData_0xDF85:
INCBIN "baserom.gb", $DF85, $DF89 - $DF85

UnknownData_0xDF89:
INCBIN "baserom.gb", $DF89, $DF8A - $DF89

LoggedData_0xDF8A:
INCBIN "baserom.gb", $DF8A, $DF8D - $DF8A

UnknownData_0xDF8D:
INCBIN "baserom.gb", $DF8D, $DF8E - $DF8D

LoggedData_0xDF8E:
INCBIN "baserom.gb", $DF8E, $DF91 - $DF8E

UnknownData_0xDF91:
INCBIN "baserom.gb", $DF91, $DF92 - $DF91

LoggedData_0xDF92:
INCBIN "baserom.gb", $DF92, $DF95 - $DF92

UnknownData_0xDF95:
INCBIN "baserom.gb", $DF95, $DF96 - $DF95

LoggedData_0xDF96:
INCBIN "baserom.gb", $DF96, $DF99 - $DF96

UnknownData_0xDF99:
INCBIN "baserom.gb", $DF99, $DF9A - $DF99

LoggedData_0xDF9A:
INCBIN "baserom.gb", $DF9A, $DF9D - $DF9A

UnknownData_0xDF9D:
INCBIN "baserom.gb", $DF9D, $DF9E - $DF9D

LoggedData_0xDF9E:
INCBIN "baserom.gb", $DF9E, $DFA2 - $DF9E

UnknownData_0xDFA2:
INCBIN "baserom.gb", $DFA2, $DFA3 - $DFA2

LoggedData_0xDFA3:
INCBIN "baserom.gb", $DFA3, $DFA6 - $DFA3

UnknownData_0xDFA6:
INCBIN "baserom.gb", $DFA6, $DFA7 - $DFA6

LoggedData_0xDFA7:
INCBIN "baserom.gb", $DFA7, $DFAA - $DFA7

UnknownData_0xDFAA:
INCBIN "baserom.gb", $DFAA, $DFAB - $DFAA

LoggedData_0xDFAB:
INCBIN "baserom.gb", $DFAB, $DFAE - $DFAB

UnknownData_0xDFAE:
INCBIN "baserom.gb", $DFAE, $DFAF - $DFAE

LoggedData_0xDFAF:
INCBIN "baserom.gb", $DFAF, $DFB2 - $DFAF

UnknownData_0xDFB2:
INCBIN "baserom.gb", $DFB2, $DFB3 - $DFB2

LoggedData_0xDFB3:
INCBIN "baserom.gb", $DFB3, $DFB6 - $DFB3

UnknownData_0xDFB6:
INCBIN "baserom.gb", $DFB6, $DFB7 - $DFB6

LoggedData_0xDFB7:
INCBIN "baserom.gb", $DFB7, $DFBA - $DFB7

UnknownData_0xDFBA:
INCBIN "baserom.gb", $DFBA, $DFBB - $DFBA

LoggedData_0xDFBB:
INCBIN "baserom.gb", $DFBB, $DFBE - $DFBB

UnknownData_0xDFBE:
INCBIN "baserom.gb", $DFBE, $DFBF - $DFBE

LoggedData_0xDFBF:
INCBIN "baserom.gb", $DFBF, $DFC3 - $DFBF

UnknownData_0xDFC3:
INCBIN "baserom.gb", $DFC3, $DFC4 - $DFC3

LoggedData_0xDFC4:
INCBIN "baserom.gb", $DFC4, $DFC7 - $DFC4

UnknownData_0xDFC7:
INCBIN "baserom.gb", $DFC7, $DFC8 - $DFC7

LoggedData_0xDFC8:
INCBIN "baserom.gb", $DFC8, $DFCB - $DFC8

UnknownData_0xDFCB:
INCBIN "baserom.gb", $DFCB, $DFCC - $DFCB

LoggedData_0xDFCC:
INCBIN "baserom.gb", $DFCC, $DFCF - $DFCC

UnknownData_0xDFCF:
INCBIN "baserom.gb", $DFCF, $DFD0 - $DFCF

LoggedData_0xDFD0:
INCBIN "baserom.gb", $DFD0, $DFD4 - $DFD0

UnknownData_0xDFD4:
INCBIN "baserom.gb", $DFD4, $DFD5 - $DFD4

LoggedData_0xDFD5:
INCBIN "baserom.gb", $DFD5, $DFD8 - $DFD5

UnknownData_0xDFD8:
INCBIN "baserom.gb", $DFD8, $DFD9 - $DFD8

LoggedData_0xDFD9:
INCBIN "baserom.gb", $DFD9, $DFDC - $DFD9

UnknownData_0xDFDC:
INCBIN "baserom.gb", $DFDC, $DFDD - $DFDC

LoggedData_0xDFDD:
INCBIN "baserom.gb", $DFDD, $DFE0 - $DFDD

UnknownData_0xDFE0:
INCBIN "baserom.gb", $DFE0, $DFE1 - $DFE0

LoggedData_0xDFE1:
INCBIN "baserom.gb", $DFE1, $DFE5 - $DFE1

UnknownData_0xDFE5:
INCBIN "baserom.gb", $DFE5, $DFE6 - $DFE5

LoggedData_0xDFE6:
INCBIN "baserom.gb", $DFE6, $DFE9 - $DFE6

UnknownData_0xDFE9:
INCBIN "baserom.gb", $DFE9, $DFEA - $DFE9

LoggedData_0xDFEA:
INCBIN "baserom.gb", $DFEA, $DFED - $DFEA

UnknownData_0xDFED:
INCBIN "baserom.gb", $DFED, $DFEE - $DFED

LoggedData_0xDFEE:
INCBIN "baserom.gb", $DFEE, $DFF1 - $DFEE

UnknownData_0xDFF1:
INCBIN "baserom.gb", $DFF1, $DFF2 - $DFF1

LoggedData_0xDFF2:
INCBIN "baserom.gb", $DFF2, $DFF6 - $DFF2

UnknownData_0xDFF6:
INCBIN "baserom.gb", $DFF6, $DFF7 - $DFF6

LoggedData_0xDFF7:
INCBIN "baserom.gb", $DFF7, $DFFA - $DFF7

UnknownData_0xDFFA:
INCBIN "baserom.gb", $DFFA, $DFFB - $DFFA

LoggedData_0xDFFB:
INCBIN "baserom.gb", $DFFB, $DFFE - $DFFB

UnknownData_0xDFFE:
INCBIN "baserom.gb", $DFFE, $DFFF - $DFFE

LoggedData_0xDFFF:
INCBIN "baserom.gb", $DFFF, $E002 - $DFFF

UnknownData_0xE002:
INCBIN "baserom.gb", $E002, $E003 - $E002

LoggedData_0xE003:
INCBIN "baserom.gb", $E003, $E007 - $E003

UnknownData_0xE007:
INCBIN "baserom.gb", $E007, $E008 - $E007

LoggedData_0xE008:
INCBIN "baserom.gb", $E008, $E00B - $E008

UnknownData_0xE00B:
INCBIN "baserom.gb", $E00B, $E00C - $E00B

LoggedData_0xE00C:
INCBIN "baserom.gb", $E00C, $E00F - $E00C

UnknownData_0xE00F:
INCBIN "baserom.gb", $E00F, $E010 - $E00F

LoggedData_0xE010:
INCBIN "baserom.gb", $E010, $E013 - $E010

UnknownData_0xE013:
INCBIN "baserom.gb", $E013, $E014 - $E013

LoggedData_0xE014:
INCBIN "baserom.gb", $E014, $E018 - $E014

UnknownData_0xE018:
INCBIN "baserom.gb", $E018, $E019 - $E018

LoggedData_0xE019:
INCBIN "baserom.gb", $E019, $E01C - $E019

UnknownData_0xE01C:
INCBIN "baserom.gb", $E01C, $E01D - $E01C

LoggedData_0xE01D:
INCBIN "baserom.gb", $E01D, $E020 - $E01D

UnknownData_0xE020:
INCBIN "baserom.gb", $E020, $E021 - $E020

LoggedData_0xE021:
INCBIN "baserom.gb", $E021, $E024 - $E021

UnknownData_0xE024:
INCBIN "baserom.gb", $E024, $E025 - $E024

LoggedData_0xE025:
INCBIN "baserom.gb", $E025, $E029 - $E025

UnknownData_0xE029:
INCBIN "baserom.gb", $E029, $E02A - $E029

LoggedData_0xE02A:
INCBIN "baserom.gb", $E02A, $E02D - $E02A

UnknownData_0xE02D:
INCBIN "baserom.gb", $E02D, $E02E - $E02D

LoggedData_0xE02E:
INCBIN "baserom.gb", $E02E, $E031 - $E02E

UnknownData_0xE031:
INCBIN "baserom.gb", $E031, $E032 - $E031

LoggedData_0xE032:
INCBIN "baserom.gb", $E032, $E035 - $E032

UnknownData_0xE035:
INCBIN "baserom.gb", $E035, $E036 - $E035

LoggedData_0xE036:
INCBIN "baserom.gb", $E036, $E03A - $E036

UnknownData_0xE03A:
INCBIN "baserom.gb", $E03A, $E03B - $E03A

LoggedData_0xE03B:
INCBIN "baserom.gb", $E03B, $E03E - $E03B

UnknownData_0xE03E:
INCBIN "baserom.gb", $E03E, $E03F - $E03E

LoggedData_0xE03F:
INCBIN "baserom.gb", $E03F, $E042 - $E03F

UnknownData_0xE042:
INCBIN "baserom.gb", $E042, $E043 - $E042

LoggedData_0xE043:
INCBIN "baserom.gb", $E043, $E046 - $E043

UnknownData_0xE046:
INCBIN "baserom.gb", $E046, $E047 - $E046

LoggedData_0xE047:
INCBIN "baserom.gb", $E047, $E04B - $E047

UnknownData_0xE04B:
INCBIN "baserom.gb", $E04B, $E04C - $E04B

LoggedData_0xE04C:
INCBIN "baserom.gb", $E04C, $E04F - $E04C

UnknownData_0xE04F:
INCBIN "baserom.gb", $E04F, $E050 - $E04F

LoggedData_0xE050:
INCBIN "baserom.gb", $E050, $E053 - $E050

UnknownData_0xE053:
INCBIN "baserom.gb", $E053, $E054 - $E053

LoggedData_0xE054:
INCBIN "baserom.gb", $E054, $E057 - $E054

UnknownData_0xE057:
INCBIN "baserom.gb", $E057, $E058 - $E057

LoggedData_0xE058:
INCBIN "baserom.gb", $E058, $E05B - $E058

UnknownData_0xE05B:
INCBIN "baserom.gb", $E05B, $E05C - $E05B

LoggedData_0xE05C:
INCBIN "baserom.gb", $E05C, $E060 - $E05C

UnknownData_0xE060:
INCBIN "baserom.gb", $E060, $E061 - $E060

LoggedData_0xE061:
INCBIN "baserom.gb", $E061, $E064 - $E061

UnknownData_0xE064:
INCBIN "baserom.gb", $E064, $E065 - $E064

LoggedData_0xE065:
INCBIN "baserom.gb", $E065, $E068 - $E065

UnknownData_0xE068:
INCBIN "baserom.gb", $E068, $E069 - $E068

LoggedData_0xE069:
INCBIN "baserom.gb", $E069, $E06C - $E069

UnknownData_0xE06C:
INCBIN "baserom.gb", $E06C, $E06D - $E06C

LoggedData_0xE06D:
INCBIN "baserom.gb", $E06D, $E070 - $E06D

UnknownData_0xE070:
INCBIN "baserom.gb", $E070, $E071 - $E070

LoggedData_0xE071:
INCBIN "baserom.gb", $E071, $E075 - $E071

UnknownData_0xE075:
INCBIN "baserom.gb", $E075, $E076 - $E075

LoggedData_0xE076:
INCBIN "baserom.gb", $E076, $E079 - $E076

UnknownData_0xE079:
INCBIN "baserom.gb", $E079, $E07A - $E079

LoggedData_0xE07A:
INCBIN "baserom.gb", $E07A, $E07D - $E07A

UnknownData_0xE07D:
INCBIN "baserom.gb", $E07D, $E07E - $E07D

LoggedData_0xE07E:
INCBIN "baserom.gb", $E07E, $E081 - $E07E

UnknownData_0xE081:
INCBIN "baserom.gb", $E081, $E082 - $E081

LoggedData_0xE082:
INCBIN "baserom.gb", $E082, $E085 - $E082

UnknownData_0xE085:
INCBIN "baserom.gb", $E085, $E086 - $E085

LoggedData_0xE086:
INCBIN "baserom.gb", $E086, $E08A - $E086

UnknownData_0xE08A:
INCBIN "baserom.gb", $E08A, $E08B - $E08A

LoggedData_0xE08B:
INCBIN "baserom.gb", $E08B, $E08E - $E08B

UnknownData_0xE08E:
INCBIN "baserom.gb", $E08E, $E08F - $E08E

LoggedData_0xE08F:
INCBIN "baserom.gb", $E08F, $E092 - $E08F

UnknownData_0xE092:
INCBIN "baserom.gb", $E092, $E093 - $E092

LoggedData_0xE093:
INCBIN "baserom.gb", $E093, $E096 - $E093

UnknownData_0xE096:
INCBIN "baserom.gb", $E096, $E097 - $E096

LoggedData_0xE097:
INCBIN "baserom.gb", $E097, $E09A - $E097

UnknownData_0xE09A:
INCBIN "baserom.gb", $E09A, $E09B - $E09A

LoggedData_0xE09B:
INCBIN "baserom.gb", $E09B, $E0B0 - $E09B

UnknownData_0xE0B0:
INCBIN "baserom.gb", $E0B0, $E0B2 - $E0B0

LoggedData_0xE0B2:
INCBIN "baserom.gb", $E0B2, $E0B6 - $E0B2

UnknownData_0xE0B6:
INCBIN "baserom.gb", $E0B6, $E0B8 - $E0B6

LoggedData_0xE0B8:
INCBIN "baserom.gb", $E0B8, $E0D2 - $E0B8

UnknownData_0xE0D2:
INCBIN "baserom.gb", $E0D2, $E0D4 - $E0D2

LoggedData_0xE0D4:
INCBIN "baserom.gb", $E0D4, $E0D7 - $E0D4

UnknownData_0xE0D7:
INCBIN "baserom.gb", $E0D7, $E0D8 - $E0D7

LoggedData_0xE0D8:
INCBIN "baserom.gb", $E0D8, $E0DB - $E0D8

UnknownData_0xE0DB:
INCBIN "baserom.gb", $E0DB, $E0DC - $E0DB

LoggedData_0xE0DC:
INCBIN "baserom.gb", $E0DC, $E0DF - $E0DC

UnknownData_0xE0DF:
INCBIN "baserom.gb", $E0DF, $E0E0 - $E0DF

LoggedData_0xE0E0:
INCBIN "baserom.gb", $E0E0, $E0E3 - $E0E0

UnknownData_0xE0E3:
INCBIN "baserom.gb", $E0E3, $E0E4 - $E0E3

LoggedData_0xE0E4:
INCBIN "baserom.gb", $E0E4, $E0E8 - $E0E4

UnknownData_0xE0E8:
INCBIN "baserom.gb", $E0E8, $E0E9 - $E0E8

LoggedData_0xE0E9:
INCBIN "baserom.gb", $E0E9, $E0EC - $E0E9

UnknownData_0xE0EC:
INCBIN "baserom.gb", $E0EC, $E0ED - $E0EC

LoggedData_0xE0ED:
INCBIN "baserom.gb", $E0ED, $E0F0 - $E0ED

UnknownData_0xE0F0:
INCBIN "baserom.gb", $E0F0, $E0F1 - $E0F0

LoggedData_0xE0F1:
INCBIN "baserom.gb", $E0F1, $E0F4 - $E0F1

UnknownData_0xE0F4:
INCBIN "baserom.gb", $E0F4, $E0F5 - $E0F4

LoggedData_0xE0F5:
INCBIN "baserom.gb", $E0F5, $E0F9 - $E0F5

UnknownData_0xE0F9:
INCBIN "baserom.gb", $E0F9, $E0FA - $E0F9

LoggedData_0xE0FA:
INCBIN "baserom.gb", $E0FA, $E0FD - $E0FA

UnknownData_0xE0FD:
INCBIN "baserom.gb", $E0FD, $E0FE - $E0FD

LoggedData_0xE0FE:
INCBIN "baserom.gb", $E0FE, $E101 - $E0FE

UnknownData_0xE101:
INCBIN "baserom.gb", $E101, $E102 - $E101

LoggedData_0xE102:
INCBIN "baserom.gb", $E102, $E105 - $E102

UnknownData_0xE105:
INCBIN "baserom.gb", $E105, $E106 - $E105

LoggedData_0xE106:
INCBIN "baserom.gb", $E106, $E10A - $E106

UnknownData_0xE10A:
INCBIN "baserom.gb", $E10A, $E10B - $E10A

LoggedData_0xE10B:
INCBIN "baserom.gb", $E10B, $E10E - $E10B

UnknownData_0xE10E:
INCBIN "baserom.gb", $E10E, $E10F - $E10E

LoggedData_0xE10F:
INCBIN "baserom.gb", $E10F, $E112 - $E10F

UnknownData_0xE112:
INCBIN "baserom.gb", $E112, $E113 - $E112

LoggedData_0xE113:
INCBIN "baserom.gb", $E113, $E116 - $E113

UnknownData_0xE116:
INCBIN "baserom.gb", $E116, $E117 - $E116

LoggedData_0xE117:
INCBIN "baserom.gb", $E117, $E11B - $E117

UnknownData_0xE11B:
INCBIN "baserom.gb", $E11B, $E11C - $E11B

LoggedData_0xE11C:
INCBIN "baserom.gb", $E11C, $E11F - $E11C

UnknownData_0xE11F:
INCBIN "baserom.gb", $E11F, $E120 - $E11F

LoggedData_0xE120:
INCBIN "baserom.gb", $E120, $E123 - $E120

UnknownData_0xE123:
INCBIN "baserom.gb", $E123, $E124 - $E123

LoggedData_0xE124:
INCBIN "baserom.gb", $E124, $E127 - $E124

UnknownData_0xE127:
INCBIN "baserom.gb", $E127, $E128 - $E127

LoggedData_0xE128:
INCBIN "baserom.gb", $E128, $E12C - $E128

UnknownData_0xE12C:
INCBIN "baserom.gb", $E12C, $E12D - $E12C

LoggedData_0xE12D:
INCBIN "baserom.gb", $E12D, $E130 - $E12D

UnknownData_0xE130:
INCBIN "baserom.gb", $E130, $E131 - $E130

LoggedData_0xE131:
INCBIN "baserom.gb", $E131, $E134 - $E131

UnknownData_0xE134:
INCBIN "baserom.gb", $E134, $E135 - $E134

LoggedData_0xE135:
INCBIN "baserom.gb", $E135, $E138 - $E135

UnknownData_0xE138:
INCBIN "baserom.gb", $E138, $E139 - $E138

LoggedData_0xE139:
INCBIN "baserom.gb", $E139, $E13D - $E139

UnknownData_0xE13D:
INCBIN "baserom.gb", $E13D, $E13E - $E13D

LoggedData_0xE13E:
INCBIN "baserom.gb", $E13E, $E141 - $E13E

UnknownData_0xE141:
INCBIN "baserom.gb", $E141, $E142 - $E141

LoggedData_0xE142:
INCBIN "baserom.gb", $E142, $E145 - $E142

UnknownData_0xE145:
INCBIN "baserom.gb", $E145, $E146 - $E145

LoggedData_0xE146:
INCBIN "baserom.gb", $E146, $E149 - $E146

UnknownData_0xE149:
INCBIN "baserom.gb", $E149, $E14A - $E149

LoggedData_0xE14A:
INCBIN "baserom.gb", $E14A, $E14E - $E14A

UnknownData_0xE14E:
INCBIN "baserom.gb", $E14E, $E14F - $E14E

LoggedData_0xE14F:
INCBIN "baserom.gb", $E14F, $E152 - $E14F

UnknownData_0xE152:
INCBIN "baserom.gb", $E152, $E153 - $E152

LoggedData_0xE153:
INCBIN "baserom.gb", $E153, $E156 - $E153

UnknownData_0xE156:
INCBIN "baserom.gb", $E156, $E157 - $E156

LoggedData_0xE157:
INCBIN "baserom.gb", $E157, $E15A - $E157

UnknownData_0xE15A:
INCBIN "baserom.gb", $E15A, $E15B - $E15A

LoggedData_0xE15B:
INCBIN "baserom.gb", $E15B, $E15F - $E15B

UnknownData_0xE15F:
INCBIN "baserom.gb", $E15F, $E160 - $E15F

LoggedData_0xE160:
INCBIN "baserom.gb", $E160, $E163 - $E160

UnknownData_0xE163:
INCBIN "baserom.gb", $E163, $E164 - $E163

LoggedData_0xE164:
INCBIN "baserom.gb", $E164, $E167 - $E164

UnknownData_0xE167:
INCBIN "baserom.gb", $E167, $E168 - $E167

LoggedData_0xE168:
INCBIN "baserom.gb", $E168, $E16B - $E168

UnknownData_0xE16B:
INCBIN "baserom.gb", $E16B, $E16C - $E16B

LoggedData_0xE16C:
INCBIN "baserom.gb", $E16C, $E170 - $E16C

UnknownData_0xE170:
INCBIN "baserom.gb", $E170, $E171 - $E170

LoggedData_0xE171:
INCBIN "baserom.gb", $E171, $E174 - $E171

UnknownData_0xE174:
INCBIN "baserom.gb", $E174, $E175 - $E174

LoggedData_0xE175:
INCBIN "baserom.gb", $E175, $E178 - $E175

UnknownData_0xE178:
INCBIN "baserom.gb", $E178, $E179 - $E178

LoggedData_0xE179:
INCBIN "baserom.gb", $E179, $E17C - $E179

UnknownData_0xE17C:
INCBIN "baserom.gb", $E17C, $E17D - $E17C

LoggedData_0xE17D:
INCBIN "baserom.gb", $E17D, $E181 - $E17D

UnknownData_0xE181:
INCBIN "baserom.gb", $E181, $E182 - $E181

LoggedData_0xE182:
INCBIN "baserom.gb", $E182, $E185 - $E182

UnknownData_0xE185:
INCBIN "baserom.gb", $E185, $E186 - $E185

LoggedData_0xE186:
INCBIN "baserom.gb", $E186, $E189 - $E186

UnknownData_0xE189:
INCBIN "baserom.gb", $E189, $E18A - $E189

LoggedData_0xE18A:
INCBIN "baserom.gb", $E18A, $E18D - $E18A

UnknownData_0xE18D:
INCBIN "baserom.gb", $E18D, $E18E - $E18D

LoggedData_0xE18E:
INCBIN "baserom.gb", $E18E, $E191 - $E18E

UnknownData_0xE191:
INCBIN "baserom.gb", $E191, $E192 - $E191

LoggedData_0xE192:
INCBIN "baserom.gb", $E192, $E195 - $E192

UnknownData_0xE195:
INCBIN "baserom.gb", $E195, $E196 - $E195

LoggedData_0xE196:
INCBIN "baserom.gb", $E196, $E19A - $E196

UnknownData_0xE19A:
INCBIN "baserom.gb", $E19A, $E19B - $E19A

LoggedData_0xE19B:
INCBIN "baserom.gb", $E19B, $E19E - $E19B

UnknownData_0xE19E:
INCBIN "baserom.gb", $E19E, $E19F - $E19E

LoggedData_0xE19F:
INCBIN "baserom.gb", $E19F, $E1A2 - $E19F

UnknownData_0xE1A2:
INCBIN "baserom.gb", $E1A2, $E1A3 - $E1A2

LoggedData_0xE1A3:
INCBIN "baserom.gb", $E1A3, $E1A6 - $E1A3

UnknownData_0xE1A6:
INCBIN "baserom.gb", $E1A6, $E1A7 - $E1A6

LoggedData_0xE1A7:
INCBIN "baserom.gb", $E1A7, $E1AA - $E1A7

UnknownData_0xE1AA:
INCBIN "baserom.gb", $E1AA, $E1AB - $E1AA

LoggedData_0xE1AB:
INCBIN "baserom.gb", $E1AB, $E1AE - $E1AB

UnknownData_0xE1AE:
INCBIN "baserom.gb", $E1AE, $E1AF - $E1AE

LoggedData_0xE1AF:
INCBIN "baserom.gb", $E1AF, $E1B2 - $E1AF

UnknownData_0xE1B2:
INCBIN "baserom.gb", $E1B2, $E1B3 - $E1B2

LoggedData_0xE1B3:
INCBIN "baserom.gb", $E1B3, $E1B6 - $E1B3

UnknownData_0xE1B6:
INCBIN "baserom.gb", $E1B6, $E1B7 - $E1B6

LoggedData_0xE1B7:
INCBIN "baserom.gb", $E1B7, $E1BB - $E1B7

UnknownData_0xE1BB:
INCBIN "baserom.gb", $E1BB, $E1BC - $E1BB

LoggedData_0xE1BC:
INCBIN "baserom.gb", $E1BC, $E1BF - $E1BC

UnknownData_0xE1BF:
INCBIN "baserom.gb", $E1BF, $E1C0 - $E1BF

LoggedData_0xE1C0:
INCBIN "baserom.gb", $E1C0, $E1C3 - $E1C0

UnknownData_0xE1C3:
INCBIN "baserom.gb", $E1C3, $E1C4 - $E1C3

LoggedData_0xE1C4:
INCBIN "baserom.gb", $E1C4, $E1C7 - $E1C4

UnknownData_0xE1C7:
INCBIN "baserom.gb", $E1C7, $E1C8 - $E1C7

LoggedData_0xE1C8:
INCBIN "baserom.gb", $E1C8, $E1CC - $E1C8

UnknownData_0xE1CC:
INCBIN "baserom.gb", $E1CC, $E1CD - $E1CC

LoggedData_0xE1CD:
INCBIN "baserom.gb", $E1CD, $E1D0 - $E1CD

UnknownData_0xE1D0:
INCBIN "baserom.gb", $E1D0, $E1D1 - $E1D0

LoggedData_0xE1D1:
INCBIN "baserom.gb", $E1D1, $E1D4 - $E1D1

UnknownData_0xE1D4:
INCBIN "baserom.gb", $E1D4, $E1D5 - $E1D4

LoggedData_0xE1D5:
INCBIN "baserom.gb", $E1D5, $E1D8 - $E1D5

UnknownData_0xE1D8:
INCBIN "baserom.gb", $E1D8, $E1D9 - $E1D8

LoggedData_0xE1D9:
INCBIN "baserom.gb", $E1D9, $E1DD - $E1D9

UnknownData_0xE1DD:
INCBIN "baserom.gb", $E1DD, $E1DE - $E1DD

LoggedData_0xE1DE:
INCBIN "baserom.gb", $E1DE, $E1E1 - $E1DE

UnknownData_0xE1E1:
INCBIN "baserom.gb", $E1E1, $E1E2 - $E1E1

LoggedData_0xE1E2:
INCBIN "baserom.gb", $E1E2, $E1E5 - $E1E2

UnknownData_0xE1E5:
INCBIN "baserom.gb", $E1E5, $E1E6 - $E1E5

LoggedData_0xE1E6:
INCBIN "baserom.gb", $E1E6, $E1E9 - $E1E6

UnknownData_0xE1E9:
INCBIN "baserom.gb", $E1E9, $E1EA - $E1E9

LoggedData_0xE1EA:
INCBIN "baserom.gb", $E1EA, $E1EE - $E1EA

UnknownData_0xE1EE:
INCBIN "baserom.gb", $E1EE, $E1EF - $E1EE

LoggedData_0xE1EF:
INCBIN "baserom.gb", $E1EF, $E1F2 - $E1EF

UnknownData_0xE1F2:
INCBIN "baserom.gb", $E1F2, $E1F3 - $E1F2

LoggedData_0xE1F3:
INCBIN "baserom.gb", $E1F3, $E1F6 - $E1F3

UnknownData_0xE1F6:
INCBIN "baserom.gb", $E1F6, $E1F7 - $E1F6

LoggedData_0xE1F7:
INCBIN "baserom.gb", $E1F7, $E1FA - $E1F7

UnknownData_0xE1FA:
INCBIN "baserom.gb", $E1FA, $E1FB - $E1FA

LoggedData_0xE1FB:
INCBIN "baserom.gb", $E1FB, $E1FF - $E1FB

UnknownData_0xE1FF:
INCBIN "baserom.gb", $E1FF, $E200 - $E1FF

LoggedData_0xE200:
INCBIN "baserom.gb", $E200, $E203 - $E200

UnknownData_0xE203:
INCBIN "baserom.gb", $E203, $E204 - $E203

LoggedData_0xE204:
INCBIN "baserom.gb", $E204, $E207 - $E204

UnknownData_0xE207:
INCBIN "baserom.gb", $E207, $E208 - $E207

LoggedData_0xE208:
INCBIN "baserom.gb", $E208, $E20B - $E208

UnknownData_0xE20B:
INCBIN "baserom.gb", $E20B, $E20C - $E20B

LoggedData_0xE20C:
INCBIN "baserom.gb", $E20C, $E210 - $E20C

UnknownData_0xE210:
INCBIN "baserom.gb", $E210, $E211 - $E210

LoggedData_0xE211:
INCBIN "baserom.gb", $E211, $E214 - $E211

UnknownData_0xE214:
INCBIN "baserom.gb", $E214, $E215 - $E214

LoggedData_0xE215:
INCBIN "baserom.gb", $E215, $E218 - $E215

UnknownData_0xE218:
INCBIN "baserom.gb", $E218, $E219 - $E218

LoggedData_0xE219:
INCBIN "baserom.gb", $E219, $E21C - $E219

UnknownData_0xE21C:
INCBIN "baserom.gb", $E21C, $E21D - $E21C

LoggedData_0xE21D:
INCBIN "baserom.gb", $E21D, $E221 - $E21D

UnknownData_0xE221:
INCBIN "baserom.gb", $E221, $E222 - $E221

LoggedData_0xE222:
INCBIN "baserom.gb", $E222, $E225 - $E222

UnknownData_0xE225:
INCBIN "baserom.gb", $E225, $E226 - $E225

LoggedData_0xE226:
INCBIN "baserom.gb", $E226, $E229 - $E226

UnknownData_0xE229:
INCBIN "baserom.gb", $E229, $E22A - $E229

LoggedData_0xE22A:
INCBIN "baserom.gb", $E22A, $E22D - $E22A

UnknownData_0xE22D:
INCBIN "baserom.gb", $E22D, $E22E - $E22D

LoggedData_0xE22E:
INCBIN "baserom.gb", $E22E, $E232 - $E22E

UnknownData_0xE232:
INCBIN "baserom.gb", $E232, $E233 - $E232

LoggedData_0xE233:
INCBIN "baserom.gb", $E233, $E236 - $E233

UnknownData_0xE236:
INCBIN "baserom.gb", $E236, $E237 - $E236

LoggedData_0xE237:
INCBIN "baserom.gb", $E237, $E23A - $E237

UnknownData_0xE23A:
INCBIN "baserom.gb", $E23A, $E23B - $E23A

LoggedData_0xE23B:
INCBIN "baserom.gb", $E23B, $E23E - $E23B

UnknownData_0xE23E:
INCBIN "baserom.gb", $E23E, $E23F - $E23E

LoggedData_0xE23F:
INCBIN "baserom.gb", $E23F, $E243 - $E23F

UnknownData_0xE243:
INCBIN "baserom.gb", $E243, $E244 - $E243

LoggedData_0xE244:
INCBIN "baserom.gb", $E244, $E247 - $E244

UnknownData_0xE247:
INCBIN "baserom.gb", $E247, $E248 - $E247

LoggedData_0xE248:
INCBIN "baserom.gb", $E248, $E24B - $E248

UnknownData_0xE24B:
INCBIN "baserom.gb", $E24B, $E24C - $E24B

LoggedData_0xE24C:
INCBIN "baserom.gb", $E24C, $E24F - $E24C

UnknownData_0xE24F:
INCBIN "baserom.gb", $E24F, $E250 - $E24F

LoggedData_0xE250:
INCBIN "baserom.gb", $E250, $E253 - $E250

UnknownData_0xE253:
INCBIN "baserom.gb", $E253, $E254 - $E253

LoggedData_0xE254:
INCBIN "baserom.gb", $E254, $E258 - $E254

UnknownData_0xE258:
INCBIN "baserom.gb", $E258, $E259 - $E258

LoggedData_0xE259:
INCBIN "baserom.gb", $E259, $E25C - $E259

UnknownData_0xE25C:
INCBIN "baserom.gb", $E25C, $E25D - $E25C

LoggedData_0xE25D:
INCBIN "baserom.gb", $E25D, $E260 - $E25D

UnknownData_0xE260:
INCBIN "baserom.gb", $E260, $E261 - $E260

LoggedData_0xE261:
INCBIN "baserom.gb", $E261, $E264 - $E261

UnknownData_0xE264:
INCBIN "baserom.gb", $E264, $E265 - $E264

LoggedData_0xE265:
INCBIN "baserom.gb", $E265, $E268 - $E265

UnknownData_0xE268:
INCBIN "baserom.gb", $E268, $E269 - $E268

LoggedData_0xE269:
INCBIN "baserom.gb", $E269, $E26D - $E269

UnknownData_0xE26D:
INCBIN "baserom.gb", $E26D, $E26E - $E26D

LoggedData_0xE26E:
INCBIN "baserom.gb", $E26E, $E271 - $E26E

UnknownData_0xE271:
INCBIN "baserom.gb", $E271, $E272 - $E271

LoggedData_0xE272:
INCBIN "baserom.gb", $E272, $E275 - $E272

UnknownData_0xE275:
INCBIN "baserom.gb", $E275, $E276 - $E275

LoggedData_0xE276:
INCBIN "baserom.gb", $E276, $E279 - $E276

UnknownData_0xE279:
INCBIN "baserom.gb", $E279, $E27A - $E279

LoggedData_0xE27A:
INCBIN "baserom.gb", $E27A, $E27D - $E27A

UnknownData_0xE27D:
INCBIN "baserom.gb", $E27D, $E27E - $E27D

LoggedData_0xE27E:
INCBIN "baserom.gb", $E27E, $E282 - $E27E

UnknownData_0xE282:
INCBIN "baserom.gb", $E282, $E283 - $E282

LoggedData_0xE283:
INCBIN "baserom.gb", $E283, $E286 - $E283

UnknownData_0xE286:
INCBIN "baserom.gb", $E286, $E287 - $E286

LoggedData_0xE287:
INCBIN "baserom.gb", $E287, $E28A - $E287

UnknownData_0xE28A:
INCBIN "baserom.gb", $E28A, $E28B - $E28A

LoggedData_0xE28B:
INCBIN "baserom.gb", $E28B, $E28E - $E28B

UnknownData_0xE28E:
INCBIN "baserom.gb", $E28E, $E28F - $E28E

LoggedData_0xE28F:
INCBIN "baserom.gb", $E28F, $E292 - $E28F

UnknownData_0xE292:
INCBIN "baserom.gb", $E292, $E293 - $E292

LoggedData_0xE293:
INCBIN "baserom.gb", $E293, $E2A8 - $E293

UnknownData_0xE2A8:
INCBIN "baserom.gb", $E2A8, $E2AA - $E2A8

LoggedData_0xE2AA:
INCBIN "baserom.gb", $E2AA, $E2AE - $E2AA

UnknownData_0xE2AE:
INCBIN "baserom.gb", $E2AE, $E2B0 - $E2AE

LoggedData_0xE2B0:
INCBIN "baserom.gb", $E2B0, $E2CA - $E2B0

UnknownData_0xE2CA:
INCBIN "baserom.gb", $E2CA, $E2CC - $E2CA

LoggedData_0xE2CC:
INCBIN "baserom.gb", $E2CC, $E2CF - $E2CC

UnknownData_0xE2CF:
INCBIN "baserom.gb", $E2CF, $E2D0 - $E2CF

LoggedData_0xE2D0:
INCBIN "baserom.gb", $E2D0, $E2D3 - $E2D0

UnknownData_0xE2D3:
INCBIN "baserom.gb", $E2D3, $E2D4 - $E2D3

LoggedData_0xE2D4:
INCBIN "baserom.gb", $E2D4, $E2D7 - $E2D4

UnknownData_0xE2D7:
INCBIN "baserom.gb", $E2D7, $E2D8 - $E2D7

LoggedData_0xE2D8:
INCBIN "baserom.gb", $E2D8, $E2DB - $E2D8

UnknownData_0xE2DB:
INCBIN "baserom.gb", $E2DB, $E2DC - $E2DB

LoggedData_0xE2DC:
INCBIN "baserom.gb", $E2DC, $E2E0 - $E2DC

UnknownData_0xE2E0:
INCBIN "baserom.gb", $E2E0, $E2E1 - $E2E0

LoggedData_0xE2E1:
INCBIN "baserom.gb", $E2E1, $E2E4 - $E2E1

UnknownData_0xE2E4:
INCBIN "baserom.gb", $E2E4, $E2E5 - $E2E4

LoggedData_0xE2E5:
INCBIN "baserom.gb", $E2E5, $E2E8 - $E2E5

UnknownData_0xE2E8:
INCBIN "baserom.gb", $E2E8, $E2E9 - $E2E8

LoggedData_0xE2E9:
INCBIN "baserom.gb", $E2E9, $E2EC - $E2E9

UnknownData_0xE2EC:
INCBIN "baserom.gb", $E2EC, $E2ED - $E2EC

LoggedData_0xE2ED:
INCBIN "baserom.gb", $E2ED, $E2F1 - $E2ED

UnknownData_0xE2F1:
INCBIN "baserom.gb", $E2F1, $E2F2 - $E2F1

LoggedData_0xE2F2:
INCBIN "baserom.gb", $E2F2, $E2F5 - $E2F2

UnknownData_0xE2F5:
INCBIN "baserom.gb", $E2F5, $E2F6 - $E2F5

LoggedData_0xE2F6:
INCBIN "baserom.gb", $E2F6, $E2F9 - $E2F6

UnknownData_0xE2F9:
INCBIN "baserom.gb", $E2F9, $E2FA - $E2F9

LoggedData_0xE2FA:
INCBIN "baserom.gb", $E2FA, $E2FD - $E2FA

UnknownData_0xE2FD:
INCBIN "baserom.gb", $E2FD, $E2FE - $E2FD

LoggedData_0xE2FE:
INCBIN "baserom.gb", $E2FE, $E302 - $E2FE

UnknownData_0xE302:
INCBIN "baserom.gb", $E302, $E303 - $E302

LoggedData_0xE303:
INCBIN "baserom.gb", $E303, $E306 - $E303

UnknownData_0xE306:
INCBIN "baserom.gb", $E306, $E307 - $E306

LoggedData_0xE307:
INCBIN "baserom.gb", $E307, $E30A - $E307

UnknownData_0xE30A:
INCBIN "baserom.gb", $E30A, $E30B - $E30A

LoggedData_0xE30B:
INCBIN "baserom.gb", $E30B, $E30E - $E30B

UnknownData_0xE30E:
INCBIN "baserom.gb", $E30E, $E30F - $E30E

LoggedData_0xE30F:
INCBIN "baserom.gb", $E30F, $E313 - $E30F

UnknownData_0xE313:
INCBIN "baserom.gb", $E313, $E314 - $E313

LoggedData_0xE314:
INCBIN "baserom.gb", $E314, $E317 - $E314

UnknownData_0xE317:
INCBIN "baserom.gb", $E317, $E318 - $E317

LoggedData_0xE318:
INCBIN "baserom.gb", $E318, $E31B - $E318

UnknownData_0xE31B:
INCBIN "baserom.gb", $E31B, $E31C - $E31B

LoggedData_0xE31C:
INCBIN "baserom.gb", $E31C, $E31F - $E31C

UnknownData_0xE31F:
INCBIN "baserom.gb", $E31F, $E320 - $E31F

LoggedData_0xE320:
INCBIN "baserom.gb", $E320, $E324 - $E320

UnknownData_0xE324:
INCBIN "baserom.gb", $E324, $E325 - $E324

LoggedData_0xE325:
INCBIN "baserom.gb", $E325, $E328 - $E325

UnknownData_0xE328:
INCBIN "baserom.gb", $E328, $E329 - $E328

LoggedData_0xE329:
INCBIN "baserom.gb", $E329, $E32C - $E329

UnknownData_0xE32C:
INCBIN "baserom.gb", $E32C, $E32D - $E32C

LoggedData_0xE32D:
INCBIN "baserom.gb", $E32D, $E330 - $E32D

UnknownData_0xE330:
INCBIN "baserom.gb", $E330, $E331 - $E330

LoggedData_0xE331:
INCBIN "baserom.gb", $E331, $E335 - $E331

UnknownData_0xE335:
INCBIN "baserom.gb", $E335, $E336 - $E335

LoggedData_0xE336:
INCBIN "baserom.gb", $E336, $E339 - $E336

UnknownData_0xE339:
INCBIN "baserom.gb", $E339, $E33A - $E339

LoggedData_0xE33A:
INCBIN "baserom.gb", $E33A, $E33D - $E33A

UnknownData_0xE33D:
INCBIN "baserom.gb", $E33D, $E33E - $E33D

LoggedData_0xE33E:
INCBIN "baserom.gb", $E33E, $E341 - $E33E

UnknownData_0xE341:
INCBIN "baserom.gb", $E341, $E342 - $E341

LoggedData_0xE342:
INCBIN "baserom.gb", $E342, $E346 - $E342

UnknownData_0xE346:
INCBIN "baserom.gb", $E346, $E347 - $E346

LoggedData_0xE347:
INCBIN "baserom.gb", $E347, $E34A - $E347

UnknownData_0xE34A:
INCBIN "baserom.gb", $E34A, $E34B - $E34A

LoggedData_0xE34B:
INCBIN "baserom.gb", $E34B, $E34E - $E34B

UnknownData_0xE34E:
INCBIN "baserom.gb", $E34E, $E34F - $E34E

LoggedData_0xE34F:
INCBIN "baserom.gb", $E34F, $E352 - $E34F

UnknownData_0xE352:
INCBIN "baserom.gb", $E352, $E353 - $E352

LoggedData_0xE353:
INCBIN "baserom.gb", $E353, $E357 - $E353

UnknownData_0xE357:
INCBIN "baserom.gb", $E357, $E358 - $E357

LoggedData_0xE358:
INCBIN "baserom.gb", $E358, $E35B - $E358

UnknownData_0xE35B:
INCBIN "baserom.gb", $E35B, $E35C - $E35B

LoggedData_0xE35C:
INCBIN "baserom.gb", $E35C, $E35F - $E35C

UnknownData_0xE35F:
INCBIN "baserom.gb", $E35F, $E360 - $E35F

LoggedData_0xE360:
INCBIN "baserom.gb", $E360, $E363 - $E360

UnknownData_0xE363:
INCBIN "baserom.gb", $E363, $E364 - $E363

LoggedData_0xE364:
INCBIN "baserom.gb", $E364, $E368 - $E364

UnknownData_0xE368:
INCBIN "baserom.gb", $E368, $E369 - $E368

LoggedData_0xE369:
INCBIN "baserom.gb", $E369, $E36C - $E369

UnknownData_0xE36C:
INCBIN "baserom.gb", $E36C, $E36D - $E36C

LoggedData_0xE36D:
INCBIN "baserom.gb", $E36D, $E370 - $E36D

UnknownData_0xE370:
INCBIN "baserom.gb", $E370, $E371 - $E370

LoggedData_0xE371:
INCBIN "baserom.gb", $E371, $E374 - $E371

UnknownData_0xE374:
INCBIN "baserom.gb", $E374, $E375 - $E374

LoggedData_0xE375:
INCBIN "baserom.gb", $E375, $E379 - $E375

UnknownData_0xE379:
INCBIN "baserom.gb", $E379, $E37A - $E379

LoggedData_0xE37A:
INCBIN "baserom.gb", $E37A, $E37D - $E37A

UnknownData_0xE37D:
INCBIN "baserom.gb", $E37D, $E37E - $E37D

LoggedData_0xE37E:
INCBIN "baserom.gb", $E37E, $E381 - $E37E

UnknownData_0xE381:
INCBIN "baserom.gb", $E381, $E382 - $E381

LoggedData_0xE382:
INCBIN "baserom.gb", $E382, $E385 - $E382

UnknownData_0xE385:
INCBIN "baserom.gb", $E385, $E386 - $E385

LoggedData_0xE386:
INCBIN "baserom.gb", $E386, $E389 - $E386

UnknownData_0xE389:
INCBIN "baserom.gb", $E389, $E38A - $E389

LoggedData_0xE38A:
INCBIN "baserom.gb", $E38A, $E38D - $E38A

UnknownData_0xE38D:
INCBIN "baserom.gb", $E38D, $E38E - $E38D

LoggedData_0xE38E:
INCBIN "baserom.gb", $E38E, $E392 - $E38E

UnknownData_0xE392:
INCBIN "baserom.gb", $E392, $E393 - $E392

LoggedData_0xE393:
INCBIN "baserom.gb", $E393, $E396 - $E393

UnknownData_0xE396:
INCBIN "baserom.gb", $E396, $E397 - $E396

LoggedData_0xE397:
INCBIN "baserom.gb", $E397, $E39A - $E397

UnknownData_0xE39A:
INCBIN "baserom.gb", $E39A, $E39B - $E39A

LoggedData_0xE39B:
INCBIN "baserom.gb", $E39B, $E39E - $E39B

UnknownData_0xE39E:
INCBIN "baserom.gb", $E39E, $E39F - $E39E

LoggedData_0xE39F:
INCBIN "baserom.gb", $E39F, $E3A2 - $E39F

UnknownData_0xE3A2:
INCBIN "baserom.gb", $E3A2, $E3A3 - $E3A2

LoggedData_0xE3A3:
INCBIN "baserom.gb", $E3A3, $E3A6 - $E3A3

UnknownData_0xE3A6:
INCBIN "baserom.gb", $E3A6, $E3A7 - $E3A6

LoggedData_0xE3A7:
INCBIN "baserom.gb", $E3A7, $E3AA - $E3A7

UnknownData_0xE3AA:
INCBIN "baserom.gb", $E3AA, $E3AB - $E3AA

LoggedData_0xE3AB:
INCBIN "baserom.gb", $E3AB, $E3AE - $E3AB

UnknownData_0xE3AE:
INCBIN "baserom.gb", $E3AE, $E3AF - $E3AE

LoggedData_0xE3AF:
INCBIN "baserom.gb", $E3AF, $E3B3 - $E3AF

UnknownData_0xE3B3:
INCBIN "baserom.gb", $E3B3, $E3B4 - $E3B3

LoggedData_0xE3B4:
INCBIN "baserom.gb", $E3B4, $E3B7 - $E3B4

UnknownData_0xE3B7:
INCBIN "baserom.gb", $E3B7, $E3B8 - $E3B7

LoggedData_0xE3B8:
INCBIN "baserom.gb", $E3B8, $E3BB - $E3B8

UnknownData_0xE3BB:
INCBIN "baserom.gb", $E3BB, $E3BC - $E3BB

LoggedData_0xE3BC:
INCBIN "baserom.gb", $E3BC, $E3BF - $E3BC

UnknownData_0xE3BF:
INCBIN "baserom.gb", $E3BF, $E3C0 - $E3BF

LoggedData_0xE3C0:
INCBIN "baserom.gb", $E3C0, $E3C4 - $E3C0

UnknownData_0xE3C4:
INCBIN "baserom.gb", $E3C4, $E3C5 - $E3C4

LoggedData_0xE3C5:
INCBIN "baserom.gb", $E3C5, $E3C8 - $E3C5

UnknownData_0xE3C8:
INCBIN "baserom.gb", $E3C8, $E3C9 - $E3C8

LoggedData_0xE3C9:
INCBIN "baserom.gb", $E3C9, $E3CC - $E3C9

UnknownData_0xE3CC:
INCBIN "baserom.gb", $E3CC, $E3CD - $E3CC

LoggedData_0xE3CD:
INCBIN "baserom.gb", $E3CD, $E3D0 - $E3CD

UnknownData_0xE3D0:
INCBIN "baserom.gb", $E3D0, $E3D1 - $E3D0

LoggedData_0xE3D1:
INCBIN "baserom.gb", $E3D1, $E3D5 - $E3D1

UnknownData_0xE3D5:
INCBIN "baserom.gb", $E3D5, $E3D6 - $E3D5

LoggedData_0xE3D6:
INCBIN "baserom.gb", $E3D6, $E3D9 - $E3D6

UnknownData_0xE3D9:
INCBIN "baserom.gb", $E3D9, $E3DA - $E3D9

LoggedData_0xE3DA:
INCBIN "baserom.gb", $E3DA, $E3DD - $E3DA

UnknownData_0xE3DD:
INCBIN "baserom.gb", $E3DD, $E3DE - $E3DD

LoggedData_0xE3DE:
INCBIN "baserom.gb", $E3DE, $E3E1 - $E3DE

UnknownData_0xE3E1:
INCBIN "baserom.gb", $E3E1, $E3E2 - $E3E1

LoggedData_0xE3E2:
INCBIN "baserom.gb", $E3E2, $E3E6 - $E3E2

UnknownData_0xE3E6:
INCBIN "baserom.gb", $E3E6, $E3E7 - $E3E6

LoggedData_0xE3E7:
INCBIN "baserom.gb", $E3E7, $E3EA - $E3E7

UnknownData_0xE3EA:
INCBIN "baserom.gb", $E3EA, $E3EB - $E3EA

LoggedData_0xE3EB:
INCBIN "baserom.gb", $E3EB, $E3EE - $E3EB

UnknownData_0xE3EE:
INCBIN "baserom.gb", $E3EE, $E3EF - $E3EE

LoggedData_0xE3EF:
INCBIN "baserom.gb", $E3EF, $E3F2 - $E3EF

UnknownData_0xE3F2:
INCBIN "baserom.gb", $E3F2, $E3F3 - $E3F2

LoggedData_0xE3F3:
INCBIN "baserom.gb", $E3F3, $E3F7 - $E3F3

UnknownData_0xE3F7:
INCBIN "baserom.gb", $E3F7, $E3F8 - $E3F7

LoggedData_0xE3F8:
INCBIN "baserom.gb", $E3F8, $E3FB - $E3F8

UnknownData_0xE3FB:
INCBIN "baserom.gb", $E3FB, $E3FC - $E3FB

LoggedData_0xE3FC:
INCBIN "baserom.gb", $E3FC, $E3FF - $E3FC

UnknownData_0xE3FF:
INCBIN "baserom.gb", $E3FF, $E400 - $E3FF

LoggedData_0xE400:
INCBIN "baserom.gb", $E400, $E403 - $E400

UnknownData_0xE403:
INCBIN "baserom.gb", $E403, $E404 - $E403

LoggedData_0xE404:
INCBIN "baserom.gb", $E404, $E408 - $E404

UnknownData_0xE408:
INCBIN "baserom.gb", $E408, $E409 - $E408

LoggedData_0xE409:
INCBIN "baserom.gb", $E409, $E40C - $E409

UnknownData_0xE40C:
INCBIN "baserom.gb", $E40C, $E40D - $E40C

LoggedData_0xE40D:
INCBIN "baserom.gb", $E40D, $E410 - $E40D

UnknownData_0xE410:
INCBIN "baserom.gb", $E410, $E411 - $E410

LoggedData_0xE411:
INCBIN "baserom.gb", $E411, $E414 - $E411

UnknownData_0xE414:
INCBIN "baserom.gb", $E414, $E415 - $E414

LoggedData_0xE415:
INCBIN "baserom.gb", $E415, $E419 - $E415

UnknownData_0xE419:
INCBIN "baserom.gb", $E419, $E41A - $E419

LoggedData_0xE41A:
INCBIN "baserom.gb", $E41A, $E41D - $E41A

UnknownData_0xE41D:
INCBIN "baserom.gb", $E41D, $E41E - $E41D

LoggedData_0xE41E:
INCBIN "baserom.gb", $E41E, $E421 - $E41E

UnknownData_0xE421:
INCBIN "baserom.gb", $E421, $E422 - $E421

LoggedData_0xE422:
INCBIN "baserom.gb", $E422, $E425 - $E422

UnknownData_0xE425:
INCBIN "baserom.gb", $E425, $E426 - $E425

LoggedData_0xE426:
INCBIN "baserom.gb", $E426, $E42A - $E426

UnknownData_0xE42A:
INCBIN "baserom.gb", $E42A, $E42B - $E42A

LoggedData_0xE42B:
INCBIN "baserom.gb", $E42B, $E42E - $E42B

UnknownData_0xE42E:
INCBIN "baserom.gb", $E42E, $E42F - $E42E

LoggedData_0xE42F:
INCBIN "baserom.gb", $E42F, $E432 - $E42F

UnknownData_0xE432:
INCBIN "baserom.gb", $E432, $E433 - $E432

LoggedData_0xE433:
INCBIN "baserom.gb", $E433, $E436 - $E433

UnknownData_0xE436:
INCBIN "baserom.gb", $E436, $E437 - $E436

LoggedData_0xE437:
INCBIN "baserom.gb", $E437, $E43B - $E437

UnknownData_0xE43B:
INCBIN "baserom.gb", $E43B, $E43C - $E43B

LoggedData_0xE43C:
INCBIN "baserom.gb", $E43C, $E43F - $E43C

UnknownData_0xE43F:
INCBIN "baserom.gb", $E43F, $E440 - $E43F

LoggedData_0xE440:
INCBIN "baserom.gb", $E440, $E443 - $E440

UnknownData_0xE443:
INCBIN "baserom.gb", $E443, $E444 - $E443

LoggedData_0xE444:
INCBIN "baserom.gb", $E444, $E447 - $E444

UnknownData_0xE447:
INCBIN "baserom.gb", $E447, $E448 - $E447

LoggedData_0xE448:
INCBIN "baserom.gb", $E448, $E44B - $E448

UnknownData_0xE44B:
INCBIN "baserom.gb", $E44B, $E44C - $E44B

LoggedData_0xE44C:
INCBIN "baserom.gb", $E44C, $E450 - $E44C

UnknownData_0xE450:
INCBIN "baserom.gb", $E450, $E451 - $E450

LoggedData_0xE451:
INCBIN "baserom.gb", $E451, $E454 - $E451

UnknownData_0xE454:
INCBIN "baserom.gb", $E454, $E455 - $E454

LoggedData_0xE455:
INCBIN "baserom.gb", $E455, $E458 - $E455

UnknownData_0xE458:
INCBIN "baserom.gb", $E458, $E459 - $E458

LoggedData_0xE459:
INCBIN "baserom.gb", $E459, $E45C - $E459

UnknownData_0xE45C:
INCBIN "baserom.gb", $E45C, $E45D - $E45C

LoggedData_0xE45D:
INCBIN "baserom.gb", $E45D, $E460 - $E45D

UnknownData_0xE460:
INCBIN "baserom.gb", $E460, $E461 - $E460

LoggedData_0xE461:
INCBIN "baserom.gb", $E461, $E465 - $E461

UnknownData_0xE465:
INCBIN "baserom.gb", $E465, $E466 - $E465

LoggedData_0xE466:
INCBIN "baserom.gb", $E466, $E469 - $E466

UnknownData_0xE469:
INCBIN "baserom.gb", $E469, $E46A - $E469

LoggedData_0xE46A:
INCBIN "baserom.gb", $E46A, $E46D - $E46A

UnknownData_0xE46D:
INCBIN "baserom.gb", $E46D, $E46E - $E46D

LoggedData_0xE46E:
INCBIN "baserom.gb", $E46E, $E471 - $E46E

UnknownData_0xE471:
INCBIN "baserom.gb", $E471, $E472 - $E471

LoggedData_0xE472:
INCBIN "baserom.gb", $E472, $E475 - $E472

UnknownData_0xE475:
INCBIN "baserom.gb", $E475, $E476 - $E475

LoggedData_0xE476:
INCBIN "baserom.gb", $E476, $E47A - $E476

UnknownData_0xE47A:
INCBIN "baserom.gb", $E47A, $E47B - $E47A

LoggedData_0xE47B:
INCBIN "baserom.gb", $E47B, $E47E - $E47B

UnknownData_0xE47E:
INCBIN "baserom.gb", $E47E, $E47F - $E47E

LoggedData_0xE47F:
INCBIN "baserom.gb", $E47F, $E482 - $E47F

UnknownData_0xE482:
INCBIN "baserom.gb", $E482, $E483 - $E482

LoggedData_0xE483:
INCBIN "baserom.gb", $E483, $E486 - $E483

UnknownData_0xE486:
INCBIN "baserom.gb", $E486, $E487 - $E486

LoggedData_0xE487:
INCBIN "baserom.gb", $E487, $E48A - $E487

UnknownData_0xE48A:
INCBIN "baserom.gb", $E48A, $E48B - $E48A

LoggedData_0xE48B:
INCBIN "baserom.gb", $E48B, $E4A0 - $E48B

UnknownData_0xE4A0:
INCBIN "baserom.gb", $E4A0, $E4A2 - $E4A0

LoggedData_0xE4A2:
INCBIN "baserom.gb", $E4A2, $E4A6 - $E4A2

UnknownData_0xE4A6:
INCBIN "baserom.gb", $E4A6, $E4A8 - $E4A6

LoggedData_0xE4A8:
INCBIN "baserom.gb", $E4A8, $E4C2 - $E4A8

UnknownData_0xE4C2:
INCBIN "baserom.gb", $E4C2, $E4C4 - $E4C2

LoggedData_0xE4C4:
INCBIN "baserom.gb", $E4C4, $E4C7 - $E4C4

UnknownData_0xE4C7:
INCBIN "baserom.gb", $E4C7, $E4C8 - $E4C7

LoggedData_0xE4C8:
INCBIN "baserom.gb", $E4C8, $E4CB - $E4C8

UnknownData_0xE4CB:
INCBIN "baserom.gb", $E4CB, $E4CC - $E4CB

LoggedData_0xE4CC:
INCBIN "baserom.gb", $E4CC, $E4CF - $E4CC

UnknownData_0xE4CF:
INCBIN "baserom.gb", $E4CF, $E4D0 - $E4CF

LoggedData_0xE4D0:
INCBIN "baserom.gb", $E4D0, $E4D3 - $E4D0

UnknownData_0xE4D3:
INCBIN "baserom.gb", $E4D3, $E4D4 - $E4D3

LoggedData_0xE4D4:
INCBIN "baserom.gb", $E4D4, $E4D8 - $E4D4

UnknownData_0xE4D8:
INCBIN "baserom.gb", $E4D8, $E4D9 - $E4D8

LoggedData_0xE4D9:
INCBIN "baserom.gb", $E4D9, $E4DC - $E4D9

UnknownData_0xE4DC:
INCBIN "baserom.gb", $E4DC, $E4DD - $E4DC

LoggedData_0xE4DD:
INCBIN "baserom.gb", $E4DD, $E4E0 - $E4DD

UnknownData_0xE4E0:
INCBIN "baserom.gb", $E4E0, $E4E1 - $E4E0

LoggedData_0xE4E1:
INCBIN "baserom.gb", $E4E1, $E4E4 - $E4E1

UnknownData_0xE4E4:
INCBIN "baserom.gb", $E4E4, $E4E5 - $E4E4

LoggedData_0xE4E5:
INCBIN "baserom.gb", $E4E5, $E4E9 - $E4E5

UnknownData_0xE4E9:
INCBIN "baserom.gb", $E4E9, $E4EA - $E4E9

LoggedData_0xE4EA:
INCBIN "baserom.gb", $E4EA, $E4ED - $E4EA

UnknownData_0xE4ED:
INCBIN "baserom.gb", $E4ED, $E4EE - $E4ED

LoggedData_0xE4EE:
INCBIN "baserom.gb", $E4EE, $E4F1 - $E4EE

UnknownData_0xE4F1:
INCBIN "baserom.gb", $E4F1, $E4F2 - $E4F1

LoggedData_0xE4F2:
INCBIN "baserom.gb", $E4F2, $E4F5 - $E4F2

UnknownData_0xE4F5:
INCBIN "baserom.gb", $E4F5, $E4F6 - $E4F5

LoggedData_0xE4F6:
INCBIN "baserom.gb", $E4F6, $E4FA - $E4F6

UnknownData_0xE4FA:
INCBIN "baserom.gb", $E4FA, $E4FB - $E4FA

LoggedData_0xE4FB:
INCBIN "baserom.gb", $E4FB, $E4FE - $E4FB

UnknownData_0xE4FE:
INCBIN "baserom.gb", $E4FE, $E4FF - $E4FE

LoggedData_0xE4FF:
INCBIN "baserom.gb", $E4FF, $E502 - $E4FF

UnknownData_0xE502:
INCBIN "baserom.gb", $E502, $E503 - $E502

LoggedData_0xE503:
INCBIN "baserom.gb", $E503, $E506 - $E503

UnknownData_0xE506:
INCBIN "baserom.gb", $E506, $E507 - $E506

LoggedData_0xE507:
INCBIN "baserom.gb", $E507, $E50B - $E507

UnknownData_0xE50B:
INCBIN "baserom.gb", $E50B, $E50C - $E50B

LoggedData_0xE50C:
INCBIN "baserom.gb", $E50C, $E50F - $E50C

UnknownData_0xE50F:
INCBIN "baserom.gb", $E50F, $E510 - $E50F

LoggedData_0xE510:
INCBIN "baserom.gb", $E510, $E513 - $E510

UnknownData_0xE513:
INCBIN "baserom.gb", $E513, $E514 - $E513

LoggedData_0xE514:
INCBIN "baserom.gb", $E514, $E517 - $E514

UnknownData_0xE517:
INCBIN "baserom.gb", $E517, $E518 - $E517

LoggedData_0xE518:
INCBIN "baserom.gb", $E518, $E51C - $E518

UnknownData_0xE51C:
INCBIN "baserom.gb", $E51C, $E51D - $E51C

LoggedData_0xE51D:
INCBIN "baserom.gb", $E51D, $E520 - $E51D

UnknownData_0xE520:
INCBIN "baserom.gb", $E520, $E521 - $E520

LoggedData_0xE521:
INCBIN "baserom.gb", $E521, $E524 - $E521

UnknownData_0xE524:
INCBIN "baserom.gb", $E524, $E525 - $E524

LoggedData_0xE525:
INCBIN "baserom.gb", $E525, $E528 - $E525

UnknownData_0xE528:
INCBIN "baserom.gb", $E528, $E529 - $E528

LoggedData_0xE529:
INCBIN "baserom.gb", $E529, $E52D - $E529

UnknownData_0xE52D:
INCBIN "baserom.gb", $E52D, $E52E - $E52D

LoggedData_0xE52E:
INCBIN "baserom.gb", $E52E, $E531 - $E52E

UnknownData_0xE531:
INCBIN "baserom.gb", $E531, $E532 - $E531

LoggedData_0xE532:
INCBIN "baserom.gb", $E532, $E535 - $E532

UnknownData_0xE535:
INCBIN "baserom.gb", $E535, $E536 - $E535

LoggedData_0xE536:
INCBIN "baserom.gb", $E536, $E539 - $E536

UnknownData_0xE539:
INCBIN "baserom.gb", $E539, $E53A - $E539

LoggedData_0xE53A:
INCBIN "baserom.gb", $E53A, $E53E - $E53A

UnknownData_0xE53E:
INCBIN "baserom.gb", $E53E, $E53F - $E53E

LoggedData_0xE53F:
INCBIN "baserom.gb", $E53F, $E542 - $E53F

UnknownData_0xE542:
INCBIN "baserom.gb", $E542, $E543 - $E542

LoggedData_0xE543:
INCBIN "baserom.gb", $E543, $E546 - $E543

UnknownData_0xE546:
INCBIN "baserom.gb", $E546, $E547 - $E546

LoggedData_0xE547:
INCBIN "baserom.gb", $E547, $E54A - $E547

UnknownData_0xE54A:
INCBIN "baserom.gb", $E54A, $E54B - $E54A

LoggedData_0xE54B:
INCBIN "baserom.gb", $E54B, $E54F - $E54B

UnknownData_0xE54F:
INCBIN "baserom.gb", $E54F, $E550 - $E54F

LoggedData_0xE550:
INCBIN "baserom.gb", $E550, $E553 - $E550

UnknownData_0xE553:
INCBIN "baserom.gb", $E553, $E554 - $E553

LoggedData_0xE554:
INCBIN "baserom.gb", $E554, $E557 - $E554

UnknownData_0xE557:
INCBIN "baserom.gb", $E557, $E558 - $E557

LoggedData_0xE558:
INCBIN "baserom.gb", $E558, $E55B - $E558

UnknownData_0xE55B:
INCBIN "baserom.gb", $E55B, $E55C - $E55B

LoggedData_0xE55C:
INCBIN "baserom.gb", $E55C, $E560 - $E55C

UnknownData_0xE560:
INCBIN "baserom.gb", $E560, $E561 - $E560

LoggedData_0xE561:
INCBIN "baserom.gb", $E561, $E564 - $E561

UnknownData_0xE564:
INCBIN "baserom.gb", $E564, $E565 - $E564

LoggedData_0xE565:
INCBIN "baserom.gb", $E565, $E568 - $E565

UnknownData_0xE568:
INCBIN "baserom.gb", $E568, $E569 - $E568

LoggedData_0xE569:
INCBIN "baserom.gb", $E569, $E56C - $E569

UnknownData_0xE56C:
INCBIN "baserom.gb", $E56C, $E56D - $E56C

LoggedData_0xE56D:
INCBIN "baserom.gb", $E56D, $E571 - $E56D

UnknownData_0xE571:
INCBIN "baserom.gb", $E571, $E572 - $E571

LoggedData_0xE572:
INCBIN "baserom.gb", $E572, $E575 - $E572

UnknownData_0xE575:
INCBIN "baserom.gb", $E575, $E576 - $E575

LoggedData_0xE576:
INCBIN "baserom.gb", $E576, $E579 - $E576

UnknownData_0xE579:
INCBIN "baserom.gb", $E579, $E57A - $E579

LoggedData_0xE57A:
INCBIN "baserom.gb", $E57A, $E57D - $E57A

UnknownData_0xE57D:
INCBIN "baserom.gb", $E57D, $E57E - $E57D

LoggedData_0xE57E:
INCBIN "baserom.gb", $E57E, $E581 - $E57E

UnknownData_0xE581:
INCBIN "baserom.gb", $E581, $E582 - $E581

LoggedData_0xE582:
INCBIN "baserom.gb", $E582, $E585 - $E582

UnknownData_0xE585:
INCBIN "baserom.gb", $E585, $E586 - $E585

LoggedData_0xE586:
INCBIN "baserom.gb", $E586, $E58A - $E586

UnknownData_0xE58A:
INCBIN "baserom.gb", $E58A, $E58B - $E58A

LoggedData_0xE58B:
INCBIN "baserom.gb", $E58B, $E58E - $E58B

UnknownData_0xE58E:
INCBIN "baserom.gb", $E58E, $E58F - $E58E

LoggedData_0xE58F:
INCBIN "baserom.gb", $E58F, $E592 - $E58F

UnknownData_0xE592:
INCBIN "baserom.gb", $E592, $E593 - $E592

LoggedData_0xE593:
INCBIN "baserom.gb", $E593, $E596 - $E593

UnknownData_0xE596:
INCBIN "baserom.gb", $E596, $E597 - $E596

LoggedData_0xE597:
INCBIN "baserom.gb", $E597, $E59A - $E597

UnknownData_0xE59A:
INCBIN "baserom.gb", $E59A, $E59B - $E59A

LoggedData_0xE59B:
INCBIN "baserom.gb", $E59B, $E59E - $E59B

UnknownData_0xE59E:
INCBIN "baserom.gb", $E59E, $E59F - $E59E

LoggedData_0xE59F:
INCBIN "baserom.gb", $E59F, $E5A2 - $E59F

UnknownData_0xE5A2:
INCBIN "baserom.gb", $E5A2, $E5A3 - $E5A2

LoggedData_0xE5A3:
INCBIN "baserom.gb", $E5A3, $E5A6 - $E5A3

UnknownData_0xE5A6:
INCBIN "baserom.gb", $E5A6, $E5A7 - $E5A6

LoggedData_0xE5A7:
INCBIN "baserom.gb", $E5A7, $E5AB - $E5A7

UnknownData_0xE5AB:
INCBIN "baserom.gb", $E5AB, $E5AC - $E5AB

LoggedData_0xE5AC:
INCBIN "baserom.gb", $E5AC, $E5AF - $E5AC

UnknownData_0xE5AF:
INCBIN "baserom.gb", $E5AF, $E5B0 - $E5AF

LoggedData_0xE5B0:
INCBIN "baserom.gb", $E5B0, $E5B3 - $E5B0

UnknownData_0xE5B3:
INCBIN "baserom.gb", $E5B3, $E5B4 - $E5B3

LoggedData_0xE5B4:
INCBIN "baserom.gb", $E5B4, $E5B7 - $E5B4

UnknownData_0xE5B7:
INCBIN "baserom.gb", $E5B7, $E5B8 - $E5B7

LoggedData_0xE5B8:
INCBIN "baserom.gb", $E5B8, $E5BC - $E5B8

UnknownData_0xE5BC:
INCBIN "baserom.gb", $E5BC, $E5BD - $E5BC

LoggedData_0xE5BD:
INCBIN "baserom.gb", $E5BD, $E5C0 - $E5BD

UnknownData_0xE5C0:
INCBIN "baserom.gb", $E5C0, $E5C1 - $E5C0

LoggedData_0xE5C1:
INCBIN "baserom.gb", $E5C1, $E5C4 - $E5C1

UnknownData_0xE5C4:
INCBIN "baserom.gb", $E5C4, $E5C5 - $E5C4

LoggedData_0xE5C5:
INCBIN "baserom.gb", $E5C5, $E5C8 - $E5C5

UnknownData_0xE5C8:
INCBIN "baserom.gb", $E5C8, $E5C9 - $E5C8

LoggedData_0xE5C9:
INCBIN "baserom.gb", $E5C9, $E5CD - $E5C9

UnknownData_0xE5CD:
INCBIN "baserom.gb", $E5CD, $E5CE - $E5CD

LoggedData_0xE5CE:
INCBIN "baserom.gb", $E5CE, $E5D1 - $E5CE

UnknownData_0xE5D1:
INCBIN "baserom.gb", $E5D1, $E5D2 - $E5D1

LoggedData_0xE5D2:
INCBIN "baserom.gb", $E5D2, $E5D5 - $E5D2

UnknownData_0xE5D5:
INCBIN "baserom.gb", $E5D5, $E5D6 - $E5D5

LoggedData_0xE5D6:
INCBIN "baserom.gb", $E5D6, $E5D9 - $E5D6

UnknownData_0xE5D9:
INCBIN "baserom.gb", $E5D9, $E5DA - $E5D9

LoggedData_0xE5DA:
INCBIN "baserom.gb", $E5DA, $E5DE - $E5DA

UnknownData_0xE5DE:
INCBIN "baserom.gb", $E5DE, $E5DF - $E5DE

LoggedData_0xE5DF:
INCBIN "baserom.gb", $E5DF, $E5E2 - $E5DF

UnknownData_0xE5E2:
INCBIN "baserom.gb", $E5E2, $E5E3 - $E5E2

LoggedData_0xE5E3:
INCBIN "baserom.gb", $E5E3, $E5E6 - $E5E3

UnknownData_0xE5E6:
INCBIN "baserom.gb", $E5E6, $E5E7 - $E5E6

LoggedData_0xE5E7:
INCBIN "baserom.gb", $E5E7, $E5EA - $E5E7

UnknownData_0xE5EA:
INCBIN "baserom.gb", $E5EA, $E5EB - $E5EA

LoggedData_0xE5EB:
INCBIN "baserom.gb", $E5EB, $E5EF - $E5EB

UnknownData_0xE5EF:
INCBIN "baserom.gb", $E5EF, $E5F0 - $E5EF

LoggedData_0xE5F0:
INCBIN "baserom.gb", $E5F0, $E5F3 - $E5F0

UnknownData_0xE5F3:
INCBIN "baserom.gb", $E5F3, $E5F4 - $E5F3

LoggedData_0xE5F4:
INCBIN "baserom.gb", $E5F4, $E5F7 - $E5F4

UnknownData_0xE5F7:
INCBIN "baserom.gb", $E5F7, $E5F8 - $E5F7

LoggedData_0xE5F8:
INCBIN "baserom.gb", $E5F8, $E5FB - $E5F8

UnknownData_0xE5FB:
INCBIN "baserom.gb", $E5FB, $E5FC - $E5FB

LoggedData_0xE5FC:
INCBIN "baserom.gb", $E5FC, $E600 - $E5FC

UnknownData_0xE600:
INCBIN "baserom.gb", $E600, $E601 - $E600

LoggedData_0xE601:
INCBIN "baserom.gb", $E601, $E604 - $E601

UnknownData_0xE604:
INCBIN "baserom.gb", $E604, $E605 - $E604

LoggedData_0xE605:
INCBIN "baserom.gb", $E605, $E608 - $E605

UnknownData_0xE608:
INCBIN "baserom.gb", $E608, $E609 - $E608

LoggedData_0xE609:
INCBIN "baserom.gb", $E609, $E60C - $E609

UnknownData_0xE60C:
INCBIN "baserom.gb", $E60C, $E60D - $E60C

LoggedData_0xE60D:
INCBIN "baserom.gb", $E60D, $E611 - $E60D

UnknownData_0xE611:
INCBIN "baserom.gb", $E611, $E612 - $E611

LoggedData_0xE612:
INCBIN "baserom.gb", $E612, $E615 - $E612

UnknownData_0xE615:
INCBIN "baserom.gb", $E615, $E616 - $E615

LoggedData_0xE616:
INCBIN "baserom.gb", $E616, $E619 - $E616

UnknownData_0xE619:
INCBIN "baserom.gb", $E619, $E61A - $E619

LoggedData_0xE61A:
INCBIN "baserom.gb", $E61A, $E61D - $E61A

UnknownData_0xE61D:
INCBIN "baserom.gb", $E61D, $E61E - $E61D

LoggedData_0xE61E:
INCBIN "baserom.gb", $E61E, $E622 - $E61E

UnknownData_0xE622:
INCBIN "baserom.gb", $E622, $E623 - $E622

LoggedData_0xE623:
INCBIN "baserom.gb", $E623, $E626 - $E623

UnknownData_0xE626:
INCBIN "baserom.gb", $E626, $E627 - $E626

LoggedData_0xE627:
INCBIN "baserom.gb", $E627, $E62A - $E627

UnknownData_0xE62A:
INCBIN "baserom.gb", $E62A, $E62B - $E62A

LoggedData_0xE62B:
INCBIN "baserom.gb", $E62B, $E62E - $E62B

UnknownData_0xE62E:
INCBIN "baserom.gb", $E62E, $E62F - $E62E

LoggedData_0xE62F:
INCBIN "baserom.gb", $E62F, $E633 - $E62F

UnknownData_0xE633:
INCBIN "baserom.gb", $E633, $E634 - $E633

LoggedData_0xE634:
INCBIN "baserom.gb", $E634, $E637 - $E634

UnknownData_0xE637:
INCBIN "baserom.gb", $E637, $E638 - $E637

LoggedData_0xE638:
INCBIN "baserom.gb", $E638, $E63B - $E638

UnknownData_0xE63B:
INCBIN "baserom.gb", $E63B, $E63C - $E63B

LoggedData_0xE63C:
INCBIN "baserom.gb", $E63C, $E63F - $E63C

UnknownData_0xE63F:
INCBIN "baserom.gb", $E63F, $E640 - $E63F

LoggedData_0xE640:
INCBIN "baserom.gb", $E640, $E643 - $E640

UnknownData_0xE643:
INCBIN "baserom.gb", $E643, $E644 - $E643

LoggedData_0xE644:
INCBIN "baserom.gb", $E644, $E648 - $E644

UnknownData_0xE648:
INCBIN "baserom.gb", $E648, $E649 - $E648

LoggedData_0xE649:
INCBIN "baserom.gb", $E649, $E64C - $E649

UnknownData_0xE64C:
INCBIN "baserom.gb", $E64C, $E64D - $E64C

LoggedData_0xE64D:
INCBIN "baserom.gb", $E64D, $E650 - $E64D

UnknownData_0xE650:
INCBIN "baserom.gb", $E650, $E651 - $E650

LoggedData_0xE651:
INCBIN "baserom.gb", $E651, $E654 - $E651

UnknownData_0xE654:
INCBIN "baserom.gb", $E654, $E655 - $E654

LoggedData_0xE655:
INCBIN "baserom.gb", $E655, $E658 - $E655

UnknownData_0xE658:
INCBIN "baserom.gb", $E658, $E659 - $E658

LoggedData_0xE659:
INCBIN "baserom.gb", $E659, $E65D - $E659

UnknownData_0xE65D:
INCBIN "baserom.gb", $E65D, $E65E - $E65D

LoggedData_0xE65E:
INCBIN "baserom.gb", $E65E, $E661 - $E65E

UnknownData_0xE661:
INCBIN "baserom.gb", $E661, $E662 - $E661

LoggedData_0xE662:
INCBIN "baserom.gb", $E662, $E665 - $E662

UnknownData_0xE665:
INCBIN "baserom.gb", $E665, $E666 - $E665

LoggedData_0xE666:
INCBIN "baserom.gb", $E666, $E669 - $E666

UnknownData_0xE669:
INCBIN "baserom.gb", $E669, $E66A - $E669

LoggedData_0xE66A:
INCBIN "baserom.gb", $E66A, $E66D - $E66A

UnknownData_0xE66D:
INCBIN "baserom.gb", $E66D, $E66E - $E66D

LoggedData_0xE66E:
INCBIN "baserom.gb", $E66E, $E672 - $E66E

UnknownData_0xE672:
INCBIN "baserom.gb", $E672, $E673 - $E672

LoggedData_0xE673:
INCBIN "baserom.gb", $E673, $E676 - $E673

UnknownData_0xE676:
INCBIN "baserom.gb", $E676, $E677 - $E676

LoggedData_0xE677:
INCBIN "baserom.gb", $E677, $E67A - $E677

UnknownData_0xE67A:
INCBIN "baserom.gb", $E67A, $E67B - $E67A

LoggedData_0xE67B:
INCBIN "baserom.gb", $E67B, $E67E - $E67B

UnknownData_0xE67E:
INCBIN "baserom.gb", $E67E, $E67F - $E67E

LoggedData_0xE67F:
INCBIN "baserom.gb", $E67F, $E682 - $E67F

UnknownData_0xE682:
INCBIN "baserom.gb", $E682, $E683 - $E682

LoggedData_0xE683:
INCBIN "baserom.gb", $E683, $E68C - $E683

UnknownData_0xE68C:
INCBIN "baserom.gb", $E68C, $E68E - $E68C

LoggedData_0xE68E:
INCBIN "baserom.gb", $E68E, $E694 - $E68E

UnknownData_0xE694:
INCBIN "baserom.gb", $E694, $E696 - $E694

LoggedData_0xE696:
INCBIN "baserom.gb", $E696, $E69E - $E696

UnknownData_0xE69E:
INCBIN "baserom.gb", $E69E, $E6A0 - $E69E

LoggedData_0xE6A0:
INCBIN "baserom.gb", $E6A0, $E6A8 - $E6A0

UnknownData_0xE6A8:
INCBIN "baserom.gb", $E6A8, $E6B4 - $E6A8

LoggedData_0xE6B4:
INCBIN "baserom.gb", $E6B4, $E6BC - $E6B4

UnknownData_0xE6BC:
INCBIN "baserom.gb", $E6BC, $E6D2 - $E6BC

LoggedData_0xE6D2:
INCBIN "baserom.gb", $E6D2, $E6D5 - $E6D2

UnknownData_0xE6D5:
INCBIN "baserom.gb", $E6D5, $E6D6 - $E6D5

LoggedData_0xE6D6:
INCBIN "baserom.gb", $E6D6, $E6D9 - $E6D6

UnknownData_0xE6D9:
INCBIN "baserom.gb", $E6D9, $E6DA - $E6D9

LoggedData_0xE6DA:
INCBIN "baserom.gb", $E6DA, $E6DD - $E6DA

UnknownData_0xE6DD:
INCBIN "baserom.gb", $E6DD, $E6DE - $E6DD

LoggedData_0xE6DE:
INCBIN "baserom.gb", $E6DE, $E6E1 - $E6DE

UnknownData_0xE6E1:
INCBIN "baserom.gb", $E6E1, $E6E2 - $E6E1

LoggedData_0xE6E2:
INCBIN "baserom.gb", $E6E2, $E6E6 - $E6E2

UnknownData_0xE6E6:
INCBIN "baserom.gb", $E6E6, $E6E7 - $E6E6

LoggedData_0xE6E7:
INCBIN "baserom.gb", $E6E7, $E6EA - $E6E7

UnknownData_0xE6EA:
INCBIN "baserom.gb", $E6EA, $E6EB - $E6EA

LoggedData_0xE6EB:
INCBIN "baserom.gb", $E6EB, $E6EE - $E6EB

UnknownData_0xE6EE:
INCBIN "baserom.gb", $E6EE, $E6EF - $E6EE

LoggedData_0xE6EF:
INCBIN "baserom.gb", $E6EF, $E6F2 - $E6EF

UnknownData_0xE6F2:
INCBIN "baserom.gb", $E6F2, $E6F3 - $E6F2

LoggedData_0xE6F3:
INCBIN "baserom.gb", $E6F3, $E6F7 - $E6F3

UnknownData_0xE6F7:
INCBIN "baserom.gb", $E6F7, $E6F8 - $E6F7

LoggedData_0xE6F8:
INCBIN "baserom.gb", $E6F8, $E6FB - $E6F8

UnknownData_0xE6FB:
INCBIN "baserom.gb", $E6FB, $E6FC - $E6FB

LoggedData_0xE6FC:
INCBIN "baserom.gb", $E6FC, $E6FF - $E6FC

UnknownData_0xE6FF:
INCBIN "baserom.gb", $E6FF, $E700 - $E6FF

LoggedData_0xE700:
INCBIN "baserom.gb", $E700, $E703 - $E700

UnknownData_0xE703:
INCBIN "baserom.gb", $E703, $E704 - $E703

LoggedData_0xE704:
INCBIN "baserom.gb", $E704, $E708 - $E704

UnknownData_0xE708:
INCBIN "baserom.gb", $E708, $E709 - $E708

LoggedData_0xE709:
INCBIN "baserom.gb", $E709, $E70C - $E709

UnknownData_0xE70C:
INCBIN "baserom.gb", $E70C, $E70D - $E70C

LoggedData_0xE70D:
INCBIN "baserom.gb", $E70D, $E710 - $E70D

UnknownData_0xE710:
INCBIN "baserom.gb", $E710, $E711 - $E710

LoggedData_0xE711:
INCBIN "baserom.gb", $E711, $E714 - $E711

UnknownData_0xE714:
INCBIN "baserom.gb", $E714, $E715 - $E714

LoggedData_0xE715:
INCBIN "baserom.gb", $E715, $E719 - $E715

UnknownData_0xE719:
INCBIN "baserom.gb", $E719, $E71A - $E719

LoggedData_0xE71A:
INCBIN "baserom.gb", $E71A, $E71D - $E71A

UnknownData_0xE71D:
INCBIN "baserom.gb", $E71D, $E71E - $E71D

LoggedData_0xE71E:
INCBIN "baserom.gb", $E71E, $E721 - $E71E

UnknownData_0xE721:
INCBIN "baserom.gb", $E721, $E722 - $E721

LoggedData_0xE722:
INCBIN "baserom.gb", $E722, $E725 - $E722

UnknownData_0xE725:
INCBIN "baserom.gb", $E725, $E726 - $E725

LoggedData_0xE726:
INCBIN "baserom.gb", $E726, $E72A - $E726

UnknownData_0xE72A:
INCBIN "baserom.gb", $E72A, $E72B - $E72A

LoggedData_0xE72B:
INCBIN "baserom.gb", $E72B, $E72E - $E72B

UnknownData_0xE72E:
INCBIN "baserom.gb", $E72E, $E72F - $E72E

LoggedData_0xE72F:
INCBIN "baserom.gb", $E72F, $E732 - $E72F

UnknownData_0xE732:
INCBIN "baserom.gb", $E732, $E733 - $E732

LoggedData_0xE733:
INCBIN "baserom.gb", $E733, $E736 - $E733

UnknownData_0xE736:
INCBIN "baserom.gb", $E736, $E737 - $E736

LoggedData_0xE737:
INCBIN "baserom.gb", $E737, $E73B - $E737

UnknownData_0xE73B:
INCBIN "baserom.gb", $E73B, $E73C - $E73B

LoggedData_0xE73C:
INCBIN "baserom.gb", $E73C, $E73F - $E73C

UnknownData_0xE73F:
INCBIN "baserom.gb", $E73F, $E740 - $E73F

LoggedData_0xE740:
INCBIN "baserom.gb", $E740, $E743 - $E740

UnknownData_0xE743:
INCBIN "baserom.gb", $E743, $E744 - $E743

LoggedData_0xE744:
INCBIN "baserom.gb", $E744, $E747 - $E744

UnknownData_0xE747:
INCBIN "baserom.gb", $E747, $E748 - $E747

LoggedData_0xE748:
INCBIN "baserom.gb", $E748, $E74C - $E748

UnknownData_0xE74C:
INCBIN "baserom.gb", $E74C, $E74D - $E74C

LoggedData_0xE74D:
INCBIN "baserom.gb", $E74D, $E750 - $E74D

UnknownData_0xE750:
INCBIN "baserom.gb", $E750, $E751 - $E750

LoggedData_0xE751:
INCBIN "baserom.gb", $E751, $E754 - $E751

UnknownData_0xE754:
INCBIN "baserom.gb", $E754, $E755 - $E754

LoggedData_0xE755:
INCBIN "baserom.gb", $E755, $E758 - $E755

UnknownData_0xE758:
INCBIN "baserom.gb", $E758, $E759 - $E758

LoggedData_0xE759:
INCBIN "baserom.gb", $E759, $E75D - $E759

UnknownData_0xE75D:
INCBIN "baserom.gb", $E75D, $E75E - $E75D

LoggedData_0xE75E:
INCBIN "baserom.gb", $E75E, $E761 - $E75E

UnknownData_0xE761:
INCBIN "baserom.gb", $E761, $E762 - $E761

LoggedData_0xE762:
INCBIN "baserom.gb", $E762, $E765 - $E762

UnknownData_0xE765:
INCBIN "baserom.gb", $E765, $E766 - $E765

LoggedData_0xE766:
INCBIN "baserom.gb", $E766, $E769 - $E766

UnknownData_0xE769:
INCBIN "baserom.gb", $E769, $E76A - $E769

LoggedData_0xE76A:
INCBIN "baserom.gb", $E76A, $E76E - $E76A

UnknownData_0xE76E:
INCBIN "baserom.gb", $E76E, $E76F - $E76E

LoggedData_0xE76F:
INCBIN "baserom.gb", $E76F, $E772 - $E76F

UnknownData_0xE772:
INCBIN "baserom.gb", $E772, $E773 - $E772

LoggedData_0xE773:
INCBIN "baserom.gb", $E773, $E776 - $E773

UnknownData_0xE776:
INCBIN "baserom.gb", $E776, $E777 - $E776

LoggedData_0xE777:
INCBIN "baserom.gb", $E777, $E77A - $E777

UnknownData_0xE77A:
INCBIN "baserom.gb", $E77A, $E77B - $E77A

LoggedData_0xE77B:
INCBIN "baserom.gb", $E77B, $E77F - $E77B

UnknownData_0xE77F:
INCBIN "baserom.gb", $E77F, $E780 - $E77F

LoggedData_0xE780:
INCBIN "baserom.gb", $E780, $E783 - $E780

UnknownData_0xE783:
INCBIN "baserom.gb", $E783, $E784 - $E783

LoggedData_0xE784:
INCBIN "baserom.gb", $E784, $E787 - $E784

UnknownData_0xE787:
INCBIN "baserom.gb", $E787, $E788 - $E787

LoggedData_0xE788:
INCBIN "baserom.gb", $E788, $E78B - $E788

UnknownData_0xE78B:
INCBIN "baserom.gb", $E78B, $E78C - $E78B

LoggedData_0xE78C:
INCBIN "baserom.gb", $E78C, $E78F - $E78C

UnknownData_0xE78F:
INCBIN "baserom.gb", $E78F, $E790 - $E78F

LoggedData_0xE790:
INCBIN "baserom.gb", $E790, $E794 - $E790

UnknownData_0xE794:
INCBIN "baserom.gb", $E794, $E795 - $E794

LoggedData_0xE795:
INCBIN "baserom.gb", $E795, $E798 - $E795

UnknownData_0xE798:
INCBIN "baserom.gb", $E798, $E799 - $E798

LoggedData_0xE799:
INCBIN "baserom.gb", $E799, $E79C - $E799

UnknownData_0xE79C:
INCBIN "baserom.gb", $E79C, $E79D - $E79C

LoggedData_0xE79D:
INCBIN "baserom.gb", $E79D, $E7A0 - $E79D

UnknownData_0xE7A0:
INCBIN "baserom.gb", $E7A0, $E7A1 - $E7A0

LoggedData_0xE7A1:
INCBIN "baserom.gb", $E7A1, $E7A5 - $E7A1

UnknownData_0xE7A5:
INCBIN "baserom.gb", $E7A5, $E7A6 - $E7A5

LoggedData_0xE7A6:
INCBIN "baserom.gb", $E7A6, $E7A9 - $E7A6

UnknownData_0xE7A9:
INCBIN "baserom.gb", $E7A9, $E7AA - $E7A9

LoggedData_0xE7AA:
INCBIN "baserom.gb", $E7AA, $E7AD - $E7AA

UnknownData_0xE7AD:
INCBIN "baserom.gb", $E7AD, $E7AE - $E7AD

LoggedData_0xE7AE:
INCBIN "baserom.gb", $E7AE, $E7B1 - $E7AE

UnknownData_0xE7B1:
INCBIN "baserom.gb", $E7B1, $E7B2 - $E7B1

LoggedData_0xE7B2:
INCBIN "baserom.gb", $E7B2, $E7B6 - $E7B2

UnknownData_0xE7B6:
INCBIN "baserom.gb", $E7B6, $E7B7 - $E7B6

LoggedData_0xE7B7:
INCBIN "baserom.gb", $E7B7, $E7BA - $E7B7

UnknownData_0xE7BA:
INCBIN "baserom.gb", $E7BA, $E7BB - $E7BA

LoggedData_0xE7BB:
INCBIN "baserom.gb", $E7BB, $E7BE - $E7BB

UnknownData_0xE7BE:
INCBIN "baserom.gb", $E7BE, $E7BF - $E7BE

LoggedData_0xE7BF:
INCBIN "baserom.gb", $E7BF, $E7C2 - $E7BF

UnknownData_0xE7C2:
INCBIN "baserom.gb", $E7C2, $E7C3 - $E7C2

LoggedData_0xE7C3:
INCBIN "baserom.gb", $E7C3, $E7C7 - $E7C3

UnknownData_0xE7C7:
INCBIN "baserom.gb", $E7C7, $E7C8 - $E7C7

LoggedData_0xE7C8:
INCBIN "baserom.gb", $E7C8, $E7CB - $E7C8

UnknownData_0xE7CB:
INCBIN "baserom.gb", $E7CB, $E7CC - $E7CB

LoggedData_0xE7CC:
INCBIN "baserom.gb", $E7CC, $E7CF - $E7CC

UnknownData_0xE7CF:
INCBIN "baserom.gb", $E7CF, $E7D0 - $E7CF

LoggedData_0xE7D0:
INCBIN "baserom.gb", $E7D0, $E7D3 - $E7D0

UnknownData_0xE7D3:
INCBIN "baserom.gb", $E7D3, $E7D4 - $E7D3

LoggedData_0xE7D4:
INCBIN "baserom.gb", $E7D4, $E7D7 - $E7D4

UnknownData_0xE7D7:
INCBIN "baserom.gb", $E7D7, $E7D8 - $E7D7

LoggedData_0xE7D8:
INCBIN "baserom.gb", $E7D8, $E7D9 - $E7D8

UnknownData_0xE7D9:
INCBIN "baserom.gb", $E7D9, $E835 - $E7D9

LoggedData_0xE835:
INCBIN "baserom.gb", $E835, $E838 - $E835

UnknownData_0xE838:
INCBIN "baserom.gb", $E838, $E839 - $E838

LoggedData_0xE839:
INCBIN "baserom.gb", $E839, $E83C - $E839

UnknownData_0xE83C:
INCBIN "baserom.gb", $E83C, $E83D - $E83C

LoggedData_0xE83D:
INCBIN "baserom.gb", $E83D, $E840 - $E83D

UnknownData_0xE840:
INCBIN "baserom.gb", $E840, $E841 - $E840

LoggedData_0xE841:
INCBIN "baserom.gb", $E841, $E844 - $E841

UnknownData_0xE844:
INCBIN "baserom.gb", $E844, $E845 - $E844

LoggedData_0xE845:
INCBIN "baserom.gb", $E845, $E848 - $E845

UnknownData_0xE848:
INCBIN "baserom.gb", $E848, $E849 - $E848

LoggedData_0xE849:
INCBIN "baserom.gb", $E849, $E84D - $E849

UnknownData_0xE84D:
INCBIN "baserom.gb", $E84D, $E84E - $E84D

LoggedData_0xE84E:
INCBIN "baserom.gb", $E84E, $E851 - $E84E

UnknownData_0xE851:
INCBIN "baserom.gb", $E851, $E852 - $E851

LoggedData_0xE852:
INCBIN "baserom.gb", $E852, $E855 - $E852

UnknownData_0xE855:
INCBIN "baserom.gb", $E855, $E856 - $E855

LoggedData_0xE856:
INCBIN "baserom.gb", $E856, $E859 - $E856

UnknownData_0xE859:
INCBIN "baserom.gb", $E859, $E85A - $E859

LoggedData_0xE85A:
INCBIN "baserom.gb", $E85A, $E85D - $E85A

UnknownData_0xE85D:
INCBIN "baserom.gb", $E85D, $E85E - $E85D

LoggedData_0xE85E:
INCBIN "baserom.gb", $E85E, $E861 - $E85E

UnknownData_0xE861:
INCBIN "baserom.gb", $E861, $E862 - $E861

LoggedData_0xE862:
INCBIN "baserom.gb", $E862, $E866 - $E862

UnknownData_0xE866:
INCBIN "baserom.gb", $E866, $E867 - $E866

LoggedData_0xE867:
INCBIN "baserom.gb", $E867, $E86A - $E867

UnknownData_0xE86A:
INCBIN "baserom.gb", $E86A, $E86B - $E86A

LoggedData_0xE86B:
INCBIN "baserom.gb", $E86B, $E86E - $E86B

UnknownData_0xE86E:
INCBIN "baserom.gb", $E86E, $E86F - $E86E

LoggedData_0xE86F:
INCBIN "baserom.gb", $E86F, $E872 - $E86F

UnknownData_0xE872:
INCBIN "baserom.gb", $E872, $E873 - $E872

LoggedData_0xE873:
INCBIN "baserom.gb", $E873, $E876 - $E873

UnknownData_0xE876:
INCBIN "baserom.gb", $E876, $E877 - $E876

LoggedData_0xE877:
INCBIN "baserom.gb", $E877, $E87A - $E877

UnknownData_0xE87A:
INCBIN "baserom.gb", $E87A, $E87B - $E87A

LoggedData_0xE87B:
INCBIN "baserom.gb", $E87B, $E87F - $E87B

UnknownData_0xE87F:
INCBIN "baserom.gb", $E87F, $E880 - $E87F

LoggedData_0xE880:
INCBIN "baserom.gb", $E880, $E883 - $E880

UnknownData_0xE883:
INCBIN "baserom.gb", $E883, $E884 - $E883

LoggedData_0xE884:
INCBIN "baserom.gb", $E884, $E887 - $E884

UnknownData_0xE887:
INCBIN "baserom.gb", $E887, $E888 - $E887

LoggedData_0xE888:
INCBIN "baserom.gb", $E888, $E88B - $E888

UnknownData_0xE88B:
INCBIN "baserom.gb", $E88B, $E88C - $E88B

LoggedData_0xE88C:
INCBIN "baserom.gb", $E88C, $E88F - $E88C

UnknownData_0xE88F:
INCBIN "baserom.gb", $E88F, $E890 - $E88F

LoggedData_0xE890:
INCBIN "baserom.gb", $E890, $E891 - $E890

UnknownData_0xE891:
INCBIN "baserom.gb", $E891, $E929 - $E891

LoggedData_0xE929:
INCBIN "baserom.gb", $E929, $E931 - $E929

UnknownData_0xE931:
INCBIN "baserom.gb", $E931, $E933 - $E931

LoggedData_0xE933:
INCBIN "baserom.gb", $E933, $E939 - $E933

UnknownData_0xE939:
INCBIN "baserom.gb", $E939, $E93B - $E939

LoggedData_0xE93B:
INCBIN "baserom.gb", $E93B, $E943 - $E93B

UnknownData_0xE943:
INCBIN "baserom.gb", $E943, $E945 - $E943

LoggedData_0xE945:
INCBIN "baserom.gb", $E945, $E94D - $E945

UnknownData_0xE94D:
INCBIN "baserom.gb", $E94D, $E977 - $E94D

LoggedData_0xE977:
INCBIN "baserom.gb", $E977, $E97A - $E977

UnknownData_0xE97A:
INCBIN "baserom.gb", $E97A, $E97B - $E97A

LoggedData_0xE97B:
INCBIN "baserom.gb", $E97B, $E97E - $E97B

UnknownData_0xE97E:
INCBIN "baserom.gb", $E97E, $E97F - $E97E

LoggedData_0xE97F:
INCBIN "baserom.gb", $E97F, $E982 - $E97F

UnknownData_0xE982:
INCBIN "baserom.gb", $E982, $E983 - $E982

LoggedData_0xE983:
INCBIN "baserom.gb", $E983, $E986 - $E983

UnknownData_0xE986:
INCBIN "baserom.gb", $E986, $E987 - $E986

LoggedData_0xE987:
INCBIN "baserom.gb", $E987, $E98B - $E987

UnknownData_0xE98B:
INCBIN "baserom.gb", $E98B, $E98C - $E98B

LoggedData_0xE98C:
INCBIN "baserom.gb", $E98C, $E98F - $E98C

UnknownData_0xE98F:
INCBIN "baserom.gb", $E98F, $E990 - $E98F

LoggedData_0xE990:
INCBIN "baserom.gb", $E990, $E993 - $E990

UnknownData_0xE993:
INCBIN "baserom.gb", $E993, $E994 - $E993

LoggedData_0xE994:
INCBIN "baserom.gb", $E994, $E997 - $E994

UnknownData_0xE997:
INCBIN "baserom.gb", $E997, $E998 - $E997

LoggedData_0xE998:
INCBIN "baserom.gb", $E998, $E99C - $E998

UnknownData_0xE99C:
INCBIN "baserom.gb", $E99C, $E99D - $E99C

LoggedData_0xE99D:
INCBIN "baserom.gb", $E99D, $E9A0 - $E99D

UnknownData_0xE9A0:
INCBIN "baserom.gb", $E9A0, $E9A1 - $E9A0

LoggedData_0xE9A1:
INCBIN "baserom.gb", $E9A1, $E9A4 - $E9A1

UnknownData_0xE9A4:
INCBIN "baserom.gb", $E9A4, $E9A5 - $E9A4

LoggedData_0xE9A5:
INCBIN "baserom.gb", $E9A5, $E9A8 - $E9A5

UnknownData_0xE9A8:
INCBIN "baserom.gb", $E9A8, $E9A9 - $E9A8

LoggedData_0xE9A9:
INCBIN "baserom.gb", $E9A9, $E9AD - $E9A9

UnknownData_0xE9AD:
INCBIN "baserom.gb", $E9AD, $E9AE - $E9AD

LoggedData_0xE9AE:
INCBIN "baserom.gb", $E9AE, $E9B1 - $E9AE

UnknownData_0xE9B1:
INCBIN "baserom.gb", $E9B1, $E9B2 - $E9B1

LoggedData_0xE9B2:
INCBIN "baserom.gb", $E9B2, $E9B5 - $E9B2

UnknownData_0xE9B5:
INCBIN "baserom.gb", $E9B5, $E9B6 - $E9B5

LoggedData_0xE9B6:
INCBIN "baserom.gb", $E9B6, $E9B9 - $E9B6

UnknownData_0xE9B9:
INCBIN "baserom.gb", $E9B9, $E9BA - $E9B9

LoggedData_0xE9BA:
INCBIN "baserom.gb", $E9BA, $E9BE - $E9BA

UnknownData_0xE9BE:
INCBIN "baserom.gb", $E9BE, $E9BF - $E9BE

LoggedData_0xE9BF:
INCBIN "baserom.gb", $E9BF, $E9C2 - $E9BF

UnknownData_0xE9C2:
INCBIN "baserom.gb", $E9C2, $E9C3 - $E9C2

LoggedData_0xE9C3:
INCBIN "baserom.gb", $E9C3, $E9C6 - $E9C3

UnknownData_0xE9C6:
INCBIN "baserom.gb", $E9C6, $E9C7 - $E9C6

LoggedData_0xE9C7:
INCBIN "baserom.gb", $E9C7, $E9CA - $E9C7

UnknownData_0xE9CA:
INCBIN "baserom.gb", $E9CA, $E9CB - $E9CA

LoggedData_0xE9CB:
INCBIN "baserom.gb", $E9CB, $E9CF - $E9CB

UnknownData_0xE9CF:
INCBIN "baserom.gb", $E9CF, $E9D0 - $E9CF

LoggedData_0xE9D0:
INCBIN "baserom.gb", $E9D0, $E9D3 - $E9D0

UnknownData_0xE9D3:
INCBIN "baserom.gb", $E9D3, $E9D4 - $E9D3

LoggedData_0xE9D4:
INCBIN "baserom.gb", $E9D4, $E9D7 - $E9D4

UnknownData_0xE9D7:
INCBIN "baserom.gb", $E9D7, $E9D8 - $E9D7

LoggedData_0xE9D8:
INCBIN "baserom.gb", $E9D8, $E9DB - $E9D8

UnknownData_0xE9DB:
INCBIN "baserom.gb", $E9DB, $E9DC - $E9DB

LoggedData_0xE9DC:
INCBIN "baserom.gb", $E9DC, $E9E0 - $E9DC

UnknownData_0xE9E0:
INCBIN "baserom.gb", $E9E0, $E9E1 - $E9E0

LoggedData_0xE9E1:
INCBIN "baserom.gb", $E9E1, $E9E4 - $E9E1

UnknownData_0xE9E4:
INCBIN "baserom.gb", $E9E4, $E9E5 - $E9E4

LoggedData_0xE9E5:
INCBIN "baserom.gb", $E9E5, $E9E8 - $E9E5

UnknownData_0xE9E8:
INCBIN "baserom.gb", $E9E8, $E9E9 - $E9E8

LoggedData_0xE9E9:
INCBIN "baserom.gb", $E9E9, $E9EC - $E9E9

UnknownData_0xE9EC:
INCBIN "baserom.gb", $E9EC, $E9ED - $E9EC

LoggedData_0xE9ED:
INCBIN "baserom.gb", $E9ED, $E9F1 - $E9ED

UnknownData_0xE9F1:
INCBIN "baserom.gb", $E9F1, $E9F2 - $E9F1

LoggedData_0xE9F2:
INCBIN "baserom.gb", $E9F2, $E9F5 - $E9F2

UnknownData_0xE9F5:
INCBIN "baserom.gb", $E9F5, $E9F6 - $E9F5

LoggedData_0xE9F6:
INCBIN "baserom.gb", $E9F6, $E9F9 - $E9F6

UnknownData_0xE9F9:
INCBIN "baserom.gb", $E9F9, $E9FA - $E9F9

LoggedData_0xE9FA:
INCBIN "baserom.gb", $E9FA, $E9FD - $E9FA

UnknownData_0xE9FD:
INCBIN "baserom.gb", $E9FD, $E9FE - $E9FD

LoggedData_0xE9FE:
INCBIN "baserom.gb", $E9FE, $EA02 - $E9FE

UnknownData_0xEA02:
INCBIN "baserom.gb", $EA02, $EA03 - $EA02

LoggedData_0xEA03:
INCBIN "baserom.gb", $EA03, $EA06 - $EA03

UnknownData_0xEA06:
INCBIN "baserom.gb", $EA06, $EA07 - $EA06

LoggedData_0xEA07:
INCBIN "baserom.gb", $EA07, $EA0A - $EA07

UnknownData_0xEA0A:
INCBIN "baserom.gb", $EA0A, $EA0B - $EA0A

LoggedData_0xEA0B:
INCBIN "baserom.gb", $EA0B, $EA0E - $EA0B

UnknownData_0xEA0E:
INCBIN "baserom.gb", $EA0E, $EA0F - $EA0E

LoggedData_0xEA0F:
INCBIN "baserom.gb", $EA0F, $EA13 - $EA0F

UnknownData_0xEA13:
INCBIN "baserom.gb", $EA13, $EA14 - $EA13

LoggedData_0xEA14:
INCBIN "baserom.gb", $EA14, $EA17 - $EA14

UnknownData_0xEA17:
INCBIN "baserom.gb", $EA17, $EA18 - $EA17

LoggedData_0xEA18:
INCBIN "baserom.gb", $EA18, $EA1B - $EA18

UnknownData_0xEA1B:
INCBIN "baserom.gb", $EA1B, $EA1C - $EA1B

LoggedData_0xEA1C:
INCBIN "baserom.gb", $EA1C, $EA1F - $EA1C

UnknownData_0xEA1F:
INCBIN "baserom.gb", $EA1F, $EA20 - $EA1F

LoggedData_0xEA20:
INCBIN "baserom.gb", $EA20, $EA24 - $EA20

UnknownData_0xEA24:
INCBIN "baserom.gb", $EA24, $EA25 - $EA24

LoggedData_0xEA25:
INCBIN "baserom.gb", $EA25, $EA28 - $EA25

UnknownData_0xEA28:
INCBIN "baserom.gb", $EA28, $EA29 - $EA28

LoggedData_0xEA29:
INCBIN "baserom.gb", $EA29, $EA2C - $EA29

UnknownData_0xEA2C:
INCBIN "baserom.gb", $EA2C, $EA2D - $EA2C

LoggedData_0xEA2D:
INCBIN "baserom.gb", $EA2D, $EA30 - $EA2D

UnknownData_0xEA30:
INCBIN "baserom.gb", $EA30, $EA31 - $EA30

LoggedData_0xEA31:
INCBIN "baserom.gb", $EA31, $EA34 - $EA31

UnknownData_0xEA34:
INCBIN "baserom.gb", $EA34, $EA35 - $EA34

LoggedData_0xEA35:
INCBIN "baserom.gb", $EA35, $EA39 - $EA35

UnknownData_0xEA39:
INCBIN "baserom.gb", $EA39, $EA3A - $EA39

LoggedData_0xEA3A:
INCBIN "baserom.gb", $EA3A, $EA3D - $EA3A

UnknownData_0xEA3D:
INCBIN "baserom.gb", $EA3D, $EA3E - $EA3D

LoggedData_0xEA3E:
INCBIN "baserom.gb", $EA3E, $EA41 - $EA3E

UnknownData_0xEA41:
INCBIN "baserom.gb", $EA41, $EA42 - $EA41

LoggedData_0xEA42:
INCBIN "baserom.gb", $EA42, $EA45 - $EA42

UnknownData_0xEA45:
INCBIN "baserom.gb", $EA45, $EA46 - $EA45

LoggedData_0xEA46:
INCBIN "baserom.gb", $EA46, $EA4A - $EA46

UnknownData_0xEA4A:
INCBIN "baserom.gb", $EA4A, $EA4B - $EA4A

LoggedData_0xEA4B:
INCBIN "baserom.gb", $EA4B, $EA4E - $EA4B

UnknownData_0xEA4E:
INCBIN "baserom.gb", $EA4E, $EA4F - $EA4E

LoggedData_0xEA4F:
INCBIN "baserom.gb", $EA4F, $EA52 - $EA4F

UnknownData_0xEA52:
INCBIN "baserom.gb", $EA52, $EA53 - $EA52

LoggedData_0xEA53:
INCBIN "baserom.gb", $EA53, $EA56 - $EA53

UnknownData_0xEA56:
INCBIN "baserom.gb", $EA56, $EA57 - $EA56

LoggedData_0xEA57:
INCBIN "baserom.gb", $EA57, $EA5B - $EA57

UnknownData_0xEA5B:
INCBIN "baserom.gb", $EA5B, $EA5C - $EA5B

LoggedData_0xEA5C:
INCBIN "baserom.gb", $EA5C, $EA5F - $EA5C

UnknownData_0xEA5F:
INCBIN "baserom.gb", $EA5F, $EA60 - $EA5F

LoggedData_0xEA60:
INCBIN "baserom.gb", $EA60, $EA63 - $EA60

UnknownData_0xEA63:
INCBIN "baserom.gb", $EA63, $EA64 - $EA63

LoggedData_0xEA64:
INCBIN "baserom.gb", $EA64, $EA67 - $EA64

UnknownData_0xEA67:
INCBIN "baserom.gb", $EA67, $EA68 - $EA67

LoggedData_0xEA68:
INCBIN "baserom.gb", $EA68, $EA6C - $EA68

UnknownData_0xEA6C:
INCBIN "baserom.gb", $EA6C, $EA6D - $EA6C

LoggedData_0xEA6D:
INCBIN "baserom.gb", $EA6D, $EA70 - $EA6D

UnknownData_0xEA70:
INCBIN "baserom.gb", $EA70, $EA71 - $EA70

LoggedData_0xEA71:
INCBIN "baserom.gb", $EA71, $EA74 - $EA71

UnknownData_0xEA74:
INCBIN "baserom.gb", $EA74, $EA75 - $EA74

LoggedData_0xEA75:
INCBIN "baserom.gb", $EA75, $EA78 - $EA75

UnknownData_0xEA78:
INCBIN "baserom.gb", $EA78, $EA79 - $EA78

LoggedData_0xEA79:
INCBIN "baserom.gb", $EA79, $EA7C - $EA79

UnknownData_0xEA7C:
INCBIN "baserom.gb", $EA7C, $EA7D - $EA7C

LoggedData_0xEA7D:
INCBIN "baserom.gb", $EA7D, $EA7E - $EA7D

UnknownData_0xEA7E:
INCBIN "baserom.gb", $EA7E, $EBCE - $EA7E

LoggedData_0xEBCE:
INCBIN "baserom.gb", $EBCE, $EBD6 - $EBCE

UnknownData_0xEBD6:
INCBIN "baserom.gb", $EBD6, $EBD8 - $EBD6

LoggedData_0xEBD8:
INCBIN "baserom.gb", $EBD8, $EBDE - $EBD8

UnknownData_0xEBDE:
INCBIN "baserom.gb", $EBDE, $EBE0 - $EBDE

LoggedData_0xEBE0:
INCBIN "baserom.gb", $EBE0, $EBE8 - $EBE0

UnknownData_0xEBE8:
INCBIN "baserom.gb", $EBE8, $EBEA - $EBE8

LoggedData_0xEBEA:
INCBIN "baserom.gb", $EBEA, $EBF2 - $EBEA

UnknownData_0xEBF2:
INCBIN "baserom.gb", $EBF2, $EC1C - $EBF2

LoggedData_0xEC1C:
INCBIN "baserom.gb", $EC1C, $EC1F - $EC1C

UnknownData_0xEC1F:
INCBIN "baserom.gb", $EC1F, $EC20 - $EC1F

LoggedData_0xEC20:
INCBIN "baserom.gb", $EC20, $EC23 - $EC20

UnknownData_0xEC23:
INCBIN "baserom.gb", $EC23, $EC24 - $EC23

LoggedData_0xEC24:
INCBIN "baserom.gb", $EC24, $EC27 - $EC24

UnknownData_0xEC27:
INCBIN "baserom.gb", $EC27, $EC28 - $EC27

LoggedData_0xEC28:
INCBIN "baserom.gb", $EC28, $EC2B - $EC28

UnknownData_0xEC2B:
INCBIN "baserom.gb", $EC2B, $EC2C - $EC2B

LoggedData_0xEC2C:
INCBIN "baserom.gb", $EC2C, $EC30 - $EC2C

UnknownData_0xEC30:
INCBIN "baserom.gb", $EC30, $EC31 - $EC30

LoggedData_0xEC31:
INCBIN "baserom.gb", $EC31, $EC34 - $EC31

UnknownData_0xEC34:
INCBIN "baserom.gb", $EC34, $EC35 - $EC34

LoggedData_0xEC35:
INCBIN "baserom.gb", $EC35, $EC38 - $EC35

UnknownData_0xEC38:
INCBIN "baserom.gb", $EC38, $EC39 - $EC38

LoggedData_0xEC39:
INCBIN "baserom.gb", $EC39, $EC3C - $EC39

UnknownData_0xEC3C:
INCBIN "baserom.gb", $EC3C, $EC3D - $EC3C

LoggedData_0xEC3D:
INCBIN "baserom.gb", $EC3D, $EC41 - $EC3D

UnknownData_0xEC41:
INCBIN "baserom.gb", $EC41, $EC42 - $EC41

LoggedData_0xEC42:
INCBIN "baserom.gb", $EC42, $EC45 - $EC42

UnknownData_0xEC45:
INCBIN "baserom.gb", $EC45, $EC46 - $EC45

LoggedData_0xEC46:
INCBIN "baserom.gb", $EC46, $EC49 - $EC46

UnknownData_0xEC49:
INCBIN "baserom.gb", $EC49, $EC4A - $EC49

LoggedData_0xEC4A:
INCBIN "baserom.gb", $EC4A, $EC4D - $EC4A

UnknownData_0xEC4D:
INCBIN "baserom.gb", $EC4D, $EC4E - $EC4D

LoggedData_0xEC4E:
INCBIN "baserom.gb", $EC4E, $EC52 - $EC4E

UnknownData_0xEC52:
INCBIN "baserom.gb", $EC52, $EC53 - $EC52

LoggedData_0xEC53:
INCBIN "baserom.gb", $EC53, $EC56 - $EC53

UnknownData_0xEC56:
INCBIN "baserom.gb", $EC56, $EC57 - $EC56

LoggedData_0xEC57:
INCBIN "baserom.gb", $EC57, $EC5A - $EC57

UnknownData_0xEC5A:
INCBIN "baserom.gb", $EC5A, $EC5B - $EC5A

LoggedData_0xEC5B:
INCBIN "baserom.gb", $EC5B, $EC5E - $EC5B

UnknownData_0xEC5E:
INCBIN "baserom.gb", $EC5E, $EC5F - $EC5E

LoggedData_0xEC5F:
INCBIN "baserom.gb", $EC5F, $EC63 - $EC5F

UnknownData_0xEC63:
INCBIN "baserom.gb", $EC63, $EC64 - $EC63

LoggedData_0xEC64:
INCBIN "baserom.gb", $EC64, $EC67 - $EC64

UnknownData_0xEC67:
INCBIN "baserom.gb", $EC67, $EC68 - $EC67

LoggedData_0xEC68:
INCBIN "baserom.gb", $EC68, $EC6B - $EC68

UnknownData_0xEC6B:
INCBIN "baserom.gb", $EC6B, $EC6C - $EC6B

LoggedData_0xEC6C:
INCBIN "baserom.gb", $EC6C, $EC6F - $EC6C

UnknownData_0xEC6F:
INCBIN "baserom.gb", $EC6F, $EC70 - $EC6F

LoggedData_0xEC70:
INCBIN "baserom.gb", $EC70, $EC74 - $EC70

UnknownData_0xEC74:
INCBIN "baserom.gb", $EC74, $EC75 - $EC74

LoggedData_0xEC75:
INCBIN "baserom.gb", $EC75, $EC78 - $EC75

UnknownData_0xEC78:
INCBIN "baserom.gb", $EC78, $EC79 - $EC78

LoggedData_0xEC79:
INCBIN "baserom.gb", $EC79, $EC7C - $EC79

UnknownData_0xEC7C:
INCBIN "baserom.gb", $EC7C, $EC7D - $EC7C

LoggedData_0xEC7D:
INCBIN "baserom.gb", $EC7D, $EC80 - $EC7D

UnknownData_0xEC80:
INCBIN "baserom.gb", $EC80, $EC81 - $EC80

LoggedData_0xEC81:
INCBIN "baserom.gb", $EC81, $EC85 - $EC81

UnknownData_0xEC85:
INCBIN "baserom.gb", $EC85, $EC86 - $EC85

LoggedData_0xEC86:
INCBIN "baserom.gb", $EC86, $EC89 - $EC86

UnknownData_0xEC89:
INCBIN "baserom.gb", $EC89, $EC8A - $EC89

LoggedData_0xEC8A:
INCBIN "baserom.gb", $EC8A, $EC8D - $EC8A

UnknownData_0xEC8D:
INCBIN "baserom.gb", $EC8D, $EC8E - $EC8D

LoggedData_0xEC8E:
INCBIN "baserom.gb", $EC8E, $EC91 - $EC8E

UnknownData_0xEC91:
INCBIN "baserom.gb", $EC91, $EC92 - $EC91

LoggedData_0xEC92:
INCBIN "baserom.gb", $EC92, $EC96 - $EC92

UnknownData_0xEC96:
INCBIN "baserom.gb", $EC96, $EC97 - $EC96

LoggedData_0xEC97:
INCBIN "baserom.gb", $EC97, $EC9A - $EC97

UnknownData_0xEC9A:
INCBIN "baserom.gb", $EC9A, $EC9B - $EC9A

LoggedData_0xEC9B:
INCBIN "baserom.gb", $EC9B, $EC9E - $EC9B

UnknownData_0xEC9E:
INCBIN "baserom.gb", $EC9E, $EC9F - $EC9E

LoggedData_0xEC9F:
INCBIN "baserom.gb", $EC9F, $ECA2 - $EC9F

UnknownData_0xECA2:
INCBIN "baserom.gb", $ECA2, $ECA3 - $ECA2

LoggedData_0xECA3:
INCBIN "baserom.gb", $ECA3, $ECA7 - $ECA3

UnknownData_0xECA7:
INCBIN "baserom.gb", $ECA7, $ECA8 - $ECA7

LoggedData_0xECA8:
INCBIN "baserom.gb", $ECA8, $ECAB - $ECA8

UnknownData_0xECAB:
INCBIN "baserom.gb", $ECAB, $ECAC - $ECAB

LoggedData_0xECAC:
INCBIN "baserom.gb", $ECAC, $ECAF - $ECAC

UnknownData_0xECAF:
INCBIN "baserom.gb", $ECAF, $ECB0 - $ECAF

LoggedData_0xECB0:
INCBIN "baserom.gb", $ECB0, $ECB3 - $ECB0

UnknownData_0xECB3:
INCBIN "baserom.gb", $ECB3, $ECB4 - $ECB3

LoggedData_0xECB4:
INCBIN "baserom.gb", $ECB4, $ECB8 - $ECB4

UnknownData_0xECB8:
INCBIN "baserom.gb", $ECB8, $ECB9 - $ECB8

LoggedData_0xECB9:
INCBIN "baserom.gb", $ECB9, $ECBC - $ECB9

UnknownData_0xECBC:
INCBIN "baserom.gb", $ECBC, $ECBD - $ECBC

LoggedData_0xECBD:
INCBIN "baserom.gb", $ECBD, $ECC0 - $ECBD

UnknownData_0xECC0:
INCBIN "baserom.gb", $ECC0, $ECC1 - $ECC0

LoggedData_0xECC1:
INCBIN "baserom.gb", $ECC1, $ECC4 - $ECC1

UnknownData_0xECC4:
INCBIN "baserom.gb", $ECC4, $ECC5 - $ECC4

LoggedData_0xECC5:
INCBIN "baserom.gb", $ECC5, $ECC9 - $ECC5

UnknownData_0xECC9:
INCBIN "baserom.gb", $ECC9, $ECCA - $ECC9

LoggedData_0xECCA:
INCBIN "baserom.gb", $ECCA, $ECCD - $ECCA

UnknownData_0xECCD:
INCBIN "baserom.gb", $ECCD, $ECCE - $ECCD

LoggedData_0xECCE:
INCBIN "baserom.gb", $ECCE, $ECD1 - $ECCE

UnknownData_0xECD1:
INCBIN "baserom.gb", $ECD1, $ECD2 - $ECD1

LoggedData_0xECD2:
INCBIN "baserom.gb", $ECD2, $ECD5 - $ECD2

UnknownData_0xECD5:
INCBIN "baserom.gb", $ECD5, $ECD6 - $ECD5

LoggedData_0xECD6:
INCBIN "baserom.gb", $ECD6, $ECD9 - $ECD6

UnknownData_0xECD9:
INCBIN "baserom.gb", $ECD9, $ECDA - $ECD9

LoggedData_0xECDA:
INCBIN "baserom.gb", $ECDA, $ECDE - $ECDA

UnknownData_0xECDE:
INCBIN "baserom.gb", $ECDE, $ECDF - $ECDE

LoggedData_0xECDF:
INCBIN "baserom.gb", $ECDF, $ECE2 - $ECDF

UnknownData_0xECE2:
INCBIN "baserom.gb", $ECE2, $ECE3 - $ECE2

LoggedData_0xECE3:
INCBIN "baserom.gb", $ECE3, $ECE6 - $ECE3

UnknownData_0xECE6:
INCBIN "baserom.gb", $ECE6, $ECE7 - $ECE6

LoggedData_0xECE7:
INCBIN "baserom.gb", $ECE7, $ECEA - $ECE7

UnknownData_0xECEA:
INCBIN "baserom.gb", $ECEA, $ECEB - $ECEA

LoggedData_0xECEB:
INCBIN "baserom.gb", $ECEB, $ECEF - $ECEB

UnknownData_0xECEF:
INCBIN "baserom.gb", $ECEF, $ECF0 - $ECEF

LoggedData_0xECF0:
INCBIN "baserom.gb", $ECF0, $ECF3 - $ECF0

UnknownData_0xECF3:
INCBIN "baserom.gb", $ECF3, $ECF4 - $ECF3

LoggedData_0xECF4:
INCBIN "baserom.gb", $ECF4, $ECF7 - $ECF4

UnknownData_0xECF7:
INCBIN "baserom.gb", $ECF7, $ECF8 - $ECF7

LoggedData_0xECF8:
INCBIN "baserom.gb", $ECF8, $ECFB - $ECF8

UnknownData_0xECFB:
INCBIN "baserom.gb", $ECFB, $ECFC - $ECFB

LoggedData_0xECFC:
INCBIN "baserom.gb", $ECFC, $ED00 - $ECFC

UnknownData_0xED00:
INCBIN "baserom.gb", $ED00, $ED01 - $ED00

LoggedData_0xED01:
INCBIN "baserom.gb", $ED01, $ED04 - $ED01

UnknownData_0xED04:
INCBIN "baserom.gb", $ED04, $ED05 - $ED04

LoggedData_0xED05:
INCBIN "baserom.gb", $ED05, $ED08 - $ED05

UnknownData_0xED08:
INCBIN "baserom.gb", $ED08, $ED09 - $ED08

LoggedData_0xED09:
INCBIN "baserom.gb", $ED09, $ED0C - $ED09

UnknownData_0xED0C:
INCBIN "baserom.gb", $ED0C, $ED0D - $ED0C

LoggedData_0xED0D:
INCBIN "baserom.gb", $ED0D, $ED11 - $ED0D

UnknownData_0xED11:
INCBIN "baserom.gb", $ED11, $ED12 - $ED11

LoggedData_0xED12:
INCBIN "baserom.gb", $ED12, $ED15 - $ED12

UnknownData_0xED15:
INCBIN "baserom.gb", $ED15, $ED16 - $ED15

LoggedData_0xED16:
INCBIN "baserom.gb", $ED16, $ED19 - $ED16

UnknownData_0xED19:
INCBIN "baserom.gb", $ED19, $ED1A - $ED19

LoggedData_0xED1A:
INCBIN "baserom.gb", $ED1A, $ED1D - $ED1A

UnknownData_0xED1D:
INCBIN "baserom.gb", $ED1D, $ED1E - $ED1D

LoggedData_0xED1E:
INCBIN "baserom.gb", $ED1E, $ED21 - $ED1E

UnknownData_0xED21:
INCBIN "baserom.gb", $ED21, $ED22 - $ED21

LoggedData_0xED22:
INCBIN "baserom.gb", $ED22, $ED23 - $ED22

UnknownData_0xED23:
INCBIN "baserom.gb", $ED23, $EE73 - $ED23

LoggedData_0xEE73:
INCBIN "baserom.gb", $EE73, $EE7B - $EE73

UnknownData_0xEE7B:
INCBIN "baserom.gb", $EE7B, $EE7D - $EE7B

LoggedData_0xEE7D:
INCBIN "baserom.gb", $EE7D, $EE83 - $EE7D

UnknownData_0xEE83:
INCBIN "baserom.gb", $EE83, $EE85 - $EE83

LoggedData_0xEE85:
INCBIN "baserom.gb", $EE85, $EE8D - $EE85

UnknownData_0xEE8D:
INCBIN "baserom.gb", $EE8D, $EE8F - $EE8D

LoggedData_0xEE8F:
INCBIN "baserom.gb", $EE8F, $EE97 - $EE8F

UnknownData_0xEE97:
INCBIN "baserom.gb", $EE97, $EEC1 - $EE97

LoggedData_0xEEC1:
INCBIN "baserom.gb", $EEC1, $EEC4 - $EEC1

UnknownData_0xEEC4:
INCBIN "baserom.gb", $EEC4, $EEC5 - $EEC4

LoggedData_0xEEC5:
INCBIN "baserom.gb", $EEC5, $EEC8 - $EEC5

UnknownData_0xEEC8:
INCBIN "baserom.gb", $EEC8, $EEC9 - $EEC8

LoggedData_0xEEC9:
INCBIN "baserom.gb", $EEC9, $EECC - $EEC9

UnknownData_0xEECC:
INCBIN "baserom.gb", $EECC, $EECD - $EECC

LoggedData_0xEECD:
INCBIN "baserom.gb", $EECD, $EED0 - $EECD

UnknownData_0xEED0:
INCBIN "baserom.gb", $EED0, $EED1 - $EED0

LoggedData_0xEED1:
INCBIN "baserom.gb", $EED1, $EED5 - $EED1

UnknownData_0xEED5:
INCBIN "baserom.gb", $EED5, $EED6 - $EED5

LoggedData_0xEED6:
INCBIN "baserom.gb", $EED6, $EED9 - $EED6

UnknownData_0xEED9:
INCBIN "baserom.gb", $EED9, $EEDA - $EED9

LoggedData_0xEEDA:
INCBIN "baserom.gb", $EEDA, $EEDD - $EEDA

UnknownData_0xEEDD:
INCBIN "baserom.gb", $EEDD, $EEDE - $EEDD

LoggedData_0xEEDE:
INCBIN "baserom.gb", $EEDE, $EEE1 - $EEDE

UnknownData_0xEEE1:
INCBIN "baserom.gb", $EEE1, $EEE2 - $EEE1

LoggedData_0xEEE2:
INCBIN "baserom.gb", $EEE2, $EEE6 - $EEE2

UnknownData_0xEEE6:
INCBIN "baserom.gb", $EEE6, $EEE7 - $EEE6

LoggedData_0xEEE7:
INCBIN "baserom.gb", $EEE7, $EEEA - $EEE7

UnknownData_0xEEEA:
INCBIN "baserom.gb", $EEEA, $EEEB - $EEEA

LoggedData_0xEEEB:
INCBIN "baserom.gb", $EEEB, $EEEE - $EEEB

UnknownData_0xEEEE:
INCBIN "baserom.gb", $EEEE, $EEEF - $EEEE

LoggedData_0xEEEF:
INCBIN "baserom.gb", $EEEF, $EEF2 - $EEEF

UnknownData_0xEEF2:
INCBIN "baserom.gb", $EEF2, $EEF3 - $EEF2

LoggedData_0xEEF3:
INCBIN "baserom.gb", $EEF3, $EEF7 - $EEF3

UnknownData_0xEEF7:
INCBIN "baserom.gb", $EEF7, $EEF8 - $EEF7

LoggedData_0xEEF8:
INCBIN "baserom.gb", $EEF8, $EEFB - $EEF8

UnknownData_0xEEFB:
INCBIN "baserom.gb", $EEFB, $EEFC - $EEFB

LoggedData_0xEEFC:
INCBIN "baserom.gb", $EEFC, $EEFF - $EEFC

UnknownData_0xEEFF:
INCBIN "baserom.gb", $EEFF, $EF00 - $EEFF

LoggedData_0xEF00:
INCBIN "baserom.gb", $EF00, $EF03 - $EF00

UnknownData_0xEF03:
INCBIN "baserom.gb", $EF03, $EF04 - $EF03

LoggedData_0xEF04:
INCBIN "baserom.gb", $EF04, $EF08 - $EF04

UnknownData_0xEF08:
INCBIN "baserom.gb", $EF08, $EF09 - $EF08

LoggedData_0xEF09:
INCBIN "baserom.gb", $EF09, $EF0C - $EF09

UnknownData_0xEF0C:
INCBIN "baserom.gb", $EF0C, $EF0D - $EF0C

LoggedData_0xEF0D:
INCBIN "baserom.gb", $EF0D, $EF10 - $EF0D

UnknownData_0xEF10:
INCBIN "baserom.gb", $EF10, $EF11 - $EF10

LoggedData_0xEF11:
INCBIN "baserom.gb", $EF11, $EF14 - $EF11

UnknownData_0xEF14:
INCBIN "baserom.gb", $EF14, $EF15 - $EF14

LoggedData_0xEF15:
INCBIN "baserom.gb", $EF15, $EF19 - $EF15

UnknownData_0xEF19:
INCBIN "baserom.gb", $EF19, $EF1A - $EF19

LoggedData_0xEF1A:
INCBIN "baserom.gb", $EF1A, $EF1D - $EF1A

UnknownData_0xEF1D:
INCBIN "baserom.gb", $EF1D, $EF1E - $EF1D

LoggedData_0xEF1E:
INCBIN "baserom.gb", $EF1E, $EF21 - $EF1E

UnknownData_0xEF21:
INCBIN "baserom.gb", $EF21, $EF22 - $EF21

LoggedData_0xEF22:
INCBIN "baserom.gb", $EF22, $EF25 - $EF22

UnknownData_0xEF25:
INCBIN "baserom.gb", $EF25, $EF26 - $EF25

LoggedData_0xEF26:
INCBIN "baserom.gb", $EF26, $EF2A - $EF26

UnknownData_0xEF2A:
INCBIN "baserom.gb", $EF2A, $EF2B - $EF2A

LoggedData_0xEF2B:
INCBIN "baserom.gb", $EF2B, $EF2E - $EF2B

UnknownData_0xEF2E:
INCBIN "baserom.gb", $EF2E, $EF2F - $EF2E

LoggedData_0xEF2F:
INCBIN "baserom.gb", $EF2F, $EF32 - $EF2F

UnknownData_0xEF32:
INCBIN "baserom.gb", $EF32, $EF33 - $EF32

LoggedData_0xEF33:
INCBIN "baserom.gb", $EF33, $EF36 - $EF33

UnknownData_0xEF36:
INCBIN "baserom.gb", $EF36, $EF37 - $EF36

LoggedData_0xEF37:
INCBIN "baserom.gb", $EF37, $EF3B - $EF37

UnknownData_0xEF3B:
INCBIN "baserom.gb", $EF3B, $EF3C - $EF3B

LoggedData_0xEF3C:
INCBIN "baserom.gb", $EF3C, $EF3F - $EF3C

UnknownData_0xEF3F:
INCBIN "baserom.gb", $EF3F, $EF40 - $EF3F

LoggedData_0xEF40:
INCBIN "baserom.gb", $EF40, $EF43 - $EF40

UnknownData_0xEF43:
INCBIN "baserom.gb", $EF43, $EF44 - $EF43

LoggedData_0xEF44:
INCBIN "baserom.gb", $EF44, $EF47 - $EF44

UnknownData_0xEF47:
INCBIN "baserom.gb", $EF47, $EF48 - $EF47

LoggedData_0xEF48:
INCBIN "baserom.gb", $EF48, $EF4C - $EF48

UnknownData_0xEF4C:
INCBIN "baserom.gb", $EF4C, $EF4D - $EF4C

LoggedData_0xEF4D:
INCBIN "baserom.gb", $EF4D, $EF50 - $EF4D

UnknownData_0xEF50:
INCBIN "baserom.gb", $EF50, $EF51 - $EF50

LoggedData_0xEF51:
INCBIN "baserom.gb", $EF51, $EF54 - $EF51

UnknownData_0xEF54:
INCBIN "baserom.gb", $EF54, $EF55 - $EF54

LoggedData_0xEF55:
INCBIN "baserom.gb", $EF55, $EF58 - $EF55

UnknownData_0xEF58:
INCBIN "baserom.gb", $EF58, $EF59 - $EF58

LoggedData_0xEF59:
INCBIN "baserom.gb", $EF59, $EF5D - $EF59

UnknownData_0xEF5D:
INCBIN "baserom.gb", $EF5D, $EF5E - $EF5D

LoggedData_0xEF5E:
INCBIN "baserom.gb", $EF5E, $EF61 - $EF5E

UnknownData_0xEF61:
INCBIN "baserom.gb", $EF61, $EF62 - $EF61

LoggedData_0xEF62:
INCBIN "baserom.gb", $EF62, $EF65 - $EF62

UnknownData_0xEF65:
INCBIN "baserom.gb", $EF65, $EF66 - $EF65

LoggedData_0xEF66:
INCBIN "baserom.gb", $EF66, $EF69 - $EF66

UnknownData_0xEF69:
INCBIN "baserom.gb", $EF69, $EF6A - $EF69

LoggedData_0xEF6A:
INCBIN "baserom.gb", $EF6A, $EF6E - $EF6A

UnknownData_0xEF6E:
INCBIN "baserom.gb", $EF6E, $EF6F - $EF6E

LoggedData_0xEF6F:
INCBIN "baserom.gb", $EF6F, $EF72 - $EF6F

UnknownData_0xEF72:
INCBIN "baserom.gb", $EF72, $EF73 - $EF72

LoggedData_0xEF73:
INCBIN "baserom.gb", $EF73, $EF76 - $EF73

UnknownData_0xEF76:
INCBIN "baserom.gb", $EF76, $EF77 - $EF76

LoggedData_0xEF77:
INCBIN "baserom.gb", $EF77, $EF7A - $EF77

UnknownData_0xEF7A:
INCBIN "baserom.gb", $EF7A, $EF7B - $EF7A

LoggedData_0xEF7B:
INCBIN "baserom.gb", $EF7B, $EF7E - $EF7B

UnknownData_0xEF7E:
INCBIN "baserom.gb", $EF7E, $EF7F - $EF7E

LoggedData_0xEF7F:
INCBIN "baserom.gb", $EF7F, $EF83 - $EF7F

UnknownData_0xEF83:
INCBIN "baserom.gb", $EF83, $EF84 - $EF83

LoggedData_0xEF84:
INCBIN "baserom.gb", $EF84, $EF87 - $EF84

UnknownData_0xEF87:
INCBIN "baserom.gb", $EF87, $EF88 - $EF87

LoggedData_0xEF88:
INCBIN "baserom.gb", $EF88, $EF8B - $EF88

UnknownData_0xEF8B:
INCBIN "baserom.gb", $EF8B, $EF8C - $EF8B

LoggedData_0xEF8C:
INCBIN "baserom.gb", $EF8C, $EF8F - $EF8C

UnknownData_0xEF8F:
INCBIN "baserom.gb", $EF8F, $EF90 - $EF8F

LoggedData_0xEF90:
INCBIN "baserom.gb", $EF90, $EF94 - $EF90

UnknownData_0xEF94:
INCBIN "baserom.gb", $EF94, $EF95 - $EF94

LoggedData_0xEF95:
INCBIN "baserom.gb", $EF95, $EF98 - $EF95

UnknownData_0xEF98:
INCBIN "baserom.gb", $EF98, $EF99 - $EF98

LoggedData_0xEF99:
INCBIN "baserom.gb", $EF99, $EF9C - $EF99

UnknownData_0xEF9C:
INCBIN "baserom.gb", $EF9C, $EF9D - $EF9C

LoggedData_0xEF9D:
INCBIN "baserom.gb", $EF9D, $EFA0 - $EF9D

UnknownData_0xEFA0:
INCBIN "baserom.gb", $EFA0, $EFA1 - $EFA0

LoggedData_0xEFA1:
INCBIN "baserom.gb", $EFA1, $EFA5 - $EFA1

UnknownData_0xEFA5:
INCBIN "baserom.gb", $EFA5, $EFA6 - $EFA5

LoggedData_0xEFA6:
INCBIN "baserom.gb", $EFA6, $EFA9 - $EFA6

UnknownData_0xEFA9:
INCBIN "baserom.gb", $EFA9, $EFAA - $EFA9

LoggedData_0xEFAA:
INCBIN "baserom.gb", $EFAA, $EFAD - $EFAA

UnknownData_0xEFAD:
INCBIN "baserom.gb", $EFAD, $EFAE - $EFAD

LoggedData_0xEFAE:
INCBIN "baserom.gb", $EFAE, $EFB1 - $EFAE

UnknownData_0xEFB1:
INCBIN "baserom.gb", $EFB1, $EFB2 - $EFB1

LoggedData_0xEFB2:
INCBIN "baserom.gb", $EFB2, $EFB6 - $EFB2

UnknownData_0xEFB6:
INCBIN "baserom.gb", $EFB6, $EFB7 - $EFB6

LoggedData_0xEFB7:
INCBIN "baserom.gb", $EFB7, $EFBA - $EFB7

UnknownData_0xEFBA:
INCBIN "baserom.gb", $EFBA, $EFBB - $EFBA

LoggedData_0xEFBB:
INCBIN "baserom.gb", $EFBB, $EFBE - $EFBB

UnknownData_0xEFBE:
INCBIN "baserom.gb", $EFBE, $EFBF - $EFBE

LoggedData_0xEFBF:
INCBIN "baserom.gb", $EFBF, $EFC2 - $EFBF

UnknownData_0xEFC2:
INCBIN "baserom.gb", $EFC2, $EFC3 - $EFC2

LoggedData_0xEFC3:
INCBIN "baserom.gb", $EFC3, $EFC6 - $EFC3

UnknownData_0xEFC6:
INCBIN "baserom.gb", $EFC6, $EFC7 - $EFC6

LoggedData_0xEFC7:
INCBIN "baserom.gb", $EFC7, $EFC8 - $EFC7

UnknownData_0xEFC8:
INCBIN "baserom.gb", $EFC8, $F118 - $EFC8

LoggedData_0xF118:
INCBIN "baserom.gb", $F118, $F120 - $F118

UnknownData_0xF120:
INCBIN "baserom.gb", $F120, $F122 - $F120

LoggedData_0xF122:
INCBIN "baserom.gb", $F122, $F125 - $F122

UnknownData_0xF125:
INCBIN "baserom.gb", $F125, $F126 - $F125

LoggedData_0xF126:
INCBIN "baserom.gb", $F126, $F129 - $F126

UnknownData_0xF129:
INCBIN "baserom.gb", $F129, $F12A - $F129

LoggedData_0xF12A:
INCBIN "baserom.gb", $F12A, $F12D - $F12A

UnknownData_0xF12D:
INCBIN "baserom.gb", $F12D, $F12E - $F12D

LoggedData_0xF12E:
INCBIN "baserom.gb", $F12E, $F131 - $F12E

UnknownData_0xF131:
INCBIN "baserom.gb", $F131, $F132 - $F131

LoggedData_0xF132:
INCBIN "baserom.gb", $F132, $F136 - $F132

UnknownData_0xF136:
INCBIN "baserom.gb", $F136, $F137 - $F136

LoggedData_0xF137:
INCBIN "baserom.gb", $F137, $F13A - $F137

UnknownData_0xF13A:
INCBIN "baserom.gb", $F13A, $F13B - $F13A

LoggedData_0xF13B:
INCBIN "baserom.gb", $F13B, $F13E - $F13B

UnknownData_0xF13E:
INCBIN "baserom.gb", $F13E, $F13F - $F13E

LoggedData_0xF13F:
INCBIN "baserom.gb", $F13F, $F142 - $F13F

UnknownData_0xF142:
INCBIN "baserom.gb", $F142, $F143 - $F142

LoggedData_0xF143:
INCBIN "baserom.gb", $F143, $F147 - $F143

UnknownData_0xF147:
INCBIN "baserom.gb", $F147, $F148 - $F147

LoggedData_0xF148:
INCBIN "baserom.gb", $F148, $F14B - $F148

UnknownData_0xF14B:
INCBIN "baserom.gb", $F14B, $F14C - $F14B

LoggedData_0xF14C:
INCBIN "baserom.gb", $F14C, $F14F - $F14C

UnknownData_0xF14F:
INCBIN "baserom.gb", $F14F, $F150 - $F14F

LoggedData_0xF150:
INCBIN "baserom.gb", $F150, $F153 - $F150

UnknownData_0xF153:
INCBIN "baserom.gb", $F153, $F154 - $F153

LoggedData_0xF154:
INCBIN "baserom.gb", $F154, $F158 - $F154

UnknownData_0xF158:
INCBIN "baserom.gb", $F158, $F159 - $F158

LoggedData_0xF159:
INCBIN "baserom.gb", $F159, $F15C - $F159

UnknownData_0xF15C:
INCBIN "baserom.gb", $F15C, $F15D - $F15C

LoggedData_0xF15D:
INCBIN "baserom.gb", $F15D, $F160 - $F15D

UnknownData_0xF160:
INCBIN "baserom.gb", $F160, $F161 - $F160

LoggedData_0xF161:
INCBIN "baserom.gb", $F161, $F164 - $F161

UnknownData_0xF164:
INCBIN "baserom.gb", $F164, $F165 - $F164

LoggedData_0xF165:
INCBIN "baserom.gb", $F165, $F186 - $F165

UnknownData_0xF186:
INCBIN "baserom.gb", $F186, $F188 - $F186

LoggedData_0xF188:
INCBIN "baserom.gb", $F188, $F18B - $F188

UnknownData_0xF18B:
INCBIN "baserom.gb", $F18B, $F18C - $F18B

LoggedData_0xF18C:
INCBIN "baserom.gb", $F18C, $F18F - $F18C

UnknownData_0xF18F:
INCBIN "baserom.gb", $F18F, $F190 - $F18F

LoggedData_0xF190:
INCBIN "baserom.gb", $F190, $F193 - $F190

UnknownData_0xF193:
INCBIN "baserom.gb", $F193, $F194 - $F193

LoggedData_0xF194:
INCBIN "baserom.gb", $F194, $F197 - $F194

UnknownData_0xF197:
INCBIN "baserom.gb", $F197, $F198 - $F197

LoggedData_0xF198:
INCBIN "baserom.gb", $F198, $F19C - $F198

UnknownData_0xF19C:
INCBIN "baserom.gb", $F19C, $F19D - $F19C

LoggedData_0xF19D:
INCBIN "baserom.gb", $F19D, $F1A0 - $F19D

UnknownData_0xF1A0:
INCBIN "baserom.gb", $F1A0, $F1A1 - $F1A0

LoggedData_0xF1A1:
INCBIN "baserom.gb", $F1A1, $F1A4 - $F1A1

UnknownData_0xF1A4:
INCBIN "baserom.gb", $F1A4, $F1A5 - $F1A4

LoggedData_0xF1A5:
INCBIN "baserom.gb", $F1A5, $F1A8 - $F1A5

UnknownData_0xF1A8:
INCBIN "baserom.gb", $F1A8, $F1A9 - $F1A8

LoggedData_0xF1A9:
INCBIN "baserom.gb", $F1A9, $F1AD - $F1A9

UnknownData_0xF1AD:
INCBIN "baserom.gb", $F1AD, $F1AE - $F1AD

LoggedData_0xF1AE:
INCBIN "baserom.gb", $F1AE, $F1B1 - $F1AE

UnknownData_0xF1B1:
INCBIN "baserom.gb", $F1B1, $F1B2 - $F1B1

LoggedData_0xF1B2:
INCBIN "baserom.gb", $F1B2, $F1B5 - $F1B2

UnknownData_0xF1B5:
INCBIN "baserom.gb", $F1B5, $F1B6 - $F1B5

LoggedData_0xF1B6:
INCBIN "baserom.gb", $F1B6, $F1B9 - $F1B6

UnknownData_0xF1B9:
INCBIN "baserom.gb", $F1B9, $F1BA - $F1B9

LoggedData_0xF1BA:
INCBIN "baserom.gb", $F1BA, $F1BE - $F1BA

UnknownData_0xF1BE:
INCBIN "baserom.gb", $F1BE, $F1BF - $F1BE

LoggedData_0xF1BF:
INCBIN "baserom.gb", $F1BF, $F1C2 - $F1BF

UnknownData_0xF1C2:
INCBIN "baserom.gb", $F1C2, $F1C3 - $F1C2

LoggedData_0xF1C3:
INCBIN "baserom.gb", $F1C3, $F1C6 - $F1C3

UnknownData_0xF1C6:
INCBIN "baserom.gb", $F1C6, $F1C7 - $F1C6

LoggedData_0xF1C7:
INCBIN "baserom.gb", $F1C7, $F1CA - $F1C7

UnknownData_0xF1CA:
INCBIN "baserom.gb", $F1CA, $F1CB - $F1CA

LoggedData_0xF1CB:
INCBIN "baserom.gb", $F1CB, $F1CF - $F1CB

UnknownData_0xF1CF:
INCBIN "baserom.gb", $F1CF, $F1D0 - $F1CF

LoggedData_0xF1D0:
INCBIN "baserom.gb", $F1D0, $F1D3 - $F1D0

UnknownData_0xF1D3:
INCBIN "baserom.gb", $F1D3, $F1D4 - $F1D3

LoggedData_0xF1D4:
INCBIN "baserom.gb", $F1D4, $F1D7 - $F1D4

UnknownData_0xF1D7:
INCBIN "baserom.gb", $F1D7, $F1D8 - $F1D7

LoggedData_0xF1D8:
INCBIN "baserom.gb", $F1D8, $F1DB - $F1D8

UnknownData_0xF1DB:
INCBIN "baserom.gb", $F1DB, $F1DC - $F1DB

LoggedData_0xF1DC:
INCBIN "baserom.gb", $F1DC, $F1E0 - $F1DC

UnknownData_0xF1E0:
INCBIN "baserom.gb", $F1E0, $F1E1 - $F1E0

LoggedData_0xF1E1:
INCBIN "baserom.gb", $F1E1, $F1E4 - $F1E1

UnknownData_0xF1E4:
INCBIN "baserom.gb", $F1E4, $F1E5 - $F1E4

LoggedData_0xF1E5:
INCBIN "baserom.gb", $F1E5, $F1E8 - $F1E5

UnknownData_0xF1E8:
INCBIN "baserom.gb", $F1E8, $F1E9 - $F1E8

LoggedData_0xF1E9:
INCBIN "baserom.gb", $F1E9, $F1EC - $F1E9

UnknownData_0xF1EC:
INCBIN "baserom.gb", $F1EC, $F1ED - $F1EC

LoggedData_0xF1ED:
INCBIN "baserom.gb", $F1ED, $F1F1 - $F1ED

UnknownData_0xF1F1:
INCBIN "baserom.gb", $F1F1, $F1F2 - $F1F1

LoggedData_0xF1F2:
INCBIN "baserom.gb", $F1F2, $F1F5 - $F1F2

UnknownData_0xF1F5:
INCBIN "baserom.gb", $F1F5, $F1F6 - $F1F5

LoggedData_0xF1F6:
INCBIN "baserom.gb", $F1F6, $F1F9 - $F1F6

UnknownData_0xF1F9:
INCBIN "baserom.gb", $F1F9, $F1FA - $F1F9

LoggedData_0xF1FA:
INCBIN "baserom.gb", $F1FA, $F1FD - $F1FA

UnknownData_0xF1FD:
INCBIN "baserom.gb", $F1FD, $F1FE - $F1FD

LoggedData_0xF1FE:
INCBIN "baserom.gb", $F1FE, $F202 - $F1FE

UnknownData_0xF202:
INCBIN "baserom.gb", $F202, $F203 - $F202

LoggedData_0xF203:
INCBIN "baserom.gb", $F203, $F206 - $F203

UnknownData_0xF206:
INCBIN "baserom.gb", $F206, $F207 - $F206

LoggedData_0xF207:
INCBIN "baserom.gb", $F207, $F20A - $F207

UnknownData_0xF20A:
INCBIN "baserom.gb", $F20A, $F20B - $F20A

LoggedData_0xF20B:
INCBIN "baserom.gb", $F20B, $F20E - $F20B

UnknownData_0xF20E:
INCBIN "baserom.gb", $F20E, $F20F - $F20E

LoggedData_0xF20F:
INCBIN "baserom.gb", $F20F, $F213 - $F20F

UnknownData_0xF213:
INCBIN "baserom.gb", $F213, $F214 - $F213

LoggedData_0xF214:
INCBIN "baserom.gb", $F214, $F217 - $F214

UnknownData_0xF217:
INCBIN "baserom.gb", $F217, $F218 - $F217

LoggedData_0xF218:
INCBIN "baserom.gb", $F218, $F21B - $F218

UnknownData_0xF21B:
INCBIN "baserom.gb", $F21B, $F21C - $F21B

LoggedData_0xF21C:
INCBIN "baserom.gb", $F21C, $F21F - $F21C

UnknownData_0xF21F:
INCBIN "baserom.gb", $F21F, $F220 - $F21F

LoggedData_0xF220:
INCBIN "baserom.gb", $F220, $F224 - $F220

UnknownData_0xF224:
INCBIN "baserom.gb", $F224, $F225 - $F224

LoggedData_0xF225:
INCBIN "baserom.gb", $F225, $F228 - $F225

UnknownData_0xF228:
INCBIN "baserom.gb", $F228, $F229 - $F228

LoggedData_0xF229:
INCBIN "baserom.gb", $F229, $F22C - $F229

UnknownData_0xF22C:
INCBIN "baserom.gb", $F22C, $F22D - $F22C

LoggedData_0xF22D:
INCBIN "baserom.gb", $F22D, $F230 - $F22D

UnknownData_0xF230:
INCBIN "baserom.gb", $F230, $F231 - $F230

LoggedData_0xF231:
INCBIN "baserom.gb", $F231, $F235 - $F231

UnknownData_0xF235:
INCBIN "baserom.gb", $F235, $F236 - $F235

LoggedData_0xF236:
INCBIN "baserom.gb", $F236, $F239 - $F236

UnknownData_0xF239:
INCBIN "baserom.gb", $F239, $F23A - $F239

LoggedData_0xF23A:
INCBIN "baserom.gb", $F23A, $F23D - $F23A

UnknownData_0xF23D:
INCBIN "baserom.gb", $F23D, $F23E - $F23D

LoggedData_0xF23E:
INCBIN "baserom.gb", $F23E, $F241 - $F23E

UnknownData_0xF241:
INCBIN "baserom.gb", $F241, $F242 - $F241

LoggedData_0xF242:
INCBIN "baserom.gb", $F242, $F246 - $F242

UnknownData_0xF246:
INCBIN "baserom.gb", $F246, $F247 - $F246

LoggedData_0xF247:
INCBIN "baserom.gb", $F247, $F24A - $F247

UnknownData_0xF24A:
INCBIN "baserom.gb", $F24A, $F24B - $F24A

LoggedData_0xF24B:
INCBIN "baserom.gb", $F24B, $F24E - $F24B

UnknownData_0xF24E:
INCBIN "baserom.gb", $F24E, $F24F - $F24E

LoggedData_0xF24F:
INCBIN "baserom.gb", $F24F, $F252 - $F24F

UnknownData_0xF252:
INCBIN "baserom.gb", $F252, $F253 - $F252

LoggedData_0xF253:
INCBIN "baserom.gb", $F253, $F257 - $F253

UnknownData_0xF257:
INCBIN "baserom.gb", $F257, $F258 - $F257

LoggedData_0xF258:
INCBIN "baserom.gb", $F258, $F25B - $F258

UnknownData_0xF25B:
INCBIN "baserom.gb", $F25B, $F25C - $F25B

LoggedData_0xF25C:
INCBIN "baserom.gb", $F25C, $F25F - $F25C

UnknownData_0xF25F:
INCBIN "baserom.gb", $F25F, $F260 - $F25F

LoggedData_0xF260:
INCBIN "baserom.gb", $F260, $F263 - $F260

UnknownData_0xF263:
INCBIN "baserom.gb", $F263, $F264 - $F263

LoggedData_0xF264:
INCBIN "baserom.gb", $F264, $F268 - $F264

UnknownData_0xF268:
INCBIN "baserom.gb", $F268, $F269 - $F268

LoggedData_0xF269:
INCBIN "baserom.gb", $F269, $F26C - $F269

UnknownData_0xF26C:
INCBIN "baserom.gb", $F26C, $F26D - $F26C

LoggedData_0xF26D:
INCBIN "baserom.gb", $F26D, $F270 - $F26D

UnknownData_0xF270:
INCBIN "baserom.gb", $F270, $F271 - $F270

LoggedData_0xF271:
INCBIN "baserom.gb", $F271, $F274 - $F271

UnknownData_0xF274:
INCBIN "baserom.gb", $F274, $F275 - $F274

LoggedData_0xF275:
INCBIN "baserom.gb", $F275, $F279 - $F275

UnknownData_0xF279:
INCBIN "baserom.gb", $F279, $F27A - $F279

LoggedData_0xF27A:
INCBIN "baserom.gb", $F27A, $F27D - $F27A

UnknownData_0xF27D:
INCBIN "baserom.gb", $F27D, $F27E - $F27D

LoggedData_0xF27E:
INCBIN "baserom.gb", $F27E, $F281 - $F27E

UnknownData_0xF281:
INCBIN "baserom.gb", $F281, $F282 - $F281

LoggedData_0xF282:
INCBIN "baserom.gb", $F282, $F285 - $F282

UnknownData_0xF285:
INCBIN "baserom.gb", $F285, $F286 - $F285

LoggedData_0xF286:
INCBIN "baserom.gb", $F286, $F28A - $F286

UnknownData_0xF28A:
INCBIN "baserom.gb", $F28A, $F28B - $F28A

LoggedData_0xF28B:
INCBIN "baserom.gb", $F28B, $F28E - $F28B

UnknownData_0xF28E:
INCBIN "baserom.gb", $F28E, $F28F - $F28E

LoggedData_0xF28F:
INCBIN "baserom.gb", $F28F, $F292 - $F28F

UnknownData_0xF292:
INCBIN "baserom.gb", $F292, $F293 - $F292

LoggedData_0xF293:
INCBIN "baserom.gb", $F293, $F296 - $F293

UnknownData_0xF296:
INCBIN "baserom.gb", $F296, $F297 - $F296

LoggedData_0xF297:
INCBIN "baserom.gb", $F297, $F2B8 - $F297

UnknownData_0xF2B8:
INCBIN "baserom.gb", $F2B8, $F2BA - $F2B8

LoggedData_0xF2BA:
INCBIN "baserom.gb", $F2BA, $F2BD - $F2BA

UnknownData_0xF2BD:
INCBIN "baserom.gb", $F2BD, $F2BE - $F2BD

LoggedData_0xF2BE:
INCBIN "baserom.gb", $F2BE, $F2C1 - $F2BE

UnknownData_0xF2C1:
INCBIN "baserom.gb", $F2C1, $F2C2 - $F2C1

LoggedData_0xF2C2:
INCBIN "baserom.gb", $F2C2, $F2C5 - $F2C2

UnknownData_0xF2C5:
INCBIN "baserom.gb", $F2C5, $F2C6 - $F2C5

LoggedData_0xF2C6:
INCBIN "baserom.gb", $F2C6, $F2C9 - $F2C6

UnknownData_0xF2C9:
INCBIN "baserom.gb", $F2C9, $F2CA - $F2C9

LoggedData_0xF2CA:
INCBIN "baserom.gb", $F2CA, $F2CE - $F2CA

UnknownData_0xF2CE:
INCBIN "baserom.gb", $F2CE, $F2CF - $F2CE

LoggedData_0xF2CF:
INCBIN "baserom.gb", $F2CF, $F2D2 - $F2CF

UnknownData_0xF2D2:
INCBIN "baserom.gb", $F2D2, $F2D3 - $F2D2

LoggedData_0xF2D3:
INCBIN "baserom.gb", $F2D3, $F2D6 - $F2D3

UnknownData_0xF2D6:
INCBIN "baserom.gb", $F2D6, $F2D7 - $F2D6

LoggedData_0xF2D7:
INCBIN "baserom.gb", $F2D7, $F2DA - $F2D7

UnknownData_0xF2DA:
INCBIN "baserom.gb", $F2DA, $F2DB - $F2DA

LoggedData_0xF2DB:
INCBIN "baserom.gb", $F2DB, $F2DF - $F2DB

UnknownData_0xF2DF:
INCBIN "baserom.gb", $F2DF, $F2E0 - $F2DF

LoggedData_0xF2E0:
INCBIN "baserom.gb", $F2E0, $F2E3 - $F2E0

UnknownData_0xF2E3:
INCBIN "baserom.gb", $F2E3, $F2E4 - $F2E3

LoggedData_0xF2E4:
INCBIN "baserom.gb", $F2E4, $F2E7 - $F2E4

UnknownData_0xF2E7:
INCBIN "baserom.gb", $F2E7, $F2E8 - $F2E7

LoggedData_0xF2E8:
INCBIN "baserom.gb", $F2E8, $F2EB - $F2E8

UnknownData_0xF2EB:
INCBIN "baserom.gb", $F2EB, $F2EC - $F2EB

LoggedData_0xF2EC:
INCBIN "baserom.gb", $F2EC, $F2F0 - $F2EC

UnknownData_0xF2F0:
INCBIN "baserom.gb", $F2F0, $F2F1 - $F2F0

LoggedData_0xF2F1:
INCBIN "baserom.gb", $F2F1, $F2F4 - $F2F1

UnknownData_0xF2F4:
INCBIN "baserom.gb", $F2F4, $F2F5 - $F2F4

LoggedData_0xF2F5:
INCBIN "baserom.gb", $F2F5, $F2F8 - $F2F5

UnknownData_0xF2F8:
INCBIN "baserom.gb", $F2F8, $F2F9 - $F2F8

LoggedData_0xF2F9:
INCBIN "baserom.gb", $F2F9, $F2FC - $F2F9

UnknownData_0xF2FC:
INCBIN "baserom.gb", $F2FC, $F2FD - $F2FC

LoggedData_0xF2FD:
INCBIN "baserom.gb", $F2FD, $F301 - $F2FD

UnknownData_0xF301:
INCBIN "baserom.gb", $F301, $F302 - $F301

LoggedData_0xF302:
INCBIN "baserom.gb", $F302, $F305 - $F302

UnknownData_0xF305:
INCBIN "baserom.gb", $F305, $F306 - $F305

LoggedData_0xF306:
INCBIN "baserom.gb", $F306, $F309 - $F306

UnknownData_0xF309:
INCBIN "baserom.gb", $F309, $F30A - $F309

LoggedData_0xF30A:
INCBIN "baserom.gb", $F30A, $F30D - $F30A

UnknownData_0xF30D:
INCBIN "baserom.gb", $F30D, $F30E - $F30D

LoggedData_0xF30E:
INCBIN "baserom.gb", $F30E, $F312 - $F30E

UnknownData_0xF312:
INCBIN "baserom.gb", $F312, $F313 - $F312

LoggedData_0xF313:
INCBIN "baserom.gb", $F313, $F316 - $F313

UnknownData_0xF316:
INCBIN "baserom.gb", $F316, $F317 - $F316

LoggedData_0xF317:
INCBIN "baserom.gb", $F317, $F31A - $F317

UnknownData_0xF31A:
INCBIN "baserom.gb", $F31A, $F31B - $F31A

LoggedData_0xF31B:
INCBIN "baserom.gb", $F31B, $F31E - $F31B

UnknownData_0xF31E:
INCBIN "baserom.gb", $F31E, $F31F - $F31E

LoggedData_0xF31F:
INCBIN "baserom.gb", $F31F, $F323 - $F31F

UnknownData_0xF323:
INCBIN "baserom.gb", $F323, $F324 - $F323

LoggedData_0xF324:
INCBIN "baserom.gb", $F324, $F327 - $F324

UnknownData_0xF327:
INCBIN "baserom.gb", $F327, $F328 - $F327

LoggedData_0xF328:
INCBIN "baserom.gb", $F328, $F32B - $F328

UnknownData_0xF32B:
INCBIN "baserom.gb", $F32B, $F32C - $F32B

LoggedData_0xF32C:
INCBIN "baserom.gb", $F32C, $F32F - $F32C

UnknownData_0xF32F:
INCBIN "baserom.gb", $F32F, $F330 - $F32F

LoggedData_0xF330:
INCBIN "baserom.gb", $F330, $F334 - $F330

UnknownData_0xF334:
INCBIN "baserom.gb", $F334, $F335 - $F334

LoggedData_0xF335:
INCBIN "baserom.gb", $F335, $F338 - $F335

UnknownData_0xF338:
INCBIN "baserom.gb", $F338, $F339 - $F338

LoggedData_0xF339:
INCBIN "baserom.gb", $F339, $F33C - $F339

UnknownData_0xF33C:
INCBIN "baserom.gb", $F33C, $F33D - $F33C

LoggedData_0xF33D:
INCBIN "baserom.gb", $F33D, $F340 - $F33D

UnknownData_0xF340:
INCBIN "baserom.gb", $F340, $F341 - $F340

LoggedData_0xF341:
INCBIN "baserom.gb", $F341, $F345 - $F341

UnknownData_0xF345:
INCBIN "baserom.gb", $F345, $F346 - $F345

LoggedData_0xF346:
INCBIN "baserom.gb", $F346, $F349 - $F346

UnknownData_0xF349:
INCBIN "baserom.gb", $F349, $F34A - $F349

LoggedData_0xF34A:
INCBIN "baserom.gb", $F34A, $F34D - $F34A

UnknownData_0xF34D:
INCBIN "baserom.gb", $F34D, $F34E - $F34D

LoggedData_0xF34E:
INCBIN "baserom.gb", $F34E, $F351 - $F34E

UnknownData_0xF351:
INCBIN "baserom.gb", $F351, $F352 - $F351

LoggedData_0xF352:
INCBIN "baserom.gb", $F352, $F356 - $F352

UnknownData_0xF356:
INCBIN "baserom.gb", $F356, $F357 - $F356

LoggedData_0xF357:
INCBIN "baserom.gb", $F357, $F35A - $F357

UnknownData_0xF35A:
INCBIN "baserom.gb", $F35A, $F35B - $F35A

LoggedData_0xF35B:
INCBIN "baserom.gb", $F35B, $F35E - $F35B

UnknownData_0xF35E:
INCBIN "baserom.gb", $F35E, $F35F - $F35E

LoggedData_0xF35F:
INCBIN "baserom.gb", $F35F, $F362 - $F35F

UnknownData_0xF362:
INCBIN "baserom.gb", $F362, $F363 - $F362

LoggedData_0xF363:
INCBIN "baserom.gb", $F363, $F367 - $F363

UnknownData_0xF367:
INCBIN "baserom.gb", $F367, $F368 - $F367

LoggedData_0xF368:
INCBIN "baserom.gb", $F368, $F36B - $F368

UnknownData_0xF36B:
INCBIN "baserom.gb", $F36B, $F36C - $F36B

LoggedData_0xF36C:
INCBIN "baserom.gb", $F36C, $F36F - $F36C

UnknownData_0xF36F:
INCBIN "baserom.gb", $F36F, $F370 - $F36F

LoggedData_0xF370:
INCBIN "baserom.gb", $F370, $F373 - $F370

UnknownData_0xF373:
INCBIN "baserom.gb", $F373, $F374 - $F373

LoggedData_0xF374:
INCBIN "baserom.gb", $F374, $F378 - $F374

UnknownData_0xF378:
INCBIN "baserom.gb", $F378, $F379 - $F378

LoggedData_0xF379:
INCBIN "baserom.gb", $F379, $F37C - $F379

UnknownData_0xF37C:
INCBIN "baserom.gb", $F37C, $F37D - $F37C

LoggedData_0xF37D:
INCBIN "baserom.gb", $F37D, $F380 - $F37D

UnknownData_0xF380:
INCBIN "baserom.gb", $F380, $F381 - $F380

LoggedData_0xF381:
INCBIN "baserom.gb", $F381, $F384 - $F381

UnknownData_0xF384:
INCBIN "baserom.gb", $F384, $F385 - $F384

LoggedData_0xF385:
INCBIN "baserom.gb", $F385, $F389 - $F385

UnknownData_0xF389:
INCBIN "baserom.gb", $F389, $F38A - $F389

LoggedData_0xF38A:
INCBIN "baserom.gb", $F38A, $F38D - $F38A

UnknownData_0xF38D:
INCBIN "baserom.gb", $F38D, $F38E - $F38D

LoggedData_0xF38E:
INCBIN "baserom.gb", $F38E, $F391 - $F38E

UnknownData_0xF391:
INCBIN "baserom.gb", $F391, $F392 - $F391

LoggedData_0xF392:
INCBIN "baserom.gb", $F392, $F395 - $F392

UnknownData_0xF395:
INCBIN "baserom.gb", $F395, $F396 - $F395

LoggedData_0xF396:
INCBIN "baserom.gb", $F396, $F39A - $F396

UnknownData_0xF39A:
INCBIN "baserom.gb", $F39A, $F39B - $F39A

LoggedData_0xF39B:
INCBIN "baserom.gb", $F39B, $F39E - $F39B

UnknownData_0xF39E:
INCBIN "baserom.gb", $F39E, $F39F - $F39E

LoggedData_0xF39F:
INCBIN "baserom.gb", $F39F, $F3A2 - $F39F

UnknownData_0xF3A2:
INCBIN "baserom.gb", $F3A2, $F3A3 - $F3A2

LoggedData_0xF3A3:
INCBIN "baserom.gb", $F3A3, $F3A6 - $F3A3

UnknownData_0xF3A6:
INCBIN "baserom.gb", $F3A6, $F3A7 - $F3A6

LoggedData_0xF3A7:
INCBIN "baserom.gb", $F3A7, $F3AB - $F3A7

UnknownData_0xF3AB:
INCBIN "baserom.gb", $F3AB, $F3AC - $F3AB

LoggedData_0xF3AC:
INCBIN "baserom.gb", $F3AC, $F3AF - $F3AC

UnknownData_0xF3AF:
INCBIN "baserom.gb", $F3AF, $F3B0 - $F3AF

LoggedData_0xF3B0:
INCBIN "baserom.gb", $F3B0, $F3B3 - $F3B0

UnknownData_0xF3B3:
INCBIN "baserom.gb", $F3B3, $F3B4 - $F3B3

LoggedData_0xF3B4:
INCBIN "baserom.gb", $F3B4, $F3B7 - $F3B4

UnknownData_0xF3B7:
INCBIN "baserom.gb", $F3B7, $F3B8 - $F3B7

LoggedData_0xF3B8:
INCBIN "baserom.gb", $F3B8, $F3BC - $F3B8

UnknownData_0xF3BC:
INCBIN "baserom.gb", $F3BC, $F3BD - $F3BC

LoggedData_0xF3BD:
INCBIN "baserom.gb", $F3BD, $F3C0 - $F3BD

UnknownData_0xF3C0:
INCBIN "baserom.gb", $F3C0, $F3C1 - $F3C0

LoggedData_0xF3C1:
INCBIN "baserom.gb", $F3C1, $F3C4 - $F3C1

UnknownData_0xF3C4:
INCBIN "baserom.gb", $F3C4, $F3C5 - $F3C4

LoggedData_0xF3C5:
INCBIN "baserom.gb", $F3C5, $F3C8 - $F3C5

UnknownData_0xF3C8:
INCBIN "baserom.gb", $F3C8, $F3C9 - $F3C8

LoggedData_0xF3C9:
INCBIN "baserom.gb", $F3C9, $F3D2 - $F3C9

UnknownData_0xF3D2:
INCBIN "baserom.gb", $F3D2, $F3D4 - $F3D2

LoggedData_0xF3D4:
INCBIN "baserom.gb", $F3D4, $F3DC - $F3D4

UnknownData_0xF3DC:
INCBIN "baserom.gb", $F3DC, $F3DE - $F3DC

LoggedData_0xF3DE:
INCBIN "baserom.gb", $F3DE, $F3E1 - $F3DE

UnknownData_0xF3E1:
INCBIN "baserom.gb", $F3E1, $F3E2 - $F3E1

LoggedData_0xF3E2:
INCBIN "baserom.gb", $F3E2, $F3E5 - $F3E2

UnknownData_0xF3E5:
INCBIN "baserom.gb", $F3E5, $F3E6 - $F3E5

LoggedData_0xF3E6:
INCBIN "baserom.gb", $F3E6, $F3E9 - $F3E6

UnknownData_0xF3E9:
INCBIN "baserom.gb", $F3E9, $F3EA - $F3E9

LoggedData_0xF3EA:
INCBIN "baserom.gb", $F3EA, $F3ED - $F3EA

UnknownData_0xF3ED:
INCBIN "baserom.gb", $F3ED, $F3EE - $F3ED

LoggedData_0xF3EE:
INCBIN "baserom.gb", $F3EE, $F3F2 - $F3EE

UnknownData_0xF3F2:
INCBIN "baserom.gb", $F3F2, $F3F3 - $F3F2

LoggedData_0xF3F3:
INCBIN "baserom.gb", $F3F3, $F3F6 - $F3F3

UnknownData_0xF3F6:
INCBIN "baserom.gb", $F3F6, $F3F7 - $F3F6

LoggedData_0xF3F7:
INCBIN "baserom.gb", $F3F7, $F3FA - $F3F7

UnknownData_0xF3FA:
INCBIN "baserom.gb", $F3FA, $F3FB - $F3FA

LoggedData_0xF3FB:
INCBIN "baserom.gb", $F3FB, $F3FE - $F3FB

UnknownData_0xF3FE:
INCBIN "baserom.gb", $F3FE, $F3FF - $F3FE

LoggedData_0xF3FF:
INCBIN "baserom.gb", $F3FF, $F403 - $F3FF

UnknownData_0xF403:
INCBIN "baserom.gb", $F403, $F404 - $F403

LoggedData_0xF404:
INCBIN "baserom.gb", $F404, $F407 - $F404

UnknownData_0xF407:
INCBIN "baserom.gb", $F407, $F408 - $F407

LoggedData_0xF408:
INCBIN "baserom.gb", $F408, $F40B - $F408

UnknownData_0xF40B:
INCBIN "baserom.gb", $F40B, $F40C - $F40B

LoggedData_0xF40C:
INCBIN "baserom.gb", $F40C, $F40F - $F40C

UnknownData_0xF40F:
INCBIN "baserom.gb", $F40F, $F410 - $F40F

LoggedData_0xF410:
INCBIN "baserom.gb", $F410, $F414 - $F410

UnknownData_0xF414:
INCBIN "baserom.gb", $F414, $F415 - $F414

LoggedData_0xF415:
INCBIN "baserom.gb", $F415, $F418 - $F415

UnknownData_0xF418:
INCBIN "baserom.gb", $F418, $F419 - $F418

LoggedData_0xF419:
INCBIN "baserom.gb", $F419, $F41C - $F419

UnknownData_0xF41C:
INCBIN "baserom.gb", $F41C, $F41D - $F41C

LoggedData_0xF41D:
INCBIN "baserom.gb", $F41D, $F420 - $F41D

UnknownData_0xF420:
INCBIN "baserom.gb", $F420, $F421 - $F420

LoggedData_0xF421:
INCBIN "baserom.gb", $F421, $F425 - $F421

UnknownData_0xF425:
INCBIN "baserom.gb", $F425, $F426 - $F425

LoggedData_0xF426:
INCBIN "baserom.gb", $F426, $F429 - $F426

UnknownData_0xF429:
INCBIN "baserom.gb", $F429, $F42A - $F429

LoggedData_0xF42A:
INCBIN "baserom.gb", $F42A, $F42D - $F42A

UnknownData_0xF42D:
INCBIN "baserom.gb", $F42D, $F42E - $F42D

LoggedData_0xF42E:
INCBIN "baserom.gb", $F42E, $F431 - $F42E

UnknownData_0xF431:
INCBIN "baserom.gb", $F431, $F432 - $F431

LoggedData_0xF432:
INCBIN "baserom.gb", $F432, $F436 - $F432

UnknownData_0xF436:
INCBIN "baserom.gb", $F436, $F437 - $F436

LoggedData_0xF437:
INCBIN "baserom.gb", $F437, $F43A - $F437

UnknownData_0xF43A:
INCBIN "baserom.gb", $F43A, $F43B - $F43A

LoggedData_0xF43B:
INCBIN "baserom.gb", $F43B, $F43E - $F43B

UnknownData_0xF43E:
INCBIN "baserom.gb", $F43E, $F43F - $F43E

LoggedData_0xF43F:
INCBIN "baserom.gb", $F43F, $F442 - $F43F

UnknownData_0xF442:
INCBIN "baserom.gb", $F442, $F443 - $F442

LoggedData_0xF443:
INCBIN "baserom.gb", $F443, $F447 - $F443

UnknownData_0xF447:
INCBIN "baserom.gb", $F447, $F448 - $F447

LoggedData_0xF448:
INCBIN "baserom.gb", $F448, $F44B - $F448

UnknownData_0xF44B:
INCBIN "baserom.gb", $F44B, $F44C - $F44B

LoggedData_0xF44C:
INCBIN "baserom.gb", $F44C, $F44F - $F44C

UnknownData_0xF44F:
INCBIN "baserom.gb", $F44F, $F450 - $F44F

LoggedData_0xF450:
INCBIN "baserom.gb", $F450, $F453 - $F450

UnknownData_0xF453:
INCBIN "baserom.gb", $F453, $F454 - $F453

LoggedData_0xF454:
INCBIN "baserom.gb", $F454, $F458 - $F454

UnknownData_0xF458:
INCBIN "baserom.gb", $F458, $F459 - $F458

LoggedData_0xF459:
INCBIN "baserom.gb", $F459, $F45C - $F459

UnknownData_0xF45C:
INCBIN "baserom.gb", $F45C, $F45D - $F45C

LoggedData_0xF45D:
INCBIN "baserom.gb", $F45D, $F460 - $F45D

UnknownData_0xF460:
INCBIN "baserom.gb", $F460, $F461 - $F460

LoggedData_0xF461:
INCBIN "baserom.gb", $F461, $F464 - $F461

UnknownData_0xF464:
INCBIN "baserom.gb", $F464, $F465 - $F464

LoggedData_0xF465:
INCBIN "baserom.gb", $F465, $F466 - $F465

UnknownData_0xF466:
INCBIN "baserom.gb", $F466, $F6F4 - $F466

LoggedData_0xF6F4:
INCBIN "baserom.gb", $F6F4, $F6F8 - $F6F4

UnknownData_0xF6F8:
INCBIN "baserom.gb", $F6F8, $F6FE - $F6F8

LoggedData_0xF6FE:
INCBIN "baserom.gb", $F6FE, $F748 - $F6FE

UnknownData_0xF748:
INCBIN "baserom.gb", $F748, $F76A - $F748

LoggedData_0xF76A:
INCBIN "baserom.gb", $F76A, $F87A - $F76A

UnknownData_0xF87A:
INCBIN "baserom.gb", $F87A, $10000 - $F87A

SECTION "Bank04", ROMX, BANK[$04]

LoggedData_0x10000:
INCBIN "baserom.gb", $10000, $13FD0 - $10000

UnknownData_0x13FD0:
INCBIN "baserom.gb", $13FD0, $14000 - $13FD0

SECTION "Bank05", ROMX, BANK[$05]

LoggedData_0x14000:
INCBIN "baserom.gb", $14000, $14002 - $14000

UnknownData_0x14002:
INCBIN "baserom.gb", $14002, $14006 - $14002

LoggedData_0x14006:
INCBIN "baserom.gb", $14006, $1401A - $14006

UnknownData_0x1401A:
INCBIN "baserom.gb", $1401A, $1402A - $1401A

LoggedData_0x1402A:
INCBIN "baserom.gb", $1402A, $1402E - $1402A

UnknownData_0x1402E:
INCBIN "baserom.gb", $1402E, $14036 - $1402E

LoggedData_0x14036:
INCBIN "baserom.gb", $14036, $14042 - $14036

UnknownData_0x14042:
INCBIN "baserom.gb", $14042, $14052 - $14042

LoggedData_0x14052:
INCBIN "baserom.gb", $14052, $14082 - $14052

UnknownData_0x14082:
INCBIN "baserom.gb", $14082, $1408A - $14082

LoggedData_0x1408A:
INCBIN "baserom.gb", $1408A, $1408E - $1408A

UnknownData_0x1408E:
INCBIN "baserom.gb", $1408E, $14092 - $1408E

LoggedData_0x14092:
INCBIN "baserom.gb", $14092, $14096 - $14092

UnknownData_0x14096:
INCBIN "baserom.gb", $14096, $1409A - $14096

LoggedData_0x1409A:
INCBIN "baserom.gb", $1409A, $140C6 - $1409A

UnknownData_0x140C6:
INCBIN "baserom.gb", $140C6, $140CA - $140C6

LoggedData_0x140CA:
INCBIN "baserom.gb", $140CA, $140CE - $140CA

UnknownData_0x140CE:
INCBIN "baserom.gb", $140CE, $140DE - $140CE

LoggedData_0x140DE:
INCBIN "baserom.gb", $140DE, $140EA - $140DE

UnknownData_0x140EA:
INCBIN "baserom.gb", $140EA, $1432D - $140EA

LoggedData_0x1432D:
INCBIN "baserom.gb", $1432D, $14484 - $1432D

UnknownData_0x14484:
INCBIN "baserom.gb", $14484, $14509 - $14484

LoggedData_0x14509:
INCBIN "baserom.gb", $14509, $14BC5 - $14509

UnknownData_0x14BC5:
INCBIN "baserom.gb", $14BC5, $14C30 - $14BC5

LoggedData_0x14C30:
INCBIN "baserom.gb", $14C30, $14E1D - $14C30

UnknownData_0x14E1D:
INCBIN "baserom.gb", $14E1D, $14E85 - $14E1D

LoggedData_0x14E85:
INCBIN "baserom.gb", $14E85, $151B8 - $14E85

UnknownData_0x151B8:
INCBIN "baserom.gb", $151B8, $152DD - $151B8

LoggedData_0x152DD:
INCBIN "baserom.gb", $152DD, $1548A - $152DD

UnknownData_0x1548A:
INCBIN "baserom.gb", $1548A, $15571 - $1548A

LoggedData_0x15571:
INCBIN "baserom.gb", $15571, $156DA - $15571

UnknownData_0x156DA:
INCBIN "baserom.gb", $156DA, $18000 - $156DA

SECTION "Bank06", ROMX, BANK[$06]

LoggedData_0x18000:
INCBIN "baserom.gb", $18000, $18180 - $18000

UnknownData_0x18180:
INCBIN "baserom.gb", $18180, $18340 - $18180

LoggedData_0x18340:
INCBIN "baserom.gb", $18340, $18BC0 - $18340

UnknownData_0x18BC0:
INCBIN "baserom.gb", $18BC0, $18CA0 - $18BC0

LoggedData_0x18CA0:
INCBIN "baserom.gb", $18CA0, $18EA0 - $18CA0

UnknownData_0x18EA0:
INCBIN "baserom.gb", $18EA0, $18EC0 - $18EA0

LoggedData_0x18EC0:
INCBIN "baserom.gb", $18EC0, $18F60 - $18EC0

UnknownData_0x18F60:
INCBIN "baserom.gb", $18F60, $18FA0 - $18F60

LoggedData_0x18FA0:
INCBIN "baserom.gb", $18FA0, $190A0 - $18FA0

UnknownData_0x190A0:
INCBIN "baserom.gb", $190A0, $190C0 - $190A0

LoggedData_0x190C0:
INCBIN "baserom.gb", $190C0, $195B0 - $190C0

UnknownData_0x195B0:
INCBIN "baserom.gb", $195B0, $195C0 - $195B0

LoggedData_0x195C0:
INCBIN "baserom.gb", $195C0, $19870 - $195C0

UnknownData_0x19870:
INCBIN "baserom.gb", $19870, $19878 - $19870

LoggedData_0x19878:
INCBIN "baserom.gb", $19878, $19884 - $19878

UnknownData_0x19884:
INCBIN "baserom.gb", $19884, $198B2 - $19884

LoggedData_0x198B2:
INCBIN "baserom.gb", $198B2, $198BA - $198B2

UnknownData_0x198BA:
INCBIN "baserom.gb", $198BA, $198C8 - $198BA

LoggedData_0x198C8:
INCBIN "baserom.gb", $198C8, $198F0 - $198C8

UnknownData_0x198F0:
INCBIN "baserom.gb", $198F0, $19900 - $198F0

LoggedData_0x19900:
INCBIN "baserom.gb", $19900, $19908 - $19900

UnknownData_0x19908:
INCBIN "baserom.gb", $19908, $19930 - $19908

LoggedData_0x19930:
INCBIN "baserom.gb", $19930, $19932 - $19930

UnknownData_0x19932:
INCBIN "baserom.gb", $19932, $1993A - $19932

LoggedData_0x1993A:
INCBIN "baserom.gb", $1993A, $19943 - $1993A

UnknownData_0x19943:
INCBIN "baserom.gb", $19943, $1994C - $19943

LoggedData_0x1994C:
INCBIN "baserom.gb", $1994C, $19955 - $1994C

UnknownData_0x19955:
INCBIN "baserom.gb", $19955, $1995E - $19955

LoggedData_0x1995E:
INCBIN "baserom.gb", $1995E, $19A18 - $1995E

UnknownData_0x19A18:
INCBIN "baserom.gb", $19A18, $19A1A - $19A18

LoggedData_0x19A1A:
INCBIN "baserom.gb", $19A1A, $19A2D - $19A1A

UnknownData_0x19A2D:
INCBIN "baserom.gb", $19A2D, $19A2F - $19A2D

LoggedData_0x19A2F:
INCBIN "baserom.gb", $19A2F, $19A42 - $19A2F

UnknownData_0x19A42:
INCBIN "baserom.gb", $19A42, $19A44 - $19A42

LoggedData_0x19A44:
INCBIN "baserom.gb", $19A44, $19A57 - $19A44

UnknownData_0x19A57:
INCBIN "baserom.gb", $19A57, $19A59 - $19A57

LoggedData_0x19A59:
INCBIN "baserom.gb", $19A59, $19A72 - $19A59

UnknownData_0x19A72:
INCBIN "baserom.gb", $19A72, $19A74 - $19A72

LoggedData_0x19A74:
INCBIN "baserom.gb", $19A74, $19A90 - $19A74

UnknownData_0x19A90:
INCBIN "baserom.gb", $19A90, $19A92 - $19A90

LoggedData_0x19A92:
INCBIN "baserom.gb", $19A92, $19BD4 - $19A92

UnknownData_0x19BD4:
INCBIN "baserom.gb", $19BD4, $19BD6 - $19BD4

LoggedData_0x19BD6:
INCBIN "baserom.gb", $19BD6, $19D36 - $19BD6

UnknownData_0x19D36:
INCBIN "baserom.gb", $19D36, $19D38 - $19D36

LoggedData_0x19D38:
INCBIN "baserom.gb", $19D38, $19E90 - $19D38

UnknownData_0x19E90:
INCBIN "baserom.gb", $19E90, $19E92 - $19E90

LoggedData_0x19E92:
INCBIN "baserom.gb", $19E92, $19E9A - $19E92

UnknownData_0x19E9A:
INCBIN "baserom.gb", $19E9A, $19E9C - $19E9A

LoggedData_0x19E9C:
INCBIN "baserom.gb", $19E9C, $19EAC - $19E9C

UnknownData_0x19EAC:
INCBIN "baserom.gb", $19EAC, $19EB0 - $19EAC

LoggedData_0x19EB0:
INCBIN "baserom.gb", $19EB0, $19F61 - $19EB0

UnknownData_0x19F61:
INCBIN "baserom.gb", $19F61, $19F6A - $19F61

LoggedData_0x19F6A:
INCBIN "baserom.gb", $19F6A, $1A49A - $19F6A

UnknownData_0x1A49A:
INCBIN "baserom.gb", $1A49A, $1A49C - $1A49A

LoggedData_0x1A49C:
INCBIN "baserom.gb", $1A49C, $1A4B8 - $1A49C

UnknownData_0x1A4B8:
INCBIN "baserom.gb", $1A4B8, $1A4C2 - $1A4B8

LoggedData_0x1A4C2:
INCBIN "baserom.gb", $1A4C2, $1A4CC - $1A4C2

UnknownData_0x1A4CC:
INCBIN "baserom.gb", $1A4CC, $1A4E0 - $1A4CC

LoggedData_0x1A4E0:
INCBIN "baserom.gb", $1A4E0, $1A56F - $1A4E0

UnknownData_0x1A56F:
INCBIN "baserom.gb", $1A56F, $1A5A3 - $1A56F

LoggedData_0x1A5A3:
INCBIN "baserom.gb", $1A5A3, $1A5D7 - $1A5A3

UnknownData_0x1A5D7:
INCBIN "baserom.gb", $1A5D7, $1A627 - $1A5D7

LoggedData_0x1A627:
INCBIN "baserom.gb", $1A627, $1A62F - $1A627

UnknownData_0x1A62F:
INCBIN "baserom.gb", $1A62F, $1A631 - $1A62F

LoggedData_0x1A631:
INCBIN "baserom.gb", $1A631, $1A641 - $1A631

UnknownData_0x1A641:
INCBIN "baserom.gb", $1A641, $1A643 - $1A641

LoggedData_0x1A643:
INCBIN "baserom.gb", $1A643, $1A64D - $1A643

UnknownData_0x1A64D:
INCBIN "baserom.gb", $1A64D, $1A675 - $1A64D

LoggedData_0x1A675:
INCBIN "baserom.gb", $1A675, $1A704 - $1A675

UnknownData_0x1A704:
INCBIN "baserom.gb", $1A704, $1A7BC - $1A704

LoggedData_0x1A7BC:
INCBIN "baserom.gb", $1A7BC, $1A7CC - $1A7BC

UnknownData_0x1A7CC:
INCBIN "baserom.gb", $1A7CC, $1A7CE - $1A7CC

LoggedData_0x1A7CE:
INCBIN "baserom.gb", $1A7CE, $1A7E2 - $1A7CE

UnknownData_0x1A7E2:
INCBIN "baserom.gb", $1A7E2, $1A80A - $1A7E2

LoggedData_0x1A80A:
INCBIN "baserom.gb", $1A80A, $1A899 - $1A80A

UnknownData_0x1A899:
INCBIN "baserom.gb", $1A899, $1A951 - $1A899

LoggedData_0x1A951:
INCBIN "baserom.gb", $1A951, $1A959 - $1A951

UnknownData_0x1A959:
INCBIN "baserom.gb", $1A959, $1A95B - $1A959

LoggedData_0x1A95B:
INCBIN "baserom.gb", $1A95B, $1A961 - $1A95B

UnknownData_0x1A961:
INCBIN "baserom.gb", $1A961, $1A963 - $1A961

LoggedData_0x1A963:
INCBIN "baserom.gb", $1A963, $1A96B - $1A963

UnknownData_0x1A96B:
INCBIN "baserom.gb", $1A96B, $1A96D - $1A96B

LoggedData_0x1A96D:
INCBIN "baserom.gb", $1A96D, $1A975 - $1A96D

UnknownData_0x1A975:
INCBIN "baserom.gb", $1A975, $1A99F - $1A975

LoggedData_0x1A99F:
INCBIN "baserom.gb", $1A99F, $1AA2E - $1A99F

UnknownData_0x1AA2E:
INCBIN "baserom.gb", $1AA2E, $1AAE6 - $1AA2E

LoggedData_0x1AAE6:
INCBIN "baserom.gb", $1AAE6, $1AC80 - $1AAE6

UnknownData_0x1AC80:
INCBIN "baserom.gb", $1AC80, $1AC82 - $1AC80

LoggedData_0x1AC82:
INCBIN "baserom.gb", $1AC82, $1AC8A - $1AC82

UnknownData_0x1AC8A:
INCBIN "baserom.gb", $1AC8A, $1AC8C - $1AC8A

LoggedData_0x1AC8C:
INCBIN "baserom.gb", $1AC8C, $1AE92 - $1AC8C

UnknownData_0x1AE92:
INCBIN "baserom.gb", $1AE92, $1B000 - $1AE92

LoggedData_0x1B000:
INCBIN "baserom.gb", $1B000, $1C000 - $1B000

SECTION "Bank07", ROMX, BANK[$07]

Logged_0x1C000:
	jr Logged_0x1C071

Logged_0x1C002:
	call Logged_0x1C0A8
	xor a
	ld [$DC00],a
	call Logged_0x1C0C6
	xor a
	ld [$DC01],a
	call Logged_0x1C0D6
	xor a
	ld hl,$DC03
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	call Logged_0x1C184
	xor a
	ld [$DC02],a
	call Logged_0x1C1F5
	xor a
	ld [$DC22],a
	ld a,[$C0A0]
	rlca
	jr nc,Logged_0x1C06B
	ld a,[$DC10]
	cp $06
	jr nz,Unknown_0x1C044
	ld a,[$D23B]
	cp $01
	jr z,Logged_0x1C06B

Unknown_0x1C044:
	ld a,[$DC86]
	cp $01
	jr nz,Unknown_0x1C05B
	ld a,[$DC13]
	cp $01
	jr nz,Unknown_0x1C05B
	ld a,[$DC52]
	cp $02
	jr nz,Unknown_0x1C05B
	jr Logged_0x1C06B

Unknown_0x1C05B:
	ld a,[$DC1E]
	inc a
	ld [$DC1E],a
	cp $2B
	jr nz,Logged_0x1C06B
	xor a
	ld [$DC1E],a
	ret

Logged_0x1C06B:
	call Logged_0x1C282
	jp Logged_0x1CC04

Logged_0x1C071:
	ld a,$80
	ld [$FF00+$26],a
	ld a,$FF
	ld [$FF00+$25],a
	ld [$DC23],a
	ld a,$08
	ld [$FF00+$10],a
	xor a
	ld [$FF00+$11],a
	ld [$FF00+$12],a
	ld [$FF00+$13],a
	ld [$FF00+$14],a
	ld [$FF00+$16],a
	ld [$FF00+$17],a
	ld [$FF00+$18],a
	ld [$FF00+$19],a
	ld [$FF00+$1A],a
	ld [$FF00+$1B],a
	ld [$FF00+$1C],a
	ld [$FF00+$1D],a
	ld [$FF00+$1E],a
	ld [$FF00+$20],a
	ld [$FF00+$21],a
	ld [$FF00+$22],a
	ld [$FF00+$23],a
	ld a,$77
	ld [$FF00+$24],a
	ret

Logged_0x1C0A8:
	ld b,$00
	ld a,[$DC00]
	and a
	ret z
	ld [$DC10],a
	dec a
	rlca
	ld c,a
	ld b,$00
	ld hl,$50FB
	add hl,bc
	ld a,[hli]
	ld [$DC16],a
	ld a,[hl]
	ld [$DC17],a
	jp Logged_0x1CB2A

Logged_0x1C0C6:
	ld b,$00
	ld a,[$DC01]
	and a
	ret z

Logged_0x1C0CD:
	rrca
	inc b
	jr nc,Logged_0x1C0CD
	ld a,b
	ld [$DC22],a
	ret

Logged_0x1C0D6:
	ld b,$00
	ld c,$00

Logged_0x1C0DA:
	ld d,$00
	ld e,$00
	xor a
	ld [$DC26],a
	ld hl,$DC03
	add hl,bc
	ld a,[hl]
	and a
	jr z,Logged_0x1C122
	ld [$DC26],a

Logged_0x1C0ED:
	ld a,[$DC26]
	rrca
	ld [$DC26],a
	jr nc,Logged_0x1C11C
	push bc
	ld a,$08
	ld h,a
	call Logged_0x1CBDC
	ld a,l
	add a,e
	inc a
	push af
	dec a
	rlca
	ld c,a
	ld b,$00
	ld hl,$510D
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ld a,[bc]
	ld b,$00
	ld c,a
	ld hl,$DCCC
	add hl,bc
	pop af
	ld [hl],a
	call Logged_0x1C129
	pop bc

Logged_0x1C11C:
	inc e
	ld a,e
	cp $08
	jr nz,Logged_0x1C0ED

Logged_0x1C122:
	inc c
	ld a,c
	cp $0B
	jr nz,Logged_0x1C0DA
	ret

Logged_0x1C129:
	call Logged_0x1C134
	call Logged_0x1C144
	call Logged_0x1C153
	jr Logged_0x1C16B

Logged_0x1C134:
	ld hl,$DCCF
	ld a,[hl]
	cp $1A
	ret nz
	ld hl,$DCD3
	ld a,[hl]
	cp $0C
	jr z,Logged_0x1C17D
	ret

Logged_0x1C144:
	ld hl,$DCCD
	ld a,[hl]
	cp $0A
	ret nz
	ld hl,$DCD1
	ld a,[hl]
	and a
	jr nz,Logged_0x1C17D
	ret

Logged_0x1C153:
	ld hl,$DCCE
	ld a,[hl]
	cp $04
	ret nz
	ld hl,$DCD2
	ld a,[hl]
	cp $0B
	jr z,Logged_0x1C17D
	cp $10
	jr z,Logged_0x1C17D
	cp $04
	jr z,Logged_0x1C17D
	ret

Logged_0x1C16B:
	ld hl,$DCD0
	add hl,bc
	ld a,[hl]
	cp $28
	jr z,Logged_0x1C17D
	cp $24
	jr z,Logged_0x1C17D
	cp $25
	jr z,Logged_0x1C17D
	ret

Logged_0x1C17D:
	ld hl,$DCCC
	add hl,bc
	xor a
	ld [hl],a
	ret

Logged_0x1C184:
	ld a,[$DC02]
	and a
	ret z
	rrca
	call c,Logged_0x1C1A8
	rrca
	call c,Logged_0x1C1BA
	rrca
	call c,Logged_0x1C1CC
	rrca
	call c,Logged_0x1C1E0
	rrca
	call c,Unknown_0x1C1F2
	rrca
	call c,Unknown_0x1C1F3
	rrca
	call c,Unknown_0x1C1F4
	rrca
	ret nc
	ret

Logged_0x1C1A8:
	push af
	ld a,[$DCD0]
	and a
	jr z,Logged_0x1C1B8
	xor a
	ld [$FF00+$12],a
	ld [$DCCC],a
	ld [$DCD0],a

Logged_0x1C1B8:
	pop af
	ret

Logged_0x1C1BA:
	push af
	ld a,[$DCD1]
	and a
	jr z,Logged_0x1C1CA
	xor a
	ld [$FF00+$17],a
	ld [$DCCD],a
	ld [$DCD1],a

Logged_0x1C1CA:
	pop af
	ret

Logged_0x1C1CC:
	push af
	ld a,[$DCD2]
	and a
	jr z,Logged_0x1C1DE
	xor a
	ld [$FF00+$1C],a
	ld [$FF00+$1A],a
	ld [$DCCE],a
	ld [$DCD2],a

Logged_0x1C1DE:
	pop af
	ret

Logged_0x1C1E0:
	push af
	ld a,[$DCD3]
	and a
	jr z,Logged_0x1C1F0
	xor a
	ld [$FF00+$21],a
	ld [$DCCF],a
	ld [$DCD3],a

Logged_0x1C1F0:
	pop af
	ret

Unknown_0x1C1F2:
	ret

Unknown_0x1C1F3:
	ret

Unknown_0x1C1F4:
	ret

Logged_0x1C1F5:
	ld a,[$DC22]
	and a
	ret z
	cp $01
	jr z,Logged_0x1C240
	cp $02
	jr z,Logged_0x1C207
	cp $03
	jr z,Logged_0x1C249
	ret

Logged_0x1C207:
	ld a,$01
	ld [$DC1F],a
	ld hl,$DB10
	ld de,$DC10
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld c,$A4
	ld hl,$DC28

Logged_0x1C231:
	ld a,[hl]
	dec h
	ld [hli],a
	inc h
	dec c
	jr nz,Logged_0x1C231
	call Logged_0x1CA94
	xor a
	ld [$DC10],a
	ret

Logged_0x1C240:
	xor a
	ld [$DC1F],a
	inc a
	ld [$DC24],a
	ret

Logged_0x1C249:
	xor a
	ld [$DC1F],a
	ld hl,$DC10
	ld de,$DB10
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld d,$00
	ld e,$00

Logged_0x1C271:
	ld hl,$DB28
	add hl,de
	ld a,[hl]
	ld hl,$DC28
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $A4
	jr nz,Logged_0x1C271
	ret

Logged_0x1C282:
	ld a,[$DC24]
	and a
	jr nz,Logged_0x1C28A
	jr Logged_0x1C298

Logged_0x1C28A:
	call Logged_0x1CA94
	xor a
	ld [$DC10],a
	ld [$DC22],a
	ld [$DC24],a
	ret

Logged_0x1C298:
	ld a,[$DC10]
	and a
	ret z
	ld d,$00
	ld e,$00

Logged_0x1C2A1:
	call Logged_0x1CAC1
	ld hl,$DCAC
	add hl,de
	jr z,Logged_0x1C2C8
	call Logged_0x1C2DD
	call Logged_0x1C5B7
	call Logged_0x1C847
	call Logged_0x1C78C
	call Logged_0x1C60A
	call Logged_0x1C65F
	call Logged_0x1C6B1
	call Logged_0x1C8E9
	call Logged_0x1C2CF
	call Logged_0x1C6F4

Logged_0x1C2C8:
	inc e
	ld a,e
	cp $04
	jr nz,Logged_0x1C2A1
	ret

Logged_0x1C2CF:
	ld hl,$DC50
	add hl,de
	ld a,[hl]
	and a
	ret z
	cp $FF
	jr z,Logged_0x1C2DB
	inc a

Logged_0x1C2DB:
	ld [hl],a
	ret

Logged_0x1C2DD:
	call Logged_0x1C389
	jr Logged_0x1C2E5

Logged_0x1C2E2:
	call Logged_0x1C384

Logged_0x1C2E5:
	ld b,a
	sub $20
	jr c,Logged_0x1C337
	ld a,b
	sub $2C
	jr c,Logged_0x1C311
	ld a,b
	sub $30
	jr c,Logged_0x1C309
	ld a,b
	sub $70
	jr c,Logged_0x1C2FD
	ld a,b
	jp Logged_0x1C4BD

Logged_0x1C2FD:
	ld a,b
	sub $30
	rlca
	rlca
	ld hl,$DC6C
	add hl,de
	ld [hl],a
	jr Logged_0x1C2E2

Logged_0x1C309:
	ld a,b
	sub $2C
	ld [$DC18],a
	jr Logged_0x1C2E2

Logged_0x1C311:
	ld a,b
	sub $20
	ld c,a
	ld b,$00
	push bc
	ld hl,$4F37
	ld a,[$DC12]
	rlca
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld l,a
	ld h,b
	pop bc
	add hl,bc
	ld a,[hl]

Logged_0x1C32B:
	ld hl,$DC7C
	add hl,de
	ld [hl],a
	ld hl,$DC78
	add hl,de
	ld [hl],a
	jr Logged_0x1C2E2

Logged_0x1C337:
	ld a,b
	rlca
	ld c,a
	ld b,$00
	ld hl,$4344
	add hl,bc
	ld a,[hli]
	ld l,[hl]
	ld h,a
	jp hl

LoggedData_0x1C344:
INCBIN "baserom.gb", $1C344, $1C354 - $1C344

UnknownData_0x1C354:
INCBIN "baserom.gb", $1C354, $1C356 - $1C354

LoggedData_0x1C356:
INCBIN "baserom.gb", $1C356, $1C358 - $1C356

UnknownData_0x1C358:
INCBIN "baserom.gb", $1C358, $1C35E - $1C358

LoggedData_0x1C35E:
INCBIN "baserom.gb", $1C35E, $1C36C - $1C35E

UnknownData_0x1C36C:
INCBIN "baserom.gb", $1C36C, $1C384 - $1C36C

Logged_0x1C384:
	ld hl,$DC9C
	add hl,de
	inc [hl]

Logged_0x1C389:
	ld hl,$DC9C
	add hl,de
	ld a,[hl]
	ld c,a
	ld b,$00
	ld a,[$DC14]
	ld h,a
	ld a,[$DC15]
	ld l,a
	add hl,bc
	ld a,[hl]
	ret
	call Logged_0x1C384
	ld hl,$DC68
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	call Logged_0x1C384
	ld hl,$DC80
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	call Logged_0x1C384
	ld hl,$DC70
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	call Logged_0x1C384
	ld hl,$DC84
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	call Logged_0x1C384
	jp Logged_0x1C32B

UnknownData_0x1C3CE:
INCBIN "baserom.gb", $1C3CE, $1C3EB - $1C3CE
	call Logged_0x1C384
	ld hl,$DC8C
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2

UnknownData_0x1C3F6:
INCBIN "baserom.gb", $1C3F6, $1C3FC - $1C3F6
	ld a,[$DC11]
	inc a
	ld [$DC11],a
	push de
	ld d,$00
	ld e,$00

Logged_0x1C408:
	xor a
	ld hl,$DC9C
	add hl,de
	ld [hl],a
	ld hl,$DC50
	add hl,de
	ld [hl],a
	ld hl,$DC90
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $04
	jr nz,Logged_0x1C408
	pop de
	call Logged_0x1CAC1
	call Logged_0x1CAFC
	jp Logged_0x1C2DD
	call Logged_0x1C384
	ld [$DC12],a
	jp Logged_0x1C2E2
	call Logged_0x1C384
	ld [$DC13],a
	jp Logged_0x1C2E2
	call Logged_0x1C384
	ld hl,$DC54
	add hl,de
	ld [hl],a
	call Logged_0x1C384
	ld hl,$DC58
	add hl,de
	ld [hl],a
	call Logged_0x1C384
	ld hl,$DC5C
	add hl,de
	ld [hl],a
	ld a,$01
	ld hl,$DCC4
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	xor a
	ld hl,$DCC4
	add hl,de
	ld [hl],a
	ld hl,$DCC8
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	xor a
	ld hl,$DC60
	add hl,de
	ld [hl],a
	ld hl,$DC90
	add hl,de
	ld [hl],a
	ld hl,$DC64
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	xor a
	ld hl,$DC70
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	call Logged_0x1C384
	ld hl,$DC94
	add hl,de
	ld [hl],a
	call Logged_0x1C384
	ld hl,$DC98
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	xor a
	ld hl,$DC94
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2
	call Logged_0x1C384
	ld hl,$DC60
	add hl,de
	ld [hl],a
	call Logged_0x1C384
	ld hl,$DC90
	add hl,de
	ld [hl],a
	call Logged_0x1C384
	ld hl,$DC64
	add hl,de
	ld [hl],a
	jp Logged_0x1C2E2

Logged_0x1C4BD:
	ld a,b
	sub $70
	ld [$DC26],a
	cp $4A
	jp z,Logged_0x1C4F3
	ld a,e
	cp $03
	jr nz,Logged_0x1C4DE
	ld a,b
	sub $BC
	ld c,a
	ld b,$00
	ld hl,$5B9B
	add hl,bc
	ld a,[hl]
	ld [$DC1A],a
	jp Logged_0x1C4F3

Logged_0x1C4DE:
	ld a,[$DC26]
	and a
	jr z,Logged_0x1C4F3
	call Logged_0x1C590
	ld hl,$DC28
	add hl,de
	ld a,b
	ld [hl],a
	ld hl,$DC2C
	add hl,de
	ld a,c
	ld [hl],a

Logged_0x1C4F3:
	call Logged_0x1C771
	ld hl,$DC7C
	add hl,de
	ld a,[hl]
	ld hl,$DC74
	add hl,de
	sub [hl]
	ld hl,$DC78
	add hl,de
	cp [hl]
	jr nz,Logged_0x1C50A
	call Logged_0x1C553

Logged_0x1C50A:
	ld hl,$DC78
	add hl,de
	ld a,[hl]
	cp $01
	jr z,Logged_0x1C543
	ld hl,$DC7C
	add hl,de
	cp [hl]
	jr z,Logged_0x1C520

Logged_0x1C51A:
	ld hl,$DC78
	add hl,de
	dec [hl]
	ret

Logged_0x1C520:
	ld a,[$DC26]
	and a
	jr z,Logged_0x1C541
	ld hl,$DCC0
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x1C532
	xor a
	ld [hl],a
	jr Logged_0x1C541

Logged_0x1C532:
	ld a,$01
	ld hl,$DCA8
	add hl,de
	ld [hl],a
	ld hl,$DCA4
	add hl,de
	ld [hl],a
	call Logged_0x1CBA8

Logged_0x1C541:
	jr Logged_0x1C51A

Logged_0x1C543:
	ld hl,$DC9C
	add hl,de
	inc [hl]
	ld hl,$DC7C
	add hl,de
	ld a,[hl]
	ld hl,$DC78
	add hl,de
	ld [hl],a
	ret

Logged_0x1C553:
	call Logged_0x1C384
	cp $BA
	jr nz,Logged_0x1C562
	ld a,$01
	ld hl,$DCC0
	add hl,de
	ld [hl],a
	ret

Logged_0x1C562:
	ld hl,$DC9C
	add hl,de
	dec [hl]
	ld a,[$DC26]
	and a
	ret z
	ld hl,$DC94
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x1C57C
	ld hl,$DCBC
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x1C57C:
	ld a,e
	and a
	jp z,Logged_0x1CA9F
	cp $01
	jp z,Logged_0x1CAA7
	cp $02
	jp z,Logged_0x1CAAF
	cp $03
	jp z,Logged_0x1CAB9

Logged_0x1C590:
	ld b,a
	ld a,e
	cp $03
	ret z
	ld hl,$DC8C
	add hl,de
	ld a,[hl]
	add a,b
	rlca
	ld c,a
	ld b,$00
	ld a,[$C0A0]
	rlca
	jr c,Unknown_0x1C5AE
	ld hl,$4FD3
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ret

Unknown_0x1C5AE:
	ld hl,$5067
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ret

Logged_0x1C5B7:
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld c,a
	push bc
	ld hl,$DC70
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x1C5FC
	push af
	and $0F
	ld [$DC26],a
	pop af
	swap a
	and $0F
	ld [$DC27],a
	ld hl,$DC50
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x1C5FC
	ld b,a
	ld a,[$DC26]
	sub b
	jr c,Logged_0x1C5FC
	and a
	jr z,Logged_0x1C5FC
	ld h,a
	ld a,[$DC27]
	ld c,a
	call Logged_0x1CBDC
	ld a,l
	pop bc

Logged_0x1C5F6:
	dec bc
	dec a
	jr nz,Logged_0x1C5F6
	jr Logged_0x1C5FD

Logged_0x1C5FC:
	pop bc

Logged_0x1C5FD:
	ld hl,$DC28
	add hl,de
	ld a,b
	ld [hl],a
	ld hl,$DC2C
	add hl,de
	ld a,c
	ld [hl],a
	ret

Logged_0x1C60A:
	ld a,e
	cp $02
	ret z
	cp $03
	ret z
	ld hl,$DC68
	add hl,de
	ld a,[hl]
	rlca
	ld c,a
	ld b,$00
	ld hl,$5A79
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	push bc
	ld hl,$DC44
	add hl,de
	ld a,[hl]
	ld c,a
	ld b,$00
	pop hl
	add hl,bc
	ld a,[hl]
	push af
	ld a,c
	rrca
	jr c,Logged_0x1C64C
	pop af
	ld hl,$DC30
	add hl,de
	ld [hl],a
	ld a,$01
	ld hl,$DCA4
	add hl,de
	ld [hl],a
	ld hl,$DC4C
	add hl,de
	ld [hl],a

Logged_0x1C645:
	ld hl,$DC44
	add hl,de
	inc [hl]
	jr Logged_0x1C60A

Logged_0x1C64C:
	pop af
	cp $FF
	jr z,Logged_0x1C65E
	ld hl,$DC48
	add hl,de
	ld [hl],a
	ld hl,$DC4C
	add hl,de
	cp [hl]
	jr z,Logged_0x1C645
	inc [hl]

Logged_0x1C65E:
	ret

Logged_0x1C65F:
	ld a,e
	cp $02
	ret z
	ld hl,$DC80
	add hl,de
	ld a,[hl]
	rlca
	ld c,a
	ld b,$00
	ld hl,$5857
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	push bc
	ld hl,$DCB0
	add hl,de
	ld a,[hl]
	ld c,a
	ld b,$00
	pop hl
	add hl,bc
	ld a,[hl]
	push af
	ld a,c
	rrca
	jr c,Logged_0x1C69E
	pop af
	ld hl,$DCA0
	add hl,de
	ld [hl],a
	ld a,$01
	ld hl,$DCA8
	add hl,de
	ld [hl],a
	ld hl,$DCB8
	add hl,de
	ld [hl],a

Logged_0x1C697:
	ld hl,$DCB0
	add hl,de
	inc [hl]
	jr Logged_0x1C65F

Logged_0x1C69E:
	pop af
	cp $FF
	jr z,Logged_0x1C6B0
	ld hl,$DCB4
	add hl,de
	ld [hl],a
	ld hl,$DCB8
	add hl,de
	cp [hl]
	jr z,Logged_0x1C697
	inc [hl]

Logged_0x1C6B0:
	ret

Logged_0x1C6B1:
	ld hl,$DC94
	add hl,de
	ld a,[hl]
	and a
	ret z
	ld hl,$DCBC
	add hl,de
	ld a,[hl]
	and a
	ret z
	cp $01
	jr z,Logged_0x1C6DA

Logged_0x1C6C3:
	ld hl,$DC94
	add hl,de
	cp [hl]
	jr z,Logged_0x1C6D1
	inc a
	ld hl,$DCBC
	add hl,de
	ld [hl],a
	ret

Logged_0x1C6D1:
	xor a
	ld hl,$DCBC
	add hl,de
	ld [hl],a
	jp Logged_0x1C57C

Logged_0x1C6DA:
	push af
	ld hl,$DC98
	add hl,de
	ld a,[hl]
	ld hl,$DCA0
	add hl,de
	ld [hl],a
	ld a,$01
	ld hl,$DCA4
	add hl,de
	ld [hl],a
	ld hl,$DCA8
	add hl,de
	ld [hl],a
	pop af
	jr Logged_0x1C6C3

Logged_0x1C6F4:
	ld hl,$DC88

Logged_0x1C6F7:
	add hl,de
	ld a,[hl]
	ld hl,$DC23
	and a
	jr z,Logged_0x1C70B
	cp $01
	jr z,Unknown_0x1C719
	jr Unknown_0x1C727

Logged_0x1C705:
	ld hl,$DCF4
	jp Logged_0x1C6F7

Logged_0x1C70B:
	ld a,e
	and a
	jr z,Logged_0x1C735
	cp $01
	jr z,Logged_0x1C73A
	cp $02
	jr z,Logged_0x1C73F
	jr Logged_0x1C744

Unknown_0x1C719:
	ld a,e
	and a
	jr z,Unknown_0x1C749
	cp $01
	jr z,Unknown_0x1C74E
	cp $02
	jr z,Unknown_0x1C753
	jr Unknown_0x1C758

Unknown_0x1C727:
	ld a,e
	and a
	jr z,Unknown_0x1C75D
	cp $01
	jr z,Unknown_0x1C762
	cp $02
	jr z,Unknown_0x1C767
	jr Unknown_0x1C76C

Logged_0x1C735:
	set 0,[hl]
	set 4,[hl]
	ret

Logged_0x1C73A:
	set 1,[hl]
	set 5,[hl]
	ret

Logged_0x1C73F:
	set 2,[hl]
	set 6,[hl]
	ret

Logged_0x1C744:
	set 3,[hl]
	set 7,[hl]
	ret

Unknown_0x1C749:
	set 0,[hl]
	res 4,[hl]
	ret

Unknown_0x1C74E:
	set 1,[hl]
	res 5,[hl]
	ret

Unknown_0x1C753:
	set 2,[hl]
	res 6,[hl]
	ret

Unknown_0x1C758:
	set 3,[hl]
	res 7,[hl]
	ret

Unknown_0x1C75D:
	res 0,[hl]
	set 4,[hl]
	ret

Unknown_0x1C762:
	res 1,[hl]
	set 5,[hl]
	ret

Unknown_0x1C767:
	res 2,[hl]
	set 6,[hl]
	ret

Unknown_0x1C76C:
	res 3,[hl]
	set 7,[hl]
	ret

Logged_0x1C771:
	ld hl,$DC6C
	add hl,de
	ld a,[hl]
	ld c,a
	ld hl,$DC7C
	add hl,de
	ld a,[hl]
	ld h,a
	call Logged_0x1CBDC
	ld a,h
	and a
	jr nz,Logged_0x1C786
	ld a,$01

Logged_0x1C786:
	ld hl,$DC74
	add hl,de
	ld [hl],a
	ret

Logged_0x1C78C:
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	and a
	jp z,Logged_0x1C832
	ld hl,$DC50
	add hl,de
	ld a,[hl]
	ld hl,$DC54
	add hl,de
	cp [hl]
	jr nz,Logged_0x1C7A8
	ld a,$02
	ld hl,$DCC4
	add hl,de
	ld [hl],a

Logged_0x1C7A8:
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	cp $01
	jp z,Logged_0x1C832
	ld hl,$DCC8
	add hl,de
	ld a,[hl]
	ld b,a
	inc [hl]
	ld hl,$DC58
	add hl,de
	ld a,[hl]
	ld c,a
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	cp $02
	jr z,Logged_0x1C7CD
	ld a,c
	rlca
	add a,$02
	ld c,a

Logged_0x1C7CD:
	ld a,c
	cp b
	jr nz,Logged_0x1C7E4
	xor a
	ld hl,$DCC8
	add hl,de
	ld [hl],a
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	cp $04
	jr nz,Logged_0x1C7E2
	ld a,$02

Logged_0x1C7E2:
	inc a
	ld [hl],a

Logged_0x1C7E4:
	ld hl,$DC3C
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DC40
	add hl,de
	ld a,[hl]
	ld c,a
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	cp $03
	jr z,Logged_0x1C803
	ld hl,$DC5C
	add hl,de
	ld a,[hl]
	ld l,a
	xor a
	ld h,a
	jr Logged_0x1C811

Logged_0x1C803:
	push bc
	ld hl,$DC5C
	add hl,de
	ld a,[hl]
	ld b,a
	xor a
	sub b
	ld l,a
	ld a,$FF
	ld h,a
	pop bc

Logged_0x1C811:
	add hl,bc
	ld b,h
	ld c,l
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	push af
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld l,a
	pop af
	ld h,a
	add hl,bc
	ld a,h
	ld c,l
	ld hl,$DC34
	add hl,de
	ld [hl],a
	ld a,c
	ld hl,$DC38
	add hl,de
	ld [hl],a
	jr Logged_0x1C846

Logged_0x1C832:
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	ld hl,$DC34
	add hl,de
	ld [hl],a
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld hl,$DC38
	add hl,de
	ld [hl],a

Logged_0x1C846:
	ret

Logged_0x1C847:
	ld hl,$DC90
	add hl,de
	ld a,[hl]
	and a
	ret z
	ld hl,$DC60
	add hl,de
	ld a,[hl]
	ld hl,$DC50
	add hl,de
	sub [hl]
	ret nc
	xor $FF
	ld [$DC26],a
	ld hl,$DC90
	add hl,de
	sub [hl]
	jr nc,Logged_0x1C8BD
	ld hl,$DC64
	add hl,de
	ld a,[hl]
	sub $70
	call Logged_0x1C590
	push bc
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld c,a
	pop hl
	call Logged_0x1C8C9
	push hl
	ld hl,$DC90
	add hl,de
	ld a,[hl]
	ld c,a
	pop hl
	call Logged_0x1CBEA
	ld c,l
	ld a,[$DC26]
	ld h,a
	call Logged_0x1CBDC
	push hl
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld l,a
	ld h,b
	pop bc
	ld a,[$DC27]
	and a
	jr z,Unknown_0x1C8AD
	call Logged_0x1C8E2
	jr Logged_0x1C8AE

Unknown_0x1C8AD:
	add hl,bc

Logged_0x1C8AE:
	ld b,h
	ld c,l

Logged_0x1C8B0:
	ld hl,$DC28
	add hl,de
	ld a,b
	ld [hl],a
	ld hl,$DC2C
	add hl,de
	ld a,c
	ld [hl],a
	ret

Logged_0x1C8BD:
	ld hl,$DC64
	add hl,de
	ld a,[hl]
	sub $70
	call Logged_0x1C590
	jr Logged_0x1C8B0

Logged_0x1C8C9:
	push hl
	call Logged_0x1C8E2
	jr nc,Unknown_0x1C8DC
	pop hl
	ld a,c
	sub l
	ld l,a
	ld a,b
	sbc a,h
	ld h,a
	ld a,$01
	ld [$DC27],a
	ret

Unknown_0x1C8DC:
	pop af
	xor a
	ld [$DC27],a
	ret

Logged_0x1C8E2:
	ld a,l
	sub c
	ld l,a
	ld a,h
	sbc a,b
	ld h,a
	ret

Logged_0x1C8E9:
	ld a,e
	and a
	jr z,Logged_0x1C8FA
	cp $01
	jp z,Logged_0x1C97F
	cp $02
	jp z,Logged_0x1C9BB
	jp Logged_0x1CA6A

Logged_0x1C8FA:
	ld a,[$DCD0]
	and a
	ret nz
	ld a,[$DC38]
	ld [$FF00+$13],a
	ld a,[$DC34]
	and $07
	push af
	ld a,[$DCA4]
	and a
	jr z,Logged_0x1C91D
	xor a
	ld [$DCA4],a
	ld a,[$DC30]
	swap a
	rlca
	rlca
	ld [$FF00+$11],a

Logged_0x1C91D:
	ld a,[$DCA8]
	and a
	jr z,Logged_0x1C931
	xor a
	ld [$DCA8],a
	ld a,[$DCA0]
	call Logged_0x1C936
	ld [$FF00+$12],a
	ld a,$80

Logged_0x1C931:
	pop bc
	or b
	ld [$FF00+$14],a
	ret

Logged_0x1C936:
	ld [$DC26],a
	ld a,[$DC0F]
	and a
	jr z,Logged_0x1C95B
	ld a,[$DC26]
	and $0F
	ld c,a
	ld hl,$495F
	add hl,bc
	ld a,[hl]
	push af
	ld a,[$DC26]
	swap a
	and $0F
	ld c,a
	ld hl,$496F
	add hl,bc
	ld a,[hl]
	pop bc
	or b
	ret

Logged_0x1C95B:
	ld a,[$DC26]
	ret

LoggedData_0x1C95F:
INCBIN "baserom.gb", $1C95F, $1C967 - $1C95F

UnknownData_0x1C967:
INCBIN "baserom.gb", $1C967, $1C968 - $1C967

LoggedData_0x1C968:
INCBIN "baserom.gb", $1C968, $1C96D - $1C968

UnknownData_0x1C96D:
INCBIN "baserom.gb", $1C96D, $1C96E - $1C96D

LoggedData_0x1C96E:
INCBIN "baserom.gb", $1C96E, $1C979 - $1C96E

UnknownData_0x1C979:
INCBIN "baserom.gb", $1C979, $1C97F - $1C979

Logged_0x1C97F:
	ld a,[$DCD1]
	and a
	ret nz
	ld a,[$DC39]
	ld [$FF00+$18],a
	ld a,[$DC35]
	and $07
	push af
	ld a,[$DCA5]
	and a
	jr z,Logged_0x1C9A2
	xor a
	ld [$DCA5],a
	ld a,[$DC31]
	swap a
	rlca
	rlca
	ld [$FF00+$16],a

Logged_0x1C9A2:
	ld a,[$DCA9]
	and a
	jr z,Logged_0x1C9B6
	xor a
	ld [$DCA9],a
	ld a,[$DCA1]
	call Logged_0x1C936
	ld [$FF00+$17],a
	ld a,$80

Logged_0x1C9B6:
	pop bc
	or b
	ld [$FF00+$19],a
	ret

Logged_0x1C9BB:
	call Logged_0x1CA42
	ld a,[$DCD2]
	and a
	ret nz
	ld a,[$DC3A]
	ld [$FF00+$1D],a
	ld a,[$DC36]
	and $07
	push af
	ld a,[$DCA6]
	and a
	jr z,Logged_0x1C9DE
	xor a
	ld [$DCA6],a
	ld a,[$DCA2]
	call Logged_0x1CA0C

Logged_0x1C9DE:
	ld a,[$DCAA]
	and a
	jr z,Logged_0x1CA07
	xor a
	ld [$DCAA],a
	xor a
	call Logged_0x1CA0C
	ld [$FF00+$1A],a

Logged_0x1C9EE:
	ld a,[$FF00+$26]
	rrca
	rrca
	rrca
	jr c,Logged_0x1C9EE
	ld a,$80
	ld [$FF00+$1A],a
	ld a,[$DC13]
	call Logged_0x1CEF7
	ld a,[$DCA2]
	call Logged_0x1CA0C
	ld a,$80

Logged_0x1CA07:
	pop bc
	or b
	ld [$FF00+$1E],a
	ret

Logged_0x1CA0C:
	ld [$DC26],a
	ld a,[$DC0F]
	and a
	jr z,Logged_0x1CA27
	ld a,[$DC26]
	and a
	jr z,Logged_0x1CA3F
	cp $01
	jr z,Logged_0x1CA3F
	cp $02
	jr z,Logged_0x1CA39
	cp $03
	jr z,Logged_0x1CA3D

Logged_0x1CA27:
	ld a,[$DC26]
	and a
	jr z,Logged_0x1CA3F
	cp $01
	jr z,Logged_0x1CA39
	cp $02
	jr z,Logged_0x1CA3D
	ld a,$20
	jr Logged_0x1CA3F

Logged_0x1CA39:
	ld a,$60
	jr Logged_0x1CA3F

Logged_0x1CA3D:
	ld a,$40

Logged_0x1CA3F:
	ld [$FF00+$1C],a
	ret

Logged_0x1CA42:
	ld a,[$DCBE]
	and a
	ret nz
	ld a,[$DC86]
	and a
	ret z
	ld c,a
	ld hl,$DC50
	add hl,de
	ld a,[hl]
	ret z
	dec a
	ld h,$00
	ld l,a
	call Logged_0x1CBEA
	ld a,[$DC18]
	sub l
	jr nc,Logged_0x1CA61
	xor a

Logged_0x1CA61:
	ld [$DCA2],a
	ld a,$01
	ld [$DCA6],a
	ret

Logged_0x1CA6A:
	ld a,[$DCD3]
	and a
	ret nz
	ld a,[$DCA7]
	and a
	jr z,Logged_0x1CA7E
	xor a
	ld [$DCA7],a
	ld a,[$DC1A]
	ld [$FF00+$22],a

Logged_0x1CA7E:
	ld a,[$DCAB]
	and a
	ret z
	xor a
	ld [$DCAB],a
	ld a,[$DCA3]
	call Logged_0x1C936
	ld [$FF00+$21],a
	ld a,$80
	ld [$FF00+$23],a
	ret

Logged_0x1CA94:
	call Logged_0x1CA9F
	call Logged_0x1CAA7
	call Logged_0x1CAAF
	jr Logged_0x1CAB9

Logged_0x1CA9F:
	ld a,[$DCD0]
	and a
	ret nz
	ld [$FF00+$12],a
	ret

Logged_0x1CAA7:
	ld a,[$DCD1]
	and a
	ret nz
	ld [$FF00+$17],a
	ret

Logged_0x1CAAF:
	ld a,[$DCD2]
	and a
	ret nz
	ld [$FF00+$1C],a
	ld [$FF00+$1A],a
	ret

Logged_0x1CAB9:
	ld a,[$DCD3]
	and a
	ret nz
	ld [$FF00+$21],a
	ret

Logged_0x1CAC1:
	ld a,[$DC11]
	rlca
	ld c,a
	ld b,$00
	ld a,[$DC16]
	ld h,a
	ld a,[$DC17]
	ld l,a
	add hl,bc
	ld a,[hli]
	and a
	jr z,Logged_0x1CAF4
	ld b,a
	ld a,[hl]
	ld c,a
	ld a,e
	rlca
	ld l,a
	ld h,$00
	add hl,bc
	ld a,[hli]
	and a
	jr z,Unknown_0x1CAED
	ld [$DC14],a
	ld a,[hl]
	ld [$DC15],a
	ld a,$01
	jr Logged_0x1CAEE

Unknown_0x1CAED:
	xor a

Logged_0x1CAEE:
	ld hl,$DCAC
	add hl,de
	ld [hl],a
	ret

Logged_0x1CAF4:
	ld [$DC14],a
	ld a,[hl]
	ld [$DC15],a
	ret

Logged_0x1CAFC:
	ld a,[$DC14]
	and a
	ret nz
	ld a,[$DC15]
	and a
	jr nz,Logged_0x1CB16
	xor a
	ld [$DC10],a
	ld [$DC11],a
	ld hl,$DC9C
	add hl,de
	ld [hl],a
	pop af
	pop af
	ret

Logged_0x1CB16:
	ld a,[$DC15]
	ld b,a
	ld a,[$DC11]
	sub b
	ld [$DC11],a
	xor a
	ld hl,$DC9C
	add hl,de
	ld [hl],a
	jp Logged_0x1CAC1

Logged_0x1CB2A:
	call Logged_0x1CA94
	xor a
	ld [$DC11],a
	ld [$DC12],a
	ld a,$FF
	ld [$DC23],a
	ld a,$FF
	ld [$DC6C],a
	ld [$DC6D],a
	ld [$DC6E],a
	ld [$DC6F],a
	ld a,[$D23B]
	cp $01
	jr nz,Logged_0x1CB85
	ld a,[$DC10]
	cp $0D
	jr nz,Logged_0x1CB85
	ld d,$00
	ld e,$00

Unknown_0x1CB59:
	xor a
	ld hl,$DC70
	add hl,de
	ld [hl],a
	ld hl,$DC8C
	add hl,de
	ld [hl],a
	ld hl,$DC90
	add hl,de
	ld [hl],a
	ld hl,$DC94
	add hl,de
	ld [hl],a
	ld hl,$DC9C
	add hl,de
	ld [hl],a
	ld hl,$DCC0
	add hl,de
	ld [hl],a
	ld hl,$DCC4
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $04
	jp nz,Unknown_0x1CB59
	ret

Logged_0x1CB85:
	ld d,$00
	ld e,$00

Logged_0x1CB89:
	xor a
	ld hl,$DC70
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $5C
	jp nz,Logged_0x1CB89
	ld d,$00
	ld e,$00

Logged_0x1CB9A:
	xor a
	ld hl,$DCC4
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $04
	jp nz,Logged_0x1CB9A
	ret

Logged_0x1CBA8:
	ld a,[$DC18]
	ld [$DCA2],a
	xor a
	ld hl,$DCB8
	add hl,de
	ld [hl],a
	ld hl,$DCC8
	add hl,de
	ld [hl],a
	ld hl,$DCBC
	add hl,de
	ld [hl],a
	ld hl,$DC44
	add hl,de
	ld [hl],a
	ld hl,$DCB0
	add hl,de
	ld [hl],a
	inc a
	ld hl,$DC50
	add hl,de
	ld [hl],a
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	and a
	ret z
	cp $01
	ret z
	ld a,$01
	ld [hl],a
	ret

Logged_0x1CBDC:
	ld b,$00
	ld l,$00
	ld a,$08

Logged_0x1CBE2:
	add hl,hl
	jr nc,Logged_0x1CBE6
	add hl,bc

Logged_0x1CBE6:
	dec a
	jr nz,Logged_0x1CBE2
	ret

Logged_0x1CBEA:
	ld b,$10
	xor a
	rl l
	rl h

Logged_0x1CBF1:
	rla
	jr c,Logged_0x1CBF7
	cp c
	jr c,Logged_0x1CBFA

Logged_0x1CBF7:
	sub c
	scf
	ccf

Logged_0x1CBFA:
	ccf
	rl l
	rl h
	dec b
	jr nz,Logged_0x1CBF1
	ld h,a
	ret

Logged_0x1CC04:
	call Logged_0x1CC09
	jr Logged_0x1CC63

Logged_0x1CC09:
	ld d,$00
	ld e,$00

Logged_0x1CC0D:
	ld hl,$DCCC
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x1CC5C
	push af
	dec a
	rlca
	ld c,a
	ld b,$00
	ld hl,$510D
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ld a,[bc]
	ld c,a
	ld b,$00
	ld a,$01
	ld hl,$DCD8
	add hl,bc
	ld [hl],a
	pop af
	ld hl,$DCD0
	add hl,bc
	ld [hl],a
	ld hl,$DCF8
	add hl,bc
	ld a,[hl]
	and a
	jr nz,Logged_0x1CC41
	ld hl,$DCF4
	add hl,bc
	ld [hl],a

Logged_0x1CC41:
	xor a
	ld hl,$DCFC
	add hl,bc
	ld [hl],a
	ld hl,$DCF8
	add hl,bc
	ld [hl],a
	ld hl,$DCCC
	add hl,de
	ld [hl],a
	ld hl,$DCD4
	add hl,bc
	ld [hl],a
	ld hl,$DCF0
	add hl,bc
	ld [hl],a
	ret

Logged_0x1CC5C:
	inc e
	ld a,e
	cp $04
	jr nz,Logged_0x1CC0D
	ret

Logged_0x1CC63:
	ld d,$00
	ld e,$00

Logged_0x1CC67:
	ld hl,$DCD0
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x1CC78
	call Logged_0x1CC8F
	call Logged_0x1CDFC
	call Logged_0x1C705

Logged_0x1CC78:
	inc e
	ld a,e
	cp $04
	jr nz,Logged_0x1CC67
	ld a,[$DC23]
	ld [$FF00+$25],a
	call Logged_0x1CE2C
	call Logged_0x1CE5B
	call Logged_0x1CE8A
	jp Logged_0x1CED9

Logged_0x1CC8F:
	xor a
	ld hl,$DCA8
	add hl,de
	ld [hl],a
	ld hl,$DCD0
	add hl,de
	ld a,[hl]
	dec a
	rlca
	ld c,a
	ld b,$00
	ld hl,$510D
	add hl,bc
	ld a,[hli]
	ld [$DC20],a
	ld a,[hl]
	ld [$DC21],a

Logged_0x1CCAB:
	call Logged_0x1CCC8
	ld b,a
	sub $70
	jr c,Logged_0x1CCDB
	ld a,b
	sub $F0
	jr c,Logged_0x1CD07
	ld a,b
	sub $FF
	jr c,Logged_0x1CD27
	call Logged_0x1CCC2
	jr Logged_0x1CCAB

Logged_0x1CCC2:
	ld hl,$DCD8
	add hl,de
	inc [hl]
	ret

Logged_0x1CCC8:
	ld a,[$DC20]
	ld b,a
	ld a,[$DC21]
	ld c,a
	ld hl,$DCD8
	add hl,de
	ld a,[hl]
	ld l,a
	ld h,$00
	add hl,bc
	ld a,[hl]
	ret

Logged_0x1CCDB:
	ld hl,$DCD4
	add hl,de
	ld a,[hl]
	and a
	jr nz,Logged_0x1CD01
	ld a,b
	ld hl,$DCD4
	add hl,de
	ld [hl],a
	ld hl,$DCFC
	add hl,de
	ld a,[hl]
	and a
	jr nz,Logged_0x1CCF9
	ld a,$01

Logged_0x1CCF3:
	ld hl,$DCDC
	add hl,de
	ld [hl],a
	ret

Logged_0x1CCF9:
	xor a
	ld hl,$DCFC
	add hl,de
	ld [hl],a
	jr Logged_0x1CCF3

Logged_0x1CD01:
	dec a
	ld [hl],a
	and a
	ret nz
	jr Logged_0x1CCC2

Logged_0x1CD07:
	ld a,b
	sub $70
	rlca
	ld c,a
	ld b,$00
	ld hl,$4FD3
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ld a,b
	ld hl,$DCE0
	add hl,de
	ld [hl],a
	ld a,c
	ld hl,$DCE4
	add hl,de
	ld [hl],a
	call Logged_0x1CCC2
	jr Logged_0x1CCAB

Logged_0x1CD27:
	ld a,b
	sub $F0
	rlca
	ld c,a
	ld b,$00
	ld hl,$4D36
	add hl,bc
	ld a,[hli]
	ld l,[hl]
	ld h,a
	jp hl

LoggedData_0x1CD36:
INCBIN "baserom.gb", $1CD36, $1CD44 - $1CD36

UnknownData_0x1CD44:
INCBIN "baserom.gb", $1CD44, $1CD4A - $1CD44

LoggedData_0x1CD4A:
INCBIN "baserom.gb", $1CD4A, $1CD4C - $1CD4A
	call Logged_0x1CCC2
	ld hl,$DCFC
	add hl,de
	ld a,$01
	ld [hl],a
	call Logged_0x1CCC8
	jp Logged_0x1CCAB
	xor a
	ld hl,$DCD0
	add hl,de
	ld [hl],a
	ld hl,$DCD8
	add hl,de
	ld [hl],a
	ld hl,$DCD4
	add hl,de
	ld [hl],a
	ld hl,$DCFC
	add hl,de
	ld a,[hl]
	and a
	ret nz
	jp Logged_0x1C57C
	call Logged_0x1CCC2
	call Logged_0x1CCC8
	ld hl,$DCEC
	add hl,de
	ld [hl],a
	call Logged_0x1CCC2
	jp Logged_0x1CCAB
	call Logged_0x1CCC2
	call Logged_0x1CCC8
	ld hl,$DCE8
	add hl,de
	ld [hl],a
	call Logged_0x1CCC2
	jp Logged_0x1CCAB
	call Logged_0x1CCC2
	call Logged_0x1CCC8
	ld [$DC25],a
	call Logged_0x1CCC2
	jp Logged_0x1CCAB
	call Logged_0x1CCC2
	call Logged_0x1CCC8
	ld [$DC1B],a
	call Logged_0x1CCC2
	jp Logged_0x1CCAB
	call Logged_0x1CCC2
	call Logged_0x1CCC8
	ld [$DC19],a
	call Logged_0x1CCC2
	jp Logged_0x1CCAB
	call Logged_0x1CCC2
	call Logged_0x1CCC8
	ld hl,$DCF0
	add hl,de
	ld [hl],a
	call Logged_0x1CCC2
	jp Logged_0x1CCAB

UnknownData_0x1CDD6:
INCBIN "baserom.gb", $1CDD6, $1CDFC - $1CDD6

Logged_0x1CDFC:
	ld hl,$DCF0
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x1CE2B
	ld l,a
	sub $80
	jr nc,Logged_0x1CE0D
	ld h,$00
	jr Logged_0x1CE0F

Logged_0x1CE0D:
	ld h,$FF

Logged_0x1CE0F:
	push hl
	ld hl,$DCE0
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DCE4
	add hl,de
	ld a,[hl]
	ld c,a
	pop hl
	add hl,bc
	ld b,l
	ld a,h
	ld hl,$DCE0
	add hl,de
	ld [hl],a
	ld a,b
	ld hl,$DCE4
	add hl,de
	ld [hl],a

Logged_0x1CE2B:
	ret

Logged_0x1CE2C:
	ld a,[$DCD0]
	and a
	ret z
	ld a,[$DCE4]
	ld [$FF00+$13],a
	ld a,[$DCE0]
	and $07
	push af
	ld a,[$DCDC]
	and a
	jr z,Logged_0x1CE56
	xor a
	ld [$DCDC],a
	ld a,[$DCEC]
	swap a
	rlca
	rlca
	ld [$FF00+$11],a
	ld a,[$DCE8]
	ld [$FF00+$12],a
	ld a,$80

Logged_0x1CE56:
	pop bc
	or b
	ld [$FF00+$14],a
	ret

Logged_0x1CE5B:
	ld a,[$DCD1]
	and a
	ret z
	ld a,[$DCE5]
	ld [$FF00+$18],a
	ld a,[$DCE1]
	and $07
	push af
	ld a,[$DCDD]
	and a
	jr z,Logged_0x1CE85
	xor a
	ld [$DCDD],a
	ld a,[$DCED]
	swap a
	rlca
	rlca
	ld [$FF00+$16],a
	ld a,[$DCE9]
	ld [$FF00+$17],a
	ld a,$80

Logged_0x1CE85:
	pop bc
	or b
	ld [$FF00+$19],a
	ret

Logged_0x1CE8A:
	ld a,[$DCD2]
	and a
	ret z
	ld a,[$DCE6]
	ld [$FF00+$1D],a
	ld a,[$DCE2]
	and $07
	push af
	ld a,[$DCDE]
	and a
	jr z,Logged_0x1CED4
	xor a
	ld [$DCDE],a
	ld a,[$DC19]
	and a
	jr z,Logged_0x1CEBC
	cp $01
	jr z,Logged_0x1CEB6
	cp $02
	jr z,Logged_0x1CEBA
	ld a,$20
	jr Logged_0x1CEBC

Logged_0x1CEB6:
	ld a,$60
	jr Logged_0x1CEBC

Logged_0x1CEBA:
	ld a,$40

Logged_0x1CEBC:
	ld [$FF00+$1C],a

Logged_0x1CEBE:
	xor a
	ld [$FF00+$1A],a
	ld a,[$FF00+$26]
	rrca
	rrca
	rrca
	jr c,Logged_0x1CEBE
	ld a,[$DC25]
	call Logged_0x1CEF7
	ld a,$80
	ld [$FF00+$1A],a
	ld a,$80

Logged_0x1CED4:
	pop bc
	or b
	ld [$FF00+$1E],a
	ret

Logged_0x1CED9:
	ld a,[$DCD3]
	and a
	ret z
	ld a,[$DCDF]
	and a
	jr z,Logged_0x1CEF4
	xor a
	ld [$DCDF],a
	ld a,[$DCEB]
	ld [$FF00+$21],a
	ld a,[$DC1B]
	ld [$FF00+$22],a
	ld a,$80

Logged_0x1CEF4:
	ld [$FF00+$23],a
	ret

Logged_0x1CEF7:
	rlca
	ld c,a
	ld b,$00
	ld hl,$5AF9
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld l,a
	ld h,b
	ld bc,$FF30
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hl]
	ld [bc],a
	ret

LoggedData_0x1CF37:
INCBIN "baserom.gb", $1CF37, $1CF39 - $1CF37

UnknownData_0x1CF39:
INCBIN "baserom.gb", $1CF39, $1CF43 - $1CF39

LoggedData_0x1CF43:
INCBIN "baserom.gb", $1CF43, $1CF47 - $1CF43

UnknownData_0x1CF47:
INCBIN "baserom.gb", $1CF47, $1CF49 - $1CF47

LoggedData_0x1CF49:
INCBIN "baserom.gb", $1CF49, $1CF4B - $1CF49

UnknownData_0x1CF4B:
INCBIN "baserom.gb", $1CF4B, $1CF4D - $1CF4B

LoggedData_0x1CF4D:
INCBIN "baserom.gb", $1CF4D, $1CF4F - $1CF4D

UnknownData_0x1CF4F:
INCBIN "baserom.gb", $1CF4F, $1CF50 - $1CF4F

LoggedData_0x1CF50:
INCBIN "baserom.gb", $1CF50, $1CF55 - $1CF50

UnknownData_0x1CF55:
INCBIN "baserom.gb", $1CF55, $1CF56 - $1CF55

LoggedData_0x1CF56:
INCBIN "baserom.gb", $1CF56, $1CF58 - $1CF56

UnknownData_0x1CF58:
INCBIN "baserom.gb", $1CF58, $1CF94 - $1CF58

LoggedData_0x1CF94:
INCBIN "baserom.gb", $1CF94, $1CF97 - $1CF94

UnknownData_0x1CF97:
INCBIN "baserom.gb", $1CF97, $1CF9A - $1CF97

LoggedData_0x1CF9A:
INCBIN "baserom.gb", $1CF9A, $1CF9C - $1CF9A

UnknownData_0x1CF9C:
INCBIN "baserom.gb", $1CF9C, $1CF9F - $1CF9C

LoggedData_0x1CF9F:
INCBIN "baserom.gb", $1CF9F, $1CFA1 - $1CF9F

UnknownData_0x1CFA1:
INCBIN "baserom.gb", $1CFA1, $1CFA4 - $1CFA1

LoggedData_0x1CFA4:
INCBIN "baserom.gb", $1CFA4, $1CFA7 - $1CFA4

UnknownData_0x1CFA7:
INCBIN "baserom.gb", $1CFA7, $1CFB2 - $1CFA7

LoggedData_0x1CFB2:
INCBIN "baserom.gb", $1CFB2, $1CFB3 - $1CFB2

UnknownData_0x1CFB3:
INCBIN "baserom.gb", $1CFB3, $1CFB4 - $1CFB3

LoggedData_0x1CFB4:
INCBIN "baserom.gb", $1CFB4, $1CFB5 - $1CFB4

UnknownData_0x1CFB5:
INCBIN "baserom.gb", $1CFB5, $1CFBB - $1CFB5

LoggedData_0x1CFBB:
INCBIN "baserom.gb", $1CFBB, $1CFBC - $1CFBB

UnknownData_0x1CFBC:
INCBIN "baserom.gb", $1CFBC, $1CFCA - $1CFBC

LoggedData_0x1CFCA:
INCBIN "baserom.gb", $1CFCA, $1CFD1 - $1CFCA

UnknownData_0x1CFD1:
INCBIN "baserom.gb", $1CFD1, $1CFD5 - $1CFD1

LoggedData_0x1CFD5:
INCBIN "baserom.gb", $1CFD5, $1CFD7 - $1CFD5

UnknownData_0x1CFD7:
INCBIN "baserom.gb", $1CFD7, $1CFD9 - $1CFD7

LoggedData_0x1CFD9:
INCBIN "baserom.gb", $1CFD9, $1D041 - $1CFD9

UnknownData_0x1D041:
INCBIN "baserom.gb", $1D041, $1D043 - $1D041

LoggedData_0x1D043:
INCBIN "baserom.gb", $1D043, $1D04F - $1D043

UnknownData_0x1D04F:
INCBIN "baserom.gb", $1D04F, $1D051 - $1D04F

LoggedData_0x1D051:
INCBIN "baserom.gb", $1D051, $1D053 - $1D051

UnknownData_0x1D053:
INCBIN "baserom.gb", $1D053, $1D055 - $1D053

LoggedData_0x1D055:
INCBIN "baserom.gb", $1D055, $1D05D - $1D055

UnknownData_0x1D05D:
INCBIN "baserom.gb", $1D05D, $1D063 - $1D05D

LoggedData_0x1D063:
INCBIN "baserom.gb", $1D063, $1D065 - $1D063

UnknownData_0x1D065:
INCBIN "baserom.gb", $1D065, $1D0FB - $1D065

LoggedData_0x1D0FB:
INCBIN "baserom.gb", $1D0FB, $1D129 - $1D0FB

UnknownData_0x1D129:
INCBIN "baserom.gb", $1D129, $1D12D - $1D129

LoggedData_0x1D12D:
INCBIN "baserom.gb", $1D12D, $1D133 - $1D12D

UnknownData_0x1D133:
INCBIN "baserom.gb", $1D133, $1D13B - $1D133

LoggedData_0x1D13B:
INCBIN "baserom.gb", $1D13B, $1D14D - $1D13B

UnknownData_0x1D14D:
INCBIN "baserom.gb", $1D14D, $1D151 - $1D14D

LoggedData_0x1D151:
INCBIN "baserom.gb", $1D151, $1D167 - $1D151

UnknownData_0x1D167:
INCBIN "baserom.gb", $1D167, $1D169 - $1D167

LoggedData_0x1D169:
INCBIN "baserom.gb", $1D169, $1D177 - $1D169

UnknownData_0x1D177:
INCBIN "baserom.gb", $1D177, $1D179 - $1D177

LoggedData_0x1D179:
INCBIN "baserom.gb", $1D179, $1D17D - $1D179

UnknownData_0x1D17D:
INCBIN "baserom.gb", $1D17D, $1D17F - $1D17D

LoggedData_0x1D17F:
INCBIN "baserom.gb", $1D17F, $1D183 - $1D17F

UnknownData_0x1D183:
INCBIN "baserom.gb", $1D183, $1D185 - $1D183

LoggedData_0x1D185:
INCBIN "baserom.gb", $1D185, $1D187 - $1D185

UnknownData_0x1D187:
INCBIN "baserom.gb", $1D187, $1D189 - $1D187

LoggedData_0x1D189:
INCBIN "baserom.gb", $1D189, $1D18B - $1D189

UnknownData_0x1D18B:
INCBIN "baserom.gb", $1D18B, $1D191 - $1D18B

LoggedData_0x1D191:
INCBIN "baserom.gb", $1D191, $1D19D - $1D191

UnknownData_0x1D19D:
INCBIN "baserom.gb", $1D19D, $1D19F - $1D19D

LoggedData_0x1D19F:
INCBIN "baserom.gb", $1D19F, $1D1A3 - $1D19F

UnknownData_0x1D1A3:
INCBIN "baserom.gb", $1D1A3, $1D1AF - $1D1A3

LoggedData_0x1D1AF:
INCBIN "baserom.gb", $1D1AF, $1D1B1 - $1D1AF

UnknownData_0x1D1B1:
INCBIN "baserom.gb", $1D1B1, $1D1BD - $1D1B1

LoggedData_0x1D1BD:
INCBIN "baserom.gb", $1D1BD, $1D2B5 - $1D1BD

UnknownData_0x1D2B5:
INCBIN "baserom.gb", $1D2B5, $1D2DE - $1D2B5

LoggedData_0x1D2DE:
INCBIN "baserom.gb", $1D2DE, $1D2EA - $1D2DE

UnknownData_0x1D2EA:
INCBIN "baserom.gb", $1D2EA, $1D303 - $1D2EA

LoggedData_0x1D303:
INCBIN "baserom.gb", $1D303, $1D33A - $1D303

UnknownData_0x1D33A:
INCBIN "baserom.gb", $1D33A, $1D39C - $1D33A

LoggedData_0x1D39C:
INCBIN "baserom.gb", $1D39C, $1D3AB - $1D39C

UnknownData_0x1D3AB:
INCBIN "baserom.gb", $1D3AB, $1D3B2 - $1D3AB

LoggedData_0x1D3B2:
INCBIN "baserom.gb", $1D3B2, $1D44B - $1D3B2

UnknownData_0x1D44B:
INCBIN "baserom.gb", $1D44B, $1D493 - $1D44B

LoggedData_0x1D493:
INCBIN "baserom.gb", $1D493, $1D56A - $1D493

UnknownData_0x1D56A:
INCBIN "baserom.gb", $1D56A, $1D574 - $1D56A

LoggedData_0x1D574:
INCBIN "baserom.gb", $1D574, $1D60C - $1D574

UnknownData_0x1D60C:
INCBIN "baserom.gb", $1D60C, $1D629 - $1D60C

LoggedData_0x1D629:
INCBIN "baserom.gb", $1D629, $1D63D - $1D629

UnknownData_0x1D63D:
INCBIN "baserom.gb", $1D63D, $1D657 - $1D63D

LoggedData_0x1D657:
INCBIN "baserom.gb", $1D657, $1D679 - $1D657

UnknownData_0x1D679:
INCBIN "baserom.gb", $1D679, $1D683 - $1D679

LoggedData_0x1D683:
INCBIN "baserom.gb", $1D683, $1D68F - $1D683

UnknownData_0x1D68F:
INCBIN "baserom.gb", $1D68F, $1D69F - $1D68F

LoggedData_0x1D69F:
INCBIN "baserom.gb", $1D69F, $1D6AD - $1D69F

UnknownData_0x1D6AD:
INCBIN "baserom.gb", $1D6AD, $1D6CD - $1D6AD

LoggedData_0x1D6CD:
INCBIN "baserom.gb", $1D6CD, $1D77D - $1D6CD

UnknownData_0x1D77D:
INCBIN "baserom.gb", $1D77D, $1D789 - $1D77D

LoggedData_0x1D789:
INCBIN "baserom.gb", $1D789, $1D7A3 - $1D789

UnknownData_0x1D7A3:
INCBIN "baserom.gb", $1D7A3, $1D813 - $1D7A3

LoggedData_0x1D813:
INCBIN "baserom.gb", $1D813, $1D817 - $1D813

UnknownData_0x1D817:
INCBIN "baserom.gb", $1D817, $1D857 - $1D817

LoggedData_0x1D857:
INCBIN "baserom.gb", $1D857, $1D85F - $1D857

UnknownData_0x1D85F:
INCBIN "baserom.gb", $1D85F, $1D867 - $1D85F

LoggedData_0x1D867:
INCBIN "baserom.gb", $1D867, $1D86D - $1D867

UnknownData_0x1D86D:
INCBIN "baserom.gb", $1D86D, $1D86F - $1D86D

LoggedData_0x1D86F:
INCBIN "baserom.gb", $1D86F, $1D879 - $1D86F

UnknownData_0x1D879:
INCBIN "baserom.gb", $1D879, $1D87B - $1D879

LoggedData_0x1D87B:
INCBIN "baserom.gb", $1D87B, $1D883 - $1D87B

UnknownData_0x1D883:
INCBIN "baserom.gb", $1D883, $1D887 - $1D883

LoggedData_0x1D887:
INCBIN "baserom.gb", $1D887, $1D88B - $1D887

UnknownData_0x1D88B:
INCBIN "baserom.gb", $1D88B, $1D88F - $1D88B

LoggedData_0x1D88F:
INCBIN "baserom.gb", $1D88F, $1D893 - $1D88F

UnknownData_0x1D893:
INCBIN "baserom.gb", $1D893, $1D895 - $1D893

LoggedData_0x1D895:
INCBIN "baserom.gb", $1D895, $1D899 - $1D895

UnknownData_0x1D899:
INCBIN "baserom.gb", $1D899, $1D89D - $1D899

LoggedData_0x1D89D:
INCBIN "baserom.gb", $1D89D, $1D8AB - $1D89D

UnknownData_0x1D8AB:
INCBIN "baserom.gb", $1D8AB, $1D8AD - $1D8AB

LoggedData_0x1D8AD:
INCBIN "baserom.gb", $1D8AD, $1D8AF - $1D8AD

UnknownData_0x1D8AF:
INCBIN "baserom.gb", $1D8AF, $1D8C9 - $1D8AF

LoggedData_0x1D8C9:
INCBIN "baserom.gb", $1D8C9, $1D8D9 - $1D8C9

UnknownData_0x1D8D9:
INCBIN "baserom.gb", $1D8D9, $1D8DB - $1D8D9

LoggedData_0x1D8DB:
INCBIN "baserom.gb", $1D8DB, $1D8DD - $1D8DB

UnknownData_0x1D8DD:
INCBIN "baserom.gb", $1D8DD, $1D8E1 - $1D8DD

LoggedData_0x1D8E1:
INCBIN "baserom.gb", $1D8E1, $1D8E3 - $1D8E1

UnknownData_0x1D8E3:
INCBIN "baserom.gb", $1D8E3, $1D8ED - $1D8E3

LoggedData_0x1D8ED:
INCBIN "baserom.gb", $1D8ED, $1D8FB - $1D8ED

UnknownData_0x1D8FB:
INCBIN "baserom.gb", $1D8FB, $1D90F - $1D8FB

LoggedData_0x1D90F:
INCBIN "baserom.gb", $1D90F, $1D917 - $1D90F

UnknownData_0x1D917:
INCBIN "baserom.gb", $1D917, $1D919 - $1D917

LoggedData_0x1D919:
INCBIN "baserom.gb", $1D919, $1D929 - $1D919

UnknownData_0x1D929:
INCBIN "baserom.gb", $1D929, $1D92F - $1D929

LoggedData_0x1D92F:
INCBIN "baserom.gb", $1D92F, $1D93F - $1D92F

UnknownData_0x1D93F:
INCBIN "baserom.gb", $1D93F, $1D945 - $1D93F

LoggedData_0x1D945:
INCBIN "baserom.gb", $1D945, $1D94D - $1D945

UnknownData_0x1D94D:
INCBIN "baserom.gb", $1D94D, $1D955 - $1D94D

LoggedData_0x1D955:
INCBIN "baserom.gb", $1D955, $1D95D - $1D955

UnknownData_0x1D95D:
INCBIN "baserom.gb", $1D95D, $1D95F - $1D95D

LoggedData_0x1D95F:
INCBIN "baserom.gb", $1D95F, $1D965 - $1D95F

UnknownData_0x1D965:
INCBIN "baserom.gb", $1D965, $1D967 - $1D965

LoggedData_0x1D967:
INCBIN "baserom.gb", $1D967, $1D973 - $1D967

UnknownData_0x1D973:
INCBIN "baserom.gb", $1D973, $1D97D - $1D973

LoggedData_0x1D97D:
INCBIN "baserom.gb", $1D97D, $1D99F - $1D97D

UnknownData_0x1D99F:
INCBIN "baserom.gb", $1D99F, $1D9A3 - $1D99F

LoggedData_0x1D9A3:
INCBIN "baserom.gb", $1D9A3, $1D9AB - $1D9A3

UnknownData_0x1D9AB:
INCBIN "baserom.gb", $1D9AB, $1D9B7 - $1D9AB

LoggedData_0x1D9B7:
INCBIN "baserom.gb", $1D9B7, $1D9BB - $1D9B7

UnknownData_0x1D9BB:
INCBIN "baserom.gb", $1D9BB, $1DA03 - $1D9BB

LoggedData_0x1DA03:
INCBIN "baserom.gb", $1DA03, $1DA21 - $1DA03

UnknownData_0x1DA21:
INCBIN "baserom.gb", $1DA21, $1DA23 - $1DA21

LoggedData_0x1DA23:
INCBIN "baserom.gb", $1DA23, $1DA37 - $1DA23

UnknownData_0x1DA37:
INCBIN "baserom.gb", $1DA37, $1DA39 - $1DA37

LoggedData_0x1DA39:
INCBIN "baserom.gb", $1DA39, $1DA43 - $1DA39

UnknownData_0x1DA43:
INCBIN "baserom.gb", $1DA43, $1DA53 - $1DA43

LoggedData_0x1DA53:
INCBIN "baserom.gb", $1DA53, $1DA5B - $1DA53

UnknownData_0x1DA5B:
INCBIN "baserom.gb", $1DA5B, $1DA79 - $1DA5B

LoggedData_0x1DA79:
INCBIN "baserom.gb", $1DA79, $1DA81 - $1DA79

UnknownData_0x1DA81:
INCBIN "baserom.gb", $1DA81, $1DA83 - $1DA81

LoggedData_0x1DA83:
INCBIN "baserom.gb", $1DA83, $1DA8B - $1DA83

UnknownData_0x1DA8B:
INCBIN "baserom.gb", $1DA8B, $1DA8D - $1DA8B

LoggedData_0x1DA8D:
INCBIN "baserom.gb", $1DA8D, $1DA97 - $1DA8D

UnknownData_0x1DA97:
INCBIN "baserom.gb", $1DA97, $1DA9B - $1DA97

LoggedData_0x1DA9B:
INCBIN "baserom.gb", $1DA9B, $1DAB1 - $1DA9B

UnknownData_0x1DAB1:
INCBIN "baserom.gb", $1DAB1, $1DAB8 - $1DAB1

LoggedData_0x1DAB8:
INCBIN "baserom.gb", $1DAB8, $1DAB9 - $1DAB8

UnknownData_0x1DAB9:
INCBIN "baserom.gb", $1DAB9, $1DABC - $1DAB9

LoggedData_0x1DABC:
INCBIN "baserom.gb", $1DABC, $1DACB - $1DABC

UnknownData_0x1DACB:
INCBIN "baserom.gb", $1DACB, $1DACD - $1DACB

LoggedData_0x1DACD:
INCBIN "baserom.gb", $1DACD, $1DAE5 - $1DACD

UnknownData_0x1DAE5:
INCBIN "baserom.gb", $1DAE5, $1DAEF - $1DAE5

LoggedData_0x1DAEF:
INCBIN "baserom.gb", $1DAEF, $1DB07 - $1DAEF

UnknownData_0x1DB07:
INCBIN "baserom.gb", $1DB07, $1DB0B - $1DB07

LoggedData_0x1DB0B:
INCBIN "baserom.gb", $1DB0B, $1DB7B - $1DB0B

UnknownData_0x1DB7B:
INCBIN "baserom.gb", $1DB7B, $1DB9C - $1DB7B

LoggedData_0x1DB9C:
INCBIN "baserom.gb", $1DB9C, $1DB9F - $1DB9C

UnknownData_0x1DB9F:
INCBIN "baserom.gb", $1DB9F, $1DBA0 - $1DB9F

LoggedData_0x1DBA0:
INCBIN "baserom.gb", $1DBA0, $1DBA1 - $1DBA0

UnknownData_0x1DBA1:
INCBIN "baserom.gb", $1DBA1, $1DBA6 - $1DBA1

LoggedData_0x1DBA6:
INCBIN "baserom.gb", $1DBA6, $1DBA7 - $1DBA6

UnknownData_0x1DBA7:
INCBIN "baserom.gb", $1DBA7, $1DBAB - $1DBA7

LoggedData_0x1DBAB:
INCBIN "baserom.gb", $1DBAB, $1E851 - $1DBAB

UnknownData_0x1E851:
INCBIN "baserom.gb", $1E851, $1E852 - $1E851

LoggedData_0x1E852:
INCBIN "baserom.gb", $1E852, $1E8A2 - $1E852

UnknownData_0x1E8A2:
INCBIN "baserom.gb", $1E8A2, $1E8A3 - $1E8A2

LoggedData_0x1E8A3:
INCBIN "baserom.gb", $1E8A3, $20000 - $1E8A3

SECTION "Bank08", ROMX, BANK[$08]

Logged_0x20000:
	ld a,[$FF00+$91]
	and a
	jr z,Logged_0x20028
	cp $18
	jr z,Unknown_0x2000D
	cp $1F
	jr nz,Logged_0x20015

Unknown_0x2000D:
	ld a,[$C119]
	and a
	jr nz,Logged_0x20028
	jr Logged_0x20019

Logged_0x20015:
	cp $0B
	jr nc,Logged_0x20028

Logged_0x20019:
	call Logged_0x20FDF
	jr nc,Logged_0x20028
	ld a,[$FF00+$91]
	cp $0C
	jr z,Logged_0x2006F
	cp $0D
	jr z,Logged_0x2006F

Logged_0x20028:
	ld hl,$406F
	push hl
	ld a,[$FF00+$91]
	rst JumpList
	dw Logged_0x20089
	dw Logged_0x2022E
	dw Logged_0x20299
	dw Logged_0x202B7
	dw Logged_0x202DC
	dw Logged_0x20381
	dw Logged_0x203A6
	dw Logged_0x203C1
	dw Unknown_0x20448
	dw Logged_0x20505
	dw Logged_0x20585
	dw Unknown_0x205A0
	dw Unknown_0x205EF
	dw Unknown_0x20673
	dw Unknown_0x206F7
	dw Unknown_0x2071B
	dw Unknown_0x20768
	dw Unknown_0x20783
	dw Unknown_0x20794
	dw Unknown_0x207A5
	dw Unknown_0x2082C
	dw Unknown_0x2088E
	dw Logged_0x208CB
	dw Logged_0x208F5
	dw Unknown_0x208FF
	dw Unknown_0x20913
	dw Unknown_0x20914
	dw Unknown_0x20915
	dw Unknown_0x2092E
	dw Unknown_0x20942
	dw Unknown_0x2094C
	dw Unknown_0x2096A

Logged_0x2006F:
	ld a,[$C116]
	rra
	jr nc,Logged_0x2007E
	ld hl,$C116
	res 0,[hl]
	ld a,$81
	ld [$FF00+$02],a

Logged_0x2007E:
	ld hl,$C116
	res 6,[hl]
	call Logged_0x2958
	jp Logged_0x0B60

Logged_0x20089:
	call Logged_0x05CC
	xor a
	ld [$FF00+$42],a
	ld [$FF00+$43],a
	ld hl,$C0DE
	ld [hli],a
	ld [hl],a
	ld [$C127],a
	ld [$C128],a
	ld [$C116],a
	ld [$C118],a
	ld [$C119],a
	ld [$C117],a
	inc a
	ld [$C156],a
	ld [$C157],a
	ld a,$F7
	ld [$C109],a
	ld a,$03
	call Logged_0x1331
	add a,$10
	ld [$C115],a
	ld a,$03
	call Logged_0x0A96
	ld hl,$41C3
	ld de,$C129
	ld c,$0D
	call Logged_0x092B
	call Logged_0x20C43
	ld hl,$9800
	ld a,$A2
	ld bc,$0400
	call Logged_0x0914
	ld hl,$C200
	ld de,$41D0
	ld bc,$3C10
	call Logged_0x309F
	ld hl,$C20D
	ld c,$00
	call Logged_0x31C3
	ld bc,$4836
	ld hl,$C240
	ld de,$41DE
	call Logged_0x309F
	ld hl,$C24D
	ld c,$00
	call Logged_0x31C3
	ld bc,$4A36
	ld hl,$C260
	ld de,$41EC
	call Logged_0x309F
	ld hl,$9801
	ld de,$6992
	ld bc,$0306
	call Logged_0x209E2
	ld hl,$9863
	ld de,$69A4
	ld bc,$0D11
	call Logged_0x209E2
	ld a,[$C0A0]
	rla
	jr c,Unknown_0x20153
	ld hl,$9AE3
	ld de,$6A81
	ld bc,$0611
	call Logged_0x209E2
	ld a,[$C1A1]
	and $03
	jr z,Logged_0x20199
	ld b,a
	ld c,$00

Logged_0x20144:
	srl b
	push bc
	call c,Logged_0x201FA
	pop bc
	inc c
	ld a,c
	cp $02
	jr nz,Logged_0x20144
	jr Logged_0x20199

Unknown_0x20153:
	xor a
	ld [$C200],a
	ld a,$01
	ld [$C240],a
	ld a,[$C1A1]
	and $03
	jr z,Unknown_0x20187
	ld b,a
	ld c,$00

Unknown_0x20166:
	srl b
	push bc
	call c,Logged_0x201FA
	pop bc
	inc c
	ld a,c
	cp $02
	jr nz,Unknown_0x20166
	ld hl,$C12C
	ld a,$68
	ld [hli],a
	inc hl
	ld a,$0A
	ld [hli],a
	inc hl
	ld a,$86
	ld [hli],a
	inc hl
	ld a,$13
	ld [hl],a
	jr Logged_0x20199

Unknown_0x20187:
	ld hl,$C12C
	ld a,$5A
	ld [hli],a
	inc hl
	ld a,$18
	ld [hli],a
	inc hl
	ld a,$66
	ld [hli],a
	inc hl
	ld a,$1B
	ld [hl],a

Logged_0x20199:
	ld a,$32
	call Logged_0x1629
	ld a,$32
	call Logged_0x3262
	call Logged_0x20585
	ld hl,$FFFF
	set 1,[hl]
	ld hl,$C0A6
	set 1,[hl]
	call Logged_0x060E
	ld a,$01
	ld [$D243],a
	ld a,$06
	ld [$D244],a
	ld a,$10
	ld [$CE75],a
	ret

LoggedData_0x201C3:
INCBIN "baserom.gb", $201C3, $201FA - $201C3

Logged_0x201FA:
	ld a,$0A
	ld [$0000],a
	ld h,c
	ld l,$00
	add hl,hl
	add hl,hl
	add hl,hl
	ld de,$A00A
	add hl,de
	ld a,[hl]
	add a,$D9
	ld d,a
	ld a,c
	swap a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$990A
	add hl,bc
	ld a,$A6
	ld [hli],a
	ld a,$A7
	ld [hli],a
	ld a,$A8
	ld [hli],a
	ld [hl],d
	inc hl
	ld a,$86
	ld [hli],a
	ld [hl],a
	ld a,$00
	ld [$0000],a
	ret

Logged_0x2022E:
	call Logged_0x20DAC
	ld a,[$FF00+$8B]
	and $CD
	ret z
	and $09
	jr z,Logged_0x20263
	ld hl,$DC06
	set 5,[hl]
	ld a,$02
	ld [$FF00+$91],a
	ld a,[$C203]
	cp $74
	jr z,Unknown_0x20257
	ld hl,$CE75
	ld a,$0A
	ld [hli],a
	ld a,$04
	ld [hli],a
	ld a,$16
	ld [hl],a
	ret

Unknown_0x20257:
	ld hl,$CE75
	ld a,$0A
	ld [hli],a
	ld a,$04
	ld [hli],a
	ld [hl],$18
	ret

Logged_0x20263:
	ld a,[$C0A0]
	rla
	ret c
	ld a,[$C116]
	rla
	ret nc
	ld a,[$FF00+$8B]
	bit 2,a
	jr z,Unknown_0x20280
	ld hl,$C203
	ld a,[hl]
	xor $48
	ld [hl],a
	ld hl,$DC06
	set 4,[hl]
	ret

Unknown_0x20280:
	rla
	jr nc,Unknown_0x2028E
	ld a,$74
	ld [$C203],a
	ld hl,$DC06
	set 4,[hl]
	ret

Unknown_0x2028E:
	ld a,$3C
	ld [$C203],a
	ld hl,$DC06
	set 4,[hl]
	ret

Logged_0x20299:
	call Logged_0x20DAC
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$0A
	ld [hli],a
	ld a,[$C200]
	xor $01
	ld [$C200],a
	dec [hl]
	ret nz
	dec hl
	ld a,$01
	ld [hli],a
	inc hl
	ld a,[hl]
	ld [$FF00+$91],a
	ret

Logged_0x202B7:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$01
	ld [hl],a
	ld hl,$C12C
	inc [hl]
	inc [hl]
	inc hl
	inc hl
	dec [hl]
	dec [hl]
	inc hl
	inc hl
	inc [hl]
	inc [hl]
	inc hl
	inc hl
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	ld hl,$CE76
	dec [hl]
	ret nz
	inc hl
	ld a,[hl]
	ld [$FF00+$91],a
	ret

Logged_0x202DC:
	ld a,[$FF00+$8B]
	bit 1,a
	jr z,Logged_0x20324
	ld a,[$C0A0]
	rla
	ret c
	xor a
	ld [$C240],a
	ld b,$10
	ld a,[$C1A1]
	and $07
	jr z,Logged_0x202F6
	ld b,$17

Logged_0x202F6:
	ld hl,$CE75
	ld a,$01
	ld [hli],a
	ld [hl],b
	inc hl
	ld a,$01
	ld [hl],a
	ld hl,$DC06
	set 6,[hl]
	ld a,$05
	ld [$FF00+$91],a
	xor a
	ld [$C119],a
	ld [$C117],a
	ld [$C118],a
	ld a,$F7
	ld [$C109],a
	ld a,$03
	call Logged_0x1331
	add a,$08
	ld [$C115],a
	ret

Logged_0x20324:
	and $09
	jr z,Logged_0x2036A
	ld hl,$DC06
	set 5,[hl]
	ld a,$F2
	ld [$C109],a
	ld hl,$CE75
	ld a,$0A
	ld [hli],a
	ld a,$04
	ld [hl],a
	ld a,$06
	ld [$FF00+$91],a
	ld a,[$C243]
	sub $48
	swap a
	cp $02
	jr z,Unknown_0x20364
	ld [$C1A2],a
	ld c,a
	ld b,$00
	ld hl,$437E
	add hl,bc
	ld a,[hl]
	ld b,$09
	ld hl,$C1A1
	and [hl]
	jr nz,Logged_0x2035F
	ld b,$07

Logged_0x2035F:
	ld hl,$CE77
	ld [hl],b
	ret

Unknown_0x20364:
	ld a,$0E
	ld [$CE77],a
	ret

Logged_0x2036A:
	ld de,$4858
	ld a,[$C1A1]
	and $03
	jr z,Logged_0x20376
	ld e,$68

Logged_0x20376:
	ld b,$10
	ld hl,$C243
	jp Logged_0x2103F

LoggedData_0x2037E:
INCBIN "baserom.gb", $2037E, $2037F - $2037E

UnknownData_0x2037F:
INCBIN "baserom.gb", $2037F, $20381 - $2037F

Logged_0x20381:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$01
	ld [hl],a
	ld hl,$C12C
	dec [hl]
	dec [hl]
	inc hl
	inc hl
	inc [hl]
	inc [hl]
	inc hl
	inc hl
	dec [hl]
	dec [hl]
	inc hl
	inc hl
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ld hl,$CE76
	dec [hl]
	ret nz
	inc hl
	ld a,[hl]
	ld [$FF00+$91],a
	ret

Logged_0x203A6:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$0A
	ld [hli],a
	ld a,[$C240]
	xor $01
	ld [$C240],a
	dec [hl]
	ret nz
	dec hl
	ld a,$02
	ld [hli],a
	inc hl
	ld a,[hl]
	ld [$FF00+$91],a
	ret

Logged_0x203C1:
	ld hl,$D12C
	set 0,[hl]
	ld hl,$CE68
	xor a
	ld c,$08
	call Logged_0x091D
	ld a,$03
	ld [$FF00+$90],a
	xor a
	ld [$FF00+$91],a
	xor a
	ld [$CE58],a
	ld [$C9E4],a
	ld [$CE73],a
	ld bc,$0010
	jp Logged_0x0AE5

UnknownData_0x203E6:
INCBIN "baserom.gb", $203E6, $20448 - $203E6

Unknown_0x20448:
	ld a,[$FF00+$8B]
	bit 1,a
	jr z,Unknown_0x2045C
	ld hl,$DC06
	set 6,[hl]
	ld hl,$D12A
	res 7,[hl]
	xor a
	ld [$FF00+$91],a
	ret

Unknown_0x2045C:
	and $09
	jr z,Unknown_0x204D2
	ld hl,$CC42
	xor a
	ld c,$40
	call Logged_0x091D
	ld hl,$CC82
	xor a
	ld bc,$0100
	call Logged_0x0914
	ld hl,$CD82
	xor a
	ld c,$40
	call Logged_0x091D
	ld a,$04
	ld [$CE52],a
	ld hl,$CDC2
	xor a
	ld c,$80
	call Logged_0x091D
	ld hl,$CE54
	xor a
	ld c,$04
	call Logged_0x091D
	xor a
	ld [$CE58],a
	ld hl,$CE5D
	xor a
	ld c,$08
	call Logged_0x091D
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A000
	add hl,bc
	ld bc,$0400
	xor a
	call Logged_0x0914
	ld a,$00
	ld [$0000],a
	ld hl,$C9E4
	dec [hl]
	xor a
	ld [$C922],a
	ld a,$03
	ld [$FF00+$90],a
	xor a
	ld [$FF00+$91],a
	ld hl,$DC06
	set 5,[hl]
	ret

Unknown_0x204D2:
	ld hl,$C9E4
	ld a,[$FF00+$96]
	rla
	jr nc,Unknown_0x204EF
	ld a,[$DC06]
	set 4,a
	ld [$DC06],a
	dec [hl]
	ld a,[hl]
	cp $FF
	jp nz,Unknown_0x209D4
	ld a,$07
	ld [hl],a
	jp Unknown_0x209D4

Unknown_0x204EF:
	rla
	ret nc
	ld a,[$DC06]
	set 4,a
	ld [$DC06],a
	inc [hl]
	ld a,[hl]
	cp $08
	jp nz,Unknown_0x209D4
	xor a
	ld [hl],a
	jp Unknown_0x209D4

Logged_0x20505:
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A00A
	add hl,bc
	ld a,[hl]
	ld [$C9E4],a
	ld a,$00
	ld [$0000],a
	call Logged_0x209F4
	ld b,$00
	ld a,[$CC40]
	and a
	jr z,Logged_0x20532
	ld b,$06
	cp $7F
	jr nz,Logged_0x20532
	inc b

Logged_0x20532:
	ld a,b
	ld [$CE58],a
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$457D
	add hl,bc
	ld a,[$CC41]
	and [hl]
	jr z,Logged_0x2055B
	ld hl,$D12A
	set 7,[hl]
	set 2,[hl]
	xor a
	ld [$C922],a
	ld a,$0A
	ld [$FF00+$90],a
	ld a,$12
	ld [$FF00+$91],a
	jr Logged_0x20566

Logged_0x2055B:
	xor a
	ld [$C156],a
	ld a,$0A
	ld [$FF00+$90],a
	xor a
	ld [$FF00+$91],a

Logged_0x20566:
	ld hl,$D12C
	set 0,[hl]
	ld hl,$FF47
	ld a,$1B
	ld [hli],a
	ld a,$1E
	ld [hli],a
	ld a,$83
	ld [hl],a
	ld bc,$0008
	jp Logged_0x0AE5

UnknownData_0x2057D:
INCBIN "baserom.gb", $2057D, $2057E - $2057D

LoggedData_0x2057E:
INCBIN "baserom.gb", $2057E, $2057F - $2057E

UnknownData_0x2057F:
INCBIN "baserom.gb", $2057F, $20580 - $2057F

LoggedData_0x20580:
INCBIN "baserom.gb", $20580, $20585 - $20580

Logged_0x20585:
	ld a,$1B
	ld [$FF00+$47],a
	ld a,$1E
	ld [$FF00+$48],a
	ld a,$83
	ld [$FF00+$49],a
	ld b,$04
	ld a,[$C0A0]
	rla
	jr c,Logged_0x2059B
	ld b,$01

Logged_0x2059B:
	ld hl,$FF91
	ld [hl],b
	ret

Unknown_0x205A0:
	ld hl,$C0FA
	ld c,$00

Unknown_0x205A5:
	ld a,[hl]
	and a
	jr nz,Unknown_0x205BF
	ld a,[$C0A5]
	rra
	jr nc,Unknown_0x205A5
	ld a,[$C0A5]
	res 0,a
	ld [$C0A5],a
	inc c
	ld a,c
	cp $10
	jr c,Unknown_0x205A5
	jr Unknown_0x205E5

Unknown_0x205BF:
	xor a
	ld [hl],a
	ld a,[$C100]
	call Logged_0x20FBE
	cp $01
	jp nz,Unknown_0x205E5
	ld a,$FB
	ld [$C109],a
	xor a
	ld [$C117],a
	ld a,[$C119]
	and a
	jr z,Unknown_0x205E0
	ld hl,$C116
	set 0,[hl]

Unknown_0x205E0:
	ld a,$0C
	ld [$FF00+$91],a
	ret

Unknown_0x205E5:
	ld a,$01
	ld [$FF00+$91],a
	ld a,$F7
	ld [$C109],a
	ret

Unknown_0x205EF:
	ld hl,$C0FA
	ld c,$00

Unknown_0x205F4:
	ld a,[hl]
	and a
	jr nz,Unknown_0x20616
	ld a,[$C0A5]
	rra
	jr nc,Unknown_0x205F4
	ld a,[$C0A5]
	res 0,a
	ld [$C0A5],a
	inc c
	ld a,c
	cp $10
	jr c,Unknown_0x205F4
	ld a,$01
	ld [$FF00+$91],a
	ld a,$F7
	ld [$C109],a
	ret

Unknown_0x20616:
	ld a,[$C100]
	call Logged_0x20FBE
	cp $02
	jr nz,Unknown_0x20650
	xor a
	ld [$C156],a
	ld a,[$C119]
	ld [$C0F9],a
	and a
	jp z,Unknown_0x206B2

Unknown_0x2062E:
	xor a
	ld [$C0F7],a
	inc a
	ld [$C0F8],a
	ld [$C0FE],a
	ld [$C0FC],a
	ld [$C0F6],a
	ld [$D120],a
	ld bc,$0108
	call Logged_0x0AE5
	xor a
	ld [$FF00+$91],a
	ld a,$05
	ld [$FF00+$90],a
	ret

Unknown_0x20650:
	ld hl,$C117
	inc [hl]
	ld a,[hl]
	cp $08
	jr c,Unknown_0x20663
	ld a,$01
	ld [$FF00+$91],a
	ld a,$F7
	ld [$C109],a
	ret

Unknown_0x20663:
	ld a,$FB
	ld [$C109],a
	ld a,[$C119]
	and a
	ret z
	ld hl,$C116
	set 0,[hl]
	ret

Unknown_0x20673:
	ld hl,$C0FA
	ld c,$00

Unknown_0x20678:
	ld a,[hl]
	and a
	jr nz,Unknown_0x2069A
	ld a,[$C0A5]
	rra
	jr nc,Unknown_0x20678
	ld a,[$C0A5]
	res 0,a
	ld [$C0A5],a
	inc c
	ld a,c
	cp $10
	jr c,Unknown_0x20678
	ld a,$01
	ld [$FF00+$91],a
	ld a,$F7
	ld [$C109],a
	ret

Unknown_0x2069A:
	ld a,[$C100]
	call Logged_0x20FBE
	cp $02
	jr nz,Unknown_0x206D4
	xor a
	ld [$C156],a
	ld a,[$C119]
	ld [$C0F9],a
	and a
	jp nz,Unknown_0x2062E

Unknown_0x206B2:
	xor a
	ld [$D120],a
	ld [$C0F8],a
	inc a
	ld [$C0FE],a
	ld [$C0FC],a
	ld [$C0F7],a
	ld [$C0F6],a
	ld bc,$0108
	call Logged_0x0AE5
	xor a
	ld [$FF00+$91],a
	ld a,$05
	ld [$FF00+$90],a
	ret

Unknown_0x206D4:
	ld hl,$C117
	inc [hl]
	ld a,[hl]
	cp $08
	jr c,Unknown_0x206E7
	ld a,$01
	ld [$FF00+$91],a
	ld a,$F7
	ld [$C109],a
	ret

Unknown_0x206E7:
	ld a,$FB
	ld [$C109],a
	ld a,[$C119]
	and a
	ret z
	ld hl,$C116
	set 0,[hl]
	ret

Unknown_0x206F7:
	ld a,$01
	ld [$C260],a
	ld hl,$C261
	ld a,$0A
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$C26C
	set 7,[hl]
	ld hl,$C26D
	ld c,$00
	call Logged_0x31C3
	ld a,$04
	ld [$FF00+$8B],a
	ld a,$0F
	ld [$FF00+$91],a
	jr Unknown_0x20753

Unknown_0x2071B:
	ld a,[$FF00+$8B]
	bit 1,a
	jr z,Unknown_0x2072F
	xor a
	ld [$C260],a
	ld a,$04
	ld [$FF00+$91],a
	ld hl,$DC06
	set 6,[hl]
	ret

Unknown_0x2072F:
	rra
	jr nc,Unknown_0x20748
	ld hl,$CE75
	ld a,$0A
	ld [hli],a
	ld a,$04
	ld [hli],a
	ld a,$11
	ld [hl],a
	ld a,$10
	ld [$FF00+$91],a
	ld hl,$DC06
	set 5,[hl]
	ret

Unknown_0x20748:
	ld de,$4A5A
	ld b,$10
	ld hl,$C263
	call Logged_0x2103F

Unknown_0x20753:
	ld a,[$C263]
	sub $4A
	swap a
	ld c,a
	ld b,$00
	ld hl,$437E
	add hl,bc
	ld a,[$C1A1]
	and [hl]
	ret nz
	jr Unknown_0x20748

Unknown_0x20768:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$0A
	ld [hli],a
	ld a,[$C260]
	xor $01
	ld [$C260],a
	dec [hl]
	ret nz
	dec hl
	ld a,$02
	ld [hli],a
	inc hl
	ld a,[hl]
	ld [$FF00+$91],a
	ret

Unknown_0x20783:
	ld hl,$CE75
	ld a,$01
	ld [hli],a
	ld a,$04
	ld [hli],a
	ld a,$12
	ld [hl],a
	ld a,$03
	ld [$FF00+$91],a
	ret

Unknown_0x20794:
	ld hl,$C243
	ld a,$72
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,$3E
	ld [hl],a
	ld a,$13
	ld [$FF00+$91],a
	ret

Unknown_0x207A5:
	ld a,[$FF00+$8B]
	rra
	jr nc,Unknown_0x207C9
	ld hl,$DC06
	set 5,[hl]
	ld hl,$CE75
	ld a,$0A
	ld [hli],a
	ld a,$04
	ld [hli],a
	ld a,$06
	ld [$FF00+$91],a
	ld b,$1B
	ld a,[$C247]
	cp $60
	jr z,Unknown_0x207C7
	ld b,$15

Unknown_0x207C7:
	ld [hl],b
	ret

Unknown_0x207C9:
	rra
	jr nc,Unknown_0x207FA
	ld de,$6836
	ld b,$04
	ld a,[$C1A1]
	and $03
	jr nz,Unknown_0x207DC
	ld d,$48
	ld b,$0C

Unknown_0x207DC:
	ld hl,$C243
	ld [hl],d
	inc hl
	inc hl
	inc hl
	inc hl
	ld [hl],e
	ld hl,$CE75
	ld a,$01
	ld [hli],a
	ld [hl],b
	inc hl
	ld a,$0F
	ld [hl],a
	ld a,$05
	ld [$FF00+$91],a
	ld hl,$DC06
	set 6,[hl]
	ret

Unknown_0x207FA:
	ld hl,$C247
	ld a,[$FF00+$8B]
	bit 2,a
	jr z,Unknown_0x2080D
	ld a,[hl]
	xor $5E
	ld [hl],a
	ld hl,$DC06
	set 4,[hl]
	ret

Unknown_0x2080D:
	bit 5,a
	jr z,Unknown_0x2081D
	ld a,[hl]
	cp $3E
	ret z
	ld [hl],$3E
	ld hl,$DC06
	set 4,[hl]
	ret

Unknown_0x2081D:
	bit 4,a
	ret z
	ld a,[hl]
	cp $60
	ret z
	ld [hl],$60
	ld hl,$DC06
	set 4,[hl]
	ret

Unknown_0x2082C:
	ld hl,$48BB
	ld de,$CE88
	ld c,$10
	call Logged_0x092B
	ld a,[$C263]
	sub $4A
	push af
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$98EA
	add hl,bc
	ld e,l
	ld d,h
	ld hl,$CE81
	ld a,$CE
	ld [hld],a
	ld a,$88
	ld [hld],a
	ld a,$08
	ld [hld],a
	ld a,$02
	ld [hld],a
	ld [hl],d
	dec hl
	ld [hl],e
	ld de,$CE7C
	call Logged_0x09A3
	pop af
	swap a
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A000
	add hl,bc
	ld a,$0A
	ld [$0000],a
	push hl
	ld bc,$0800
	xor a
	call Logged_0x0914
	pop hl
	ld bc,$1000
	add hl,bc
	ld bc,$0800
	xor a
	call Logged_0x0914
	ld a,$00
	ld [$0000],a
	call Logged_0x20C43

Unknown_0x2088E:
	ld de,$6836
	ld b,$04
	ld a,[$C1A1]
	and $07
	jr nz,Unknown_0x2089E
	ld d,$48
	ld b,$0B

Unknown_0x2089E:
	ld hl,$C243
	ld [hl],d
	inc hl
	inc hl
	inc hl
	inc hl
	ld [hl],e
	xor a
	ld [$C260],a
	ld hl,$CE75
	ld a,$01
	ld [hli],a
	ld [hl],b
	inc hl
	ld a,$04
	ld [hl],a
	ld a,$05
	ld [$FF00+$91],a
	ret

UnknownData_0x208BB:
INCBIN "baserom.gb", $208BB, $208CB - $208BB

Logged_0x208CB:
	ld b,$10
	ld a,[$C1A1]
	and $07
	jr z,Logged_0x208D6
	ld b,$17

Logged_0x208D6:
	ld hl,$CE75
	ld a,$01
	ld [hli],a
	ld [hl],b
	inc hl
	ld a,$17
	ld [hl],a
	ld a,$03
	ld [$FF00+$91],a
	ld a,$F2
	ld [$C109],a
	ld a,[$C119]
	and a
	ret z
	ld hl,$C116
	set 0,[hl]
	ret

Logged_0x208F5:
	ld a,$01
	ld [$C240],a
	ld a,$04
	ld [$FF00+$91],a
	ret

Unknown_0x208FF:
	ld a,$1F
	ld [$FF00+$91],a
	ld a,$FC
	ld [$C109],a
	ld a,[$C119]
	and a
	ret z
	ld hl,$C116
	set 0,[hl]
	ret

Unknown_0x20913:
	ret

Unknown_0x20914:
	ret

Unknown_0x20915:
	ld a,$1C
	ld [$FF00+$91],a
	ld hl,$DC0A
	set 5,[hl]
	ld hl,$C261
	ld a,$0B
	ld [hli],a
	xor a
	ld [hli],a
	ld hl,$C26D
	ld c,$00
	jp Logged_0x31C3

Unknown_0x2092E:
	ld a,[$C26C]
	bit 6,a
	ret z
	xor a
	ld [$C260],a
	ld a,$28
	ld [$CE75],a
	ld a,$1D
	ld [$FF00+$91],a
	ret

Unknown_0x20942:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$14
	ld [$FF00+$91],a
	ret

Unknown_0x2094C:
	ld hl,$C115
	dec [hl]
	ret nz
	ld a,$FB
	ld [$C109],a
	ld [$FF00+$01],a
	ld b,$0D
	ld a,[$C119]
	and a
	jr z,Unknown_0x20966
	ld hl,$C116
	set 0,[hl]
	dec b

Unknown_0x20966:
	ld a,b
	ld [$FF00+$91],a
	ret

Unknown_0x2096A:
	ld hl,$C0FA

Unknown_0x2096D:
	ld a,[hl]
	and a
	jr nz,Unknown_0x2098F
	ld a,[$C0A5]
	rra
	jr nc,Unknown_0x2096D
	ld a,[$C0A5]
	res 0,a
	ld [$C0A5],a
	inc c
	ld a,c
	cp $10
	jr c,Unknown_0x2096D
	ld a,$01
	ld [$FF00+$91],a
	ld a,$F7
	ld [$C109],a
	ret

Unknown_0x2098F:
	xor a
	ld [hl],a
	ld a,$0B
	ld [$FF00+$91],a
	ld a,[$C119]
	and a
	ret z
	ld hl,$C116
	set 0,[hl]
	ret

UnknownData_0x209A0:
INCBIN "baserom.gb", $209A0, $209D4 - $209A0

Unknown_0x209D4:
	ld a,[$C9E4]
	add a,$D9
	ld [$CE88],a
	ld de,$CE7C
	jp Logged_0x09A3

Logged_0x209E2:
	push bc
	push hl

Logged_0x209E4:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x209E4
	pop hl
	ld bc,$0020
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x209E2
	ret

Logged_0x209F4:
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	push bc
	ld hl,$A001
	add hl,bc
	ld a,[hli]
	ld [$CC40],a
	ld de,$CE5D
	ld c,$08
	call Logged_0x092B
	inc hl
	ld a,[hl]
	ld [$CC41],a
	ld hl,$C9E4
	ld a,[hl]
	add a,a
	add a,a
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$4AB8
	add hl,bc
	ld a,[hli]
	ld b,[hl]
	ld c,a
	inc hl
	ld e,l
	ld d,h
	ld l,c
	ld h,b
	pop bc
	push de
	add hl,bc
	ld a,[hli]
	ld [$CE53],a
	ld b,a
	ld de,$CE54
	ld c,$04

Logged_0x20A3C:
	xor a
	rr b
	rla
	ld [de],a
	inc de
	dec c
	jr nz,Logged_0x20A3C
	ld a,[hli]
	ld [$CE71],a
	ld a,[hli]
	ld [$CE72],a
	inc hl
	ld a,[hli]
	ld [$CE73],a
	ld a,[hli]
	ld [$CE66],a
	ld bc,$CE5A
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	ld a,[hli]
	ld [$C9E5],a
	ld a,[hli]
	ld [$C9E6],a
	ld a,[hli]
	ld [$CEB4],a
	ld a,[hli]
	ld [$CEB5],a
	ld a,[hli]
	ld [$CE52],a
	ld a,[hli]
	ld [$CFDD],a
	ld a,[hli]
	ld [$CE70],a
	pop de
	ld a,[de]
	ld c,a
	push de
	ld de,$CC42
	call Logged_0x092B
	pop de
	inc de
	ld a,[de]
	ld c,a
	push de
	ld de,$CC82
	call Logged_0x092B
	pop de
	inc de
	ld a,[de]
	ld c,a
	push de
	ld de,$CD82
	call Logged_0x092B
	pop de
	inc de
	ld a,[de]
	ld c,a
	push de
	ld de,$CDC2
	call Logged_0x092B
	pop de
	inc de
	ld a,[de]
	ld c,a
	ld de,$C922
	call Logged_0x092B
	ld a,$00
	ld [$0000],a
	ret

LoggedData_0x20AB8:
INCBIN "baserom.gb", $20AB8, $20B00 - $20AB8

Logged_0x20B00:
	ld a,[$C922]

Logged_0x20B03:
	ld [$D250],a
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	push bc
	ld hl,$A000
	add hl,bc
	ld a,[$C1A2]
	add a,$30
	ld [hli],a
	ld a,[$CC40]
	ld [hli],a
	ld e,l
	ld d,h
	ld hl,$CE5D
	ld c,$08
	call Logged_0x092B
	ld a,[$C9E4]
	ld [de],a
	inc de
	ld a,[$CC41]
	ld [de],a
	ld hl,$C9E4
	ld a,[hl]
	add a,a
	add a,a
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$4AB8
	add hl,bc
	ld a,[hli]
	ld b,[hl]
	ld c,a
	inc hl
	ld e,l
	ld d,h
	ld l,c
	ld h,b
	pop bc
	add hl,bc
	push hl
	push de
	ld de,$CE57
	ld a,[$CE53]
	and $C0
	push af
	ld b,$00
	ld c,$04

Logged_0x20B5E:
	ld a,[de]
	rra
	rl b
	dec de
	dec c
	jr nz,Logged_0x20B5E
	pop af
	or b
	ld [hli],a
	ld a,[$CE71]
	ld [hli],a
	ld a,[$CE72]
	ld [hli],a
	inc hl
	ld a,[$CE73]
	ld [hli],a
	ld a,[$CE66]
	ld [hli],a
	ld bc,$CE5A
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hli],a
	ld a,[$C9E5]
	ld [hli],a
	ld a,[$C9E6]
	ld [hli],a
	ld a,[$CEB4]
	ld [hli],a
	ld a,[$CEB5]
	ld [hli],a
	ld a,[$CE52]
	ld [hli],a
	ld a,[$CFDD]
	ld [hli],a
	ld a,[$D250]
	ld [hli],a
	ld e,l
	ld d,h
	pop hl
	ld a,[hli]
	ld c,a
	push hl
	ld hl,$CC42
	call Logged_0x092B
	pop hl
	ld a,[hli]
	ld c,a
	push hl
	ld hl,$CC82
	call Logged_0x092B
	pop hl
	ld a,[hli]
	ld c,a
	push hl
	ld hl,$CD82
	call Logged_0x092B
	pop hl
	ld a,[hli]
	ld c,a
	push hl
	ld hl,$CDC2
	call Logged_0x092B
	pop hl
	ld a,[hli]
	ld c,a
	push hl
	ld hl,$C922
	call Logged_0x092B
	pop hl
	ld a,[hli]
	ld b,[hl]
	ld c,a
	pop hl
	call Logged_0x330C
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A000
	add hl,bc
	push hl
	push hl
	ld bc,$000F
	call Logged_0x330C
	pop hl
	ld bc,$1000
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld bc,$0800
	call Logged_0x0922
	ld a,$00
	ld [$0000],a
	ret

UnknownData_0x20C06:
INCBIN "baserom.gb", $20C06, $20C43 - $20C06

Logged_0x20C43:
	ld hl,$C1A1
	ld a,[hl]
	and $F8
	ld [hl],a
	ld a,$0A
	ld [$0000],a
	ld hl,$A000
	ld b,$30
	call Logged_0x20CA5
	jr nc,Logged_0x20C5E
	ld hl,$C1A1
	set 0,[hl]

Logged_0x20C5E:
	ld hl,$A800
	ld b,$31
	call Logged_0x20CA5
	jr nc,Logged_0x20C6D
	ld hl,$C1A1
	set 1,[hl]

Logged_0x20C6D:
	ld a,$00
	ld [$0000],a
	ld a,[$C1A1]
	and $03
	ret z
	scf
	ret

Logged_0x20C7A:
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A000
	add hl,bc
	ld a,[$C1A2]
	add a,$30
	ld b,a
	call Logged_0x20CA5
	jr nc,Unknown_0x20C9E
	ld a,$00
	ld [$0000],a
	scf
	ret

Unknown_0x20C9E:
	ld a,$00
	ld [$0000],a
	and a
	ret

Logged_0x20CA5:
	ld a,[hli]
	cp b
	jr nz,Logged_0x20CD3
	push hl
	ld bc,$000E
	ld d,a

Logged_0x20CAE:
	ld a,[hli]
	add a,d
	ld d,a
	dec bc
	ld a,b
	or c
	jr nz,Logged_0x20CAE
	ld a,[hl]
	pop hl
	cp d
	jr z,Logged_0x20CFA
	push hl
	dec hl
	ld bc,$1000
	add hl,bc
	ld bc,$000F
	ld d,$00

Unknown_0x20CC6:
	ld a,[hli]
	add a,d
	ld d,a
	dec bc
	ld a,b
	or c
	jr nz,Unknown_0x20CC6
	ld a,[hl]
	pop hl
	cp d
	jr z,Unknown_0x20CEB

Logged_0x20CD3:
	dec hl
	push hl
	ld bc,$0800
	xor a
	call Logged_0x0914
	pop hl
	ld bc,$1000
	add hl,bc
	ld bc,$0800
	xor a
	call Logged_0x0914
	jp Logged_0x20DAA

Unknown_0x20CEB:
	push hl
	dec hl
	ld e,l
	ld d,h
	ld bc,$1000
	add hl,bc
	ld bc,$0800
	call Logged_0x0922
	pop hl

Logged_0x20CFA:
	xor a
	ld [$D24B],a
	xor a
	ld [$D24C],a
	push hl
	ld bc,$000F
	add hl,bc
	ld de,$4ABF
	ld c,$08

Logged_0x20D0C:
	push bc
	ld a,[de]
	ld c,a
	inc de
	ld a,[de]
	ld b,a
	inc de
	push de
	push hl
	push bc
	ld d,$00

Logged_0x20D18:
	ld a,[hli]
	add a,d
	ld d,a
	dec bc
	ld a,b
	or c
	jr nz,Logged_0x20D18
	ld a,[hl]
	pop bc
	pop hl
	cp d
	jr z,Logged_0x20D5A
	push hl
	push bc
	ld de,$1000
	add hl,de
	ld d,$00

Unknown_0x20D2E:
	ld a,[hli]
	add a,d
	ld d,a
	dec bc
	ld a,b
	or c
	jr nz,Unknown_0x20D2E
	ld a,[hl]
	pop bc
	pop hl
	cp d
	jr z,Logged_0x20D5A
	ld a,[$D24C]
	srl a
	ld [$D24C],a
	push hl
	push bc
	push bc
	push hl
	xor a
	call Logged_0x0914
	pop hl
	ld bc,$1000
	add hl,bc
	pop bc
	xor a
	call Logged_0x0914
	pop bc
	pop hl
	jr Logged_0x20D86

Logged_0x20D5A:
	push hl
	push bc
	push bc
	ld e,l
	ld d,h
	ld bc,$1000
	add hl,bc
	push hl
	push de
	pop hl
	pop de
	jr Logged_0x20D72

UnknownData_0x20D69:
INCBIN "baserom.gb", $20D69, $20D72 - $20D69

Logged_0x20D72:
	pop bc
	inc bc
	call Logged_0x0922
	pop bc
	pop hl
	ld a,$01
	ld [$D24B],a
	ld a,[$D24C]
	scf
	rra
	ld [$D24C],a

Logged_0x20D86:
	inc bc
	add hl,bc
	pop de
	push hl
	ld hl,$0007
	add hl,de
	ld e,l
	ld d,h
	pop hl
	pop bc
	dec c
	jp nz,Logged_0x20D0C
	pop hl
	ld a,[$D24C]
	and [hl]
	ld [hld],a
	ld bc,$000F
	call Logged_0x330C
	ld a,[$D24B]
	and a
	jr z,Logged_0x20DAA
	scf
	ret

Logged_0x20DAA:
	and a
	ret

Logged_0x20DAC:
	ld a,[$C118]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$4DBB
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x20DBB:
INCBIN "baserom.gb", $20DBB, $20DC5 - $20DBB

UnknownData_0x20DC5:
INCBIN "baserom.gb", $20DC5, $20DC7 - $20DC5
	ld a,[$C116]
	bit 6,a
	jr z,Logged_0x20DE7
	ld a,[$C100]
	call Logged_0x20FBE
	cp $01
	jr nz,Logged_0x20DE7
	xor a
	ld [$C119],a
	ld [$C117],a
	ld a,$04
	ld [$C118],a
	jp Unknown_0x20F44

Logged_0x20DE7:
	ld hl,$C115
	dec [hl]
	ret nz
	ld a,$03
	call Logged_0x1331
	add a,$02
	ld [$C115],a
	ld a,$01
	ld [$C118],a
	ret
	ld a,[$C116]
	bit 6,a
	jr z,Logged_0x20E1C
	ld a,[$C100]
	call Logged_0x20FBE
	cp $01
	jr nz,Logged_0x20E1C
	xor a
	ld [$C119],a
	ld [$C117],a
	ld a,$04
	ld [$C118],a
	jp Unknown_0x20F44

Logged_0x20E1C:
	ld hl,$C115
	dec [hl]
	ret nz
	ld a,$F7
	ld [$C109],a
	ld hl,$C116
	set 0,[hl]
	ld a,$03
	call Logged_0x1331
	add a,$02
	ld [$C115],a
	ld a,$02
	ld [$C118],a
	xor a
	ld [$C117],a
	ret
	ld a,[$C116]
	bit 6,a
	jr z,Unknown_0x20E65
	xor a
	ld [$C117],a
	ld a,[$C100]
	call Logged_0x20FBE
	cp $01
	jr nz,Logged_0x20E7D
	ld a,$01
	ld [$C119],a
	xor a
	ld [$C117],a
	ld a,$03
	ld [$C118],a
	jp Unknown_0x20F44

Unknown_0x20E65:
	ld hl,$C117
	inc [hl]
	ld a,[hl]
	cp $3C
	ret c
	xor a
	ld [hl],a
	ld a,$08
	ld [$C115],a
	xor a
	ld [$C119],a
	xor a
	ld [$C118],a
	ret

Logged_0x20E7D:
	xor a
	ld [$C119],a
	ld [$C117],a
	ld a,$04
	ld [$C118],a
	ret
	ld a,[$C116]
	bit 6,a
	jr z,Logged_0x20EB3
	xor a
	ld [$C117],a
	ld hl,$C11A
	inc [hl]
	ld a,[hl]
	cp $02
	jr nc,Unknown_0x20EED
	ld a,[$C100]
	call Logged_0x20FBE
	cp $01
	jr nz,Logged_0x20EDC
	ld hl,$C116
	bit 7,[hl]
	ret nz
	set 7,[hl]
	jp Unknown_0x20F44

Logged_0x20EB3:
	ld hl,$C115
	dec [hl]
	jr nz,Logged_0x20ED2
	ld a,$F7
	ld [$C109],a
	ld hl,$C116
	set 0,[hl]
	ld a,$03
	call Logged_0x1331
	add a,$02
	ld [$C115],a
	xor a
	ld [$C11A],a
	ret

Logged_0x20ED2:
	ld hl,$C117
	inc [hl]
	ld a,[hl]
	cp $3C
	ret c
	xor a
	ld [hl],a

Logged_0x20EDC:
	ld hl,$C116
	bit 7,[hl]
	ret z
	ld a,[$C100]
	cp $FB
	ret z
	res 7,[hl]
	jp Unknown_0x20F6E

Unknown_0x20EED:
	xor a
	ld [$C119],a
	ld [$C117],a
	ld a,$04
	ld [$C118],a
	ret
	ld a,[$C116]
	bit 6,a
	jr z,Logged_0x20F1A
	xor a
	ld [$C117],a
	ld a,[$C100]
	call Logged_0x20FBE
	cp $01
	jr nz,Unknown_0x20F33
	ld hl,$C116
	bit 7,[hl]
	ret nz
	set 7,[hl]
	jp Unknown_0x20F44

Logged_0x20F1A:
	ld hl,$C117
	inc [hl]
	ld a,[hl]
	cp $3C
	ret c
	xor a
	ld [hl],a
	ld a,$01
	ld [$C119],a
	xor a
	ld [$C117],a
	ld a,$03
	ld [$C118],a
	ret

Unknown_0x20F33:
	ld hl,$C116
	bit 7,[hl]
	ret z
	ld a,[$C100]
	cp $FB
	ret z
	res 7,[hl]
	jp Unknown_0x20F6E

Unknown_0x20F44:
	ld hl,$DC07
	set 0,[hl]
	ld hl,$4F9D
	ld de,$CE88
	ld c,$06
	call Logged_0x092B
	ld hl,$CE81
	ld a,$CE
	ld [hld],a
	ld a,$88
	ld [hld],a
	ld a,$03
	ld [hld],a
	ld a,$02
	ld [hld],a
	ld a,$9B
	ld [hld],a
	ld a,$2F
	ld [hl],a
	ld e,l
	ld d,h
	jp Logged_0x09A3

Unknown_0x20F6E:
	ld hl,$DC07
	set 1,[hl]
	ld a,$3C
	ld [$C203],a
	ld hl,$4FA3
	ld de,$CE88
	ld c,$06
	call Logged_0x092B
	ld hl,$CE81
	ld a,$CE
	ld [hld],a
	ld a,$88
	ld [hld],a
	ld a,$03
	ld [hld],a
	ld a,$02
	ld [hld],a
	ld a,$9B
	ld [hld],a
	ld a,$2F
	ld [hl],a
	ld e,l
	ld d,h
	jp Logged_0x09A3

UnknownData_0x20F9D:
INCBIN "baserom.gb", $20F9D, $20FBE - $20F9D

Logged_0x20FBE:
	ld hl,$4FD0
	ld c,$07

Logged_0x20FC3:
	cp [hl]
	jr z,Logged_0x20FCD
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x20FC3
	ld a,[hl]
	ret

Logged_0x20FCD:
	inc hl
	ld a,[hl]
	ret

LoggedData_0x20FD0:
INCBIN "baserom.gb", $20FD0, $20FD1 - $20FD0

UnknownData_0x20FD1:
INCBIN "baserom.gb", $20FD1, $20FD2 - $20FD1

LoggedData_0x20FD2:
INCBIN "baserom.gb", $20FD2, $20FD3 - $20FD2

UnknownData_0x20FD3:
INCBIN "baserom.gb", $20FD3, $20FD4 - $20FD3

LoggedData_0x20FD4:
INCBIN "baserom.gb", $20FD4, $20FD5 - $20FD4

UnknownData_0x20FD5:
INCBIN "baserom.gb", $20FD5, $20FD6 - $20FD5

LoggedData_0x20FD6:
INCBIN "baserom.gb", $20FD6, $20FD7 - $20FD6

UnknownData_0x20FD7:
INCBIN "baserom.gb", $20FD7, $20FD8 - $20FD7

LoggedData_0x20FD8:
INCBIN "baserom.gb", $20FD8, $20FD9 - $20FD8

UnknownData_0x20FD9:
INCBIN "baserom.gb", $20FD9, $20FDA - $20FD9

LoggedData_0x20FDA:
INCBIN "baserom.gb", $20FDA, $20FDB - $20FDA

UnknownData_0x20FDB:
INCBIN "baserom.gb", $20FDB, $20FDC - $20FDB

LoggedData_0x20FDC:
INCBIN "baserom.gb", $20FDC, $20FDE - $20FDC

UnknownData_0x20FDE:
INCBIN "baserom.gb", $20FDE, $20FDF - $20FDE

Logged_0x20FDF:
	ld hl,$C0FA
	ld a,[hl]
	and a
	jr z,Logged_0x2102D
	xor a
	ld [hl],a
	ld hl,$C116
	set 6,[hl]
	ld a,[$C100]
	cp $FC
	jr nz,Logged_0x2103D
	ld a,[$FF00+$90]
	cp $02
	jr nz,Unknown_0x21000
	ld a,[$FF00+$91]
	cp $01
	jr nz,Logged_0x2103D

Unknown_0x21000:
	ld a,[$FF00+$90]
	cp $02
	jr z,Unknown_0x2100F
	ld a,$01
	ld [$D245],a
	xor a
	ld [$D243],a

Unknown_0x2100F:
	ld a,$02
	ld [$FF00+$90],a
	ld a,$FB
	ld [$C109],a
	ld a,$0D
	ld [$FF00+$91],a
	ld a,[$C119]
	and a
	jr z,Unknown_0x21027
	ld hl,$C116
	set 0,[hl]

Unknown_0x21027:
	xor a
	ld [$C117],a
	scf
	ret

Logged_0x2102D:
	ld a,[$FF00+$90]
	cp $01
	jr nz,Logged_0x2103D
	ld a,[$FF00+$01]
	cp $FD
	jr z,Logged_0x2103D
	ld a,$80
	ld [$FF00+$02],a

Logged_0x2103D:
	and a
	ret

Logged_0x2103F:
	ld a,[$FF00+$8B]
	and $84
	jr z,Logged_0x21058
	ld a,[hl]
	cp e
	jr z,Logged_0x21051
	add a,b
	ld [hl],a
	ld hl,$DC06
	set 4,[hl]
	ret

Logged_0x21051:
	ld [hl],d
	ld hl,$DC06
	set 4,[hl]
	ret

Logged_0x21058:
	ld a,[$FF00+$8B]
	and $40
	ret z
	ld a,[hl]
	cp d
	jr z,Unknown_0x21069
	sub b
	ld [hl],a
	ld hl,$DC06
	set 4,[hl]
	ret

Unknown_0x21069:
	ld [hl],e
	ld hl,$DC06
	set 4,[hl]
	ret

Logged_0x21070:
	ld hl,$D22F
	ld a,[$FF00+$96]
	and $08
	or [hl]
	ld [hl],a
	ld a,[$D22E]
	rst JumpList
	dw Logged_0x21095
	dw Logged_0x211D9
	dw Logged_0x2122C
	dw Logged_0x21276
	dw Logged_0x212B6
	dw Logged_0x212BB
	dw Logged_0x2136E
	dw Logged_0x213D8
	dw Logged_0x21497
	dw Logged_0x2155F
	dw Logged_0x215D1
	dw Logged_0x215EA

Logged_0x21095:
	call Logged_0x05CC
	ld a,$E3
	ld [$C0A7],a
	ld a,$70
	ld [$FF00+$42],a
	ld [$D234],a
	xor a
	ld [$FF00+$43],a
	ld [$D235],a
	ld hl,$C0DE
	ld [hli],a
	ld [hl],a
	ld [$C127],a
	ld [$C128],a
	inc a
	ld [$C156],a
	ld [$C157],a
	ld hl,$D230
	ld a,$01
	ld [hli],a
	ld a,$00
	ld [hli],a
	ld a,$00
	ld [hli],a
	ld a,$20
	ld [hl],a
	ld a,$E4
	ld [$FF00+$47],a
	ld a,$0E
	call Logged_0x0A96
	ld hl,$9800
	ld a,$E1
	ld bc,$0400
	call Logged_0x0914
	ld hl,$9800
	ld de,$6B47
	ld bc,$1214
	call Logged_0x209E2
	ld hl,$C9E6
	ld a,$08
	sub [hl]
	rra
	ld e,a
	ld [$D237],a
	dec hl
	ld a,$08
	sub [hl]
	rra
	ld [$D236],a
	swap a
	add a,a
	ld d,a
	ld a,e
	add a,d
	ld c,a
	ld b,$00
	ld hl,$984B
	add hl,bc
	ld a,[$C9E5]
	ld b,a

Logged_0x2110F:
	push bc
	push hl
	ld a,[$C9E6]
	ld c,a
	ld a,$DF
	call Logged_0x091D
	pop hl
	ld bc,$0020
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x2110F
	ld hl,$CE5C
	ld a,[hld]
	push hl
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld a,[$C150]
	and a
	jr z,Logged_0x2113E
	add a,a
	add a,$CB
	ld [$99E1],a
	inc a
	ld [$9A01],a

Logged_0x2113E:
	ld a,[$C151]
	add a,a
	add a,$CB
	ld [$99E2],a
	inc a
	ld [$9A02],a
	pop hl
	ld a,[hld]
	push hl
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld a,[$C150]
	add a,a
	add a,$CB
	ld [$99E4],a
	inc a
	ld [$9A04],a
	ld a,[$C151]
	add a,a
	add a,$CB
	ld [$99E5],a
	inc a
	ld [$9A05],a
	pop hl
	ld a,[hl]
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld a,[$C150]
	add a,a
	add a,$CB
	ld [$99E7],a
	inc a
	ld [$9A07],a
	ld a,[$C151]
	add a,a
	add a,$CB
	ld [$99E8],a
	inc a
	ld [$9A08],a
	ld hl,$51CD
	ld de,$CE82
	ld c,$06
	call Logged_0x092B
	ld hl,$51D3
	ld de,$CE9C
	ld c,$06
	call Logged_0x092B
	ld a,$68
	call Logged_0x1629
	ld a,$68
	call Logged_0x3262
	ld a,$01
	ld [$D243],a
	ld a,$03
	ld [$D244],a
	ld hl,$CE75
	ld a,$10
	ld [hli],a
	ld [hl],$00
	xor a
	ld [$CE78],a
	ld hl,$D22E
	inc [hl]
	jp Logged_0x060E

LoggedData_0x211CD:
INCBIN "baserom.gb", $211CD, $211D9 - $211CD

Logged_0x211D9:
	ld hl,$D231
	ld a,[$D235]
	sub [hl]
	ld [$D235],a
	dec hl
	ld a,[$D234]
	sbc a,[hl]
	ld [$D234],a
	cp $F0
	jr c,Logged_0x21210
	ld a,$FC
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld hl,$D232
	ld a,$00
	ld [hli],a
	ld a,$40
	ld [hl],a
	xor a
	ld [$FF00+$42],a
	ld hl,$D234
	ld [hli],a
	ld [hl],a
	ld hl,$D22E
	inc [hl]
	ld hl,$DC0C
	set 6,[hl]
	ret

Logged_0x21210:
	ld a,[$D234]
	ld [$FF00+$42],a
	ld hl,$D231
	ld a,[$D233]
	add a,[hl]
	ld [hld],a
	ld a,[$D232]
	adc a,[hl]
	ld [hl],a
	cp $04
	ret c
	ld a,$04
	ld [hli],a
	ld a,$00
	ld [hld],a
	ret

Logged_0x2122C:
	ld hl,$D231
	ld a,[$D235]
	sub [hl]
	ld [$D235],a
	dec hl
	ld a,[$D234]
	sbc a,[hl]
	ld [$D234],a
	cp $F0
	jr c,Logged_0x21263
	ld a,$FE
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld hl,$D232
	ld a,$00
	ld [hli],a
	ld a,$40
	ld [hl],a
	xor a
	ld [$FF00+$42],a
	ld hl,$D234
	ld [hli],a
	ld [hl],a
	ld hl,$D22E
	inc [hl]
	ld hl,$DC0C
	set 6,[hl]
	ret

Logged_0x21263:
	ld a,[$D234]
	ld [$FF00+$42],a
	ld hl,$D231
	ld a,[$D233]
	add a,[hl]
	ld [hld],a
	ld a,[$D232]
	adc a,[hl]
	ld [hl],a
	ret

Logged_0x21276:
	ld hl,$D231
	ld a,[$D235]
	sub [hl]
	ld [$D235],a
	dec hl
	ld a,[$D234]
	sbc a,[hl]
	ld [$D234],a
	cp $F0
	jr c,Logged_0x212A3
	xor a
	ld [$FF00+$42],a
	ld hl,$D22E
	inc [hl]
	ld a,$36
	call Logged_0x1629
	ld a,$36
	call Logged_0x3262
	ld hl,$DC0C
	set 6,[hl]
	ret

Logged_0x212A3:
	ld a,[$D234]
	ld [$FF00+$42],a
	ld hl,$D231
	ld a,[$D233]
	add a,[hl]
	ld [hld],a
	ld a,[$D232]
	adc a,[hl]
	ld [hl],a
	ret

Logged_0x212B6:
	ld hl,$D22E
	inc [hl]
	ret

Logged_0x212BB:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld b,$18
	ld a,[$D22F]
	bit 3,a
	jr z,Logged_0x212CB
	ld b,$02

Logged_0x212CB:
	ld a,b
	ld [hli],a
	ld a,[hl]
	push af
	ld c,a
	ld b,$00
	ld hl,$CE54
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,a
	add a,[hl]
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$CE78
	add a,[hl]
	ld [hl],a
	pop af
	add a,a
	add a,a
	ld l,a
	add a,a
	add a,a
	add a,l
	ld l,a
	ld h,$00
	add hl,bc
	ld bc,$533A
	add hl,bc
	ld de,$CE88
	ld c,$0A
	call Logged_0x092B
	ld hl,$CE76
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$5362
	add hl,bc
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld de,$CE7C
	call Logged_0x09A3
	call Logged_0x2167A
	ld hl,$CE76
	inc [hl]
	ld a,[hl]
	cp $02
	ret c
	ld hl,$CE75
	ld b,$30
	ld a,[$D22F]
	bit 3,a
	jr z,Logged_0x21331
	ld b,$02

Logged_0x21331:
	ld a,b
	ld [hli],a
	ld [hl],$00
	ld hl,$D22E
	inc [hl]
	ret

UnknownData_0x2133A:
INCBIN "baserom.gb", $2133A, $21344 - $2133A

LoggedData_0x21344:
INCBIN "baserom.gb", $21344, $2134E - $21344

UnknownData_0x2134E:
INCBIN "baserom.gb", $2134E, $21358 - $2134E

LoggedData_0x21358:
INCBIN "baserom.gb", $21358, $2136E - $21358

Logged_0x2136E:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld hl,$53BA
	ld a,[$CE53]
	bit 6,a
	jr z,Logged_0x2138A
	ld hl,$CE78
	ld a,[hl]
	add a,$14
	ld [hl],a
	call Logged_0x2167A
	ld hl,$53BE

Logged_0x2138A:
	ld de,$CE88
	ld c,$0A
	call Logged_0x092B
	ld hl,$53C2
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld de,$CE7C
	call Logged_0x09A3
	ld hl,$CE75
	ld b,$30
	ld a,[$D22F]
	bit 3,a
	jr z,Logged_0x213B1
	ld b,$02

Logged_0x213B1:
	ld a,b
	ld [hli],a
	ld [hl],$00
	ld hl,$D22E
	inc [hl]
	ret

LoggedData_0x213BA:
INCBIN "baserom.gb", $213BA, $213D8 - $213BA

Logged_0x213D8:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld hl,$53C8
	ld de,$CE88
	ld c,$0A
	call Logged_0x092B
	ld hl,$53D2
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld a,[$CE66]
	and a
	jr nz,Logged_0x21410
	ld a,$CB
	ld [$CE89],a
	ld [$CE8C],a
	inc a
	ld [$CE8E],a
	ld [$CE91],a
	ld de,$CE7C
	call Logged_0x09A3
	jr Logged_0x2147C

Logged_0x21410:
	ld hl,$CE75
	ld a,$02
	ld [hli],a
	ld a,[hl]
	inc a
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld a,[$C150]
	and a
	jr z,Logged_0x2142E
	add a,a
	add a,$CB
	ld [$CE88],a
	inc a
	ld [$CE8D],a

Logged_0x2142E:
	ld a,[$C151]
	add a,a
	add a,$CB
	ld [$CE89],a
	inc a
	ld [$CE8E],a
	ld a,[$CE76]
	inc a
	add a,a
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld a,[$C150]
	and a
	jr z,Logged_0x21456
	add a,a
	add a,$CB
	ld [$CE8B],a
	inc a
	ld [$CE90],a

Logged_0x21456:
	ld a,[$C151]
	add a,a
	add a,$CB
	ld [$CE8C],a
	inc a
	ld [$CE91],a
	ld de,$CE7C
	call Logged_0x09A3
	ld hl,$CE78
	ld a,[hl]
	add a,$02
	ld [hl],a
	call Logged_0x2167A
	ld hl,$CE76
	inc [hl]
	ld a,[$CE66]
	cp [hl]
	ret nz

Logged_0x2147C:
	ld hl,$CE75
	ld b,$30
	ld a,[$D22F]
	bit 3,a
	jr z,Logged_0x2148A
	ld b,$02

Logged_0x2148A:
	ld a,b
	ld [hli],a
	ld [hl],$00
	xor a
	ld [$D238],a
	ld hl,$D22E
	inc [hl]
	ret

Logged_0x21497:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld hl,$5559
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld hl,$CE75
	ld b,$04
	ld a,[$D22F]
	bit 3,a
	jr z,Logged_0x214B5
	ld b,$02

Logged_0x214B5:
	ld a,b
	ld [hli],a
	ld a,[hl]
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$C923
	add hl,bc
	ld a,[$CE73]
	dec a
	cp [hl]
	jr nz,Logged_0x214CE
	ld hl,$D238
	inc [hl]
	jr Logged_0x2150B

Logged_0x214CE:
	ld a,[hl]
	ld l,a
	ld h,$00
	ld a,[$C9E6]
	ld b,a
	call Logged_0x32D9
	push af
	ld a,l
	swap a
	ld l,a
	add hl,hl
	pop af
	ld c,a
	ld b,$00
	add hl,bc
	push hl
	ld a,[$D236]
	swap a
	add a,a
	ld hl,$D237
	add a,[hl]
	ld c,a
	ld b,$00
	pop hl
	add hl,bc
	ld bc,$984B
	add hl,bc
	ld a,l
	ld [$CE7C],a
	ld a,h
	ld [$CE7D],a
	ld a,$E0
	ld [$CE88],a
	ld de,$CE7C
	call Logged_0x09A3

Logged_0x2150B:
	ld hl,$CE76
	inc [hl]
	ld a,[$C922]
	cp [hl]
	ret nz
	ld l,a
	ld h,$00
	ld a,[$D238]
	and a
	jr z,Logged_0x2151E
	dec l

Logged_0x2151E:
	ld de,$0064
	call Logged_0x32F6
	push hl
	ld a,[$C9E5]
	ld l,a
	ld h,$00
	ld a,[$C9E6]
	ld e,a
	ld d,$00
	call Logged_0x32F6
	ld b,l
	pop hl
	call Logged_0x32D9
	ld b,$05
	call Logged_0x32D9
	ld a,l
	ld [$CE77],a
	ld hl,$CE75
	ld b,$10
	ld a,[$D22F]
	bit 3,a
	jr z,Logged_0x21550
	ld b,$02

Logged_0x21550:
	ld a,b
	ld [hli],a
	ld [hl],$00
	ld hl,$D22E
	inc [hl]
	ret

LoggedData_0x21559:
INCBIN "baserom.gb", $21559, $2155F - $21559

Logged_0x2155F:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$02
	ld [hl],a
	ld hl,$55CD
	ld de,$CE88
	ld c,$04
	call Logged_0x092B
	ld hl,$55C7
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld a,[$CE76]
	inc a
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld a,[$C150]
	and a
	jr z,Logged_0x21597
	add a,a
	add a,$CB
	ld [$CE88],a
	inc a
	ld [$CE8A],a

Logged_0x21597:
	ld a,[$C151]
	add a,a
	add a,$CB
	ld [$CE89],a
	inc a
	ld [$CE8B],a
	ld de,$CE7C
	call Logged_0x09A3
	ld hl,$CE78
	inc [hl]
	call Logged_0x2167A
	ld hl,$CE76
	inc [hl]
	ld a,[$CE77]
	cp [hl]
	ret nz
	ld hl,$CE75
	ld a,$10
	ld [hli],a
	ld [hl],$00
	ld hl,$D22E
	inc [hl]
	ret

LoggedData_0x215C7:
INCBIN "baserom.gb", $215C7, $215D1 - $215C7

Logged_0x215D1:
	ld a,[$CE78]
	cp $64
	jr nz,Logged_0x215DF
	ld hl,$DC03
	set 4,[hl]
	jr Logged_0x215DF

Logged_0x215DF:
	ld a,[$CE78]
	ld [$CE65],a
	ld hl,$D22E
	inc [hl]
	ret

Logged_0x215EA:
	ld a,[$FF00+$96]
	and $09
	ret z
	ld hl,$DC06
	set 5,[hl]
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$CE5D
	add hl,bc
	ld a,[hl]
	push hl
	push af
	ld a,[$CE65]
	cp [hl]
	jp z,Logged_0x2160C
	jp c,Logged_0x2160C
	ld [hl],a

Logged_0x2160C:
	ld a,[$CE58]
	push af
	ld a,[$CC40]
	cp $01
	jr nz,Logged_0x2161B
	ld b,$06
	jr Logged_0x21621

Logged_0x2161B:
	cp $7F
	jr nz,Logged_0x21625
	ld b,$07

Logged_0x21621:
	ld a,b
	ld [$CE58],a

Logged_0x21625:
	ld a,$0A
	ld [$0000],a
	ld a,[$C9E4]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$566A
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	add hl,bc
	ld a,[hl]
	ld [$CFDD],a
	ld a,[$CE70]
	call Logged_0x20B03
	pop af
	ld [$CE58],a
	pop af
	pop hl
	ld [hl],a
	xor a
	ld [$C156],a
	ld [$D22F],a
	ld [$D22E],a
	ld [$C154],a
	ld a,$12
	ld [$FF00+$91],a
	ld bc,$0140
	jp Logged_0x0AE5

LoggedData_0x2166A:
INCBIN "baserom.gb", $2166A, $21678 - $2166A

UnknownData_0x21678:
INCBIN "baserom.gb", $21678, $2167A - $21678

Logged_0x2167A:
	ld hl,$DC06
	set 4,[hl]
	ld a,[$CE78]
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld a,[$C14F]
	and a
	jr z,Logged_0x2169A
	add a,a
	add a,$CB
	ld [$CE9C],a
	inc a
	ld [$CE9F],a
	jr Logged_0x216A0

Logged_0x2169A:
	ld a,[$C150]
	and a
	jr z,Logged_0x216AD

Logged_0x216A0:
	ld a,[$C150]
	add a,a
	add a,$CB
	ld [$CE9D],a
	inc a
	ld [$CEA0],a

Logged_0x216AD:
	ld a,[$C151]
	add a,a
	add a,$CB
	ld [$CE9E],a
	inc a
	ld [$CEA1],a
	ld de,$CE82
	jp Logged_0x09A3

Logged_0x216C0:
	ld hl,$5704
	push hl
	ld a,[$C154]
	rst JumpList
	dw Logged_0x21710
	dw Logged_0x218F9
	dw Logged_0x2193D
	dw Logged_0x21A37
	dw Logged_0x21A69
	dw Logged_0x21BE2
	dw Logged_0x21C0D
	dw Logged_0x21C8E
	dw Logged_0x21D21
	dw Logged_0x21E70
	dw Logged_0x21F26
	dw Logged_0x21F3D
	dw Logged_0x220AA
	dw Logged_0x220F9
	dw Logged_0x22187
	dw Logged_0x22199
	dw Logged_0x221F3
	dw Logged_0x22288
	dw Logged_0x22369
	dw Logged_0x2238B
	dw Logged_0x223B0
	dw Logged_0x223D2
	dw Logged_0x223F7
	dw Logged_0x22419
	dw Logged_0x2243E
	dw Logged_0x22455
	dw Logged_0x22468
	dw Logged_0x22468
	dw Logged_0x224BC
	dw Logged_0x2255C
	call Logged_0x3AED
	call Logged_0x2960
	call Logged_0x140E
	jp Logged_0x0F09

Logged_0x21710:
	call Logged_0x05CC
	ld hl,$FFFF
	res 1,[hl]
	ld hl,$C0A6
	res 1,[hl]
	ld hl,$C127
	xor a
	ld c,$23
	call Logged_0x091D
	ld a,$D8
	ld [$C1A5],a
	xor a
	ld [$FF00+$45],a
	ld [$C1A4],a
	ld hl,$C0DE
	ld [hli],a
	ld [hl],a
	ld [$C157],a
	ld a,$02
	ld [$C156],a
	ld hl,$C0A7
	res 5,[hl]
	ld hl,$D141
	set 7,[hl]
	ld a,$0C
	call Logged_0x0A96
	ld hl,$9800
	xor a
	ld bc,$0400
	call Logged_0x0914
	call Logged_0x3287
	ld bc,$881C
	ld de,$58DB
	ld hl,$C2A0
	call Logged_0x309F
	ld bc,$7035
	ld de,$58DF
	ld hl,$C2C0
	call Logged_0x309F
	ld bc,$703B
	ld de,$58E3
	ld hl,$C2E0
	call Logged_0x309F
	ld bc,$7043
	ld de,$58E7
	ld hl,$C300
	call Logged_0x309F
	ld bc,$7952
	ld de,$58EB
	ld hl,$C320
	call Logged_0x309F
	ld a,$0A
	ld [$C154],a
	ld a,[$C9E4]
	call Logged_0x22844
	ld a,[$D12A]
	bit 2,a
	jr nz,Logged_0x217AC
	bit 1,a
	jr z,Logged_0x217D9

Logged_0x217AC:
	ld a,[$CE58]
	and a
	jr nz,Logged_0x217D9
	ld hl,$D074
	ld a,$1A
	ld [hli],a
	inc a
	ld [hl],a
	ld hl,$D07F
	ld a,$B8
	ld [hli],a
	inc a
	ld [hl],a
	ld hl,$D08A
	ld de,$58EF
	ld c,$05

Logged_0x217CA:
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hld],a
	inc de
	push bc
	ld bc,$000B
	add hl,bc
	pop bc
	dec c
	jr nz,Logged_0x217CA

Logged_0x217D9:
	ld hl,$9800
	ld de,$D000
	ld bc,$110B
	call Logged_0x209E2
	ld a,$09
	ld [$C154],a
	ld a,[$C9E4]
	inc a
	call Logged_0x22844
	ld hl,$980A
	ld de,$D000
	ld bc,$110B
	call Logged_0x209E2
	ld a,$0A
	ld [$C154],a
	ld a,[$C9E4]
	dec a
	call Logged_0x22844
	ld hl,$9815
	ld de,$D000
	ld bc,$110B
	call Logged_0x209E2
	ld a,$37
	call Logged_0x1629
	ld a,$37
	call Logged_0x3262
	ld hl,$D12A
	bit 2,[hl]
	jr z,Logged_0x2182A
	res 2,[hl]
	jr Logged_0x2187A

Logged_0x2182A:
	ld a,[$D12A]
	bit 1,a
	jr nz,Logged_0x21881
	ld a,[$CE58]
	and a
	jr nz,Logged_0x2187A
	ld hl,$99E6
	ld a,$1E
	ld [hli],a
	inc a
	ld [hld],a
	ld bc,$0020
	add hl,bc
	ld a,$24
	ld [hli],a
	inc a
	ld [hl],a
	ld hl,$C200
	ld a,$01
	ld [hli],a
	ld a,$B2
	ld [hli],a
	ld a,$06
	ld [hli],a
	ld a,$68
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld [hl],$60
	ld bc,$8860
	ld de,$58D3
	ld hl,$C220
	call Logged_0x309F
	ld a,$01
	ld [$C154],a
	ld a,$04
	ld [$CE75],a
	ld hl,$D12A
	set 6,[hl]
	jp Logged_0x060E

Logged_0x2187A:
	ld a,[$D12A]
	bit 1,a
	jr z,Logged_0x2188E

Logged_0x21881:
	ld b,$06
	ld a,[$CC40]
	cp $01
	jr nz,Logged_0x2188E
	ld a,b
	ld [$CE58],a

Logged_0x2188E:
	ld hl,$C201
	ld a,$B2
	ld [hli],a
	ld a,[$C9E4]
	add a,$0E
	ld [hli],a
	ld a,$68
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld [hl],$60
	ld bc,$5860
	ld de,$58D7
	ld hl,$C220
	call Logged_0x309F
	call Logged_0x226B8
	ld a,$08
	ld [$C154],a
	ld a,$04
	ld [$CE75],a
	ld hl,$D12A
	set 6,[hl]
	jp Logged_0x060E

LoggedData_0x218C3:
INCBIN "baserom.gb", $218C3, $218F9 - $218C3

Logged_0x218F9:
	ld hl,$CE75
	dec [hl]
	ret nz
	call Logged_0x05D9
	ld hl,$FF47
	ld a,$E4
	ld [hli],a
	ld a,$1C
	ld [hli],a
	ld [hl],$84
	ld hl,$C225
	ld a,$FF
	ld [hli],a
	ld [hl],$00
	ld hl,$C22D
	ld c,$0C
	call Logged_0x31C3
	ld hl,$C22C
	set 7,[hl]
	ld a,$02
	ld [$C154],a
	ld hl,$CE78
	res 0,[hl]
	ld hl,$D12A
	res 6,[hl]
	ld a,$01
	ld [$D243],a
	ld a,$12
	ld [$D244],a
	jp Logged_0x060E

Logged_0x2193D:
	ld hl,$C223
	ld a,[hli]
	and $07
	ret nz
	ld a,[hld]
	and a
	ret nz
	ld a,[hl]
	cp $58
	jr nz,Logged_0x2196A
	inc hl
	inc hl
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$DC03
	set 7,[hl]
	ld a,$03
	ld [$C154],a
	xor a
	ld [$C200],a
	ld b,$59
	xor a
	ld c,a
	ld d,a
	ld hl,$C221
	jp Logged_0x31AF

Logged_0x2196A:
	ld a,[$CE78]
	rra
	ret c
	ld a,[hl]
	cp $60
	ret z
	cp $68
	jr nz,Logged_0x219CA
	ld hl,$5A1F
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld hl,$CE88
	ld a,$1A
	ld [hli],a
	inc a
	ld [hli],a
	ld a,$B8
	ld [hli],a
	inc a
	ld [hl],a
	ld a,[$C1A5]
	add a,$58
	srl a
	srl a
	srl a
	ld c,a
	ld b,$00
	ld hl,$9940
	add hl,bc
	ld de,$CE7C
	ld a,l
	ld [de],a
	inc de
	ld a,h
	ld [de],a
	ld bc,$5A60
	ld de,$5A29
	ld hl,$C240
	call Logged_0x309F
	ld a,$FA
	add a,l
	ld e,a
	ld d,h
	call Logged_0x31D7
	ld hl,$C202
	ld a,[hl]
	add a,$08
	ld [hl],a
	ld de,$CE7C
	jp Logged_0x09A3

Logged_0x219CA:
	ld hl,$DC03
	set 6,[hl]
	ld hl,$5A19
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld de,$5A25
	ld a,[$C223]
	cp $70
	jr z,Logged_0x219E7
	ld de,$5A27

Logged_0x219E7:
	ld hl,$CE88
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld a,[$C223]
	sub $10
	and $F8
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld a,[$C1A5]
	add a,$58
	srl a
	srl a
	srl a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$9800
	add hl,bc
	ld de,$CE7D
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	jp Logged_0x09A3

LoggedData_0x21A19:
INCBIN "baserom.gb", $21A19, $21A37 - $21A19

Logged_0x21A37:
	ld hl,$C22C
	bit 6,[hl]
	ret z
	res 6,[hl]
	ld a,$04
	ld [$C154],a
	ld a,$04
	ld [$C0AC],a
	ld a,[$C9E4]
	add a,$38
	push af
	call Logged_0x1629
	db $76;halt
	ld hl,$C0A5
	res 0,[hl]

Logged_0x21A58:
	bit 0,[hl]
	jr z,Logged_0x21A58
	res 0,[hl]
	pop af
	call Logged_0x3262
	xor a
	ld [$C0AC],a
	jp Logged_0x226B8

Logged_0x21A69:
	ld a,[$FF00+$96]
	and $09
	jp z,Logged_0x21B0A
	ld hl,$DC06
	set 5,[hl]
	ld hl,$CE75
	ld a,$08
	ld [hli],a
	ld [hl],$07
	ld a,[$C9E4]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$58C3
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld bc,$000B
	add hl,bc
	ld de,$D000
	ld c,$07
	call Logged_0x092B
	inc hl
	inc hl
	inc hl
	ld c,$07
	call Logged_0x092B
	ld a,[$C1A5]
	add a,$30
	srl a
	srl a
	srl a
	ld b,a
	cp $1A
	jr c,Logged_0x21AFB
	ld a,$20
	sub b
	ld [$D24B],a
	ld hl,$D000
	ld de,$D00E
	ld c,$0E
	call Logged_0x092B
	ld hl,$D00E
	ld de,$D000
	ld a,[$D24B]
	ld c,a
	call Logged_0x092B
	ld hl,$D015
	ld a,[$D24B]
	ld c,a
	call Logged_0x092B
	ld a,[$D24B]
	ld c,a
	ld b,$00
	ld hl,$D00E
	add hl,bc
	ld a,[$D24B]
	sub $07
	cpl
	inc a
	ld c,a
	push bc
	call Logged_0x092B
	ld a,[$D24B]
	ld c,a
	ld b,$00
	ld hl,$D015
	add hl,bc
	pop bc
	call Logged_0x092B

Logged_0x21AFB:
	ld hl,$D00E
	xor a
	ld c,$0E
	call Logged_0x091D
	ld a,$0D
	ld [$C154],a
	ret

Logged_0x21B0A:
	ld a,[$FF00+$96]
	rla
	jr nc,Logged_0x21B7E
	ld hl,$DC09
	set 6,[hl]
	ld a,$04
	ld [$C0AC],a
	ld a,$37
	call Logged_0x1629
	db $76;halt
	ld hl,$C0A5
	res 0,[hl]

Logged_0x21B24:
	bit 0,[hl]
	jr z,Logged_0x21B24
	res 0,[hl]
	ld a,$37
	call Logged_0x3262
	xor a
	ld [$C0AC],a
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A00B
	add hl,bc
	ld e,l
	ld d,h
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$697A
	add hl,bc
	ld a,[de]
	and [hl]
	ld a,$00
	ld [$0000],a
	jr nz,Logged_0x21B68
	ld a,$01
	ld [$C330],a
	ld [$C310],a
	ld [$C2F0],a
	ld [$C2D0],a

Logged_0x21B68:
	ld a,$05
	ld [$C154],a
	ld a,$01
	ld [$C200],a
	ld hl,$C221
	ld b,$59
	ld c,$03
	ld d,$0E
	jp Logged_0x31B3

Logged_0x21B7E:
	ld a,[$FF00+$96]
	bit 2,a
	ret z
	ld a,$1C
	ld [$C154],a
	ld bc,$794C
	ld de,$5BDA
	ld hl,$C340
	call Logged_0x309F
	ld bc,$7943
	ld de,$5BDE
	ld hl,$C360
	call Logged_0x309F
	ld hl,$DC07
	set 0,[hl]
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A00B
	add hl,bc
	ld e,l
	ld d,h
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$697A
	add hl,bc
	ld a,[de]
	and [hl]
	ld a,$00
	ld [$0000],a
	ret nz
	ld a,$01
	ld [$C330],a
	ld [$C310],a
	ld [$C2F0],a
	ld [$C2D0],a
	ret

LoggedData_0x21BDA:
INCBIN "baserom.gb", $21BDA, $21BE2 - $21BDA

Logged_0x21BE2:
	ld hl,$C22C
	bit 6,[hl]
	ret z
	ld hl,$DC04
	set 0,[hl]
	res 6,[hl]
	ld a,$06
	ld [$C154],a
	ld hl,$C223
	ld a,[hl]
	add a,$0A
	ld [hli],a
	inc hl
	ld a,$01
	ld [hli],a
	ld [hl],$00
	ld hl,$C221
	ld b,$51
	ld c,$04
	ld d,$00
	jp Logged_0x31B3

Logged_0x21C0D:
	ld hl,$C223
	ld a,[hli]
	cp $88
	ret c
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	xor a
	ld [$C200],a
	ld a,[$CE78]
	rla
	jr c,Logged_0x21C38
	ld a,$07
	ld [$C154],a
	ld hl,$C22C
	res 7,[hl]
	ld hl,$C221
	ld b,$53
	ld c,$04
	ld d,$00
	jp Logged_0x31B3

Logged_0x21C38:
	ld hl,$5C8C
	ld de,$CE9C
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$5F20
	ld de,$CE82
	ld c,$06
	call Logged_0x092B
	ld a,[$C1A5]
	and $F8
	add a,$60
	srl a
	srl a
	srl a
	ld c,a
	ld b,$00
	ld hl,$99E0
	add hl,bc
	ld de,$CE83
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	call Logged_0x09A3
	ld a,$0F
	ld [$C154],a
	ld a,$08
	ld [$CE75],a
	xor a
	ld [$CE76],a
	ld hl,$C22C
	res 7,[hl]
	ld hl,$C221
	ld b,$53
	ld c,$04
	ld d,$00
	jp Logged_0x31B3

LoggedData_0x21C8C:
INCBIN "baserom.gb", $21C8C, $21C8E - $21C8C

Logged_0x21C8E:
	ld a,[$FF00+$96]
	bit 5,a
	jr z,Logged_0x21CBD
	ld hl,$C221
	ld b,$52
	ld c,$04
	ld d,$00
	call Logged_0x31B3
	ld a,[$C9E4]
	and a
	ret z
	ld a,$0A
	ld [$C154],a
	ld a,[$C9E4]
	sub $02
	call Logged_0x22844
	ld hl,$C22C
	set 7,[hl]
	ld a,$0B
	ld [$CE75],a
	ret

Logged_0x21CBD:
	bit 4,a
	jr z,Logged_0x21CEC
	ld hl,$C221
	ld b,$53
	ld c,$04
	ld d,$00
	call Logged_0x31B3
	ld a,[$CE58]
	ld hl,$C9E4
	cp [hl]
	ret z
	ld a,$09
	ld [$C154],a
	ld a,[$C9E4]
	add a,$02
	call Logged_0x22844
	ld hl,$C22C
	set 7,[hl]
	xor a
	ld [$CE75],a
	ret

Logged_0x21CEC:
	ld a,[$FF00+$96]
	bit 6,a
	ret z
	ld a,$02
	ld [$C154],a
	ld hl,$CE78
	set 0,[hl]
	ld a,$01
	ld [$C200],a
	ld a,[$C9E4]
	add a,$0E
	ld [$C202],a
	ld hl,$C22C
	set 7,[hl]
	ld hl,$C225
	ld a,$FF
	ld [hli],a
	ld [hl],$00
	ld hl,$C221
	ld b,$50
	ld c,$04
	ld d,$00
	jp Logged_0x31B3

Logged_0x21D21:
	ld hl,$CE75
	dec [hl]
	ret nz
	call Logged_0x05D9
	ld hl,$FF47
	ld a,$E4
	ld [hli],a
	ld a,$1C
	ld [hli],a
	ld [hl],$84
	ld a,[$C9E4]
	add a,$38
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$CE5D
	add hl,bc
	ld a,[$CE65]
	cp [hl]
	jp z,Logged_0x21E04
	jp c,Logged_0x21E04
	ld [hl],a
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld de,$D000
	ld hl,$C14F
	ld b,$00
	ld a,[hli]
	and a
	jr z,Logged_0x21D6B
	add a,$F6
	ld b,a

Logged_0x21D6B:
	ld a,b
	ld [de],a
	inc de
	ld a,[hld]
	and a
	jr nz,Logged_0x21D79
	ld b,$00
	ld a,[hl]
	and a
	jr z,Logged_0x21D7C
	ld a,b

Logged_0x21D79:
	add a,$F6
	ld b,a

Logged_0x21D7C:
	ld a,b
	ld [de],a
	inc de
	inc hl
	inc hl
	ld a,[hl]
	add a,$F6
	ld [de],a
	ld hl,$CE75
	ld a,$40
	ld [hli],a
	ld [hl],$00
	ld bc,$2848
	ld de,$5E5C
	ld hl,$C240
	call Logged_0x309F
	ld hl,$C24D
	ld c,$00
	call Logged_0x31C3
	ld bc,$2850
	ld de,$5E5C
	ld hl,$C260
	call Logged_0x309F
	ld hl,$C26D
	ld c,$00
	call Logged_0x31C3
	ld bc,$2858
	ld de,$5E5C
	ld hl,$C280
	call Logged_0x309F
	ld hl,$C28D
	ld c,$00
	call Logged_0x31C3
	ld a,$0B
	ld [$C154],a
	ld hl,$CE88
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$DB
	ld [hli],a
	inc a
	ld [hl],a
	ld hl,$5E6A
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld a,[$C1A5]
	add a,$58
	srl a
	srl a
	srl a
	ld c,a
	ld b,$00
	ld hl,$985D
	add hl,bc
	ld de,$CE7D
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	call Logged_0x09A3
	jr Logged_0x21E4A

Logged_0x21E04:
	ld a,[$D12A]
	bit 1,a
	jr z,Logged_0x21E40
	ld a,[$CC40]
	cp $01
	jr nz,Logged_0x21E40
	ld a,$37
	call Logged_0x1629
	ld a,$37
	call Logged_0x3262
	ld a,$05
	ld [$C154],a
	ld a,$01
	ld [$C200],a
	ld hl,$CE78
	res 0,[hl]
	set 7,[hl]
	ld hl,$C22C
	set 7,[hl]
	ld hl,$C221
	ld b,$59
	ld c,$03
	ld d,$0E
	call Logged_0x31B3
	jr Logged_0x21E4A

Logged_0x21E40:
	ld hl,$C22C
	set 7,[hl]
	ld a,$04
	ld [$C154],a

Logged_0x21E4A:
	ld hl,$D12A
	res 6,[hl]
	ld a,$01
	ld [$D243],a
	ld a,$12
	ld [$D244],a
	jp Logged_0x060E

LoggedData_0x21E5C:
INCBIN "baserom.gb", $21E5C, $21E70 - $21E5C

Logged_0x21E70:
	call Logged_0x2279F
	ld a,[$CE78]
	rla
	jp nc,Logged_0x21F05
	ld a,[$C1A5]
	and $07
	cp $07
	jr nz,Unknown_0x21ED0
	ld hl,$DC03
	set 6,[hl]
	ld a,[$CE75]
	cp $09
	jr c,Unknown_0x21E9B
	sub $09
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5F1C
	add hl,bc
	jr Unknown_0x21E9E

Unknown_0x21E9B:
	ld hl,$5F1A

Unknown_0x21E9E:
	ld de,$CE9C
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$5F20
	ld de,$CE82
	ld c,$06
	call Logged_0x092B
	ld a,[$C1A5]
	and $F8
	add a,$68
	srl a
	srl a
	srl a
	ld c,a
	ld b,$00
	ld hl,$99E0
	add hl,bc
	ld de,$CE83
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	jp Logged_0x09A3

Unknown_0x21ED0:
	ld a,[$CE75]
	cp $0B
	ret c
	ld hl,$CE78
	res 0,[hl]
	res 7,[hl]
	ld a,$02
	ld [$C154],a
	ld hl,$C9E4
	inc [hl]
	ld a,[hl]
	add a,$06
	ld [$C202],a
	ld a,$01
	ld [$C200],a
	ld hl,$C225
	ld a,$FF
	ld [hli],a
	ld [hl],$00
	ld hl,$C221
	ld b,$54
	ld c,$04
	ld d,$00
	jp Logged_0x31B3

Logged_0x21F05:
	ld a,[$CE75]
	cp $0B
	ret c
	ld a,$07
	ld [$C154],a
	ld hl,$C9E4
	inc [hl]
	ld hl,$C22C
	res 7,[hl]
	ret

UnknownData_0x21F1A:
INCBIN "baserom.gb", $21F1A, $21F20 - $21F1A

LoggedData_0x21F20:
INCBIN "baserom.gb", $21F20, $21F26 - $21F20

Logged_0x21F26:
	call Logged_0x227F4
	ld a,[$CE75]
	and a
	ret nz
	ld a,$07
	ld [$C154],a
	ld hl,$C9E4
	dec [hl]
	ld hl,$C22C
	res 7,[hl]
	ret

Logged_0x21F3D:
	ld hl,$CE76
	ld a,[hld]
	cp $03
	jr z,Logged_0x21F52
	ld a,[hl]
	and $03
	jr nz,Logged_0x21F52
	ld a,[$DC06]
	set 4,a
	ld [$DC06],a

Logged_0x21F52:
	dec [hl]
	ret nz
	inc hl
	ld a,[hld]
	cp $03
	jr z,Logged_0x21F8E
	ld b,$08
	cp $02
	jr nz,Logged_0x21F62
	ld b,$40

Logged_0x21F62:
	ld [hl],b
	ld a,[$CE76]
	ld c,a
	ld b,$00
	ld hl,$D000
	add hl,bc
	ld a,[hl]
	ld [$CE88],a
	ld hl,$6082
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld a,[$CE76]
	swap a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$C240
	add hl,bc
	ld [hl],$00
	jp Logged_0x22060

Logged_0x21F8E:
	ld a,[$CE65]
	cp $64
	jr c,Logged_0x22004
	ld bc,$0102
	call Logged_0x0AF7
	ld a,$01
	ld [$D243],a
	ld a,$13
	ld [$D244],a
	ld bc,$2848
	ld de,$608E
	ld hl,$C240
	call Logged_0x309F
	ld a,$01
	ld [$C24D],a
	ld a,$FE
	ld [$C24B],a
	ld bc,$2850
	ld de,$609C
	ld hl,$C260
	call Logged_0x309F
	ld a,$01
	ld [$C26D],a
	ld a,$F7
	ld [$C26B],a
	ld bc,$2858
	ld de,$609C
	ld hl,$C280
	call Logged_0x309F
	ld a,$01
	ld [$C28D],a
	ld a,$F0
	ld [$C28B],a
	ld a,$0C
	ld [$C154],a
	ld hl,$CE88
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$6088
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	xor a
	ld [$CE76],a
	jr Logged_0x22060

Logged_0x22004:
	ld a,[$D12A]
	bit 1,a
	jr z,Logged_0x22055
	ld a,[$CC40]
	cp $01
	jr nz,Logged_0x2204B
	ld a,$37
	call Logged_0x1629
	ld a,$37
	call Logged_0x3262
	ld a,$05
	ld [$C154],a
	ld a,$01
	ld [$C200],a
	xor a
	ld [$C2C0],a
	ld [$C2E0],a
	ld [$C300],a
	ld [$C320],a
	ld hl,$CE78
	res 0,[hl]
	set 7,[hl]
	ld hl,$C22C
	set 7,[hl]
	ld hl,$C221
	ld b,$59
	ld c,$03
	ld d,$0E
	jp Logged_0x31B3

Logged_0x2204B:
	cp $7F
	jr nz,Logged_0x22055
	ld a,$11
	ld [$C154],a
	ret

Logged_0x22055:
	ld hl,$C22C
	set 7,[hl]
	ld a,$04
	ld [$C154],a
	ret

Logged_0x22060:
	ld a,[$C1A5]
	add a,$40
	srl a
	srl a
	srl a
	ld hl,$CE76
	add a,[hl]
	inc [hl]
	ld c,a
	ld b,$00
	ld hl,$9860
	add hl,bc
	ld de,$CE7D
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	jp Logged_0x09A3

LoggedData_0x22082:
INCBIN "baserom.gb", $22082, $220AA - $22082

Logged_0x220AA:
	ld hl,$C24C
	xor a
	ld [$CE76],a

Logged_0x220B1:
	push hl
	bit 6,[hl]
	jr z,Logged_0x220D9
	res 6,[hl]
	ld a,$F4
	add a,l
	ld l,a
	ld [hl],$00
	ld b,$F7
	ld a,[$CE76]
	and a
	jr z,Logged_0x220C7
	dec b

Logged_0x220C7:
	ld a,b
	ld [$CE88],a
	ld hl,$6082
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	call Logged_0x22060

Logged_0x220D9:
	pop hl
	ld bc,$0020
	add hl,bc
	ld a,[$CE76]
	inc a
	ld [$CE76],a
	cp $03
	jr c,Logged_0x220B1
	ld a,[$C280]
	and a
	ret nz
	ld a,$60
	ld [$CE75],a
	ld a,$0E
	ld [$C154],a
	ret

Logged_0x220F9:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$08
	ld [hli],a
	dec [hl]
	jr nz,Logged_0x22123
	ld hl,$D12A
	res 1,[hl]
	call Logged_0x209F4
	ld a,[$C922]
	and a
	jr nz,Logged_0x22117
	ld a,$04
	ld [$CE52],a

Logged_0x22117:
	xor a
	ld [$FF00+$91],a
	ld [$C154],a
	ld bc,$0108
	jp Logged_0x0AE5

Logged_0x22123:
	ld de,$D000
	ld a,[$CE76]
	rra
	jr c,Logged_0x2212F
	ld de,$D00E

Logged_0x2212F:
	ld a,$07
	ld [$D24B],a
	ld hl,$CE81
	ld a,[$C1A5]
	add a,$30
	srl a
	srl a
	srl a
	ld b,a
	cp $1A
	jr c,Logged_0x2216A
	ld a,$20
	sub b
	ld [$D24B],a
	push de
	call Logged_0x2216A
	pop hl
	ld a,[$D24B]
	add a,a
	ld e,a
	ld d,$00
	add hl,de
	ld e,l
	ld d,h
	ld hl,$D24B
	ld a,$07
	sub [hl]
	ld [$D24B],a
	ld b,$00
	ld hl,$CE87

Logged_0x2216A:
	ld a,d
	ld [hld],a
	ld a,e
	ld [hld],a
	ld a,[$D24B]
	ld [hld],a
	ld a,$02
	ld [hld],a
	push hl
	ld a,b
	ld c,a
	ld b,$00
	ld hl,$9820
	add hl,bc
	pop de
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	jp Logged_0x09A3

Logged_0x22187:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$01
	ld [$D243],a
	ld a,$04
	ld [$D245],a
	jp Logged_0x22004

Logged_0x22199:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$04
	ld [hli],a
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$61E1
	add hl,bc
	ld c,[hl]
	ld b,$88
	push bc
	call Logged_0x3069
	pop bc
	push hl
	ld de,$61E5
	call Logged_0x309F
	pop hl
	ld a,$0D
	add a,l
	ld l,a
	ld c,$02
	call Logged_0x31C3
	ld hl,$DC06
	set 3,[hl]
	ld hl,$CE76
	inc [hl]
	ld a,[hld]
	cp $04
	ret c
	ld a,$10
	ld [hli],a
	ld a,$06
	ld [hli],a
	ld a,$40
	ld [hli],a
	inc hl
	ld [hl],$00
	ld a,$10
	ld [$C154],a
	ret

LoggedData_0x221E1:
INCBIN "baserom.gb", $221E1, $221F3 - $221E1

Logged_0x221F3:
	ld hl,$CE77
	dec [hl]
	jr nz,Logged_0x22239
	ld a,$10
	ld [hli],a
	inc hl
	ld a,[hl]
	cp $03
	jr nc,Logged_0x22239
	add a,a
	add a,a
	add a,[hl]
	add a,[hl]
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$625D
	add hl,bc
	ld a,[hli]
	ld c,a
	ld a,[hli]
	push hl
	ld h,[hl]
	ld l,a
	ld de,$CE88
	call Logged_0x092B
	ld de,$CE81
	ld a,$CE
	ld [de],a
	dec de
	ld a,$88
	ld [de],a
	dec de
	pop hl
	inc hl
	ld a,[hli]
	ld [de],a
	dec de
	ld a,[hli]
	ld [de],a
	dec de
	ld a,[hli]
	ld [de],a
	dec de
	ld a,[hl]
	ld [de],a
	call Logged_0x09A3
	ld hl,$CE79
	inc [hl]

Logged_0x22239:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,[$DC07]
	set 5,a
	ld [$DC07],a
	ld a,$10
	ld [hli],a
	dec [hl]
	ret nz
	ld hl,$CE78
	res 0,[hl]
	res 7,[hl]
	ld a,$06
	ld [$CE58],a
	ld a,$07
	ld [$C154],a
	ret

LoggedData_0x2225D:
INCBIN "baserom.gb", $2225D, $22288 - $2225D

Logged_0x22288:
	ld bc,$0108
	call Logged_0x0AE5
	call Logged_0x05CC
	ld a,$08
	ld [$C1A5],a
	ld a,$06
	ld [$C9E4],a
	ld hl,$9800
	xor a
	ld bc,$0400
	call Logged_0x0914
	ld a,$0A
	ld [$C154],a
	ld a,$06
	call Logged_0x22844
	ld hl,$9800
	ld de,$D000
	ld bc,$110B
	call Logged_0x209E2
	ld a,$09
	ld [$C154],a
	ld a,$07
	call Logged_0x22844
	ld hl,$980A
	ld de,$D000
	ld bc,$110B
	call Logged_0x209E2
	ld a,$37
	call Logged_0x1629
	ld a,$37
	call Logged_0x3262
	ld a,$88
	ld [$C223],a
	ld a,$30
	ld [$C227],a
	ld hl,$C22C
	res 7,[hl]
	ld hl,$C221
	ld bc,$5305
	ld d,$00
	call Logged_0x31B3
	xor a
	ld [$C2A0],a
	xor a
	ld [$C2C0],a
	xor a
	ld [$C2E0],a
	xor a
	ld [$C300],a
	xor a
	ld [$C320],a
	ld bc,$88DB
	ld de,$634D
	ld hl,$C340
	call Logged_0x309F
	ld hl,$C34D
	ld c,$00
	call Logged_0x31C3
	ld bc,$88F0
	ld de,$635B
	ld hl,$C360
	call Logged_0x309F
	ld hl,$C36D
	ld c,$03
	call Logged_0x31C3
	ld a,$12
	ld [$C154],a
	ld a,$04
	ld [$CE75],a
	ld hl,$D12A
	set 6,[hl]
	ld a,$01
	ld [$D243],a
	ld a,$0D
	ld [$D244],a
	jp Logged_0x060E

LoggedData_0x2234D:
INCBIN "baserom.gb", $2234D, $22369 - $2234D

Logged_0x22369:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$60
	call Logged_0x05D9
	ld hl,$FF47
	ld a,$E4
	ld [hli],a
	ld a,$1C
	ld [hli],a
	ld [hl],$84
	ld a,$18
	ld [$C154],a
	ld hl,$D12A
	res 6,[hl]
	jp Logged_0x060E

Logged_0x2238B:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$10
	ld a,$14
	ld [$C154],a
	ld hl,$C225
	ld a,$FF
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld hl,$C22C
	set 7,[hl]
	ld hl,$C221
	ld bc,$5005
	ld d,$00
	jp Logged_0x31B3

Logged_0x223B0:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$A0
	ld a,$15
	ld [$C154],a
	ld hl,$C22C
	res 7,[hl]
	ld hl,$C225
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$C221
	ld bc,$5105
	ld d,$00
	jp Logged_0x31B3

Logged_0x223D2:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$10
	ld a,$16
	ld [$C154],a
	ld hl,$C225
	ld a,$01
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld hl,$C22C
	set 7,[hl]
	ld hl,$C221
	ld bc,$5105
	ld d,$00
	jp Logged_0x31B3

Logged_0x223F7:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$C0
	ld a,$17
	ld [$C154],a
	ld hl,$C22C
	res 7,[hl]
	ld hl,$C225
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$C221
	ld bc,$5305
	ld d,$00
	jp Logged_0x31B3

Logged_0x22419:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$30
	ld a,$19
	ld [$C154],a
	ld hl,$C229
	ld a,$01
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld hl,$C22C
	set 7,[hl]
	ld hl,$C221
	ld bc,$5305
	ld d,$00
	jp Logged_0x31B3

Logged_0x2243E:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$60
	ld a,$13
	ld [$C154],a
	ld hl,$C221
	ld bc,$5205
	ld d,$00
	jp Logged_0x31B3

Logged_0x22455:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld [hl],$28
	ld a,$1A
	ld [$C154],a
	ld hl,$C229
	xor a
	ld [hli],a
	ld [hl],a
	ret

Logged_0x22468:
	ld hl,$C1A5
	inc [hl]
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$07
	ld [$C9E4],a
	ld [$CE58],a
	ld a,$84
	ld [$C2A0],a
	ld hl,$C2A3
	ld a,$A8
	ld [hli],a
	xor a
	ld [hli],a
	ld a,$FF
	ld [hli],a
	ld a,$80
	ld [hl],a
	ld a,$02
	ld [$C154],a
	ld hl,$CE78
	set 0,[hl]
	ld a,$01
	ld [$C200],a
	ld a,[$C9E4]
	add a,$0E
	ld [$C202],a
	ld hl,$C22C
	set 7,[hl]
	ld hl,$C225
	ld a,$FF
	ld [hli],a
	ld [hl],$00
	ld hl,$C221
	ld b,$50
	ld c,$04
	ld d,$00
	jp Logged_0x31B3

Logged_0x224BC:
	ld hl,$C367
	ld a,[$FF00+$96]
	rra
	jr nc,Logged_0x22522
	ld a,[hl]
	cp $43
	jr nz,Logged_0x2250F
	ld hl,$DC06
	set 6,[hl]

Unknown_0x224CE:
	ld a,$04
	ld [$C154],a
	xor a
	ld [$C340],a
	ld [$C360],a
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	ld hl,$A00B
	add hl,bc
	ld e,l
	ld d,h
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$697A
	add hl,bc
	ld a,[de]
	and [hl]
	ld a,$00
	ld [$0000],a
	ret nz
	ld a,$03
	ld [$C330],a
	ld [$C310],a
	ld [$C2F0],a
	ld [$C2D0],a
	ret

Logged_0x2250F:
	ld hl,$CE75
	ld a,$08
	ld [hli],a
	ld [hl],$07
	ld a,$1D
	ld [$C154],a
	ld hl,$DC0A
	set 5,[hl]
	ret

Logged_0x22522:
	ld a,[$FF00+$96]
	bit 1,a
	jr z,Logged_0x2252F
	ld hl,$DC06
	set 6,[hl]
	jr Unknown_0x224CE

Logged_0x2252F:
	bit 2,a
	jr z,Logged_0x2253D
	ld a,[hl]
	xor $6D
	ld [hl],a
	ld hl,$DC06
	set 4,[hl]
	ret

Logged_0x2253D:
	bit 5,a
	jr z,Logged_0x2254D
	ld a,[hl]
	cp $2E
	ret z
	ld [hl],$2E
	ld hl,$DC06
	set 4,[hl]
	ret

Logged_0x2254D:
	bit 4,a
	ret z
	ld a,[hl]
	cp $43
	ret z
	ld [hl],$43
	ld hl,$DC06
	set 4,[hl]
	ret

Logged_0x2255C:
	ld hl,$CE75
	dec [hl]
	ret nz
	ld a,$08
	ld [hli],a
	dec [hl]
	jr z,Logged_0x22570
	ld a,[$C360]
	xor $01
	ld [$C360],a
	ret

Logged_0x22570:
	call Logged_0x209F4
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$6682
	add hl,bc
	ld a,[$CC41]
	and [hl]
	ld [$CC41],a
	xor a
	ld [$CE53],a
	ld hl,$CE54
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$CE71
	ld [hli],a
	ld [hl],a
	ld [$CE66],a
	ld hl,$CE5A
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld [$CFDD],a
	ld [$CE70],a
	ld [$CEB5],a
	ld a,$04
	ld [$CE52],a
	ld hl,$CC42
	xor a
	ld c,$40
	call Logged_0x091D
	ld hl,$CC82
	xor a
	ld bc,$0100
	call Logged_0x0914
	ld hl,$CD82
	xor a
	ld c,$40
	call Logged_0x091D
	ld hl,$CDC2
	xor a
	ld c,$80
	call Logged_0x091D
	ld hl,$CE42
	xor a
	ld c,$10
	call Logged_0x091D
	ld hl,$C922
	xor a
	ld c,$C1
	call Logged_0x091D
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld d,a
	ld e,$00
	ld a,[$C9E4]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6982
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	add hl,de
	bit 7,[hl]
	ld a,$00
	ld [$0000],a
	ld a,$00
	jr z,Logged_0x2260B
	inc a

Logged_0x2260B:
	push af
	call Logged_0x20B00
	ld a,$0A
	ld [$0000],a
	ld a,[$C9E4]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6698
	add hl,bc
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[hli]
	ld b,[hl]
	ld c,a
	ld a,[$C1A2]
	ld h,a
	ld l,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,de
	push hl
	xor a
	ld [hli],a
	ld [hld],a
	ld a,h
	add a,$10
	ld h,a
	xor a
	ld [hli],a
	ld [hld],a
	pop hl
	dec hl
	dec hl
	dec hl
	call Logged_0x330C
	ld a,h
	add a,$10
	ld h,a
	ld [hl],d
	ld a,$00
	ld [$0000],a
	ld hl,$CE75
	ld a,$10
	ld [hli],a
	ld [hl],$00
	ld a,$04
	ld [$C154],a
	xor a
	ld [$C340],a
	ld [$C360],a
	pop af
	and a
	jp z,Logged_0x226B8
	ld bc,$2830
	ld de,$668A
	ld hl,$C380
	call Logged_0x309F
	ld hl,$C38D
	ld c,$02
	call Logged_0x31C3
	ld hl,$DC0A
	set 5,[hl]
	jp Logged_0x226B8

LoggedData_0x22682:
INCBIN "baserom.gb", $22682, $22683 - $22682

UnknownData_0x22683:
INCBIN "baserom.gb", $22683, $2268A - $22683

LoggedData_0x2268A:
INCBIN "baserom.gb", $2268A, $2269C - $2268A

UnknownData_0x2269C:
INCBIN "baserom.gb", $2269C, $226B8 - $2269C

Logged_0x226B8:
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld b,a
	ld c,$00
	push bc
	ld hl,$A00B
	add hl,bc
	ld e,l
	ld d,h
	ld a,[$C9E4]
	ld c,a
	ld b,$00
	ld hl,$697A
	add hl,bc
	ld a,[de]
	and [hl]
	pop de
	ld a,$00
	ld [$0000],a
	ret nz
	push de
	ld a,$0A
	ld [$0000],a
	ld a,[$C9E4]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$677F
	add hl,bc
	ld a,[hli]
	push hl
	ld h,[hl]
	ld l,a
	add hl,de
	ld l,[hl]
	ld a,l
	ld [$D24B],a
	ld h,$00
	ld de,$0064
	call Logged_0x32F6
	ld c,l
	ld b,h
	pop hl
	pop de
	push bc
	inc hl
	ld a,[hli]
	ld h,[hl]
	ld l,a
	add hl,de
	push hl
	ld a,[hli]
	ld e,[hl]
	ld d,$00
	ld l,a
	ld h,$00
	ld a,$00
	ld [$0000],a
	call Logged_0x32F6
	ld b,l
	pop de
	pop hl
	push de
	call Logged_0x32D9
	ld b,$0A
	call Logged_0x32D9
	ld b,a
	xor a
	ld [$C2C0],a
	ld a,l
	and a
	jr z,Logged_0x2273D
	add a,$35
	ld [$C2C2],a
	ld a,$AE
	ld [$C2C0],a

Logged_0x2273D:
	ld a,b
	add a,$35
	ld [$C2E2],a
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	ld a,$0A
	ld [$0000],a
	ld b,$04
	ld a,[$D24B]
	and a
	jr z,Logged_0x22756
	ld b,[hl]

Logged_0x22756:
	ld a,b
	add a,$30
	ld [$C322],a
	ld a,$00
	ld [$0000],a
	ld a,$AB
	ld [$C320],a
	ld a,$AC
	ld [$C300],a
	ld a,$AD
	ld [$C2E0],a
	ld a,$03
	ld [$C330],a
	ld [$C310],a
	ld [$C2F0],a
	ld [$C2D0],a
	ret

LoggedData_0x2277F:
INCBIN "baserom.gb", $2277F, $2279F - $2277F

Logged_0x2279F:
	ld hl,$C1A5
	inc [hl]
	ld a,[hl]
	and $07
	ret nz
	ld a,[$CE75]
	ld c,a
	ld b,$00
	ld hl,$D000
	add hl,bc
	ld de,$CE88
	ld c,$11

Logged_0x227B6:
	ld a,[hl]
	ld [de],a
	inc de
	push bc
	ld bc,$000B
	add hl,bc
	pop bc
	dec c
	jr nz,Logged_0x227B6
	ld hl,$CE75
	inc [hl]
	ld hl,$67EE
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld a,[$C1A5]
	add a,$C8
	srl a
	srl a
	srl a
	ld c,a
	ld b,$00
	ld hl,$9800
	add hl,bc
	ld de,$CE7D
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	jp Logged_0x09A3

LoggedData_0x227EE:
INCBIN "baserom.gb", $227EE, $227F4 - $227EE

Logged_0x227F4:
	ld hl,$C1A5
	dec [hl]
	ld a,[hl]
	and $07
	ret nz
	ld a,[$CE75]
	dec a
	ld c,a
	ld b,$00
	ld hl,$D000
	add hl,bc
	ld de,$CE88
	ld c,$11

Logged_0x2280C:
	ld a,[hl]
	ld [de],a
	inc de
	push bc
	ld bc,$000B
	add hl,bc
	pop bc
	dec c
	jr nz,Logged_0x2280C
	ld hl,$CE75
	dec [hl]
	ld hl,$67EE
	ld de,$CE7C
	ld c,$06
	call Logged_0x092B
	ld a,[$C1A5]
	add a,$D0
	srl a
	srl a
	srl a
	ld c,a
	ld b,$00
	ld hl,$9800
	add hl,bc
	ld de,$CE7D
	ld a,h
	ld [de],a
	dec de
	ld a,l
	ld [de],a
	jp Logged_0x09A3

Logged_0x22844:
	ld [$D24B],a
	ld hl,$D000
	xor a
	ld c,$BB
	call Logged_0x091D
	ld a,[$D24B]
	cp $08
	ret nc
	add a,a
	ld c,a
	ld b,$00
	ld hl,$58C3
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld de,$D000
	ld a,[$C154]
	cp $0A
	jr z,Logged_0x2286C
	inc de

Logged_0x2286C:
	ld c,$0D

Logged_0x2286E:
	push bc
	ld c,$0A
	call Logged_0x092B
	inc de
	pop bc
	dec c
	jr nz,Logged_0x2286E
	ld a,[$CE58]
	and a
	jp z,Logged_0x2293C
	ld hl,$70BF
	ld a,[$D24B]
	and a
	jr z,Logged_0x2289C
	ld a,[$CE58]
	ld hl,$D24B
	cp [hl]
	jp c,Logged_0x2293C
	ld hl,$7123
	jp z,Logged_0x2289C
	ld hl,$70F1

Logged_0x2289C:
	push hl
	ld a,[$D24B]
	ld c,a
	ld b,$00
	ld hl,$697A
	add hl,bc
	ld a,[$CC40]
	and [hl]
	jr z,Logged_0x228F4
	ld a,[$D24B]
	ld c,a
	ld b,$00
	ld hl,$CE5D
	add hl,bc
	ld l,[hl]
	ld h,$00
	call Logged_0x14EB
	ld hl,$D024
	ld a,[$C154]
	cp $0A
	jr z,Logged_0x228C8
	inc hl

Logged_0x228C8:
	ld b,$00
	ld a,[$C14F]
	and a
	jr z,Logged_0x228D3
	add a,$F6
	ld b,a

Logged_0x228D3:
	ld [hl],b
	inc hl
	ld a,[$C150]
	and a
	jr nz,Logged_0x228E4
	ld b,$00
	ld a,[$C14F]
	and a
	jr z,Logged_0x228E7
	ld a,b

Logged_0x228E4:
	add a,$F6
	ld b,a

Logged_0x228E7:
	ld [hl],b
	inc hl
	ld a,[$C151]
	add a,$F6
	ld [hli],a
	ld a,$DB
	ld [hli],a
	inc a
	ld [hl],a

Logged_0x228F4:
	pop hl
	ld de,$D084
	ld a,[$C154]
	cp $0A
	jr z,Logged_0x22900
	inc de

Logged_0x22900:
	ld c,$05

Logged_0x22902:
	push bc
	ld c,$0A
	call Logged_0x092B
	inc de
	pop bc
	dec c
	jr nz,Logged_0x22902
	ld hl,$D074
	ld a,[$C154]
	cp $0A
	jr z,Logged_0x22918
	inc hl

Logged_0x22918:
	ld a,$1A
	ld [hli],a
	inc a
	ld [hl],a
	ld bc,$000A
	add hl,bc
	ld a,$B8
	ld [hli],a
	inc a
	ld [hl],a
	ld hl,$D0AF
	ld a,[$C154]
	cp $0A
	jr z,Logged_0x22933
	ld hl,$D0A5

Logged_0x22933:
	ld a,$20
	ld [hl],a
	inc a
	ld bc,$000B
	add hl,bc
	ld [hl],a

Logged_0x2293C:
	ld a,$0A
	ld [$0000],a
	ld a,[$C1A2]
	add a,a
	add a,a
	add a,a
	ld d,a
	ld e,$00
	ld a,[$D24B]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6982
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	add hl,de
	bit 7,[hl]
	ld a,$00
	ld [$0000],a
	ret z
	ld hl,$D021
	ld a,[$C154]
	cp $0A
	jr z,Logged_0x2296C
	inc hl

Logged_0x2296C:
	ld a,$BA
	ld [hli],a
	inc a
	ld [hld],a
	ld bc,$000B
	add hl,bc
	inc a
	ld [hli],a
	inc a
	ld [hl],a
	ret

LoggedData_0x2297A:
INCBIN "baserom.gb", $2297A, $22AE7 - $2297A

UnknownData_0x22AE7:
INCBIN "baserom.gb", $22AE7, $22B47 - $22AE7

LoggedData_0x22B47:
INCBIN "baserom.gb", $22B47, $23155 - $22B47

UnknownData_0x23155:
INCBIN "baserom.gb", $23155, $24000 - $23155

SECTION "Bank09", ROMX, BANK[$09]

Logged_0x24000:
	push de
	ld hl,$C220
	ld de,$6CEF
	call Logged_0x309F
	pop de
	ld a,d
	ld [$C230],a
	add a,$24
	ld [$C221],a
	xor a
	ld [$C222],a
	ld hl,$C5E0
	ld de,$6D10
	ld bc,$8E96
	call Logged_0x309F
	ld hl,$C5E1
	ld b,$3F
	ld a,[$CE52]
	ld c,a
	ld d,a
	add a,a
	add a,a
	add a,d
	ld d,a
	call Logged_0x31B3
	ld a,$80
	ld [$D141],a
	ld hl,$C705
	res 7,[hl]
	ret

Logged_0x24040:
	call Logged_0x26A51
	ld hl,$405B
	push hl
	ld a,[$D174]
	rst JumpList
	dw Logged_0x24092
	dw Logged_0x2417B
	dw Logged_0x240D9
	dw Unknown_0x240FE
	dw Logged_0x24113
	dw Logged_0x24122
	dw Logged_0x241E0
	dw Logged_0x24212
	xor a
	ld [$C420],a
	ld [$C220],a
	ld a,$01
	ld [$D144],a
	ld hl,$D16B
	ld a,[hl]
	and a
	jp z,Logged_0x26A62
	dec [hl]
	ld a,[hl]
	and $03
	ld hl,$D143
	jr nz,Logged_0x24086
	ld a,[hl]
	xor $80
	ld [hl],a
	ld a,[$D16B]
	and a
	jr nz,Logged_0x24086
	res 7,[hl]
	set 6,[hl]

Logged_0x24086:
	ld a,[hl]
	rla
	jp c,Logged_0x26A62
	xor a
	ld [$D144],a
	jp Logged_0x26A62

Logged_0x24092:
	ld a,[$FF00+$96]
	bit 3,a
	jr z,Logged_0x240BB
	ld a,[$D12B]
	bit 4,a
	jr nz,Logged_0x240BB
	bit 1,a
	jr nz,Logged_0x240BB
	ld a,[$C9E4]
	cp $09
	jr z,Logged_0x240BB
	ld hl,$D12A
	set 5,[hl]
	ld a,[$D157]
	cp $01
	jr z,Logged_0x240BB
	ld hl,$D158
	set 5,[hl]

Logged_0x240BB:
	ld hl,$D177
	ld a,[hl]
	and a
	jr z,Logged_0x240C3
	dec [hl]

Logged_0x240C3:
	call Logged_0x24243
	call Logged_0x24B5F
	ld a,[$C9E4]
	cp $09
	call nz,Logged_0x268DB
	ld hl,$D16A
	ld a,[hl]
	and a
	ret z
	dec [hl]
	ret

Logged_0x240D9:
	xor a
	ld [$FF00+$95],a
	ld [$FF00+$96],a
	call Logged_0x24B5F
	ld a,[$D157]
	cp $04
	ret nz
	ld a,[$D15E]
	cp $01
	ret nz
	xor a
	ld [$C158],a
	ld [$C15C],a
	ld a,$1E
	ld [$FF00+$47],a
	ld a,$04
	ld [$D174],a
	ret

Unknown_0x240FE:
	xor a
	ld [$FF00+$95],a
	ld [$FF00+$96],a
	call Logged_0x24B5F
	ld a,[$D157]
	and a
	ret nz
	ld a,$02
	ld [$D174],a
	jp Logged_0x24BF3

Logged_0x24113:
	xor a
	ld [$FF00+$95],a
	ld [$FF00+$96],a
	ld a,[$D141]
	rra
	jp c,Logged_0x2692A
	jp Logged_0x268F7

Logged_0x24122:
	xor a
	ld [$FF00+$95],a
	ld [$FF00+$96],a
	call Logged_0x24243
	call Logged_0x24B5F
	ld a,[$D157]
	cp $01
	jr nz,Logged_0x2413A
	ld a,[$D142]
	bit 6,a
	ret z

Logged_0x2413A:
	ld hl,$D158
	set 5,[hl]
	ld a,[$D157]
	cp $09
	ret z
	cp $10
	ret z
	ld hl,$D149
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,[$D157]
	and a
	jr z,Logged_0x24165
	cp $01
	jr z,Logged_0x24165
	cp $04
	ret nz
	ld a,[$D15E]
	cp $01
	ret nz

Logged_0x24165:
	xor a
	ld [$D174],a
	ld [$D15E],a
	ld a,$15
	ld [$D157],a
	ld a,[$FF00+$91]
	ld [$C155],a
	ld a,$1A
	ld [$FF00+$91],a
	ret

Logged_0x2417B:
	xor a
	ld [$FF00+$95],a
	ld [$FF00+$96],a
	call Logged_0x24243
	call Logged_0x24B5F
	ld a,[$D157]
	cp $01
	jr nz,Logged_0x24193
	ld a,[$D142]
	bit 6,a
	ret z

Logged_0x24193:
	ld hl,$D158
	set 5,[hl]
	ld a,[$D157]
	cp $09
	ret z
	ld hl,$D149
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,[$D157]
	and a
	jr z,Logged_0x241BB
	cp $01
	jr z,Logged_0x241BB
	cp $04
	ret nz
	ld a,[$D15E]
	cp $01
	ret nz

Logged_0x241BB:
	xor a
	ld [$D134],a
	ld [$C15C],a
	ld hl,$D142
	set 5,[hl]
	ld a,[$D141]
	rra
	jr nc,Logged_0x241DA
	ld a,$02
	ld [$D174],a
	ld a,$01
	ld [$D154],a
	jp Logged_0x24BF3

Logged_0x241DA:
	ld a,$04
	ld [$D174],a
	ret

Logged_0x241E0:
	ld bc,$0180
	ld a,[$D147]
	cp $50
	jr z,Logged_0x241F7
	ld bc,$0220
	ld a,[$D14B]
	cp $48
	jr z,Logged_0x241F7
	ld bc,$0310

Logged_0x241F7:
	ld a,b
	ld [$D154],a
	ld [$D161],a
	ld a,c
	ld [$FF00+$95],a
	ld hl,$D158
	res 5,[hl]
	xor a
	ld [$D15A],a
	ld a,$07
	ld [$D174],a
	jp Logged_0x24249

Logged_0x24212:
	xor a
	ld [$FF00+$95],a
	call Logged_0x24249
	ld a,[$D157]
	cp $01
	jr nz,Logged_0x24225
	ld a,[$D142]
	bit 6,a
	ret z

Logged_0x24225:
	ld a,$04
	ld [$D174],a
	ld hl,$D158
	set 5,[hl]
	ld a,[$D154]
	xor $01
	ld [$D154],a
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x24243:
	ld a,[$D158]
	bit 5,a
	ret nz

Logged_0x24249:
	ld a,[$D141]
	rra
	jr c,Logged_0x24252
	jp Logged_0x2454F

Logged_0x24252:
	ld a,[$D15B]
	rst JumpList
	dw Logged_0x2425A
	dw Logged_0x24415

Logged_0x2425A:
	ld hl,$D158
	ld a,[hl]
	and $FC
	ld [hl],a
	ld a,[$D159]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld bc,$702C
	add hl,bc
	ld bc,$0040
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$FF00+$95]
	call Logged_0x3177
	ld e,l
	ld d,h
	and a
	jr z,Logged_0x242AC
	cp $02
	ret z
	ld a,[de]
	call Logged_0x2688E
	jr nc,Unknown_0x242A3
	ld [$CE7B],a
	xor a
	ld [$D136],a
	ld b,$04
	ld a,[$D142]
	bit 4,a
	jr z,Logged_0x2429D
	ld b,$17

Logged_0x2429D:
	ld a,b
	ld [$FF00+$91],a
	jp Logged_0x24400

Unknown_0x242A3:
	ld a,[$D154]
	call Logged_0x26844
	jp Logged_0x24400

Logged_0x242AC:
	push de
	ld a,[de]
	ld b,a
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,b
	call Logged_0x301A
	ld a,d
	ld [$D15C],a
	ld a,e
	ld [$D15D],a
	ld bc,$0001
	call Logged_0x2F88
	ld hl,$D24D
	ld [hl],d
	pop de
	rra
	jr c,Logged_0x242EC
	ld a,[$D24D]
	cp $3F
	jr nz,Logged_0x242E3
	ld a,[de]
	ld c,a
	ld a,[$D154]
	or c
	jr nz,Logged_0x242E3
	jp Logged_0x2695D

Logged_0x242E3:
	ld a,[$D154]
	call Logged_0x26844
	jp Logged_0x24400

Logged_0x242EC:
	xor a
	ld [$D16C],a
	ld a,[de]
	ld hl,$D154
	cp [hl]
	jr z,Logged_0x242FF
	ld a,$03
	ld [$D15A],a
	jp Logged_0x24400

Logged_0x242FF:
	ld hl,$D15A
	ld a,[hl]
	and a
	jr z,Logged_0x24308
	dec [hl]
	ret

Logged_0x24308:
	ld a,[de]
	ld [$D154],a
	inc de
	ld hl,$D150
	set 7,[hl]
	ld a,$01
	ld [$D157],a
	ld a,$01
	ld [$D15B],a
	ld a,[$D24D]
	and $3F
	ld c,a
	ld b,$00
	ld hl,$732C
	add hl,bc
	ld a,[hl]
	ld [$D24F],a
	ld a,[$D154]
	ld c,a
	ld b,$00
	ld hl,$7381
	add hl,bc
	push de
	ld d,[hl]
	ld hl,$0000
	ld a,[$D24D]
	cp $43
	jr z,Logged_0x2435D
	ld a,[$D24F]
	and d
	jr nz,Logged_0x24365
	ld hl,$0020
	ld a,[$D158]
	set 4,a
	ld [$D158],a
	ld a,[$DC03]
	set 6,a
	ld [$DC03],a
	jr Logged_0x24365

Logged_0x2435D:
	ld a,[$D158]
	set 3,a
	ld [$D158],a

Logged_0x24365:
	pop de
	add hl,de
	ld a,[hli]
	ld [$D155],a
	ld a,[hli]
	ld [$D156],a
	ld a,[hl]
	ld [$D24C],a
	ld a,[$D154]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld a,[$D158]
	and $10
	rrca
	ld b,a
	ld a,[$D159]
	or b
	add a,a
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$712C
	add hl,bc
	ld de,$D149
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$D145
	ld a,[$D24C]
	ld b,a
	ld a,[$D159]
	ld c,a
	ld d,$00
	call Logged_0x31B3
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x2FBC
	ld a,[hl]
	cp $43
	ret z
	cp $50
	ret z
	ld e,l
	ld d,h
	ld a,[hl]
	and $3F
	ld c,a
	ld b,$00
	ld hl,$732C
	add hl,bc
	ld a,[$D154]
	ld c,a
	ld b,$00
	ld a,[hl]
	ld hl,$737D
	add hl,bc
	or [hl]
	ld b,a
	add a,$10
	ld [de],a
	ld a,$90
	add a,b
	push af
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x3007
	push de
	call Logged_0x3047
	pop de
	ld a,$11
	ld [hli],a
	ld [hl],d
	inc hl
	ld [hl],e
	inc hl
	pop af
	ld [hl],a
	ret

Logged_0x24400:
	ld a,[de]
	ld [$D154],a
	ld hl,$D145
	inc de
	inc de
	inc de
	ld a,[de]
	ld b,a
	ld a,[$D159]
	ld c,a
	ld d,$00
	jp Logged_0x31AF

Logged_0x24415:
	ld hl,$D142
	res 6,[hl]
	ld hl,$D158
	ld a,[$FF00+$96]
	and $01
	or [hl]
	ld [hl],a
	ld hl,$D156
	ld a,[hl]
	and a
	jr z,Logged_0x2447E
	dec [hl]
	jr nz,Logged_0x2447E
	push hl
	ld a,[$D15C]
	ld d,a
	ld a,[$D15D]
	ld e,a
	call Logged_0x2FBC
	ld a,[hl]
	cp $43
	jr z,Logged_0x2447D
	cp $50
	jr z,Logged_0x2447D
	ld a,[hl]
	cp $20
	jr c,Logged_0x2444C
	ld hl,$732C
	jr Logged_0x24453

Logged_0x2444C:
	ld c,a
	ld b,$00
	ld hl,$732C
	add hl,bc

Logged_0x24453:
	ld a,[$D154]
	ld c,a
	ld b,$00
	ld a,[hl]
	ld hl,$7381
	add hl,bc
	or [hl]
	ld b,a
	ld a,$90
	add a,b
	push af
	ld a,[$D15C]
	ld d,a
	ld a,[$D15D]
	ld e,a
	call Logged_0x3007
	push de
	call Logged_0x3047
	pop de
	ld a,$11
	ld [hli],a
	ld [hl],d
	inc hl
	ld [hl],e
	inc hl
	pop af
	ld [hl],a

Logged_0x2447D:
	pop hl

Logged_0x2447E:
	dec hl
	dec [hl]
	jp nz,Logged_0x24519
	ld hl,$D142
	set 6,[hl]
	call Logged_0x26311
	push af
	ld l,e
	ld h,d
	ld a,[hl]
	cp $43
	jr z,Logged_0x244B6
	cp $50
	jr z,Logged_0x244B6
	cp $20
	jr c,Logged_0x244A0
	ld hl,$732C
	jr Logged_0x244A7

Logged_0x244A0:
	ld c,a
	ld b,$00
	ld hl,$732C
	add hl,bc

Logged_0x244A7:
	ld a,[$D154]
	ld c,a
	ld b,$00
	ld a,[hl]
	ld hl,$7381
	add hl,bc
	or [hl]
	add a,$10
	ld [de],a

Logged_0x244B6:
	pop af
	ret c
	ld hl,$D148
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$D150
	res 7,[hl]
	xor a
	ld [$D151],a
	xor a
	ld [$D15B],a
	xor a
	ld [$D157],a
	ld hl,$D158
	res 4,[hl]
	ld a,[$D154]
	call Logged_0x2688E
	jr nc,Logged_0x244F7
	ld [$CE7B],a
	xor a
	ld [$D136],a
	ld b,$04
	ld a,[$D142]
	bit 4,a
	jr z,Logged_0x244F3
	ld b,$17

Logged_0x244F3:
	ld a,b
	ld [$FF00+$91],a
	ret

Logged_0x244F7:
	ld b,$00
	ld a,[$D12A]
	bit 5,a
	jp nz,Logged_0x26AD2
	ld a,[$FF00+$95]
	and $02
	ret nz
	ld hl,$D158
	ld a,[hl]
	and $03
	jp z,Logged_0x2425A
	res 0,[hl]
	res 1,[hl]
	ld hl,$FF96
	or [hl]
	ld [hl],a
	ret

Logged_0x24519:
	ld a,[hl]
	cp $01
	ret nz
	ld a,[$D154]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld a,[$D158]
	and $10
	rrca
	ld b,a
	ld a,[$D159]
	or b
	add a,a
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$722C
	add hl,bc
	ld de,$D149
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x2454F:
	ld a,[$D15B]
	rst JumpList
	dw Logged_0x2455D
	dw Logged_0x246E3
	dw Logged_0x24801
	dw Logged_0x24910
	dw Logged_0x249F0

Logged_0x2455D:
	ld hl,$D158
	ld a,[hl]
	and $FC
	ld [hl],a
	xor a
	ld [$D24D],a
	ld a,[$D159]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld bc,$6D2C
	add hl,bc
	ld bc,$0040
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$FF00+$95]
	call Logged_0x3177
	ld e,l
	ld d,h
	and a
	jr z,Logged_0x245D1
	cp $02
	jr nz,Logged_0x245A1
	ld hl,$D150
	res 7,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31B3

Logged_0x245A1:
	ld a,[de]
	call Logged_0x2688E
	jp nc,Logged_0x246BF
	ld [$CE7B],a
	ld a,[$FF00+$91]
	cp $09
	jp z,Logged_0x246BF
	cp $0D
	jp z,Logged_0x246BF
	xor a
	ld [$D136],a
	ld b,$17
	ld a,[$D142]
	bit 4,a
	jr nz,Logged_0x245CB
	push de
	call Logged_0x26C81
	pop de
	ld b,$04

Logged_0x245CB:
	ld a,b
	ld [$FF00+$91],a
	jp Logged_0x246CB

Logged_0x245D1:
	push de
	ld a,[de]
	ld b,a
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,b
	call Logged_0x301A
	ld bc,$0062
	call Logged_0x2F6C
	ld b,a
	ld a,d
	pop de
	cp $3F
	jr nz,Logged_0x245FD
	ld a,$01
	ld [$D24D],a
	ld a,[de]
	ld c,a
	ld a,[$D154]
	or c
	jr nz,Logged_0x245FD
	jp Logged_0x2695D

Logged_0x245FD:
	bit 1,b
	jr nz,Logged_0x2460B
	bit 6,b
	jp nz,Logged_0x246A3
	bit 5,b
	jp nz,Logged_0x246BF

Logged_0x2460B:
	ld a,$03
	ld [$D160],a
	ld a,[de]
	ld hl,$D154
	cp [hl]
	jr z,Logged_0x2461F
	ld a,$03
	ld [$D15A],a
	jp Logged_0x246CB

Logged_0x2461F:
	ld hl,$D15A
	ld a,[hl]
	and a
	jr z,Logged_0x24628
	dec [hl]
	ret

Logged_0x24628:
	push de
	call Logged_0x25F2C
	pop de
	jr nc,Logged_0x24640
	ld a,[$D174]
	cp $04
	ret z
	call Logged_0x25FD5
	ld hl,$D143
	set 5,[hl]
	jp Logged_0x24801

Logged_0x24640:
	xor a
	ld [$D16C],a
	ld hl,$D150
	set 7,[hl]
	ld a,$01
	ld [$D157],a
	ld a,$01
	ld [$D15B],a
	ld a,[de]
	ld [$D154],a
	inc de
	ld a,[$D158]
	and $04
	ld l,a
	ld h,$00
	add hl,de
	ld a,[hli]
	ld [$D155],a
	inc hl
	ld a,[hl]
	ld [$D24C],a
	ld a,[$D154]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld a,[$D159]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$6E2C
	add hl,bc
	ld de,$D149
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$D145
	ld a,[$D24C]
	ld b,a
	ld a,[$D159]
	ld c,a
	ld d,$00
	jp Logged_0x31AF

Logged_0x246A3:
	ld hl,$D154
	ld a,[de]
	cp [hl]
	jr nz,Logged_0x246CB
	ld hl,$D150
	set 7,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$11
	ld d,$14
	jp Logged_0x31AF

Logged_0x246BF:
	ld a,[$D24D]
	and a
	jr nz,Logged_0x246CB
	ld a,[$D154]
	call Logged_0x26844

Logged_0x246CB:
	ld hl,$D150
	res 7,[hl]
	ld a,[de]
	ld [$D154],a
	ld hl,$D145
	inc de
	inc de
	inc de
	ld a,[de]
	ld b,a
	ld c,$00
	ld d,$00
	jp Logged_0x31AF

Logged_0x246E3:
	ld hl,$D142
	res 6,[hl]
	ld hl,$D158
	ld a,[$FF00+$96]
	and $03
	or [hl]
	ld [hl],a
	ld hl,$D155
	dec [hl]
	jp nz,Logged_0x2476F
	ld hl,$D142
	set 6,[hl]
	ld hl,$D148
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$D150
	res 7,[hl]
	xor a
	ld [$D151],a
	xor a
	ld [$D15B],a
	xor a
	ld [$D157],a
	call Logged_0x260DC
	ret c
	ld a,[$FF00+$95]
	bit 1,a
	jr z,Logged_0x24729
	call Logged_0x25F2C
	jp c,Logged_0x25FD5

Logged_0x24729:
	ld a,[$D154]
	call Logged_0x2688E
	jr nc,Logged_0x24752
	ld [$CE7B],a
	ld a,[$FF00+$91]
	cp $09
	ret z
	cp $0D
	ret z
	xor a
	ld [$D136],a
	ld b,$17
	ld a,[$D142]
	bit 4,a
	jr nz,Logged_0x2474E
	call Logged_0x26C81
	ld b,$04

Logged_0x2474E:
	ld a,b
	ld [$FF00+$91],a
	ret

Logged_0x24752:
	ld b,$00
	ld a,[$D12A]
	bit 5,a
	jp nz,Logged_0x26AD2
	ld hl,$D158
	ld a,[hl]
	and $03
	jp z,Logged_0x2455D
	res 0,[hl]
	res 1,[hl]
	ld hl,$FF96
	or [hl]
	ld [hl],a
	ret

Logged_0x2476F:
	ld a,[hl]
	cp $01
	ret nz
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld hl,$478B
	push hl
	ld a,[$D154]
	rst JumpList
	dw Logged_0x247DF
	dw Logged_0x247E4
	dw Logged_0x247EB
	dw Logged_0x247F4
	ld bc,$0060
	call Logged_0x2F6C
	jr z,Logged_0x247B5
	ld a,$09
	ld [$D157],a
	xor a
	ld [$D15F],a
	ld a,[$D154]
	ld c,a
	ld b,$00
	ld hl,$47FD
	add hl,bc
	ld a,[hl]
	ld [$D22B],a
	ld hl,$D149
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret

Logged_0x247B5:
	ld a,[$D154]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld a,[$D159]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$6F2C
	add hl,bc
	ld de,$D149
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld de,$D14D
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x247DF:
	ld a,d
	and $F0
	ld d,a
	ret

Logged_0x247E4:
	ld a,d
	and $F0
	add a,$10
	ld d,a
	ret

Logged_0x247EB:
	ld a,e
	add a,$08
	and $F0
	sub $08
	ld e,a
	ret

Logged_0x247F4:
	ld a,e
	add a,$08
	and $F0
	add a,$08
	ld e,a
	ret

LoggedData_0x247FD:
INCBIN "baserom.gb", $247FD, $247FE - $247FD

UnknownData_0x247FE:
INCBIN "baserom.gb", $247FE, $24800 - $247FE

LoggedData_0x24800:
INCBIN "baserom.gb", $24800, $24801 - $24800

Logged_0x24801:
	ld hl,$D158
	ld a,[hl]
	and $FC
	ld [hl],a
	ld a,[$D159]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	ld bc,$6D2C
	add hl,bc
	ld bc,$0040
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$FF00+$95]
	call Logged_0x3177
	ld e,l
	ld d,h
	and a
	jr z,Logged_0x2485A
	cp $02
	jr nz,Unknown_0x2483D
	ld a,[$FF00+$95]
	bit 1,a
	jp nz,Logged_0x248FB
	ld a,[$D161]
	ld [$D154],a
	jp Logged_0x25C03

Unknown_0x2483D:
	ld a,[$FF00+$96]
	call Logged_0x303A
	cp $FF
	jr nz,Unknown_0x2484C
	ld a,[$D154]
	jp Logged_0x26844

Unknown_0x2484C:
	push af
	call Logged_0x26844
	pop af

Logged_0x24851:
	ld [$D154],a
	call Logged_0x260BB
	jp Logged_0x25C09

Logged_0x2485A:
	xor a
	ld [$D16C],a
	ld a,[$D161]
	add a,a
	add a,a
	ld c,a
	ld a,[de]
	add a,c
	ld c,a
	ld b,$00
	ld hl,$7395
	add hl,bc
	ld a,[hl]
	and a
	jr nz,Logged_0x24878
	ld a,[de]
	ld [$D154],a
	jp Logged_0x25C03

Logged_0x24878:
	ld c,$08
	cp $01
	jr z,Logged_0x2488A
	ld a,[$FF00+$95]
	bit 1,a
	jr nz,Logged_0x24888
	ld a,[de]
	jp Logged_0x24851

Logged_0x24888:
	ld c,$04

Logged_0x2488A:
	ld a,[$D17C]
	and c
	jr nz,Logged_0x248AF
	ld hl,$D150
	set 7,[hl]
	ld a,[$D146]
	cp $14
	jr c,Logged_0x2489F
	cp $18
	ret c

Logged_0x2489F:
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$11
	ld d,$14
	jp Logged_0x31B3

Logged_0x248AF:
	ld a,[de]
	ld hl,$D154
	cp [hl]
	jr z,Logged_0x248BE
	ld a,$03
	ld [$D15A],a
	jp Logged_0x248E4

Logged_0x248BE:
	ld hl,$D15A
	ld a,[hl]
	and a
	jr z,Logged_0x248C7
	dec [hl]
	ret

Logged_0x248C7:
	ld hl,$D170
	ld a,e
	ld [hli],a
	ld [hl],d
	ld a,$04
	ld [$D15B],a
	ld b,$01
	ld hl,$D143
	bit 5,[hl]
	jr z,Logged_0x248DF
	res 5,[hl]
	ld b,$06

Logged_0x248DF:
	ld a,b
	ld [$D155],a
	ret

Logged_0x248E4:
	ld a,[$D161]
	add a,a
	add a,a
	ld c,a
	ld a,[de]
	ld [$D154],a
	add a,c
	ld c,a
	ld b,$00
	ld hl,$7385
	add hl,bc
	ld a,[hl]
	ld [$D161],a
	ret

Logged_0x248FB:
	ld hl,$D150
	set 7,[hl]
	ld hl,$D145
	ld a,[$D161]
	add a,$68
	ld b,a
	ld c,$00
	ld d,$0A
	jp Logged_0x31B3

Logged_0x24910:
	ld hl,$D142
	res 6,[hl]
	ld hl,$D158
	ld a,[$FF00+$96]
	and $03
	or [hl]
	ld [hl],a
	ld hl,$D155
	dec [hl]
	jr nz,Logged_0x24970
	ld hl,$D142
	set 6,[hl]
	ld hl,$D148
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$D150
	res 7,[hl]
	xor a
	ld [$D151],a
	ld a,$02
	ld [$D15B],a
	xor a
	ld [$D157],a
	ld a,$01
	ld [$D24C],a
	call Logged_0x26420
	ret c
	call Logged_0x260DC
	ret c
	ld b,$00
	ld a,[$D12A]
	bit 5,a
	jp nz,Logged_0x26AD2
	ld hl,$D158
	ld a,[hl]
	and $03
	jp z,Logged_0x24801
	res 0,[hl]
	res 1,[hl]
	ld hl,$FF96
	or [hl]
	ld [hl],a
	ret

Logged_0x24970:
	ld a,[hl]
	cp $01
	ret nz
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld hl,$498C
	push hl
	ld a,[$D154]
	rst JumpList
	dw Logged_0x247DF
	dw Logged_0x247E4
	dw Logged_0x247EB
	dw Logged_0x247F4
	push de
	ld bc,$0060
	call Logged_0x2F6C
	pop de
	jr z,Logged_0x249B8

Unknown_0x24996:
	ld a,$09
	ld [$D157],a
	xor a
	ld [$D15F],a
	ld a,[$D154]
	ld c,a
	ld b,$00
	ld hl,$47FD
	add hl,bc
	ld a,[hl]
	ld [$D22B],a
	ld hl,$D149
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret

Logged_0x249B8:
	ld a,[$D161]
	call Logged_0x301A
	ld bc,$0180
	call Logged_0x2F6C
	jr nz,Unknown_0x24996
	ld a,[$D154]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld a,[$D159]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$6F2C
	add hl,bc
	ld de,$D149
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld de,$D14D
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Logged_0x249F0:
	ld hl,$D170
	ld a,[hli]
	ld d,[hl]
	ld e,a
	ld a,[$FF00+$95]
	call Logged_0x303A
	cp $FF
	jr z,Logged_0x24A04
	ld b,a
	ld a,[de]
	cp b
	jr z,Logged_0x24A0A

Logged_0x24A04:
	ld a,$02
	ld [$D15B],a
	ret

Logged_0x24A0A:
	ld hl,$D155
	dec [hl]
	ret nz
	ld [hl],$01
	ld hl,$D161
	ld a,[de]
	ld b,a
	cp [hl]
	jr z,Logged_0x24A4D
	push de
	push bc
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld bc,$0060
	call Logged_0x2F6C
	pop bc
	pop de
	jr nz,Logged_0x24A44
	push de
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,b
	call Logged_0x301A
	ld bc,$0060
	call Logged_0x2F6C
	pop de
	jp z,Logged_0x24AF6

Logged_0x24A44:
	ld a,[$D161]
	add a,$68
	ld b,a
	jp Logged_0x24ADD

Logged_0x24A4D:
	push de
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,b
	call Logged_0x302A
	ld a,[$D161]
	rst JumpList
	dw Logged_0x24A66
	dw Logged_0x24A6F
	dw Logged_0x24A78
	dw Logged_0x24A81

Logged_0x24A66:
	ld a,[$D147]
	cp $21
	jr c,Logged_0x24A88
	jr Logged_0x24AA8

Logged_0x24A6F:
	ld a,[$D147]
	cp $80
	jr nc,Logged_0x24A88
	jr Logged_0x24AA8

Logged_0x24A78:
	ld a,[$D14B]
	cp $19
	jr c,Logged_0x24A88
	jr Logged_0x24AA8

Logged_0x24A81:
	ld a,[$D14B]
	cp $88
	jr c,Logged_0x24AA8

Logged_0x24A88:
	pop de
	ld hl,$D150
	set 7,[hl]
	ld a,[$D146]
	cp $14
	jr c,Logged_0x24A98
	cp $18
	ret c

Logged_0x24A98:
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$11
	ld d,$14
	jp Logged_0x31B3

Logged_0x24AA8:
	ld a,[$D17A]
	sub $68
	add a,a
	ld c,a
	ld b,$00
	ld hl,$7521
	add hl,bc
	ld a,[hli]
	ld b,a
	ld c,[hl]
	call Logged_0x2F6C
	pop de
	jr nz,Logged_0x24AD7
	push de
	ld a,[de]
	ld b,a
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,b
	call Logged_0x301A
	ld bc,$0060
	call Logged_0x2F6C
	pop de
	jp z,Logged_0x24AF6

Logged_0x24AD7:
	ld a,[$D154]
	add a,$68
	ld b,a

Logged_0x24ADD:
	ld hl,$D150
	set 7,[hl]
	ld a,[$D146]
	cp $14
	jr c,Logged_0x24AEC
	cp $18
	ret c

Logged_0x24AEC:
	ld hl,$D145
	ld c,$0C
	ld d,$14
	jp Logged_0x31B3

Logged_0x24AF6:
	ld a,[de]
	ld [$D154],a
	inc de
	ld hl,$D150
	set 7,[hl]
	ld a,$01
	ld [$D157],a
	ld a,$03
	ld [$D15B],a
	ld a,[$D158]
	and $04
	ld l,a
	ld h,$00
	add hl,de
	ld a,[hli]
	ld [$D155],a
	inc hl
	ld a,[$D154]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld a,[$D159]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$6E2C
	add hl,bc
	ld de,$D148
	xor a
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	xor a
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,[$D161]
	add a,$68
	ld b,a
	ld a,[$D159]
	ld c,a
	ld hl,$D145
	ld d,$0A
	call Logged_0x31B3
	ld a,[$D161]
	ld [$D17B],a
	ret

Logged_0x24B5F:
	ld a,[$D141]
	rra
	jr c,Logged_0x24B67
	jr Logged_0x24B9C

Logged_0x24B67:
	call Logged_0x2692A
	ld a,[$D157]
	rst JumpList
	dw Logged_0x24BD4
	dw Logged_0x25C26
	dw Unknown_0x26AD1
	dw Unknown_0x26AD1
	dw Logged_0x24DEF
	dw Unknown_0x26AD1
	dw Logged_0x25147
	dw Unknown_0x26AD1
	dw Unknown_0x26AD1
	dw Unknown_0x26AD1
	dw Unknown_0x26AD1
	dw Unknown_0x26AD1
	dw Unknown_0x2549D
	dw Unknown_0x26AD1
	dw Unknown_0x26AD1
	dw Unknown_0x26AD1
	dw Logged_0x25915
	dw Unknown_0x25C6D
	dw Logged_0x25CCF
	dw Logged_0x25CFC
	dw Logged_0x25DE7
	dw Logged_0x25E58
	dw Logged_0x25F13

Logged_0x24B9C:
	call Logged_0x268F7
	call Logged_0x269F1
	ld a,[$D157]
	rst JumpList
	dw Logged_0x25B4D
	dw Logged_0x25C26
	dw Logged_0x25C27
	dw Unknown_0x24E0C
	dw Logged_0x24E1B
	dw Logged_0x2511E
	dw Logged_0x25147
	dw Logged_0x2514F
	dw Logged_0x251B6
	dw Logged_0x25259
	dw Logged_0x2542C
	dw Logged_0x2547D
	dw Unknown_0x2549D
	dw Logged_0x254CE
	dw Unknown_0x25862
	dw Logged_0x2587E
	dw Logged_0x25915
	dw Unknown_0x25C6D
	dw Logged_0x25CCF
	dw Logged_0x25CFC
	dw Logged_0x25DE7
	dw Logged_0x25E58
	dw Logged_0x25F13

Logged_0x24BD4:
	ld b,$00
	ld a,[$D12A]
	bit 5,a
	jp nz,Logged_0x26AD2
	ld a,[$FF00+$91]
	cp $04
	ret z
	cp $17
	ret z
	ld a,[$FF00+$96]
	rra
	jr c,Logged_0x24BF3
	ld a,[$FF00+$95]
	rra
	rra
	jp c,Logged_0x24D4F
	ret

Logged_0x24BF3:
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x2FA4
	ld a,[hl]
	cp $10
	jp nz,Logged_0x24C94
	ld a,[$FF00+$91]
	cp $11
	ret z
	ld hl,$DC07
	set 6,[hl]
	call Logged_0x2685A
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld hl,$D158
	set 5,[hl]
	ld a,$10
	ld [$D16A],a
	ld hl,$D141
	res 0,[hl]
	set 7,[hl]
	xor a
	ld [$DC0F],a
	ld hl,$C158
	ld a,$04
	ld [hli],a
	ld [hl],$04
	ld a,$04
	ld [$D157],a
	ld a,$01
	ld [$D15E],a
	ld hl,$C705
	res 7,[hl]
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	ld hl,$D145
	jp Logged_0x31AF

Logged_0x24C55:
	ld a,$10
	ld [$D16A],a
	ld hl,$D141
	res 0,[hl]
	set 7,[hl]
	xor a
	ld [$DC0F],a
	ld hl,$D142
	res 3,[hl]
	ld hl,$C158
	ld a,$04
	ld [hli],a
	ld [hl],$04
	ld a,$04
	ld [$D157],a
	xor a
	ld [$D15E],a
	ld hl,$C705
	res 7,[hl]
	ld hl,$D150
	set 7,[hl]
	ld a,[$D154]
	add a,$58
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31AF

Logged_0x24C94:
	ld a,[$D142]
	bit 5,a
	jr z,Logged_0x24CA4
	ld a,[$C154]
	cp $08
	jr z,Logged_0x24CA4
	jr Logged_0x24CD7

Logged_0x24CA4:
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld bc,$0008
	call Logged_0x2F6C
	jr nz,Logged_0x24CD7
	ld hl,$DC03
	set 3,[hl]
	ld a,$04
	ld [$D157],a
	ld a,$1E
	ld [$D155],a
	ld hl,$D158
	set 5,[hl]
	ld a,[$D154]
	add a,$4C
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31AF

Logged_0x24CD7:
	ld hl,$DC03
	set 7,[hl]
	call Logged_0x2685A
	ld hl,$D141
	res 0,[hl]
	ld hl,$D142
	set 3,[hl]
	xor a
	ld [$DC0F],a
	ld a,$06
	ld [$D157],a
	ld a,$10
	ld [$D155],a
	ld hl,$D158
	set 5,[hl]
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	push de
	push de
	call Logged_0x3069
	pop bc
	ld de,$6D1E
	call Logged_0x309F
	ld a,$FA
	add a,l
	ld e,a
	ld d,h
	call Logged_0x31D7
	pop de
	push de
	call Logged_0x2FA4
	ld a,[$D142]
	bit 5,a
	jr z,Logged_0x24D34
	ld a,[$C154]
	cp $08
	jr z,Logged_0x24D34
	ld a,[hl]
	cp $68
	jr c,Logged_0x24D34
	cp $80
	jr c,Logged_0x24D36

Logged_0x24D34:
	ld a,[hli]
	ld [hld],a

Logged_0x24D36:
	ld a,$10
	ld [hli],a
	inc hl
	ld a,$43
	ld [hl],a
	pop de
	call Logged_0x3007
	push de
	ld c,e
	ld b,d
	ld a,$10
	call Logged_0x26C2
	pop bc
	ld a,$C3
	jp Logged_0x26C2

Logged_0x24D4F:
	ld hl,$D177
	ld a,[hl]
	and a
	ret nz
	ld a,[$FF00+$91]
	cp $13
	ret z
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld bc,$0008
	call Logged_0x2F6C
	jr nz,Logged_0x24D8D
	ld hl,$DC03
	set 3,[hl]
	ld a,$04
	ld [$D157],a
	ld a,$1E
	ld [$D155],a
	ld hl,$D158
	set 5,[hl]
	ld a,[$D154]
	add a,$4C
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31AF

Logged_0x24D8D:
	push de
	ld hl,$DC0C
	set 1,[hl]
	ld hl,$D141
	set 7,[hl]
	ld hl,$FF40
	set 6,[hl]
	res 3,[hl]
	ld a,$E3
	ld [$C0A7],a
	ld a,[$FF00+$90]
	cp $0E
	jr nz,Logged_0x24DAE
	ld a,$77
	jr Logged_0x24DB4

Logged_0x24DAE:
	ld a,[$CFDD]
	add a,a
	add a,$48

Logged_0x24DB4:
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	ld a,[$D142]
	bit 5,a
	jr nz,Logged_0x24DC8
	ld hl,$FF91
	set 2,[hl]

Logged_0x24DC8:
	ld a,$14
	ld [$D157],a
	ld hl,$D143
	set 4,[hl]
	ld hl,$D150
	set 7,[hl]
	ld hl,$D158
	set 5,[hl]
	pop de
	ld b,$42
	ld a,d
	cp $10
	jr nz,Logged_0x24DE6
	ld b,$43

Logged_0x24DE6:
	ld hl,$D145
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31B3

Logged_0x24DEF:
	ld hl,$D155
	dec [hl]
	ret nz
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	ld a,[$D154]
	add a,$50
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31AF

Unknown_0x24E0C:
	ld hl,$D155
	dec [hl]
	ret nz
	ld hl,$D129
	set 5,[hl]
	ld a,$20
	ld [$FF00+$91],a
	ret

Logged_0x24E1B:
	ld a,[$D15E]
	rst JumpList
	dw Logged_0x24E27
	dw Logged_0x24EAC
	dw Logged_0x25080
	dw Logged_0x250AB

Logged_0x24E27:
	ld a,[$FF00+$96]
	rra
	jp c,Logged_0x251CB
	ld a,[$D150]
	bit 6,a
	ret z
	ld a,$01
	ld [$D15E],a
	ld hl,$D150
	res 7,[hl]
	ret

Logged_0x24E3E:
	push bc
	push de
	call Logged_0x2605A
	pop de
	pop bc
	push de
	ld hl,$DC04
	set 5,[hl]
	ld a,b
	and $7F
	inc a
	ld [$D179],a
	push bc
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D154]
	ld [$D17B],a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$7479
	add hl,bc
	ld a,[hli]
	ld [$D17E],a
	add a,d
	ld d,a
	ld a,[hl]
	ld [$D17F],a
	add a,e
	ld e,a
	pop bc
	call Logged_0x2606F
	push hl
	call Logged_0x2698F
	pop hl
	pop de
	ld a,$18
	add a,l
	ld l,a
	ld a,$FF
	ld [hl],a
	ld a,[$D17A]
	ld b,a
	call Logged_0x26C53
	jr nc,Logged_0x24E90
	ld [hl],c

Logged_0x24E90:
	ld hl,$D159
	set 3,[hl]
	ld hl,$D158
	set 5,[hl]
	ld a,[$D154]
	ld [$D161],a
	add a,$5C
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x24EAC:
	ld b,$80
	ld a,[$D12A]
	bit 5,a
	jp nz,Logged_0x26AD2
	ld a,[$FF00+$96]
	bit 0,a
	jr z,Logged_0x24ECF
	ld a,$04
	ld [$D16E],a
	ld a,[$D179]
	and a
	call nz,Logged_0x25C03
	xor a
	ld [$D172],a
	jp Logged_0x25F9C

Logged_0x24ECF:
	ld a,[$FF00+$95]
	bit 1,a
	jr z,Logged_0x24F33
	ld a,[$D179]
	and a
	jp nz,Logged_0x24F52
	call Logged_0x25F2C
	jr nc,Logged_0x24EE6
	call Logged_0x24E3E
	jr Logged_0x24F52

Logged_0x24EE6:
	ld bc,$0062
	call Logged_0x2F6C
	bit 6,a
	jr nz,Logged_0x24F15
	ld a,[$FF00+$96]
	bit 1,a
	jr z,Logged_0x24F33
	ld a,$02
	ld [$D157],a
	ld hl,$D150
	set 7,[hl]
	ld hl,$D141
	set 2,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$10
	ld d,$00
	jp Logged_0x31AF

Logged_0x24F15:
	ld a,$07
	ld [$D157],a
	ld hl,$D158
	set 5,[hl]
	ld hl,$D141
	set 2,[hl]
	ld a,[$D154]
	add a,$5C
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31AF

Logged_0x24F33:
	ld a,[$D179]
	and a
	jr z,Logged_0x24F52
	ld a,[$FF00+$95]
	and $F0
	jr nz,Logged_0x24F52
	call Logged_0x25C03
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x24F52:
	ld a,[$FF00+$95]
	call Logged_0x303A
	cp $FF
	jr nz,Logged_0x24F77
	ld hl,$D150
	res 7,[hl]
	ld a,[$D179]
	and a
	jp nz,Logged_0x24E90
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x24F77:
	ld [$D24B],a
	ld hl,$D154
	cp [hl]
	jr z,Logged_0x24F88
	ld a,$08
	ld [$D16E],a
	jp Logged_0x25054

Logged_0x24F88:
	ld hl,$D16E
	ld a,[hl]
	and a
	jr z,Logged_0x24F91
	dec [hl]
	ret

Logged_0x24F91:
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D24B]
	call Logged_0x301A
	ld a,[$D24B]
	push de
	call Logged_0x3122
	pop de
	jp c,Unknown_0x25071
	ld bc,$0062
	push de
	call Logged_0x2F6C
	ld b,a
	ld a,d
	pop de
	jr z,Logged_0x24FEE
	cp $3F
	jr nz,Logged_0x24FC4
	ld hl,$D24B
	ld a,[$D154]
	or [hl]
	jp z,Logged_0x2695D

Logged_0x24FC4:
	bit 6,b
	jr z,Logged_0x24FDD
	ld hl,$D150
	set 7,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$11
	ld d,$0F
	jp Logged_0x31AF

Logged_0x24FDD:
	bit 1,b
	jp z,Logged_0x2505B
	ld a,[$D24B]
	ld [$D154],a
	call Logged_0x25F2C
	jp c,Logged_0x24E3E

Logged_0x24FEE:
	ld a,[$D179]
	and a
	jr z,Logged_0x2502D
	ld a,[$D24B]
	call Logged_0x301A
	ld a,[$D24B]
	push de
	call Logged_0x3122
	pop de
	ret c
	ld a,[$D17A]
	sub $68
	add a,a
	ld c,a
	ld b,$00
	ld hl,$7521
	add hl,bc
	ld a,[hli]
	ld b,a
	ld c,[hl]
	call Logged_0x2F6C
	jr z,Logged_0x2502D
	ld hl,$D150
	set 7,[hl]
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$11
	ld d,$0F
	ld hl,$D145
	jp Logged_0x31AF

Logged_0x2502D:
	ld hl,$D142
	res 1,[hl]
	ld a,$04
	ld [$D16E],a
	ld a,$02
	ld [$D15E],a
	ld hl,$D150
	set 7,[hl]
	ld a,[$D24B]
	ld [$D154],a
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	ld hl,$D145
	jp Logged_0x31AF

Logged_0x25054:
	ld a,[$D179]
	and a
	call nz,Logged_0x260BB

Logged_0x2505B:
	ld a,[$D24B]
	ld [$D154],a

Logged_0x25061:
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	ld hl,$D145
	jp Logged_0x31B3

Unknown_0x25071:
	ld a,[$D24B]
	ld [$D154],a
	ld a,[$D179]
	and a
	call nz,Logged_0x260BB
	jr Logged_0x25061

Logged_0x25080:
	ld a,$03
	ld [$D15E],a
	ld a,[$D179]
	and a
	jr nz,Logged_0x2509B
	ld a,[$D154]
	add a,$24
	ld b,a
	ld c,$04
	ld d,$03
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x2509B:
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$0D
	ld d,$0A
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x250AB:
	ld a,[$D154]
	swap a
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$D159
	ld a,[hl]
	add a,a
	add a,[hl]
	ld l,a
	ld h,$00
	add hl,bc
	ld bc,$73B9
	add hl,bc
	ld de,$D147
	ld a,[de]
	add a,[hl]
	ld [de],a
	inc de
	inc de
	inc de
	inc de
	inc hl
	ld a,[de]
	add a,[hl]
	ld [de],a
	inc hl
	ld a,[hl]
	ld [$D155],a
	ld a,[$D154]
	ld l,a
	ld h,$00
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	add hl,hl
	ld a,[$D159]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	add hl,bc
	ld bc,$6E2C
	add hl,bc
	ld de,$D149
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$01
	ld [$D157],a
	ld [$D15B],a
	ld hl,$D158
	res 5,[hl]
	ld hl,$D142
	res 6,[hl]
	ld hl,$D179
	ld a,[hli]
	and a
	ret z
	ld a,$03
	ld [$D15B],a
	ret

Logged_0x2511E:
	ld hl,$D150
	bit 6,[hl]
	ret z
	res 6,[hl]
	res 7,[hl]
	ld a,[$D141]
	bit 2,a
	jr nz,Unknown_0x25139
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	ret

Unknown_0x25139:
	xor a
	ld [$D15B],a
	inc a
	ld [$D15E],a
	ld a,$04
	ld [$D157],a
	ret

Logged_0x25147:
	ld hl,$D155
	dec [hl]
	ret nz
	jp Logged_0x24C55

Logged_0x2514F:
	ld a,[$FF00+$95]
	bit 1,a
	jp z,Logged_0x25C2F
	and $F0
	jr nz,Logged_0x2518A
	ld a,[$D141]
	bit 2,a
	jr nz,Logged_0x25176
	ld hl,$D150
	res 7,[hl]
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$00
	ld d,$0A
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x25176:
	ld hl,$D150
	res 7,[hl]
	ld a,[$D154]
	add a,$5C
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x2518A:
	ld hl,$D150
	set 7,[hl]
	ld d,$14
	ld bc,$1418
	ld a,[$D141]
	bit 2,a
	jr z,Logged_0x251A0
	ld bc,$0F13
	ld d,$0F

Logged_0x251A0:
	ld a,[$D146]
	cp b
	jr c,Logged_0x251A8
	cp c
	ret c

Logged_0x251A8:
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$11
	ld hl,$D145
	jp Logged_0x31B3

Logged_0x251B6:
	ld hl,$D150
	bit 6,[hl]
	ret z
	ld a,[$D172]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5253
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

Logged_0x251CB:
	ld hl,$DC04
	set 0,[hl]

Logged_0x251D0:
	call Logged_0x26876
	ld a,$08
	ld [$D177],a
	ld hl,$D141
	res 7,[hl]
	set 0,[hl]
	ld a,$01
	ld [$DC0F],a
	ld hl,$D150
	res 7,[hl]
	ld hl,$D158
	res 5,[hl]
	set 3,[hl]
	xor a
	ld [$D157],a
	ld hl,$C158
	ld a,$04
	ld [hli],a
	ld [hl],$04
	ld hl,$D145
	ld a,[$D154]
	add a,$50
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF
	ld a,$0A
	ld [$D157],a
	ld a,$27
	ld [$D155],a
	ld hl,$D150
	set 7,[hl]
	ld hl,$D158
	set 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$02
	ld d,$0B
	jp Logged_0x31B3
	ld hl,$DC03
	set 1,[hl]
	ld a,$0B
	ld [$D157],a
	ld hl,$D150
	set 7,[hl]
	ld hl,$D158
	set 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$04
	ld d,$17
	jp Logged_0x31B3

LoggedData_0x25253:
INCBIN "baserom.gb", $25253, $25259 - $25253

Logged_0x25259:
	ld a,[$D15F]
	rst JumpList
	dw Logged_0x25263
	dw Logged_0x253BF
	dw Logged_0x25400

Logged_0x25263:
	ld a,[$D154]
	ld d,a
	ld c,a
	ld b,$00
	ld hl,$73B5
	add hl,bc
	ld a,[hl]
	ld hl,$D22B
	and [hl]
	jr nz,Logged_0x25279
	ld a,d
	xor $01
	ld d,a

Logged_0x25279:
	ld a,d
	push af
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$73A5
	add hl,bc
	ld de,$D149
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld hl,$D158
	set 5,[hl]
	ld hl,$D15F
	inc [hl]
	pop af
	ld [$D24B],a
	rst JumpList
	dw Logged_0x252AA
	dw Logged_0x252B5
	dw Logged_0x252C0
	dw Logged_0x252CD

Logged_0x252AA:
	ld a,[$D147]
	and $0F
	jr nz,Logged_0x252D8
	ld a,$10
	jr Logged_0x252D8

Logged_0x252B5:
	ld a,[$D147]
	and $0F
	ld b,a
	ld a,$10
	sub b
	jr Logged_0x252D8

Logged_0x252C0:
	ld a,[$D14B]
	sub $08
	and $0F
	jr nz,Logged_0x252D8
	ld a,$10
	jr Logged_0x252D8

Logged_0x252CD:
	ld a,[$D14B]
	sub $08
	and $0F
	ld b,a
	ld a,$10
	sub b

Logged_0x252D8:
	ld [$D155],a
	cp $10
	ret c
	ld a,[$D17A]
	sub $68
	ld c,a
	ld b,$00
	ld hl,$5377
	add hl,bc
	ld a,[hl]
	and a
	jr nz,Logged_0x25366
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D179]
	and a
	jr z,Logged_0x2534F
	ld a,[$D24B]
	ld hl,$D161
	cp [hl]
	jr nz,Logged_0x25338
	call Logged_0x301A
	push de
	ld bc,$0001
	call Logged_0x2F6C
	pop de
	jr nz,Logged_0x25366
	ld a,[$D24B]
	call Logged_0x301A
	push de
	ld a,[$D24B]
	call Logged_0x3122
	pop de
	jr c,Logged_0x25366
	ld a,[$D17A]
	sub $68
	add a,a
	ld c,a
	ld b,$00
	ld hl,$538F
	add hl,bc
	ld a,[hli]
	ld c,[hl]
	ld b,a
	call Logged_0x2F6C
	ret z
	jr Logged_0x25366

Logged_0x25338:
	push de
	ld a,[$D17A]
	sub $68
	add a,a
	ld c,a
	ld b,$00
	ld hl,$538F
	add hl,bc
	ld a,[hli]
	ld c,[hl]
	ld b,a
	call Logged_0x2F6C
	pop de
	jr nz,Logged_0x25366

Logged_0x2534F:
	ld a,[$D24B]
	call Logged_0x301A
	push de
	ld a,[$D24B]
	call Logged_0x3122
	pop de
	jr c,Logged_0x25366
	ld bc,$0060
	call Logged_0x2F6C
	ret z

Logged_0x25366:
	ld a,$04
	ld [$D155],a
	ld a,$02
	ld [$D15F],a
	ld a,[$D24B]
	ld [$D22D],a
	ret

UnknownData_0x25377:
INCBIN "baserom.gb", $25377, $2537D - $25377

LoggedData_0x2537D:
INCBIN "baserom.gb", $2537D, $2537E - $2537D

UnknownData_0x2537E:
INCBIN "baserom.gb", $2537E, $2537F - $2537E

LoggedData_0x2537F:
INCBIN "baserom.gb", $2537F, $25381 - $2537F

UnknownData_0x25381:
INCBIN "baserom.gb", $25381, $25387 - $25381

LoggedData_0x25387:
INCBIN "baserom.gb", $25387, $25389 - $25387

UnknownData_0x25389:
INCBIN "baserom.gb", $25389, $2538E - $25389

LoggedData_0x2538E:
INCBIN "baserom.gb", $2538E, $2538F - $2538E

UnknownData_0x2538F:
INCBIN "baserom.gb", $2538F, $2539B - $2538F

LoggedData_0x2539B:
INCBIN "baserom.gb", $2539B, $2539D - $2539B

UnknownData_0x2539D:
INCBIN "baserom.gb", $2539D, $2539F - $2539D

LoggedData_0x2539F:
INCBIN "baserom.gb", $2539F, $253A3 - $2539F

UnknownData_0x253A3:
INCBIN "baserom.gb", $253A3, $253AF - $253A3

LoggedData_0x253AF:
INCBIN "baserom.gb", $253AF, $253B3 - $253AF

UnknownData_0x253B3:
INCBIN "baserom.gb", $253B3, $253BF - $253B3

Logged_0x253BF:
	ld hl,$D155
	dec [hl]
	ret nz
	ld hl,$D148
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hli],a
	ld [hli],a
	ld [hl],a
	xor a
	ld [$D157],a
	ld hl,$D142
	set 6,[hl]
	res 3,[hl]
	ld hl,$D158
	res 5,[hl]
	ld hl,$D150
	res 7,[hl]
	ld a,[$D179]
	and a
	jr z,Logged_0x253EC
	ld a,$02

Logged_0x253EC:
	ld [$D15B],a
	ld a,[$D179]
	and a
	jr z,Logged_0x253FD
	ld a,$01
	ld [$D24C],a
	call Logged_0x26420

Logged_0x253FD:
	jp Logged_0x260DC

Logged_0x25400:
	ld hl,$D155
	dec [hl]
	ret nz
	ld a,$04
	ld [hl],a
	ld a,[$D22D]
	xor $01
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$73A5
	add hl,bc
	ld de,$D149
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$01
	ld [$D15F],a
	ret

Logged_0x2542C:
	ld hl,$D155
	dec [hl]
	jr z,Logged_0x25445
	ld hl,$D150
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld a,[$D174]
	and a
	ret nz
	ld hl,$DC03
	set 0,[hl]
	ret

Logged_0x25445:
	call Logged_0x26311
	ret c
	ld a,$43
	ld [de],a
	dec de
	dec de
	ld a,$10
	ld [de],a
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x3007
	push de
	call Logged_0x3047
	pop de
	ld a,$11
	ld [hli],a
	ld [hl],d
	inc hl
	ld [hl],e
	inc hl
	ld a,$10
	ld [hl],a
	push de
	call Logged_0x3047
	pop de
	ld a,$11
	ld [hli],a
	ld [hl],d
	inc hl
	ld [hl],e
	inc hl
	ld a,$C3
	ld [hl],a
	jp Logged_0x251D0

Logged_0x2547D:
	ld hl,$D150
	bit 6,[hl]
	ret z
	res 7,[hl]
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	ld a,[$D154]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	ld hl,$D145
	jp Logged_0x31AF

Unknown_0x2549D:
	ld a,[$FF00+$96]
	and $03
	ld hl,$D158
	or [hl]
	ld [hl],a
	ld hl,$D155
	dec [hl]
	ret nz
	xor a
	ld [$D157],a
	ld hl,$D150
	res 7,[hl]
	ld hl,$D158
	res 5,[hl]
	ld hl,$D158
	ld a,[hl]
	and $03
	res 0,[hl]
	res 1,[hl]
	ld hl,$FF96
	or [hl]
	ld [hl],a
	and $03
	jp nz,Logged_0x25B4D
	ret

Logged_0x254CE:
	ld a,[$D15E]
	rst JumpList
	dw Logged_0x254E2
	dw Logged_0x25585
	dw Logged_0x25595
	dw Unknown_0x25753
	dw Logged_0x2579A
	dw Logged_0x257AA
	dw Logged_0x257C2
	dw Logged_0x25847

Logged_0x254E2:
	ld a,[$D17C]
	bit 1,a
	jp z,Unknown_0x25551
	ld c,$03
	ld d,$0E
	ld a,[$D141]
	bit 2,a
	jr z,Logged_0x254FD
	dec c
	ld d,$09
	ld a,$FF
	ld [$D145],a

Logged_0x254FD:
	ld hl,$D159
	res 3,[hl]
	ld hl,$D150
	set 7,[hl]
	ld a,$04
	ld [$D15E],a
	dec a
	ld [$D155],a
	ld hl,$D145
	ld a,[$D161]
	add a,$5C
	ld b,a
	jp Logged_0x31AF

Logged_0x2551C:
	ld a,[$D17C]
	rra
	jp nc,Logged_0x25561
	ld c,$01
	ld d,$05
	ld a,[$D141]
	bit 2,a
	jr z,Logged_0x25531
	dec c
	ld d,$01

Logged_0x25531:
	ld hl,$D159
	res 3,[hl]
	ld hl,$D150
	set 7,[hl]
	ld a,$01
	ld [$D15E],a
	ld a,$03
	ld [$D155],a
	ld hl,$D145
	ld a,[$D161]
	add a,$5C
	ld b,a
	jp Logged_0x31B3

Unknown_0x25551:
	ld d,$1D
	ld c,$06
	ld a,[$D141]
	bit 2,a
	jr nz,Logged_0x2556F
	ld d,$22
	inc c
	jr Logged_0x2556F

Logged_0x25561:
	ld d,$13
	ld c,$04
	ld a,[$D141]
	bit 2,a
	jr nz,Logged_0x2556F
	ld d,$18
	inc c

Logged_0x2556F:
	ld a,$05
	ld [$D157],a
	ld hl,$D150
	set 7,[hl]
	ld hl,$D145
	ld a,[$D161]
	add a,$5C
	ld b,a
	jp Logged_0x31B3

Logged_0x25585:
	ld hl,$D155
	dec [hl]
	ret nz
	ld hl,$D142
	set 3,[hl]
	ld a,$07
	ld [$D15E],a
	ret

Logged_0x25595:
	ld a,[$D150]
	bit 5,a
	jp z,Logged_0x256FB
	res 5,a
	ld [$D150],a
	ld a,[$D179]
	and a
	ret z
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D161]
	xor $01
	call Logged_0x301A
	ld hl,$D24D
	ld [hl],e
	inc hl
	ld [hl],d
	push de
	ld a,[$D161]
	xor $01
	call Logged_0x3122
	pop de
	jr c,Logged_0x255E0
	ld a,[$D17A]
	sub $68
	add a,a
	ld c,a
	ld b,$00
	ld hl,$7521
	add hl,bc
	ld a,[hli]
	ld b,a
	ld c,[hl]
	push de
	call Logged_0x2F6C
	pop de
	jr z,Logged_0x25627

Logged_0x255E0:
	ld hl,$D142
	res 3,[hl]
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$10
	add a,l
	ld l,a
	ld a,$01
	ld [hl],a
	ld a,[$D161]
	ld [$D154],a
	ld a,$02
	ld [$D135],a
	ld a,[$D141]
	bit 2,a
	jr nz,Logged_0x25610
	ld hl,$D158
	res 5,[hl]
	xor a
	ld [$D157],a
	jp Logged_0x26037

Logged_0x25610:
	ld a,$FF
	ld [$D145],a
	ld a,$04
	ld [$D157],a
	ld a,$01
	ld [$D15E],a
	ld hl,$D150
	res 7,[hl]
	jp Logged_0x24E90

Logged_0x25627:
	xor a
	ld [$D24C],a
	push de
	call Logged_0x2642E
	pop de
	ret c
	ld a,[$D161]
	xor $01
	call Logged_0x301A
	push de
	ld a,[$D161]
	xor $01
	call Logged_0x3122
	pop de
	jr c,Logged_0x2565A
	ld a,[$D17A]
	sub $68
	add a,a
	ld c,a
	ld b,$00
	ld hl,$7521
	add hl,bc
	ld a,[hli]
	ld b,a
	ld c,[hl]
	call Logged_0x2F6C
	jr z,Logged_0x2568E

Logged_0x2565A:
	ld hl,$DC05
	set 1,[hl]
	xor a
	ld [$D179],a
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$03
	add a,l
	ld l,a
	ld a,[$D24E]
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,[$D24D]
	ld [hl],a
	ld a,$09
	add a,l
	ld l,a
	ld a,$02
	ld [hli],a
	ld a,$01
	ld [hli],a
	inc hl
	ld a,[$D161]
	xor $01
	ld [hli],a
	ld a,[$D17A]
	ld [hl],a
	ret

Logged_0x2568E:
	ld hl,$DC05
	set 1,[hl]
	xor a
	ld [$D179],a
	ld a,[$D161]
	add a,a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$7481
	add hl,bc
	ld a,[$D147]
	add a,[hl]
	ld b,a
	inc hl
	ld a,[$D14B]
	add a,[hl]
	ld c,a
	inc hl
	inc hl
	ld e,l
	ld d,h
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	inc hl
	inc hl
	push bc
	ld a,[$D161]
	xor $01
	ld b,a
	add a,a
	add a,a
	add a,b
	add a,$02
	ld [hli],a
	pop bc
	ld [hl],b
	inc hl
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld [hl],c
	inc hl
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc hl
	set 7,[hl]
	inc de
	ld a,$04
	add a,l
	ld l,a
	ld a,$02
	ld [hli],a
	ld a,[de]
	ld [hli],a
	inc hl
	ld a,[$D161]
	xor $01
	ld [hli],a
	ld a,[$D17A]
	ld [hl],a
	ld a,$F9
	add a,l
	ld l,a
	ld c,$00
	jp Logged_0x31C3

Logged_0x256FB:
	bit 6,a
	ret z
	ld a,[$D161]
	ld [$D154],a
	ld hl,$D142
	res 3,[hl]
	ld hl,$D150
	res 7,[hl]
	ld a,[$D141]
	bit 2,a
	jr nz,Logged_0x25736
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	xor a
	ld [$D15B],a
	ld a,$03
	ld [$D160],a
	ld hl,$D145
	ld a,[$D154]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF

Logged_0x25736:
	xor a
	ld [$D15B],a
	inc a
	ld [$D15E],a
	ld a,$04
	ld [$D157],a
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	jp Logged_0x31AF

Unknown_0x25753:
	ld a,[$D150]
	bit 6,a
	ret z
	ld hl,$D150
	res 7,[hl]
	ld a,[$D141]
	bit 2,a
	jr nz,Unknown_0x2577D
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF

Unknown_0x2577D:
	xor a
	ld [$D15B],a
	inc a
	ld [$D15E],a
	ld a,$04
	ld [$D157],a
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	jp Logged_0x31AF

Logged_0x2579A:
	ld hl,$D155
	dec [hl]
	ret nz
	ld hl,$D142
	set 3,[hl]
	ld a,$05
	ld [$D15E],a
	ret

Logged_0x257AA:
	ld a,[$D150]
	bit 5,a
	jp z,Logged_0x256FB
	res 5,a
	ld [$D150],a
	ld a,$02
	ld [$D155],a
	ld a,$06
	ld [$D15E],a
	ret

Logged_0x257C2:
	ld hl,$D155
	dec [hl]
	ret nz
	ld hl,$DC05
	set 1,[hl]
	xor a
	ld [$D179],a
	ld a,$02
	ld [$D15E],a
	ld a,[$D161]
	add a,a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$74A1
	add hl,bc
	ld a,[$D147]
	add a,[hl]
	ld d,a
	inc hl
	ld a,[$D14B]
	add a,[hl]
	ld e,a
	inc hl
	push hl
	ld a,[$D17A]
	sub $68
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$74C1
	add hl,bc
	ld a,[hli]
	ld [$D17C],a
	ld a,[hli]
	ld c,[hl]
	ld b,a
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$03
	add a,l
	ld l,a
	call Logged_0x26091
	inc hl
	ld a,[$D161]
	ld b,a
	add a,a
	add a,a
	add a,b
	add a,$02
	ld [hli],a
	inc hl
	inc hl
	pop de
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld a,$02
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld a,$02
	ld [hli],a
	ld a,[de]
	ld [hli],a
	inc hl
	ld a,[$D161]
	ld [hli],a
	ld a,[$D17A]
	ld [hl],a
	ret

Logged_0x25847:
	ld hl,$D150
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld a,$02
	ld [$D15E],a
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$10
	add a,l
	ld l,a
	ld a,$04
	ld [hl],a
	ret

Unknown_0x25862:
	ld hl,$D155
	dec [hl]
	ret nz
	ld a,$06
	ld [hli],a
	ld de,$D14B
	ld a,[de]
	xor $02
	ld [de],a
	dec [hl]
	ret nz
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	jp Logged_0x251CB

Logged_0x2587E:
	ld a,[$D154]
	ld [$D24B],a
	ld a,[$FF00+$95]
	bit 1,a
	jr z,Logged_0x258CA
	ld hl,$D150
	bit 6,[hl]
	jr z,Logged_0x25898
	res 6,[hl]
	ld hl,$DC09
	set 3,[hl]

Logged_0x25898:
	ld a,[$FF00+$95]
	call Logged_0x303A
	cp $FF
	ret z
	ld [$D24B],a
	push af
	ld a,[$D161]
	add a,a
	add a,a
	ld c,a
	pop af
	add a,c
	ld c,a
	ld b,$00
	ld hl,$7395
	add hl,bc
	ld a,[hl]
	and a
	jr z,Logged_0x258CA
	ld b,a
	xor a
	ld [$D15E],a
	ld a,$0D
	ld [$D157],a
	ld a,b
	cp $01
	jp z,Logged_0x254E2
	jp Logged_0x2551C

Logged_0x258CA:
	ld hl,$D150
	res 7,[hl]
	ld a,[$D141]
	bit 2,a
	jr nz,Logged_0x258EE
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31B3

Logged_0x258EE:
	ld a,[$D179]
	and a
	call nz,Logged_0x25C03
	ld a,[$D24B]
	ld [$D154],a
	ld a,$04
	ld [$D157],a
	ld a,$01
	ld [$D15E],a
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	jp Logged_0x31B3

Logged_0x25915:
	ld a,[$D15F]
	rst JumpList
	dw Logged_0x2591F
	dw Logged_0x25A43
	dw Logged_0x25A69

Logged_0x2591F:
	ld b,$29
	ld a,[$D142]
	rra
	jr nc,Logged_0x25929
	ld b,$28

Logged_0x25929:
	ld hl,$D145
	xor a
	ld c,a
	ld d,a
	call Logged_0x31B3
	ld hl,$DC03
	set 5,[hl]
	ld hl,$D150
	set 7,[hl]
	ld a,$3C
	ld [$D162],a
	ld hl,$D158
	set 5,[hl]
	jr Logged_0x25961

Logged_0x25948:
	ld hl,$D149
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$02
	ld [$D15F],a
	ld a,[$D179]
	and a
	call nz,Logged_0x260BB
	jp Logged_0x25A15

Logged_0x25961:
	ld a,[$D154]
	xor $01
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$73A5
	add hl,bc
	ld de,$D148
	xor a
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	xor a
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld a,[$D154]
	xor $01
	rst JumpList
	dw Logged_0x25992
	dw Logged_0x2599E
	dw Logged_0x259AE
	dw Logged_0x259BC

Logged_0x25992:
	ld a,[$D147]
	and $0F
	jr z,Logged_0x25948
	ld b,a
	ld c,$00
	jr Logged_0x259CC

Logged_0x2599E:
	ld a,[$D147]
	and $0F
	jr z,Logged_0x25948
	ld b,a
	ld a,$10
	sub b
	ld b,a
	ld c,$00
	jr Logged_0x259CC

Logged_0x259AE:
	ld a,[$D14B]
	sub $08
	and $0F
	jr z,Logged_0x25948
	ld c,a
	ld b,$00
	jr Logged_0x259CC

Logged_0x259BC:
	ld a,[$D14B]
	sub $08
	and $0F
	jr z,Logged_0x25948
	ld b,a
	ld a,$10
	sub b
	ld c,a
	ld b,$00

Logged_0x259CC:
	ld [$D156],a
	ld hl,$D158
	res 4,[hl]
	ld a,$01
	ld [$D15F],a
	ld a,[$D141]
	rra
	jr c,Logged_0x25A15
	ld hl,$D147
	ld a,[hli]
	add a,b
	ld d,a
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	add a,c
	ld e,a
	ld bc,$0060
	call Logged_0x2F6C
	jr z,Logged_0x25A15
	ld hl,$D156
	ld a,$10
	sub [hl]
	ld [hl],a
	ld hl,$D149
	ld a,[hli]
	cpl
	ld d,a
	ld a,[hl]
	cpl
	ld e,a
	inc de
	ld a,e
	ld [hld],a
	ld a,d
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,[hli]
	cpl
	ld d,a
	ld a,[hl]
	cpl
	ld e,a
	inc de
	ld a,e
	ld [hld],a
	ld [hl],d

Logged_0x25A15:
	ld hl,$D141
	set 6,[hl]
	ld hl,$C540
	ld c,$20
	xor a
	call Logged_0x091D
	ld hl,$C540
	ld a,$8A
	ld [hli],a
	ld a,$B1
	ld [hli],a
	inc hl
	ld a,$8E
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,$96
	ld [hl],a
	ld a,$90
	ld [$C54C],a
	ld hl,$C54D
	ld c,$01
	jp Logged_0x31C3

Logged_0x25A43:
	ld hl,$D162
	dec [hl]
	ld hl,$D156
	dec [hl]
	ret nz
	ld hl,$D148
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld hl,$D142
	set 6,[hl]
	ld a,$02
	ld [$D15F],a
	ld a,[$D179]
	and a
	ret z
	jp Logged_0x260BB

Logged_0x25A69:
	ld hl,$D162
	dec [hl]
	ret nz
	ld a,$5A
	ld [$D16A],a
	ld [$D16B],a
	ld hl,$D141
	res 6,[hl]
	ld hl,$D150
	res 7,[hl]
	ld hl,$D158
	res 4,[hl]
	xor a
	ld [$D15B],a
	ld a,[$D143]
	bit 4,a
	jr z,Logged_0x25ABC
	ld a,$14
	ld [$D157],a
	ld hl,$D150
	set 7,[hl]
	ld hl,$D158
	set 5,[hl]
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x2FA4
	ld a,[hl]
	ld b,$42
	cp $10
	jr nz,Logged_0x25AB3
	ld b,$43

Logged_0x25AB3:
	ld hl,$D145
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31B3

Logged_0x25ABC:
	ld a,[$D141]
	rra
	jr c,Logged_0x25B04
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld bc,$0010
	call Logged_0x2F6C
	jr z,Logged_0x25AEC
	ld a,$01
	ld [$D15E],a
	ld a,$04
	ld [$D157],a
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	jp Logged_0x31AF

Logged_0x25AEC:
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF

Logged_0x25B04:
	ld hl,$C705
	res 7,[hl]
	ld hl,$D141
	res 7,[hl]
	set 0,[hl]
	ld a,$01
	ld [$DC0F],a
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x2FBC
	ld a,[hl]
	cp $43
	jr nz,Logged_0x25B35
	ld a,[$FF00+$91]
	bit 3,a
	jr nz,Logged_0x25B35
	ld hl,$D141
	set 7,[hl]
	ld hl,$C705
	set 7,[hl]

Logged_0x25B35:
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$50
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF

Logged_0x25B4D:
	ld b,$00
	ld a,[$D12A]
	bit 5,a
	jp nz,Logged_0x26AD2
	ld a,[$FF00+$91]
	cp $04
	ret z
	cp $17
	ret z
	ld a,[$FF00+$96]
	rra
	jr c,Logged_0x25B6C
	ld a,[$FF00+$95]
	bit 1,a
	jp nz,Logged_0x25B9D
	ret

Logged_0x25B6C:
	ld a,[$D179]
	and a
	jr z,Logged_0x25B7B
	ld a,[$D161]
	ld [$D154],a
	call Logged_0x25C03

Logged_0x25B7B:
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld bc,$0084
	call Logged_0x2F6C
	ret z
	rla
	jr c,Logged_0x25B95
	ld a,$02
	ld [$D172],a
	jp Logged_0x25F9C

Logged_0x25B95:
	ld a,$01
	ld [$D172],a
	jp Logged_0x25F9C

Logged_0x25B9D:
	ld a,[$D179]
	and a
	ret nz
	call Logged_0x25F2C
	jr nc,Logged_0x25BB1
	ld a,[$D174]
	cp $04
	ret z
	call Logged_0x25FD5
	ret

Logged_0x25BB1:
	ld bc,$0062
	call Logged_0x2F6C
	bit 6,a
	jr nz,Logged_0x25BE4
	ld a,[$FF00+$96]
	bit 1,a
	ret z
	ld a,$02
	ld [$D157],a
	ld hl,$D150
	set 7,[hl]
	ld hl,$D158
	set 5,[hl]
	ld hl,$D141
	res 2,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$10
	ld d,$05
	jp Logged_0x31AF

Logged_0x25BE4:
	ld a,$07
	ld [$D157],a
	ld hl,$D158
	set 5,[hl]
	ld hl,$D141
	res 2,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$00
	ld d,$0A
	jp Logged_0x31AF

Logged_0x25C03:
	call Logged_0x260CF
	call Logged_0x269BA

Logged_0x25C09:
	ld hl,$D159
	res 3,[hl]
	xor a
	ld [$D15B],a
	ld a,$03
	ld [$D160],a
	ld hl,$D145
	ld a,[$D161]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF

Logged_0x25C26:
	ret

Logged_0x25C27:
	ld hl,$D150
	bit 6,[hl]
	ret z
	res 6,[hl]

Logged_0x25C2F:
	ld a,[$D141]
	bit 2,a
	jr nz,Logged_0x25C4E
	xor a
	ld [$D157],a
	ld hl,$D158
	res 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF

Logged_0x25C4E:
	ld a,$04
	ld [$D157],a
	ld a,$01
	ld [$D15E],a
	ld hl,$D150
	res 7,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	jp Logged_0x31AF

Unknown_0x25C6D:
	ld a,[$D15E]
	rst JumpList
	dw Unknown_0x25C75
	dw Unknown_0x25C88

Unknown_0x25C75:
	ld hl,$D15E
	inc [hl]
	ld hl,$D155
	ld a,$58
	ld [hli],a
	ld a,$02
	ld [hl],a
	ld a,$01
	ld [$D133],a
	ret

Unknown_0x25C88:
	ld a,[$FF00+$96]
	and $0F
	jr nz,Logged_0x25C9A
	ld hl,$D155
	ld a,[hli]
	ld d,[hl]
	ld e,a
	dec de
	ld a,d
	ld [hld],a
	ld [hl],e
	or e
	ret nz

Logged_0x25C9A:
	ld hl,$D12D
	bit 7,[hl]
	jr z,Logged_0x25CAF
	res 7,[hl]
	ld a,$04
	ld [$D157],a
	ld a,$01
	ld [$D15E],a
	jr Logged_0x25CB3

Logged_0x25CAF:
	xor a
	ld [$D157],a

Logged_0x25CB3:
	xor a
	ld [$D133],a
	ld hl,$D158
	res 5,[hl]
	ld hl,$FF40
	ld a,[$D141]
	rra
	jr nc,Logged_0x25CCA
	res 6,[hl]
	set 3,[hl]
	ret

Logged_0x25CCA:
	set 6,[hl]
	res 3,[hl]
	ret

Logged_0x25CCF:
	ld a,[$D15E]
	rst JumpList
	dw Logged_0x25CD7
	dw Logged_0x25CE1

Logged_0x25CD7:
	ld a,$10
	ld [$D155],a
	ld hl,$D15E
	inc [hl]
	ret

Logged_0x25CE1:
	ld hl,$D155
	dec [hl]
	ret nz
	ld [hl],$10
	ld a,[$CE52]
	cp $04
	jp z,Logged_0x25C9A
	ld hl,$DC04
	set 2,[hl]
	call Logged_0x26BA2
	jp nc,Logged_0x25C9A
	ret

Logged_0x25CFC:
	ld a,[$D15E]
	rst JumpList
	dw Logged_0x25D08
	dw Unknown_0x25D1D
	dw Logged_0x25D23
	dw Logged_0x25DC2

Logged_0x25D08:
	ld hl,$D155
	dec [hl]
	ret nz
	ld a,$01
	ld [$D243],a
	ld a,$0E
	ld [$D244],a
	ld a,$02
	ld [$D15E],a
	ret

Unknown_0x25D1D:
	ld a,$03
	ld [$D15E],a
	ret

Logged_0x25D23:
	ld hl,$D150
	bit 6,[hl]
	ret z
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x25D45
	ld a,$14
	ld [$FF00+$91],a
	ld a,$03
	ld [$D15E],a
	ld hl,$D145
	ld b,$41
	ld c,$01
	ld d,$00
	jp Logged_0x31AF

Logged_0x25D45:
	ld hl,$D23D
	ld a,[$C9E4]
	ld [hli],a
	ld a,[$CFDB]
	ld [hli],a
	ld a,[$D147]
	ld [hli],a
	ld a,[$D14B]
	ld [hli],a
	ld a,[$D141]
	and $81
	ld [hl],a
	ld a,[$C9E4]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5DA2
	add hl,bc
	ld a,[hli]
	ld [$CFDB],a
	ld a,[hli]
	ld [$CFDE],a
	ld [$CFDF],a
	ld a,[$CE53]
	bit 6,a
	jr nz,Logged_0x25D8B
	ld hl,$CE71
	ld a,[hli]
	ld d,[hl]
	ld e,a
	inc de
	ld a,d
	ld [hld],a
	ld [hl],e
	call Logged_0x3224
	ld [$0000],a

Logged_0x25D8B:
	ld a,$0C
	ld [$FF00+$90],a
	ld a,$12
	ld [$FF00+$91],a
	xor a
	ld [$D120],a
	ld a,$73
	ld [$D6A5],a
	ld bc,$0101
	jp Logged_0x0AE5

LoggedData_0x25DA2:
INCBIN "baserom.gb", $25DA2, $25DA4 - $25DA2

UnknownData_0x25DA4:
INCBIN "baserom.gb", $25DA4, $25DA6 - $25DA4

LoggedData_0x25DA6:
INCBIN "baserom.gb", $25DA6, $25DA8 - $25DA6

UnknownData_0x25DA8:
INCBIN "baserom.gb", $25DA8, $25DC2 - $25DA8

Logged_0x25DC2:
	ld hl,$D150
	bit 6,[hl]
	ret z
	res 7,[hl]
	ld hl,$D158
	res 5,[hl]
	xor a
	ld [$D157],a
	xor a
	ld [$D15E],a
	ld a,[$C9E4]
	cp $07
	ret nz
	ld hl,$CEB5
	inc [hl]
	ld hl,$D12A
	res 0,[hl]
	ret

Logged_0x25DE7:
	ld a,[$FF00+$95]
	rra
	rra
	ret c
	ld hl,$D141
	res 7,[hl]
	ld hl,$D143
	res 4,[hl]
	ld hl,$DC0C
	set 2,[hl]
	ld a,$FF
	ld [$FF00+$47],a
	ld a,$FF
	ld [$FF00+$48],a
	ld hl,$FF40
	res 6,[hl]
	set 3,[hl]
	ld a,$AB
	ld [$C0A7],a
	ld a,[$FF00+$90]
	cp $0E
	jr nz,Logged_0x25E19
	ld a,$79
	jr Logged_0x25E1F

Logged_0x25E19:
	ld a,[$CFDD]
	add a,a
	add a,$49

Logged_0x25E1F:
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	ld a,[$D142]
	bit 5,a
	jr nz,Logged_0x25E33
	ld hl,$FF91
	res 2,[hl]

Logged_0x25E33:
	ld a,$1E
	ld [$FF00+$47],a
	ld a,$1C
	ld [$FF00+$48],a
	xor a
	ld [$D157],a
	ld hl,$D150
	res 7,[hl]
	ld hl,$D158
	res 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$50
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31B3

Logged_0x25E58:
	ld a,[$D15E]
	rst JumpList
	dw Logged_0x25E62
	dw Logged_0x25E72
	dw Logged_0x25EAF

Logged_0x25E62:
	ld a,$01
	ld [$D15E],a
	ld a,$20
	ld [$D155],a
	ld a,$02
	ld [$D245],a
	ret

Logged_0x25E72:
	ld hl,$D155
	dec [hl]
	ret nz
	ld a,$02
	ld [$D15E],a
	ld a,$01
	ld [$D243],a
	ld a,$02
	ld [$D244],a
	ld hl,$D150
	set 7,[hl]
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x2FA4
	ld d,$00
	ld a,[$D141]
	rra
	jr c,Logged_0x25EA5
	ld a,[hl]
	cp $10
	jr nz,Logged_0x25EA5
	ld d,$05

Logged_0x25EA5:
	ld hl,$D145
	ld b,$44
	ld c,$00
	jp Logged_0x31B3

Logged_0x25EAF:
	ld hl,$D150
	bit 6,[hl]
	ret z
	res 6,[hl]
	res 7,[hl]
	ld hl,$D158
	res 5,[hl]
	xor a
	ld [$D157],a
	ld b,$00
	ld a,[$CFDD]
	cp $0F
	jr nz,Logged_0x25ECC
	inc b

Logged_0x25ECC:
	ld a,b
	ld [$D243],a
	ld a,$04
	ld [$D245],a
	ld b,$50
	ld d,$00
	ld a,[$D141]
	rra
	jr c,Logged_0x25F06
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x2FA4
	ld b,$24
	ld d,$00
	ld a,[hl]
	cp $10
	jr nz,Logged_0x25F06
	ld a,$04
	ld [$D157],a
	ld a,$01
	ld [$D15E],a
	ld hl,$D158
	set 5,[hl]
	ld b,$58
	ld d,$09

Logged_0x25F06:
	ld hl,$D145
	ld a,[$D154]
	add a,b
	ld b,a
	ld c,$00
	jp Logged_0x31B3

Logged_0x25F13:
	ld a,$09
	ld [$D157],a
	ld hl,$DC05
	set 0,[hl]
	ret

UnknownData_0x25F1E:
INCBIN "baserom.gb", $25F1E, $25F2C - $25F1E

Logged_0x25F2C:
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D154]
	call Logged_0x301A
	ld a,d
	and a
	ret z
	cp $A0
	ret z
	ld a,e
	cp $F8
	ret z
	cp $A8
	ret z
	push de
	ld bc,$0002
	call Logged_0x2F6C
	jr nz,Logged_0x25F53
	and a
	jr Logged_0x25F9A

Logged_0x25F53:
	ld a,d
	cp $1F
	jr nz,Logged_0x25F87
	ld hl,$C154
	ld a,[hl]
	cp $09
	jr z,Logged_0x25F9A
	ld a,$09
	ld [$C154],a
	ld a,$04
	ld [$D174],a
	ld hl,$D158
	set 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$00
	ld d,$0A
	call Logged_0x31AF
	ld hl,$DC04
	set 5,[hl]
	scf
	pop de
	ret

Logged_0x25F87:
	sub $68
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$74C1
	add hl,bc
	ld a,[hli]
	ld [$D17C],a
	ld a,[hli]
	ld c,[hl]
	ld b,a
	scf

Logged_0x25F9A:
	pop de
	ret

Logged_0x25F9C:
	ld a,$10
	ld [$D16A],a
	ld hl,$D158
	res 0,[hl]
	res 1,[hl]
	ld hl,$DC09
	set 6,[hl]
	ld a,$08
	ld [$D157],a
	ld a,$10
	ld [$D155],a
	xor a
	ld [$D15E],a
	ld hl,$D150
	set 7,[hl]
	ld hl,$D158
	set 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$03
	ld d,$0E
	jp Logged_0x31B3

Logged_0x25FD5:
	ld a,[$D179]
	and a
	ret nz
	push bc
	ld hl,$DC04
	set 5,[hl]
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D154]
	call Logged_0x301A
	push de
	call Logged_0x2605A
	pop de
	pop bc
	push de
	push bc
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D154]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$7479
	add hl,bc
	ld a,[hli]
	ld [$D17E],a
	add a,d
	ld d,a
	ld a,[hl]
	ld [$D17F],a
	add a,e
	ld e,a
	pop bc
	ld a,b
	and $7F
	inc a
	ld [$D179],a
	call Logged_0x2606F
	push hl
	call Logged_0x2698F
	pop hl
	pop de
	ld a,$18
	add a,l
	ld l,a
	ld a,$FF
	ld [hl],a
	ld a,[$D17A]
	ld b,a
	call Logged_0x26C53
	jr nc,Logged_0x26037
	ld [hl],c

Logged_0x26037:
	ld hl,$D159
	set 3,[hl]
	ld a,[$D154]
	ld [$D161],a
	ld [$D17B],a
	ld a,$02
	ld [$D15B],a
	ld hl,$D145
	ld a,[$D154]
	add a,$68
	ld b,a
	ld c,$00
	ld d,$0A
	jp Logged_0x31AF

Logged_0x2605A:
	call Logged_0x3007
	push de
	srl d
	srl e
	call Logged_0x2FD4
	ld a,[hli]
	ld [$D17A],a
	ld a,[hld]
	ld [hl],a
	pop bc
	jp Logged_0x26C2

Logged_0x2606F:
	push de
	push bc
	call Logged_0x3069
	ld de,$D180
	ld a,l
	ld [de],a
	inc de
	ld a,h
	ld [de],a
	push hl
	ld c,$20
	xor a
	call Logged_0x091D
	pop hl
	push hl
	ld a,$15
	add a,l
	ld l,a
	ld [hl],b
	pop hl
	pop bc
	ld a,b
	ld [hli],a
	inc hl
	inc hl
	pop de

Logged_0x26091:
	ld a,d
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,e
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld [hl],a
	ld a,$04
	add a,l
	ld l,a
	xor a
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,[$D17A]
	ld [hl],a
	ld a,$ED
	add a,l
	ld l,a
	ld b,c
	ld c,$00
	ld d,$00
	push hl
	call Logged_0x31B3
	pop hl
	ret

Logged_0x260BB:
	ld hl,$D159
	res 3,[hl]
	call Logged_0x269BA
	jp Logged_0x260CF

UnknownData_0x260C6:
INCBIN "baserom.gb", $260C6, $260CF - $260C6

Logged_0x260CF:
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$18
	add a,l
	ld l,a
	set 7,[hl]
	ret

Logged_0x260DC:
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x2FA4
	ld e,l
	ld d,h
	ld a,[hl]
	ld [$D24B],a
	ld c,a
	ld b,$00
	ld hl,$6108
	add hl,bc
	ld a,[hl]
	rst JumpList
	dw Logged_0x26198
	dw Logged_0x2619D
	dw Logged_0x261DC
	dw Logged_0x261EB
	dw Logged_0x2623D
	dw Logged_0x26267
	dw Logged_0x261F6
	dw Logged_0x26205
	dw Logged_0x26214

LoggedData_0x26108:
INCBIN "baserom.gb", $26108, $2610D - $26108

UnknownData_0x2610D:
INCBIN "baserom.gb", $2610D, $26110 - $2610D

LoggedData_0x26110:
INCBIN "baserom.gb", $26110, $26111 - $26110

UnknownData_0x26111:
INCBIN "baserom.gb", $26111, $26112 - $26111

LoggedData_0x26112:
INCBIN "baserom.gb", $26112, $26115 - $26112

UnknownData_0x26115:
INCBIN "baserom.gb", $26115, $26118 - $26115

LoggedData_0x26118:
INCBIN "baserom.gb", $26118, $26119 - $26118

UnknownData_0x26119:
INCBIN "baserom.gb", $26119, $2611A - $26119

LoggedData_0x2611A:
INCBIN "baserom.gb", $2611A, $2611F - $2611A

UnknownData_0x2611F:
INCBIN "baserom.gb", $2611F, $26120 - $2611F

LoggedData_0x26120:
INCBIN "baserom.gb", $26120, $26124 - $26120

UnknownData_0x26124:
INCBIN "baserom.gb", $26124, $26139 - $26124

LoggedData_0x26139:
INCBIN "baserom.gb", $26139, $2613E - $26139

UnknownData_0x2613E:
INCBIN "baserom.gb", $2613E, $26198 - $2613E

Logged_0x26198:
	ld a,[$D24B]
	and a
	ret

Logged_0x2619D:
	ld a,$04
	ld [$D157],a
	ld a,$01
	ld [$D15E],a
	xor a
	ld [$D15B],a
	ld hl,$D158
	set 5,[hl]
	ld a,[$D179]
	and a
	jr z,Logged_0x261CA
	ld hl,$D145
	ld a,[$D161]
	ld [$D154],a
	add a,$5C
	ld b,a
	xor a
	ld c,a
	ld d,a
	call Logged_0x31AF
	scf
	ret

Logged_0x261CA:
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	call Logged_0x31AF
	scf
	ret

Logged_0x261DC:
	ld hl,$CE55
	ld a,[hl]
	and a
	ret nz
	inc [hl]
	call Logged_0x26223
	ld d,$32
	jp Logged_0x26C19

Logged_0x261EB:
	call Logged_0x26223
	call Logged_0x26BA2
	ld d,$31
	jp Logged_0x26C19

Logged_0x261F6:
	ld hl,$CE56
	ld a,[hl]
	and a
	ret nz
	inc [hl]
	call Logged_0x26223
	ld d,$33
	jp Logged_0x26C19

Logged_0x26205:
	ld hl,$CE54
	ld a,[hl]
	and a
	ret nz
	inc [hl]
	call Logged_0x26223
	ld d,$34
	jp Logged_0x26C19

Logged_0x26214:
	ld hl,$CE57
	ld a,[hl]
	and a
	ret nz
	inc [hl]
	call Logged_0x26223
	ld d,$35
	jp Logged_0x26C19

Logged_0x26223:
	ld hl,$DC04
	set 2,[hl]
	push de
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x3007
	ld c,e
	ld b,d
	pop hl
	inc hl
	ld a,[hld]
	ld [hl],a
	jp Logged_0x26C2

Logged_0x2623D:
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld a,[hl]
	cp $FF
	jr z,Logged_0x26265
	ld [hl],$FF
	call Logged_0x3218
	call Logged_0x26CC0
	ld a,[$D147]
	ld [hli],a
	ld a,[$D14B]
	ld [hl],a
	ld a,[$C922]
	ld [$CE70],a
	call Logged_0x3224

Logged_0x26265:
	and a
	ret

Logged_0x26267:
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x2629D
	ld a,[$D147]
	sub $10
	and $F0
	swap a
	ld d,a
	ld a,[$D14B]
	sub $08
	and $F0
	swap a
	ld e,a
	ld a,[$CFDB]
	ld b,a
	ld hl,$62D8

Logged_0x26289:
	ld a,[hli]
	cp $FF
	jr z,Unknown_0x262D6
	cp b
	jr nz,Logged_0x262D1
	ld a,[hli]
	cp d
	jr nz,Logged_0x262D2
	ld a,[hli]
	cp e
	jr nz,Logged_0x262D3
	ld a,[hl]
	ld [$D239],a

Logged_0x2629D:
	ld a,$13
	ld [$D157],a
	xor a
	ld [$D15E],a
	ld [$D179],a
	ld hl,$D158
	set 5,[hl]
	ld hl,$D150
	set 7,[hl]
	ld hl,$D145
	ld b,$41
	xor a
	ld c,a
	ld d,a
	call Logged_0x31AF
	ld a,$02
	ld [$D155],a
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x262CF
	ld a,$02
	ld [$D245],a

Logged_0x262CF:
	scf
	ret

Logged_0x262D1:
	inc hl

Logged_0x262D2:
	inc hl

Logged_0x262D3:
	inc hl
	jr Logged_0x26289

Unknown_0x262D6:
	and a
	ret

LoggedData_0x262D8:
INCBIN "baserom.gb", $262D8, $262DE - $262D8

UnknownData_0x262DE:
INCBIN "baserom.gb", $262DE, $262E0 - $262DE

LoggedData_0x262E0:
INCBIN "baserom.gb", $262E0, $262E5 - $262E0

UnknownData_0x262E5:
INCBIN "baserom.gb", $262E5, $262E8 - $262E5

LoggedData_0x262E8:
INCBIN "baserom.gb", $262E8, $262E9 - $262E8

UnknownData_0x262E9:
INCBIN "baserom.gb", $262E9, $262EC - $262E9

LoggedData_0x262EC:
INCBIN "baserom.gb", $262EC, $262ED - $262EC

UnknownData_0x262ED:
INCBIN "baserom.gb", $262ED, $262F0 - $262ED

LoggedData_0x262F0:
INCBIN "baserom.gb", $262F0, $262F1 - $262F0

UnknownData_0x262F1:
INCBIN "baserom.gb", $262F1, $262F4 - $262F1

LoggedData_0x262F4:
INCBIN "baserom.gb", $262F4, $26310 - $262F4

UnknownData_0x26310:
INCBIN "baserom.gb", $26310, $26311 - $26310

Logged_0x26311:
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	call Logged_0x2FBC
	ld e,l
	ld d,h
	push de
	ld hl,$633B
	push hl
	ld a,[de]
	ld c,a
	ld b,$00
	ld hl,$633D
	add hl,bc
	ld a,[hl]
	rst JumpList
	dw Logged_0x263CD
	dw Logged_0x263CD
	dw Logged_0x263CF
	dw Logged_0x263E0
	dw Logged_0x263ED
	dw Logged_0x263FE
	dw Logged_0x2640F
	pop de
	ret

LoggedData_0x2633D:
INCBIN "baserom.gb", $2633D, $2633E - $2633D

UnknownData_0x2633E:
INCBIN "baserom.gb", $2633E, $2634D - $2633E

LoggedData_0x2634D:
INCBIN "baserom.gb", $2634D, $2635D - $2634D

UnknownData_0x2635D:
INCBIN "baserom.gb", $2635D, $2636E - $2635D

LoggedData_0x2636E:
INCBIN "baserom.gb", $2636E, $26373 - $2636E

UnknownData_0x26373:
INCBIN "baserom.gb", $26373, $26380 - $26373

LoggedData_0x26380:
INCBIN "baserom.gb", $26380, $26381 - $26380

UnknownData_0x26381:
INCBIN "baserom.gb", $26381, $263CD - $26381

Logged_0x263CD:
	and a
	ret

Logged_0x263CF:
	ld hl,$DC04
	set 2,[hl]
	ld hl,$CE55
	ld a,[hl]
	and a
	ret nz
	inc [hl]
	ld d,$32
	jp Logged_0x26C19

Logged_0x263E0:
	ld hl,$DC04
	set 2,[hl]
	call Logged_0x26BA2
	ld d,$31
	jp Logged_0x26C19

Logged_0x263ED:
	ld hl,$DC04
	set 2,[hl]
	ld hl,$CE56
	ld a,[hl]
	and a
	ret nz
	inc [hl]
	ld d,$33
	jp Logged_0x26C19

Logged_0x263FE:
	ld hl,$DC04
	set 2,[hl]
	ld hl,$CE54
	ld a,[hl]
	and a
	ret nz
	inc [hl]
	ld d,$34
	jp Logged_0x26C19

Logged_0x2640F:
	ld hl,$DC04
	set 2,[hl]
	ld hl,$CE57
	ld a,[hl]
	and a
	ret nz
	inc [hl]
	ld d,$35
	jp Logged_0x26C19

Logged_0x26420:
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D161]
	call Logged_0x301A

Logged_0x2642E:
	push de
	call Logged_0x2FA4
	ld e,l
	ld d,h
	ld a,[hl]
	ld [$D24B],a
	ld c,a
	ld b,$00
	ld hl,$644A
	add hl,bc
	pop bc
	ld a,[hl]
	rst JumpList
	dw Logged_0x264DA
	dw Logged_0x264DC
	dw Logged_0x2661D
	dw Logged_0x266E7

LoggedData_0x2644A:
INCBIN "baserom.gb", $2644A, $2644F - $2644A

UnknownData_0x2644F:
INCBIN "baserom.gb", $2644F, $26452 - $2644F

LoggedData_0x26452:
INCBIN "baserom.gb", $26452, $26453 - $26452

UnknownData_0x26453:
INCBIN "baserom.gb", $26453, $26454 - $26453

LoggedData_0x26454:
INCBIN "baserom.gb", $26454, $26457 - $26454

UnknownData_0x26457:
INCBIN "baserom.gb", $26457, $2645A - $26457

LoggedData_0x2645A:
INCBIN "baserom.gb", $2645A, $2645B - $2645A

UnknownData_0x2645B:
INCBIN "baserom.gb", $2645B, $2645D - $2645B

LoggedData_0x2645D:
INCBIN "baserom.gb", $2645D, $26466 - $2645D

UnknownData_0x26466:
INCBIN "baserom.gb", $26466, $264AA - $26466

LoggedData_0x264AA:
INCBIN "baserom.gb", $264AA, $264AE - $264AA

UnknownData_0x264AE:
INCBIN "baserom.gb", $264AE, $264DA - $264AE

Logged_0x264DA:
	and a
	ret

Logged_0x264DC:
	ld e,c
	ld d,b
	ld hl,$D180
	ld a,[hli]
	ld c,a
	ld b,[hl]
	ld a,[$D17A]
	sub $68
	rst JumpList
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Unknown_0x26574
	dw Unknown_0x26574
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2651A
	dw Logged_0x2653B
	dw Logged_0x26575
	dw Unknown_0x26574
	dw Unknown_0x26574
	dw Unknown_0x26574
	dw Unknown_0x26574
	dw Unknown_0x26574
	dw Unknown_0x26574

Logged_0x2651A:
	ld a,$10
	add a,c
	ld l,a
	ld h,b
	ld a,$05
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,[$D17A]
	ld [hl],a
	xor a
	ld [$D179],a
	ld a,[$D24C]
	and a
	call nz,Logged_0x25C09
	ld hl,$DC05
	set 2,[hl]
	scf
	ret

Logged_0x2653B:
	push de
	xor a
	ld [bc],a
	xor a
	ld [$D179],a
	ld a,[$D24C]
	and a
	call nz,Logged_0x25C09
	pop de
	push de
	call Logged_0x2FA4
	ld [hl],$0C
	inc hl
	inc hl
	ld [hl],$50
	pop de
	call Logged_0x3007
	ld b,d
	ld c,e
	push bc
	ld a,$0C
	call Logged_0x26C2
	pop bc
	ld a,$D0
	call Logged_0x26C2
	ld a,[$D24C]
	and a
	call nz,Logged_0x25C09
	ld hl,$DC06
	set 2,[hl]
	scf
	ret

Unknown_0x26574:
	ret

Logged_0x26575:
	ld a,[$D12A]
	bit 5,a
	jr z,Logged_0x265A6
	ld a,$03
	add a,c
	ld l,a
	ld h,b
	ld a,d
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,e
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld [$D179],a
	ld a,$06
	add a,l
	ld l,a
	ld a,$0D
	ld [hli],a
	ld [hl],$02
	ld hl,$D12B
	set 1,[hl]
	ld a,[$D24C]
	and a
	jp nz,Logged_0x25C09
	ret

Logged_0x265A6:
	push de
	push bc
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x265C9
	ld a,$19
	add a,c
	ld c,a
	ld a,[bc]
	ld c,a
	ld b,$00
	ld hl,$6615
	add hl,bc
	ld d,[hl]
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CD82
	add hl,bc
	ld a,[hl]
	or d
	ld [hl],a

Logged_0x265C9:
	pop hl
	ld a,$10
	add a,l
	ld l,a
	ld a,$0C
	ld [hli],a
	ld [hl],$10
	ld a,$F2
	add a,l
	ld l,a
	xor a
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,$F8
	ld [hl],a
	ld a,$13
	add a,l
	ld l,a
	pop de
	ld a,d
	ld [hli],a
	ld [hl],e
	ld a,$FE
	add a,l
	ld l,a
	ld a,[hl]
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$C9E8
	add hl,bc
	ld a,$FF
	ld [hli],a
	ld [hl],a
	xor a
	ld [$D179],a
	ld a,[$D24C]
	and a
	call nz,Logged_0x25C09
	ld hl,$D142
	set 4,[hl]
	ld hl,$D12B
	set 1,[hl]
	ld hl,$DC05
	set 2,[hl]
	scf
	ret

LoggedData_0x26615:
INCBIN "baserom.gb", $26615, $2661B - $26615

UnknownData_0x2661B:
INCBIN "baserom.gb", $2661B, $2661D - $2661B

Logged_0x2661D:
	ld hl,$DC07
	set 5,[hl]
	ld hl,$D12A
	res 5,[hl]
	push bc
	ld a,$14
	ld [de],a
	ld e,c
	ld d,b
	call Logged_0x3007
	ld b,d
	ld c,e
	ld a,$14
	call Logged_0x26C2
	ld a,[$D24B]
	sub $60
	ld c,a
	ld b,$00
	ld hl,$66DF
	add hl,bc
	ld d,[hl]
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld a,[hl]
	or d
	ld [hl],a
	pop de
	cp $FF
	jr nz,Logged_0x2666C
	ld a,[$D12A]
	bit 3,a
	jp nz,Logged_0x266CF
	ld a,$05
	ld [$D174],a
	call Logged_0x26CC0
	ld a,d
	ld [hli],a
	ld [hl],e
	call Logged_0x3218

Logged_0x2666C:
	ld a,[$D12A]
	bit 3,a
	jr nz,Logged_0x266B1
	ld a,[$D17A]
	sub $70
	ld c,a
	ld b,$00
	ld hl,$66DF
	add hl,bc
	ld d,[hl]
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC82
	add hl,bc
	ld a,[hl]
	or d
	ld [hl],a
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$8F
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld [$D179],a
	ld a,[$D24C]
	and a
	call nz,Logged_0x25C09
	ld a,[$C922]
	ld [$CE70],a
	call Logged_0x3224
	scf
	ret

Logged_0x266B1:
	ld hl,$D13B
	set 0,[hl]
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$10
	add a,l
	ld l,a
	ld [hl],$08
	xor a
	ld [$D179],a
	ld a,[$D24C]
	and a
	call nz,Logged_0x25C09
	scf
	ret

Logged_0x266CF:
	ld a,$0B
	ld [$C253],a
	xor a
	ld [$C25B],a
	ld hl,$C254
	set 0,[hl]
	jr Logged_0x266B1

LoggedData_0x266DF:
INCBIN "baserom.gb", $266DF, $266E3 - $266DF

UnknownData_0x266E3:
INCBIN "baserom.gb", $266E3, $266E7 - $266E3

Logged_0x266E7:
	ld a,[$D17A]
	cp $6F
	jr nz,Logged_0x26721
	push bc
	ld a,[$D24B]
	sub $18
	add a,a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$67FE
	add hl,bc
	ld e,l
	ld d,h
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$10
	add a,l
	ld l,a
	ld [hl],$08
	pop bc
	ld a,[de]
	add a,b
	ld b,a
	inc de
	inc de
	inc de
	ld a,[de]
	add a,c
	ld c,a
	inc de
	inc de
	inc de
	ld a,[de]
	ld [$D24D],a
	push bc
	jp Logged_0x26793

Logged_0x26721:
	cp $7F
	ret z
	cp $7A
	ret z
	push bc
	ld a,[$D24B]
	sub $18
	add a,a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$67FE
	add hl,bc
	ld e,l
	ld d,h
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	pop bc
	push hl
	inc hl
	inc hl
	inc hl
	ld a,[de]
	add a,b
	ld [hli],a
	ld b,a
	inc de
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	add a,c
	ld [hli],a
	ld c,a
	inc de
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld a,$02
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld a,$02
	ld [hli],a
	ld [hli],a
	inc hl
	ld a,[de]
	ld [hl],a
	ld [$D24D],a
	inc de
	ld a,$05
	add a,l
	ld l,a
	set 2,[hl]
	ld a,$FC
	add a,l
	ld l,a
	ld a,[hl]
	sub $68
	push bc
	ld c,a
	ld b,$00
	ld hl,$681E
	add hl,bc
	pop bc
	ld a,[hl]
	pop hl
	push bc
	inc hl
	ld b,a
	ld a,[de]
	ld d,a
	ld c,$00
	call Logged_0x31B3

Logged_0x26793:
	xor a
	ld [$D179],a
	ld a,[$D24C]
	and a
	jr z,Logged_0x267DA
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld bc,$0010
	call Logged_0x2F6C
	jr nz,Unknown_0x267B2
	call Logged_0x25C09
	jr Logged_0x267DA

Unknown_0x267B2:
	ld hl,$D159
	res 3,[hl]
	ld a,$04
	ld [$D157],a
	ld a,$01
	ld [$D15E],a
	xor a
	ld [$D15B],a
	ld hl,$D158
	set 5,[hl]
	ld hl,$D145
	ld a,[$D154]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	call Logged_0x31AF

Logged_0x267DA:
	call Logged_0x3069
	pop bc
	ld de,$6836
	call Logged_0x309F
	ld a,$FA
	add a,l
	ld l,a
	ld b,$8C
	ld c,$00
	ld a,[$D24D]
	ld d,a
	add a,a
	add a,a
	add a,d
	ld d,a
	call Logged_0x31B3
	ld hl,$DC0A
	set 2,[hl]
	scf
	ret

LoggedData_0x267FE:
INCBIN "baserom.gb", $267FE, $2681E - $267FE

UnknownData_0x2681E:
INCBIN "baserom.gb", $2681E, $26826 - $2681E

LoggedData_0x26826:
INCBIN "baserom.gb", $26826, $26827 - $26826

UnknownData_0x26827:
INCBIN "baserom.gb", $26827, $2682E - $26827

LoggedData_0x2682E:
INCBIN "baserom.gb", $2682E, $26830 - $2682E

UnknownData_0x26830:
INCBIN "baserom.gb", $26830, $26836 - $26830

LoggedData_0x26836:
INCBIN "baserom.gb", $26836, $26844 - $26836

Logged_0x26844:
	ld b,a
	ld hl,$D16C
	ld a,[hl]
	and a
	jr nz,Logged_0x2684F
	inc [hl]
	jr Logged_0x26854

Logged_0x2684F:
	ld a,[$FF00+$96]
	and $F0
	ret z

Logged_0x26854:
	ld hl,$DC03
	set 3,[hl]
	ret

Logged_0x2685A:
	ld a,[$D142]
	bit 5,a
	jr nz,Logged_0x2686C
	ld a,[$FF00+$91]
	cp $13
	jr z,Logged_0x2686C
	ld hl,$FF91
	set 2,[hl]

Logged_0x2686C:
	ld a,$01
	ld [$D134],a
	xor a
	ld [$C158],a
	ret

Logged_0x26876:
	ld a,[$D142]
	bit 5,a
	jr nz,Logged_0x26888
	ld a,[$FF00+$91]
	cp $13
	jr z,Logged_0x26888
	ld hl,$FF91
	res 2,[hl]

Logged_0x26888:
	ld a,$02
	ld [$D134],a
	ret

Logged_0x2688E:
	rst JumpList
	dw Logged_0x26897
	dw Logged_0x268A6
	dw Logged_0x268B7
	dw Logged_0x268C7

Logged_0x26897:
	ld a,[$D147]
	cp $11
	ret nc
	ld a,[$FF00+$95]
	bit 6,a
	jr z,Logged_0x268D9
	xor a
	scf
	ret

Logged_0x268A6:
	ld a,[$D147]
	ld b,a
	ld a,$8F
	cp b
	ret nc
	ld a,[$FF00+$95]
	rla
	jr nc,Logged_0x268D9
	ld a,$01
	scf
	ret

Logged_0x268B7:
	ld a,[$D14B]
	cp $09
	ret nc
	ld a,[$FF00+$95]
	bit 5,a
	jr z,Logged_0x268D9
	ld a,$02
	scf
	ret

Logged_0x268C7:
	ld a,[$D14B]
	ld b,a
	ld a,$97
	cp b
	ret nc
	ld a,[$FF00+$95]
	bit 4,a
	jr z,Logged_0x268D9
	ld a,$03
	scf
	ret

Logged_0x268D9:
	and a
	ret

Logged_0x268DB:
	ld a,[$FF00+$91]
	cp $13
	ret z
	ld a,[$CE52]
	cp $02
	ret nc
	ld hl,$D16F
	ld a,[hl]
	and a
	jr z,Logged_0x268EF
	dec [hl]
	ret

Logged_0x268EF:
	ld [hl],$78
	ld hl,$DC04
	set 1,[hl]
	ret

Logged_0x268F7:
	ld hl,$C158
	ld a,[hli]
	and a
	ret z
	dec [hl]
	ret nz
	dec hl
	dec [hl]
	ld a,[hli]
	ld e,l
	ld d,h
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6922
	add hl,bc
	ld a,[hli]
	ld [de],a
	ld a,[$C15A]
	and a
	jr z,Logged_0x26918
	xor a
	ld [$C158],a

Logged_0x26918:
	ld a,[hl]
	ld [$C15F],a
	ld hl,$C15C
	set 2,[hl]
	ret

LoggedData_0x26922:
INCBIN "baserom.gb", $26922, $2692A - $26922

Logged_0x2692A:
	ld hl,$C158
	ld a,[hli]
	and a
	ret z
	dec [hl]
	ret nz
	dec hl
	dec [hl]
	ld a,[hli]
	ld e,l
	ld d,h
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6955
	add hl,bc
	ld a,[hli]
	ld [de],a
	ld a,[$C15A]
	and a
	jr z,Logged_0x2694B
	xor a
	ld [$C158],a

Logged_0x2694B:
	ld a,[hl]
	ld [$C15F],a
	ld hl,$C15C
	set 2,[hl]
	ret

LoggedData_0x26955:
INCBIN "baserom.gb", $26955, $2695D - $26955

Logged_0x2695D:
	ld hl,$D12A
	res 5,[hl]
	ld a,[$FF00+$91]
	ld [$C155],a
	ld a,$11
	ld [$FF00+$91],a
	ld hl,$CFD6
	ld a,[$FF00+$47]
	ld [hli],a
	ld a,[$FF00+$48]
	ld [hli],a
	ld a,[$FF00+$49]
	ld [hli],a
	ld a,[$FF00+$40]
	ld [hl],a
	ld hl,$DC05
	set 7,[hl]
	ld hl,$D12B
	set 0,[hl]
	xor a
	ld [$FF00+$95],a
	ld [$FF00+$96],a
	ld bc,$0110
	jp Logged_0x0AF7

Logged_0x2698F:
	inc hl
	inc hl
	ld a,[hli]
	sub $10
	and $F0
	ld d,a
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	sub $08
	and $F0
	swap a
	or d
	ld d,a
	push hl
	ld a,[$CFDB]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$CDC2
	add hl,bc
	ld a,[hl]
	pop hl
	cp d
	ret nz
	ld a,$11
	add a,l
	ld l,a
	set 0,[hl]
	ret

Logged_0x269BA:
	ld hl,$D180
	ld a,[hli]
	ld h,[hl]
	ld l,a
	ld a,$18
	add a,l
	ld l,a
	bit 0,[hl]
	ret z
	ld a,[$D147]
	ld d,a
	ld a,[$D14B]
	ld e,a
	ld a,[$D161]
	call Logged_0x301A
	ld a,d
	sub $10
	and $F0
	ld d,a
	ld a,e
	sub $08
	and $F0
	swap a
	or d
	ld d,a
	ld a,[$CFDB]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$CDC2
	add hl,bc
	ld [hl],d
	ret

Logged_0x269F1:
	ld hl,$D173
	ld a,[$D179]
	and a
	jr z,Logged_0x26A4E
	ld a,[$FF00+$95]
	and $F2
	cp $02
	jr nz,Logged_0x26A4E
	ld b,$00
	ld c,$12
	ld d,$1E
	ld a,[$D157]
	and a
	jr z,Logged_0x26A1F
	cp $04
	jr nz,Logged_0x26A4E
	ld a,[$D15E]
	cp $01
	jr nz,Logged_0x26A4E
	ld b,$04
	ld c,$12
	ld d,$19

Logged_0x26A1F:
	inc [hl]
	ld a,[hl]
	cp $1E
	ret c
	xor a
	ld [hl],a
	ld hl,$DC09
	set 3,[hl]
	ld hl,$D141
	ld a,[hl]
	and $FB
	or b
	ld [hl],a
	ld a,$0F
	ld [$D157],a
	ld hl,$D150
	set 7,[hl]
	ld hl,$D158
	set 5,[hl]
	ld hl,$D145
	ld a,[$D161]
	add a,$68
	ld b,a
	jp Logged_0x31B3

Logged_0x26A4E:
	xor a
	ld [hl],a
	ret

Logged_0x26A51:
	ld de,$D144
	ld hl,$C420
	ld a,[$D141]
	rla
	jr nc,Logged_0x26A71
	ld hl,$C220
	jr Logged_0x26A71

Logged_0x26A62:
	ld hl,$D144
	ld de,$C420
	ld a,[$D141]
	rla
	jr nc,Logged_0x26A71
	ld de,$C220

Logged_0x26A71:
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ret

Unknown_0x26AD1:
	ret

Logged_0x26AD2:
	ld a,[$D157]
	cp $04
	jr z,Logged_0x26ADE
	ld hl,$D158
	res 5,[hl]

Logged_0x26ADE:
	ld hl,$D12A
	res 5,[hl]
	ld hl,$D12B
	set 0,[hl]
	ld hl,$D12D
	ld a,[hl]
	or b
	ld [hl],a
	ld a,[$FF00+$91]
	ld [$C155],a
	ld a,$05
	ld [$FF00+$91],a
	ld hl,$CFD6
	ld a,[$FF00+$47]
	ld [hli],a
	ld a,[$FF00+$48]
	ld [hli],a
	ld a,[$FF00+$49]
	ld [hli],a
	ld a,[$FF00+$40]
	ld [hl],a
	ld hl,$DC05
	set 7,[hl]
	ld bc,$0110
	jp Logged_0x0AF7

Logged_0x26B11:
	ld hl,$D12D
	set 0,[hl]
	ld a,$01
	ld [$CE67],a
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld [hl],$FF
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC82
	add hl,bc
	ld [hl],$FF
	ld hl,$CA00
	ld de,$0018
	ld b,$09

Logged_0x26B3B:
	ld c,$0A

Logged_0x26B3D:
	ld a,[hl]
	cp $60
	jr c,Logged_0x26B4A
	cp $68
	jr nc,Logged_0x26B4A
	ld [hl],$14
	jr Logged_0x26B55

Logged_0x26B4A:
	cp $70
	jr c,Logged_0x26B55
	cp $78
	jr nc,Logged_0x26B55
	inc hl
	ld a,[hld]
	ld [hl],a

Logged_0x26B55:
	inc hl
	inc hl
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x26B3D
	add hl,de
	dec b
	jr nz,Logged_0x26B3B
	ld a,[$CFDB]
	inc a
	ld [$CE73],a
	ld hl,$CE53
	set 7,[hl]
	ret

UnknownData_0x26B6D:
INCBIN "baserom.gb", $26B6D, $26B85 - $26B6D

Logged_0x26B85:
	ld hl,$C233
	ld a,[$D141]
	rla
	jr c,Logged_0x26B91
	ld hl,$C433

Logged_0x26B91:
	ld a,$12
	ld [hli],a
	set 5,[hl]
	ld a,$06
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld a,$5A
	ld [$D16B],a
	ret

Logged_0x26BA2:
	ld hl,$CE52
	ld a,[hl]
	cp $04
	ret nc
	inc [hl]
	ld b,$3F
	ld a,[hl]
	ld c,a
	add a,a
	add a,a
	add a,[hl]
	ld d,a
	ld hl,$C5E1
	call Logged_0x31B3
	scf
	ret

UnknownData_0x26BBA:
INCBIN "baserom.gb", $26BBA, $26C19 - $26BBA

Logged_0x26C19:
	ld a,[$C9E4]
	cp $08
	ret z
	ld hl,$C9E7
	ld b,$01
	ld a,[hli]
	ld c,a
	and a
	ret z

Logged_0x26C28:
	ld a,[$D147]
	cp [hl]
	jr nz,Logged_0x26C3C
	inc hl
	ld a,[$D14B]
	cp [hl]
	jr nz,Logged_0x26C3D
	inc hl
	ld a,[hl]
	cp d
	jr z,Logged_0x26C45
	jr Logged_0x26C3E

Logged_0x26C3C:
	inc hl

Logged_0x26C3D:
	inc hl

Logged_0x26C3E:
	inc hl
	sla b
	dec c
	jr nz,Logged_0x26C28
	ret

Logged_0x26C45:
	ld a,[$CFDB]
	ld e,a
	ld d,$00
	ld hl,$CD82
	add hl,de
	ld a,[hl]
	or b
	ld [hl],a
	ret

Logged_0x26C53:
	ld a,b
	cp $79
	jr nz,Logged_0x26C7F
	push hl
	ld hl,$C9E7
	ld a,[hli]
	and a
	jr z,Unknown_0x26C7E
	inc hl
	inc hl
	ld c,$00

Logged_0x26C64:
	ld a,[hld]
	cp b
	jr nz,Logged_0x26C74
	ld a,[hld]
	cp e
	jr nz,Logged_0x26C73
	ld a,[hli]
	cp d
	jr nz,Logged_0x26C74
	pop hl
	scf
	ret

Logged_0x26C73:
	inc hl

Logged_0x26C74:
	inc hl
	inc hl
	inc hl
	inc hl
	inc c
	ld a,c
	cp $08
	jr c,Logged_0x26C64

Unknown_0x26C7E:
	pop hl

Logged_0x26C7F:
	and a
	ret

Logged_0x26C81:
	ld a,[$C9E4]
	cp $07
	ret nc
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld a,[hl]
	cp $FF
	ret nz
	ld hl,$C922
	ld a,[hli]
	ld c,a
	ld b,$00
	ld a,[$CFDB]

Logged_0x26C9F:
	cp [hl]
	jr z,Logged_0x26CAF
	inc hl
	inc hl
	inc hl
	inc b
	dec c
	jr nz,Logged_0x26C9F
	ld a,[$CE70]
	jp Logged_0x3230

Logged_0x26CAF:
	inc hl
	ld a,[$D147]
	ld [hli],a
	ld a,[$D14B]
	ld [hl],a
	ld a,b
	inc a
	ld [$CE70],a
	jp Logged_0x3230

Logged_0x26CC0:
	ld hl,$C922
	ld a,[hli]
	ld c,a
	ld a,[$CFDB]

Logged_0x26CC8:
	cp [hl]
	jr z,Logged_0x26CDC
	inc hl
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x26CC8
	ld a,[$C922]
	inc a
	ld [$C922],a
	ld a,[$CFDB]
	ld [hl],a

Logged_0x26CDC:
	ld a,[$CE73]
	dec a
	cp [hl]
	jr nz,Logged_0x26CED
	ld a,[$CE53]
	rla
	jr c,Logged_0x26CED
	xor a
	ld [$CE73],a

Logged_0x26CED:
	inc hl
	ret

LoggedData_0x26CEF:
INCBIN "baserom.gb", $26CEF, $26D2C - $26CEF

UnknownData_0x26D2C:
INCBIN "baserom.gb", $26D2C, $26D3C - $26D2C

LoggedData_0x26D3C:
INCBIN "baserom.gb", $26D3C, $26D3E - $26D3C

UnknownData_0x26D3E:
INCBIN "baserom.gb", $26D3E, $26D3F - $26D3E

LoggedData_0x26D3F:
INCBIN "baserom.gb", $26D3F, $26D40 - $26D3F

UnknownData_0x26D40:
INCBIN "baserom.gb", $26D40, $26D54 - $26D40

LoggedData_0x26D54:
INCBIN "baserom.gb", $26D54, $26D55 - $26D54

UnknownData_0x26D55:
INCBIN "baserom.gb", $26D55, $26D5C - $26D55

LoggedData_0x26D5C:
INCBIN "baserom.gb", $26D5C, $26D5E - $26D5C

UnknownData_0x26D5E:
INCBIN "baserom.gb", $26D5E, $26D7C - $26D5E

LoggedData_0x26D7C:
INCBIN "baserom.gb", $26D7C, $26D7E - $26D7C

UnknownData_0x26D7E:
INCBIN "baserom.gb", $26D7E, $26D7F - $26D7E

LoggedData_0x26D7F:
INCBIN "baserom.gb", $26D7F, $26D80 - $26D7F

UnknownData_0x26D80:
INCBIN "baserom.gb", $26D80, $26D94 - $26D80

LoggedData_0x26D94:
INCBIN "baserom.gb", $26D94, $26D96 - $26D94

UnknownData_0x26D96:
INCBIN "baserom.gb", $26D96, $26D9C - $26D96

LoggedData_0x26D9C:
INCBIN "baserom.gb", $26D9C, $26D9E - $26D9C

UnknownData_0x26D9E:
INCBIN "baserom.gb", $26D9E, $26DBC - $26D9E

LoggedData_0x26DBC:
INCBIN "baserom.gb", $26DBC, $26DBE - $26DBC

UnknownData_0x26DBE:
INCBIN "baserom.gb", $26DBE, $26DBF - $26DBE

LoggedData_0x26DBF:
INCBIN "baserom.gb", $26DBF, $26DC0 - $26DBF

UnknownData_0x26DC0:
INCBIN "baserom.gb", $26DC0, $26DD4 - $26DC0

LoggedData_0x26DD4:
INCBIN "baserom.gb", $26DD4, $26DD6 - $26DD4

UnknownData_0x26DD6:
INCBIN "baserom.gb", $26DD6, $26DDC - $26DD6

LoggedData_0x26DDC:
INCBIN "baserom.gb", $26DDC, $26DDE - $26DDC

UnknownData_0x26DDE:
INCBIN "baserom.gb", $26DDE, $26DFC - $26DDE

LoggedData_0x26DFC:
INCBIN "baserom.gb", $26DFC, $26DFE - $26DFC

UnknownData_0x26DFE:
INCBIN "baserom.gb", $26DFE, $26DFF - $26DFE

LoggedData_0x26DFF:
INCBIN "baserom.gb", $26DFF, $26E00 - $26DFF

UnknownData_0x26E00:
INCBIN "baserom.gb", $26E00, $26E14 - $26E00

LoggedData_0x26E14:
INCBIN "baserom.gb", $26E14, $26E16 - $26E14

UnknownData_0x26E16:
INCBIN "baserom.gb", $26E16, $26E1C - $26E16

LoggedData_0x26E1C:
INCBIN "baserom.gb", $26E1C, $26E1E - $26E1C

UnknownData_0x26E1E:
INCBIN "baserom.gb", $26E1E, $26E3C - $26E1E

LoggedData_0x26E3C:
INCBIN "baserom.gb", $26E3C, $26E40 - $26E3C

UnknownData_0x26E40:
INCBIN "baserom.gb", $26E40, $26E5C - $26E40

LoggedData_0x26E5C:
INCBIN "baserom.gb", $26E5C, $26E60 - $26E5C

UnknownData_0x26E60:
INCBIN "baserom.gb", $26E60, $26E7C - $26E60

LoggedData_0x26E7C:
INCBIN "baserom.gb", $26E7C, $26E80 - $26E7C

UnknownData_0x26E80:
INCBIN "baserom.gb", $26E80, $26E94 - $26E80

LoggedData_0x26E94:
INCBIN "baserom.gb", $26E94, $26E98 - $26E94

UnknownData_0x26E98:
INCBIN "baserom.gb", $26E98, $26E9C - $26E98

LoggedData_0x26E9C:
INCBIN "baserom.gb", $26E9C, $26EA0 - $26E9C

UnknownData_0x26EA0:
INCBIN "baserom.gb", $26EA0, $26EBC - $26EA0

LoggedData_0x26EBC:
INCBIN "baserom.gb", $26EBC, $26EC0 - $26EBC

UnknownData_0x26EC0:
INCBIN "baserom.gb", $26EC0, $26ED4 - $26EC0

LoggedData_0x26ED4:
INCBIN "baserom.gb", $26ED4, $26ED8 - $26ED4

UnknownData_0x26ED8:
INCBIN "baserom.gb", $26ED8, $26EDC - $26ED8

LoggedData_0x26EDC:
INCBIN "baserom.gb", $26EDC, $26EE0 - $26EDC

UnknownData_0x26EE0:
INCBIN "baserom.gb", $26EE0, $26EFC - $26EE0

LoggedData_0x26EFC:
INCBIN "baserom.gb", $26EFC, $26F00 - $26EFC

UnknownData_0x26F00:
INCBIN "baserom.gb", $26F00, $26F14 - $26F00

LoggedData_0x26F14:
INCBIN "baserom.gb", $26F14, $26F18 - $26F14

UnknownData_0x26F18:
INCBIN "baserom.gb", $26F18, $26F1C - $26F18

LoggedData_0x26F1C:
INCBIN "baserom.gb", $26F1C, $26F20 - $26F1C

UnknownData_0x26F20:
INCBIN "baserom.gb", $26F20, $26F3C - $26F20

LoggedData_0x26F3C:
INCBIN "baserom.gb", $26F3C, $26F40 - $26F3C

UnknownData_0x26F40:
INCBIN "baserom.gb", $26F40, $26F5C - $26F40

LoggedData_0x26F5C:
INCBIN "baserom.gb", $26F5C, $26F60 - $26F5C

UnknownData_0x26F60:
INCBIN "baserom.gb", $26F60, $26F7C - $26F60

LoggedData_0x26F7C:
INCBIN "baserom.gb", $26F7C, $26F80 - $26F7C

UnknownData_0x26F80:
INCBIN "baserom.gb", $26F80, $26F94 - $26F80

LoggedData_0x26F94:
INCBIN "baserom.gb", $26F94, $26F98 - $26F94

UnknownData_0x26F98:
INCBIN "baserom.gb", $26F98, $26F9C - $26F98

LoggedData_0x26F9C:
INCBIN "baserom.gb", $26F9C, $26FA0 - $26F9C

UnknownData_0x26FA0:
INCBIN "baserom.gb", $26FA0, $26FBC - $26FA0

LoggedData_0x26FBC:
INCBIN "baserom.gb", $26FBC, $26FC0 - $26FBC

UnknownData_0x26FC0:
INCBIN "baserom.gb", $26FC0, $26FD4 - $26FC0

LoggedData_0x26FD4:
INCBIN "baserom.gb", $26FD4, $26FD8 - $26FD4

UnknownData_0x26FD8:
INCBIN "baserom.gb", $26FD8, $26FDC - $26FD8

LoggedData_0x26FDC:
INCBIN "baserom.gb", $26FDC, $26FE0 - $26FDC

UnknownData_0x26FE0:
INCBIN "baserom.gb", $26FE0, $26FFC - $26FE0

LoggedData_0x26FFC:
INCBIN "baserom.gb", $26FFC, $27000 - $26FFC

UnknownData_0x27000:
INCBIN "baserom.gb", $27000, $27014 - $27000

LoggedData_0x27014:
INCBIN "baserom.gb", $27014, $27018 - $27014

UnknownData_0x27018:
INCBIN "baserom.gb", $27018, $2701C - $27018

LoggedData_0x2701C:
INCBIN "baserom.gb", $2701C, $27020 - $2701C

UnknownData_0x27020:
INCBIN "baserom.gb", $27020, $2703C - $27020

LoggedData_0x2703C:
INCBIN "baserom.gb", $2703C, $27040 - $2703C

UnknownData_0x27040:
INCBIN "baserom.gb", $27040, $2705D - $27040

LoggedData_0x2705D:
INCBIN "baserom.gb", $2705D, $27060 - $2705D

UnknownData_0x27060:
INCBIN "baserom.gb", $27060, $2707C - $27060

LoggedData_0x2707C:
INCBIN "baserom.gb", $2707C, $27080 - $2707C

UnknownData_0x27080:
INCBIN "baserom.gb", $27080, $2709D - $27080

LoggedData_0x2709D:
INCBIN "baserom.gb", $2709D, $270A0 - $2709D

UnknownData_0x270A0:
INCBIN "baserom.gb", $270A0, $270BC - $270A0

LoggedData_0x270BC:
INCBIN "baserom.gb", $270BC, $270C0 - $270BC

UnknownData_0x270C0:
INCBIN "baserom.gb", $270C0, $270DD - $270C0

LoggedData_0x270DD:
INCBIN "baserom.gb", $270DD, $270E0 - $270DD

UnknownData_0x270E0:
INCBIN "baserom.gb", $270E0, $270FC - $270E0

LoggedData_0x270FC:
INCBIN "baserom.gb", $270FC, $27100 - $270FC

UnknownData_0x27100:
INCBIN "baserom.gb", $27100, $2711D - $27100

LoggedData_0x2711D:
INCBIN "baserom.gb", $2711D, $27120 - $2711D

UnknownData_0x27120:
INCBIN "baserom.gb", $27120, $2713C - $27120

LoggedData_0x2713C:
INCBIN "baserom.gb", $2713C, $27140 - $2713C

UnknownData_0x27140:
INCBIN "baserom.gb", $27140, $2715C - $27140

LoggedData_0x2715C:
INCBIN "baserom.gb", $2715C, $27160 - $2715C

UnknownData_0x27160:
INCBIN "baserom.gb", $27160, $2717C - $27160

LoggedData_0x2717C:
INCBIN "baserom.gb", $2717C, $27180 - $2717C

UnknownData_0x27180:
INCBIN "baserom.gb", $27180, $2719C - $27180

LoggedData_0x2719C:
INCBIN "baserom.gb", $2719C, $271A0 - $2719C

UnknownData_0x271A0:
INCBIN "baserom.gb", $271A0, $271BC - $271A0

LoggedData_0x271BC:
INCBIN "baserom.gb", $271BC, $271C0 - $271BC

UnknownData_0x271C0:
INCBIN "baserom.gb", $271C0, $271DC - $271C0

LoggedData_0x271DC:
INCBIN "baserom.gb", $271DC, $271E0 - $271DC

UnknownData_0x271E0:
INCBIN "baserom.gb", $271E0, $271FC - $271E0

LoggedData_0x271FC:
INCBIN "baserom.gb", $271FC, $27200 - $271FC

UnknownData_0x27200:
INCBIN "baserom.gb", $27200, $2721C - $27200

LoggedData_0x2721C:
INCBIN "baserom.gb", $2721C, $27220 - $2721C

UnknownData_0x27220:
INCBIN "baserom.gb", $27220, $2723C - $27220

LoggedData_0x2723C:
INCBIN "baserom.gb", $2723C, $27240 - $2723C

UnknownData_0x27240:
INCBIN "baserom.gb", $27240, $2725C - $27240

LoggedData_0x2725C:
INCBIN "baserom.gb", $2725C, $27260 - $2725C

UnknownData_0x27260:
INCBIN "baserom.gb", $27260, $2727C - $27260

LoggedData_0x2727C:
INCBIN "baserom.gb", $2727C, $27280 - $2727C

UnknownData_0x27280:
INCBIN "baserom.gb", $27280, $2729C - $27280

LoggedData_0x2729C:
INCBIN "baserom.gb", $2729C, $272A0 - $2729C

UnknownData_0x272A0:
INCBIN "baserom.gb", $272A0, $272BC - $272A0

LoggedData_0x272BC:
INCBIN "baserom.gb", $272BC, $272C0 - $272BC

UnknownData_0x272C0:
INCBIN "baserom.gb", $272C0, $272DC - $272C0

LoggedData_0x272DC:
INCBIN "baserom.gb", $272DC, $272E0 - $272DC

UnknownData_0x272E0:
INCBIN "baserom.gb", $272E0, $272FC - $272E0

LoggedData_0x272FC:
INCBIN "baserom.gb", $272FC, $27300 - $272FC

UnknownData_0x27300:
INCBIN "baserom.gb", $27300, $2731C - $27300

LoggedData_0x2731C:
INCBIN "baserom.gb", $2731C, $27320 - $2731C

UnknownData_0x27320:
INCBIN "baserom.gb", $27320, $2732C - $27320

LoggedData_0x2732C:
INCBIN "baserom.gb", $2732C, $2732D - $2732C

UnknownData_0x2732D:
INCBIN "baserom.gb", $2732D, $2732F - $2732D

LoggedData_0x2732F:
INCBIN "baserom.gb", $2732F, $27330 - $2732F

UnknownData_0x27330:
INCBIN "baserom.gb", $27330, $2733C - $27330

LoggedData_0x2733C:
INCBIN "baserom.gb", $2733C, $2734C - $2733C

UnknownData_0x2734C:
INCBIN "baserom.gb", $2734C, $2735D - $2734C

LoggedData_0x2735D:
INCBIN "baserom.gb", $2735D, $27362 - $2735D

UnknownData_0x27362:
INCBIN "baserom.gb", $27362, $2737D - $27362

LoggedData_0x2737D:
INCBIN "baserom.gb", $2737D, $27387 - $2737D

UnknownData_0x27387:
INCBIN "baserom.gb", $27387, $27389 - $27387

LoggedData_0x27389:
INCBIN "baserom.gb", $27389, $2738B - $27389

UnknownData_0x2738B:
INCBIN "baserom.gb", $2738B, $2738F - $2738B

LoggedData_0x2738F:
INCBIN "baserom.gb", $2738F, $27391 - $2738F

UnknownData_0x27391:
INCBIN "baserom.gb", $27391, $27393 - $27391

LoggedData_0x27393:
INCBIN "baserom.gb", $27393, $273B9 - $27393

UnknownData_0x273B9:
INCBIN "baserom.gb", $273B9, $273C5 - $273B9

LoggedData_0x273C5:
INCBIN "baserom.gb", $273C5, $273C8 - $273C5

UnknownData_0x273C8:
INCBIN "baserom.gb", $273C8, $273DD - $273C8

LoggedData_0x273DD:
INCBIN "baserom.gb", $273DD, $273E0 - $273DD

UnknownData_0x273E0:
INCBIN "baserom.gb", $273E0, $273F5 - $273E0

LoggedData_0x273F5:
INCBIN "baserom.gb", $273F5, $273F8 - $273F5

UnknownData_0x273F8:
INCBIN "baserom.gb", $273F8, $2740D - $273F8

LoggedData_0x2740D:
INCBIN "baserom.gb", $2740D, $27410 - $2740D

UnknownData_0x27410:
INCBIN "baserom.gb", $27410, $27425 - $27410

LoggedData_0x27425:
INCBIN "baserom.gb", $27425, $27428 - $27425

UnknownData_0x27428:
INCBIN "baserom.gb", $27428, $2743D - $27428

LoggedData_0x2743D:
INCBIN "baserom.gb", $2743D, $27440 - $2743D

UnknownData_0x27440:
INCBIN "baserom.gb", $27440, $27455 - $27440

LoggedData_0x27455:
INCBIN "baserom.gb", $27455, $27458 - $27455

UnknownData_0x27458:
INCBIN "baserom.gb", $27458, $2746D - $27458

LoggedData_0x2746D:
INCBIN "baserom.gb", $2746D, $27470 - $2746D

UnknownData_0x27470:
INCBIN "baserom.gb", $27470, $27479 - $27470

LoggedData_0x27479:
INCBIN "baserom.gb", $27479, $27483 - $27479

UnknownData_0x27483:
INCBIN "baserom.gb", $27483, $27484 - $27483

LoggedData_0x27484:
INCBIN "baserom.gb", $27484, $2748B - $27484

UnknownData_0x2748B:
INCBIN "baserom.gb", $2748B, $2748C - $2748B

LoggedData_0x2748C:
INCBIN "baserom.gb", $2748C, $27493 - $2748C

UnknownData_0x27493:
INCBIN "baserom.gb", $27493, $27494 - $27493

LoggedData_0x27494:
INCBIN "baserom.gb", $27494, $2749B - $27494

UnknownData_0x2749B:
INCBIN "baserom.gb", $2749B, $2749C - $2749B

LoggedData_0x2749C:
INCBIN "baserom.gb", $2749C, $274A3 - $2749C

UnknownData_0x274A3:
INCBIN "baserom.gb", $274A3, $274A4 - $274A3

LoggedData_0x274A4:
INCBIN "baserom.gb", $274A4, $274AB - $274A4

UnknownData_0x274AB:
INCBIN "baserom.gb", $274AB, $274AC - $274AB

LoggedData_0x274AC:
INCBIN "baserom.gb", $274AC, $274B3 - $274AC

UnknownData_0x274B3:
INCBIN "baserom.gb", $274B3, $274B4 - $274B3

LoggedData_0x274B4:
INCBIN "baserom.gb", $274B4, $274BB - $274B4

UnknownData_0x274BB:
INCBIN "baserom.gb", $274BB, $274BC - $274BB

LoggedData_0x274BC:
INCBIN "baserom.gb", $274BC, $274C1 - $274BC

UnknownData_0x274C1:
INCBIN "baserom.gb", $274C1, $274D9 - $274C1

LoggedData_0x274D9:
INCBIN "baserom.gb", $274D9, $274DC - $274D9

UnknownData_0x274DC:
INCBIN "baserom.gb", $274DC, $274DD - $274DC

LoggedData_0x274DD:
INCBIN "baserom.gb", $274DD, $274E0 - $274DD

UnknownData_0x274E0:
INCBIN "baserom.gb", $274E0, $274E1 - $274E0

LoggedData_0x274E1:
INCBIN "baserom.gb", $274E1, $274E4 - $274E1

UnknownData_0x274E4:
INCBIN "baserom.gb", $274E4, $274E5 - $274E4

LoggedData_0x274E5:
INCBIN "baserom.gb", $274E5, $274E8 - $274E5

UnknownData_0x274E8:
INCBIN "baserom.gb", $274E8, $274E9 - $274E8

LoggedData_0x274E9:
INCBIN "baserom.gb", $274E9, $274EC - $274E9

UnknownData_0x274EC:
INCBIN "baserom.gb", $274EC, $274ED - $274EC

LoggedData_0x274ED:
INCBIN "baserom.gb", $274ED, $274F0 - $274ED

UnknownData_0x274F0:
INCBIN "baserom.gb", $274F0, $27501 - $274F0

LoggedData_0x27501:
INCBIN "baserom.gb", $27501, $27504 - $27501

UnknownData_0x27504:
INCBIN "baserom.gb", $27504, $27505 - $27504

LoggedData_0x27505:
INCBIN "baserom.gb", $27505, $27508 - $27505

UnknownData_0x27508:
INCBIN "baserom.gb", $27508, $2750D - $27508

LoggedData_0x2750D:
INCBIN "baserom.gb", $2750D, $27510 - $2750D

UnknownData_0x27510:
INCBIN "baserom.gb", $27510, $27511 - $27510

LoggedData_0x27511:
INCBIN "baserom.gb", $27511, $27514 - $27511

UnknownData_0x27514:
INCBIN "baserom.gb", $27514, $27515 - $27514

LoggedData_0x27515:
INCBIN "baserom.gb", $27515, $27518 - $27515

UnknownData_0x27518:
INCBIN "baserom.gb", $27518, $27519 - $27518

LoggedData_0x27519:
INCBIN "baserom.gb", $27519, $2751C - $27519

UnknownData_0x2751C:
INCBIN "baserom.gb", $2751C, $2751D - $2751C

LoggedData_0x2751D:
INCBIN "baserom.gb", $2751D, $27520 - $2751D

UnknownData_0x27520:
INCBIN "baserom.gb", $27520, $2752D - $27520

LoggedData_0x2752D:
INCBIN "baserom.gb", $2752D, $2752F - $2752D

UnknownData_0x2752F:
INCBIN "baserom.gb", $2752F, $27531 - $2752F

LoggedData_0x27531:
INCBIN "baserom.gb", $27531, $27539 - $27531

UnknownData_0x27539:
INCBIN "baserom.gb", $27539, $27541 - $27539

LoggedData_0x27541:
INCBIN "baserom.gb", $27541, $27545 - $27541

UnknownData_0x27545:
INCBIN "baserom.gb", $27545, $27547 - $27545

LoggedData_0x27547:
INCBIN "baserom.gb", $27547, $27551 - $27547

UnknownData_0x27551:
INCBIN "baserom.gb", $27551, $28000 - $27551

SECTION "Bank0A", ROMX, BANK[$0A]

LoggedData_0x28000:
INCBIN "baserom.gb", $28000, $28004 - $28000

UnknownData_0x28004:
INCBIN "baserom.gb", $28004, $28040 - $28004

LoggedData_0x28040:
INCBIN "baserom.gb", $28040, $28048 - $28040

UnknownData_0x28048:
INCBIN "baserom.gb", $28048, $2804C - $28048

LoggedData_0x2804C:
INCBIN "baserom.gb", $2804C, $28050 - $2804C

UnknownData_0x28050:
INCBIN "baserom.gb", $28050, $28054 - $28050

LoggedData_0x28054:
INCBIN "baserom.gb", $28054, $2806C - $28054

UnknownData_0x2806C:
INCBIN "baserom.gb", $2806C, $28070 - $2806C

LoggedData_0x28070:
INCBIN "baserom.gb", $28070, $2807C - $28070

UnknownData_0x2807C:
INCBIN "baserom.gb", $2807C, $28080 - $2807C

LoggedData_0x28080:
INCBIN "baserom.gb", $28080, $28084 - $28080

UnknownData_0x28084:
INCBIN "baserom.gb", $28084, $28088 - $28084

LoggedData_0x28088:
INCBIN "baserom.gb", $28088, $28090 - $28088

UnknownData_0x28090:
INCBIN "baserom.gb", $28090, $28200 - $28090

LoggedData_0x28200:
INCBIN "baserom.gb", $28200, $28204 - $28200

UnknownData_0x28204:
INCBIN "baserom.gb", $28204, $28244 - $28204

LoggedData_0x28244:
INCBIN "baserom.gb", $28244, $28254 - $28244

UnknownData_0x28254:
INCBIN "baserom.gb", $28254, $28258 - $28254

LoggedData_0x28258:
INCBIN "baserom.gb", $28258, $2825C - $28258

UnknownData_0x2825C:
INCBIN "baserom.gb", $2825C, $28260 - $2825C

LoggedData_0x28260:
INCBIN "baserom.gb", $28260, $28268 - $28260

UnknownData_0x28268:
INCBIN "baserom.gb", $28268, $28280 - $28268

LoggedData_0x28280:
INCBIN "baserom.gb", $28280, $282BC - $28280

UnknownData_0x282BC:
INCBIN "baserom.gb", $282BC, $28300 - $282BC

LoggedData_0x28300:
INCBIN "baserom.gb", $28300, $28310 - $28300

UnknownData_0x28310:
INCBIN "baserom.gb", $28310, $28400 - $28310

LoggedData_0x28400:
INCBIN "baserom.gb", $28400, $28414 - $28400

UnknownData_0x28414:
INCBIN "baserom.gb", $28414, $28420 - $28414

LoggedData_0x28420:
INCBIN "baserom.gb", $28420, $28424 - $28420

UnknownData_0x28424:
INCBIN "baserom.gb", $28424, $28428 - $28424

LoggedData_0x28428:
INCBIN "baserom.gb", $28428, $28438 - $28428

UnknownData_0x28438:
INCBIN "baserom.gb", $28438, $28440 - $28438

LoggedData_0x28440:
INCBIN "baserom.gb", $28440, $28470 - $28440

UnknownData_0x28470:
INCBIN "baserom.gb", $28470, $28480 - $28470

LoggedData_0x28480:
INCBIN "baserom.gb", $28480, $28484 - $28480

UnknownData_0x28484:
INCBIN "baserom.gb", $28484, $28498 - $28484

LoggedData_0x28498:
INCBIN "baserom.gb", $28498, $284C0 - $28498

UnknownData_0x284C0:
INCBIN "baserom.gb", $284C0, $284C4 - $284C0

LoggedData_0x284C4:
INCBIN "baserom.gb", $284C4, $284D8 - $284C4

UnknownData_0x284D8:
INCBIN "baserom.gb", $284D8, $284FC - $284D8

LoggedData_0x284FC:
INCBIN "baserom.gb", $284FC, $28590 - $284FC

UnknownData_0x28590:
INCBIN "baserom.gb", $28590, $285B8 - $28590

LoggedData_0x285B8:
INCBIN "baserom.gb", $285B8, $285D0 - $285B8

UnknownData_0x285D0:
INCBIN "baserom.gb", $285D0, $285E0 - $285D0

LoggedData_0x285E0:
INCBIN "baserom.gb", $285E0, $285E8 - $285E0

UnknownData_0x285E8:
INCBIN "baserom.gb", $285E8, $285EC - $285E8

LoggedData_0x285EC:
INCBIN "baserom.gb", $285EC, $28604 - $285EC

UnknownData_0x28604:
INCBIN "baserom.gb", $28604, $28624 - $28604

LoggedData_0x28624:
INCBIN "baserom.gb", $28624, $28628 - $28624

UnknownData_0x28628:
INCBIN "baserom.gb", $28628, $28640 - $28628

LoggedData_0x28640:
INCBIN "baserom.gb", $28640, $28680 - $28640

UnknownData_0x28680:
INCBIN "baserom.gb", $28680, $286C4 - $28680

LoggedData_0x286C4:
INCBIN "baserom.gb", $286C4, $286D8 - $286C4

UnknownData_0x286D8:
INCBIN "baserom.gb", $286D8, $286FC - $286D8

LoggedData_0x286FC:
INCBIN "baserom.gb", $286FC, $2872C - $286FC

UnknownData_0x2872C:
INCBIN "baserom.gb", $2872C, $28734 - $2872C

LoggedData_0x28734:
INCBIN "baserom.gb", $28734, $28750 - $28734

UnknownData_0x28750:
INCBIN "baserom.gb", $28750, $28754 - $28750

LoggedData_0x28754:
INCBIN "baserom.gb", $28754, $28780 - $28754

UnknownData_0x28780:
INCBIN "baserom.gb", $28780, $28800 - $28780

LoggedData_0x28800:
INCBIN "baserom.gb", $28800, $2AC60 - $28800

UnknownData_0x2AC60:
INCBIN "baserom.gb", $2AC60, $2AD60 - $2AC60

LoggedData_0x2AD60:
INCBIN "baserom.gb", $2AD60, $2C000 - $2AD60

SECTION "Bank0B", ROMX, BANK[$0B]

UnknownData_0x2C000:
INCBIN "baserom.gb", $2C000, $2C002 - $2C000
	call Logged_0x2C0A8
	xor a
	ld [$DC00],a
	call Logged_0x2C0C6
	xor a
	ld [$DC01],a
	call Logged_0x2C0D6
	xor a
	ld hl,$DC03
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	call Logged_0x2C184
	xor a
	ld [$DC02],a
	call Logged_0x2C1F5
	xor a
	ld [$DC22],a
	ld a,[$C0A0]
	rlca
	jr nc,Logged_0x2C06B
	ld a,[$DC10]
	cp $06
	jr nz,Unknown_0x2C044
	ld a,[$D23B]
	cp $01
	jr z,Logged_0x2C06B

Unknown_0x2C044:
	ld a,[$DC86]
	cp $01
	jr nz,Unknown_0x2C05B
	ld a,[$DC13]
	cp $01
	jr nz,Unknown_0x2C05B
	ld a,[$DC52]
	cp $02
	jr nz,Unknown_0x2C05B
	jr Logged_0x2C06B

Unknown_0x2C05B:
	ld a,[$DC1E]
	inc a
	ld [$DC1E],a
	cp $2B
	jr nz,Logged_0x2C06B
	xor a
	ld [$DC1E],a
	ret

Logged_0x2C06B:
	call Logged_0x2C282
	jp Logged_0x2CC04

UnknownData_0x2C071:
INCBIN "baserom.gb", $2C071, $2C0A8 - $2C071

Logged_0x2C0A8:
	ld b,$00
	ld a,[$DC00]
	and a
	ret z
	ld [$DC10],a
	dec a
	rlca
	ld c,a
	ld b,$00
	ld hl,$50FB
	add hl,bc
	ld a,[hli]
	ld [$DC16],a
	ld a,[hl]
	ld [$DC17],a
	jp Logged_0x2CB2A

Logged_0x2C0C6:
	ld b,$00
	ld a,[$DC01]
	and a
	ret z

Logged_0x2C0CD:
	rrca
	inc b
	jr nc,Logged_0x2C0CD
	ld a,b
	ld [$DC22],a
	ret

Logged_0x2C0D6:
	ld b,$00
	ld c,$00

Logged_0x2C0DA:
	ld d,$00
	ld e,$00
	xor a
	ld [$DC26],a
	ld hl,$DC03
	add hl,bc
	ld a,[hl]
	and a
	jr z,Logged_0x2C122
	ld [$DC26],a

Logged_0x2C0ED:
	ld a,[$DC26]
	rrca
	ld [$DC26],a
	jr nc,Logged_0x2C11C
	push bc
	ld a,$08
	ld h,a
	call Logged_0x2CBDC
	ld a,l
	add a,e
	inc a
	push af
	dec a
	rlca
	ld c,a
	ld b,$00
	ld hl,$5129
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ld a,[bc]
	ld b,$00
	ld c,a
	ld hl,$DCCC
	add hl,bc
	pop af
	ld [hl],a
	call Logged_0x2C129
	pop bc

Logged_0x2C11C:
	inc e
	ld a,e
	cp $08
	jr nz,Logged_0x2C0ED

Logged_0x2C122:
	inc c
	ld a,c
	cp $0B
	jr nz,Logged_0x2C0DA
	ret

Logged_0x2C129:
	call Logged_0x2C134
	call Logged_0x2C144
	call Logged_0x2C153
	jr Logged_0x2C16B

Logged_0x2C134:
	ld hl,$DCCF
	ld a,[hl]
	cp $1A
	ret nz
	ld hl,$DCD3
	ld a,[hl]
	cp $0C
	jr z,Logged_0x2C17D
	ret

Logged_0x2C144:
	ld hl,$DCCD
	ld a,[hl]
	cp $0A
	ret nz
	ld hl,$DCD1
	ld a,[hl]
	and a
	jr nz,Logged_0x2C17D
	ret

Logged_0x2C153:
	ld hl,$DCCE
	ld a,[hl]
	cp $04
	ret nz
	ld hl,$DCD2
	ld a,[hl]
	cp $0B
	jr z,Logged_0x2C17D
	cp $10
	jr z,Logged_0x2C17D
	cp $04
	jr z,Logged_0x2C17D
	ret

Logged_0x2C16B:
	ld hl,$DCD0
	add hl,bc
	ld a,[hl]
	cp $28
	jr z,Logged_0x2C17D
	cp $24
	jr z,Logged_0x2C17D
	cp $25
	jr z,Logged_0x2C17D
	ret

Logged_0x2C17D:
	ld hl,$DCCC
	add hl,bc
	xor a
	ld [hl],a
	ret

Logged_0x2C184:
	ld a,[$DC02]
	and a
	ret z
	rrca
	call c,Logged_0x2C1A8
	rrca
	call c,Logged_0x2C1BA
	rrca
	call c,Logged_0x2C1CC
	rrca
	call c,Logged_0x2C1E0
	rrca
	call c,Unknown_0x2C1F2
	rrca
	call c,Unknown_0x2C1F3
	rrca
	call c,Unknown_0x2C1F4
	rrca
	ret nc
	ret

Logged_0x2C1A8:
	push af
	ld a,[$DCD0]
	and a
	jr z,Logged_0x2C1B8
	xor a
	ld [$FF00+$12],a
	ld [$DCCC],a
	ld [$DCD0],a

Logged_0x2C1B8:
	pop af
	ret

Logged_0x2C1BA:
	push af
	ld a,[$DCD1]
	and a
	jr z,Logged_0x2C1CA
	xor a
	ld [$FF00+$17],a
	ld [$DCCD],a
	ld [$DCD1],a

Logged_0x2C1CA:
	pop af
	ret

Logged_0x2C1CC:
	push af
	ld a,[$DCD2]
	and a
	jr z,Logged_0x2C1DE
	xor a
	ld [$FF00+$1C],a
	ld [$FF00+$1A],a
	ld [$DCCE],a
	ld [$DCD2],a

Logged_0x2C1DE:
	pop af
	ret

Logged_0x2C1E0:
	push af
	ld a,[$DCD3]
	and a
	jr z,Logged_0x2C1F0
	xor a
	ld [$FF00+$21],a
	ld [$DCCF],a
	ld [$DCD3],a

Logged_0x2C1F0:
	pop af
	ret

Unknown_0x2C1F2:
	ret

Unknown_0x2C1F3:
	ret

Unknown_0x2C1F4:
	ret

Logged_0x2C1F5:
	ld a,[$DC22]
	and a
	ret z
	cp $01
	jr z,Logged_0x2C240
	cp $02
	jr z,Logged_0x2C207
	cp $03
	jr z,Logged_0x2C249
	ret

Logged_0x2C207:
	ld a,$01
	ld [$DC1F],a
	ld hl,$DB10
	ld de,$DC10
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld c,$A4
	ld hl,$DC28

Logged_0x2C231:
	ld a,[hl]
	dec h
	ld [hli],a
	inc h
	dec c
	jr nz,Logged_0x2C231
	call Logged_0x2CA94
	xor a
	ld [$DC10],a
	ret

Logged_0x2C240:
	xor a
	ld [$DC1F],a
	inc a
	ld [$DC24],a
	ret

Logged_0x2C249:
	xor a
	ld [$DC1F],a
	ld hl,$DC10
	ld de,$DB10
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld d,$00
	ld e,$00

Logged_0x2C271:
	ld hl,$DB28
	add hl,de
	ld a,[hl]
	ld hl,$DC28
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $A4
	jr nz,Logged_0x2C271
	ret

Logged_0x2C282:
	ld a,[$DC24]
	and a
	jr nz,Logged_0x2C28A
	jr Logged_0x2C298

Logged_0x2C28A:
	call Logged_0x2CA94
	xor a
	ld [$DC10],a
	ld [$DC22],a
	ld [$DC24],a
	ret

Logged_0x2C298:
	ld a,[$DC10]
	and a
	ret z
	ld d,$00
	ld e,$00

Logged_0x2C2A1:
	call Logged_0x2CAC1
	ld hl,$DCAC
	add hl,de
	jr z,Logged_0x2C2C8
	call Logged_0x2C2DD
	call Logged_0x2C5B7
	call Logged_0x2C847
	call Logged_0x2C78C
	call Logged_0x2C60A
	call Logged_0x2C65F
	call Logged_0x2C6B1
	call Logged_0x2C8E9
	call Logged_0x2C2CF
	call Logged_0x2C6F4

Logged_0x2C2C8:
	inc e
	ld a,e
	cp $04
	jr nz,Logged_0x2C2A1
	ret

Logged_0x2C2CF:
	ld hl,$DC50
	add hl,de
	ld a,[hl]
	and a
	ret z
	cp $FF
	jr z,Logged_0x2C2DB
	inc a

Logged_0x2C2DB:
	ld [hl],a
	ret

Logged_0x2C2DD:
	call Logged_0x2C389
	jr Logged_0x2C2E5

Logged_0x2C2E2:
	call Logged_0x2C384

Logged_0x2C2E5:
	ld b,a
	sub $20
	jr c,Logged_0x2C337
	ld a,b
	sub $2C
	jr c,Logged_0x2C311
	ld a,b
	sub $30
	jr c,Logged_0x2C309
	ld a,b
	sub $70
	jr c,Logged_0x2C2FD
	ld a,b
	jp Logged_0x2C4BD

Logged_0x2C2FD:
	ld a,b
	sub $30
	rlca
	rlca
	ld hl,$DC6C
	add hl,de
	ld [hl],a
	jr Logged_0x2C2E2

Logged_0x2C309:
	ld a,b
	sub $2C
	ld [$DC18],a
	jr Logged_0x2C2E2

Logged_0x2C311:
	ld a,b
	sub $20
	ld c,a
	ld b,$00
	push bc
	ld hl,$4F37
	ld a,[$DC12]
	rlca
	ld c,a
	ld b,$00
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld l,a
	ld h,b
	pop bc
	add hl,bc
	ld a,[hl]

Logged_0x2C32B:
	ld hl,$DC7C
	add hl,de
	ld [hl],a
	ld hl,$DC78
	add hl,de
	ld [hl],a
	jr Logged_0x2C2E2

Logged_0x2C337:
	ld a,b
	rlca
	ld c,a
	ld b,$00
	ld hl,$4344
	add hl,bc
	ld a,[hli]
	ld l,[hl]
	ld h,a
	jp hl

LoggedData_0x2C344:
INCBIN "baserom.gb", $2C344, $2C34C - $2C344

UnknownData_0x2C34C:
INCBIN "baserom.gb", $2C34C, $2C34E - $2C34C

LoggedData_0x2C34E:
INCBIN "baserom.gb", $2C34E, $2C354 - $2C34E

UnknownData_0x2C354:
INCBIN "baserom.gb", $2C354, $2C356 - $2C354

LoggedData_0x2C356:
INCBIN "baserom.gb", $2C356, $2C368 - $2C356

UnknownData_0x2C368:
INCBIN "baserom.gb", $2C368, $2C36A - $2C368

LoggedData_0x2C36A:
INCBIN "baserom.gb", $2C36A, $2C36C - $2C36A

UnknownData_0x2C36C:
INCBIN "baserom.gb", $2C36C, $2C384 - $2C36C

Logged_0x2C384:
	ld hl,$DC9C
	add hl,de
	inc [hl]

Logged_0x2C389:
	ld hl,$DC9C
	add hl,de
	ld a,[hl]
	ld c,a
	ld b,$00
	ld a,[$DC14]
	ld h,a
	ld a,[$DC15]
	ld l,a
	add hl,bc
	ld a,[hl]
	ret
	call Logged_0x2C384
	ld hl,$DC68
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	ld hl,$DC80
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	ld hl,$DC70
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	ld hl,$DC84
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	jp Logged_0x2C32B
	ld hl,$DC88
	add hl,de
	xor a
	ld [hl],a
	jp Logged_0x2C2E2
	ld hl,$DC88
	add hl,de
	ld a,$01
	ld [hl],a
	jp Logged_0x2C2E2
	ld hl,$DC88
	add hl,de
	ld a,$02
	ld [hl],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	ld hl,$DC8C
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2

UnknownData_0x2C3F6:
INCBIN "baserom.gb", $2C3F6, $2C3FC - $2C3F6
	ld a,[$DC11]
	inc a
	ld [$DC11],a
	push de
	ld d,$00
	ld e,$00

Logged_0x2C408:
	xor a
	ld hl,$DC9C
	add hl,de
	ld [hl],a
	ld hl,$DC50
	add hl,de
	ld [hl],a
	ld hl,$DC90
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $04
	jr nz,Logged_0x2C408
	pop de
	call Logged_0x2CAC1
	call Logged_0x2CAFC
	jp Logged_0x2C2DD
	call Logged_0x2C384
	ld [$DC12],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	ld [$DC13],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	ld hl,$DC54
	add hl,de
	ld [hl],a
	call Logged_0x2C384
	ld hl,$DC58
	add hl,de
	ld [hl],a
	call Logged_0x2C384
	ld hl,$DC5C
	add hl,de
	ld [hl],a
	ld a,$01
	ld hl,$DCC4
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2

UnknownData_0x2C45C:
INCBIN "baserom.gb", $2C45C, $2C47D - $2C45C
	xor a
	ld hl,$DC70
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	ld hl,$DC94
	add hl,de
	ld [hl],a
	call Logged_0x2C384
	ld hl,$DC98
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2
	xor a
	ld hl,$DC94
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2
	call Logged_0x2C384
	ld hl,$DC60
	add hl,de
	ld [hl],a
	call Logged_0x2C384
	ld hl,$DC90
	add hl,de
	ld [hl],a
	call Logged_0x2C384
	ld hl,$DC64
	add hl,de
	ld [hl],a
	jp Logged_0x2C2E2

Logged_0x2C4BD:
	ld a,b
	sub $70
	ld [$DC26],a
	cp $4A
	jp z,Logged_0x2C4F3
	ld a,e
	cp $03
	jr nz,Logged_0x2C4DE
	ld a,b
	sub $BC
	ld c,a
	ld b,$00
	ld hl,$5BB7
	add hl,bc
	ld a,[hl]
	ld [$DC1A],a
	jp Logged_0x2C4F3

Logged_0x2C4DE:
	ld a,[$DC26]
	and a
	jr z,Logged_0x2C4F3
	call Logged_0x2C590
	ld hl,$DC28
	add hl,de
	ld a,b
	ld [hl],a
	ld hl,$DC2C
	add hl,de
	ld a,c
	ld [hl],a

Logged_0x2C4F3:
	call Logged_0x2C771
	ld hl,$DC7C
	add hl,de
	ld a,[hl]
	ld hl,$DC74
	add hl,de
	sub [hl]
	ld hl,$DC78
	add hl,de
	cp [hl]
	jr nz,Logged_0x2C50A
	call Logged_0x2C553

Logged_0x2C50A:
	ld hl,$DC78
	add hl,de
	ld a,[hl]
	cp $01
	jr z,Logged_0x2C543
	ld hl,$DC7C
	add hl,de
	cp [hl]
	jr z,Logged_0x2C520

Logged_0x2C51A:
	ld hl,$DC78
	add hl,de
	dec [hl]
	ret

Logged_0x2C520:
	ld a,[$DC26]
	and a
	jr z,Logged_0x2C541
	ld hl,$DCC0
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x2C532
	xor a
	ld [hl],a
	jr Logged_0x2C541

Logged_0x2C532:
	ld a,$01
	ld hl,$DCA8
	add hl,de
	ld [hl],a
	ld hl,$DCA4
	add hl,de
	ld [hl],a
	call Logged_0x2CBA8

Logged_0x2C541:
	jr Logged_0x2C51A

Logged_0x2C543:
	ld hl,$DC9C
	add hl,de
	inc [hl]
	ld hl,$DC7C
	add hl,de
	ld a,[hl]
	ld hl,$DC78
	add hl,de
	ld [hl],a
	ret

Logged_0x2C553:
	call Logged_0x2C384
	cp $BA
	jr nz,Logged_0x2C562
	ld a,$01
	ld hl,$DCC0
	add hl,de
	ld [hl],a
	ret

Logged_0x2C562:
	ld hl,$DC9C
	add hl,de
	dec [hl]
	ld a,[$DC26]
	and a
	ret z
	ld hl,$DC94
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x2C57C
	ld hl,$DCBC
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x2C57C:
	ld a,e
	and a
	jp z,Logged_0x2CA9F
	cp $01
	jp z,Logged_0x2CAA7
	cp $02
	jp z,Logged_0x2CAAF
	cp $03
	jp z,Logged_0x2CAB9

Logged_0x2C590:
	ld b,a
	ld a,e
	cp $03
	ret z
	ld hl,$DC8C
	add hl,de
	ld a,[hl]
	add a,b
	rlca
	ld c,a
	ld b,$00
	ld a,[$C0A0]
	rlca
	jr c,Unknown_0x2C5AE
	ld hl,$4FD3
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ret

Unknown_0x2C5AE:
	ld hl,$5067
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ret

Logged_0x2C5B7:
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld c,a
	push bc
	ld hl,$DC70
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x2C5FC
	push af
	and $0F
	ld [$DC26],a
	pop af
	swap a
	and $0F
	ld [$DC27],a
	ld hl,$DC50
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x2C5FC
	ld b,a
	ld a,[$DC26]
	sub b
	jr c,Logged_0x2C5FC
	and a
	jr z,Logged_0x2C5FC
	ld h,a
	ld a,[$DC27]
	ld c,a
	call Logged_0x2CBDC
	ld a,l
	pop bc

Logged_0x2C5F6:
	dec bc
	dec a
	jr nz,Logged_0x2C5F6
	jr Logged_0x2C5FD

Logged_0x2C5FC:
	pop bc

Logged_0x2C5FD:
	ld hl,$DC28
	add hl,de
	ld a,b
	ld [hl],a
	ld hl,$DC2C
	add hl,de
	ld a,c
	ld [hl],a
	ret

Logged_0x2C60A:
	ld a,e
	cp $02
	ret z
	cp $03
	ret z
	ld hl,$DC68
	add hl,de
	ld a,[hl]
	rlca
	ld c,a
	ld b,$00
	ld hl,$5A95
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	push bc
	ld hl,$DC44
	add hl,de
	ld a,[hl]
	ld c,a
	ld b,$00
	pop hl
	add hl,bc
	ld a,[hl]
	push af
	ld a,c
	rrca
	jr c,Logged_0x2C64C
	pop af
	ld hl,$DC30
	add hl,de
	ld [hl],a
	ld a,$01
	ld hl,$DCA4
	add hl,de
	ld [hl],a
	ld hl,$DC4C
	add hl,de
	ld [hl],a

Logged_0x2C645:
	ld hl,$DC44
	add hl,de
	inc [hl]
	jr Logged_0x2C60A

Logged_0x2C64C:
	pop af
	cp $FF
	jr z,Logged_0x2C65E
	ld hl,$DC48
	add hl,de
	ld [hl],a
	ld hl,$DC4C
	add hl,de
	cp [hl]
	jr z,Logged_0x2C645
	inc [hl]

Logged_0x2C65E:
	ret

Logged_0x2C65F:
	ld a,e
	cp $02
	ret z
	ld hl,$DC80
	add hl,de
	ld a,[hl]
	rlca
	ld c,a
	ld b,$00
	ld hl,$5873
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	push bc
	ld hl,$DCB0
	add hl,de
	ld a,[hl]
	ld c,a
	ld b,$00
	pop hl
	add hl,bc
	ld a,[hl]
	push af
	ld a,c
	rrca
	jr c,Logged_0x2C69E
	pop af
	ld hl,$DCA0
	add hl,de
	ld [hl],a
	ld a,$01
	ld hl,$DCA8
	add hl,de
	ld [hl],a
	ld hl,$DCB8
	add hl,de
	ld [hl],a

Logged_0x2C697:
	ld hl,$DCB0
	add hl,de
	inc [hl]
	jr Logged_0x2C65F

Logged_0x2C69E:
	pop af
	cp $FF
	jr z,Logged_0x2C6B0
	ld hl,$DCB4
	add hl,de
	ld [hl],a
	ld hl,$DCB8
	add hl,de
	cp [hl]
	jr z,Logged_0x2C697
	inc [hl]

Logged_0x2C6B0:
	ret

Logged_0x2C6B1:
	ld hl,$DC94
	add hl,de
	ld a,[hl]
	and a
	ret z
	ld hl,$DCBC
	add hl,de
	ld a,[hl]
	and a
	ret z
	cp $01
	jr z,Logged_0x2C6DA

Logged_0x2C6C3:
	ld hl,$DC94
	add hl,de
	cp [hl]
	jr z,Logged_0x2C6D1
	inc a
	ld hl,$DCBC
	add hl,de
	ld [hl],a
	ret

Logged_0x2C6D1:
	xor a
	ld hl,$DCBC
	add hl,de
	ld [hl],a
	jp Logged_0x2C57C

Logged_0x2C6DA:
	push af
	ld hl,$DC98
	add hl,de
	ld a,[hl]
	ld hl,$DCA0
	add hl,de
	ld [hl],a
	ld a,$01
	ld hl,$DCA4
	add hl,de
	ld [hl],a
	ld hl,$DCA8
	add hl,de
	ld [hl],a
	pop af
	jr Logged_0x2C6C3

Logged_0x2C6F4:
	ld hl,$DC88

Logged_0x2C6F7:
	add hl,de
	ld a,[hl]
	ld hl,$DC23
	and a
	jr z,Logged_0x2C70B
	cp $01
	jr z,Logged_0x2C719
	jr Logged_0x2C727

Logged_0x2C705:
	ld hl,$DCF4
	jp Logged_0x2C6F7

Logged_0x2C70B:
	ld a,e
	and a
	jr z,Logged_0x2C735
	cp $01
	jr z,Logged_0x2C73A
	cp $02
	jr z,Logged_0x2C73F
	jr Logged_0x2C744

Logged_0x2C719:
	ld a,e
	and a
	jr z,Unknown_0x2C749
	cp $01
	jr z,Unknown_0x2C74E
	cp $02
	jr z,Logged_0x2C753
	jr Logged_0x2C758

Logged_0x2C727:
	ld a,e
	and a
	jr z,Unknown_0x2C75D
	cp $01
	jr z,Unknown_0x2C762
	cp $02
	jr z,Logged_0x2C767
	jr Logged_0x2C76C

Logged_0x2C735:
	set 0,[hl]
	set 4,[hl]
	ret

Logged_0x2C73A:
	set 1,[hl]
	set 5,[hl]
	ret

Logged_0x2C73F:
	set 2,[hl]
	set 6,[hl]
	ret

Logged_0x2C744:
	set 3,[hl]
	set 7,[hl]
	ret

Unknown_0x2C749:
	set 0,[hl]
	res 4,[hl]
	ret

Unknown_0x2C74E:
	set 1,[hl]
	res 5,[hl]
	ret

Logged_0x2C753:
	set 2,[hl]
	res 6,[hl]
	ret

Logged_0x2C758:
	set 3,[hl]
	res 7,[hl]
	ret

Unknown_0x2C75D:
	res 0,[hl]
	set 4,[hl]
	ret

Unknown_0x2C762:
	res 1,[hl]
	set 5,[hl]
	ret

Logged_0x2C767:
	res 2,[hl]
	set 6,[hl]
	ret

Logged_0x2C76C:
	res 3,[hl]
	set 7,[hl]
	ret

Logged_0x2C771:
	ld hl,$DC6C
	add hl,de
	ld a,[hl]
	ld c,a
	ld hl,$DC7C
	add hl,de
	ld a,[hl]
	ld h,a
	call Logged_0x2CBDC
	ld a,h
	and a
	jr nz,Logged_0x2C786
	ld a,$01

Logged_0x2C786:
	ld hl,$DC74
	add hl,de
	ld [hl],a
	ret

Logged_0x2C78C:
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	and a
	jp z,Logged_0x2C832
	ld hl,$DC50
	add hl,de
	ld a,[hl]
	ld hl,$DC54
	add hl,de
	cp [hl]
	jr nz,Logged_0x2C7A8
	ld a,$02
	ld hl,$DCC4
	add hl,de
	ld [hl],a

Logged_0x2C7A8:
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	cp $01
	jp z,Logged_0x2C832
	ld hl,$DCC8
	add hl,de
	ld a,[hl]
	ld b,a
	inc [hl]
	ld hl,$DC58
	add hl,de
	ld a,[hl]
	ld c,a
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	cp $02
	jr z,Logged_0x2C7CD
	ld a,c
	rlca
	add a,$02
	ld c,a

Logged_0x2C7CD:
	ld a,c
	cp b
	jr nz,Logged_0x2C7E4
	xor a
	ld hl,$DCC8
	add hl,de
	ld [hl],a
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	cp $04
	jr nz,Logged_0x2C7E2
	ld a,$02

Logged_0x2C7E2:
	inc a
	ld [hl],a

Logged_0x2C7E4:
	ld hl,$DC3C
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DC40
	add hl,de
	ld a,[hl]
	ld c,a
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	cp $03
	jr z,Logged_0x2C803
	ld hl,$DC5C
	add hl,de
	ld a,[hl]
	ld l,a
	xor a
	ld h,a
	jr Logged_0x2C811

Logged_0x2C803:
	push bc
	ld hl,$DC5C
	add hl,de
	ld a,[hl]
	ld b,a
	xor a
	sub b
	ld l,a
	ld a,$FF
	ld h,a
	pop bc

Logged_0x2C811:
	add hl,bc
	ld b,h
	ld c,l
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	push af
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld l,a
	pop af
	ld h,a
	add hl,bc
	ld a,h
	ld c,l
	ld hl,$DC34
	add hl,de
	ld [hl],a
	ld a,c
	ld hl,$DC38
	add hl,de
	ld [hl],a
	jr Logged_0x2C846

Logged_0x2C832:
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	ld hl,$DC34
	add hl,de
	ld [hl],a
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld hl,$DC38
	add hl,de
	ld [hl],a

Logged_0x2C846:
	ret

Logged_0x2C847:
	ld hl,$DC90
	add hl,de
	ld a,[hl]
	and a
	ret z
	ld hl,$DC60
	add hl,de
	ld a,[hl]
	ld hl,$DC50
	add hl,de
	sub [hl]
	ret nc
	xor $FF
	ld [$DC26],a
	ld hl,$DC90
	add hl,de
	sub [hl]
	jr nc,Logged_0x2C8BD
	ld hl,$DC64
	add hl,de
	ld a,[hl]
	sub $70
	call Logged_0x2C590
	push bc
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld c,a
	pop hl
	call Logged_0x2C8C9
	push hl
	ld hl,$DC90
	add hl,de
	ld a,[hl]
	ld c,a
	pop hl
	call Logged_0x2CBEA
	ld c,l
	ld a,[$DC26]
	ld h,a
	call Logged_0x2CBDC
	push hl
	ld hl,$DC28
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DC2C
	add hl,de
	ld a,[hl]
	ld l,a
	ld h,b
	pop bc
	ld a,[$DC27]
	and a
	jr z,Logged_0x2C8AD
	call Logged_0x2C8E2
	jr Logged_0x2C8AE

Logged_0x2C8AD:
	add hl,bc

Logged_0x2C8AE:
	ld b,h
	ld c,l

Logged_0x2C8B0:
	ld hl,$DC28
	add hl,de
	ld a,b
	ld [hl],a
	ld hl,$DC2C
	add hl,de
	ld a,c
	ld [hl],a
	ret

Logged_0x2C8BD:
	ld hl,$DC64
	add hl,de
	ld a,[hl]
	sub $70
	call Logged_0x2C590
	jr Logged_0x2C8B0

Logged_0x2C8C9:
	push hl
	call Logged_0x2C8E2
	jr nc,Logged_0x2C8DC
	pop hl
	ld a,c
	sub l
	ld l,a
	ld a,b
	sbc a,h
	ld h,a
	ld a,$01
	ld [$DC27],a
	ret

Logged_0x2C8DC:
	pop af
	xor a
	ld [$DC27],a
	ret

Logged_0x2C8E2:
	ld a,l
	sub c
	ld l,a
	ld a,h
	sbc a,b
	ld h,a
	ret

Logged_0x2C8E9:
	ld a,e
	and a
	jr z,Logged_0x2C8FA
	cp $01
	jp z,Logged_0x2C97F
	cp $02
	jp z,Logged_0x2C9BB
	jp Logged_0x2CA6A

Logged_0x2C8FA:
	ld a,[$DCD0]
	and a
	ret nz
	ld a,[$DC38]
	ld [$FF00+$13],a
	ld a,[$DC34]
	and $07
	push af
	ld a,[$DCA4]
	and a
	jr z,Logged_0x2C91D
	xor a
	ld [$DCA4],a
	ld a,[$DC30]
	swap a
	rlca
	rlca
	ld [$FF00+$11],a

Logged_0x2C91D:
	ld a,[$DCA8]
	and a
	jr z,Logged_0x2C931
	xor a
	ld [$DCA8],a
	ld a,[$DCA0]
	call Logged_0x2C936
	ld [$FF00+$12],a
	ld a,$80

Logged_0x2C931:
	pop bc
	or b
	ld [$FF00+$14],a
	ret

Logged_0x2C936:
	ld [$DC26],a
	ld a,[$DC0F]
	and a
	jr z,Logged_0x2C95B
	ld a,[$DC26]
	and $0F
	ld c,a
	ld hl,$495F
	add hl,bc
	ld a,[hl]
	push af
	ld a,[$DC26]
	swap a
	and $0F
	ld c,a
	ld hl,$496F
	add hl,bc
	ld a,[hl]
	pop bc
	or b
	ret

Logged_0x2C95B:
	ld a,[$DC26]
	ret

LoggedData_0x2C95F:
INCBIN "baserom.gb", $2C95F, $2C96A - $2C95F

UnknownData_0x2C96A:
INCBIN "baserom.gb", $2C96A, $2C96C - $2C96A

LoggedData_0x2C96C:
INCBIN "baserom.gb", $2C96C, $2C96D - $2C96C

UnknownData_0x2C96D:
INCBIN "baserom.gb", $2C96D, $2C96E - $2C96D

LoggedData_0x2C96E:
INCBIN "baserom.gb", $2C96E, $2C977 - $2C96E

UnknownData_0x2C977:
INCBIN "baserom.gb", $2C977, $2C978 - $2C977

LoggedData_0x2C978:
INCBIN "baserom.gb", $2C978, $2C979 - $2C978

UnknownData_0x2C979:
INCBIN "baserom.gb", $2C979, $2C97A - $2C979

LoggedData_0x2C97A:
INCBIN "baserom.gb", $2C97A, $2C97C - $2C97A

UnknownData_0x2C97C:
INCBIN "baserom.gb", $2C97C, $2C97E - $2C97C

LoggedData_0x2C97E:
INCBIN "baserom.gb", $2C97E, $2C97F - $2C97E

Logged_0x2C97F:
	ld a,[$DCD1]
	and a
	ret nz
	ld a,[$DC39]
	ld [$FF00+$18],a
	ld a,[$DC35]
	and $07
	push af
	ld a,[$DCA5]
	and a
	jr z,Logged_0x2C9A2
	xor a
	ld [$DCA5],a
	ld a,[$DC31]
	swap a
	rlca
	rlca
	ld [$FF00+$16],a

Logged_0x2C9A2:
	ld a,[$DCA9]
	and a
	jr z,Logged_0x2C9B6
	xor a
	ld [$DCA9],a
	ld a,[$DCA1]
	call Logged_0x2C936
	ld [$FF00+$17],a
	ld a,$80

Logged_0x2C9B6:
	pop bc
	or b
	ld [$FF00+$19],a
	ret

Logged_0x2C9BB:
	call Logged_0x2CA42
	ld a,[$DCD2]
	and a
	ret nz
	ld a,[$DC3A]
	ld [$FF00+$1D],a
	ld a,[$DC36]
	and $07
	push af
	ld a,[$DCA6]
	and a
	jr z,Logged_0x2C9DE
	xor a
	ld [$DCA6],a
	ld a,[$DCA2]
	call Logged_0x2CA0C

Logged_0x2C9DE:
	ld a,[$DCAA]
	and a
	jr z,Logged_0x2CA07
	xor a
	ld [$DCAA],a
	xor a
	call Logged_0x2CA0C
	ld [$FF00+$1A],a

Logged_0x2C9EE:
	ld a,[$FF00+$26]
	rrca
	rrca
	rrca
	jr c,Logged_0x2C9EE
	ld a,$80
	ld [$FF00+$1A],a
	ld a,[$DC13]
	call Logged_0x2CEF7
	ld a,[$DCA2]
	call Logged_0x2CA0C
	ld a,$80

Logged_0x2CA07:
	pop bc
	or b
	ld [$FF00+$1E],a
	ret

Logged_0x2CA0C:
	ld [$DC26],a
	ld a,[$DC0F]
	and a
	jr z,Logged_0x2CA27
	ld a,[$DC26]
	and a
	jr z,Logged_0x2CA3F
	cp $01
	jr z,Logged_0x2CA3F
	cp $02
	jr z,Logged_0x2CA39
	cp $03
	jr z,Logged_0x2CA3D

Logged_0x2CA27:
	ld a,[$DC26]
	and a
	jr z,Logged_0x2CA3F
	cp $01
	jr z,Logged_0x2CA39
	cp $02
	jr z,Logged_0x2CA3D
	ld a,$20
	jr Logged_0x2CA3F

Logged_0x2CA39:
	ld a,$60
	jr Logged_0x2CA3F

Logged_0x2CA3D:
	ld a,$40

Logged_0x2CA3F:
	ld [$FF00+$1C],a
	ret

Logged_0x2CA42:
	ld a,[$DCBE]
	and a
	ret nz
	ld a,[$DC86]
	and a
	ret z
	ld c,a
	ld hl,$DC50
	add hl,de
	ld a,[hl]
	ret z
	dec a
	ld h,$00
	ld l,a
	call Logged_0x2CBEA
	ld a,[$DC18]
	sub l
	jr nc,Logged_0x2CA61
	xor a

Logged_0x2CA61:
	ld [$DCA2],a
	ld a,$01
	ld [$DCA6],a
	ret

Logged_0x2CA6A:
	ld a,[$DCD3]
	and a
	ret nz
	ld a,[$DCA7]
	and a
	jr z,Logged_0x2CA7E
	xor a
	ld [$DCA7],a
	ld a,[$DC1A]
	ld [$FF00+$22],a

Logged_0x2CA7E:
	ld a,[$DCAB]
	and a
	ret z
	xor a
	ld [$DCAB],a
	ld a,[$DCA3]
	call Logged_0x2C936
	ld [$FF00+$21],a
	ld a,$80
	ld [$FF00+$23],a
	ret

Logged_0x2CA94:
	call Logged_0x2CA9F
	call Logged_0x2CAA7
	call Logged_0x2CAAF
	jr Logged_0x2CAB9

Logged_0x2CA9F:
	ld a,[$DCD0]
	and a
	ret nz
	ld [$FF00+$12],a
	ret

Logged_0x2CAA7:
	ld a,[$DCD1]
	and a
	ret nz
	ld [$FF00+$17],a
	ret

Logged_0x2CAAF:
	ld a,[$DCD2]
	and a
	ret nz
	ld [$FF00+$1C],a
	ld [$FF00+$1A],a
	ret

Logged_0x2CAB9:
	ld a,[$DCD3]
	and a
	ret nz
	ld [$FF00+$21],a
	ret

Logged_0x2CAC1:
	ld a,[$DC11]
	rlca
	ld c,a
	ld b,$00
	ld a,[$DC16]
	ld h,a
	ld a,[$DC17]
	ld l,a
	add hl,bc
	ld a,[hli]
	and a
	jr z,Logged_0x2CAF4
	ld b,a
	ld a,[hl]
	ld c,a
	ld a,e
	rlca
	ld l,a
	ld h,$00
	add hl,bc
	ld a,[hli]
	and a
	jr z,Logged_0x2CAED
	ld [$DC14],a
	ld a,[hl]
	ld [$DC15],a
	ld a,$01
	jr Logged_0x2CAEE

Logged_0x2CAED:
	xor a

Logged_0x2CAEE:
	ld hl,$DCAC
	add hl,de
	ld [hl],a
	ret

Logged_0x2CAF4:
	ld [$DC14],a
	ld a,[hl]
	ld [$DC15],a
	ret

Logged_0x2CAFC:
	ld a,[$DC14]
	and a
	ret nz
	ld a,[$DC15]
	and a
	jr nz,Logged_0x2CB16
	xor a
	ld [$DC10],a
	ld [$DC11],a
	ld hl,$DC9C
	add hl,de
	ld [hl],a
	pop af
	pop af
	ret

Logged_0x2CB16:
	ld a,[$DC15]
	ld b,a
	ld a,[$DC11]
	sub b
	ld [$DC11],a
	xor a
	ld hl,$DC9C
	add hl,de
	ld [hl],a
	jp Logged_0x2CAC1

Logged_0x2CB2A:
	call Logged_0x2CA94
	xor a
	ld [$DC11],a
	ld [$DC12],a
	ld a,$FF
	ld [$DC23],a
	ld a,$FF
	ld [$DC6C],a
	ld [$DC6D],a
	ld [$DC6E],a
	ld [$DC6F],a
	ld a,[$D23B]
	cp $01
	jr nz,Logged_0x2CB85
	ld a,[$DC10]
	cp $0D
	jr nz,Logged_0x2CB85
	ld d,$00
	ld e,$00

Unknown_0x2CB59:
	xor a
	ld hl,$DC70
	add hl,de
	ld [hl],a
	ld hl,$DC8C
	add hl,de
	ld [hl],a
	ld hl,$DC90
	add hl,de
	ld [hl],a
	ld hl,$DC94
	add hl,de
	ld [hl],a
	ld hl,$DC9C
	add hl,de
	ld [hl],a
	ld hl,$DCC0
	add hl,de
	ld [hl],a
	ld hl,$DCC4
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $04
	jp nz,Unknown_0x2CB59
	ret

Logged_0x2CB85:
	ld d,$00
	ld e,$00

Logged_0x2CB89:
	xor a
	ld hl,$DC70
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $5C
	jp nz,Logged_0x2CB89
	ld d,$00
	ld e,$00

Logged_0x2CB9A:
	xor a
	ld hl,$DCC4
	add hl,de
	ld [hl],a
	inc e
	ld a,e
	cp $04
	jp nz,Logged_0x2CB9A
	ret

Logged_0x2CBA8:
	ld a,[$DC18]
	ld [$DCA2],a
	xor a
	ld hl,$DCB8
	add hl,de
	ld [hl],a
	ld hl,$DCC8
	add hl,de
	ld [hl],a
	ld hl,$DCBC
	add hl,de
	ld [hl],a
	ld hl,$DC44
	add hl,de
	ld [hl],a
	ld hl,$DCB0
	add hl,de
	ld [hl],a
	inc a
	ld hl,$DC50
	add hl,de
	ld [hl],a
	ld hl,$DCC4
	add hl,de
	ld a,[hl]
	and a
	ret z
	cp $01
	ret z
	ld a,$01
	ld [hl],a
	ret

Logged_0x2CBDC:
	ld b,$00
	ld l,$00
	ld a,$08

Logged_0x2CBE2:
	add hl,hl
	jr nc,Logged_0x2CBE6
	add hl,bc

Logged_0x2CBE6:
	dec a
	jr nz,Logged_0x2CBE2
	ret

Logged_0x2CBEA:
	ld b,$10
	xor a
	rl l
	rl h

Logged_0x2CBF1:
	rla
	jr c,Logged_0x2CBF7
	cp c
	jr c,Logged_0x2CBFA

Logged_0x2CBF7:
	sub c
	scf
	ccf

Logged_0x2CBFA:
	ccf
	rl l
	rl h
	dec b
	jr nz,Logged_0x2CBF1
	ld h,a
	ret

Logged_0x2CC04:
	call Logged_0x2CC09
	jr Logged_0x2CC63

Logged_0x2CC09:
	ld d,$00
	ld e,$00

Logged_0x2CC0D:
	ld hl,$DCCC
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x2CC5C
	push af
	dec a
	rlca
	ld c,a
	ld b,$00
	ld hl,$5129
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ld a,[bc]
	ld c,a
	ld b,$00
	ld a,$01
	ld hl,$DCD8
	add hl,bc
	ld [hl],a
	pop af
	ld hl,$DCD0
	add hl,bc
	ld [hl],a
	ld hl,$DCF8
	add hl,bc
	ld a,[hl]
	and a
	jr nz,Logged_0x2CC41
	ld hl,$DCF4
	add hl,bc
	ld [hl],a

Logged_0x2CC41:
	xor a
	ld hl,$DCFC
	add hl,bc
	ld [hl],a
	ld hl,$DCF8
	add hl,bc
	ld [hl],a
	ld hl,$DCCC
	add hl,de
	ld [hl],a
	ld hl,$DCD4
	add hl,bc
	ld [hl],a
	ld hl,$DCF0
	add hl,bc
	ld [hl],a
	ret

Logged_0x2CC5C:
	inc e
	ld a,e
	cp $04
	jr nz,Logged_0x2CC0D
	ret

Logged_0x2CC63:
	ld d,$00
	ld e,$00

Logged_0x2CC67:
	ld hl,$DCD0
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x2CC78
	call Logged_0x2CC8F
	call Logged_0x2CDFC
	call Logged_0x2C705

Logged_0x2CC78:
	inc e
	ld a,e
	cp $04
	jr nz,Logged_0x2CC67
	ld a,[$DC23]
	ld [$FF00+$25],a
	call Logged_0x2CE2C
	call Logged_0x2CE5B
	call Logged_0x2CE8A
	jp Logged_0x2CED9

Logged_0x2CC8F:
	xor a
	ld hl,$DCA8
	add hl,de
	ld [hl],a
	ld hl,$DCD0
	add hl,de
	ld a,[hl]
	dec a
	rlca
	ld c,a
	ld b,$00
	ld hl,$5129
	add hl,bc
	ld a,[hli]
	ld [$DC20],a
	ld a,[hl]
	ld [$DC21],a

Logged_0x2CCAB:
	call Logged_0x2CCC8
	ld b,a
	sub $70
	jr c,Logged_0x2CCDB
	ld a,b
	sub $F0
	jr c,Logged_0x2CD07
	ld a,b
	sub $FF
	jr c,Logged_0x2CD27
	call Logged_0x2CCC2
	jr Logged_0x2CCAB

Logged_0x2CCC2:
	ld hl,$DCD8
	add hl,de
	inc [hl]
	ret

Logged_0x2CCC8:
	ld a,[$DC20]
	ld b,a
	ld a,[$DC21]
	ld c,a
	ld hl,$DCD8
	add hl,de
	ld a,[hl]
	ld l,a
	ld h,$00
	add hl,bc
	ld a,[hl]
	ret

Logged_0x2CCDB:
	ld hl,$DCD4
	add hl,de
	ld a,[hl]
	and a
	jr nz,Logged_0x2CD01
	ld a,b
	ld hl,$DCD4
	add hl,de
	ld [hl],a
	ld hl,$DCFC
	add hl,de
	ld a,[hl]
	and a
	jr nz,Logged_0x2CCF9
	ld a,$01

Logged_0x2CCF3:
	ld hl,$DCDC
	add hl,de
	ld [hl],a
	ret

Logged_0x2CCF9:
	xor a
	ld hl,$DCFC
	add hl,de
	ld [hl],a
	jr Logged_0x2CCF3

Logged_0x2CD01:
	dec a
	ld [hl],a
	and a
	ret nz
	jr Logged_0x2CCC2

Logged_0x2CD07:
	ld a,b
	sub $70
	rlca
	ld c,a
	ld b,$00
	ld hl,$4FD3
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld c,a
	ld a,b
	ld hl,$DCE0
	add hl,de
	ld [hl],a
	ld a,c
	ld hl,$DCE4
	add hl,de
	ld [hl],a
	call Logged_0x2CCC2
	jr Logged_0x2CCAB

Logged_0x2CD27:
	ld a,b
	sub $F0
	rlca
	ld c,a
	ld b,$00
	ld hl,$4D36
	add hl,bc
	ld a,[hli]
	ld l,[hl]
	ld h,a
	jp hl

LoggedData_0x2CD36:
INCBIN "baserom.gb", $2CD36, $2CD44 - $2CD36

UnknownData_0x2CD44:
INCBIN "baserom.gb", $2CD44, $2CD4A - $2CD44

LoggedData_0x2CD4A:
INCBIN "baserom.gb", $2CD4A, $2CD4C - $2CD4A
	call Logged_0x2CCC2
	ld hl,$DCFC
	add hl,de
	ld a,$01
	ld [hl],a
	call Logged_0x2CCC8
	jp Logged_0x2CCAB
	xor a
	ld hl,$DCD0
	add hl,de
	ld [hl],a
	ld hl,$DCD8
	add hl,de
	ld [hl],a
	ld hl,$DCD4
	add hl,de
	ld [hl],a
	ld hl,$DCFC
	add hl,de
	ld a,[hl]
	and a
	ret nz
	jp Logged_0x2C57C
	call Logged_0x2CCC2
	call Logged_0x2CCC8
	ld hl,$DCEC
	add hl,de
	ld [hl],a
	call Logged_0x2CCC2
	jp Logged_0x2CCAB
	call Logged_0x2CCC2
	call Logged_0x2CCC8
	ld hl,$DCE8
	add hl,de
	ld [hl],a
	call Logged_0x2CCC2
	jp Logged_0x2CCAB
	call Logged_0x2CCC2
	call Logged_0x2CCC8
	ld [$DC25],a
	call Logged_0x2CCC2
	jp Logged_0x2CCAB
	call Logged_0x2CCC2
	call Logged_0x2CCC8
	ld [$DC1B],a
	call Logged_0x2CCC2
	jp Logged_0x2CCAB
	call Logged_0x2CCC2
	call Logged_0x2CCC8
	ld [$DC19],a
	call Logged_0x2CCC2
	jp Logged_0x2CCAB
	call Logged_0x2CCC2
	call Logged_0x2CCC8
	ld hl,$DCF0
	add hl,de
	ld [hl],a
	call Logged_0x2CCC2
	jp Logged_0x2CCAB

UnknownData_0x2CDD6:
INCBIN "baserom.gb", $2CDD6, $2CDFC - $2CDD6

Logged_0x2CDFC:
	ld hl,$DCF0
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x2CE2B
	ld l,a
	sub $80
	jr nc,Logged_0x2CE0D
	ld h,$00
	jr Logged_0x2CE0F

Logged_0x2CE0D:
	ld h,$FF

Logged_0x2CE0F:
	push hl
	ld hl,$DCE0
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$DCE4
	add hl,de
	ld a,[hl]
	ld c,a
	pop hl
	add hl,bc
	ld b,l
	ld a,h
	ld hl,$DCE0
	add hl,de
	ld [hl],a
	ld a,b
	ld hl,$DCE4
	add hl,de
	ld [hl],a

Logged_0x2CE2B:
	ret

Logged_0x2CE2C:
	ld a,[$DCD0]
	and a
	ret z
	ld a,[$DCE4]
	ld [$FF00+$13],a
	ld a,[$DCE0]
	and $07
	push af
	ld a,[$DCDC]
	and a
	jr z,Logged_0x2CE56
	xor a
	ld [$DCDC],a
	ld a,[$DCEC]
	swap a
	rlca
	rlca
	ld [$FF00+$11],a
	ld a,[$DCE8]
	ld [$FF00+$12],a
	ld a,$80

Logged_0x2CE56:
	pop bc
	or b
	ld [$FF00+$14],a
	ret

Logged_0x2CE5B:
	ld a,[$DCD1]
	and a
	ret z
	ld a,[$DCE5]
	ld [$FF00+$18],a
	ld a,[$DCE1]
	and $07
	push af
	ld a,[$DCDD]
	and a
	jr z,Logged_0x2CE85
	xor a
	ld [$DCDD],a
	ld a,[$DCED]
	swap a
	rlca
	rlca
	ld [$FF00+$16],a
	ld a,[$DCE9]
	ld [$FF00+$17],a
	ld a,$80

Logged_0x2CE85:
	pop bc
	or b
	ld [$FF00+$19],a
	ret

Logged_0x2CE8A:
	ld a,[$DCD2]
	and a
	ret z
	ld a,[$DCE6]
	ld [$FF00+$1D],a
	ld a,[$DCE2]
	and $07
	push af
	ld a,[$DCDE]
	and a
	jr z,Logged_0x2CED4
	xor a
	ld [$DCDE],a
	ld a,[$DC19]
	and a
	jr z,Logged_0x2CEBC
	cp $01
	jr z,Logged_0x2CEB6
	cp $02
	jr z,Logged_0x2CEBA
	ld a,$20
	jr Logged_0x2CEBC

Logged_0x2CEB6:
	ld a,$60
	jr Logged_0x2CEBC

Logged_0x2CEBA:
	ld a,$40

Logged_0x2CEBC:
	ld [$FF00+$1C],a

Logged_0x2CEBE:
	xor a
	ld [$FF00+$1A],a
	ld a,[$FF00+$26]
	rrca
	rrca
	rrca
	jr c,Logged_0x2CEBE
	ld a,[$DC25]
	call Logged_0x2CEF7
	ld a,$80
	ld [$FF00+$1A],a
	ld a,$80

Logged_0x2CED4:
	pop bc
	or b
	ld [$FF00+$1E],a
	ret

Logged_0x2CED9:
	ld a,[$DCD3]
	and a
	ret z
	ld a,[$DCDF]
	and a
	jr z,Logged_0x2CEF4
	xor a
	ld [$DCDF],a
	ld a,[$DCEB]
	ld [$FF00+$21],a
	ld a,[$DC1B]
	ld [$FF00+$22],a
	ld a,$80

Logged_0x2CEF4:
	ld [$FF00+$23],a
	ret

Logged_0x2CEF7:
	rlca
	ld c,a
	ld b,$00
	ld hl,$5B15
	add hl,bc
	ld a,[hli]
	ld b,a
	ld a,[hl]
	ld l,a
	ld h,b
	ld bc,$FF30
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hl]
	ld [bc],a
	ret

LoggedData_0x2CF37:
INCBIN "baserom.gb", $2CF37, $2CF43 - $2CF37

UnknownData_0x2CF43:
INCBIN "baserom.gb", $2CF43, $2CF49 - $2CF43

LoggedData_0x2CF49:
INCBIN "baserom.gb", $2CF49, $2CF4B - $2CF49

UnknownData_0x2CF4B:
INCBIN "baserom.gb", $2CF4B, $2CF50 - $2CF4B

LoggedData_0x2CF50:
INCBIN "baserom.gb", $2CF50, $2CF58 - $2CF50

UnknownData_0x2CF58:
INCBIN "baserom.gb", $2CF58, $2CF5B - $2CF58

LoggedData_0x2CF5B:
INCBIN "baserom.gb", $2CF5B, $2CF60 - $2CF5B

UnknownData_0x2CF60:
INCBIN "baserom.gb", $2CF60, $2CF61 - $2CF60

LoggedData_0x2CF61:
INCBIN "baserom.gb", $2CF61, $2CF63 - $2CF61

UnknownData_0x2CF63:
INCBIN "baserom.gb", $2CF63, $2CF65 - $2CF63

LoggedData_0x2CF65:
INCBIN "baserom.gb", $2CF65, $2CF68 - $2CF65

UnknownData_0x2CF68:
INCBIN "baserom.gb", $2CF68, $2CF6A - $2CF68

LoggedData_0x2CF6A:
INCBIN "baserom.gb", $2CF6A, $2CF6C - $2CF6A

UnknownData_0x2CF6C:
INCBIN "baserom.gb", $2CF6C, $2CF70 - $2CF6C

LoggedData_0x2CF70:
INCBIN "baserom.gb", $2CF70, $2CF71 - $2CF70

UnknownData_0x2CF71:
INCBIN "baserom.gb", $2CF71, $2CF72 - $2CF71

LoggedData_0x2CF72:
INCBIN "baserom.gb", $2CF72, $2CF74 - $2CF72

UnknownData_0x2CF74:
INCBIN "baserom.gb", $2CF74, $2CF77 - $2CF74

LoggedData_0x2CF77:
INCBIN "baserom.gb", $2CF77, $2CF78 - $2CF77

UnknownData_0x2CF78:
INCBIN "baserom.gb", $2CF78, $2CF79 - $2CF78

LoggedData_0x2CF79:
INCBIN "baserom.gb", $2CF79, $2CF7B - $2CF79

UnknownData_0x2CF7B:
INCBIN "baserom.gb", $2CF7B, $2CF7C - $2CF7B

LoggedData_0x2CF7C:
INCBIN "baserom.gb", $2CF7C, $2CF7D - $2CF7C

UnknownData_0x2CF7D:
INCBIN "baserom.gb", $2CF7D, $2CF87 - $2CF7D

LoggedData_0x2CF87:
INCBIN "baserom.gb", $2CF87, $2CF8A - $2CF87

UnknownData_0x2CF8A:
INCBIN "baserom.gb", $2CF8A, $2CF8B - $2CF8A

LoggedData_0x2CF8B:
INCBIN "baserom.gb", $2CF8B, $2CF8C - $2CF8B

UnknownData_0x2CF8C:
INCBIN "baserom.gb", $2CF8C, $2CFB4 - $2CF8C

LoggedData_0x2CFB4:
INCBIN "baserom.gb", $2CFB4, $2CFB7 - $2CFB4

UnknownData_0x2CFB7:
INCBIN "baserom.gb", $2CFB7, $2CFB9 - $2CFB7

LoggedData_0x2CFB9:
INCBIN "baserom.gb", $2CFB9, $2CFBA - $2CFB9

UnknownData_0x2CFBA:
INCBIN "baserom.gb", $2CFBA, $2CFD3 - $2CFBA

LoggedData_0x2CFD3:
INCBIN "baserom.gb", $2CFD3, $2CFDB - $2CFD3

UnknownData_0x2CFDB:
INCBIN "baserom.gb", $2CFDB, $2CFDD - $2CFDB

LoggedData_0x2CFDD:
INCBIN "baserom.gb", $2CFDD, $2D065 - $2CFDD

UnknownData_0x2D065:
INCBIN "baserom.gb", $2D065, $2D0FB - $2D065

LoggedData_0x2D0FB:
INCBIN "baserom.gb", $2D0FB, $2D103 - $2D0FB

UnknownData_0x2D103:
INCBIN "baserom.gb", $2D103, $2D105 - $2D103

LoggedData_0x2D105:
INCBIN "baserom.gb", $2D105, $2D125 - $2D105

UnknownData_0x2D125:
INCBIN "baserom.gb", $2D125, $2D129 - $2D125

LoggedData_0x2D129:
INCBIN "baserom.gb", $2D129, $2D12B - $2D129

UnknownData_0x2D12B:
INCBIN "baserom.gb", $2D12B, $2D12D - $2D12B

LoggedData_0x2D12D:
INCBIN "baserom.gb", $2D12D, $2D13F - $2D12D

UnknownData_0x2D13F:
INCBIN "baserom.gb", $2D13F, $2D141 - $2D13F

LoggedData_0x2D141:
INCBIN "baserom.gb", $2D141, $2D147 - $2D141

UnknownData_0x2D147:
INCBIN "baserom.gb", $2D147, $2D149 - $2D147

LoggedData_0x2D149:
INCBIN "baserom.gb", $2D149, $2D15D - $2D149

UnknownData_0x2D15D:
INCBIN "baserom.gb", $2D15D, $2D15F - $2D15D

LoggedData_0x2D15F:
INCBIN "baserom.gb", $2D15F, $2D167 - $2D15F

UnknownData_0x2D167:
INCBIN "baserom.gb", $2D167, $2D169 - $2D167

LoggedData_0x2D169:
INCBIN "baserom.gb", $2D169, $2D16B - $2D169

UnknownData_0x2D16B:
INCBIN "baserom.gb", $2D16B, $2D16D - $2D16B

LoggedData_0x2D16D:
INCBIN "baserom.gb", $2D16D, $2D183 - $2D16D

UnknownData_0x2D183:
INCBIN "baserom.gb", $2D183, $2D185 - $2D183

LoggedData_0x2D185:
INCBIN "baserom.gb", $2D185, $2D193 - $2D185

UnknownData_0x2D193:
INCBIN "baserom.gb", $2D193, $2D195 - $2D193

LoggedData_0x2D195:
INCBIN "baserom.gb", $2D195, $2D19F - $2D195

UnknownData_0x2D19F:
INCBIN "baserom.gb", $2D19F, $2D1A1 - $2D19F

LoggedData_0x2D1A1:
INCBIN "baserom.gb", $2D1A1, $2D1A9 - $2D1A1

UnknownData_0x2D1A9:
INCBIN "baserom.gb", $2D1A9, $2D1AD - $2D1A9

LoggedData_0x2D1AD:
INCBIN "baserom.gb", $2D1AD, $2D1B3 - $2D1AD

UnknownData_0x2D1B3:
INCBIN "baserom.gb", $2D1B3, $2D1B9 - $2D1B3

LoggedData_0x2D1B9:
INCBIN "baserom.gb", $2D1B9, $2D1C3 - $2D1B9

UnknownData_0x2D1C3:
INCBIN "baserom.gb", $2D1C3, $2D1C5 - $2D1C3

LoggedData_0x2D1C5:
INCBIN "baserom.gb", $2D1C5, $2D1C7 - $2D1C5

UnknownData_0x2D1C7:
INCBIN "baserom.gb", $2D1C7, $2D1C9 - $2D1C7

LoggedData_0x2D1C9:
INCBIN "baserom.gb", $2D1C9, $2D1CF - $2D1C9

UnknownData_0x2D1CF:
INCBIN "baserom.gb", $2D1CF, $2D1D9 - $2D1CF

LoggedData_0x2D1D9:
INCBIN "baserom.gb", $2D1D9, $2D1E5 - $2D1D9

UnknownData_0x2D1E5:
INCBIN "baserom.gb", $2D1E5, $2D208 - $2D1E5

LoggedData_0x2D208:
INCBIN "baserom.gb", $2D208, $2D2AA - $2D208

UnknownData_0x2D2AA:
INCBIN "baserom.gb", $2D2AA, $2D2BB - $2D2AA

LoggedData_0x2D2BB:
INCBIN "baserom.gb", $2D2BB, $2D315 - $2D2BB

UnknownData_0x2D315:
INCBIN "baserom.gb", $2D315, $2D31F - $2D315

LoggedData_0x2D31F:
INCBIN "baserom.gb", $2D31F, $2D386 - $2D31F

UnknownData_0x2D386:
INCBIN "baserom.gb", $2D386, $2D393 - $2D386

LoggedData_0x2D393:
INCBIN "baserom.gb", $2D393, $2D3B7 - $2D393

UnknownData_0x2D3B7:
INCBIN "baserom.gb", $2D3B7, $2D3B8 - $2D3B7

LoggedData_0x2D3B8:
INCBIN "baserom.gb", $2D3B8, $2D3C7 - $2D3B8

UnknownData_0x2D3C7:
INCBIN "baserom.gb", $2D3C7, $2D3CE - $2D3C7

LoggedData_0x2D3CE:
INCBIN "baserom.gb", $2D3CE, $2D3EE - $2D3CE

UnknownData_0x2D3EE:
INCBIN "baserom.gb", $2D3EE, $2D3FD - $2D3EE

LoggedData_0x2D3FD:
INCBIN "baserom.gb", $2D3FD, $2D452 - $2D3FD

UnknownData_0x2D452:
INCBIN "baserom.gb", $2D452, $2D467 - $2D452

LoggedData_0x2D467:
INCBIN "baserom.gb", $2D467, $2D48B - $2D467

UnknownData_0x2D48B:
INCBIN "baserom.gb", $2D48B, $2D4AF - $2D48B

LoggedData_0x2D4AF:
INCBIN "baserom.gb", $2D4AF, $2D586 - $2D4AF

UnknownData_0x2D586:
INCBIN "baserom.gb", $2D586, $2D590 - $2D586

LoggedData_0x2D590:
INCBIN "baserom.gb", $2D590, $2D628 - $2D590

UnknownData_0x2D628:
INCBIN "baserom.gb", $2D628, $2D645 - $2D628

LoggedData_0x2D645:
INCBIN "baserom.gb", $2D645, $2D695 - $2D645

UnknownData_0x2D695:
INCBIN "baserom.gb", $2D695, $2D69F - $2D695

LoggedData_0x2D69F:
INCBIN "baserom.gb", $2D69F, $2D6FB - $2D69F

UnknownData_0x2D6FB:
INCBIN "baserom.gb", $2D6FB, $2D71B - $2D6FB

LoggedData_0x2D71B:
INCBIN "baserom.gb", $2D71B, $2D72C - $2D71B

UnknownData_0x2D72C:
INCBIN "baserom.gb", $2D72C, $2D734 - $2D72C

LoggedData_0x2D734:
INCBIN "baserom.gb", $2D734, $2D76A - $2D734

UnknownData_0x2D76A:
INCBIN "baserom.gb", $2D76A, $2D799 - $2D76A

LoggedData_0x2D799:
INCBIN "baserom.gb", $2D799, $2D7E5 - $2D799

UnknownData_0x2D7E5:
INCBIN "baserom.gb", $2D7E5, $2D7F5 - $2D7E5

LoggedData_0x2D7F5:
INCBIN "baserom.gb", $2D7F5, $2D814 - $2D7F5

UnknownData_0x2D814:
INCBIN "baserom.gb", $2D814, $2D823 - $2D814

LoggedData_0x2D823:
INCBIN "baserom.gb", $2D823, $2D86E - $2D823

UnknownData_0x2D86E:
INCBIN "baserom.gb", $2D86E, $2D873 - $2D86E

LoggedData_0x2D873:
INCBIN "baserom.gb", $2D873, $2D889 - $2D873

UnknownData_0x2D889:
INCBIN "baserom.gb", $2D889, $2D88D - $2D889

LoggedData_0x2D88D:
INCBIN "baserom.gb", $2D88D, $2D893 - $2D88D

UnknownData_0x2D893:
INCBIN "baserom.gb", $2D893, $2D895 - $2D893

LoggedData_0x2D895:
INCBIN "baserom.gb", $2D895, $2D897 - $2D895

UnknownData_0x2D897:
INCBIN "baserom.gb", $2D897, $2D899 - $2D897

LoggedData_0x2D899:
INCBIN "baserom.gb", $2D899, $2D89D - $2D899

UnknownData_0x2D89D:
INCBIN "baserom.gb", $2D89D, $2D8A1 - $2D89D

LoggedData_0x2D8A1:
INCBIN "baserom.gb", $2D8A1, $2D8A7 - $2D8A1

UnknownData_0x2D8A7:
INCBIN "baserom.gb", $2D8A7, $2D8B5 - $2D8A7

LoggedData_0x2D8B5:
INCBIN "baserom.gb", $2D8B5, $2D8B7 - $2D8B5

UnknownData_0x2D8B7:
INCBIN "baserom.gb", $2D8B7, $2D8B9 - $2D8B7

LoggedData_0x2D8B9:
INCBIN "baserom.gb", $2D8B9, $2D8BB - $2D8B9

UnknownData_0x2D8BB:
INCBIN "baserom.gb", $2D8BB, $2D8BD - $2D8BB

LoggedData_0x2D8BD:
INCBIN "baserom.gb", $2D8BD, $2D8BF - $2D8BD

UnknownData_0x2D8BF:
INCBIN "baserom.gb", $2D8BF, $2D8C5 - $2D8BF

LoggedData_0x2D8C5:
INCBIN "baserom.gb", $2D8C5, $2D8CB - $2D8C5

UnknownData_0x2D8CB:
INCBIN "baserom.gb", $2D8CB, $2D8CF - $2D8CB

LoggedData_0x2D8CF:
INCBIN "baserom.gb", $2D8CF, $2D8D5 - $2D8CF

UnknownData_0x2D8D5:
INCBIN "baserom.gb", $2D8D5, $2D8D7 - $2D8D5

LoggedData_0x2D8D7:
INCBIN "baserom.gb", $2D8D7, $2D8E1 - $2D8D7

UnknownData_0x2D8E1:
INCBIN "baserom.gb", $2D8E1, $2D8E3 - $2D8E1

LoggedData_0x2D8E3:
INCBIN "baserom.gb", $2D8E3, $2D8E5 - $2D8E3

UnknownData_0x2D8E5:
INCBIN "baserom.gb", $2D8E5, $2D8E7 - $2D8E5

LoggedData_0x2D8E7:
INCBIN "baserom.gb", $2D8E7, $2D8E9 - $2D8E7

UnknownData_0x2D8E9:
INCBIN "baserom.gb", $2D8E9, $2D8F5 - $2D8E9

LoggedData_0x2D8F5:
INCBIN "baserom.gb", $2D8F5, $2D8F7 - $2D8F5

UnknownData_0x2D8F7:
INCBIN "baserom.gb", $2D8F7, $2D8FB - $2D8F7

LoggedData_0x2D8FB:
INCBIN "baserom.gb", $2D8FB, $2D8FD - $2D8FB

UnknownData_0x2D8FD:
INCBIN "baserom.gb", $2D8FD, $2D8FF - $2D8FD

LoggedData_0x2D8FF:
INCBIN "baserom.gb", $2D8FF, $2D901 - $2D8FF

UnknownData_0x2D901:
INCBIN "baserom.gb", $2D901, $2D903 - $2D901

LoggedData_0x2D903:
INCBIN "baserom.gb", $2D903, $2D905 - $2D903

UnknownData_0x2D905:
INCBIN "baserom.gb", $2D905, $2D909 - $2D905

LoggedData_0x2D909:
INCBIN "baserom.gb", $2D909, $2D933 - $2D909

UnknownData_0x2D933:
INCBIN "baserom.gb", $2D933, $2D93B - $2D933

LoggedData_0x2D93B:
INCBIN "baserom.gb", $2D93B, $2D941 - $2D93B

UnknownData_0x2D941:
INCBIN "baserom.gb", $2D941, $2D945 - $2D941

LoggedData_0x2D945:
INCBIN "baserom.gb", $2D945, $2D94B - $2D945

UnknownData_0x2D94B:
INCBIN "baserom.gb", $2D94B, $2D94F - $2D94B

LoggedData_0x2D94F:
INCBIN "baserom.gb", $2D94F, $2D957 - $2D94F

UnknownData_0x2D957:
INCBIN "baserom.gb", $2D957, $2D95F - $2D957

LoggedData_0x2D95F:
INCBIN "baserom.gb", $2D95F, $2D963 - $2D95F

UnknownData_0x2D963:
INCBIN "baserom.gb", $2D963, $2D965 - $2D963

LoggedData_0x2D965:
INCBIN "baserom.gb", $2D965, $2D969 - $2D965

UnknownData_0x2D969:
INCBIN "baserom.gb", $2D969, $2D98F - $2D969

LoggedData_0x2D98F:
INCBIN "baserom.gb", $2D98F, $2D993 - $2D98F

UnknownData_0x2D993:
INCBIN "baserom.gb", $2D993, $2D999 - $2D993

LoggedData_0x2D999:
INCBIN "baserom.gb", $2D999, $2D9A1 - $2D999

UnknownData_0x2D9A1:
INCBIN "baserom.gb", $2D9A1, $2D9A7 - $2D9A1

LoggedData_0x2D9A7:
INCBIN "baserom.gb", $2D9A7, $2D9AD - $2D9A7

UnknownData_0x2D9AD:
INCBIN "baserom.gb", $2D9AD, $2D9BF - $2D9AD

LoggedData_0x2D9BF:
INCBIN "baserom.gb", $2D9BF, $2D9DD - $2D9BF

UnknownData_0x2D9DD:
INCBIN "baserom.gb", $2D9DD, $2D9E9 - $2D9DD

LoggedData_0x2D9E9:
INCBIN "baserom.gb", $2D9E9, $2D9F9 - $2D9E9

UnknownData_0x2D9F9:
INCBIN "baserom.gb", $2D9F9, $2D9FD - $2D9F9

LoggedData_0x2D9FD:
INCBIN "baserom.gb", $2D9FD, $2DA01 - $2D9FD

UnknownData_0x2DA01:
INCBIN "baserom.gb", $2DA01, $2DA07 - $2DA01

LoggedData_0x2DA07:
INCBIN "baserom.gb", $2DA07, $2DA13 - $2DA07

UnknownData_0x2DA13:
INCBIN "baserom.gb", $2DA13, $2DA15 - $2DA13

LoggedData_0x2DA15:
INCBIN "baserom.gb", $2DA15, $2DA19 - $2DA15

UnknownData_0x2DA19:
INCBIN "baserom.gb", $2DA19, $2DA27 - $2DA19

LoggedData_0x2DA27:
INCBIN "baserom.gb", $2DA27, $2DA2D - $2DA27

UnknownData_0x2DA2D:
INCBIN "baserom.gb", $2DA2D, $2DA53 - $2DA2D

LoggedData_0x2DA53:
INCBIN "baserom.gb", $2DA53, $2DA55 - $2DA53

UnknownData_0x2DA55:
INCBIN "baserom.gb", $2DA55, $2DA65 - $2DA55

LoggedData_0x2DA65:
INCBIN "baserom.gb", $2DA65, $2DA6F - $2DA65

UnknownData_0x2DA6F:
INCBIN "baserom.gb", $2DA6F, $2DA77 - $2DA6F

LoggedData_0x2DA77:
INCBIN "baserom.gb", $2DA77, $2DA7B - $2DA77

UnknownData_0x2DA7B:
INCBIN "baserom.gb", $2DA7B, $2DA86 - $2DA7B

LoggedData_0x2DA86:
INCBIN "baserom.gb", $2DA86, $2DA89 - $2DA86

UnknownData_0x2DA89:
INCBIN "baserom.gb", $2DA89, $2DA95 - $2DA89

LoggedData_0x2DA95:
INCBIN "baserom.gb", $2DA95, $2DAB3 - $2DA95

UnknownData_0x2DAB3:
INCBIN "baserom.gb", $2DAB3, $2DAB7 - $2DAB3

LoggedData_0x2DAB7:
INCBIN "baserom.gb", $2DAB7, $2DAB9 - $2DAB7

UnknownData_0x2DAB9:
INCBIN "baserom.gb", $2DAB9, $2DABB - $2DAB9

LoggedData_0x2DABB:
INCBIN "baserom.gb", $2DABB, $2DADB - $2DABB

UnknownData_0x2DADB:
INCBIN "baserom.gb", $2DADB, $2DADC - $2DADB

LoggedData_0x2DADC:
INCBIN "baserom.gb", $2DADC, $2DAF7 - $2DADC

UnknownData_0x2DAF7:
INCBIN "baserom.gb", $2DAF7, $2DAF8 - $2DAF7

LoggedData_0x2DAF8:
INCBIN "baserom.gb", $2DAF8, $2DB01 - $2DAF8

UnknownData_0x2DB01:
INCBIN "baserom.gb", $2DB01, $2DB02 - $2DB01

LoggedData_0x2DB02:
INCBIN "baserom.gb", $2DB02, $2DB03 - $2DB02

UnknownData_0x2DB03:
INCBIN "baserom.gb", $2DB03, $2DB0E - $2DB03

LoggedData_0x2DB0E:
INCBIN "baserom.gb", $2DB0E, $2DB0F - $2DB0E

UnknownData_0x2DB0F:
INCBIN "baserom.gb", $2DB0F, $2DB15 - $2DB0F

LoggedData_0x2DB15:
INCBIN "baserom.gb", $2DB15, $2DBB7 - $2DB15

UnknownData_0x2DBB7:
INCBIN "baserom.gb", $2DBB7, $2DBB8 - $2DBB7

LoggedData_0x2DBB8:
INCBIN "baserom.gb", $2DBB8, $2DBBD - $2DBB8

UnknownData_0x2DBBD:
INCBIN "baserom.gb", $2DBBD, $2DBC0 - $2DBBD

LoggedData_0x2DBC0:
INCBIN "baserom.gb", $2DBC0, $2DBC1 - $2DBC0

UnknownData_0x2DBC1:
INCBIN "baserom.gb", $2DBC1, $2DBC2 - $2DBC1

LoggedData_0x2DBC2:
INCBIN "baserom.gb", $2DBC2, $2DBC3 - $2DBC2

UnknownData_0x2DBC3:
INCBIN "baserom.gb", $2DBC3, $2DBC4 - $2DBC3

LoggedData_0x2DBC4:
INCBIN "baserom.gb", $2DBC4, $2E113 - $2DBC4

UnknownData_0x2E113:
INCBIN "baserom.gb", $2E113, $2E115 - $2E113

LoggedData_0x2E115:
INCBIN "baserom.gb", $2E115, $2E11C - $2E115

UnknownData_0x2E11C:
INCBIN "baserom.gb", $2E11C, $2E11D - $2E11C

LoggedData_0x2E11D:
INCBIN "baserom.gb", $2E11D, $2E140 - $2E11D

UnknownData_0x2E140:
INCBIN "baserom.gb", $2E140, $2E142 - $2E140

LoggedData_0x2E142:
INCBIN "baserom.gb", $2E142, $2E16A - $2E142

UnknownData_0x2E16A:
INCBIN "baserom.gb", $2E16A, $2E16C - $2E16A

LoggedData_0x2E16C:
INCBIN "baserom.gb", $2E16C, $2E19C - $2E16C

UnknownData_0x2E19C:
INCBIN "baserom.gb", $2E19C, $2E19E - $2E19C

LoggedData_0x2E19E:
INCBIN "baserom.gb", $2E19E, $2E426 - $2E19E

UnknownData_0x2E426:
INCBIN "baserom.gb", $2E426, $2E427 - $2E426

LoggedData_0x2E427:
INCBIN "baserom.gb", $2E427, $2E8C5 - $2E427

UnknownData_0x2E8C5:
INCBIN "baserom.gb", $2E8C5, $2E8C6 - $2E8C5

LoggedData_0x2E8C6:
INCBIN "baserom.gb", $2E8C6, $2E8C7 - $2E8C6

UnknownData_0x2E8C7:
INCBIN "baserom.gb", $2E8C7, $2E8C8 - $2E8C7

LoggedData_0x2E8C8:
INCBIN "baserom.gb", $2E8C8, $2E8C9 - $2E8C8

UnknownData_0x2E8C9:
INCBIN "baserom.gb", $2E8C9, $2E8CA - $2E8C9

LoggedData_0x2E8CA:
INCBIN "baserom.gb", $2E8CA, $2EAB6 - $2E8CA

UnknownData_0x2EAB6:
INCBIN "baserom.gb", $2EAB6, $2EAB9 - $2EAB6

LoggedData_0x2EAB9:
INCBIN "baserom.gb", $2EAB9, $2ED55 - $2EAB9

UnknownData_0x2ED55:
INCBIN "baserom.gb", $2ED55, $2ED57 - $2ED55

LoggedData_0x2ED57:
INCBIN "baserom.gb", $2ED57, $2ED5B - $2ED57

UnknownData_0x2ED5B:
INCBIN "baserom.gb", $2ED5B, $2ED5D - $2ED5B

LoggedData_0x2ED5D:
INCBIN "baserom.gb", $2ED5D, $2ED62 - $2ED5D

UnknownData_0x2ED62:
INCBIN "baserom.gb", $2ED62, $2ED63 - $2ED62

LoggedData_0x2ED63:
INCBIN "baserom.gb", $2ED63, $2ED64 - $2ED63

UnknownData_0x2ED64:
INCBIN "baserom.gb", $2ED64, $2ED65 - $2ED64

LoggedData_0x2ED65:
INCBIN "baserom.gb", $2ED65, $2ED67 - $2ED65

UnknownData_0x2ED67:
INCBIN "baserom.gb", $2ED67, $2ED6D - $2ED67

LoggedData_0x2ED6D:
INCBIN "baserom.gb", $2ED6D, $2ED6F - $2ED6D

UnknownData_0x2ED6F:
INCBIN "baserom.gb", $2ED6F, $2ED75 - $2ED6F

LoggedData_0x2ED75:
INCBIN "baserom.gb", $2ED75, $2ED7A - $2ED75

UnknownData_0x2ED7A:
INCBIN "baserom.gb", $2ED7A, $2ED7B - $2ED7A

LoggedData_0x2ED7B:
INCBIN "baserom.gb", $2ED7B, $2ED80 - $2ED7B

UnknownData_0x2ED80:
INCBIN "baserom.gb", $2ED80, $2ED81 - $2ED80

LoggedData_0x2ED81:
INCBIN "baserom.gb", $2ED81, $2EDAA - $2ED81

UnknownData_0x2EDAA:
INCBIN "baserom.gb", $2EDAA, $2EDAB - $2EDAA

LoggedData_0x2EDAB:
INCBIN "baserom.gb", $2EDAB, $2EDD8 - $2EDAB

UnknownData_0x2EDD8:
INCBIN "baserom.gb", $2EDD8, $2EDDA - $2EDD8

LoggedData_0x2EDDA:
INCBIN "baserom.gb", $2EDDA, $2EE0E - $2EDDA

UnknownData_0x2EE0E:
INCBIN "baserom.gb", $2EE0E, $2EE0F - $2EE0E

LoggedData_0x2EE0F:
INCBIN "baserom.gb", $2EE0F, $2EE4E - $2EE0F

UnknownData_0x2EE4E:
INCBIN "baserom.gb", $2EE4E, $2EE50 - $2EE4E

LoggedData_0x2EE50:
INCBIN "baserom.gb", $2EE50, $2EE8B - $2EE50

UnknownData_0x2EE8B:
INCBIN "baserom.gb", $2EE8B, $2EE8D - $2EE8B

LoggedData_0x2EE8D:
INCBIN "baserom.gb", $2EE8D, $2EEE9 - $2EE8D

UnknownData_0x2EEE9:
INCBIN "baserom.gb", $2EEE9, $2EEF0 - $2EEE9

LoggedData_0x2EEF0:
INCBIN "baserom.gb", $2EEF0, $2EFBE - $2EEF0

UnknownData_0x2EFBE:
INCBIN "baserom.gb", $2EFBE, $2EFC4 - $2EFBE

LoggedData_0x2EFC4:
INCBIN "baserom.gb", $2EFC4, $2EFFE - $2EFC4

UnknownData_0x2EFFE:
INCBIN "baserom.gb", $2EFFE, $2EFFF - $2EFFE

LoggedData_0x2EFFF:
INCBIN "baserom.gb", $2EFFF, $2F057 - $2EFFF

UnknownData_0x2F057:
INCBIN "baserom.gb", $2F057, $2F058 - $2F057

LoggedData_0x2F058:
INCBIN "baserom.gb", $2F058, $2F0BC - $2F058

UnknownData_0x2F0BC:
INCBIN "baserom.gb", $2F0BC, $2F657 - $2F0BC

LoggedData_0x2F657:
INCBIN "baserom.gb", $2F657, $2F6DE - $2F657

UnknownData_0x2F6DE:
INCBIN "baserom.gb", $2F6DE, $2F6E3 - $2F6DE

LoggedData_0x2F6E3:
INCBIN "baserom.gb", $2F6E3, $2F78E - $2F6E3

UnknownData_0x2F78E:
INCBIN "baserom.gb", $2F78E, $2F793 - $2F78E

LoggedData_0x2F793:
INCBIN "baserom.gb", $2F793, $2F7F7 - $2F793

UnknownData_0x2F7F7:
INCBIN "baserom.gb", $2F7F7, $2F7FD - $2F7F7

LoggedData_0x2F7FD:
INCBIN "baserom.gb", $2F7FD, $2F82F - $2F7FD

UnknownData_0x2F82F:
INCBIN "baserom.gb", $2F82F, $2F835 - $2F82F

LoggedData_0x2F835:
INCBIN "baserom.gb", $2F835, $2F9E0 - $2F835

UnknownData_0x2F9E0:
INCBIN "baserom.gb", $2F9E0, $2F9E4 - $2F9E0

LoggedData_0x2F9E4:
INCBIN "baserom.gb", $2F9E4, $2F9EB - $2F9E4

UnknownData_0x2F9EB:
INCBIN "baserom.gb", $2F9EB, $2F9F4 - $2F9EB

LoggedData_0x2F9F4:
INCBIN "baserom.gb", $2F9F4, $2FA0E - $2F9F4

UnknownData_0x2FA0E:
INCBIN "baserom.gb", $2FA0E, $2FA10 - $2FA0E

LoggedData_0x2FA10:
INCBIN "baserom.gb", $2FA10, $2FA28 - $2FA10

UnknownData_0x2FA28:
INCBIN "baserom.gb", $2FA28, $2FA29 - $2FA28

LoggedData_0x2FA29:
INCBIN "baserom.gb", $2FA29, $2FA44 - $2FA29

UnknownData_0x2FA44:
INCBIN "baserom.gb", $2FA44, $2FA45 - $2FA44

LoggedData_0x2FA45:
INCBIN "baserom.gb", $2FA45, $2FB01 - $2FA45

UnknownData_0x2FB01:
INCBIN "baserom.gb", $2FB01, $2FB02 - $2FB01

LoggedData_0x2FB02:
INCBIN "baserom.gb", $2FB02, $2FC51 - $2FB02

UnknownData_0x2FC51:
INCBIN "baserom.gb", $2FC51, $2FC52 - $2FC51

LoggedData_0x2FC52:
INCBIN "baserom.gb", $2FC52, $2FD1C - $2FC52

UnknownData_0x2FD1C:
INCBIN "baserom.gb", $2FD1C, $2FD1D - $2FD1C

LoggedData_0x2FD1D:
INCBIN "baserom.gb", $2FD1D, $2FD38 - $2FD1D

UnknownData_0x2FD38:
INCBIN "baserom.gb", $2FD38, $2FD39 - $2FD38

LoggedData_0x2FD39:
INCBIN "baserom.gb", $2FD39, $2FD4F - $2FD39

UnknownData_0x2FD4F:
INCBIN "baserom.gb", $2FD4F, $2FD50 - $2FD4F

LoggedData_0x2FD50:
INCBIN "baserom.gb", $2FD50, $2FDEA - $2FD50

UnknownData_0x2FDEA:
INCBIN "baserom.gb", $2FDEA, $2FDEC - $2FDEA

LoggedData_0x2FDEC:
INCBIN "baserom.gb", $2FDEC, $2FF93 - $2FDEC

UnknownData_0x2FF93:
INCBIN "baserom.gb", $2FF93, $2FF94 - $2FF93

LoggedData_0x2FF94:
INCBIN "baserom.gb", $2FF94, $2FFDF - $2FF94

UnknownData_0x2FFDF:
INCBIN "baserom.gb", $2FFDF, $30000 - $2FFDF

SECTION "Bank0C", ROMX, BANK[$0C]
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	rst JumpList
	dw Logged_0x30024
	dw Logged_0x30027
	dw Logged_0x301FE
	dw Logged_0x303EA
	dw Logged_0x3053C
	dw Logged_0x3064F
	dw Logged_0x30666
	dw Logged_0x3072C
	dw Logged_0x30736
	dw Logged_0x30739
	dw Logged_0x3074B
	dw Logged_0x30874
	dw Logged_0x308C5
	dw Unknown_0x3093A
	dw Logged_0x30947

Logged_0x30024:
	ld a,[de]
	inc a
	ld [de],a

Logged_0x30027:
	push de
	ld a,$0F
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	jr z,Logged_0x30099
	res 5,[hl]
	ld a,$F4
	add a,l
	ld l,a
	ld b,[hl]
	ld a,$F0
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,b
	rst JumpList
	dw Logged_0x30079
	dw Unknown_0x3005C
	dw Unknown_0x30069
	dw Unknown_0x3004C

Unknown_0x3004C:
	ld a,e
	add a,$08
	ld b,a
	and $0F
	jr z,Logged_0x30082
	ld a,b
	and $F0
	add a,$08
	ld e,a
	jr Logged_0x30082

Unknown_0x3005C:
	ld a,d
	and $0F
	jr z,Logged_0x30082
	ld a,d
	and $F0
	add a,$10
	ld d,a
	jr Logged_0x30082

Unknown_0x30069:
	ld a,e
	add a,$08
	ld b,a
	and $0F
	jr z,Logged_0x30082
	ld a,b
	and $F0
	sub $08
	ld e,a
	jr Logged_0x30082

Logged_0x30079:
	ld a,d
	and $0F
	jr z,Logged_0x30082
	ld a,d
	and $F0
	ld d,a

Logged_0x30082:
	ld bc,$0180
	call Logged_0x2F6C
	jr z,Logged_0x30099
	pop hl
	ld a,[$C23D]
	ld c,a
	ld b,$00
	ld hl,$41FA
	add hl,bc
	ld b,[hl]
	jp Logged_0x3017A

Logged_0x30099:
	pop de
	ld a,$08
	add a,e
	ld l,a
	ld h,d
	bit 7,[hl]
	jr z,Logged_0x30107
	push hl
	inc hl
	ld a,[hl]
	cp $FF
	jr z,Logged_0x300C7
	push af
	ld a,[$C223]
	ld d,a
	ld a,[$C227]
	ld e,a
	ld a,[$C23D]
	call Logged_0x301A
	pop af
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$C9E8
	add hl,bc
	ld a,d
	ld [hli],a
	ld [hl],e

Logged_0x300C7:
	pop hl
	push hl
	ld a,$EB
	add a,l
	ld l,a
	push hl
	ld a,[$C223]
	ld d,a
	ld a,[$C227]
	ld e,a
	ld a,[$D17B]
	call Logged_0x301A
	pop hl
	xor a
	ld [$D258],a
	call Logged_0x30DA1
	pop hl
	jr nc,Logged_0x300EC
	xor a
	ld [$D179],a
	ret

Logged_0x300EC:
	ld a,$E8
	add a,l
	ld l,a
	ld a,$9F
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	ld a,$0E
	ld [hli],a
	ld a,$01
	ld [hl],a
	ld a,$F1
	add a,l
	ld l,a
	xor a
	ld [hld],a
	dec hl
	jp Logged_0x32EE4

Logged_0x30107:
	push de
	call Logged_0x30B37
	pop hl
	ld a,[$D141]
	bit 6,a
	ret nz
	ld de,$C233
	ld a,[$D141]
	rla
	jr c,Logged_0x3011E
	ld de,$C433

Logged_0x3011E:
	ld a,[de]
	cp $09
	ret z
	cp $10
	ret z
	cp $16
	ret z
	ld a,$F3
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$0E
	add a,l
	ld l,a
	ld a,[hl]
	call Logged_0x31162
	ret nc
	push hl
	ld a,[hl]
	sub $80
	add a,a
	ld c,a
	ld b,$00
	ld hl,$41A4
	add hl,bc
	ld b,$01
	ld a,d
	cp [hl]
	jr c,Logged_0x3014E
	inc b

Logged_0x3014E:
	set 2,b
	inc hl
	ld a,e
	cp [hl]
	jr c,Logged_0x30159
	ld a,b
	add a,$04
	ld b,a

Logged_0x30159:
	pop hl
	push hl
	ld a,$1E
	add a,l
	ld l,a
	ld a,b
	ld [hli],a
	set 7,[hl]
	pop hl
	ld a,[hl]
	cp $A7
	jr nz,Logged_0x3017A
	ld a,$10
	add a,l
	ld l,a
	ld a,[hl]
	cp $11
	jr nz,Logged_0x3017A
	ld hl,$D16A
	ld a,[$D16B]
	and [hl]
	ret nz

Logged_0x3017A:
	ld hl,$C233
	ld a,[$D141]
	rla
	jr c,Logged_0x30186
	ld hl,$C433

Logged_0x30186:
	ld a,[hl]
	cp $04
	ret z
	cp $0F
	jr nz,Logged_0x30194
	ld a,[$D141]
	bit 2,a
	ret nz

Logged_0x30194:
	ld a,$16
	ld [hl],a
	ld a,$08
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld a,b
	xor $0F
	ld [$D22B],a
	ret

LoggedData_0x301A4:
INCBIN "baserom.gb", $301A4, $301A6 - $301A4

UnknownData_0x301A6:
INCBIN "baserom.gb", $301A6, $301C4 - $301A6

LoggedData_0x301C4:
INCBIN "baserom.gb", $301C4, $301CE - $301C4

UnknownData_0x301CE:
INCBIN "baserom.gb", $301CE, $301D0 - $301CE

LoggedData_0x301D0:
INCBIN "baserom.gb", $301D0, $301D2 - $301D0

UnknownData_0x301D2:
INCBIN "baserom.gb", $301D2, $301E4 - $301D2

LoggedData_0x301E4:
INCBIN "baserom.gb", $301E4, $301E6 - $301E4

UnknownData_0x301E6:
INCBIN "baserom.gb", $301E6, $301EA - $301E6

LoggedData_0x301EA:
INCBIN "baserom.gb", $301EA, $301EC - $301EA

UnknownData_0x301EC:
INCBIN "baserom.gb", $301EC, $301F2 - $301EC

LoggedData_0x301F2:
INCBIN "baserom.gb", $301F2, $301F4 - $301F2

UnknownData_0x301F4:
INCBIN "baserom.gb", $301F4, $301F6 - $301F4

LoggedData_0x301F6:
INCBIN "baserom.gb", $301F6, $301FA - $301F6

UnknownData_0x301FA:
INCBIN "baserom.gb", $301FA, $301FE - $301FA

Logged_0x301FE:
	push de
	ld a,$0F
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	jr z,Logged_0x30265
	res 5,[hl]
	ld a,$F4
	add a,l
	ld l,a
	ld b,[hl]
	ld a,$F0
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,b
	rst JumpList
	dw Logged_0x30250
	dw Logged_0x30233
	dw Logged_0x30240
	dw Logged_0x30223

Logged_0x30223:
	ld a,e
	add a,$08
	ld b,a
	and $0F
	jr z,Logged_0x30259
	ld a,b
	and $F0
	add a,$08
	ld e,a
	jr Logged_0x30259

Logged_0x30233:
	ld a,d
	and $0F
	jr z,Logged_0x30259
	ld a,d
	and $F0
	add a,$10
	ld d,a
	jr Logged_0x30259

Logged_0x30240:
	ld a,e
	add a,$08
	ld b,a
	and $0F
	jr z,Logged_0x30259
	ld a,b
	and $F0
	sub $08
	ld e,a
	jr Logged_0x30259

Logged_0x30250:
	ld a,d
	and $0F
	jr z,Logged_0x30259
	ld a,d
	and $F0
	ld d,a

Logged_0x30259:
	ld bc,$0180
	call Logged_0x2F6C
	jr z,Logged_0x30265
	pop hl
	jp Logged_0x30350

Logged_0x30265:
	pop de
	push de
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$0E
	add a,l
	ld l,a
	ld a,[hl]
	call Logged_0x31162
	ld [$D252],a
	pop de
	jr c,Logged_0x3029D
	push de
	call Logged_0x31309
	pop de
	cp $02
	jp c,Logged_0x303A1
	ld a,[$D141]
	rra
	jp c,Logged_0x303A1
	push de
	ld a,$0C
	add a,l
	ld l,a
	call Logged_0x3135C
	pop de
	jp Logged_0x303A1

Logged_0x3029D:
	bit 4,a
	jr z,Logged_0x302C8
	ld a,[$CEBA]
	swap a
	ld l,a
	ld h,$00
	add hl,hl
	ld bc,$C213
	add hl,bc
	ld a,[hl]
	cp $0A
	jr z,Logged_0x302FB
	ld a,[$DC05]
	set 3,a
	ld [$DC05],a
	ld a,$0A
	ld [hli],a
	set 0,[hl]
	ld a,$07
	add a,l
	ld l,a
	ld [hl],$00
	jr Logged_0x302FB

Logged_0x302C8:
	bit 6,a
	jr z,Logged_0x302DB
	push af
	push de
	ld a,$08
	add a,e
	ld e,a
	ld a,[de]
	pop de
	pop bc
	bit 1,a
	jp nz,Logged_0x303A1
	ld a,b

Logged_0x302DB:
	bit 1,a
	jr z,Logged_0x302F6
	ld a,$1F
	add a,l
	ld l,a
	set 6,[hl]
	dec hl
	ld a,$08
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[de]
	swap a
	ld b,a
	ld a,[hl]
	and $CF
	or b
	ld [hl],a
	ret

Logged_0x302F6:
	bit 2,a
	jp z,Logged_0x30392

Logged_0x302FB:
	ld l,e
	ld h,d
	inc de
	ld a,[de]
	cp $02
	jr nc,Logged_0x30350
	push hl
	ld a,$F3
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	xor $01
	call Logged_0x301A
	push de
	ld bc,$0108
	call Logged_0x2F6C
	pop de
	pop hl
	jr z,Logged_0x30350
	ld a,$0A
	ld [hl],a
	ld a,$FC
	add a,l
	ld l,a
	res 7,[hl]
	ld a,$F7
	add a,l
	ld l,a
	ld [hl],d
	inc hl
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],e
	inc hl
	inc hl
	ld [hli],a
	ld [hld],a
	dec hl
	dec hl
	push hl
	call Logged_0x2FA4
	ld a,[hl]
	sub $7B
	ld e,a
	add a,a
	add a,a
	ld d,a
	ld a,[hl]
	and $BF
	ld [hl],a
	pop hl
	jp Logged_0x30828

Logged_0x30350:
	ld a,$03
	ld [hli],a
	ld a,$11
	sub [hl]
	ld b,a
	xor a
	ld [hli],a
	ld [hl],b
	inc hl
	push hl
	ld a,[hl]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$43DA
	add hl,bc
	pop de
	ld a,$F0
	add a,e
	ld e,a
	ld a,[de]
	ld b,a
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[de]
	ld c,a
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$12
	add a,e
	ld l,a
	ld h,d
	ld a,b
	ld [hli],a
	ld [hl],c
	ld a,[$D252]
	bit 3,a
	ret z
	ld hl,$DC04
	set 6,[hl]
	ret

Logged_0x30392:
	ld a,[hl]
	push af
	ld a,$8C
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	xor a
	ld [hl],a
	pop af
	call Logged_0x30A33

Logged_0x303A1:
	ld l,e
	ld h,d
	inc hl
	call Logged_0x30B75
	ret nc
	and a
	jr nz,Logged_0x303CF
	ld a,$08
	add a,l
	ld l,a
	xor a
	ld [hld],a
	ld [hld],a
	ld a,$03
	ld [hl],a
	ld a,$F3
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$15
	add a,l
	ld l,a
	ld a,d
	ld [hli],a
	ld [hl],e
	ld a,[$DC06]
	set 1,a
	ld [$DC06],a
	ret

Logged_0x303CF:
	ld a,$06
	add a,l
	ld l,a
	ld a,$0A
	ld [hli],a
	ld a,$10
	ld [hl],a
	ret

LoggedData_0x303DA:
INCBIN "baserom.gb", $303DA, $303EA - $303DA

Logged_0x303EA:
	push de
	ld a,$0C
	add a,e
	ld l,a
	ld h,d
	ld a,[hli]
	ld d,a
	ld e,[hl]
	ld a,$F8
	add a,l
	ld l,a
	ld a,[hl]
	call Logged_0x31162
	pop de
	jr nc,Logged_0x30430
	bit 7,a
	jr nz,Logged_0x30430
	bit 1,a
	jr z,Logged_0x30421
	ld a,$08
	ld [de],a
	ld a,$1F
	add a,l
	ld l,a
	set 6,[hl]
	dec hl
	inc de
	inc de
	inc de
	ld a,[de]
	swap a
	ld b,a
	ld a,[hl]
	and $CF
	or b
	ld [hl],a
	dec de
	dec de
	dec de
	jr Logged_0x30430

Logged_0x30421:
	ld a,[hl]
	push af
	ld a,$8C
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	xor a
	ld [hl],a
	pop af
	call Logged_0x30A33

Logged_0x30430:
	push de
	call Logged_0x31309
	and a
	jr z,Logged_0x30460
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	cp $01
	jr nz,Logged_0x30460
	ld a,$09
	ld [hl],a
	ld a,$08
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld d,$01
	ld a,b
	cp $10
	jr c,Logged_0x30451
	inc d

Logged_0x30451:
	set 2,d
	ld a,c
	cp $10
	jr c,Logged_0x3045C
	ld a,d
	add a,$04
	ld d,a

Logged_0x3045C:
	ld a,d
	ld [$D22B],a

Logged_0x30460:
	pop de
	inc de
	call Logged_0x30D30
	ret nc
	push hl
	ld a,$F2
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld bc,$0002
	call Logged_0x2F6C
	pop hl
	jr z,Logged_0x304B2
	dec hl
	ld a,$03
	ld [hli],a
	xor a
	ld [hli],a
	ld a,$10
	ld [hli],a
	ld a,[hl]
	xor $01
	ld [hl],a
	push hl
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$452C
	add hl,bc
	pop de
	ld a,$F0
	add a,e
	ld e,a
	ld a,[de]
	ld b,a
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[de]
	ld c,a
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$12
	add a,e
	ld l,a
	ld h,d
	ld a,b
	ld [hli],a
	ld [hl],c
	ret

Logged_0x304B2:
	push hl
	ld a,$F2
	add a,l
	ld l,a
	ld a,$01
	call Logged_0x30D94
	pop hl
	ret c
	push hl
	inc hl
	inc hl
	inc hl
	ld b,[hl]
	ld a,$EF
	add a,l
	ld l,a
	ld d,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld e,[hl]
	push de
	push bc
	push de
	push bc
	call Logged_0x3007
	pop bc
	ld a,b
	ld c,e
	ld b,d
	call Logged_0x26C2
	pop de
	call Logged_0x2FA4
	pop bc
	ld a,[hli]
	ld [hld],a
	ld [hl],b
	pop de
	pop hl
	ld a,$01
	ld [hld],a
	ld a,$0E
	ld [hl],a
	ld a,$F0
	add a,l
	ld l,a
	ld a,$9F
	ld [hli],a
	inc hl
	xor a
	ld [hl],a
	ld a,$17
	add a,l
	ld l,a
	ld a,[hl]
	cp $FF
	jr z,Logged_0x3050A
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$C9E8
	add hl,bc
	ld a,d
	ld [hli],a
	ld [hl],e

Logged_0x3050A:
	ld hl,$C240
	ld de,$0020
	ld c,$0E

Logged_0x30512:
	ld a,[hl]
	cp $80
	jr z,Logged_0x3051F
	cp $90
	jr c,Logged_0x30527
	cp $A0
	jr nc,Logged_0x30527

Logged_0x3051F:
	push hl
	ld a,$1F
	add a,l
	ld l,a
	set 5,[hl]
	pop hl

Logged_0x30527:
	add hl,de
	dec c
	jr nz,Logged_0x30512
	ret

UnknownData_0x3052C:
INCBIN "baserom.gb", $3052C, $3053C - $3052C

Logged_0x3053C:
	ld a,$08
	add a,e
	ld l,a
	ld h,d
	bit 7,[hl]
	jr z,Logged_0x30573
	push hl
	inc hl
	ld a,[hl]
	cp $FF
	jr z,Logged_0x30569
	push af
	ld a,[$C223]
	ld d,a
	ld a,[$C227]
	ld e,a
	ld a,[$C23D]
	call Logged_0x301A
	pop af
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$C9E8
	add hl,bc
	ld a,d
	ld [hli],a
	ld [hl],e

Logged_0x30569:
	pop hl
	ld a,$E8
	add a,l
	ld l,a
	ld [hl],$00
	jp Logged_0x32EE4

Logged_0x30573:
	push de
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$0E
	add a,l
	ld l,a
	ld a,[$C23D]
	and a
	jr nz,Logged_0x3058D
	ld a,d
	add a,$04
	ld d,a

Logged_0x3058D:
	ld a,[hl]
	call Logged_0x31162
	ld [$D252],a
	pop de
	jp nc,Logged_0x30B4E
	bit 4,a
	jr z,Logged_0x305C3
	ld a,[$CEBA]
	swap a
	ld l,a
	ld h,$00
	add hl,hl
	ld bc,$C213
	add hl,bc
	ld a,[hl]
	cp $0A
	jr z,Logged_0x305F9
	ld a,[$DC05]
	set 3,a
	ld [$DC05],a
	ld a,$0A
	ld [hli],a
	set 0,[hl]
	ld a,$07
	add a,l
	ld l,a
	ld [hl],$00
	jr Logged_0x305F9

Logged_0x305C3:
	bit 6,a
	jr z,Logged_0x305D5
	ld b,a
	push de
	ld a,$08
	add a,e
	ld e,a
	ld a,[de]
	pop de
	bit 1,a
	jp nz,Logged_0x30B4E
	ld a,b

Logged_0x305D5:
	bit 1,a
	jr z,Logged_0x305F5
	ld a,$1F
	add a,l
	ld l,a
	set 6,[hl]
	dec hl
	ld a,$08
	ld [de],a
	ld a,[$C23D]
	xor $01
	swap a
	ld b,a
	ld a,[hl]
	and $CF
	or b
	ld [hl],a
	xor a
	ld [$D179],a
	ret

Logged_0x305F5:
	bit 2,a
	jr z,Logged_0x3063D

Logged_0x305F9:
	ld l,e
	ld h,d
	ld a,$03
	ld [hli],a
	ld a,$11
	sub [hl]
	ld b,a
	xor a
	ld [hli],a
	ld [hl],b
	inc hl
	push hl
	ld a,[hl]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$43DA
	add hl,bc
	pop de
	ld a,$F0
	add a,e
	ld e,a
	ld a,[de]
	ld b,a
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[de]
	ld c,a
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$12
	add a,e
	ld l,a
	ld h,d
	ld a,b
	ld [hli],a
	ld [hl],c
	ld a,[$D252]
	bit 3,a
	ret z
	ld hl,$DC04
	set 6,[hl]
	ret

Logged_0x3063D:
	ld a,[hl]
	push af
	ld a,$8C
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	xor a
	ld [hl],a
	pop af
	call Logged_0x30A33
	jp Logged_0x30B4E

Logged_0x3064F:
	ld l,e
	ld h,d
	inc [hl]
	inc hl
	ld a,$20
	ld [hl],a
	ld a,$F2
	add a,l
	ld l,a
	ld a,$F8
	ld [hli],a
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret

Logged_0x30666:
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld [hl],$01
	push hl
	ld a,$03
	add a,l
	ld l,a
	ld a,[hl]
	sub $70
	add a,a
	ld c,a
	ld b,$00
	ld hl,$CE42
	add hl,bc
	ld a,[hli]
	swap a
	add a,$10
	ld d,a
	ld a,[hl]
	swap a
	add a,$08
	ld e,a
	push de
	call Logged_0x2FA4
	ld a,[hl]
	pop de
	pop hl
	cp $13
	ret nz
	ld a,[$D179]
	and a
	jr z,Logged_0x306AA
	ld a,[$D135]
	and a
	jr z,Logged_0x306A4
	dec a
	ld [$D135],a
	ret

Logged_0x306A4:
	ld a,[$C233]
	cp $0D
	ret z

Logged_0x306AA:
	push hl
	ld c,$0F
	ld b,$19
	ld hl,$C220

Logged_0x306B2:
	ld a,[hli]
	and a
	jr z,Logged_0x306D2
	inc hl
	inc hl
	ld a,d
	add a,$0F
	sub [hl]
	jr c,Logged_0x306D4
	cp $1E
	jr nc,Logged_0x306D4
	inc hl
	inc hl
	inc hl
	inc hl
	ld a,e
	add a,$0F
	sub [hl]
	jr c,Logged_0x306D8
	cp $1E
	jr c,Logged_0x3072A
	jr Logged_0x306D8

Logged_0x306D2:
	inc hl
	inc hl

Logged_0x306D4:
	inc hl
	inc hl
	inc hl
	inc hl

Logged_0x306D8:
	ld a,l
	add a,b
	ld l,a
	ld a,h
	adc a,$00
	ld h,a
	dec c
	jr nz,Logged_0x306B2
	pop hl
	dec hl
	inc [hl]
	ld a,[$DC06]
	set 3,a
	ld [$DC06],a
	ld a,$F3
	add a,l
	ld l,a
	ld a,d
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld [hl],e
	ld a,$05
	add a,l
	ld l,a
	push hl
	ld a,$08
	add a,l
	ld l,a
	ld a,[hl]
	ld [$D24B],a
	sub $70
	add a,a
	ld c,a
	ld b,$00
	ld hl,$CE42
	add hl,bc
	ld a,[hli]
	ld e,[hl]
	ld d,a
	push de
	call Logged_0x2FD4
	ld a,[hli]
	ld [hld],a
	ld a,[$D24B]
	ld [hl],a
	pop bc
	sla b
	sla c
	ld a,[$D24B]
	call Logged_0x26C2
	pop hl
	jp Logged_0x30A9D

Logged_0x3072A:
	pop hl
	ret

Logged_0x3072C:
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	jp Logged_0x30AB0

Logged_0x30736:
	jp Logged_0x30A8E

Logged_0x30739:
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	ret z
	res 6,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld a,$05
	ld [hl],a
	ret

Logged_0x3074B:
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	push hl
	ld a,$F2
	add a,l
	ld l,a
	ld a,[hli]
	ld [$D256],a
	ld d,a
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	ld e,a
	ld [$D255],a
	call Logged_0x2FA4
	ld a,[hl]
	or $40
	ld [hl],a
	pop hl
	ld a,$05
	add a,l
	ld l,a
	ld d,[hl]
	inc hl
	ld e,[hl]
	ld a,$FC
	add a,l
	ld l,a
	ld [hl],d
	ld a,$EE
	add a,l
	ld l,a
	ld [hl],e
	inc hl
	ld a,d
	add a,a
	add a,a
	add a,d
	add a,$02
	ld [hl],a
	ld a,$0F
	add a,l
	ld l,a
	ld [hl],$01
	push hl
	push de
	call Logged_0x30B75
	pop de
	pop hl
	jr c,Logged_0x30809
	ld a,d
	add a,a
	add a,a
	add a,d
	add a,d
	push hl
	ld c,a
	ld b,$00
	ld hl,$484C
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$F2
	add a,l
	ld l,a
	ld a,[de]
	add a,[hl]
	ld [hli],a
	inc hl
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	add a,[hl]
	ld [hli],a
	inc hl
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	ld a,$F8
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	push hl
	ld a,$0E
	add a,l
	ld l,a
	ld a,[hl]
	call Logged_0x312BD
	pop hl
	jr nc,Logged_0x307EB
	dec hl
	dec hl
	dec hl
	dec hl
	ld a,[$D256]
	ld d,a
	ld [hli],a
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	ld a,[$D255]
	ld e,a
	ld [hli],a
	inc hl
	xor a
	ld [hli],a
	ld [hld],a
	dec hl
	dec hl
	jr Logged_0x30816

Logged_0x307EB:
	ld a,$05
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$04
	add a,l
	ld l,a
	push hl
	ld a,$02
	ld [hli],a
	ld a,$01
	ld [hl],a
	ld a,$FC
	add a,l
	ld l,a
	ld c,$00
	call Logged_0x31C3
	pop de
	jp Logged_0x301FE

Logged_0x30809:
	and a
	jr nz,Logged_0x30848
	ld a,$F2
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]

Logged_0x30816:
	push hl
	call Logged_0x2FA4
	ld a,[hl]
	or $40
	sub $7B
	ld e,a
	add a,a
	add a,a
	ld d,a
	ld a,[hl]
	and $BF
	ld [hl],a
	pop hl

Logged_0x30828:
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	add a,d
	push hl
	ld c,a
	ld b,$00
	ld hl,$4864
	add hl,bc
	ld a,[hl]
	pop hl
	inc hl
	inc hl
	inc hl
	ld [hl],a
	ld a,$EB
	add a,l
	ld l,a
	ld a,$88
	ld [hli],a
	ld [hl],e
	ld a,$0F
	add a,l
	ld l,a

Logged_0x30848:
	ld a,$10
	ld [hl],a
	ret

LoggedData_0x3084C:
INCBIN "baserom.gb", $3084C, $30864 - $3084C

UnknownData_0x30864:
INCBIN "baserom.gb", $30864, $30865 - $30864

LoggedData_0x30865:
INCBIN "baserom.gb", $30865, $30866 - $30865

UnknownData_0x30866:
INCBIN "baserom.gb", $30866, $30869 - $30866

LoggedData_0x30869:
INCBIN "baserom.gb", $30869, $3086B - $30869

UnknownData_0x3086B:
INCBIN "baserom.gb", $3086B, $3086C - $3086B

LoggedData_0x3086C:
INCBIN "baserom.gb", $3086C, $3086D - $3086C

UnknownData_0x3086D:
INCBIN "baserom.gb", $3086D, $3086F - $3086D

LoggedData_0x3086F:
INCBIN "baserom.gb", $3086F, $30871 - $3086F

UnknownData_0x30871:
INCBIN "baserom.gb", $30871, $30872 - $30871

LoggedData_0x30872:
INCBIN "baserom.gb", $30872, $30873 - $30872

UnknownData_0x30873:
INCBIN "baserom.gb", $30873, $30874 - $30873

Logged_0x30874:
	ld a,$03
	add a,e
	ld e,a
	ld a,[de]
	push af
	ld b,a
	add a,a
	add a,a
	add a,b
	add a,$02
	ld b,a
	ld a,$EF
	add a,e
	ld e,a
	ld a,b
	ld [de],a
	pop af
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$48B5
	add hl,bc
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	inc de
	inc de
	ld a,[de]
	set 7,a
	ld [de],a
	ld a,$05
	add a,e
	ld e,a
	ld a,$01
	ld [de],a
	dec de
	ld a,$02
	ld [de],a
	jp Logged_0x301FE

LoggedData_0x308B5:
INCBIN "baserom.gb", $308B5, $308C5 - $308B5

Logged_0x308C5:
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	dec hl
	ld [hl],$00
	ld a,$0A
	add a,l
	ld l,a
	ld a,[hli]
	ld e,[hl]
	ld d,a
	ld a,$E6
	add a,l
	ld l,a
	push hl
	inc hl
	inc hl
	ld a,d
	ld [hli],a
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],e
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$02
	add a,l
	ld l,a
	ld [hl],$80
	ld a,$F4
	add a,l
	ld l,a
	ld [hl],$83
	ld a,[$D12B]
	res 1,a
	ld [$D12B],a
	ld d,$00
	ld a,[$CE66]
	inc a
	ld [$CE66],a
	cp $05
	jr z,Logged_0x30919
	cp $0A
	jr z,Logged_0x30919
	cp $0F
	jr z,Logged_0x30919
	cp $14
	jr nz,Logged_0x3091F
	ld d,$20
	ld b,$B3
	jr Logged_0x30921

Logged_0x30919:
	ld d,$20
	ld b,$B3
	jr Logged_0x30921

Logged_0x3091F:
	ld b,$B0

Logged_0x30921:
	ld hl,$DC09
	set 4,[hl]
	pop hl
	ld a,$17
	add a,l
	ld l,a
	ld a,[hl]
	and $DF
	or d
	ld [hl],a
	ld a,$E9
	add a,l
	ld l,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31B3

Unknown_0x3093A:
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$03
	add a,l
	ld c,a
	ld b,h
	jp Logged_0x30EF8

Logged_0x30947:
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$EF
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ret
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	rst JumpList
	dw Logged_0x3095F
	dw Logged_0x309EA
	dw Logged_0x30A09

Logged_0x3095F:
	ld hl,$D142
	set 4,[hl]
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	ret z
	res 6,[hl]
	ld a,[$D142]
	res 4,a
	ld [$D142],a
	ld a,$F4
	add a,l
	ld l,a
	ld [hl],$00
	ld a,$18
	add a,l
	ld l,a
	ld b,[hl]
	ld a,$E8
	add a,l
	ld l,a
	bit 5,b
	ret z
	ld de,$C560
	ld c,$20
	call Logged_0x092B
	ld a,$83
	ld [$C560],a
	ld a,$01
	ld [$C570],a
	ld hl,$C563
	ld a,$9C
	sub [hl]
	ld d,a
	ld hl,$C567
	ld a,$94
	sub [hl]
	ld e,a
	cp d
	jr c,Logged_0x309B9
	ld h,d
	ld l,$00
	ld b,e
	call Logged_0x32D9
	ld e,l
	ld d,h
	ld bc,$0100
	jr Logged_0x309C5

Logged_0x309B9:
	ld h,e
	ld l,$00
	ld b,d
	call Logged_0x32D9
	ld c,l
	ld b,h
	ld de,$0100

Logged_0x309C5:
	ld hl,$C565
	ld a,d
	ld [hli],a
	ld a,e
	ld [hli],a
	inc hl
	inc hl
	ld a,b
	ld [hli],a
	ld [hl],c
	ld hl,$DC0B
	set 2,[hl]
	ld hl,$CE52
	ld a,[hl]
	cp $04
	jr z,Logged_0x309DF
	inc [hl]

Logged_0x309DF:
	ld hl,$C561
	ld bc,$B400
	ld d,$00
	jp Logged_0x31B3

Logged_0x309EA:
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[hl]
	cp $9C
	ret c
	inc hl
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,[$FF00+$91]
	cp $04
	jr nz,Logged_0x30A0E
	ld a,$06
	add a,l
	ld l,a
	ld [hl],$02
	ret

Logged_0x30A09:
	ld a,[$FF00+$91]
	cp $04
	ret z

Logged_0x30A0E:
	ld a,[$FF00+$91]
	cp $08
	jr z,Logged_0x30A17
	cp $0C
	ret nz

Logged_0x30A17:
	ld a,$F0
	add a,e
	ld e,a
	xor a
	ld [de],a
	ld hl,$CE52
	ld b,$3F
	ld a,[hl]
	ld c,a
	add a,a
	add a,a
	add a,[hl]
	ld d,a
	ld hl,$DC04
	set 2,[hl]
	ld hl,$C5E1
	jp Logged_0x31B3

Logged_0x30A33:
	cp $90
	ret c
	cp $97
	ret nc
	push hl
	sub $90
	add a,a
	ld c,a
	ld b,$00
	ld hl,$4A6C
	add hl,bc
	pop bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl
	ld hl,$DC0B
	set 6,[hl]
	ret
	inc bc
	ld a,[bc]
	rra
	jr c,Logged_0x30A5A
	ld hl,$DC0B
	set 5,[hl]
	ret

Logged_0x30A5A:
	ld hl,$DC04
	set 3,[hl]
	ret
	ld hl,$DC06
	set 7,[hl]
	ret
	ld hl,$DC0B
	set 7,[hl]
	ret

LoggedData_0x30A6C:
INCBIN "baserom.gb", $30A6C, $30A74 - $30A6C

UnknownData_0x30A74:
INCBIN "baserom.gb", $30A74, $30A78 - $30A74

LoggedData_0x30A78:
INCBIN "baserom.gb", $30A78, $30A7A - $30A78
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	rst JumpList
	dw Logged_0x30ABA
	dw Logged_0x30ACF
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	rst JumpList
	dw Logged_0x30A8E
	dw Logged_0x30AAB

Logged_0x30A8E:
	ld l,e
	ld h,d
	inc [hl]
	ld a,$F5
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hli],a
	inc hl

Logged_0x30A9D:
	set 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld bc,$8F00
	ld d,$00
	jp Logged_0x31B3

Logged_0x30AAB:
	ld a,$FC
	add a,e
	ld l,a
	ld h,d

Logged_0x30AB0:
	bit 6,[hl]
	ret z
	ld a,$F4
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ret

Logged_0x30ABA:
	ld l,e
	ld h,d
	inc [hl]
	ld a,$FC
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld bc,$8F00
	ld d,$00
	jp Logged_0x31B3

Logged_0x30ACF:
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	jr z,Logged_0x30B08
	res 5,[hl]
	ld a,$05
	add a,l
	ld l,a
	ld a,[hli]
	swap a
	add a,$10
	ld d,a
	ld a,[hli]
	swap a
	add a,$08
	ld e,a
	ld a,[hli]
	ld c,[hl]
	ld b,a
	push bc
	call Logged_0x3007
	pop bc
	push de
	srl d
	srl e
	push bc
	call Logged_0x2FD4
	pop bc
	bit 0,c
	jr nz,Logged_0x30B02
	ld a,[hli]
	ld [hld],a

Logged_0x30B02:
	ld [hl],b
	ld a,b
	pop bc
	jp Logged_0x26C2

Logged_0x30B08:
	bit 6,[hl]
	ret z
	ld a,$F4
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ret
	ld a,$10
	add a,e
	ld l,a
	ld h,d
	inc [hl]
	ld a,$F5
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hli],a
	inc hl
	set 7,[hl]
	set 4,[hl]
	ld a,$F4
	add a,l
	ld l,a
	ld a,$01
	ld [hli],a
	ld bc,$B100
	ld d,$00
	jp Logged_0x31B3

Logged_0x30B37:
	ld a,$F3
	add a,e
	ld e,a
	ld hl,$D17E
	ld a,[$C223]
	add a,[hl]
	ld [de],a
	inc de
	inc de
	inc de
	inc de
	inc hl
	ld a,[$C227]
	add a,[hl]
	ld [de],a
	ret

Logged_0x30B4E:
	ld a,[$C23D]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$4B6D
	add hl,bc
	ld a,$F3
	add a,e
	ld e,a
	ld a,[$C223]
	add a,[hl]
	ld [de],a
	inc de
	inc de
	inc de
	inc de
	inc hl
	ld a,[$C227]
	add a,[hl]
	ld [de],a
	ret

LoggedData_0x30B6D:
INCBIN "baserom.gb", $30B6D, $30B75 - $30B6D

Logged_0x30B75:
	and a
	dec [hl]
	ret nz
	ld a,$10
	ld [hl],a
	ld a,$F2
	add a,l
	ld l,a
	ld d,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld e,[hl]
	ld a,$11
	add a,l
	ld l,a
	push hl
	push de
	bit 2,[hl]
	jr z,Logged_0x30B95
	res 2,[hl]
	pop de
	pop hl
	jr Logged_0x30BA3

Logged_0x30B95:
	ld a,$EB
	add a,l
	ld l,a
	xor a
	call Logged_0x30D94
	pop de
	pop hl
	jr nc,Logged_0x30BA3
	and a
	ret

Logged_0x30BA3:
	ld a,$FB
	add a,l
	ld l,a
	ld a,[hl]
	push hl
	push af
	call Logged_0x301A
	pop af
	push de
	call Logged_0x3122
	pop de
	pop hl
	jr nc,Logged_0x30BC4
	ld a,$F2
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	xor a
	scf
	ret

Logged_0x30BC4:
	push hl
	inc hl
	ld a,[hl]
	sub $68
	add a,a
	ld c,a
	ld b,$00
	ld hl,$4CB2
	add hl,bc
	ld a,[hli]
	ld b,a
	ld c,[hl]
	push de
	call Logged_0x2F6C
	pop bc
	pop hl
	jr nz,Logged_0x30BDE
	and a
	ret

Logged_0x30BDE:
	push af
	ld a,$F2
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	pop af
	bit 3,a
	jr nz,Logged_0x30C0A
	bit 2,a
	jr z,Logged_0x30C07
	push hl
	ld a,d
	ld [$D24B],a
	ld e,c
	ld d,b
	call Logged_0x2FA4
	ld e,l
	ld d,h
	pop bc
	ld a,$F9
	add a,c
	ld c,a
	jp Logged_0x30F64

Logged_0x30C07:
	xor a
	scf
	ret

Logged_0x30C0A:
	ld a,c
	ld [$D24D],a
	ld a,b
	ld [$D24E],a
	push hl
	ld a,$09
	add a,l
	ld l,a
	ld a,[hl]
	ld [$D24B],a
	ld a,d
	sub $7B
	ld e,a
	swap a
	ld b,a
	ld a,[$D24B]
	add a,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$4CE2
	add hl,bc
	ld b,[hl]
	inc hl
	ld a,[$D24E]
	add a,[hl]
	ld [$D250],a
	inc hl
	ld a,[$D24D]
	add a,[hl]
	ld [$D24F],a
	inc hl
	ld a,[hl]
	pop hl
	and a
	jr z,Logged_0x30C07
	push hl
	push de
	ld hl,$D24D
	ld a,[hli]
	ld d,[hl]
	ld e,a
	call Logged_0x2FA4
	ld a,[hl]
	and $BF
	ld [hl],a
	pop de
	pop hl
	ld a,$0C
	add a,l
	ld l,a
	ld [hl],b
	ld a,$F6
	add a,l
	ld l,a
	res 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld a,[hl]
	push af
	ld a,$88
	ld [hli],a
	ld [hl],e
	ld a,$15
	add a,l
	ld l,a
	pop af
	ld [hl],a
	ld a,$EC
	add a,l
	ld l,a
	push hl
	ld d,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld e,[hl]
	ld a,[$D24B]
	call Logged_0x301A
	pop hl
	ld [hl],d
	ld a,$04
	add a,l
	ld l,a
	ld [hl],e
	inc hl
	inc hl
	inc hl
	push hl
	call Logged_0x3069
	ld a,[$D250]
	ld b,a
	ld a,[$D24F]
	ld c,a
	ld de,$4D22
	call Logged_0x309F
	ld a,$06
	add a,l
	ld l,a
	ld c,$00
	call Logged_0x31C3
	ld hl,$DC07
	set 2,[hl]
	pop hl
	ld a,$01
	scf
	ret

UnknownData_0x30CB2:
INCBIN "baserom.gb", $30CB2, $30CC2 - $30CB2

LoggedData_0x30CC2:
INCBIN "baserom.gb", $30CC2, $30CCA - $30CC2

UnknownData_0x30CCA:
INCBIN "baserom.gb", $30CCA, $30CD2 - $30CCA

LoggedData_0x30CD2:
INCBIN "baserom.gb", $30CD2, $30CD6 - $30CD2

UnknownData_0x30CD6:
INCBIN "baserom.gb", $30CD6, $30CE2 - $30CD6

LoggedData_0x30CE2:
INCBIN "baserom.gb", $30CE2, $30CEE - $30CE2

UnknownData_0x30CEE:
INCBIN "baserom.gb", $30CEE, $30CF2 - $30CEE

LoggedData_0x30CF2:
INCBIN "baserom.gb", $30CF2, $30D12 - $30CF2

UnknownData_0x30D12:
INCBIN "baserom.gb", $30D12, $30D16 - $30D12

LoggedData_0x30D16:
INCBIN "baserom.gb", $30D16, $30D30 - $30D16

Logged_0x30D30:
	ld a,[de]
	cp $10
	jr nc,Logged_0x30D55
	add a,a
	ld c,a
	ld b,$00
	ld hl,$4D74
	add hl,bc
	ld a,$F2
	add a,e
	ld e,a
	ld a,[de]
	add a,[hl]
	ld [de],a
	ld b,a
	inc hl
	ld a,$04
	add a,e
	ld e,a
	ld a,[de]
	add a,[hl]
	ld [de],a
	ld c,a
	ld a,$0A
	add a,e
	ld e,a
	ld a,[de]
	inc a
	ld [de],a

Logged_0x30D55:
	ld l,e
	ld h,d
	inc hl
	ld a,[hl]
	and a
	jr z,Logged_0x30D6C
	dec [hl]
	jr nz,Logged_0x30D6A
	ld a,$F3
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a

Logged_0x30D6A:
	and a
	ret

Logged_0x30D6C:
	dec hl
	ld a,[hl]
	cp $10
	jr c,Logged_0x30D6A
	scf
	ret

LoggedData_0x30D74:
INCBIN "baserom.gb", $30D74, $30D94 - $30D74

Logged_0x30D94:
	ld [$D258],a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld a,[hld]
	ld e,a
	dec hl
	dec hl
	dec hl

Logged_0x30DA1:
	push hl
	ld hl,$D255
	ld a,e
	ld [hli],a
	ld [hl],d
	call Logged_0x2FA4
	ld e,l
	ld d,h
	ld a,[hl]
	ld [$D24B],a
	ld c,a
	ld b,$00
	ld hl,$4DC3
	add hl,bc
	pop bc
	ld a,[hl]
	rst JumpList
	dw Logged_0x30E53
	dw Logged_0x30E55
	dw Logged_0x30F64
	dw Logged_0x31019

LoggedData_0x30DC3:
INCBIN "baserom.gb", $30DC3, $30DC8 - $30DC3

UnknownData_0x30DC8:
INCBIN "baserom.gb", $30DC8, $30DCB - $30DC8

LoggedData_0x30DCB:
INCBIN "baserom.gb", $30DCB, $30DCC - $30DCB

UnknownData_0x30DCC:
INCBIN "baserom.gb", $30DCC, $30DCD - $30DCC

LoggedData_0x30DCD:
INCBIN "baserom.gb", $30DCD, $30DD0 - $30DCD

UnknownData_0x30DD0:
INCBIN "baserom.gb", $30DD0, $30DD3 - $30DD0

LoggedData_0x30DD3:
INCBIN "baserom.gb", $30DD3, $30DD4 - $30DD3

UnknownData_0x30DD4:
INCBIN "baserom.gb", $30DD4, $30DD6 - $30DD4

LoggedData_0x30DD6:
INCBIN "baserom.gb", $30DD6, $30DD8 - $30DD6

UnknownData_0x30DD8:
INCBIN "baserom.gb", $30DD8, $30DD9 - $30DD8

LoggedData_0x30DD9:
INCBIN "baserom.gb", $30DD9, $30DDF - $30DD9

UnknownData_0x30DDF:
INCBIN "baserom.gb", $30DDF, $30E23 - $30DDF

LoggedData_0x30E23:
INCBIN "baserom.gb", $30E23, $30E27 - $30E23

UnknownData_0x30E27:
INCBIN "baserom.gb", $30E27, $30E3E - $30E27

LoggedData_0x30E3E:
INCBIN "baserom.gb", $30E3E, $30E42 - $30E3E

UnknownData_0x30E42:
INCBIN "baserom.gb", $30E42, $30E53 - $30E42

Logged_0x30E53:
	and a
	ret

Logged_0x30E55:
	ld a,$11
	add a,c
	ld c,a
	ld a,[bc]
	sub $68
	rst JumpList
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Unknown_0x30ED3
	dw Unknown_0x30ED3
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E8D
	dw Logged_0x30E9B
	dw Logged_0x30ED4
	dw Unknown_0x30ED3
	dw Unknown_0x30ED3
	dw Unknown_0x30ED3
	dw Unknown_0x30ED3
	dw Unknown_0x30ED3
	dw Unknown_0x30ED3

Logged_0x30E8D:
	ld a,$FC
	add a,c
	ld c,a
	ld a,$05
	ld [bc],a
	ld hl,$DC05
	set 2,[hl]
	scf
	ret

Logged_0x30E9B:
	ld a,$EC
	add a,c
	ld l,a
	ld h,b
	xor a
	ld [hli],a
	ld hl,$D255
	ld a,[hli]
	ld e,a
	ld d,[hl]
	push de
	call Logged_0x2FA4
	ld [hl],$0C
	inc hl
	inc hl
	ld [hl],$50
	pop de
	call Logged_0x3007
	ld b,d
	ld c,e
	push bc
	ld a,$0C
	call Logged_0x26C2
	call Logged_0x3047
	ld a,$11
	ld [hli],a
	pop bc
	ld a,b
	ld [hli],a
	ld a,c
	ld [hli],a
	ld a,$D0
	ld [hl],a
	ld hl,$DC06
	set 2,[hl]
	scf
	ret

Unknown_0x30ED3:
	ret

Logged_0x30ED4:
	ld a,[$FF00+$91]
	cp $04
	ret z
	cp $05
	jr nz,Logged_0x30EF8
	ld a,$F1
	add a,c
	ld l,a
	ld h,b
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	ld a,$0D
	ld [hli],a
	ld [hl],$01
	ld hl,$D12B
	set 1,[hl]
	ret

Logged_0x30EF8:
	ld a,$05
	add a,c
	ld c,a
	push bc
	ld a,[$C9E4]
	cp $08
	jr z,Logged_0x30F1A
	ld a,[bc]
	ld c,a
	ld b,$00
	ld hl,$4F5C
	add hl,bc
	ld d,[hl]
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CD82
	add hl,bc
	ld a,[hl]
	or d
	ld [hl],a

Logged_0x30F1A:
	pop hl
	ld a,$F7
	add a,l
	ld l,a
	ld a,$0C
	ld [hli],a
	ld [hl],$10
	ld a,$F2
	add a,l
	ld l,a
	ld d,[hl]
	xor a
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$F8
	ld [hl],a
	ld a,$13
	add a,l
	ld l,a
	ld a,d
	ld [hli],a
	ld [hl],e
	ld a,$FE
	add a,l
	ld l,a
	ld a,[hl]
	add a,a
	add a,[hl]
	ld c,a
	ld b,$00
	ld hl,$C9E8
	add hl,bc
	ld a,$FF
	ld [hli],a
	ld [hl],a
	ld hl,$D142
	set 4,[hl]
	ld hl,$D12B
	set 1,[hl]
	ld hl,$DC05
	set 2,[hl]
	scf
	ret

LoggedData_0x30F5C:
INCBIN "baserom.gb", $30F5C, $30F60 - $30F5C

UnknownData_0x30F60:
INCBIN "baserom.gb", $30F60, $30F61 - $30F60

LoggedData_0x30F61:
INCBIN "baserom.gb", $30F61, $30F62 - $30F61

UnknownData_0x30F62:
INCBIN "baserom.gb", $30F62, $30F64 - $30F62

Logged_0x30F64:
	ld hl,$DC07
	set 5,[hl]
	ld a,$14
	ld [de],a
	ld l,c
	ld h,b
	push hl
	push hl
	ld hl,$D255
	ld a,[hli]
	ld d,[hl]
	ld e,a
	push de
	call Logged_0x3007
	ld b,d
	ld c,e
	ld a,$14
	call Logged_0x26C2
	ld a,[$D24B]
	sub $60
	ld c,a
	ld b,$00
	ld hl,$5011
	add hl,bc
	ld d,[hl]
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC42
	add hl,bc
	ld a,[hl]
	or d
	ld [hl],a
	pop de
	cp $FF
	jr nz,Logged_0x30FB5
	ld a,[$D12A]
	bit 3,a
	jr nz,Unknown_0x31000
	ld a,$05
	ld [$D174],a
	call Logged_0x33FAF
	ld a,d
	ld [hli],a
	ld [hl],e
	call Logged_0x31107

Logged_0x30FB5:
	pop hl
	ld a,[$D12A]
	bit 3,a
	jr nz,Logged_0x30FF2
	ld a,$11
	add a,l
	ld l,a
	ld a,[hl]
	sub $70
	ld c,a
	ld b,$00
	ld hl,$5011
	add hl,bc
	ld d,[hl]
	ld a,[$CFDB]
	ld c,a
	ld b,$00
	ld hl,$CC82
	add hl,bc
	ld a,[hl]
	or d
	ld [hl],a
	pop hl
	ld a,$FD
	add a,l
	ld l,a
	ld a,$8F
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld a,[$C922]
	ld [$CE70],a
	call Logged_0x3224
	scf
	ret

Logged_0x30FF2:
	ld hl,$D13B
	set 0,[hl]
	pop hl
	ld a,$0D
	add a,l
	ld l,a
	ld [hl],$08
	scf
	ret

Unknown_0x31000:
	ld a,$0B
	ld [$C253],a
	xor a
	ld [$C25B],a
	ld hl,$C254
	set 0,[hl]
	pop hl
	jr Logged_0x30FF2

LoggedData_0x31011:
INCBIN "baserom.gb", $31011, $31015 - $31011

UnknownData_0x31015:
INCBIN "baserom.gb", $31015, $31019 - $31015

Logged_0x31019:
	ld a,[$D258]
	and a
	jr z,Logged_0x31021
	and a
	ret

Logged_0x31021:
	ld a,$11
	add a,c
	ld c,a
	ld a,[bc]
	cp $7F
	ret z
	cp $7A
	ret z
	ld a,$EF
	add a,c
	ld c,a
	push bc
	ld a,[$D24B]
	sub $18
	add a,a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$50C1
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	push hl
	ld a,[de]
	ld b,a
	ld a,[$D256]
	add a,b
	ld [hli],a
	ld b,a
	inc de
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld c,a
	ld a,[$D255]
	add a,c
	ld [hli],a
	ld c,a
	inc de
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld a,$02
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld a,$02
	ld [hli],a
	dec a
	ld [hli],a
	inc hl
	ld a,[de]
	ld [hl],a
	ld [$D24D],a
	inc de
	ld a,$05
	add a,l
	ld l,a
	set 2,[hl]
	ld a,$FC
	add a,l
	ld l,a
	ld a,[hl]
	sub $68
	push bc
	ld c,a
	ld b,$00
	ld hl,$50E1
	add hl,bc
	pop bc
	ld a,[hl]
	pop hl
	push bc
	ld b,a
	dec hl
	dec hl
	ld a,[de]
	ld d,a
	ld c,$00
	call Logged_0x31B3
	call Logged_0x3069
	pop bc
	ld de,$50F9
	call Logged_0x309F
	ld a,$FA
	add a,l
	ld l,a
	ld b,$8C
	ld c,$00
	ld a,[$D24D]
	ld d,a
	add a,a
	add a,a
	add a,d
	ld d,a
	call Logged_0x31B3
	ld hl,$DC0A
	set 2,[hl]
	scf
	ret

LoggedData_0x310C1:
INCBIN "baserom.gb", $310C1, $310E1 - $310C1

UnknownData_0x310E1:
INCBIN "baserom.gb", $310E1, $310E9 - $310E1

LoggedData_0x310E9:
INCBIN "baserom.gb", $310E9, $310EA - $310E9

UnknownData_0x310EA:
INCBIN "baserom.gb", $310EA, $310F1 - $310EA

LoggedData_0x310F1:
INCBIN "baserom.gb", $310F1, $310F3 - $310F1

UnknownData_0x310F3:
INCBIN "baserom.gb", $310F3, $310F9 - $310F3

LoggedData_0x310F9:
INCBIN "baserom.gb", $310F9, $31107 - $310F9

Logged_0x31107:
	ld hl,$D12A
	res 4,[hl]
	ld hl,$C240
	ld c,$0E
	call Logged_0x31119
	ld hl,$C440
	ld c,$0E

Logged_0x31119:
	ld de,$0020
	ld b,$00

Logged_0x3111E:
	ld a,[hl]
	rla
	jr nc,Logged_0x31155
	ld a,[hl]
	cp $80
	jr nz,Logged_0x31134
	push hl
	ld a,$14
	add a,l
	ld l,a
	ld a,[hl]
	pop hl
	cp $79
	jr z,Logged_0x31155
	jr Logged_0x3113C

Logged_0x31134:
	cp $90
	jr c,Logged_0x31155
	cp $A0
	jr nc,Logged_0x31155

Logged_0x3113C:
	push bc
	push hl
	ld a,[hl]
	push af
	ld a,$8C
	ld [hl],a
	ld a,$10
	add a,l
	ld l,a
	xor a
	ld [hl],a
	pop af
	cp $80
	jr z,Logged_0x31151
	call Logged_0x30A33

Logged_0x31151:
	pop hl
	pop bc
	ld b,$01

Logged_0x31155:
	add hl,de
	dec c
	jr nz,Logged_0x3111E
	ld a,b
	and a
	ret z
	ld hl,$D12A
	set 4,[hl]
	ret

Logged_0x31162:
	ld b,a
	ld hl,$D24B
	ld a,e
	ld [hli],a
	ld [hl],d
	ld c,$02
	ld hl,$C240

Logged_0x3116E:
	push bc
	ld a,b
	cp c
	jr z,Logged_0x311CD
	bit 7,[hl]
	jr z,Logged_0x311CD
	inc hl
	ld a,[hld]
	cp $8F
	jr z,Logged_0x311CD
	push hl
	ld a,[hl]
	and $7F
	ld c,a
	add a,a
	add a,a
	add a,c
	ld c,a
	ld b,$00
	ld hl,$51E6
	add hl,bc
	ld a,[hli]
	ld [$D24D],a
	bit 0,a
	jr nz,Logged_0x31196
	jr Logged_0x311CC

Logged_0x31196:
	bit 5,a
	jr z,Logged_0x311A4
	pop bc
	push bc
	ld a,$1F
	add a,c
	ld c,a
	ld a,[bc]
	rra
	jr c,Logged_0x311CC

Logged_0x311A4:
	ld a,[$D24C]
	sub [hl]
	ld d,a
	inc hl
	ld a,[$D24B]
	sub [hl]
	ld e,a
	inc hl
	pop bc
	push bc
	ld a,$03
	add a,c
	ld c,a
	ld a,[bc]
	sub d
	jr c,Logged_0x311CC
	cp [hl]
	jr nc,Logged_0x311CC
	ld [$D24E],a
	inc hl
	inc bc
	inc bc
	inc bc
	inc bc
	ld a,[bc]
	sub e
	jr c,Logged_0x311CC
	cp [hl]
	jr c,Logged_0x311DA

Logged_0x311CC:
	pop hl

Logged_0x311CD:
	ld de,$0020
	add hl,de
	pop bc
	inc c
	ld a,c
	cp $10
	jr c,Logged_0x3116E
	and a
	ret

Logged_0x311DA:
	pop hl
	pop bc
	ld e,a
	ld a,[$D24E]
	ld d,a
	ld a,[$D24D]
	scf
	ret

LoggedData_0x311E6:
INCBIN "baserom.gb", $311E6, $311EC - $311E6

UnknownData_0x311EC:
INCBIN "baserom.gb", $311EC, $311F0 - $311EC

LoggedData_0x311F0:
INCBIN "baserom.gb", $311F0, $311F1 - $311F0

UnknownData_0x311F1:
INCBIN "baserom.gb", $311F1, $311F5 - $311F1

LoggedData_0x311F5:
INCBIN "baserom.gb", $311F5, $311F6 - $311F5

UnknownData_0x311F6:
INCBIN "baserom.gb", $311F6, $3120E - $311F6

LoggedData_0x3120E:
INCBIN "baserom.gb", $3120E, $3120F - $3120E

UnknownData_0x3120F:
INCBIN "baserom.gb", $3120F, $3121D - $3120F

LoggedData_0x3121D:
INCBIN "baserom.gb", $3121D, $3121E - $3121D

UnknownData_0x3121E:
INCBIN "baserom.gb", $3121E, $31222 - $3121E

LoggedData_0x31222:
INCBIN "baserom.gb", $31222, $31223 - $31222

UnknownData_0x31223:
INCBIN "baserom.gb", $31223, $31236 - $31223

LoggedData_0x31236:
INCBIN "baserom.gb", $31236, $31259 - $31236

UnknownData_0x31259:
INCBIN "baserom.gb", $31259, $31281 - $31259

LoggedData_0x31281:
INCBIN "baserom.gb", $31281, $31282 - $31281

UnknownData_0x31282:
INCBIN "baserom.gb", $31282, $31286 - $31282

LoggedData_0x31286:
INCBIN "baserom.gb", $31286, $3128B - $31286

UnknownData_0x3128B:
INCBIN "baserom.gb", $3128B, $31290 - $3128B

LoggedData_0x31290:
INCBIN "baserom.gb", $31290, $3129D - $31290

UnknownData_0x3129D:
INCBIN "baserom.gb", $3129D, $3129F - $3129D

LoggedData_0x3129F:
INCBIN "baserom.gb", $3129F, $312BD - $3129F

Logged_0x312BD:
	ld b,a
	ld hl,$D24B
	ld a,e
	ld [hli],a
	ld [hl],d
	ld c,$02
	ld hl,$C240

Logged_0x312C9:
	push bc
	ld a,b
	cp c
	jr z,Logged_0x312F8
	ld a,[hl]
	cp $80
	jr nz,Logged_0x312F8
	push hl
	ld a,[$D24C]
	sub $0E
	ld d,a
	ld a,[$D24B]
	sub $0E
	ld e,a
	ld a,$03
	add a,l
	ld l,a
	ld a,[hli]
	sub d
	jr c,Logged_0x312F7
	cp $1C
	jr nc,Logged_0x312F7
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	sub e
	jr c,Logged_0x312F7
	cp $1C
	jr c,Logged_0x31305

Logged_0x312F7:
	pop hl

Logged_0x312F8:
	ld de,$0020
	add hl,de
	pop bc
	inc c
	ld a,c
	cp $10
	jr c,Logged_0x312C9
	and a
	ret

Logged_0x31305:
	pop hl
	pop bc
	scf
	ret

Logged_0x31309:
	ld a,[$D142]
	bit 3,a
	jr nz,Logged_0x3135A
	ld a,$F3
	add a,e
	ld e,a

Logged_0x31314:
	ld a,[de]
	sub $0C
	ld b,a
	ld a,$04
	add a,e
	ld e,a
	ld a,[de]
	sub $0C
	ld c,a
	ld hl,$C223
	ld a,[$D141]
	rla
	jr c,Logged_0x3132C
	ld hl,$C423

Logged_0x3132C:
	ld a,[hli]
	sub b
	ld b,a
	jr c,Logged_0x3135A
	cp $18
	jr nc,Logged_0x3135A
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	sub c
	ld c,a
	jr c,Logged_0x3135A
	cp $18
	jr nc,Logged_0x3135A
	push bc
	ld a,[$D141]
	and $08
	ld b,a
	ld a,[$D16A]
	or b
	ld b,a
	ld a,[$D16B]
	or b
	pop bc
	jr nz,Logged_0x31357
	ld a,$02
	ret

Logged_0x31357:
	ld a,$01
	ret

Logged_0x3135A:
	xor a
	ret

Logged_0x3135C:
	ld a,[hl]
	cp $10
	ret z

Logged_0x31360:
	ld a,$10
	ld [hl],a
	ld a,$08
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld a,$F9
	add a,l
	ld l,a
	set 5,[hl]
	ld d,$00
	ld a,c
	cp $10
	jr c,Logged_0x31377
	inc d

Logged_0x31377:
	ld a,[$D142]
	and $FE
	or d
	ld [$D142],a
	ret
	push de
	ld a,$10
	add a,e
	ld e,a
	call Logged_0x31309
	cp $02
	jr c,Logged_0x3139A
	ld a,[$D141]
	rra
	jr c,Logged_0x3139A
	ld a,$0C
	add a,l
	ld l,a
	call Logged_0x3135C

Logged_0x3139A:
	call Logged_0x32E7E
	pop de
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$53AF
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x313AF:
INCBIN "baserom.gb", $313AF, $313DF - $313AF

UnknownData_0x313DF:
INCBIN "baserom.gb", $313DF, $313E1 - $313DF

LoggedData_0x313E1:
INCBIN "baserom.gb", $313E1, $313E5 - $313E1
	inc de
	ld a,$80
	ld [de],a
	dec de
	ld a,$19
	ld [de],a
	ret
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$1E
	ld [$FF00+$49],a
	dec hl
	ld a,$01
	ld [hli],a
	ld a,$21
	ld [hli],a
	inc hl
	inc hl
	ld a,$03
	ld [hl],a
	ld a,$ED
	add a,l
	ld l,a
	ld a,$A2
	ld [hli],a
	ld a,$0F
	ld [hli],a
	ld a,$60
	ld [hli],a
	xor a
	ld [hli],a
	ld a,$FE
	ld [hli],a
	ld a,$00
	ld [hli],a
	ld a,$F7
	ld [hli],a
	xor a
	ld [hli],a
	ld a,$01
	ld [hli],a
	ld a,$00
	ld [hl],a
	ret
	ld hl,$DC07
	set 7,[hl]
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x31437
	ld a,$02
	ld [$D245],a
	jr Logged_0x3143C

Logged_0x31437:
	ld a,$01
	ld [$D245],a

Logged_0x3143C:
	ld l,e
	ld h,d
	ld a,$0B
	ld [hli],a
	ld a,$FF
	ld [hl],a
	ld a,$F0
	add a,l
	ld l,a
	ld d,$1E
	ld bc,$A206
	jp Logged_0x31B3
	ld a,$F5
	add a,e
	ld e,a
	ld l,a
	ld h,d
	ld a,[hli]
	ld l,[hl]
	ld h,a
	ld bc,$0020
	add hl,bc
	ld a,h
	ld [de],a
	inc de
	ld a,l
	ld [de],a
	ld a,$0B
	add a,e
	ld l,a
	ld h,d
	dec [hl]
	ret nz
	ld a,$10
	ld [hld],a
	inc [hl]
	ld a,$FC
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$F7
	add a,l
	ld l,a
	ld a,$60
	ld [hli],a
	xor a
	ld [hli],a
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$FB
	add a,l
	ld l,a
	ld bc,$A200
	ld d,$09
	jp Logged_0x31B3
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	dec hl
	ld a,$06
	ld [hli],a
	ld a,$18
	ld [hli],a
	ld a,$03
	ld [hl],a
	ld a,$F7
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$02
	add a,l
	ld l,a
	res 7,[hl]
	ld a,$0C
	add a,l
	ld l,a
	ld a,$01
	ld [hli],a
	ld a,$05
	ld [hl],a
	ret
	push de
	ld a,$08
	add a,e
	ld e,a
	ld a,[de]
	and a
	jr z,Logged_0x314C1
	dec a
	ld [de],a
	ld b,$04
	jr Logged_0x314DE

Logged_0x314C1:
	ld a,$02
	call Logged_0x1331
	add a,$01
	ld [de],a
	inc de
	ld a,[de]
	and a
	jr z,Logged_0x314D4
	dec a
	ld [de],a
	ld b,$07
	jr Logged_0x314DE

Logged_0x314D4:
	ld a,$02
	call Logged_0x1331
	add a,$05
	ld [de],a
	ld b,$0C

Logged_0x314DE:
	pop hl
	ld [hl],b
	ret
	ld a,$03
	call Logged_0x1331
	ld l,e
	ld h,d
	inc [hl]
	ld bc,$0000
	bit 1,a
	jr z,Logged_0x314F3
	ld bc,$0301

Logged_0x314F3:
	and $01
	inc a
	inc hl
	inc hl
	ld [hld],a
	ld a,$11
	ld [hli],a
	inc hl
	ld [hl],c
	ld a,$F9
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld d,b
	ld bc,$A200
	jp Logged_0x31B3
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	jr nz,Logged_0x31535
	ld a,$10
	ld [hl],a
	inc hl
	dec [hl]
	dec hl
	jr nz,Logged_0x31539
	dec hl
	ld a,$06
	ld [hli],a
	ld a,$01
	ld [hli],a
	ld a,$03
	ld [hl],a
	ld a,$F3
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	res 7,[hl]
	ret

Logged_0x31535:
	ld a,[hl]
	cp $10
	ret nz

Logged_0x31539:
	inc hl
	inc hl
	ld b,[hl]
	ld a,$F0
	add a,l
	ld l,a
	ld a,b
	and a
	jr z,Logged_0x3154B
	ld a,[hli]
	cp $80
	jr z,Logged_0x31550
	jr Logged_0x3155D

Logged_0x3154B:
	ld a,[hli]
	cp $50
	jr nz,Logged_0x3155D

Logged_0x31550:
	ld a,b
	xor $01
	ld b,a
	ld a,$0F
	add a,l
	ld l,a
	ld [hl],b
	ld a,$F1
	add a,l
	ld l,a

Logged_0x3155D:
	inc hl
	ld de,$FF00
	ld c,$00
	ld a,b
	and a
	jr z,Logged_0x3156C
	ld de,$0100
	ld c,$03

Logged_0x3156C:
	ld a,d
	ld [hli],a
	ld [hl],e
	ld a,$FB
	add a,l
	ld l,a
	ld d,c
	ld bc,$A200
	jp Logged_0x31B3
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	inc hl
	ld a,[hld]
	dec hl
	ld [hl],a
	ret
	push de
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld d,[hl]
	ld e,$88
	ld bc,$0108
	call Logged_0x2F6C
	pop de
	jr nz,Logged_0x315AC
	ld a,$08
	ld [de],a
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	set 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld d,$0C
	ld bc,$A201
	jp Logged_0x31B3

Logged_0x315AC:
	ld l,e
	ld h,d
	ld a,$05
	ld [hli],a
	ld a,$11
	ld [hli],a
	ld a,$01
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	xor a
	ld [hli],a
	inc [hl]
	ld a,$F3
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld d,b
	ld bc,$A200
	jp Logged_0x31B3
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	jr nz,Logged_0x315E5
	bit 6,[hl]
	ret z
	res 7,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld a,$03
	ld [hl],a
	ret

Logged_0x315E5:
	ld a,[$DC09]
	set 0,a
	ld [$DC09],a
	res 5,[hl]
	ld a,$F7
	add a,l
	ld l,a
	ld a,[hli]
	ld b,a
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	add a,$10
	ld c,a
	push bc
	call Logged_0x3069
	push hl
	ld c,$20
	xor a
	call Logged_0x091D
	pop hl
	pop bc
	ld a,$81
	ld [hli],a
	inc hl
	inc hl
	ld [hl],b
	inc hl
	inc hl
	inc hl
	inc hl
	ld [hl],c
	ld a,$FA
	add a,l
	ld l,a
	ld d,$20
	ld bc,$A207
	jp Logged_0x31B3
	ld a,$05
	add a,e
	ld l,a
	ld h,d
	ld a,[hl]
	ld bc,$0000
	call Logged_0x3091
	ld a,[hl]
	and $7F
	cp $02
	jr nz,Logged_0x3163C
	ld a,$10
	add a,l
	ld l,a
	ld a,[hl]
	and a
	jr nz,Logged_0x3163C
	inc [hl]

Logged_0x3163C:
	ld hl,$DC09
	set 2,[hl]
	ld l,e
	ld h,d
	inc [hl]
	inc hl
	ld a,$40
	ld [hl],a
	ld a,$F2
	add a,l
	ld l,a
	ld a,[hl]
	inc a
	and $FE
	ld [hli],a
	cp $80
	jr nc,Logged_0x3165E
	xor a
	ld [hli],a
	ld a,$02
	ld [hli],a
	ld a,$00
	ld [hld],a
	dec hl

Logged_0x3165E:
	ld a,$05
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$02
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld d,$1B
	ld bc,$A205
	jp Logged_0x31B3
	ld l,e
	ld h,d
	ld a,$F3
	add a,l
	ld l,a
	ld a,[hl]
	cp $80
	ret c
	ld [hl],$80
	inc hl
	inc hl
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$0B
	add a,l
	ld l,a
	dec [hl]
	ret nz
	inc hl
	inc hl
	inc hl
	dec [hl]
	dec hl
	dec hl
	dec hl
	dec hl
	jr z,Logged_0x3169C
	ld a,$11
	ld [hl],a
	ret

Logged_0x3169C:
	ld a,$1A
	ld [hl],a
	ld hl,$D12B
	set 4,[hl]
	ret
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$13
	ld [$FF00+$91],a
	ret
	ld a,$0D
	ld [de],a
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	set 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld d,$11
	ld bc,$A202
	jp Logged_0x31B3
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	ret z
	res 6,[hl]
	ld a,$04
	add a,l
	ld l,a
	inc [hl]
	inc hl
	ld a,$30
	ld [hl],a
	ld a,$F0
	add a,l
	ld l,a
	ld d,$14
	ld bc,$A203
	jp Logged_0x31B3
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	dec hl
	inc [hl]
	ld a,$F1
	add a,l
	ld l,a
	ld d,$17
	ld bc,$A204
	jp Logged_0x31B3
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld a,$04
	add a,l
	ld l,a
	inc [hl]
	push hl
	ld a,$F3
	add a,l
	ld l,a
	ld a,[hli]
	ld b,a
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	add a,$10
	ld c,a
	push bc
	call Logged_0x3069
	ld a,b
	ld [$D24B],a
	push hl
	ld c,$20
	xor a
	call Logged_0x091D
	pop hl
	pop bc
	push hl
	ld a,$01
	ld [hli],a
	inc hl
	inc hl
	ld [hl],b
	inc hl
	inc hl
	inc hl
	inc hl
	ld [hl],c
	ld a,$FA
	add a,l
	ld l,a
	ld d,$25
	ld bc,$A208
	call Logged_0x31B3
	call Logged_0x3069
	ld a,b
	ld [$D24C],a
	ld e,l
	ld d,h
	pop hl
	push de
	ld c,$20
	call Logged_0x092B
	pop hl
	ld a,$82
	ld [hli],a
	push hl
	ld d,$2E
	ld bc,$A20B
	call Logged_0x31B3
	pop hl
	ld a,$1E
	add a,l
	ld l,a
	ld a,[$D24B]
	ld [hl],a
	pop hl
	ld a,$05
	add a,l
	ld l,a
	ld a,[$D24C]
	ld [hl],a
	ret
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	jr z,Logged_0x31780
	res 6,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld a,$14
	ld [hl],a
	ret

Logged_0x31780:
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld a,$09
	add a,l
	ld l,a
	ld a,[hl]
	ld bc,$0010
	call Logged_0x3091
	inc [hl]
	ld hl,$DC09
	set 1,[hl]
	ret
	ld l,e
	ld h,d
	inc [hl]
	inc hl
	ld a,$21
	ld [hl],a
	ld a,$F4
	add a,l
	ld l,a
	ld a,$FE
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld a,$FC
	add a,l
	ld l,a
	ld [hl],$0F
	ret
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	jr nz,Logged_0x317D7
	ld a,$20
	ld [hld],a
	inc [hl]
	ld a,$F5
	add a,l
	ld l,a
	ld a,$FF
	ld [hli],a
	ld a,$00
	ld [hli],a
	inc hl
	inc hl
	ld a,$00
	ld [hli],a
	ld a,$80
	ld [hl],a
	ld a,$F7
	add a,l
	ld l,a
	ld d,$09
	ld bc,$A200
	jp Logged_0x31B3

Logged_0x317D7:
	ld a,$F5
	add a,l
	ld l,a
	ld a,[hl]
	add a,$20
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ret
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$03
	add a,l
	ld l,a
	ld a,$04
	sub [hl]
	dec a
	swap a
	add a,$28
	ld b,a
	ld a,$F3
	add a,l
	ld l,a
	ld a,[hli]
	cp b
	jr c,Unknown_0x31819
	ld a,$08
	add a,l
	ld l,a
	ld [hl],$0C
	ld a,$F5
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$0E
	add a,l
	ld l,a
	ld a,$01
	ld [hli],a
	ld [hl],$05
	ret

Unknown_0x31819:
	dec hl
	dec hl
	dec hl
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld a,$00
	ld [hli],a
	ld a,$80
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	ld [hl],$18
	ret
	ld l,e
	ld h,d
	inc [hl]
	ld a,$F9
	add a,l
	ld l,a
	ld a,$FF
	ld [hli],a
	ld a,$80
	ld [hl],a
	ld a,$F7
	add a,l
	ld l,a
	ld d,$06
	ld bc,$A200
	jp Logged_0x31B3
	ld a,$F7
	add a,e
	ld l,a
	ld h,d
	ld a,[hli]
	cp $18
	ret nz
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	inc [hl]
	inc hl
	ld [hl],$E0
	ld a,$F0
	add a,l
	ld l,a
	ld d,$14
	ld bc,$A203
	jp Logged_0x31B3
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	dec hl
	inc [hl]
	ld a,$F9
	add a,l
	ld l,a
	ld a,$00
	ld [hli],a
	ld a,$80
	ld [hl],a
	ld a,$F7
	add a,l
	ld l,a
	ld d,$09
	ld bc,$A200
	jp Logged_0x31B3
	ld a,$04
	add a,e
	ld l,a
	ld h,d
	ld a,$04
	sub [hl]
	dec a
	swap a
	add a,$28
	ld b,a
	ld a,$F3
	add a,l
	ld l,a
	ld a,[hli]
	cp b
	ret c
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	ld [hl],$03
	ret

UnknownData_0x318A5:
INCBIN "baserom.gb", $318A5, $318BD - $318A5
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$58CE
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x318CE:
INCBIN "baserom.gb", $318CE, $318D8 - $318CE
	ld l,e
	ld h,d
	inc [hl]
	inc hl
	ld a,$10
	ld [hli],a
	inc hl
	ld a,$03
	ld [hl],a
	ld a,$F6
	add a,l
	ld l,a
	ld a,$01
	ld [hli],a
	ld a,$00
	ld [hl],a
	inc hl
	inc hl
	set 7,[hl]
	ret

Logged_0x318F2:
	push de
	call Logged_0x31309
	pop de
	and a
	jr z,Logged_0x3190F
	cp $01
	jr z,Logged_0x31978
	ld a,[$D141]
	rra
	jr c,Logged_0x3190F
	ld a,$0C
	add a,l
	ld l,a
	push de
	call Logged_0x3135C
	pop de
	jr Logged_0x31978

Logged_0x3190F:
	push de
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld d,[hl]
	inc hl
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$0E
	add a,l
	ld l,a
	ld a,[hl]
	call Logged_0x31162
	pop bc
	jr nc,Logged_0x3193F
	bit 2,a
	jr z,Logged_0x3193F
	ld d,a
	ld a,$10
	add a,l
	ld l,a
	bit 6,d
	jr z,Logged_0x3193B
	ld a,[hl]
	cp $0B
	jr z,Logged_0x3193B
	ld a,$09
	ld [hl],a

Logged_0x3193B:
	ld e,c
	ld d,b
	jr Logged_0x31978

Logged_0x3193F:
	ld l,c
	ld h,b
	inc hl
	dec [hl]
	ret nz
	ld a,$10
	ld [hl],a
	ld a,$F2
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	push hl
	push de
	ld a,$03
	call Logged_0x3122
	pop de
	pop hl
	jr c,Unknown_0x319CF
	push hl
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	call Logged_0x301A
	push de
	ld bc,$010A
	call Logged_0x2F6C
	pop bc
	pop hl
	ret z
	bit 3,a
	jr nz,Logged_0x319AF

Logged_0x31973:
	ld a,$09
	add a,l
	ld e,a
	ld d,h

Logged_0x31978:
	ld l,e
	ld h,d
	ld a,$02
	ld [hli],a
	ld a,$11
	sub [hl]
	ld b,a
	xor a
	ld [hli],a
	ld [hl],b
	inc hl
	push hl
	ld a,[hl]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$43DA
	add hl,bc
	pop de
	ld a,$F2
	add a,e
	ld e,a
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	inc de
	inc de
	ld a,[hli]
	ld [de],a
	inc de
	ld a,[hl]
	ld [de],a
	ld a,$F7
	add a,e
	ld l,a
	ld h,d
	ld d,$20
	ld bc,$A20A
	jp Logged_0x31B3

Logged_0x319AF:
	push hl
	inc hl
	inc hl
	inc hl
	call Logged_0x30C0A
	pop hl
	and a
	jr z,Logged_0x31973
	inc hl
	inc hl
	inc hl
	xor a
	ld [hld],a
	ld [hld],a
	dec hl
	dec hl
	ld [hld],a
	ld [hl],a
	ld a,$0B
	add a,l
	ld l,a
	ld a,$04
	ld [hli],a
	ld a,$10
	ld [hl],a
	ret

Unknown_0x319CF:
	ld a,$F9
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ret
	inc de
	call Logged_0x30D30
	ret nc
	ld l,e
	ld h,d
	ld a,$40
	ld [hli],a
	ld a,$10
	ld [hld],a
	dec hl
	ld a,$03
	ld [hl],a
	ld a,$F3
	add a,l
	ld l,a
	ld b,[hl]
	inc hl
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$15
	add a,l
	ld l,a
	ld [hl],b
	ld a,$ED
	add a,l
	ld l,a
	res 7,[hl]
	ret
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$04
	ld [hli],a
	dec [hl]
	jr nz,Logged_0x31A13
	ld a,$EE
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ret

Logged_0x31A13:
	ld a,[hl]
	rra
	jr c,Logged_0x31A22
	ld a,$0D
	add a,l
	ld l,a
	ld b,[hl]
	ld a,$E4
	add a,l
	ld l,a
	ld [hl],b
	ret

Logged_0x31A22:
	ld a,$F1
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ret
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	push hl
	ld a,$F2
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	call Logged_0x2FA4
	ld a,[hl]
	or $40
	ld [hl],a
	pop hl
	ld a,$05
	add a,l
	ld l,a
	ld d,[hl]
	inc hl
	ld e,[hl]
	ld a,$FC
	add a,l
	ld l,a
	ld [hl],d
	ld a,$EE
	add a,l
	ld l,a
	ld [hl],e
	inc hl
	ld a,$20
	ld [hl],a
	ld a,d
	add a,a
	add a,a
	add a,d
	add a,d
	push hl
	ld c,a
	ld b,$00
	ld hl,$5A98
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$01
	add a,l
	ld l,a
	ld a,[de]
	add a,[hl]
	ld [hli],a
	inc hl
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	add a,[hl]
	ld [hli],a
	inc hl
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc hl
	set 7,[hl]
	ld a,$04
	add a,l
	ld l,a
	push hl
	ld a,$01
	ld [hli],a
	ld [hl],a
	ld a,$FC
	add a,l
	ld l,a
	ld c,$07
	call Logged_0x31C3
	pop de
	jp Logged_0x318F2

LoggedData_0x31A98:
INCBIN "baserom.gb", $31A98, $31AAA - $31A98

UnknownData_0x31AAA:
INCBIN "baserom.gb", $31AAA, $31AB0 - $31AAA
	push de
	ld a,$10
	add a,e
	ld e,a
	call Logged_0x31309
	pop de
	cp $02
	jr c,Logged_0x31ACC
	ld a,[$D141]
	rra
	jr c,Logged_0x31ACC
	ld a,$0C
	add a,l
	ld l,a
	push de
	call Logged_0x3135C
	pop de

Logged_0x31ACC:
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5ADD
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x31ADD:
INCBIN "baserom.gb", $31ADD, $31AE7 - $31ADD
	ret
	ld l,e
	ld h,d
	inc [hl]
	ld a,$FC
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld d,$2E
	ld bc,$A20B
	jp Logged_0x31B3
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	jr z,Logged_0x31B1A
	res 7,[hl]
	ld a,$05
	add a,l
	ld l,a
	ld a,$20
	ld [hli],a
	ld a,$04
	ld [hld],a
	dec hl
	inc [hl]
	ld a,$F7
	add a,l
	ld l,a
	inc [hl]
	ret

Logged_0x31B1A:
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld a,$FB
	add a,l
	ld l,a
	inc [hl]
	ld a,$18
	add a,l
	ld l,a
	ld a,[hl]
	ld bc,$0007
	call Logged_0x3091
	inc [hl]
	ret
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$08
	ld [hli],a
	ld a,[$FF00+$49]
	xor $07
	ld [$FF00+$49],a
	dec [hl]
	ret nz
	dec hl
	dec hl
	inc [hl]
	ld a,$FC
	add a,l
	ld l,a
	set 7,[hl]
	set 4,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld d,$27
	ld bc,$A209
	push hl
	call Logged_0x31B3
	pop hl
	ld a,$1E
	add a,l
	ld l,a
	ld a,[hl]
	ld bc,$0000
	call Logged_0x3091
	xor a
	ld [hl],a
	ld b,$08
	ld a,[$D141]
	rra
	jr c,Logged_0x31B71
	ld b,$10

Logged_0x31B71:
	ld hl,$DC07
	ld a,[hl]
	or b
	ld [hl],a
	ret
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	ret z
	res 5,[hl]
	ld hl,$C15A
	ld a,$06
	ld [hli],a
	ld a,$01
	ld [hl],a
	ret
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5B9D
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x31B9D:
INCBIN "baserom.gb", $31B9D, $31BB1 - $31B9D
	ld l,e
	ld h,d
	inc hl
	inc hl
	ld b,$01
	ld a,[hli]
	rla
	jr nc,Logged_0x31BC8
	ld a,$01
	ld [hli],a
	xor a
	ld [hld],a
	dec hl
	dec hl
	dec hl
	ld [hl],$03
	jp Logged_0x31EEB

Logged_0x31BC8:
	ld a,$01
	ld [hli],a
	xor a
	ld [hld],a
	dec hl
	dec hl
	dec hl
	ld [hl],$01
	push de
	call Logged_0x31309
	pop de
	and a
	jr z,Logged_0x31C51
	push hl
	push de
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	call Logged_0x2FA4
	pop de
	ld a,[hl]
	pop hl
	cp $10
	jr z,Logged_0x31C51
	ld a,[$D141]
	rra
	jr c,Logged_0x31C51
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	cp $10
	jr z,Logged_0x31C51
	push de
	push de
	ld a,[$D141]
	and $08
	ld b,a
	ld a,[$D16A]
	or b
	ld b,a
	ld a,[$D16B]
	or b
	jr nz,Logged_0x31C18
	push de
	call Logged_0x31360
	pop de

Logged_0x31C18:
	push de
	ld a,$0F
	add a,e
	ld e,a
	ld a,[de]
	bit 2,a
	pop de
	jr z,Logged_0x31C27
	pop de
	pop de
	jr Logged_0x31C51

Logged_0x31C27:
	call Logged_0x321F0
	pop hl
	inc hl
	push hl
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	ld d,a
	ld c,$00
	pop hl
	ld a,$F0
	add a,l
	ld l,a
	ld b,$93
	call Logged_0x31B3
	pop de
	ld a,$0F
	add a,e
	ld l,a
	ld h,d
	set 2,[hl]
	jp Logged_0x31D21

Logged_0x31C51:
	ld a,$0F
	add a,e
	ld l,a
	ld h,d
	bit 7,[hl]
	jr z,Logged_0x31C9B
	res 7,[hl]
	set 2,[hl]
	push hl
	ld a,$F2
	add a,l
	ld l,a
	ld e,a
	ld d,h
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$5E63
	add hl,bc
	ld b,[hl]
	pop hl
	dec de
	dec hl
	ld a,[hl]
	and b
	jr z,Logged_0x31C97
	push hl
	push de
	call Logged_0x321F0
	pop hl
	inc hl
	push hl
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	ld d,a
	ld c,$00
	pop hl
	ld a,$F0
	add a,l
	ld l,a
	ld b,$93
	call Logged_0x31B3
	pop hl

Logged_0x31C97:
	inc hl
	jp Logged_0x31D21

Logged_0x31C9B:
	bit 5,[hl]
	jp z,Logged_0x31D21
	res 5,[hl]
	ld a,$F2
	add a,l
	ld l,a
	ld b,[hl]
	push hl
	ld a,$F2
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld hl,$5CF0
	push hl
	ld a,b
	rst JumpList
	dw Logged_0x31CC0
	dw Logged_0x31CCE
	dw Logged_0x31CD9
	dw Logged_0x31CE7

Logged_0x31CC0:
	ld a,e
	add a,$08
	ld b,a
	and $0F
	ret z
	ld a,b
	and $F0
	add a,$08
	ld e,a
	ret

Logged_0x31CCE:
	ld a,d
	and $0F
	ret z
	ld a,d
	and $F0
	add a,$10
	ld d,a
	ret

Logged_0x31CD9:
	ld a,e
	add a,$08
	ld b,a
	and $0F
	ret z
	ld a,b
	and $F0
	sub $08
	ld e,a
	ret

Logged_0x31CE7:
	ld a,d
	and $0F
	ret z
	ld a,d
	and $F0
	ld d,a
	ret
	ld bc,$0280
	call Logged_0x2F6C
	pop hl
	jr z,Logged_0x31D1D
	push hl
	ld e,l
	ld d,h
	dec de
	push hl
	call Logged_0x321F0
	pop hl
	push hl
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	ld d,a
	ld c,$00
	pop hl
	ld a,$F0
	add a,l
	ld l,a
	ld b,$93
	call Logged_0x31B3
	pop hl

Logged_0x31D1D:
	ld a,$0E
	add a,l
	ld l,a

Logged_0x31D21:
	ld a,$F4
	add a,l
	ld l,a
	dec [hl]
	ret nz
	ld a,$20
	ld [hl],a
	ld a,$F0
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	push hl
	push de
	call Logged_0x2FA4
	ld a,[hl]
	pop de
	pop hl
	cp $10
	jr z,Logged_0x31D92
	ld a,$0A
	add a,l
	ld l,a
	push hl
	push de
	ld a,[hl]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5E47
	add hl,bc
	ld a,[hli]
	add a,d
	ld d,a
	ld a,[hl]
	add a,e
	ld e,a
	ld bc,$0280
	call Logged_0x2F6C
	ld a,d
	ld [$D24B],a
	pop de
	pop hl
	jr z,Logged_0x31DC7
	ld a,$F4
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$09
	add a,l
	ld l,a
	ld a,$01
	ld [hld],a
	dec hl
	ld a,[hl]
	xor $02
	ld [hl],a
	ld a,$0E
	add a,l
	ld l,a
	bit 2,[hl]
	ret z
	res 2,[hl]
	ld a,$F5
	add a,l
	ld l,a
	ld a,$01
	ld [hld],a
	ld a,$80
	ld [hld],a
	dec hl
	dec hl
	ld [hl],$09
	ret

Logged_0x31D92:
	ld a,$0A
	add a,l
	ld l,a

Logged_0x31D96:
	ld a,[hl]
	push hl
	push af
	inc hl
	inc hl
	ld a,$20
	ld [hld],a
	dec hl
	dec hl
	ld [hl],$02
	ld a,$F5
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	pop af
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,[hl]
	add a,$28
	ld d,a
	ld c,$02
	pop hl
	ld a,$F0
	add a,l
	ld l,a
	ld b,$93
	jp Logged_0x31B3

Logged_0x31DC7:
	ld a,[$D24B]
	cp $10
	jr nz,Logged_0x31DFC
	dec hl
	ld a,$06
	ld [hli],a
	ld a,[hli]
	inc hl
	ld [hl],$01
	push hl
	push af
	ld a,$F2
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	pop af
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	ld d,a
	ld c,$04
	pop hl
	ld a,$EE
	add a,l
	ld l,a
	ld b,$93
	jp Logged_0x31B3

Logged_0x31DFC:
	push hl
	ld a,[hl]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5E56
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$F9
	add a,l
	ld l,a
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hld],a
	dec de
	dec hl
	dec hl
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hl],a
	push hl
	ld a,$07
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$05
	add a,l
	ld l,a
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	ld d,a
	ld c,$00
	pop hl
	dec hl
	dec hl
	dec hl
	dec hl
	ld b,$93
	jp Logged_0x31B3

UnknownData_0x31E3F:
INCBIN "baserom.gb", $31E3F, $31E47 - $31E3F

LoggedData_0x31E47:
INCBIN "baserom.gb", $31E47, $31E67 - $31E47
	ld l,e
	ld h,d
	inc hl
	inc hl
	inc hl
	dec [hl]
	ret nz
	ld a,$ED
	add a,l
	ld l,a
	push hl
	push hl
	call Logged_0x307D
	ld e,l
	ld d,h
	pop hl
	push de
	ld c,$20
	call Logged_0x092B
	pop hl
	pop de
	xor a
	ld [de],a
	ld a,$10
	add a,l
	ld l,a
	ld a,$03
	ld [hli],a
	inc hl
	inc hl
	ld [hl],$21
	inc hl
	ld [hl],$00
	ld a,$EF
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$0A
	add a,l
	ld l,a
	push hl
	ld b,[hl]
	ld c,$02

Logged_0x31EA4:
	push bc
	push de
	ld a,b
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5E47
	add hl,bc
	ld a,[hli]
	add a,d
	ld d,a
	ld a,[hl]
	add a,e
	ld e,a
	call Logged_0x2FBC
	pop de
	pop bc
	ld a,[hl]
	cp $43
	jp z,Logged_0x32004
	cp $11
	jr c,Logged_0x31ED8
	cp $20
	jr nc,Logged_0x31ED8
	push af
	push bc
	ld a,b
	ld c,a
	ld b,$00
	ld hl,$5EE7
	add hl,bc
	pop bc
	pop af
	and [hl]
	jp nz,Logged_0x32004

Logged_0x31ED8:
	ld a,b
	xor $02
	ld b,a
	dec c
	jr nz,Logged_0x31EA4
	pop hl
	ld a,[hl]
	xor $02
	ld [hl],a
	jp Logged_0x31FD3

LoggedData_0x31EE7:
INCBIN "baserom.gb", $31EE7, $31EEB - $31EE7

Logged_0x31EEB:
	push de
	call Logged_0x31309
	pop de
	and a
	jr z,Logged_0x31F4B
	ld a,[$D141]
	rra
	jr nc,Logged_0x31F4B
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	cp $10
	jr z,Logged_0x31F4B
	push de
	push de
	ld a,[$D141]
	and $08
	ld b,a
	ld a,[$D16A]
	or b
	ld b,a
	ld a,[$D16B]
	or b
	jr nz,Logged_0x31F1A
	push de
	call Logged_0x31360
	pop de

Logged_0x31F1A:
	push de
	ld a,$0F
	add a,e
	ld e,a
	ld a,[de]
	bit 2,a
	pop de
	jr z,Logged_0x31F29
	pop de
	pop de
	jr Logged_0x31F4B

Logged_0x31F29:
	call Logged_0x321F0
	pop hl
	inc hl
	push hl
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	add a,$14
	ld d,a
	ld c,$00
	pop hl
	ld a,$F0
	add a,l
	ld l,a
	ld b,$93
	call Logged_0x31B3
	pop de

Logged_0x31F4B:
	ld a,$03
	add a,e
	ld l,a
	ld h,d
	dec [hl]
	ret nz
	ld a,$20
	ld [hl],a
	ld a,$F0
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	push hl
	push de
	call Logged_0x2FA4
	ld a,[hl]
	pop de
	pop hl
	cp $10
	jr z,Logged_0x31FCF
	ld a,$0A
	add a,l
	ld l,a
	push hl
	ld b,[hl]
	ld c,$02
	push de
	call Logged_0x2FBC
	ld a,[hl]
	ld [$D24B],a
	pop de

Logged_0x31F7C:
	push bc
	push de
	ld a,b
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5E47
	add hl,bc
	ld a,[hli]
	add a,d
	ld d,a
	ld a,[hl]
	add a,e
	ld e,a
	ld bc,$0280
	call Logged_0x2F88
	ld a,d
	pop de
	pop bc
	jr nz,Logged_0x31FBB
	cp $43
	jr z,Logged_0x31FAB
	push af
	push bc
	ld a,b
	ld c,a
	ld b,$00
	ld hl,$5EE7
	add hl,bc
	pop bc
	pop af
	and [hl]
	jr z,Logged_0x31FBB

Logged_0x31FAB:
	push bc
	ld a,b
	ld c,a
	ld b,$00
	ld hl,$605C
	add hl,bc
	pop bc
	ld a,[$D24B]
	and [hl]
	jr nz,Logged_0x32004

Logged_0x31FBB:
	ld a,b
	xor $02
	ld b,a
	dec c
	jr nz,Logged_0x31F7C
	pop hl
	ld a,$F4
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret

Logged_0x31FCF:
	ld a,$0A
	add a,l
	ld l,a

Logged_0x31FD3:
	ld a,[hli]
	push hl
	push af
	inc hl
	ld a,$20
	ld [hld],a
	dec hl
	dec hl
	ld [hl],$05
	ld a,$F5
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	pop af
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	add a,$14
	ld d,a
	ld c,$05
	pop hl
	ld a,$EF
	add a,l
	ld l,a
	ld b,$93
	jp Logged_0x31B3

Logged_0x32004:
	pop hl
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	and a
	jr nz,Logged_0x32012
	inc [hl]
	dec hl
	dec hl
	dec hl
	jr Logged_0x32018

Logged_0x32012:
	dec hl
	dec hl
	dec hl
	ld a,[hl]
	cp b
	ret z

Logged_0x32018:
	ld [hl],b
	push bc
	push hl
	ld a,b
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5E56
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$F9
	add a,l
	ld l,a
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hld],a
	dec de
	dec hl
	dec hl
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hl],a
	pop bc
	push hl
	ld a,$07
	add a,l
	ld l,a
	set 7,[hl]
	ld a,b
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	add a,$14
	ld d,a
	ld c,$01
	pop hl
	dec hl
	dec hl
	dec hl
	dec hl
	ld b,$93
	jp Logged_0x31B3

LoggedData_0x3205C:
INCBIN "baserom.gb", $3205C, $32060 - $3205C
	ld l,e
	ld h,d
	inc hl
	inc hl
	inc hl
	dec [hl]
	ret nz
	ld a,$F0
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$0A
	add a,l
	ld l,a
	push hl
	ld b,[hl]
	inc hl
	ld a,[hl]
	ld [$D24C],a
	ld c,$02

Logged_0x3207E:
	push bc
	push de
	ld a,b
	add a,a
	ld c,a
	ld b,$00
	ld hl,$5E47
	add hl,bc
	ld a,[hli]
	add a,d
	ld d,a
	ld a,[hl]
	add a,e
	ld e,a
	ld bc,$0280
	call Logged_0x2F6C
	pop de
	pop bc
	jr z,Logged_0x320B3
	ld a,b
	xor $02
	ld b,a
	dec c
	jr nz,Logged_0x3207E
	pop hl
	dec hl
	ld a,$07
	ld [hli],a
	inc hl
	inc hl
	ld a,$10
	ld [hl],a
	ld a,$F2
	add a,l
	ld l,a
	ld a,$FE
	ld [hl],a
	jr Logged_0x320DE

Logged_0x320B3:
	pop hl
	ld [hl],b
	dec hl
	ld a,$08
	ld [hli],a
	ld a,[hl]
	inc hl
	inc hl
	ld [hl],$10
	push hl
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$617A
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$F7
	add a,l
	ld l,a
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hld],a
	dec hl
	dec hl
	dec de
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hl],a
	dec [hl]
	dec [hl]

Logged_0x320DE:
	ld a,[$DC09]
	set 6,a
	ld [$DC09],a
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	push hl
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,a
	add a,[hl]
	ld d,a
	ld c,$00
	pop hl
	ld a,$F0
	add a,l
	ld l,a
	ld b,$93
	jp Logged_0x31B3
	ld l,e
	ld h,d
	inc hl
	inc hl
	inc hl
	dec [hl]
	ret nz
	ld a,$ED
	add a,l
	ld l,a
	push hl
	push hl
	call Logged_0x3069
	ld e,l
	ld d,h
	pop hl
	push de
	ld c,$20
	call Logged_0x092B
	pop hl
	pop de
	xor a
	ld [de],a
	ld a,$10
	add a,l
	ld l,a
	ld a,$04
	ld [hli],a
	ld a,[hli]
	inc hl
	ld [hl],$40
	push hl
	ld c,a
	ld b,$00
	ld hl,$5E4F
	add hl,bc
	ld a,[hl]
	add a,a
	add a,[hl]
	add a,$34
	ld d,a
	ld c,$03
	pop hl
	ld a,$EE
	add a,l
	ld l,a
	ld b,$93
	jp Logged_0x31B3
	ld l,e
	ld h,d
	inc hl
	inc hl
	inc hl
	dec [hl]
	ret nz
	ld a,$10
	ld [hld],a
	push hl
	dec hl
	dec hl
	ld a,$07
	ld [hli],a
	ld a,[hl]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$617A
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$F8
	add a,l
	ld l,a
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hld],a
	dec hl
	dec hl
	dec de
	ld a,[de]
	ld [hld],a
	dec de
	ld a,[de]
	ld [hl],a
	dec [hl]
	dec [hl]
	ret

LoggedData_0x32177:
INCBIN "baserom.gb", $32177, $32187 - $32177
	ld a,$F6
	add a,e
	ld l,a
	ld h,d
	ld a,[hl]
	add a,$40
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ld a,$0E
	add a,l
	ld l,a
	dec [hl]
	ret nz
	ld a,[$DC05]
	set 2,a
	ld [$DC05],a
	ld a,$F0
	add a,l
	ld l,a
	inc [hl]
	inc [hl]
	ld a,$0E
	add a,l
	ld l,a
	jp Logged_0x31D96
	ld a,$F6
	add a,e
	ld l,a
	ld h,d
	ld a,[hl]
	add a,$40
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ld a,$0E
	add a,l
	ld l,a
	dec [hl]
	ret nz
	ld a,$F0
	add a,l
	ld l,a
	inc [hl]
	inc [hl]
	inc hl
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	ld a,$01
	ld [hli],a
	inc hl
	inc hl
	ld a,$01
	ld [hli],a
	xor a
	ld [hl],a
	ret
	ld l,e
	ld h,d
	inc hl
	inc hl
	inc hl
	dec [hl]
	ret nz
	ld [hl],$01
	inc hl
	ld a,[hld]
	dec hl
	dec hl
	dec hl
	ld [hl],a
	ret

Logged_0x321F0:
	ld l,e
	ld h,d
	inc hl
	bit 0,[hl]
	jr z,Logged_0x321FF
	ld a,$F4
	add a,l
	ld l,a
	ld b,$0C
	jr Logged_0x32205

Logged_0x321FF:
	ld a,$F8
	add a,l
	ld l,a
	ld b,$08

Logged_0x32205:
	ld a,[hli]
	cpl
	ld d,a
	ld a,[hl]
	cpl
	ld e,a
	inc de
	ld a,e
	ld [hld],a
	ld [hl],d
	ld a,b
	add a,l
	ld l,a
	ld a,[hl]
	xor $02
	ld [hli],a
	inc hl
	ld a,[hl]
	cp $01
	ret z
	sub $20
	cpl
	inc a
	add a,$02
	ld [hl],a
	ret
	push de
	ld a,$10
	add a,e
	ld e,a
	call Logged_0x32AC1
	jr nc,Logged_0x3223A
	ld a,[$D141]
	rra
	jr c,Logged_0x3223A
	ld a,$0C
	add a,l
	ld l,a
	call Logged_0x3135C

Logged_0x3223A:
	pop de
	push de
	ld hl,$6273
	push hl
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6251
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x32251:
INCBIN "baserom.gb", $32251, $32273 - $32251
	pop hl
	ld a,$1F
	add a,l
	ld l,a
	res 6,[hl]
	ret
	ld a,$01
	ld [$C1A3],a
	ld hl,$DC08
	set 2,[hl]
	ld a,$03
	ld [de],a
	ld a,$F1
	add a,e
	ld l,a
	ld h,d
	ld a,$AA
	ld [hli],a
	ld a,$11
	ld [hli],a
	ld a,$E0
	ld [hli],a
	inc hl
	ld a,$02
	ld [hli],a
	ld a,$00
	ld [hli],a
	ld a,$48
	ld [hl],a
	push hl
	call Logged_0x3069
	pop de
	ld a,$0C
	add a,e
	ld e,a
	ld a,b
	ld [de],a
	ld bc,$F048
	ld de,$62CC
	call Logged_0x309F
	push hl
	call Logged_0x3069
	pop de
	ld a,$0C
	add a,e
	ld e,a
	ld a,b
	ld [de],a
	ld bc,$4048
	ld de,$62C8
	jp Logged_0x309F

LoggedData_0x322C8:
INCBIN "baserom.gb", $322C8, $322DE - $322C8
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[hli]
	cp $60
	ret nc
	cp $40
	ret c
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld a,$0A
	add a,l
	ld l,a
	ld a,$02
	ld [hli],a
	inc hl
	inc hl
	ld a,[hl]
	swap a
	add a,a
	ld l,a
	ld h,$00
	ld bc,$C200
	add hl,bc
	ld [hl],$00
	ld a,[$FF00+$42]
	add a,$02
	ld [$FF00+$42],a
	ld hl,$DC05
	set 0,[hl]
	ret
	ret
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[hld]
	cp $60
	ret nc
	cp $45
	ret c
	dec hl
	dec hl
	ld [hl],$00
	ld a,$13
	add a,l
	ld l,a
	ld a,[hl]
	swap a
	ld l,a
	ld h,$00
	add hl,hl
	ld bc,$C202
	add hl,bc
	ld [hl],$01
	ld a,$0E
	add a,l
	ld l,a
	ld a,$0F
	ld [hli],a
	ld a,$A0
	ld [hli],a
	ld [hl],$00
	ld a,$09
	add a,l
	ld l,a
	ld [hl],$01
	ld a,$F1
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$01
	add a,l
	ld l,a
	ld c,$05
	call Logged_0x31C3
	ld a,[$FF00+$42]
	add a,$02
	ld [$FF00+$42],a
	ld hl,$DC05
	set 0,[hl]
	ret
	ld a,$0F
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	jp nz,Logged_0x329C0
	ld a,$F2
	add a,l
	ld l,a
	dec [hl]
	ret nz
	dec hl
	ld [hl],$05
	ld a,$FC
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$0E
	add a,l
	ld l,a
	ld a,[hl]
	push hl
	ld c,a
	ld b,$00
	ld hl,$6391
	add hl,bc
	ld d,[hl]
	pop hl
	ld a,$E7
	add a,l
	ld l,a
	ld bc,$AA00
	jp Logged_0x31B3

LoggedData_0x32391:
INCBIN "baserom.gb", $32391, $32394 - $32391
	ld a,$0F
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	jp nz,Logged_0x329C0
	ld a,$ED
	add a,l
	ld l,a
	bit 6,[hl]
	ret z
	ld a,$F7
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$0B
	add a,l
	ld l,a
	push hl
	ld b,[hl]
	ld c,$04

Logged_0x323B7:
	push bc
	push de
	ld a,b
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6497
	add hl,bc
	ld a,[hli]
	add a,d
	ld d,a
	ld a,[hl]
	add a,e
	ld e,a
	ld bc,$02C0
	call Logged_0x2F6C
	jr z,Logged_0x323E0
	bit 6,a
	jr nz,Logged_0x323E0
	pop de
	pop bc
	ld a,b
	inc a
	and $03
	ld b,a
	dec c
	jr nz,Logged_0x323B7
	pop hl
	ret

Logged_0x323E0:
	pop de
	pop bc
	pop hl
	ld [hl],b
	dec hl
	dec hl
	ld a,$06
	ld [hli],a
	ld [hl],$41
	push hl
	push de
	push bc
	ld a,$09
	add a,l
	ld l,a
	ld a,[hl]
	push hl
	ld c,a
	ld b,$00
	ld hl,$6494
	add hl,bc
	ld d,[hl]
	pop hl
	ld a,$FF
	add a,l
	ld l,a
	ld [hl],d
	ld a,$E8
	add a,l
	ld l,a
	ld bc,$AA01
	call Logged_0x31B3
	pop bc
	pop de
	pop hl
	ld a,$07
	add a,l
	ld l,a
	push hl
	ld a,b
	add a,a
	add a,a
	add a,b
	add a,b
	ld c,a
	ld b,$00
	ld hl,$649F
	add hl,bc
	ld c,e
	ld b,d
	ld e,l
	ld d,h
	pop hl
	xor a
	ld [hld],a
	ld [hld],a
	ld [hld],a
	ld a,[$DC09]
	set 6,a
	ld [$DC09],a

Logged_0x32431:
	push hl
	push de
	push bc
	ld a,[de]
	ld [hld],a
	inc de
	ld a,[de]
	ld [hl],a
	inc de
	ld a,$F6
	add a,l
	ld l,a
	ld a,[de]
	ld [hld],a
	inc de
	ld a,[de]
	ld [hl],a
	dec hl
	dec hl
	dec hl
	inc de
	ld a,[de]
	ld [hld],a
	inc de
	ld a,[de]
	ld [hl],a
	ld a,$1A
	add a,l
	ld l,a
	set 0,[hl]
	ld a,$FB
	add a,l
	ld l,a
	ld a,[hli]
	ld [$D24C],a
	ld [hl],$00
	call Logged_0x3069
	ld a,b
	ld [$D24B],a
	ld a,$01
	ld [hli],a
	ld a,$AA
	ld [hli],a
	ld a,[$D24C]
	add a,$25
	ld [hli],a
	pop bc
	pop de
	ld a,b
	ld [hli],a
	xor a
	ld [hli],a
	inc hl
	ld a,[de]
	ld [hld],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	ld a,c
	ld [hli],a
	xor a
	ld [hli],a
	inc hl
	ld a,[de]
	ld [hld],a
	inc de
	ld a,[de]
	ld [hl],a
	inc hl
	inc hl
	inc hl
	res 7,[hl]
	pop hl
	dec hl
	dec hl
	ld a,[$D24B]
	ld [hl],a
	ret

LoggedData_0x32494:
INCBIN "baserom.gb", $32494, $324B7 - $32494
	ld a,$F6
	add a,e
	ld l,a
	ld h,d
	ld a,[hld]
	add a,$10
	ld e,a
	ld a,[hl]
	adc a,$00
	ld d,a
	or e
	jr nz,Logged_0x324D3
	push hl
	ld a,$14
	add a,l
	ld l,a
	ld b,[hl]
	ld a,$E9
	add a,l
	ld l,a
	ld [hl],b
	pop hl

Logged_0x324D3:
	ld a,d
	bit 7,a
	jr nz,Logged_0x324DF
	cp $02
	jr c,Logged_0x324DF
	ld de,$0200

Logged_0x324DF:
	ld a,d
	ld [hli],a
	ld a,e
	ld [hld],a
	ld a,$0C
	add a,l
	ld l,a
	dec [hl]
	jr z,Logged_0x32508
	ld a,$F3
	add a,l
	ld l,a
	ld a,[hld]
	ld e,a
	ld a,[hli]
	ld d,a
	push hl
	ld a,$13
	add a,l
	ld l,a
	ld a,[hld]
	add a,e
	ld e,a
	ld a,[hld]
	adc a,d
	ld d,a
	ld a,[hld]
	add a,e
	ld e,a
	ld a,[hl]
	adc a,d
	ld d,a
	pop hl
	ld a,e
	ld [hld],a
	ld [hl],d
	ret

Logged_0x32508:
	ld a,$07
	add a,l
	ld e,a
	ld d,h
	ld a,[de]
	rst JumpList
	dw Logged_0x32519
	dw Logged_0x325FA
	dw Logged_0x32634
	dw Logged_0x3266A
	dw Logged_0x32683

Logged_0x32519:
	ld a,$FA
	add a,e
	ld l,a
	ld h,d
	push hl
	ld a,$04
	call Logged_0x1331
	and $03
	pop hl
	ld [hld],a
	ld a,$10
	ld [hld],a
	ld [hl],$04
	push hl
	push hl
	ld a,$0A
	add a,l
	ld l,a
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$66B3
	add hl,bc
	ld d,[hl]
	pop hl
	ld a,$F1
	add a,l
	ld l,a
	ld bc,$AA00
	call Logged_0x31B3
	pop hl
	ld a,$0B
	add a,l
	ld l,a
	ld [hl],$01
	ld a,$F1
	add a,l
	ld l,a
	res 7,[hl]
	ld a,[$FF00+$42]
	inc a
	ld [$FF00+$42],a
	ld a,[$DC0A]
	set 4,a
	ld [$DC0A],a

Logged_0x32561:
	ld a,$F7
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,[hli]
	ld e,a
	push de
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld a,$15
	add a,l
	ld l,a
	res 0,[hl]
	ld a,$F4
	add a,l
	ld l,a
	ld a,[hl]
	swap a
	ld l,a
	ld h,$00
	add hl,hl
	ld bc,$C200
	add hl,bc
	ld [hl],$00
	pop de
	push de
	ld bc,$0240
	call Logged_0x2F6C
	pop de
	ret z
	push de
	ld a,$04
	call Logged_0x1331
	and $03
	ld [$D24B],a
	pop de

Logged_0x3259F:
	push de
	call Logged_0x3007
	push de
	srl d
	srl e
	call Logged_0x2FD4
	ld a,[hli]
	ld [$D24C],a
	ld a,[hld]
	ld [hl],a
	pop bc
	call Logged_0x26C2
	pop de
	push de
	call Logged_0x3069
	push hl
	ld c,$20
	xor a
	call Logged_0x091D
	pop hl
	push hl
	ld a,$15
	add a,l
	ld l,a
	ld [hl],b
	pop hl
	ld a,$80
	ld [hli],a
	inc hl
	inc hl
	pop de
	ld a,d
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld a,e
	ld [hl],a
	ld a,$09
	add a,l
	ld l,a
	ld a,$0B
	ld [hli],a
	inc hl
	inc hl
	ld a,[$D24B]
	ld [hli],a
	ld a,[$D24C]
	ld [hl],a
	ld a,$04
	add a,l
	ld l,a
	set 1,[hl]
	ld a,$E9
	add a,l
	ld l,a
	ld b,$80
	ld c,$00
	ld d,$00
	jp Logged_0x31B3

Logged_0x325FA:
	ld a,$EB
	add a,e
	ld l,a
	ld h,d
	ld a,[hl]
	sub $10
	ld [hl],a
	ld a,$09
	add a,l
	ld l,a
	set 7,[hl]
	push hl
	ld a,$0E
	add a,l
	ld l,a
	push hl
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$670F
	add hl,bc
	ld d,[hl]
	pop hl
	ld a,$F6
	add a,l
	ld l,a
	ld [hl],$08
	ld a,$0B
	add a,l
	ld l,a
	ld [hl],$01
	ld a,$E6
	add a,l
	ld l,a
	ld b,$AA
	ld c,$03
	call Logged_0x31B3
	pop hl
	jp Logged_0x32561

Logged_0x32634:
	ld a,$F8
	add a,e
	ld l,a
	ld h,d
	ld a,$0A
	ld [hli],a
	ld [hl],$20
	push hl
	ld a,$FC
	add a,l
	ld l,a
	ld c,$01
	call Logged_0x31C3
	pop hl
	inc hl
	ld d,[hl]
	ld a,$08
	add a,l
	ld l,a
	ld a,[hli]
	push hl
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$66B9
	add hl,bc
	ld c,d
	ld b,$00
	add hl,bc
	ld d,[hl]
	pop hl
	ld [hl],d
	ld a,$F1
	add a,l
	ld l,a
	set 7,[hl]
	jp Logged_0x32561

Logged_0x3266A:
	ld a,$F8
	add a,e
	ld l,a
	ld h,d
	ld a,$0C
	ld [hli],a
	ld [hl],$20
	ld a,$0A
	add a,l
	ld l,a
	ld [hl],$01
	ld a,$F1
	add a,l
	ld l,a
	res 7,[hl]
	jp Logged_0x32561

Logged_0x32683:
	ld a,$F8
	add a,e
	ld l,a
	ld h,d
	ld a,$04
	ld [hli],a
	ld [hl],$20
	ld a,$09
	add a,l
	ld l,a
	ld a,[hl]
	push hl
	ld c,a
	ld b,$00
	ld hl,$66B6
	add hl,bc
	ld b,[hl]
	pop hl
	ld a,$E7
	add a,l
	ld l,a
	ld a,$AA
	ld [hli],a
	ld [hl],b
	ld a,$19
	add a,l
	ld l,a
	ld [hl],$01
	ld a,$F1
	add a,l
	ld l,a
	res 7,[hl]
	jp Logged_0x32561

LoggedData_0x326B3:
INCBIN "baserom.gb", $326B3, $326B6 - $326B3

UnknownData_0x326B6:
INCBIN "baserom.gb", $326B6, $326B7 - $326B6

LoggedData_0x326B7:
INCBIN "baserom.gb", $326B7, $326B9 - $326B7

UnknownData_0x326B9:
INCBIN "baserom.gb", $326B9, $326BD - $326B9

LoggedData_0x326BD:
INCBIN "baserom.gb", $326BD, $326C5 - $326BD
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	ret z
	ld a,$0E
	add a,l
	ld l,a
	ld a,[hl]
	cp $02
	jr c,Logged_0x326F3
	ld a,[$C1A3]
	dec a
	ld [$C1A3],a
	jr nz,Logged_0x326EC
	ld a,$F6
	add a,l
	ld l,a
	ld a,$10
	ld [hl],a
	ld hl,$D12B
	set 4,[hl]
	ret

Logged_0x326EC:
	ld a,$E6
	add a,l
	ld l,a
	ld [hl],$00
	ret

Logged_0x326F3:
	push hl
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$670F
	add hl,bc
	ld d,[hl]
	pop hl
	ld a,$F6
	add a,l
	ld l,a
	ld [hl],$08
	ld a,$F1
	add a,l
	ld l,a
	ld b,$AA
	ld c,$03
	jp Logged_0x31B3

LoggedData_0x3270F:
INCBIN "baserom.gb", $3270F, $32711 - $3270F

UnknownData_0x32711:
INCBIN "baserom.gb", $32711, $32712 - $32711
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 6,[hl]
	ret z
	ld a,$04
	add a,l
	ld l,a
	ld [hl],$09
	ld a,$0A
	add a,l
	ld l,a
	inc [hl]
	ret
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld b,$00
	ld a,[hli]
	cp $40
	jr c,Logged_0x32751
	inc b
	inc b
	cp $70
	jr nc,Logged_0x32751
	inc b
	inc b
	inc hl
	inc hl
	inc hl
	ld a,[hl]
	cp $38
	jr c,Logged_0x32759
	inc b
	cp $78
	jr nc,Logged_0x32759
	push hl
	ld a,$06
	call Logged_0x1331
	ld b,a
	pop hl
	jr Logged_0x32759

Logged_0x32751:
	inc hl
	inc hl
	inc hl
	cp $58
	jr c,Logged_0x32759
	inc b

Logged_0x32759:
	ld a,b
	ld [$D24B],a
	ld e,l
	ld d,h
	ld a,$13
	add a,l
	ld l,a
	ld a,[hl]
	rst JumpList
	dw Unknown_0x3276B
	dw Logged_0x32770
	dw Logged_0x32775

Unknown_0x3276B:
	ld hl,$67BF
	jr Logged_0x32778

Logged_0x32770:
	ld hl,$67D1
	jr Logged_0x32778

Logged_0x32775:
	ld hl,$67E3

Logged_0x32778:
	push de
	ld a,[$D24B]
	ld c,a
	add a,a
	add a,c
	ld c,a
	ld b,$00
	add hl,bc
	ld a,$FA
	add a,e
	ld e,a
	ld a,$A9
	ld [de],a
	inc de
	ld a,[hli]
	ld [de],a
	ld a,$10
	add a,e
	ld e,a
	ld a,[hli]
	ld [de],a
	ld a,$07
	add a,e
	ld e,a
	ld a,[hl]
	ld [de],a
	pop hl
	ld a,[hld]
	ld c,a
	dec hl
	dec hl
	dec hl
	ld b,[hl]
	ld a,$09
	add a,l
	ld l,a
	res 7,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld a,$06
	ld [hli],a
	ld [hl],$21
	ld de,$67F5
	ld a,$07
	add a,l
	ld l,a
	ld a,$02
	ld [hld],a
	xor a
	ld [hld],a
	ld [hld],a
	jp Logged_0x32431

UnknownData_0x327BF:
INCBIN "baserom.gb", $327BF, $327D1 - $327BF

LoggedData_0x327D1:
INCBIN "baserom.gb", $327D1, $327D4 - $327D1

UnknownData_0x327D4:
INCBIN "baserom.gb", $327D4, $327D7 - $327D4

LoggedData_0x327D7:
INCBIN "baserom.gb", $327D7, $327FB - $327D7
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	jr z,Logged_0x3280E
	res 5,[hl]
	ld a,[$DC04]
	set 4,a
	ld [$DC04],a

Logged_0x3280E:
	ld a,$05
	add a,l
	ld l,a
	dec [hl]
	ret nz
	push hl
	ld a,$01
	ld [hli],a
	push hl
	ld a,[hl]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6849
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$F3
	add a,l
	ld l,a
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc hl
	inc hl
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	ld [hl],$0B
	ld a,$FD
	add a,l
	ld l,a
	ld c,$00
	call Logged_0x31C3
	pop hl
	jr Logged_0x32870

LoggedData_0x32849:
INCBIN "baserom.gb", $32849, $32859 - $32849
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	bit 5,[hl]
	jr z,Logged_0x3286C
	res 5,[hl]
	ld a,[$DC04]
	set 4,a
	ld [$DC04],a

Logged_0x3286C:
	ld a,$05
	add a,l
	ld l,a

Logged_0x32870:
	dec [hl]
	ret nz
	ld a,$10
	ld [hli],a
	ld b,[hl]
	ld a,$F1
	add a,l
	ld l,a
	push hl
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,b
	call Logged_0x301A
	push de
	ld bc,$02C0
	call Logged_0x2F6C
	pop de
	pop hl
	ret z
	bit 6,a
	jr z,Logged_0x3289E
	ld a,$0F
	add a,l
	ld l,a
	ld a,[hl]
	ld [$D24B],a
	jp Logged_0x3259F

Logged_0x3289E:
	ld a,[$FF00+$42]
	add a,$02
	ld [$FF00+$42],a
	ld a,[$DC06]
	set 1,a
	ld [$DC06],a
	push hl
	ld a,$0A
	add a,l
	ld l,a
	ld c,$00
	call Logged_0x31C3
	pop hl
	dec hl
	ld b,[hl]
	ld a,$17
	add a,l
	ld l,a
	ld [hl],b
	ld a,$EA
	add a,l
	ld l,a
	ld a,[hli]
	ld b,a
	inc hl
	inc hl
	inc hl
	ld c,[hl]
	ld a,$09
	add a,l
	ld l,a
	ld a,$06
	ld [hli],a
	ld [hl],$21
	ld de,$68E1
	ld a,$07
	add a,l
	ld l,a
	ld a,$03
	ld [hld],a
	xor a
	ld [hld],a
	ld [hld],a
	jp Logged_0x32431

LoggedData_0x328E1:
INCBIN "baserom.gb", $328E1, $328E7 - $328E1
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	push hl
	ld a,$09
	add a,l
	ld l,a
	ld a,[hl]
	ld c,a
	ld b,$00
	ld hl,$6923
	add hl,bc
	ld b,[hl]
	pop hl
	ld a,$08
	add a,l
	ld l,a
	ld [hl],b
	ld a,$EA
	add a,l
	ld l,a
	ld a,[hli]
	ld b,a
	inc hl
	inc hl
	inc hl
	ld c,[hl]
	ld a,$09
	add a,l
	ld l,a
	ld a,$06
	ld [hli],a
	ld [hl],$21
	ld de,$6926
	ld a,$07
	add a,l
	ld l,a
	ld a,$04
	ld [hld],a
	xor a
	ld [hld],a
	ld [hld],a
	jp Logged_0x32431

UnknownData_0x32923:
INCBIN "baserom.gb", $32923, $32924 - $32923

LoggedData_0x32924:
INCBIN "baserom.gb", $32924, $3292C - $32924
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$EF
	add a,l
	ld l,a
	ld [hl],$00
	ld a,$13
	ld [$FF00+$91],a
	ret
	ld l,e
	ld h,d
	ld a,$06
	ld [hli],a
	ld [hl],$21
	ld a,$FB
	add a,l
	ld l,a
	ld [hl],$00
	ld a,$0C
	add a,l
	ld l,a
	push hl
	ld a,$FA
	add a,l
	ld l,a
	ld a,[hl]
	add a,a
	ld b,a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$696F
	add hl,bc
	ld c,e
	ld b,d
	ld e,l
	ld d,h
	pop hl
	ld a,$01
	ld [hld],a
	ld a,$80
	ld [hld],a
	ld a,$00
	ld [hld],a
	jp Logged_0x32431

LoggedData_0x3296F:
INCBIN "baserom.gb", $3296F, $32987 - $3296F
	ld l,e
	ld h,d
	inc hl
	dec [hl]
	ret nz
	ld a,$08
	ld [hld],a
	ld [hl],$04
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	res 7,[hl]
	ret
	ld hl,$DC07
	set 7,[hl]
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x329AC
	ld a,$02
	ld [$D245],a
	jr Logged_0x329B1

Logged_0x329AC:
	ld a,$01
	ld [$D245],a

Logged_0x329B1:
	ld l,e
	ld h,d
	ld a,$0D
	ld [hli],a
	ld a,$FF
	ld [hl],a
	ld a,$F2
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ret

Logged_0x329C0:
	ld a,$E4
	add a,l
	ld l,a
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	push de
	ld a,$05
	add a,l
	ld l,a
	set 7,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld [hl],$07
	ld a,$0A
	add a,l
	ld l,a
	ld a,[hl]
	push hl
	push hl
	ld c,a
	ld b,$00
	ld hl,$6AB3
	add hl,bc
	ld d,[hl]
	pop hl
	ld a,$E7
	add a,l
	ld l,a
	ld b,$AA
	ld c,$02
	call Logged_0x31B3
	pop hl
	ld a,[hl]
	cp $02
	jr c,Logged_0x32A05
	pop de
	ld a,[$C1A3]
	cp $01
	ret z
	ld hl,$DC09
	set 2,[hl]
	ret

Logged_0x32A05:
	ld [$D24D],a
	ld hl,$DC0A
	set 1,[hl]
	ld a,$04
	call Logged_0x1331
	and $03
	ld [$D24C],a
	pop de
	ld c,$04

Logged_0x32A1A:
	push bc
	push de
	ld a,[$D24C]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6AB9
	add hl,bc
	ld a,[hli]
	add a,d
	ld d,a
	ld a,[hld]
	add a,e
	ld e,a
	ld bc,$02C0
	push hl
	push de
	call Logged_0x2F6C
	pop de
	pop hl
	jr z,Logged_0x32A3D
	bit 6,a
	jr z,Logged_0x32A4F

Logged_0x32A3D:
	ld a,[hli]
	add a,d
	ld d,a
	ld a,[hld]
	add a,e
	ld e,a
	ld bc,$02C0
	call Logged_0x2F6C
	jr z,Logged_0x32A5F
	bit 6,a
	jr nz,Logged_0x32A5F

Logged_0x32A4F:
	pop de
	pop bc
	ld a,[$D24C]
	inc a
	and $03
	ld [$D24C],a
	dec c
	jr nz,Logged_0x32A1A
	pop hl
	ret

Logged_0x32A5F:
	ld hl,$C1A3
	inc [hl]
	call Logged_0x3069
	ld a,$A9
	ld [hli],a
	push hl
	ld bc,$AA00
	ld d,$12
	call Logged_0x31B3
	pop hl
	pop de
	pop bc
	inc hl
	push hl
	ld a,$18
	add a,l
	ld l,a
	ld a,[$D24D]
	ld [hl],a
	ld c,a
	ld b,$00
	ld hl,$6AB6
	add hl,bc
	ld c,[hl]
	pop hl
	ld a,[$D24C]
	and $01
	add a,c
	ld [hli],a
	push af
	ld a,$16
	add a,l
	ld l,a
	pop af
	ld [hl],a
	ld a,$EA
	add a,l
	ld l,a
	ld a,d
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,e
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld a,$08
	add a,l
	ld l,a
	ld a,[$D24C]
	ld [hl],a
	dec hl
	dec hl
	ld [hl],$0E
	ret

LoggedData_0x32AB3:
INCBIN "baserom.gb", $32AB3, $32AB8 - $32AB3

UnknownData_0x32AB8:
INCBIN "baserom.gb", $32AB8, $32AB9 - $32AB8

LoggedData_0x32AB9:
INCBIN "baserom.gb", $32AB9, $32AC1 - $32AB9

Logged_0x32AC1:
	ld a,[$D142]
	bit 3,a
	jr nz,Logged_0x32B1F
	ld a,[$D141]
	bit 3,a
	jr nz,Logged_0x32B1F
	ld hl,$D16B
	ld a,[$D16A]
	or [hl]
	jr nz,Logged_0x32B1F
	ld a,$0B
	add a,e
	ld e,a
	ld a,[de]
	and a
	jr z,Logged_0x32B1F
	dec a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6B21
	add hl,bc
	ld a,$E8
	add a,e
	ld e,a
	ld a,[de]
	sub [hl]
	ld b,a
	inc hl
	ld a,$04
	add a,e
	ld e,a
	ld a,[de]
	sub [hl]
	ld c,a
	inc hl
	ld de,$C223
	ld a,[$D141]
	rla
	jr c,Logged_0x32B06
	ld de,$C423

Logged_0x32B06:
	ld a,[de]
	sub b
	ld b,a
	jr c,Logged_0x32B1F
	cp [hl]
	jr nc,Logged_0x32B1F
	inc de
	inc de
	inc de
	inc de
	inc hl
	ld a,[de]
	sub c
	ld c,a
	jr c,Logged_0x32B1F
	cp [hl]
	jr nc,Logged_0x32B1F
	ld l,e
	ld h,d
	scf
	ret

Logged_0x32B1F:
	and a
	ret

LoggedData_0x32B21:
INCBIN "baserom.gb", $32B21, $32B25 - $32B21

UnknownData_0x32B25:
INCBIN "baserom.gb", $32B25, $32B31 - $32B25

LoggedData_0x32B31:
INCBIN "baserom.gb", $32B31, $32B3D - $32B31
	ld a,$10
	add a,e
	ld e,a
	ld a,[de]
	rst JumpList
	dw Logged_0x32B4B
	dw Logged_0x32CC4
	dw Logged_0x32DA1
	dw Logged_0x32E77

Logged_0x32B4B:
	ld a,$01
	ld [de],a
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[hli]
	ld d,a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	push de
	ld b,$00
	ld a,d
	cp $50
	jr c,Logged_0x32B63
	inc b
	inc b

Logged_0x32B63:
	ld a,e
	cp $50
	jr c,Logged_0x32B69
	inc b

Logged_0x32B69:
	ld a,b
	ld [$D24B],a
	pop de
	ld a,[$CEB8]
	cp $02
	jr c,Logged_0x32BF3
	push de
	push hl
	ld a,[$D24B]
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6C94
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$FE
	add a,l
	ld l,a
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	pop de
	ld a,[$D24B]
	add a,a
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$6CA4
	add hl,bc
	push hl
	push de
	push hl
	push de
	call Logged_0x3069
	pop bc
	ld de,$6C82
	call Logged_0x309F
	pop bc
	dec hl
	dec hl
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hli],a
	inc bc
	inc hl
	inc hl
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ld a,$03
	add a,l
	ld l,a
	ld c,$00
	call Logged_0x31C3
	call Logged_0x3069
	pop bc
	ld de,$6C82
	call Logged_0x309F
	pop bc
	inc bc
	inc bc
	inc bc
	inc bc
	dec hl
	dec hl
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hli],a
	inc bc
	inc hl
	inc hl
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ld a,$03
	add a,l
	ld l,a
	ld c,$00
	jp Logged_0x31C3

Logged_0x32BF3:
	ld a,$FE
	add a,l
	ld l,a
	ld b,$01
	ld a,[$C223]
	sub d
	jr nc,Logged_0x32C02
	cpl
	inc a
	dec b

Logged_0x32C02:
	ld d,a
	set 1,b
	ld a,[$C227]
	sub e
	jr nc,Logged_0x32C0F
	cpl
	inc a
	res 1,b

Logged_0x32C0F:
	ld e,a
	cp d
	jr nc,Logged_0x32C42
	push de
	ld de,$0100
	bit 0,b
	jr nz,Logged_0x32C1E
	ld de,$FF00

Logged_0x32C1E:
	ld a,d
	ld [hli],a
	ld a,e
	ld [hli],a
	pop de
	push hl
	push bc
	ld h,e
	ld l,$00
	ld b,d
	call Logged_0x32D9
	pop bc
	bit 1,b
	jr nz,Logged_0x32C38
	ld a,l
	cpl
	ld l,a
	ld a,h
	cpl
	ld h,a
	inc hl

Logged_0x32C38:
	ld e,l
	ld d,h
	pop hl
	inc hl
	inc hl
	ld a,d
	ld [hli],a
	ld [hl],e
	jr Logged_0x32C79

Logged_0x32C42:
	inc hl
	inc hl
	inc hl
	inc hl
	push de
	ld de,$0100
	bit 1,b
	jr nz,Logged_0x32C51
	ld de,$FF00

Logged_0x32C51:
	ld a,d
	ld [hli],a
	ld a,e
	ld [hld],a
	pop de
	push hl
	push bc
	ld h,d
	ld l,$00
	ld b,e
	call Logged_0x32D9
	pop bc
	bit 0,b
	jr nz,Logged_0x32C6B
	ld a,l
	cpl
	ld l,a
	ld a,h
	cpl
	ld h,a
	inc hl

Logged_0x32C6B:
	ld e,l
	ld d,h
	pop hl
	dec hl
	dec hl
	dec hl
	ld a,e
	ld [hld],a
	ld a,d
	ld [hli],a
	inc hl
	inc hl
	inc hl
	inc hl

Logged_0x32C79:
	ld a,$07
	add a,l
	ld l,a
	ld a,[$CEBB]
	ld [hl],a
	ret

LoggedData_0x32C82:
INCBIN "baserom.gb", $32C82, $32CC4 - $32C82

Logged_0x32CC4:
	push de
	call Logged_0x338AB
	pop hl
	jp nc,Logged_0x32D3D
	ld a,[$DC03]
	set 5,a
	ld [$DC03],a
	ld a,[$D141]
	and $40
	ld b,a
	ld a,[$D16A]
	or b
	jr nz,Logged_0x32D03
	push hl
	ld a,$F7
	add a,l
	ld l,a
	ld b,$00
	ld a,[$C227]
	cp [hl]
	jr c,Logged_0x32CEE
	inc b

Logged_0x32CEE:
	ld hl,$D142
	ld a,[hl]
	or b
	ld [hl],a
	ld a,$10
	ld [$C233],a
	xor a
	ld [$C23B],a
	ld hl,$C234
	set 5,[hl]
	pop hl

Logged_0x32D03:
	inc hl
	inc hl
	ld a,$10
	sub [hl]
	inc a
	and $0F
	inc hl
	ld [hld],a
	and a
	jr nz,Logged_0x32D17
	ld a,$F3
	add a,l
	ld l,a
	jp Logged_0x32D8A

Logged_0x32D17:
	dec hl
	ld a,[hl]
	push hl
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$737E
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$F4
	add a,l
	ld l,a
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a
	jr Logged_0x32D95

Logged_0x32D3D:
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[hli]
	ld d,a
	inc hl
	ld a,[hli]
	ld b,a
	ld [$D24C],a
	inc hl
	ld a,[hli]
	ld e,a
	inc hl
	ld a,[hl]
	ld c,a
	ld [$D24B],a
	ld a,e
	add a,$08
	and $0F
	jr z,Logged_0x32D6C
	ld a,e
	add a,$08
	and $F0
	ld e,a
	bit 7,c
	jr nz,Logged_0x32D68
	ld a,e
	add a,$10
	ld e,a

Logged_0x32D68:
	ld a,e
	sub $08
	ld e,a

Logged_0x32D6C:
	ld a,d
	and $0F
	jr z,Logged_0x32D7D
	ld a,d
	and $F0
	ld d,a
	bit 7,b
	jr nz,Logged_0x32D7D
	ld a,d
	add a,$10
	ld d,a

Logged_0x32D7D:
	push hl
	ld bc,$0210
	call Logged_0x2F6C
	pop hl
	ret z
	ld a,$FC
	add a,l
	ld l,a

Logged_0x32D8A:
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$06
	add a,l
	ld l,a

Logged_0x32D95:
	ld a,$02
	ld [hli],a
	inc hl
	xor a
	ld [hl],a
	ld hl,$DC04
	set 6,[hl]
	ret

Logged_0x32DA1:
	inc de
	inc de
	ld a,[de]
	cp $10
	jr nc,Logged_0x32DCF
	add a,a
	ld b,a
	dec de
	ld a,[de]
	swap a
	add a,a
	add a,b
	ld c,a
	ld b,$00
	ld hl,$6DF7
	add hl,bc
	ld a,$F2
	add a,e
	ld e,a
	ld a,[de]
	add a,[hl]
	ld [de],a
	ld b,a
	inc hl
	ld a,$04
	add a,e
	ld e,a
	ld a,[de]
	add a,[hl]
	ld [de],a
	ld c,a
	ld a,$0B
	add a,e
	ld e,a
	ld a,[de]
	inc a
	ld [de],a

Logged_0x32DCF:
	ld l,e
	ld h,d
	inc hl
	ld a,[hl]
	and a
	jr z,Logged_0x32DE4
	dec [hl]
	ret nz
	ld a,$F2
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret

Logged_0x32DE4:
	dec hl
	ld a,[hl]
	cp $10
	ret c
	ld a,$FE
	add a,l
	ld l,a
	ld a,$03
	ld [hl],a
	ld a,$FC
	add a,l
	ld l,a
	res 7,[hl]
	ret

LoggedData_0x32DF7:
INCBIN "baserom.gb", $32DF7, $32E77 - $32DF7

Logged_0x32E77:
	ld a,$F0
	add a,e
	ld e,a
	xor a
	ld [de],a
	ret

Logged_0x32E7E:
	ld hl,$C15A
	ld a,[hli]
	and a
	ret z
	ld bc,$6ED8
	ld a,[$D141]
	rra
	jr c,Logged_0x32EA0
	push hl
	dec hl
	ld a,[hl]
	cp $03
	jr nz,Logged_0x32E9C
	ld hl,$C233
	ld c,$01
	call Logged_0x3135C

Logged_0x32E9C:
	pop hl
	ld bc,$6ECC

Logged_0x32EA0:
	dec [hl]
	dec hl
	jr nz,Logged_0x32EB9
	dec [hl]
	ld a,[hli]
	ld e,l
	ld d,h
	add a,a
	ld l,a
	ld h,$00
	add hl,bc
	ld a,[hli]
	ld [de],a
	ld a,[hl]
	ld [$C15E],a
	ld hl,$C15C
	set 1,[hl]
	ret

Logged_0x32EB9:
	ld a,[hli]
	ld e,l
	ld d,h
	add a,a
	ld l,a
	ld h,$00
	add hl,bc
	inc hl
	ld a,[hl]
	ld [$C15E],a
	ld hl,$C15C
	set 1,[hl]
	ret

LoggedData_0x32ECC:
INCBIN "baserom.gb", $32ECC, $32EE4 - $32ECC

Logged_0x32EE4:
	ld a,$14
	add a,l
	ld l,a
	ld a,[hl]
	ld [$D24B],a
	ld a,[$C223]
	ld d,a
	ld a,[$C227]
	ld e,a
	ld a,[$D17B]
	push bc
	call Logged_0x301A
	pop bc
	push de
	push de
	push bc
	call Logged_0x2FA4
	ld a,[hl]
	cp $68
	jr c,Logged_0x32F0B
	cp $80
	jr c,Logged_0x32F0D

Logged_0x32F0B:
	inc hl
	ld [hld],a

Logged_0x32F0D:
	pop bc
	ld a,[$D24B]
	ld [hl],a
	pop de
	push hl
	call Logged_0x3007
	ld c,e
	ld b,d
	ld a,[$D24B]
	call Logged_0x26C2
	ld hl,$C240
	ld de,$0020
	ld c,$0E

Logged_0x32F27:
	ld a,[hl]
	cp $80
	jr z,Logged_0x32F34
	cp $90
	jr c,Logged_0x32F3C
	cp $A0
	jr nc,Logged_0x32F3C

Logged_0x32F34:
	push hl
	ld a,$1F
	add a,l
	ld l,a
	set 5,[hl]
	pop hl

Logged_0x32F3C:
	add hl,de
	dec c
	jr nz,Logged_0x32F27
	xor a
	ld [$D179],a
	pop hl
	pop bc
	ret

UnknownData_0x32F47:
INCBIN "baserom.gb", $32F47, $32FFE - $32F47
	ld l,e
	ld h,d
	ld a,$0C
	add a,l
	ld l,a
	bit 5,[hl]
	ret z
	ld a,$F7
	add a,l
	ld l,a
	ld d,[hl]
	inc hl
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	push hl
	push de
	call Logged_0x2F0A
	ld a,[$C430]
	and $02
	rrca
	add a,$22
	ld [hl],a
	pop de
	call Logged_0x2FF4
	push de
	call Logged_0x3047
	pop de
	ld a,$04
	ld [hli],a
	ld [hl],d
	inc hl
	ld [hl],e
	inc hl
	xor a
	ld [hli],a
	pop de
	ld a,$09
	add a,e
	ld e,a
	ld a,[de]
	and $02
	rrca
	ld [hl],a
	ld a,$F0
	add a,e
	ld e,a
	ld a,$01
	ld [de],a
	ret
	push de
	ld a,$11
	add a,e
	ld e,a
	ld a,[de]
	cp $09
	jr z,Logged_0x33076
	ld a,$F2
	add a,e
	ld e,a
	ld hl,$D184
	ld a,[hli]
	and a
	jr z,Logged_0x33076
	ld hl,$D185
	ld a,[de]
	sub $0A
	cp [hl]
	jr nc,Logged_0x33076
	add a,$14
	cp [hl]
	jr c,Logged_0x33076
	ld a,$04
	add a,e
	ld e,a
	inc hl
	ld a,[de]
	sub $0A
	cp [hl]
	jr nc,Logged_0x33076
	add a,$14
	cp [hl]
	jr nc,Unknown_0x3309C

Logged_0x33076:
	pop de
	ld a,$11
	add a,e
	ld e,a
	ld a,[de]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$7088
	add hl,bc
	ld a,[hli]
	ld h,[hl]
	ld l,a
	jp hl

LoggedData_0x33088:
INCBIN "baserom.gb", $33088, $3308C - $33088

UnknownData_0x3308C:
INCBIN "baserom.gb", $3308C, $3308E - $3308C

LoggedData_0x3308E:
INCBIN "baserom.gb", $3308E, $33092 - $3308E

UnknownData_0x33092:
INCBIN "baserom.gb", $33092, $33096 - $33092

LoggedData_0x33096:
INCBIN "baserom.gb", $33096, $3309C - $33096

Unknown_0x3309C:
	pop hl
	ld a,$01
	ld [hli],a
	ld bc,$1B00
	push hl
	ld d,$00
	call Logged_0x31AF
	pop hl
	ld a,$04
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hli],a
	inc hl
	ld a,$90
	ld [hl],a
	ld e,l
	ld d,h
	ld hl,$D128
	dec [hl]
	jr nz,Unknown_0x330F2
	ld hl,$C231
	ld a,[$D141]
	rla
	jr c,Unknown_0x330CD
	ld hl,$C431

Unknown_0x330CD:
	ld a,$40
	ld [hli],a
	inc hl
	ld a,$03
	ld [hli],a
	set 5,[hl]
	ld a,$F1
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,[$D179]
	and a
	ret z
	ld hl,$D17D
	ld a,$0B
	add a,e
	ld e,a
	ld a,[de]
	cp [hl]
	ret nz
	jr Unknown_0x33169

Unknown_0x330F2:
	ld a,[$D179]
	and a
	ret z
	ld hl,$D17D
	ld a,$0B
	add a,e
	ld e,a
	ld a,[de]
	cp [hl]
	ret nz
	ld hl,$D179
	xor a
	ld c,$09
	call Logged_0x091D
	ld hl,$C235
	res 3,[hl]
	ld a,$03
	ld [$C23C],a
	ld a,[$C233]
	cp $10
	ret z
	cp $01
	jr nz,Unknown_0x33137
	ld hl,$C237
	ld a,[hl]
	and a
	jr z,Unknown_0x33137
	ld hl,$C234
	set 5,[hl]
	ld a,$09
	ld [$C233],a
	xor a
	ld [$C237],a
	ld [$C23B],a
	ret

Unknown_0x33137:
	ld a,[$C233]
	cp $04
	jr z,Unknown_0x3318A
	cp $0D
	jr nz,Unknown_0x33149
	ld hl,$D141
	res 3,[hl]
	jr Unknown_0x3314D

Unknown_0x33149:
	cp $0F
	jr nz,Unknown_0x33172

Unknown_0x3314D:
	xor a
	ld [$C233],a
	ld a,[$D141]
	bit 2,a
	jr z,Unknown_0x33172
	ld a,$04
	ld [$C233],a
	ld a,$01
	ld [$C23A],a
	ld hl,$C22C
	res 7,[hl]
	jr Unknown_0x3318A

Unknown_0x33169:
	ld a,[$D141]
	bit 2,a
	jr nz,Unknown_0x3318A
	jr Unknown_0x33177

Unknown_0x33172:
	ld hl,$C234
	res 5,[hl]

Unknown_0x33177:
	xor a
	ld [$C237],a
	ld hl,$C221
	ld a,[$C23D]
	add a,$24
	ld b,a
	xor a
	ld c,a
	ld d,a
	jp Logged_0x31AF

Unknown_0x3318A:
	ld hl,$C221
	ld a,[$C23D]
	add a,$58
	ld b,a
	ld c,$00
	ld d,$09
	jp Logged_0x31AF

UnknownData_0x3319A:
INCBIN "baserom.gb", $3319A, $331F8 - $3319A
	ld a,[de]
	inc a
	ld [de],a
	ld a,$07
	add a,e
	ld l,a
	ld h,d
	bit 7,[hl]
	jr z,Logged_0x3324B
	push hl
	ld a,[$C223]
	ld d,a
	ld a,[$C227]
	ld e,a
	ld a,[$C23D]
	call Logged_0x301A
	pop hl
	ld a,$E8
	add a,l
	ld l,a
	push hl
	push de
	ld bc,$0140
	call Logged_0x2EDD
	pop de
	pop hl
	jr z,Logged_0x3322B
	xor a
	ld [$D179],a
	jp Logged_0x3359D

Logged_0x3322B:
	inc hl
	inc hl
	xor a
	ld [hl],a
	ld [$D179],a
	ld a,$0F
	add a,l
	ld l,a
	ld a,$09
	ld [hl],a
	push de
	call Logged_0x2F0A
	ld a,$20
	ld [hl],a
	pop de
	call Logged_0x2FF4
	ld c,e
	ld b,d
	ld a,$20
	jp Logged_0x271A

Logged_0x3324B:
	ld a,$F2
	add a,e
	ld e,a
	ld hl,$D17E
	ld a,[$C223]
	add a,[hl]
	ld [de],a
	inc de
	inc de
	inc de
	inc de
	inc hl
	ld a,[$C227]
	add a,[hl]
	ld [de],a
	ret

UnknownData_0x33262:
INCBIN "baserom.gb", $33262, $33263 - $33262
	push de
	ld a,$F2
	add a,e
	ld l,a
	ld h,d
	ld a,[$C203]
	ld b,a
	sub $0E
	cp [hl]
	jr nc,Logged_0x332E4
	ld a,$0E
	add a,b
	cp [hl]
	jr c,Logged_0x332E4
	ld a,$04
	add a,l
	ld l,a
	ld a,[$C207]
	ld b,a
	sub $0E
	cp [hl]
	jr nc,Logged_0x332E4
	ld a,$0E
	add a,b
	cp [hl]
	jr c,Logged_0x332E4

Logged_0x3328B:
	ld a,[$C213]
	cp $0A
	jr z,Logged_0x332A5
	ld hl,$C214
	set 0,[hl]
	ld a,$0A
	ld [$C213],a
	xor a
	ld [$C21B],a
	ld hl,$DC05
	set 3,[hl]

Logged_0x332A5:
	pop hl
	ld a,$03
	add a,l
	ld l,a
	ld a,$10
	sub [hl]
	inc a
	and $0F
	inc hl
	ld [hld],a
	and a
	jr nz,Logged_0x332BC
	ld a,$F1
	add a,l
	ld l,a
	jp Logged_0x33361

Logged_0x332BC:
	dec hl
	dec hl
	ld a,[hl]
	push hl
	add a,a
	add a,a
	ld c,a
	ld b,$00
	ld hl,$737E
	add hl,bc
	ld e,l
	ld d,h
	pop hl
	ld a,$F3
	add a,l
	ld l,a
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hli],a
	inc de
	inc hl
	inc hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hl],a
	ld a,$0A
	add a,l
	ld l,a
	jp Logged_0x3336E

Logged_0x332E4:
	pop hl
	push hl
	ld a,$F2
	add a,l
	ld e,a
	ld d,h
	call Logged_0x31314
	and a
	jr z,Logged_0x3331A
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	cp $01
	jr nz,Logged_0x3331A
	ld a,$09
	ld [hl],a
	ld a,$08
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld d,$01
	ld a,b
	cp $10
	jr c,Unknown_0x3330B
	inc d

Unknown_0x3330B:
	set 2,d
	ld a,c
	cp $10
	jr c,Unknown_0x33316
	ld a,d
	add a,$04
	ld d,a

Unknown_0x33316:
	ld a,d
	ld [$D22B],a

Logged_0x3331A:
	pop hl
	ld a,$03
	add a,l
	ld l,a
	dec [hl]
	ret nz
	ld a,$10
	ld [hl],a
	ld a,$EF
	add a,l
	ld l,a
	ld d,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld e,[hl]
	ld a,$F9
	add a,l
	ld l,a
	push hl
	push de
	ld bc,$0140
	call Logged_0x2EDD
	pop de
	pop hl
	jp nz,Logged_0x3359D
	ld a,$12
	add a,l
	ld l,a
	ld a,[hl]
	push hl
	push af
	call Logged_0x301A
	pop af
	push de
	call Logged_0x30E0
	pop de
	pop hl
	jr c,Logged_0x3335D
	push hl
	ld bc,$0180
	call Logged_0x2EDD
	pop hl
	jr nz,Logged_0x3335D
	ret

Logged_0x3335D:
	ld a,$F3
	add a,l
	ld l,a

Logged_0x33361:
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$0B
	add a,l
	ld l,a
	xor a
	ld [hld],a

Logged_0x3336E:
	ld a,[$DC06]
	set 1,a
	ld [$DC06],a
	xor a
	ld [hld],a
	dec hl
	dec hl
	ld a,$04
	ld [hl],a
	ret

LoggedData_0x3337E:
INCBIN "baserom.gb", $3337E, $3338A - $3337E

UnknownData_0x3338A:
INCBIN "baserom.gb", $3338A, $3338E - $3338A
	push de
	ld a,$F2
	add a,e
	ld e,a
	call Logged_0x31314
	and a
	jr z,Logged_0x333C2
	ld a,$0C
	add a,l
	ld l,a
	ld a,[hl]
	cp $01
	jr nz,Logged_0x333C2
	ld a,$09
	ld [hl],a
	ld a,$08
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld d,$01
	ld a,b
	cp $10
	jr c,Unknown_0x333B3
	inc d

Unknown_0x333B3:
	set 2,d
	ld a,c
	cp $10
	jr c,Unknown_0x333BE
	ld a,d
	add a,$04
	ld d,a

Unknown_0x333BE:
	ld a,d
	ld [$D22B],a

Logged_0x333C2:
	pop de
	ld a,$03
	add a,e
	ld e,a
	ld a,[de]
	cp $10
	jr nc,Logged_0x333EC
	add a,a
	ld c,a
	ld b,$00
	ld hl,$743F
	add hl,bc
	ld a,$EF
	add a,e
	ld e,a
	ld a,[de]
	add a,[hl]
	ld [de],a
	ld b,a
	inc hl
	ld a,$04
	add a,e
	ld e,a
	ld a,[de]
	add a,[hl]
	ld [de],a
	ld c,a
	ld a,$0D
	add a,e
	ld e,a
	ld a,[de]
	inc a
	ld [de],a

Logged_0x333EC:
	ld l,e
	ld h,d
	inc hl
	ld a,[hl]
	and a
	jr z,Logged_0x33401
	dec [hl]
	ret nz
	ld a,$F0
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret

Logged_0x33401:
	dec hl
	ld a,[hl]
	cp $10
	ret c
	ld a,$EF
	add a,l
	ld l,a
	ld d,[hl]
	ld a,$04
	add a,l
	ld l,a
	ld e,[hl]
	ld a,$F9
	add a,l
	ld l,a
	push hl
	push de
	ld bc,$0140
	call Logged_0x2EDD
	pop de
	pop hl
	jp nz,Logged_0x3359D
	inc hl
	inc hl
	xor a
	ld [hl],a
	ld a,$0F
	add a,l
	ld l,a
	ld a,$09
	ld [hl],a
	push de
	call Logged_0x2FF4
	ld c,e
	ld b,d
	ld a,$20
	call Logged_0x271A
	pop de
	call Logged_0x2F0A
	ld a,$20
	ld [hl],a
	ret

LoggedData_0x3343F:
INCBIN "baserom.gb", $3343F, $3345F - $3343F

UnknownData_0x3345F:
INCBIN "baserom.gb", $3345F, $33495 - $3345F
	ld a,$07
	add a,e
	ld l,a
	ld h,d
	bit 7,[hl]
	jr z,Logged_0x334D6
	push hl
	ld a,[$C223]
	ld d,a
	ld a,[$C227]
	ld e,a
	ld a,[$C23D]
	call Logged_0x301A
	pop hl
	ld a,$E8
	add a,l
	ld l,a
	push hl
	push de
	ld bc,$0140
	call Logged_0x2EDD
	pop de
	pop hl
	jp nz,Logged_0x3359D
	ld [hl],$00
	ld [$D179],a
	push de
	call Logged_0x2F0A
	ld a,$20
	ld [hl],a
	pop de
	call Logged_0x2FF4
	ld c,e
	ld b,d
	ld a,$20
	jp Logged_0x271A

Logged_0x334D6:
	ld a,$F9
	add a,l
	ld l,a
	push hl
	ld a,[$C23D]
	add a,a
	ld c,a
	ld b,$00
	ld hl,$752E
	add hl,bc
	ld a,$F2
	add a,e
	ld e,a
	ld a,[$C223]
	add a,[hl]
	ld [de],a
	inc de
	inc de
	inc de
	inc de
	inc hl
	ld a,[$C227]
	add a,[hl]
	ld [de],a
	ld c,$0C
	ld a,[$C23D]
	and a
	jr z,Logged_0x33503
	ld c,$08

Logged_0x33503:
	ld a,$FC
	add a,e
	ld l,a
	ld h,d
	ld a,[$C203]
	ld b,a
	sub c
	cp [hl]
	jr nc,Logged_0x3352C
	ld a,$08
	add a,b
	cp [hl]
	jr c,Logged_0x3352C
	ld a,$04
	add a,l
	ld l,a
	ld a,[$C207]
	ld b,a
	sub $08
	cp [hl]
	jr nc,Logged_0x3352C
	ld a,$08
	add a,b
	cp [hl]
	jr c,Logged_0x3352C
	jp Logged_0x3328B

Logged_0x3352C:
	pop hl
	ret

LoggedData_0x3352E:
INCBIN "baserom.gb", $3352E, $33536 - $3352E
	ld l,e
	ld h,d
	inc hl
	inc hl
	inc hl
	dec [hl]
	ret nz
	ld a,[$DC09]
	or $10
	ld [$DC09],a
	ld a,$06
	add a,l
	ld l,a
	ld a,[hli]
	ld e,[hl]
	ld d,a
	ld a,$E5
	add a,l
	ld l,a
	ld a,$01
	ld [hli],a
	push hl
	inc hl
	inc hl
	ld a,d
	ld [hli],a
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	ld [hl],e
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ld a,$02
	add a,l
	ld l,a
	ld [hl],$90
	pop hl
	ld b,$1A
	xor a
	ld c,a
	ld d,a
	call Logged_0x31B3
	ld a,[$D128]
	and a
	ret nz
	ld hl,$C231
	ld a,[$D141]
	rla
	jr c,Logged_0x33581
	ld hl,$C431

Logged_0x33581:
	ld a,$40
	ld [hli],a
	inc hl
	ld a,$03
	ld [hli],a
	set 5,[hl]
	ld a,$F1
	add a,l
	ld l,a
	xor a
	ld [hli],a
	ld [hli],a
	inc hl
	inc hl
	ld [hli],a
	ld [hl],a
	ret
	ld a,$EF
	add a,e
	ld e,a
	xor a
	ld [de],a
	ret

Logged_0x3359D:
	ld a,$11
	add a,l
	ld l,a
	ld a,$08
	ld [hli],a
	inc hl
	inc hl
	ld [hl],$10
	ld a,$EF
	add a,l
	ld l,a
	ld d,[hl]
	xor a
	ld [hli],a
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	ld a,$F8
	ld [hl],a
	ld a,$13
	add a,l
	ld l,a
	ld a,d
	ld [hli],a
	ld [hl],e
	ld hl,$DC05
	set 2,[hl]
	ld a,[$D120]
	xor $01
	ld c,a
	ld b,$00
	ld hl,$D122
	add hl,bc
	inc [hl]
	ld hl,$D128
	dec [hl]
	jp Logged_0x338DA

UnknownData_0x335D6:
INCBIN "baserom.gb", $335D6, $338AB - $335D6

Logged_0x338AB:
	ld a,[$D141]
	rra
	jr c,Logged_0x338D8
	ld a,$F3
	add a,e
	ld l,a
	ld h,d
	ld a,[$C223]
	ld b,a
	sub $0A
	cp [hl]
	ret nc
	ld a,$0A
	add a,b
	cp [hl]
	jr c,Logged_0x338D8
	ld a,$04
	add a,l
	ld l,a
	ld a,[$C227]
	ld b,a
	sub $0A
	cp [hl]
	ret nc
	ld a,$0A
	add a,b
	cp [hl]
	jr c,Logged_0x338D8
	scf
	ret

Logged_0x338D8:
	and a
	ret

Logged_0x338DA:
	ld hl,$C5A2
	inc [hl]
	ret

UnknownData_0x338DF:
INCBIN "baserom.gb", $338DF, $33FAF - $338DF

Logged_0x33FAF:
	ld hl,$C922
	ld a,[hli]
	ld c,a
	ld a,[$CFDB]

Logged_0x33FB7:
	cp [hl]
	jr z,Logged_0x33FCB
	inc hl
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x33FB7
	ld a,[$C922]
	inc a
	ld [$C922],a
	ld a,[$CFDB]
	ld [hl],a

Logged_0x33FCB:
	ld a,[$CE73]
	dec a
	cp [hl]
	jr nz,Logged_0x33FDC
	ld a,[$CE53]
	rla
	jr c,Logged_0x33FDC
	xor a
	ld [$CE73],a

Logged_0x33FDC:
	inc hl
	ret

UnknownData_0x33FDE:
INCBIN "baserom.gb", $33FDE, $34000 - $33FDE

SECTION "Bank0D", ROMX, BANK[$0D]

LoggedData_0x34000:
INCBIN "baserom.gb", $34000, $34002 - $34000

UnknownData_0x34002:
INCBIN "baserom.gb", $34002, $34010 - $34002

LoggedData_0x34010:
INCBIN "baserom.gb", $34010, $34014 - $34010

UnknownData_0x34014:
INCBIN "baserom.gb", $34014, $34080 - $34014

LoggedData_0x34080:
INCBIN "baserom.gb", $34080, $34084 - $34080

UnknownData_0x34084:
INCBIN "baserom.gb", $34084, $3408E - $34084

LoggedData_0x3408E:
INCBIN "baserom.gb", $3408E, $340B8 - $3408E

UnknownData_0x340B8:
INCBIN "baserom.gb", $340B8, $340BA - $340B8

LoggedData_0x340BA:
INCBIN "baserom.gb", $340BA, $340CE - $340BA

UnknownData_0x340CE:
INCBIN "baserom.gb", $340CE, $340D0 - $340CE

LoggedData_0x340D0:
INCBIN "baserom.gb", $340D0, $340D6 - $340D0

UnknownData_0x340D6:
INCBIN "baserom.gb", $340D6, $340D8 - $340D6

LoggedData_0x340D8:
INCBIN "baserom.gb", $340D8, $340FA - $340D8

UnknownData_0x340FA:
INCBIN "baserom.gb", $340FA, $340FC - $340FA

LoggedData_0x340FC:
INCBIN "baserom.gb", $340FC, $34114 - $340FC

UnknownData_0x34114:
INCBIN "baserom.gb", $34114, $34116 - $34114

LoggedData_0x34116:
INCBIN "baserom.gb", $34116, $3414A - $34116

UnknownData_0x3414A:
INCBIN "baserom.gb", $3414A, $3414C - $3414A

LoggedData_0x3414C:
INCBIN "baserom.gb", $3414C, $34171 - $3414C

UnknownData_0x34171:
INCBIN "baserom.gb", $34171, $345A3 - $34171

LoggedData_0x345A3:
INCBIN "baserom.gb", $345A3, $346B2 - $345A3

UnknownData_0x346B2:
INCBIN "baserom.gb", $346B2, $34811 - $346B2

LoggedData_0x34811:
INCBIN "baserom.gb", $34811, $34B56 - $34811

UnknownData_0x34B56:
INCBIN "baserom.gb", $34B56, $34B58 - $34B56

LoggedData_0x34B58:
INCBIN "baserom.gb", $34B58, $34DA4 - $34B58

UnknownData_0x34DA4:
INCBIN "baserom.gb", $34DA4, $34DA8 - $34DA4

LoggedData_0x34DA8:
INCBIN "baserom.gb", $34DA8, $34DFF - $34DA8

UnknownData_0x34DFF:
INCBIN "baserom.gb", $34DFF, $34E1C - $34DFF

LoggedData_0x34E1C:
INCBIN "baserom.gb", $34E1C, $34FD1 - $34E1C

UnknownData_0x34FD1:
INCBIN "baserom.gb", $34FD1, $34FE6 - $34FD1

LoggedData_0x34FE6:
INCBIN "baserom.gb", $34FE6, $3507B - $34FE6

UnknownData_0x3507B:
INCBIN "baserom.gb", $3507B, $3507F - $3507B

LoggedData_0x3507F:
INCBIN "baserom.gb", $3507F, $350A0 - $3507F

UnknownData_0x350A0:
INCBIN "baserom.gb", $350A0, $350B1 - $350A0

LoggedData_0x350B1:
INCBIN "baserom.gb", $350B1, $350B3 - $350B1

UnknownData_0x350B3:
INCBIN "baserom.gb", $350B3, $350B7 - $350B3

LoggedData_0x350B7:
INCBIN "baserom.gb", $350B7, $350D8 - $350B7

UnknownData_0x350D8:
INCBIN "baserom.gb", $350D8, $350E9 - $350D8

LoggedData_0x350E9:
INCBIN "baserom.gb", $350E9, $3523C - $350E9

UnknownData_0x3523C:
INCBIN "baserom.gb", $3523C, $3523E - $3523C

LoggedData_0x3523E:
INCBIN "baserom.gb", $3523E, $352E8 - $3523E

UnknownData_0x352E8:
INCBIN "baserom.gb", $352E8, $35316 - $352E8

LoggedData_0x35316:
INCBIN "baserom.gb", $35316, $35336 - $35316

UnknownData_0x35336:
INCBIN "baserom.gb", $35336, $35338 - $35336

LoggedData_0x35338:
INCBIN "baserom.gb", $35338, $353D8 - $35338

UnknownData_0x353D8:
INCBIN "baserom.gb", $353D8, $35410 - $353D8

LoggedData_0x35410:
INCBIN "baserom.gb", $35410, $35460 - $35410

UnknownData_0x35460:
INCBIN "baserom.gb", $35460, $35462 - $35460

LoggedData_0x35462:
INCBIN "baserom.gb", $35462, $35CFA - $35462

UnknownData_0x35CFA:
INCBIN "baserom.gb", $35CFA, $35CFC - $35CFA

LoggedData_0x35CFC:
INCBIN "baserom.gb", $35CFC, $35DF0 - $35CFC

UnknownData_0x35DF0:
INCBIN "baserom.gb", $35DF0, $35DF2 - $35DF0

LoggedData_0x35DF2:
INCBIN "baserom.gb", $35DF2, $3603A - $35DF2

UnknownData_0x3603A:
INCBIN "baserom.gb", $3603A, $36040 - $3603A

LoggedData_0x36040:
INCBIN "baserom.gb", $36040, $360C6 - $36040

UnknownData_0x360C6:
INCBIN "baserom.gb", $360C6, $3614C - $360C6

LoggedData_0x3614C:
INCBIN "baserom.gb", $3614C, $3625C - $3614C

UnknownData_0x3625C:
INCBIN "baserom.gb", $3625C, $3625E - $3625C

LoggedData_0x3625E:
INCBIN "baserom.gb", $3625E, $36281 - $3625E

UnknownData_0x36281:
INCBIN "baserom.gb", $36281, $36283 - $36281

LoggedData_0x36283:
INCBIN "baserom.gb", $36283, $362A4 - $36283

UnknownData_0x362A4:
INCBIN "baserom.gb", $362A4, $36332 - $362A4

LoggedData_0x36332:
INCBIN "baserom.gb", $36332, $3649E - $36332

UnknownData_0x3649E:
INCBIN "baserom.gb", $3649E, $364A0 - $3649E

LoggedData_0x364A0:
INCBIN "baserom.gb", $364A0, $364DA - $364A0

UnknownData_0x364DA:
INCBIN "baserom.gb", $364DA, $364DC - $364DA

LoggedData_0x364DC:
INCBIN "baserom.gb", $364DC, $3668A - $364DC

UnknownData_0x3668A:
INCBIN "baserom.gb", $3668A, $366AE - $3668A

LoggedData_0x366AE:
INCBIN "baserom.gb", $366AE, $36C6E - $366AE

UnknownData_0x36C6E:
INCBIN "baserom.gb", $36C6E, $36C72 - $36C6E

LoggedData_0x36C72:
INCBIN "baserom.gb", $36C72, $36C93 - $36C72

UnknownData_0x36C93:
INCBIN "baserom.gb", $36C93, $36CB4 - $36C93

LoggedData_0x36CB4:
INCBIN "baserom.gb", $36CB4, $3763A - $36CB4

UnknownData_0x3763A:
INCBIN "baserom.gb", $3763A, $376E8 - $3763A

LoggedData_0x376E8:
INCBIN "baserom.gb", $376E8, $37794 - $376E8

UnknownData_0x37794:
INCBIN "baserom.gb", $37794, $37985 - $37794

LoggedData_0x37985:
INCBIN "baserom.gb", $37985, $37989 - $37985

UnknownData_0x37989:
INCBIN "baserom.gb", $37989, $3798B - $37989

LoggedData_0x3798B:
INCBIN "baserom.gb", $3798B, $3798D - $3798B

UnknownData_0x3798D:
INCBIN "baserom.gb", $3798D, $37995 - $3798D

LoggedData_0x37995:
INCBIN "baserom.gb", $37995, $37999 - $37995

UnknownData_0x37999:
INCBIN "baserom.gb", $37999, $379B9 - $37999

LoggedData_0x379B9:
INCBIN "baserom.gb", $379B9, $379BB - $379B9

UnknownData_0x379BB:
INCBIN "baserom.gb", $379BB, $37A05 - $379BB

LoggedData_0x37A05:
INCBIN "baserom.gb", $37A05, $37A09 - $37A05

UnknownData_0x37A09:
INCBIN "baserom.gb", $37A09, $37A13 - $37A09

LoggedData_0x37A13:
INCBIN "baserom.gb", $37A13, $37A29 - $37A13

UnknownData_0x37A29:
INCBIN "baserom.gb", $37A29, $37A2B - $37A29

LoggedData_0x37A2B:
INCBIN "baserom.gb", $37A2B, $37A3D - $37A2B

UnknownData_0x37A3D:
INCBIN "baserom.gb", $37A3D, $37A3F - $37A3D

LoggedData_0x37A3F:
INCBIN "baserom.gb", $37A3F, $37A53 - $37A3F

UnknownData_0x37A53:
INCBIN "baserom.gb", $37A53, $37A55 - $37A53

LoggedData_0x37A55:
INCBIN "baserom.gb", $37A55, $37A5B - $37A55

UnknownData_0x37A5B:
INCBIN "baserom.gb", $37A5B, $37A5D - $37A5B

LoggedData_0x37A5D:
INCBIN "baserom.gb", $37A5D, $37A7B - $37A5D

UnknownData_0x37A7B:
INCBIN "baserom.gb", $37A7B, $37A81 - $37A7B

LoggedData_0x37A81:
INCBIN "baserom.gb", $37A81, $37A99 - $37A81

UnknownData_0x37A99:
INCBIN "baserom.gb", $37A99, $37A9B - $37A99

LoggedData_0x37A9B:
INCBIN "baserom.gb", $37A9B, $37ACF - $37A9B

UnknownData_0x37ACF:
INCBIN "baserom.gb", $37ACF, $37AD1 - $37ACF

LoggedData_0x37AD1:
INCBIN "baserom.gb", $37AD1, $37AFB - $37AD1

UnknownData_0x37AFB:
INCBIN "baserom.gb", $37AFB, $37AFD - $37AFB

LoggedData_0x37AFD:
INCBIN "baserom.gb", $37AFD, $37B0D - $37AFD

UnknownData_0x37B0D:
INCBIN "baserom.gb", $37B0D, $37B11 - $37B0D

LoggedData_0x37B11:
INCBIN "baserom.gb", $37B11, $37B25 - $37B11

UnknownData_0x37B25:
INCBIN "baserom.gb", $37B25, $37B3D - $37B25

LoggedData_0x37B3D:
INCBIN "baserom.gb", $37B3D, $37B4D - $37B3D

UnknownData_0x37B4D:
INCBIN "baserom.gb", $37B4D, $37B55 - $37B4D

LoggedData_0x37B55:
INCBIN "baserom.gb", $37B55, $37B69 - $37B55

UnknownData_0x37B69:
INCBIN "baserom.gb", $37B69, $37B6B - $37B69

LoggedData_0x37B6B:
INCBIN "baserom.gb", $37B6B, $37B7D - $37B6B

UnknownData_0x37B7D:
INCBIN "baserom.gb", $37B7D, $37B7F - $37B7D

LoggedData_0x37B7F:
INCBIN "baserom.gb", $37B7F, $37B93 - $37B7F

UnknownData_0x37B93:
INCBIN "baserom.gb", $37B93, $37B95 - $37B93

LoggedData_0x37B95:
INCBIN "baserom.gb", $37B95, $37B9B - $37B95

UnknownData_0x37B9B:
INCBIN "baserom.gb", $37B9B, $37B9D - $37B9B

LoggedData_0x37B9D:
INCBIN "baserom.gb", $37B9D, $37BBB - $37B9D

UnknownData_0x37BBB:
INCBIN "baserom.gb", $37BBB, $37BC1 - $37BBB

LoggedData_0x37BC1:
INCBIN "baserom.gb", $37BC1, $37BD9 - $37BC1

UnknownData_0x37BD9:
INCBIN "baserom.gb", $37BD9, $37BDB - $37BD9

LoggedData_0x37BDB:
INCBIN "baserom.gb", $37BDB, $37C0F - $37BDB

UnknownData_0x37C0F:
INCBIN "baserom.gb", $37C0F, $37C11 - $37C0F

LoggedData_0x37C11:
INCBIN "baserom.gb", $37C11, $37C2D - $37C11

UnknownData_0x37C2D:
INCBIN "baserom.gb", $37C2D, $37C2F - $37C2D

LoggedData_0x37C2F:
INCBIN "baserom.gb", $37C2F, $37C3D - $37C2F

UnknownData_0x37C3D:
INCBIN "baserom.gb", $37C3D, $37C45 - $37C3D

LoggedData_0x37C45:
INCBIN "baserom.gb", $37C45, $37C49 - $37C45

UnknownData_0x37C49:
INCBIN "baserom.gb", $37C49, $37C6B - $37C49

LoggedData_0x37C6B:
INCBIN "baserom.gb", $37C6B, $37C87 - $37C6B

UnknownData_0x37C87:
INCBIN "baserom.gb", $37C87, $37C99 - $37C87

LoggedData_0x37C99:
INCBIN "baserom.gb", $37C99, $37CCD - $37C99

UnknownData_0x37CCD:
INCBIN "baserom.gb", $37CCD, $37CCE - $37CCD

LoggedData_0x37CCE:
INCBIN "baserom.gb", $37CCE, $37CE4 - $37CCE

UnknownData_0x37CE4:
INCBIN "baserom.gb", $37CE4, $37CE5 - $37CE4

LoggedData_0x37CE5:
INCBIN "baserom.gb", $37CE5, $37CE6 - $37CE5

UnknownData_0x37CE6:
INCBIN "baserom.gb", $37CE6, $37CE7 - $37CE6

LoggedData_0x37CE7:
INCBIN "baserom.gb", $37CE7, $37CFD - $37CE7

UnknownData_0x37CFD:
INCBIN "baserom.gb", $37CFD, $37D02 - $37CFD

LoggedData_0x37D02:
INCBIN "baserom.gb", $37D02, $37D43 - $37D02

UnknownData_0x37D43:
INCBIN "baserom.gb", $37D43, $37D4A - $37D43

LoggedData_0x37D4A:
INCBIN "baserom.gb", $37D4A, $37D7A - $37D4A

UnknownData_0x37D7A:
INCBIN "baserom.gb", $37D7A, $37D7D - $37D7A

LoggedData_0x37D7D:
INCBIN "baserom.gb", $37D7D, $37DE2 - $37D7D

UnknownData_0x37DE2:
INCBIN "baserom.gb", $37DE2, $37DE3 - $37DE2

LoggedData_0x37DE3:
INCBIN "baserom.gb", $37DE3, $37DE4 - $37DE3

UnknownData_0x37DE4:
INCBIN "baserom.gb", $37DE4, $37DE5 - $37DE4

LoggedData_0x37DE5:
INCBIN "baserom.gb", $37DE5, $37E2C - $37DE5

UnknownData_0x37E2C:
INCBIN "baserom.gb", $37E2C, $37E31 - $37E2C

LoggedData_0x37E31:
INCBIN "baserom.gb", $37E31, $37E74 - $37E31

UnknownData_0x37E74:
INCBIN "baserom.gb", $37E74, $37E75 - $37E74

LoggedData_0x37E75:
INCBIN "baserom.gb", $37E75, $37E7F - $37E75

UnknownData_0x37E7F:
INCBIN "baserom.gb", $37E7F, $37E82 - $37E7F

LoggedData_0x37E82:
INCBIN "baserom.gb", $37E82, $37E8D - $37E82

UnknownData_0x37E8D:
INCBIN "baserom.gb", $37E8D, $37E8E - $37E8D

LoggedData_0x37E8E:
INCBIN "baserom.gb", $37E8E, $37E8F - $37E8E

UnknownData_0x37E8F:
INCBIN "baserom.gb", $37E8F, $37E93 - $37E8F

LoggedData_0x37E93:
INCBIN "baserom.gb", $37E93, $37E94 - $37E93

UnknownData_0x37E94:
INCBIN "baserom.gb", $37E94, $37E98 - $37E94

LoggedData_0x37E98:
INCBIN "baserom.gb", $37E98, $37E99 - $37E98

UnknownData_0x37E99:
INCBIN "baserom.gb", $37E99, $37E9D - $37E99

LoggedData_0x37E9D:
INCBIN "baserom.gb", $37E9D, $37E9E - $37E9D

UnknownData_0x37E9E:
INCBIN "baserom.gb", $37E9E, $37EB5 - $37E9E

LoggedData_0x37EB5:
INCBIN "baserom.gb", $37EB5, $37ED1 - $37EB5

UnknownData_0x37ED1:
INCBIN "baserom.gb", $37ED1, $38000 - $37ED1

SECTION "Bank0E", ROMX, BANK[$0E]

LoggedData_0x38000:
INCBIN "baserom.gb", $38000, $38012 - $38000

UnknownData_0x38012:
INCBIN "baserom.gb", $38012, $38014 - $38012

LoggedData_0x38014:
INCBIN "baserom.gb", $38014, $3801A - $38014

UnknownData_0x3801A:
INCBIN "baserom.gb", $3801A, $3801C - $3801A

LoggedData_0x3801C:
INCBIN "baserom.gb", $3801C, $3802C - $3801C

UnknownData_0x3802C:
INCBIN "baserom.gb", $3802C, $38040 - $3802C

LoggedData_0x38040:
INCBIN "baserom.gb", $38040, $38042 - $38040

UnknownData_0x38042:
INCBIN "baserom.gb", $38042, $38044 - $38042

LoggedData_0x38044:
INCBIN "baserom.gb", $38044, $38050 - $38044

UnknownData_0x38050:
INCBIN "baserom.gb", $38050, $38059 - $38050

LoggedData_0x38059:
INCBIN "baserom.gb", $38059, $3805B - $38059

UnknownData_0x3805B:
INCBIN "baserom.gb", $3805B, $3805D - $3805B

LoggedData_0x3805D:
INCBIN "baserom.gb", $3805D, $381E0 - $3805D

UnknownData_0x381E0:
INCBIN "baserom.gb", $381E0, $381E2 - $381E0

LoggedData_0x381E2:
INCBIN "baserom.gb", $381E2, $3832D - $381E2

UnknownData_0x3832D:
INCBIN "baserom.gb", $3832D, $3832F - $3832D

LoggedData_0x3832F:
INCBIN "baserom.gb", $3832F, $38342 - $3832F

UnknownData_0x38342:
INCBIN "baserom.gb", $38342, $38344 - $38342

LoggedData_0x38344:
INCBIN "baserom.gb", $38344, $38365 - $38344

UnknownData_0x38365:
INCBIN "baserom.gb", $38365, $3837A - $38365

LoggedData_0x3837A:
INCBIN "baserom.gb", $3837A, $3837C - $3837A

UnknownData_0x3837C:
INCBIN "baserom.gb", $3837C, $3837E - $3837C

LoggedData_0x3837E:
INCBIN "baserom.gb", $3837E, $384C9 - $3837E

UnknownData_0x384C9:
INCBIN "baserom.gb", $384C9, $384CB - $384C9

LoggedData_0x384CB:
INCBIN "baserom.gb", $384CB, $384DE - $384CB

UnknownData_0x384DE:
INCBIN "baserom.gb", $384DE, $384E0 - $384DE

LoggedData_0x384E0:
INCBIN "baserom.gb", $384E0, $384F3 - $384E0

UnknownData_0x384F3:
INCBIN "baserom.gb", $384F3, $384F5 - $384F3

LoggedData_0x384F5:
INCBIN "baserom.gb", $384F5, $38508 - $384F5

UnknownData_0x38508:
INCBIN "baserom.gb", $38508, $3850A - $38508

LoggedData_0x3850A:
INCBIN "baserom.gb", $3850A, $3851D - $3850A

UnknownData_0x3851D:
INCBIN "baserom.gb", $3851D, $3851F - $3851D

LoggedData_0x3851F:
INCBIN "baserom.gb", $3851F, $38538 - $3851F

UnknownData_0x38538:
INCBIN "baserom.gb", $38538, $3853A - $38538

LoggedData_0x3853A:
INCBIN "baserom.gb", $3853A, $3855E - $3853A

UnknownData_0x3855E:
INCBIN "baserom.gb", $3855E, $385CE - $3855E

LoggedData_0x385CE:
INCBIN "baserom.gb", $385CE, $38652 - $385CE

UnknownData_0x38652:
INCBIN "baserom.gb", $38652, $38654 - $38652

LoggedData_0x38654:
INCBIN "baserom.gb", $38654, $38694 - $38654

UnknownData_0x38694:
INCBIN "baserom.gb", $38694, $38696 - $38694

LoggedData_0x38696:
INCBIN "baserom.gb", $38696, $3869E - $38696

UnknownData_0x3869E:
INCBIN "baserom.gb", $3869E, $386A0 - $3869E

LoggedData_0x386A0:
INCBIN "baserom.gb", $386A0, $386A8 - $386A0

UnknownData_0x386A8:
INCBIN "baserom.gb", $386A8, $386AA - $386A8

LoggedData_0x386AA:
INCBIN "baserom.gb", $386AA, $386B2 - $386AA

UnknownData_0x386B2:
INCBIN "baserom.gb", $386B2, $386B4 - $386B2

LoggedData_0x386B4:
INCBIN "baserom.gb", $386B4, $3903D - $386B4

UnknownData_0x3903D:
INCBIN "baserom.gb", $3903D, $3903F - $3903D

LoggedData_0x3903F:
INCBIN "baserom.gb", $3903F, $39059 - $3903F

UnknownData_0x39059:
INCBIN "baserom.gb", $39059, $39063 - $39059

LoggedData_0x39063:
INCBIN "baserom.gb", $39063, $39A64 - $39063

UnknownData_0x39A64:
INCBIN "baserom.gb", $39A64, $39BA8 - $39A64

LoggedData_0x39BA8:
INCBIN "baserom.gb", $39BA8, $39D12 - $39BA8

UnknownData_0x39D12:
INCBIN "baserom.gb", $39D12, $39D14 - $39D12

LoggedData_0x39D14:
INCBIN "baserom.gb", $39D14, $39D38 - $39D14

UnknownData_0x39D38:
INCBIN "baserom.gb", $39D38, $39D3A - $39D38

LoggedData_0x39D3A:
INCBIN "baserom.gb", $39D3A, $39D46 - $39D3A

UnknownData_0x39D46:
INCBIN "baserom.gb", $39D46, $39D48 - $39D46

LoggedData_0x39D48:
INCBIN "baserom.gb", $39D48, $3A227 - $39D48

UnknownData_0x3A227:
INCBIN "baserom.gb", $3A227, $3A22D - $3A227

LoggedData_0x3A22D:
INCBIN "baserom.gb", $3A22D, $3A233 - $3A22D

UnknownData_0x3A233:
INCBIN "baserom.gb", $3A233, $3A23F - $3A233

LoggedData_0x3A23F:
INCBIN "baserom.gb", $3A23F, $3A24B - $3A23F

UnknownData_0x3A24B:
INCBIN "baserom.gb", $3A24B, $3A24F - $3A24B

LoggedData_0x3A24F:
INCBIN "baserom.gb", $3A24F, $3A253 - $3A24F

UnknownData_0x3A253:
INCBIN "baserom.gb", $3A253, $3A257 - $3A253

LoggedData_0x3A257:
INCBIN "baserom.gb", $3A257, $3A263 - $3A257

UnknownData_0x3A263:
INCBIN "baserom.gb", $3A263, $3A265 - $3A263

LoggedData_0x3A265:
INCBIN "baserom.gb", $3A265, $3A279 - $3A265

UnknownData_0x3A279:
INCBIN "baserom.gb", $3A279, $3A28F - $3A279

LoggedData_0x3A28F:
INCBIN "baserom.gb", $3A28F, $3A299 - $3A28F

UnknownData_0x3A299:
INCBIN "baserom.gb", $3A299, $3A2A3 - $3A299

LoggedData_0x3A2A3:
INCBIN "baserom.gb", $3A2A3, $3A2AD - $3A2A3

UnknownData_0x3A2AD:
INCBIN "baserom.gb", $3A2AD, $3A2B9 - $3A2AD

LoggedData_0x3A2B9:
INCBIN "baserom.gb", $3A2B9, $3A2CB - $3A2B9

UnknownData_0x3A2CB:
INCBIN "baserom.gb", $3A2CB, $3A325 - $3A2CB

LoggedData_0x3A325:
INCBIN "baserom.gb", $3A325, $3A37F - $3A325

UnknownData_0x3A37F:
INCBIN "baserom.gb", $3A37F, $3A433 - $3A37F

LoggedData_0x3A433:
INCBIN "baserom.gb", $3A433, $3A524 - $3A433

UnknownData_0x3A524:
INCBIN "baserom.gb", $3A524, $3A549 - $3A524

LoggedData_0x3A549:
INCBIN "baserom.gb", $3A549, $3A5B3 - $3A549

UnknownData_0x3A5B3:
INCBIN "baserom.gb", $3A5B3, $3A5FD - $3A5B3

LoggedData_0x3A5FD:
INCBIN "baserom.gb", $3A5FD, $3A691 - $3A5FD

UnknownData_0x3A691:
INCBIN "baserom.gb", $3A691, $3A6C2 - $3A691

LoggedData_0x3A6C2:
INCBIN "baserom.gb", $3A6C2, $3A853 - $3A6C2

UnknownData_0x3A853:
INCBIN "baserom.gb", $3A853, $3A99B - $3A853

LoggedData_0x3A99B:
INCBIN "baserom.gb", $3A99B, $3AA3F - $3A99B

UnknownData_0x3AA3F:
INCBIN "baserom.gb", $3AA3F, $3AAE3 - $3AA3F

LoggedData_0x3AAE3:
INCBIN "baserom.gb", $3AAE3, $3AB0F - $3AAE3

UnknownData_0x3AB0F:
INCBIN "baserom.gb", $3AB0F, $3AB23 - $3AB0F

LoggedData_0x3AB23:
INCBIN "baserom.gb", $3AB23, $3ABD4 - $3AB23

UnknownData_0x3ABD4:
INCBIN "baserom.gb", $3ABD4, $3ABDA - $3ABD4

LoggedData_0x3ABDA:
INCBIN "baserom.gb", $3ABDA, $3ABDC - $3ABDA

UnknownData_0x3ABDC:
INCBIN "baserom.gb", $3ABDC, $3ABFC - $3ABDC

LoggedData_0x3ABFC:
INCBIN "baserom.gb", $3ABFC, $3AC00 - $3ABFC

UnknownData_0x3AC00:
INCBIN "baserom.gb", $3AC00, $3AC02 - $3AC00

LoggedData_0x3AC02:
INCBIN "baserom.gb", $3AC02, $3AC24 - $3AC02

UnknownData_0x3AC24:
INCBIN "baserom.gb", $3AC24, $3AC46 - $3AC24

LoggedData_0x3AC46:
INCBIN "baserom.gb", $3AC46, $3AC57 - $3AC46

UnknownData_0x3AC57:
INCBIN "baserom.gb", $3AC57, $3AD73 - $3AC57

LoggedData_0x3AD73:
INCBIN "baserom.gb", $3AD73, $3ADBF - $3AD73

UnknownData_0x3ADBF:
INCBIN "baserom.gb", $3ADBF, $3ADC9 - $3ADBF

LoggedData_0x3ADC9:
INCBIN "baserom.gb", $3ADC9, $3ADD5 - $3ADC9

UnknownData_0x3ADD5:
INCBIN "baserom.gb", $3ADD5, $3ADD7 - $3ADD5

LoggedData_0x3ADD7:
INCBIN "baserom.gb", $3ADD7, $3B08C - $3ADD7

UnknownData_0x3B08C:
INCBIN "baserom.gb", $3B08C, $3B140 - $3B08C

LoggedData_0x3B140:
INCBIN "baserom.gb", $3B140, $3B214 - $3B140

UnknownData_0x3B214:
INCBIN "baserom.gb", $3B214, $3B216 - $3B214

LoggedData_0x3B216:
INCBIN "baserom.gb", $3B216, $3B231 - $3B216

UnknownData_0x3B231:
INCBIN "baserom.gb", $3B231, $3B2E5 - $3B231

LoggedData_0x3B2E5:
INCBIN "baserom.gb", $3B2E5, $3B2F3 - $3B2E5

UnknownData_0x3B2F3:
INCBIN "baserom.gb", $3B2F3, $3B301 - $3B2F3

LoggedData_0x3B301:
INCBIN "baserom.gb", $3B301, $3B367 - $3B301

UnknownData_0x3B367:
INCBIN "baserom.gb", $3B367, $3B3CD - $3B367

LoggedData_0x3B3CD:
INCBIN "baserom.gb", $3B3CD, $3B43D - $3B3CD

UnknownData_0x3B43D:
INCBIN "baserom.gb", $3B43D, $3B441 - $3B43D

LoggedData_0x3B441:
INCBIN "baserom.gb", $3B441, $3BA57 - $3B441

UnknownData_0x3BA57:
INCBIN "baserom.gb", $3BA57, $3C000 - $3BA57

SECTION "Bank0F", ROMX, BANK[$0F]

UnknownData_0x3C000:
INCBIN "baserom.gb", $3C000, $40000 - $3C000

SECTION "Bank10", ROMX, BANK[$10]
	ld hl,$0014
	add hl,de
	inc [hl]
	ld hl,$0010
	add hl,de
	ld a,[hl]
	cp $07
	call c,Logged_0x40417
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x40029
	dw Logged_0x40092
	dw Logged_0x400D9

UnknownData_0x4001B:
INCBIN "baserom.gb", $4001B, $40021 - $4001B

LoggedData_0x40021:
INCBIN "baserom.gb", $40021, $40029 - $40021

Logged_0x40029:
	ld a,$40
	ld [$D28F],a
	ld a,$48
	ld [$D290],a
	ld a,$0A
	ld hl,$0007
	add hl,de
	ld [hli],a
	ld a,$20
	ld hl,$0003
	add hl,de
	ld [hli],a
	xor a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0018
	add hl,de
	ld [hl],a
	ld a,$05
	ld c,$01
	call Logged_0x43277
	ld a,$1C
	ld [$FF00+$49],a
	xor a
	ld [$D286],a
	ld [$D28E],a
	ld hl,$0007
	add hl,de
	ld a,[hli]
	add a,$22
	ld b,a
	ld hl,$D291
	ld c,$03

Logged_0x40072:
	ld a,$20
	ld [hli],a
	ld a,b
	ld [hli],a
	add a,$0A
	ld b,a
	dec c
	jr nz,Logged_0x40072
	ld a,$30
	ld [hli],a
	ld a,$48
	ld [hl],a
	call Logged_0x405A1
	xor a
	ld [$D28D],a
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x40092:
	call Logged_0x4055B
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x400A4
	res 6,[hl]
	ld hl,$DC0A
	set 6,[hl]

Logged_0x400A4:
	ld a,[$FF00+$91]
	cp $04
	ret z
	ld a,$00
	ld c,$00
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$0011
	add hl,de
	ld bc,$01A4
	ld [hl],c
	inc hl
	ld [hl],b
	ld hl,$0015
	add hl,de
	ld bc,$0078
	ld [hl],c
	inc hl
	ld [hl],b
	ld hl,$0013
	add hl,de
	ld a,$01
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

Logged_0x400D9:
	ld hl,$D28E
	bit 7,[hl]
	jr z,Logged_0x40131
	ld hl,$0011
	add hl,de
	ld bc,$00B4
	ld [hl],c
	inc hl
	ld [hl],b
	ld a,$0D
	ld c,$03
	call Logged_0x43277
	ld hl,$D286
	inc [hl]
	ld a,[hl]
	cp $03
	jr nz,Logged_0x4011C
	ld hl,$D12B
	set 4,[hl]
	ld hl,$D12A
	res 5,[hl]
	ld hl,$000A
	add hl,de
	xor a
	ld [hld],a
	ld a,$FF
	ld [hl],a
	ld hl,$0011
	add hl,de
	ld a,$10
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$07
	ld [hl],a
	ret

Logged_0x4011C:
	ld hl,$DC09
	set 2,[hl]
	ld a,[$D286]
	dec a
	jr nz,Logged_0x40129
	jr Logged_0x40129

Logged_0x40129:
	ld hl,$0010
	add hl,de
	ld a,$06
	ld [hl],a
	ret

Logged_0x40131:
	ld hl,$0018
	add hl,de
	ld a,[$D28E]
	cp [hl]
	jr z,Logged_0x40170
	ld [hl],a
	bit 4,a
	jr z,Logged_0x40149
	ld a,$00
	ld c,$00
	call Logged_0x43277
	jr Logged_0x40170

Logged_0x40149:
	bit 5,a
	jr z,Logged_0x40156
	ld a,$0A
	ld c,$02
	call Logged_0x43277
	jr Logged_0x40170

Logged_0x40156:
	bit 6,a
	jr z,Logged_0x40163
	ld a,$0A
	ld c,$02
	call Logged_0x43277
	jr Logged_0x40170

Logged_0x40163:
	ld a,$01
	ld c,$00
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]

Logged_0x40170:
	bit 4,a
	jr z,Logged_0x40184
	ld hl,$0014
	add hl,de
	ld a,[hl]
	and $0F
	jr nz,Logged_0x40184
	ld hl,$DC06
	set 1,[hl]
	jr Logged_0x40196

Logged_0x40184:
	bit 6,a
	jr z,Logged_0x40196
	ld hl,$0014
	add hl,de
	ld a,[hl]
	and $1F
	jr nz,Logged_0x40196
	ld hl,$DC03
	set 6,[hl]

Logged_0x40196:
	ld a,[$D28F]
	cp $40
	jr nz,Logged_0x401A6
	ld a,[$D290]
	cp $48
	jr nz,Logged_0x401A6
	jr Logged_0x401D0

Logged_0x401A6:
	ld hl,$0012
	add hl,de
	ld a,[hld]
	or [hl]
	jr z,Logged_0x401B6
	ld a,[hl]
	sub $01
	ld [hli],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a

Logged_0x401B6:
	ld hl,$D28E
	ld a,[hl]
	inc a
	dec a
	jr nz,Logged_0x401DA
	ld hl,$0016
	add hl,de
	ld a,[hld]
	or [hl]
	jr z,Logged_0x401E4
	ld a,[hl]
	sub $01
	ld [hli],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr Logged_0x401E4

Logged_0x401D0:
	ld hl,$0011
	add hl,de
	ld bc,$01A4
	ld [hl],c
	inc hl
	ld [hl],b

Logged_0x401DA:
	ld hl,$0015
	add hl,de
	ld bc,$0078
	ld [hl],c
	inc hl
	ld [hl],b

Logged_0x401E4:
	ld hl,$D28E
	ld a,[hl]
	inc a
	dec a
	ret nz
	ld hl,$0012
	add hl,de
	ld a,[hld]
	or [hl]
	jr z,Logged_0x401FC
	ld hl,$0016
	add hl,de
	ld a,[hld]
	or [hl]
	jr z,Logged_0x401FC
	ret

Logged_0x401FC:
	ld hl,$0010
	add hl,de
	ld a,$04
	ld [hl],a
	ld hl,$C240
	ld c,$0E

Logged_0x40208:
	ld a,[hl]
	cp $A6
	jr nz,Logged_0x4020F
	xor a
	ld [hl],a

Logged_0x4020F:
	push de
	ld de,$0020
	add hl,de
	pop de
	dec c
	jr nz,Logged_0x40208
	push de
	call Logged_0x3069
	pop de
	ret c
	push de
	push hl
	ld a,[$D28F]
	ld d,a
	ld a,[$D290]
	ld e,a
	push de
	call Logged_0x2FA4
	inc hl
	ld a,[hld]
	ld [hl],a
	pop de
	push af
	call Logged_0x3007
	pop af
	ld c,e
	ld b,d
	call Logged_0x26C2
	pop de
	ld a,$A6
	ld [de],a
	ld hl,$0001
	add hl,de
	ld a,$A4
	ld [hl],a
	ld a,[$D28F]
	ld hl,$0003
	add hl,de
	ld [hl],a
	ld a,[$D290]
	ld hl,$0007
	add hl,de
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$05
	ld [hl],a
	ld a,$06
	ld c,$02
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	pop de
	ld hl,$0011
	add hl,de
	ld bc,$01A4
	ld [hl],c
	inc hl
	ld [hl],b
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

UnknownData_0x4027C:
INCBIN "baserom.gb", $4027C, $402A7 - $4027C
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x402B8
	res 6,[hl]
	ld a,$1A
	ld c,$05
	call Logged_0x43277

Logged_0x402B8:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	sub $01
	ld [hli],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr nc,Logged_0x402D2
	ld hl,$0011
	add hl,de
	ld bc,$01A4
	ld [hl],c
	inc hl
	ld [hl],b
	jr Logged_0x402F8

Logged_0x402D2:
	ld hl,$C240
	ld c,$0E

Logged_0x402D7:
	ld a,[hl]
	cp $A6
	jr z,Logged_0x402E6
	push de
	ld de,$0020
	add hl,de
	pop de
	dec c
	jr nz,Logged_0x402D7
	ret

Logged_0x402E6:
	ld bc,$0010
	add hl,bc
	ld a,[hl]
	cp $01
	ret nz
	ld hl,$0011
	add hl,de
	ld bc,$01A4
	ld [hl],c
	inc hl
	ld [hl],b

Logged_0x402F8:
	ld a,$14
	ld c,$04
	call Logged_0x43277
	ld hl,$D28E
	res 7,[hl]
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

UnknownData_0x4030C:
INCBIN "baserom.gb", $4030C, $403B7 - $4030C
	call Logged_0x432A6
	ld hl,$0010
	add hl,de
	ld a,$08
	ld [hl],a
	ret
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	push de
	ld a,$14
	ld c,$00
	ld b,$00
	call Logged_0x26C2
	ld a,$14
	ld c,$00
	ld b,$02
	call Logged_0x26C2
	pop de
	ld hl,$0011
	add hl,de
	ld a,$C2
	ld [hli],a
	ld a,$30
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$09
	ld [hl],a
	ret
	ld hl,$0012
	add hl,de
	ld a,[hl]
	dec a
	jr z,Logged_0x40401
	ld [hl],a
	ld a,$03
	call Logged_0x1331
	dec a
	ld [$C0DF],a
	ret

Logged_0x40401:
	xor a
	ld [$C0DF],a
	ld hl,$000A
	add hl,de
	xor a
	ld [hld],a
	ld [hl],a
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	ld a,$13
	ld [$FF00+$91],a
	ret

Logged_0x40417:
	ld hl,$D28E
	bit 7,[hl]
	jr z,Logged_0x40459
	ld hl,$0002
	add hl,de
	ld a,[hl]
	sub $0D
	jr c,Logged_0x4043A
	cp $06
	jr nc,Logged_0x4043A
	sla a
	ld c,a
	sla a
	add a,c
	ld c,a
	ld b,$00
	ld hl,$4537
	add hl,bc
	jr Logged_0x4044B

Logged_0x4043A:
	ld hl,$0014
	add hl,de
	ld a,[hl]
	and $0E
	ld c,a
	add a,c
	add a,c
	ld c,a
	ld b,$00
	ld hl,$4507
	add hl,bc

Logged_0x4044B:
	push de
	ld bc,$D291
	ld d,$06

Logged_0x40451:
	ld a,[hli]
	ld [bc],a
	inc bc
	dec d
	jr nz,Logged_0x40451
	pop de
	ret

Logged_0x40459:
	ld a,[$D28F]
	sub $40
	jr nc,Logged_0x40463
	xor $FF
	inc a

Logged_0x40463:
	ld c,a
	ld a,[$D290]
	sub $48
	jr nc,Logged_0x4046E
	xor $FF
	inc a

Logged_0x4046E:
	ld b,a
	srl b
	srl b
	sub b
	add a,c
	push af
	ld b,a
	srl b
	srl b
	sub b
	srl b
	sub b
	add a,$0A
	cp $30
	jr c,Logged_0x40487
	ld a,$30

Logged_0x40487:
	ld hl,$0007
	add hl,de
	ld [hli],a
	pop af
	ld b,$04
	ld hl,$D291
	cp $28
	jr nc,Logged_0x404B9
	add a,$08
	swap a
	and $0F
	inc a
	push af
	ld c,a
	ld a,$04
	sub c
	ld c,a
	push hl
	ld hl,$0007
	add hl,de
	ld a,[hl]
	pop hl
	add a,$22
	ld b,a

Logged_0x404AD:
	ld a,$20
	ld [hli],a
	ld a,b
	ld [hli],a
	add a,$0A
	ld b,a
	dec c
	jr nz,Logged_0x404AD
	pop bc

Logged_0x404B9:
	dec b
	jr z,Logged_0x404E4
	push de
	ld c,b
	push bc
	push hl
	push bc
	inc hl
	push hl
	ld a,[$D290]
	sub $48
	call Logged_0x404E5
	pop hl
	pop bc
	ld a,[$D290]
	call Logged_0x40500
	ld a,[$D28F]
	sub $40
	call Logged_0x404E5
	pop hl
	pop bc
	ld a,[$D28F]
	call Logged_0x40500
	pop de

Logged_0x404E4:
	ret

Logged_0x404E5:
	inc b
	jr c,Logged_0x404F1
	ld l,a
	ld h,$00
	call Logged_0x32D9
	ld e,l
	jr Logged_0x404FF

Logged_0x404F1:
	xor $FF
	inc a
	ld l,a
	ld h,$00
	call Logged_0x32D9
	ld a,l
	xor $FF
	inc a
	ld e,a

Logged_0x404FF:
	ret

Logged_0x40500:
	sub e
	ld [hli],a
	inc hl
	dec c
	jr nz,Logged_0x40500
	ret

LoggedData_0x40507:
INCBIN "baserom.gb", $40507, $4055B - $40507

Logged_0x4055B:
	push de
	ld hl,$0002
	add hl,de
	ld a,[hl]
	cp $05
	jr c,Logged_0x40573
	cp $08
	jr nc,Logged_0x40573
	sub $04
	sla a
	ld c,a
	sla a
	add a,c
	jr Logged_0x40574

Logged_0x40573:
	xor a

Logged_0x40574:
	add a,$89
	ld c,a
	ld a,$00
	adc a,$45
	ld b,a
	ld hl,$D291
	ld e,$06

Logged_0x40581:
	ld a,[bc]
	ld [hli],a
	inc bc
	dec e
	jr nz,Logged_0x40581
	pop de
	ret

LoggedData_0x40589:
INCBIN "baserom.gb", $40589, $405A1 - $40589

Logged_0x405A1:
	push de
	call Logged_0x3069
	pop de
	jr c,Logged_0x405D4
	push de
	ld d,h
	ld e,l
	ld a,$95
	ld [de],a
	ld hl,$0001
	add hl,de
	ld a,$94
	ld [hl],a
	ld hl,$0010
	add hl,de
	xor a
	ld [hl],a
	ld b,$40
	ld c,$18
	xor a
	ld hl,$0004
	add hl,de
	ld [hld],a
	ld [hl],b
	ld hl,$0008
	add hl,de
	ld [hld],a
	ld [hl],c
	ld a,$00
	ld c,$00
	call Logged_0x43277
	pop de

Logged_0x405D4:
	ret
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x405F1
	dw Logged_0x40637
	dw Logged_0x40731
	dw Logged_0x40787
	dw Logged_0x407AD
	dw Logged_0x407B7
	dw Logged_0x4084A
	dw Logged_0x40881
	dw Logged_0x408B3
	dw Logged_0x408E3
	dw Logged_0x40A1C

Logged_0x405F1:
	ld a,$A5
	ld [de],a
	push de
	ld hl,$C240
	ld de,$0020
	ld c,$0E

Logged_0x405FD:
	ld a,[hl]
	cp $A6
	jr nz,Logged_0x40604
	xor a
	ld [hl],a

Logged_0x40604:
	add hl,de
	dec c
	jr nz,Logged_0x405FD
	pop de
	ld a,$A6
	ld [de],a
	ld hl,$0019
	add hl,de
	ld bc,$0178
	ld [hl],c
	inc hl
	ld [hl],b
	ld a,$06
	ld c,$02
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$001B
	add hl,de
	ld a,$02
	ld [hl],a
	call Logged_0x40A33
	ld hl,$D28E
	set 6,[hl]
	ld hl,$0010
	add hl,de
	inc [hl]

Logged_0x40637:
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x40651
	res 6,[hl]
	ld hl,$0002
	add hl,de
	ld a,[hl]
	cp $01
	jr nz,Logged_0x40651
	ld a,$03
	ld c,$01
	call Logged_0x43277

Logged_0x40651:
	ld hl,$0018
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x40664
	call Logged_0x40A2D
	ld hl,$0010
	add hl,de
	ld a,$03
	ld [hl],a
	ret

Logged_0x40664:
	ld hl,$0019
	add hl,de
	dec [hl]
	jr nz,Logged_0x406BC
	inc hl
	dec [hl]
	jr nz,Logged_0x406BC
	ld hl,$001B
	add hl,de
	dec [hl]
	jr z,Logged_0x40689
	ld a,$00
	ld c,$00
	call Logged_0x43277
	ld hl,$0019
	add hl,de
	ld bc,$015A
	ld [hl],c
	inc hl
	ld [hl],b
	jr Logged_0x406BC

Logged_0x40689:
	inc [hl]
	ld a,$10
	ld [$C233],a
	xor a
	ld [$C23B],a
	ld a,[$D142]
	xor $01
	ld [$D142],a
	call Logged_0x40A2D
	ld hl,$0019
	add hl,de
	ld bc,$011E
	ld [hl],c
	inc hl
	ld [hl],b
	ld hl,$D28E
	res 6,[hl]
	set 4,[hl]
	ld hl,$DC04
	set 3,[hl]
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

Logged_0x406BC:
	ld hl,$D17E
	ld a,[$C223]
	add a,[hl]
	ld hl,$0003
	add hl,de
	ld [hl],a
	ld [$D28F],a
	ld hl,$D17F
	ld a,[$C227]
	add a,[hl]
	ld hl,$0007
	add hl,de
	ld [hl],a
	ld [$D290],a
	ld bc,$C233
	ld a,[$D141]
	rla
	jr c,Logged_0x406E6
	ld bc,$C433

Logged_0x406E6:
	ld a,[bc]
	cp $09
	ret z
	push bc
	ld hl,$0015
	add hl,de
	ld a,[hl]
	ld hl,$0003
	add hl,de
	ld d,[hl]
	inc hl
	inc hl
	inc hl
	inc hl
	ld e,[hl]
	call Logged_0x32C1
	jr c,Unknown_0x40701
	pop bc
	ret

Unknown_0x40701:
	ld b,$01
	ld a,d
	cp $08
	jr c,Unknown_0x40709
	inc b

Unknown_0x40709:
	set 2,b
	ld a,e
	cp $08
	jr c,Unknown_0x40714
	ld a,b
	add a,$04
	ld b,a

Unknown_0x40714:
	ld a,$1E
	add a,l
	ld l,a
	ld a,b
	ld [hli],a
	set 7,[hl]
	pop hl
	ld a,[hl]
	cp $04
	ret z
	ld a,$09
	ld [hl],a
	ld a,$08
	add a,l
	ld l,a
	xor a
	ld [hl],a
	ld a,b
	xor $0F
	ld [$D22B],a
	ret

Logged_0x40731:
	ld a,$03
	call Logged_0x1331
	dec a
	sla a
	ld hl,$D28F
	add a,[hl]
	ld hl,$0003
	add hl,de
	ld [hl],a
	ld a,$03
	call Logged_0x1331
	dec a
	sla a
	ld hl,$D290
	add a,[hl]
	ld hl,$0007
	add hl,de
	ld [hl],a
	ld hl,$0019
	add hl,de
	dec [hl]
	ret nz
	inc hl
	dec [hl]
	ret nz
	ld a,[$D28F]
	ld hl,$0007
	add hl,de
	ld [hl],a
	ld a,[$D290]
	ld hl,$0007
	add hl,de
	ld [hl],a
	cp $48
	jr nz,Logged_0x4077A
	ld a,[$D28F]
	cp $40
	jr nz,Logged_0x4077A
	jp Logged_0x40881

Logged_0x4077A:
	ld a,$80
	ld [$D28D],a
	ld hl,$0010
	add hl,de
	ld a,$05
	ld [hl],a
	ret

Logged_0x40787:
	push de
	ld hl,$D28E
	res 6,[hl]
	ld l,e
	ld h,d
	call Logged_0x32CD
	ld a,b
	ld [$D28F],a
	ld d,a
	ld a,c
	ld [$D290],a
	ld e,a
	call Logged_0x2FA4
	pop de
	ld a,$17
	ld c,$00
	call Logged_0x43277
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x407AD:
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	ret z
	xor a
	ld [de],a
	ret

Logged_0x407B7:
	push de
	ld a,$A5
	ld [de],a
	push de
	ld hl,$C240
	ld de,$0020
	ld c,$0E

Logged_0x407C4:
	ld a,[hl]
	cp $A6
	jr nz,Logged_0x407CB
	xor a
	ld [hl],a

Logged_0x407CB:
	add hl,de
	dec c
	jr nz,Logged_0x407C4
	pop de
	ld a,$A6
	ld [de],a
	ld a,[$D28F]
	sub $40
	jr nc,Logged_0x407DD
	xor $FF
	inc a

Logged_0x407DD:
	ld c,a
	ld a,[$D290]
	sub $48
	jr nc,Logged_0x407E8
	xor $FF
	inc a

Logged_0x407E8:
	cp c
	jr c,Logged_0x407F9
	ld b,a
	sla b
	ld l,$00
	ld h,c
	call Logged_0x32D9
	ld bc,$0080
	jr Logged_0x40807

Logged_0x407F9:
	ld b,c
	sla b
	ld l,$00
	ld h,a
	call Logged_0x32D9
	push hl
	ld hl,$0080
	pop bc

Logged_0x40807:
	ld a,[$D28F]
	sub $40
	jr c,Logged_0x40818
	ld a,l
	cpl
	add a,$01
	ld l,a
	ld a,h
	cpl
	adc a,$00
	ld h,a

Logged_0x40818:
	ld a,[$D290]
	sub $48
	jr c,Logged_0x40829
	ld a,c
	cpl
	add a,$01
	ld c,a
	ld a,b
	cpl
	adc a,$00
	ld b,a

Logged_0x40829:
	pop de
	push hl
	ld hl,$0009
	add hl,de
	ld [hl],b
	inc hl
	ld [hl],c
	pop bc
	ld hl,$0005
	add hl,de
	ld [hl],b
	inc hl
	ld [hl],c
	ld a,$80
	ld [$D28D],a
	ld hl,$D28E
	set 4,[hl]
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x4084A:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld [$D28F],a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld [$D290],a
	ld hl,$0009
	add hl,de
	ld a,[hli]
	or [hl]
	jr z,Logged_0x40873
	ld hl,$0006
	add hl,de
	ld a,[hld]
	or a
	jr z,Logged_0x4087B
	ld a,[hl]
	cp $01
	jr z,Logged_0x4087B
	cp $FF
	jr z,Logged_0x4087B

Logged_0x40873:
	ld a,[$D28F]
	cp $40
	ret nz
	jr Logged_0x40881

Logged_0x4087B:
	ld a,[$D290]
	cp $48
	ret nz

Logged_0x40881:
	push de
	xor a
	ld [$D28D],a
	ld hl,$D28E
	res 4,[hl]
	ld a,$40
	ld [$D28F],a
	ld d,a
	ld a,$48
	ld [$D290],a
	ld e,a
	push de
	call Logged_0x3007
	ld a,$6F
	ld c,e
	ld b,d
	call Logged_0x26C2
	pop de
	call Logged_0x2FA4
	ld a,[hli]
	ld [hld],a
	ld a,$6F
	ld [hl],a
	xor a
	ld [$D179],a
	pop de
	xor a
	ld [de],a
	ret

Logged_0x408B3:
	call Logged_0x40A2D
	ld a,$06
	ld c,$02
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld a,$80
	ld [$D28D],a
	ld hl,$D28E
	res 6,[hl]
	set 5,[hl]
	ld hl,$0005
	add hl,de
	ld a,$03
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$DC09
	set 7,[hl]
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x408E3:
	ld a,[$D286]
	cp $03
	jr z,Logged_0x408EC
	jr Logged_0x4091C

Logged_0x408EC:
	xor a
	ld [$D28D],a
	ld hl,$0000
	add hl,de
	ld a,$80
	ld [hl],a
	ld hl,$0001
	add hl,de
	ld a,$80
	ld [hl],a
	xor a
	ld hl,$0002
	add hl,de
	ld [hl],a
	ld hl,$000C
	add hl,de
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$08
	ld [hl],a
	ld hl,$0014
	add hl,de
	xor a
	ld [hl],a
	ld hl,$DC0A
	set 4,[hl]
	ret

Logged_0x4091C:
	ld c,$00
	call Logged_0x43A09
	ld b,$00
	ld hl,$0007
	add hl,de
	ld a,[hl]
	sub $48
	jr z,Logged_0x40995
	inc b
	jr c,Logged_0x40963
	ld c,$10
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x40956
	ld c,$04
	sla a
	jr c,Unknown_0x40947
	sla a
	jr c,Unknown_0x40947
	sla a
	jr nc,Logged_0x40949

Unknown_0x40947:
	ld a,$FF

Logged_0x40949:
	cp $FC
	jr c,Logged_0x4094F
	ld a,$FB

Logged_0x4094F:
	xor $FF
	inc a
	inc hl
	cp [hl]
	jr nc,Logged_0x4098A

Logged_0x40956:
	ld hl,$000A
	add hl,de
	ld a,[hl]
	sub c
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr Logged_0x40995

Logged_0x40963:
	ld c,$10
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr nz,Logged_0x4098A
	ld c,$04
	sla a
	jr nc,Unknown_0x4097B
	sla a
	jr nc,Unknown_0x4097B
	sla a
	jr c,Logged_0x4097D

Unknown_0x4097B:
	ld a,$01

Logged_0x4097D:
	cp $05
	jr nc,Logged_0x40983
	ld a,$05

Logged_0x40983:
	xor $FF
	inc a
	inc hl
	cp [hl]
	jr c,Logged_0x40956

Logged_0x4098A:
	ld hl,$000A
	add hl,de
	ld a,[hl]
	add a,c
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a

Logged_0x40995:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	sub $40
	jr z,Logged_0x409D2
	inc b
	jr c,Logged_0x409BA
	ld c,$10
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x409AD
	ld c,$04

Logged_0x409AD:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	sub c
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr Logged_0x409D2

Logged_0x409BA:
	call Logged_0x43252
	ld hl,$0005
	add hl,de
	ld a,[hl]
	cp $00
	jr z,Logged_0x409CA
	xor a
	ld [hli],a
	dec a
	ld [hli],a

Logged_0x409CA:
	ld hl,$D28E
	set 7,[hl]
	jr Logged_0x409D2

UnknownData_0x409D1:
INCBIN "baserom.gb", $409D1, $409D2 - $409D1

Logged_0x409D2:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld [$D28F],a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld [$D290],a
	ld hl,$0012
	add hl,de
	dec [hl]
	ret nz
	push hl
	ld hl,$0011
	add hl,de
	ld a,[hl]
	sub $04
	jr c,Logged_0x409FE
	ld [hl],a
	sub $40
	jr z,Unknown_0x409F9
	jr nc,Unknown_0x409FB

Unknown_0x409F9:
	ld a,$04

Unknown_0x409FB:
	pop hl
	ld [hl],a
	ret

Logged_0x409FE:
	pop hl
	ld a,$04
	ld [hl],a
	ld a,b
	or a
	jr nz,Logged_0x40A1B
	ld hl,$0006
	add hl,de
	call Logged_0x43261
	ld hl,$000A
	add hl,de
	call Logged_0x43261
	jr nz,Logged_0x40A1B
	ld hl,$0010
	add hl,de
	inc [hl]

Logged_0x40A1B:
	ret

Logged_0x40A1C:
	xor a
	ld [$D28D],a
	ld hl,$D28E
	res 5,[hl]
	ld hl,$0010
	add hl,de
	ld a,$07
	ld [hl],a
	ret

Logged_0x40A2D:
	ld a,$04
	ld [$C235],a
	ret

Logged_0x40A33:
	ld a,$0A
	ld [$C235],a
	ret
	ld c,$00
	call Logged_0x43A09
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x40A4A
	dw Logged_0x40A5F
	dw Unknown_0x40A9F

Logged_0x40A4A:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	cp $03
	jr nz,Logged_0x40A5A
	ld a,$02
	ld c,$01
	call Logged_0x43277

Logged_0x40A5A:
	ld hl,$0010
	add hl,de
	inc [hl]

Logged_0x40A5F:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	sla a
	ld c,a
	ld b,$00
	ld hl,$D291
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0003
	add hl,de
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0007
	add hl,de
	ld a,[bc]
	ld [hl],a
	ld hl,$0011
	add hl,de
	ld a,[hl]
	cp $03
	ret nz
	ld hl,$000C
	add hl,de
	bit 7,[hl]
	jr nz,Logged_0x40A9A
	ld a,[$D28D]
	bit 7,a
	jr z,Logged_0x40A9A
	ld a,$02
	ld c,$01
	call Logged_0x43277

Logged_0x40A9A:
	ld a,[$D28D]
	ld [hl],a
	ret

Unknown_0x40A9F:
	ret
	ld hl,$0014
	add hl,de
	inc [hl]
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x40AB5
	dw Logged_0x40B03
	dw Logged_0x40B63
	dw Logged_0x40BEE
	dw Unknown_0x40D75

Logged_0x40AB5:
	ld a,$95
	ld [de],a
	ld hl,$0001
	add hl,de
	ld a,$94
	ld [hl],a
	ld hl,$001A
	add hl,de
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld b,$68
	ld c,$88
	xor a
	ld hl,$0004
	add hl,de
	ld [hld],a
	ld [hl],b
	ld hl,$0008
	add hl,de
	ld [hld],a
	ld [hl],c
	xor a
	ld hl,$0006
	add hl,de
	ld [hld],a
	ld [hl],a
	ld hl,$000A
	add hl,de
	ld [hld],a
	ld [hl],a
	ld hl,$0011
	add hl,de
	ld a,$20
	ld [hli],a
	ld hl,$0013
	add hl,de
	ld a,$02
	ld [hl],a
	ld a,$00
	ld c,$00
	call Logged_0x43277
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x40B03:
	ld a,[$FF00+$91]
	cp $04
	ret z
	ld hl,$0011
	add hl,de
	dec [hl]
	jr z,Logged_0x40B3B
	ld hl,$000A
	add hl,de
	ld a,[hl]
	cp $80
	jr z,Logged_0x40B2E
	ld a,$80
	ld [hld],a
	ld a,$FF
	ld [hl],a
	ld hl,$0006
	add hl,de
	ld a,$00
	ld [hld],a
	ld a,$FE
	ld [hl],a
	ld hl,$DC09
	set 6,[hl]
	ret

Logged_0x40B2E:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	add a,$30
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ret

Logged_0x40B3B:
	inc [hl]
	xor a
	ld hl,$0006
	add hl,de
	ld [hld],a
	ld [hl],a
	ld hl,$000A
	add hl,de
	ld [hld],a
	ld [hl],a
	ld hl,$0004
	add hl,de
	xor a
	ld [hld],a
	ld a,$80
	ld [hl],a
	ld hl,$0008
	add hl,de
	xor a
	ld [hld],a
	ld a,$78
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

Logged_0x40B63:
	push de
	ld c,$05
	call Logged_0x43A09
	pop de
	ld hl,$001C
	add hl,de
	ld a,[hli]
	or [hl]
	jr nz,Logged_0x40B99
	ld hl,$0019
	add hl,de
	ld a,[$D286]
	ld [hl],a
	ld hl,$4D76
	ld a,[$D286]
	sla a
	add a,l
	ld l,a
	ld a,$00
	adc a,h
	ld h,a
	ld c,[hl]
	inc hl
	ld b,[hl]
	ld hl,$001A
	add hl,de
	ld [hl],c
	inc hl
	ld [hl],b
	inc hl
	ld a,$03
	ld [hli],a
	ld a,$01
	ld [hl],a

Logged_0x40B99:
	push de
	ld hl,$001A
	add hl,de
	push hl
	ld e,[hl]
	inc hl
	ld d,[hl]
	inc hl
	ld b,[hl]
	inc hl
	ld c,[hl]
	ld a,[de]
	inc de
	inc a
	dec a
	jr z,Logged_0x40BBF
	push de
	push bc
	push af
	push bc
	sla c
	rl b
	call Logged_0x26C2
	pop de
	call Logged_0x2FD4
	pop af
	ld [hl],a
	pop bc
	pop de

Logged_0x40BBF:
	inc c
	ld a,$08
	cp c
	jr nz,Logged_0x40BE4
	ld c,$01
	inc b
	ld a,$08
	cp b
	jr nz,Logged_0x40BE4
	ld bc,$0000
	ld de,$0000
	pop hl
	ld [hl],e
	inc hl
	ld [hl],d
	inc hl
	ld [hl],b
	inc hl
	ld [hl],c
	pop de
	ld hl,$0010
	add hl,de
	ld a,$03
	ld [hl],a
	ret

Logged_0x40BE4:
	pop hl
	ld [hl],e
	inc hl
	ld [hl],d
	inc hl
	ld [hl],b
	inc hl
	ld [hl],c
	pop de
	ret

Logged_0x40BEE:
	ld a,[$D286]
	cp $03
	jr nz,Logged_0x40C0D
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld a,$8C
	ld [de],a
	ld hl,$0010
	add hl,de
	ld a,$04
	ld [hl],a
	ret

Logged_0x40C0D:
	push de
	ld c,$05
	call Logged_0x43A09
	pop de
	ld hl,$0007
	add hl,de
	ld a,[hli]
	and $0F
	cp $08
	ret nz
	ld a,[hl]
	inc a
	dec a
	ret nz
	ld hl,$0003
	add hl,de
	ld a,[hli]
	and $0F
	ret nz
	ld a,[hl]
	inc a
	dec a
	ret nz
	ld hl,$0019
	add hl,de
	ld a,[$D286]
	cp [hl]
	jr z,Logged_0x40C4D
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

Logged_0x40C4D:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	sub $10
	and $F0
	ld c,a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	sub $08
	and $F0
	swap a
	or c
	ld c,a
	ld a,[$D286]
	sla a
	add a,$1B
	ld l,a
	ld a,$00
	adc a,$4D
	ld h,a
	ld a,[hli]
	ld h,[hl]
	ld l,a

Logged_0x40C74:
	inc hl
	inc hl
	ld a,[hl]
	cp $FF
	jr z,Logged_0x40CA2
	cp c
	jr nz,Logged_0x40C74
	inc hl
	ld a,[hl]
	ld b,c
	ld hl,$0013
	add hl,de
	ld c,[hl]
	inc c
	jr Logged_0x40C8D

Logged_0x40C89:
	srl a
	srl a

Logged_0x40C8D:
	dec c
	jr nz,Logged_0x40C89
	and $03
	jr nz,Logged_0x40CE6
	ld a,b
	and $F0
	cp $30
	jr nz,Logged_0x40C9F
	ld a,$02
	jr Logged_0x40CE6

Logged_0x40C9F:
	xor a
	jr Logged_0x40CE6

Logged_0x40CA2:
	ld hl,$0013
	add hl,de
	ld a,[hl]
	sla a
	add a,$DE
	ld l,a
	ld a,$00
	adc a,$4C
	ld h,a
	ld c,[hl]
	inc hl
	ld b,[hl]
	push de
	ld hl,$0007
	add hl,de
	ld a,[hl]
	add a,b
	ld hl,$0003
	add hl,de
	ld e,a
	ld a,[hl]
	add a,c
	ld d,a
	ld bc,$0280
	call Logged_0x2F6C
	pop de
	jr nz,Logged_0x40CD3
	ld hl,$0013
	add hl,de
	ld a,[hl]
	jr Logged_0x40CE6

Logged_0x40CD3:
	ld hl,$0013
	add hl,de
	ld a,[hl]
	inc a
	and $03
	ld [hl],a
	jr Logged_0x40CA2

LoggedData_0x40CDE:
INCBIN "baserom.gb", $40CDE, $40CE6 - $40CDE

Logged_0x40CE6:
	ld hl,$0013
	add hl,de
	ld [hl],a
	sla a
	sla a
	add a,$0B
	ld c,a
	ld a,$00
	adc a,$4D
	ld b,a
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ret

LoggedData_0x40D0B:
INCBIN "baserom.gb", $40D0B, $40D21 - $40D0B

UnknownData_0x40D21:
INCBIN "baserom.gb", $40D21, $40D23 - $40D21

LoggedData_0x40D23:
INCBIN "baserom.gb", $40D23, $40D72 - $40D23

UnknownData_0x40D72:
INCBIN "baserom.gb", $40D72, $40D73 - $40D72

LoggedData_0x40D73:
INCBIN "baserom.gb", $40D73, $40D74 - $40D73

UnknownData_0x40D74:
INCBIN "baserom.gb", $40D74, $40D75 - $40D74

Unknown_0x40D75:
	ret

LoggedData_0x40D76:
INCBIN "baserom.gb", $40D76, $40DE5 - $40D76
	ld hl,$0010
	add hl,de
	ld a,[hl]
	cp $0E
	jr nc,Logged_0x40DF9
	ld a,[$D291]
	or a
	jr nz,Logged_0x40DF9
	ld c,$03
	call Logged_0x43A09

Logged_0x40DF9:
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x40E23
	dw Logged_0x40EDF
	dw Logged_0x40F37
	dw Logged_0x40F68
	dw Logged_0x40F6E
	dw Logged_0x40FC2
	dw Logged_0x40FD6
	dw Logged_0x41021
	dw Logged_0x410A2
	dw Logged_0x410D2
	dw Logged_0x411B5
	dw Logged_0x41336
	dw Logged_0x414AC
	dw Logged_0x414BA
	dw Logged_0x41501
	dw Logged_0x41520
	dw Logged_0x4152B
	dw Logged_0x4152C

Logged_0x40E23:
	push de
	call Logged_0x3069
	pop de
	jr c,Logged_0x40E6E
	push de
	push hl
	ld hl,$0001
	add hl,de
	ld a,[hl]
	ld hl,$D28D
	pop de
	ld [hl],e
	inc hl
	ld [hl],d
	ld hl,$0001
	add hl,de
	ld [hl],a
	ld [de],a
	ld hl,$0010
	add hl,de
	ld a,$10
	ld [hl],a
	ld a,$40
	ld hl,$0003
	add hl,de
	ld [hl],a
	ld a,$48
	ld hl,$0007
	add hl,de
	ld [hl],a
	xor a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$001F
	add hl,de
	set 0,[hl]
	ld a,$30
	ld c,$0C
	call Logged_0x43277
	pop de

Logged_0x40E6E:
	ld hl,$0003
	add hl,de
	ld a,$E0
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$0007
	add hl,de
	ld a,$48
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$0005
	add hl,de
	ld a,$01
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$0009
	add hl,de
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$00
	ld c,$00
	call Logged_0x43277
	ld a,$08
	call Logged_0x1331
	ld hl,$001B
	add hl,de
	ld [hl],a
	xor a
	ld [$D286],a
	ld [$D291],a
	ld hl,$0019
	add hl,de
	ld [hl],a
	ld hl,$DC08
	set 2,[hl]
	ld hl,$001A
	add hl,de
	ld a,$04
	ld [hl],a
	ld a,$03
	call Logged_0x1331
	ld hl,$001D
	add hl,de
	ld [hl],a
	ld hl,$001C
	add hl,de
	ld [hl],a
	ld hl,$D287
	ld a,$D2
	ld [hli],a
	ld a,$01
	ld [hli],a
	ld hl,$001F
	add hl,de
	res 0,[hl]
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x40EDF:
	ld hl,$001C
	add hl,de
	ld a,[hl]
	inc a
	ld [hl],a
	and $03
	jr z,Logged_0x40EFE
	ld a,[hl]
	srl a
	srl a
	and $03
	ld c,a
	ld b,$00
	ld hl,$4F33
	add hl,bc
	ld a,[hl]
	ld c,$00
	call Logged_0x43277

Logged_0x40EFE:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	cp $40
	ret nz
	ld hl,$0005
	add hl,de
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$D28D
	ld c,[hl]
	inc hl
	ld b,[hl]
	ld hl,$0003
	add hl,bc
	ld a,$C0
	ld [hl],a
	ld a,$33
	ld c,$0D
	call Logged_0x43277
	ld hl,$DC08
	set 3,[hl]
	ld hl,$001C
	add hl,de
	ld a,$78
	ld [hl],a
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

LoggedData_0x40F33:
INCBIN "baserom.gb", $40F33, $40F37 - $40F33

Logged_0x40F37:
	ld hl,$001C
	add hl,de
	ld a,$70
	cp [hl]
	jr nc,Logged_0x40F4D
	ld a,$03
	push hl
	call Logged_0x1331
	pop hl
	dec a
	ld [$C0DE],a
	jr Logged_0x40F51

Logged_0x40F4D:
	xor a
	ld [$C0DE],a

Logged_0x40F51:
	dec [hl]
	ret nz
	ld a,$00
	ld c,$00
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$0010
	add hl,de
	ld a,$05
	ld [hl],a
	ret

Logged_0x40F68:
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x40F6E:
	ld hl,$001A
	add hl,de
	dec [hl]
	jr nz,Logged_0x40FA0
	ld hl,$0019
	add hl,de
	ld a,[hl]
	cp $02
	jr z,Logged_0x40F98
	ld hl,$0019
	add hl,de
	ld a,$00
	ld [hl],a
	ld a,$03
	call Logged_0x1331
	ld hl,$001D
	add hl,de
	ld [hl],a
	ld hl,$001A
	add hl,de
	ld a,$03
	ld [hl],a
	jr Logged_0x40FBA

Logged_0x40F98:
	ld hl,$0010
	add hl,de
	ld a,$05
	ld [hl],a
	ret

Logged_0x40FA0:
	ld hl,$0019
	add hl,de
	ld a,[hl]
	cp $02
	jr z,Logged_0x40FBA
	ld hl,$001A
	add hl,de
	dec [hl]
	jr nz,Logged_0x40FB9
	push hl
	ld hl,$0019
	add hl,de
	ld a,$01
	ld [hl],a
	pop hl

Logged_0x40FB9:
	inc [hl]

Logged_0x40FBA:
	ld hl,$0010
	add hl,de
	ld a,$09
	ld [hl],a
	ret

Logged_0x40FC2:
	ld a,$20
	ld c,$08
	call Logged_0x43277
	ld hl,$001C
	add hl,de
	ld a,$78
	ld [hl],a
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x40FD6:
	ld hl,$001C
	add hl,de
	dec [hl]
	ret nz
	inc [hl]
	ld a,[$C220]
	cp $00
	ret z
	ld hl,$001C
	add hl,de
	ld a,$02
	ld [hl],a
	ld a,[$D286]
	ld c,a
	sla a
	add a,c
	add a,$02
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld a,$24
	ld c,$09
	call Logged_0x43277
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

UnknownData_0x41005:
INCBIN "baserom.gb", $41005, $41021 - $41005

Logged_0x41021:
	ld hl,$001C
	add hl,de
	dec [hl]
	ret nz
	push de
	call Logged_0x3069
	pop de
	jr c,Logged_0x4106A
	push de
	push hl
	ld hl,$0003
	add hl,de
	ld b,[hl]
	ld hl,$0007
	add hl,de
	ld c,[hl]
	ld hl,$0001
	add hl,de
	ld a,[hl]
	pop de
	ld hl,$0001
	add hl,de
	ld [hl],a
	ld [de],a
	ld hl,$0010
	add hl,de
	ld a,$11
	ld [hl],a
	xor a
	ld hl,$0004
	add hl,de
	ld [hld],a
	ld [hl],b
	ld hl,$0008
	add hl,de
	ld [hld],a
	ld [hl],c
	call Logged_0x4158B
	ld a,$2B
	ld c,$0B
	call Logged_0x43277
	ld hl,$DC0B
	set 3,[hl]
	pop de

Logged_0x4106A:
	ld hl,$001A
	add hl,de
	dec [hl]
	jr z,Logged_0x41088
	ld a,[$D286]
	sla a
	sla a
	sla a
	sla a
	sla a
	ld c,a
	ld a,$70
	sub c
	ld hl,$001C
	add hl,de
	ld [hl],a
	ret

Logged_0x41088:
	ld a,$20
	ld c,$08
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$001C
	add hl,de
	ld a,$78
	ld [hl],a
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x410A2:
	ld hl,$001C
	add hl,de
	dec [hl]
	ret nz
	ld hl,$0019
	add hl,de
	ld a,$00
	ld [hl],a
	ld a,$08
	call Logged_0x1331
	ld hl,$001B
	add hl,de
	ld [hl],a
	ld hl,$001A
	add hl,de
	ld a,$04
	ld [hl],a
	ld a,$03
	call Logged_0x1331
	ld hl,$001D
	add hl,de
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$04
	ld [hl],a
	ret

Logged_0x410D2:
	ld hl,$0019
	add hl,de
	ld a,[hl]
	cp $02
	jr z,Logged_0x410E2
	ld hl,$001D
	add hl,de
	ld b,[hl]
	jr Logged_0x410E8

Logged_0x410E2:
	ld a,$03
	call Logged_0x1331
	ld b,a

Logged_0x410E8:
	ld hl,$001B
	add hl,de
	ld a,[hl]

Logged_0x410ED:
	dec b
	jr z,Logged_0x4110D
	dec b
	jr z,Logged_0x41103
	call Logged_0x4117B
	jr z,Logged_0x41115
	push af
	ld a,$02
	call Logged_0x1331
	ld b,a
	pop af
	inc b
	jr Logged_0x410ED

Logged_0x41103:
	dec a
	and $07
	call Logged_0x4117B
	jr nz,Logged_0x41103
	jr Logged_0x41115

Logged_0x4110D:
	inc a
	and $07
	call Logged_0x4117B
	jr nz,Logged_0x4110D

Logged_0x41115:
	push hl
	ld hl,$0012
	add hl,de
	ld [hl],b
	ld hl,$0011
	add hl,de
	ld [hl],c
	ld hl,$D28F
	pop bc
	ld [hl],c
	inc hl
	ld [hl],b
	ld hl,$001B
	add hl,de
	ld [hl],a
	ld hl,$0019
	add hl,de
	ld a,[hl]
	cp $02
	jr nz,Logged_0x41142
	ld hl,$001C
	add hl,de
	ld a,$01
	ld [hl],a
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x41142:
	ld hl,$001B
	add hl,de
	ld a,[hl]
	call Logged_0x4115D
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$001C
	add hl,de
	ld a,$08
	ld [hl],a
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x4115D:
	ld c,a
	ld b,$00
	ld hl,$516B
	add hl,bc
	ld a,[hl]
	ld c,$00
	call Logged_0x43277
	ret

LoggedData_0x4116B:
INCBIN "baserom.gb", $4116B, $4117B - $4116B

Logged_0x4117B:
	push de
	push af
	sla a
	ld c,a
	ld b,$00
	ld hl,$51A5
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0003
	add hl,de
	ld a,[bc]
	add a,[hl]
	inc bc
	ld hl,$0007
	add hl,de
	ld d,a
	ld a,[bc]
	add a,[hl]
	ld e,a
	pop af
	push de
	push af
	call Logged_0x2FA4
	ld a,[hl]
	cp $08
	pop bc
	ld a,b
	pop bc
	pop de
	ret

LoggedData_0x411A5:
INCBIN "baserom.gb", $411A5, $411B5 - $411A5

Logged_0x411B5:
	ld hl,$001C
	add hl,de
	dec [hl]
	ret nz
	push de
	ld hl,$001B
	add hl,de
	ld a,[hl]
	push af
	ld hl,$0019
	add hl,de
	ld a,[hl]
	push af
	ld hl,$0003
	add hl,de
	ld b,[hl]
	ld hl,$0007
	add hl,de
	ld c,[hl]
	ld hl,$D28D
	ld e,[hl]
	inc hl
	ld d,[hl]
	xor a
	ld hl,$0004
	add hl,de
	ld [hld],a
	ld [hl],b
	ld hl,$0008
	add hl,de
	ld [hld],a
	ld [hl],c
	pop af
	cp $02
	jr nz,Logged_0x411F4
	pop af
	ld a,$36
	ld c,$0A
	call Logged_0x43277
	jr Logged_0x411FD

Logged_0x411F4:
	pop af
	call Logged_0x4115D
	ld a,$01
	ld [$D291],a

Logged_0x411FD:
	pop de
	ld a,$30
	ld c,$0C
	call Logged_0x43277
	ld hl,$0019
	add hl,de
	ld a,[hl]
	push af
	dec a
	jr z,Logged_0x41218
	dec a
	jr z,Logged_0x4121F
	ld hl,$DC09
	set 6,[hl]
	jr Logged_0x41224

Logged_0x41218:
	ld hl,$DC09
	set 7,[hl]
	jr Logged_0x41224

Logged_0x4121F:
	ld hl,$DC0A
	set 1,[hl]

Logged_0x41224:
	pop af
	swap a
	srl a
	ld hl,$001B
	add hl,de
	add a,[hl]
	sla a
	sla a
	sla a
	ld c,a
	ld b,$00
	ld hl,$5276
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0014
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$001C
	add hl,de
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0017
	add hl,de
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0015
	add hl,de
	xor a
	ld [hli],a
	ld [hl],a
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

LoggedData_0x41276:
INCBIN "baserom.gb", $41276, $41336 - $41276

Logged_0x41336:
	ld hl,$0013
	add hl,de
	ld b,[hl]
	inc hl
	ld c,[hl]
	push hl
	ld hl,$0016
	add hl,de
	ld a,[hl]
	add a,c
	ld [hld],a
	ld a,[hl]
	adc a,b
	ld [hl],a
	ld a,c
	ld hl,$0017
	add hl,de
	ld c,[hl]
	pop hl
	sub c
	ld [hld],a
	ld a,b
	sbc a,$00
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$0015
	add hl,de
	push hl
	sub [hl]
	ld b,a
	ld hl,$0007
	add hl,de
	ld c,[hl]
	push de
	ld hl,$D28D
	ld e,[hl]
	inc hl
	ld d,[hl]
	ld hl,$0003
	add hl,de
	ld [hl],b
	ld hl,$0007
	add hl,de
	ld [hl],c
	pop de
	push de
	ld hl,$0013
	add hl,de
	ld a,[hli]
	or [hl]
	jr nz,Logged_0x413A8
	ld hl,$001B
	add hl,de
	ld c,[hl]
	ld hl,$0019
	add hl,de
	ld a,[hl]
	ld hl,$D28D
	ld e,[hl]
	inc hl
	ld d,[hl]
	dec a
	jr z,Logged_0x413A2
	dec a
	jr z,Logged_0x41399
	jr Logged_0x413A8

Logged_0x41399:
	ld a,$27
	ld c,$0A
	call Logged_0x43277
	jr Logged_0x413A8

Logged_0x413A2:
	ld a,c
	add a,$08
	call Logged_0x4115D

Logged_0x413A8:
	pop de
	ld hl,$001F
	add hl,de
	set 0,[hl]
	pop hl
	ld a,[hl]
	cp $09
	jr c,Logged_0x413B8
	jp Logged_0x41441

Logged_0x413B8:
	ld hl,$001F
	add hl,de
	res 0,[hl]
	ld hl,$0013
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x41441
	xor a
	ld [$D291],a
	ld hl,$D28F
	ld c,[hl]
	inc hl
	ld b,[hl]
	ld a,[bc]
	cp $6E
	jr nz,Logged_0x41441
	ld hl,$D28D
	ld c,[hl]
	inc hl
	ld b,[hl]
	ld hl,$0003
	add hl,bc
	ld a,$C0
	ld [hl],a
	xor a
	ld hl,$0006
	add hl,de
	ld [hld],a
	ld [hl],a
	ld hl,$000A
	add hl,de
	ld [hld],a
	ld [hl],a
	ld hl,$0012
	add hl,de
	ld b,[hl]
	ld hl,$0011
	add hl,de
	ld c,[hl]
	xor a
	ld hl,$0004
	add hl,de
	ld [hld],a
	ld [hl],b
	ld hl,$0008
	add hl,de
	ld [hld],a
	ld [hl],c
	ld a,$33
	ld c,$0D
	call Logged_0x43277
	ld a,[$D286]
	cp $02
	jr z,Logged_0x4141D
	ld hl,$DC09
	set 2,[hl]
	ld a,$3C
	jr Logged_0x41434

Logged_0x4141D:
	ld hl,$D12B
	set 4,[hl]
	ld hl,$D12A
	res 5,[hl]
	ld hl,$001C
	add hl,de
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0F
	ld [hl],a
	ret

Logged_0x41434:
	ld hl,$001C
	add hl,de
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0D
	ld [hl],a
	ret

Logged_0x41441:
	ld hl,$001C
	add hl,de
	dec [hl]
	ret nz
	ld hl,$D28D
	ld c,[hl]
	inc hl
	ld b,[hl]
	ld hl,$0003
	add hl,bc
	ld a,$C0
	ld [hl],a
	xor a
	ld hl,$0006
	add hl,de
	ld [hld],a
	ld [hl],a
	ld hl,$000A
	add hl,de
	ld [hld],a
	ld [hl],a
	ld hl,$0012
	add hl,de
	ld b,[hl]
	ld hl,$0011
	add hl,de
	ld c,[hl]
	xor a
	ld hl,$0004
	add hl,de
	ld [hld],a
	ld [hl],b
	ld hl,$0008
	add hl,de
	ld [hld],a
	ld [hl],c
	ld hl,$0019
	add hl,de
	ld a,[hl]
	cp $02
	jr nz,Logged_0x41491
	ld a,$36
	ld c,$0A
	call Logged_0x43277
	ld hl,$001C
	add hl,de
	ld a,$01
	ld [hl],a
	jr Logged_0x414A6

Logged_0x41491:
	ld hl,$001B
	add hl,de
	ld a,[hl]
	call Logged_0x4115D
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$001C
	add hl,de
	ld a,$08
	ld [hl],a

Logged_0x414A6:
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x414AC:
	ld hl,$001C
	add hl,de
	dec [hl]
	ret nz
	ld hl,$0010
	add hl,de
	ld a,$03
	ld [hl],a
	ret

Logged_0x414BA:
	ld hl,$001C
	add hl,de
	dec [hl]
	ret nz
	ld a,[$D286]
	inc a
	ld [$D286],a
	cp $03
	jr z,Logged_0x414E8
	ld a,$36
	ld c,$0A
	call Logged_0x43277
	ld hl,$0019
	add hl,de
	ld a,$02
	ld [hl],a
	ld hl,$001A
	add hl,de
	ld a,$09
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$03
	ld [hl],a
	ret

Logged_0x414E8:
	ld hl,$0005
	add hl,de
	ld bc,$FE00
	ld [hl],b
	inc hl
	ld [hl],c
	ld hl,$D287
	ld a,$D2
	ld [hli],a
	ld a,$01
	ld [hli],a
	ld hl,$0010
	add hl,de
	inc [hl]
	ret

Logged_0x41501:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,$30
	cp $20
	jr nc,Logged_0x41513
	ld hl,$0005
	add hl,de
	xor a
	ld [hli],a
	ld [hl],a

Logged_0x41513:
	ld hl,$D287
	dec [hl]
	ret nz
	inc hl
	dec [hl]
	ret nz
	ld a,$13
	ld [$FF00+$91],a
	ret

Logged_0x41520:
	call Logged_0x432A6
	ld hl,$0010
	add hl,de
	ld a,$0D
	ld [hl],a
	ret

Logged_0x4152B:
	ret

Logged_0x4152C:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	add a,$10
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x41541
	cp $08
	jr nc,Logged_0x41547
	jr Logged_0x41584

Logged_0x41541:
	cp $B8
	jr c,Logged_0x41547
	jr Logged_0x41584

Logged_0x41547:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,$10
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x4155C
	cp $10
	jr nc,Logged_0x41562
	jr Logged_0x41584

Logged_0x4155C:
	cp $B0
	jr c,Logged_0x41562
	jr Logged_0x41584

Logged_0x41562:
	ld c,$04
	call Logged_0x43A09
	ret nc
	ld bc,$0006
	ld a,$03
	call Logged_0x1331
	dec a
	jr z,Logged_0x41576
	ld bc,$000A

Logged_0x41576:
	ld l,c
	ld h,b
	add hl,de
	ld a,[hl]
	cpl
	add a,$01
	ld [hld],a
	ld a,[hl]
	cpl
	adc a,$00
	ld [hl],a
	ret

Logged_0x41584:
	ld hl,$0000
	add hl,de
	xor a
	ld [hl],a
	ret

Logged_0x4158B:
	push de
	ld b,$00
	ld a,[$C223]
	ld c,a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	sub c
	jr nc,Logged_0x4159F
	xor $FF
	inc a
	set 1,b

Logged_0x4159F:
	ld c,a
	push bc
	ld a,[$C227]
	ld c,a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	sub c
	pop bc
	jr nc,Logged_0x415B3
	xor $FF
	inc a
	set 0,b

Logged_0x415B3:
	push bc
	push bc
	cp c
	jr c,Logged_0x415C4
	ld b,a
	ld l,$00
	ld h,c
	call Logged_0x32D9
	ld bc,$0100
	jr Logged_0x415D0

Logged_0x415C4:
	ld b,c
	ld l,$00
	ld h,a
	call Logged_0x32D9
	push hl
	ld hl,$0100
	pop bc

Logged_0x415D0:
	pop af
	bit 1,a
	jr nz,Logged_0x415DF
	ld a,l
	cpl
	add a,$01
	ld l,a
	ld a,h
	cpl
	adc a,$00
	ld h,a

Logged_0x415DF:
	pop af
	bit 0,a
	jr nz,Logged_0x415EE
	ld a,c
	cpl
	add a,$01
	ld c,a
	ld a,b
	cpl
	adc a,$00
	ld b,a

Logged_0x415EE:
	pop de
	push bc
	push hl
	push hl
	ld hl,$0009
	add hl,de
	ld [hl],b
	inc hl
	ld [hl],c
	pop bc
	ld hl,$0005
	add hl,de
	ld [hl],b
	inc hl
	ld [hl],c
	pop bc
	ld hl,$0004
	call Logged_0x41610
	pop bc
	ld hl,$0008
	call Logged_0x41610
	ret

Logged_0x41610:
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	add hl,de
	ld a,[hl]
	add a,c
	ld [hld],a
	ld a,[hl]
	adc a,b
	ld [hl],a
	ret
	ld c,$01
	call Logged_0x43A09
	jr nc,Logged_0x41635
	call Logged_0x43252
	call Logged_0x43243

Logged_0x41635:
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x41651
	dw Logged_0x4169B
	dw Logged_0x41718
	dw Unknown_0x41891
	dw Logged_0x41892
	dw Logged_0x419DA
	dw Logged_0x41A16
	dw Logged_0x41ABC
	dw Unknown_0x41B09
	dw Logged_0x41B0A
	dw Logged_0x41B43

Logged_0x41651:
	ld a,$10
	ld c,$03
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	set 7,[hl]
	inc hl
	xor a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld a,$50
	ld hl,$0007
	add hl,de
	ld [hli],a
	ld hl,$0014
	add hl,de
	ld [hli],a
	ld a,$50
	ld hl,$0003
	add hl,de
	ld [hli],a
	ld hl,$0013
	add hl,de
	ld [hli],a
	xor a
	ld [$FF00+$49],a
	ld hl,$0012
	add hl,de
	ld a,$3C
	ld [hl],a
	ld hl,$DC0B
	set 4,[hl]
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x4169B:
	ld hl,$0012
	add hl,de
	ld a,[hl]
	or a
	jr nz,Logged_0x416A6
	jp Logged_0x41700

Logged_0x416A6:
	dec a
	ld [hl],a
	push af
	push af
	swap a
	and $03
	ld hl,$D141
	bit 7,[hl]
	jr nz,Logged_0x416B7
	add a,$04

Logged_0x416B7:
	ld c,a
	ld b,$00
	ld hl,$56F8
	add hl,bc
	ld a,[hl]
	ld [$FF00+$49],a
	ld hl,$0014
	add hl,de
	ld a,[hli]
	pop hl
	bit 0,h
	jr z,Logged_0x416D2
	srl h
	srl h
	sub h
	jr Logged_0x416D7

Logged_0x416D2:
	srl h
	srl h
	add a,h

Logged_0x416D7:
	ld hl,$0007
	add hl,de
	ld [hli],a
	ld hl,$0013
	add hl,de
	ld a,[hli]
	pop hl
	bit 1,h
	jr z,Logged_0x416ED
	srl h
	srl h
	sub h
	jr Logged_0x416F2

Logged_0x416ED:
	srl h
	srl h
	add a,h

Logged_0x416F2:
	ld hl,$0003
	add hl,de
	ld [hli],a
	ret

LoggedData_0x416F8:
INCBIN "baserom.gb", $416F8, $416FC - $416F8

UnknownData_0x416FC:
INCBIN "baserom.gb", $416FC, $41700 - $416FC

Logged_0x41700:
	ld a,$00
	ld c,$00
	call Logged_0x43277
	ld hl,$0011
	add hl,de
	ld a,$B4
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

Logged_0x41718:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x4172C
	sub $0C
	jr nc,Logged_0x41733
	jp Logged_0x41B84

Logged_0x4172C:
	sub $95
	jr c,Logged_0x41733
	jp Logged_0x41B84

Logged_0x41733:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x41747
	sub $14
	jr nc,Logged_0x4174E
	jp Logged_0x41B84

Logged_0x41747:
	sub $8D
	jr c,Logged_0x4174E
	jp Logged_0x41B84

Logged_0x4174E:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	sub $01
	ld [hli],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr nc,Logged_0x4175F
	jp Logged_0x41B67

Logged_0x4175F:
	ld hl,$0015
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x417A5
	dec a
	jr z,Logged_0x4178E
	dec a
	jr z,Logged_0x41784
	dec a
	jr z,Unknown_0x4177A
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr nz,Logged_0x41798
	jr Logged_0x417A5

Unknown_0x4177A:
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x41798
	jr Logged_0x417A5

Logged_0x41784:
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr nz,Logged_0x41798
	jr Logged_0x417A5

Logged_0x4178E:
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x41798
	jr Logged_0x417A5

Logged_0x41798:
	ld a,$00
	ld c,$00
	call Logged_0x43277
	ld hl,$0015
	add hl,de
	xor a
	ld [hl],a

Logged_0x417A5:
	ld hl,$001F
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x41814
	res 6,[hl]
	ld a,[$DC05]
	or $04
	ld [$DC05],a
	ld hl,$0012
	add hl,de
	ld a,[hld]
	or a
	jr nz,Logged_0x417CC
	ld a,[hl]
	cp $78
	jr nc,Logged_0x417CC
	ld a,[hl]
	add a,$78
	ld [hli],a
	ld a,[hl]
	adc a,$00
	ld [hl],a

Logged_0x417CC:
	ld hl,$001E
	add hl,de
	ld a,[hl]
	and $30
	swap a
	inc a
	ld hl,$0015
	add hl,de
	ld [hl],a
	push af
	ld c,a
	sla a
	sla a
	add a,c
	add a,$22
	ld c,$00
	call Logged_0x43277
	pop af
	ld bc,$0160
	ld hl,$0006
	dec a
	jr z,Logged_0x41809
	dec a
	jr z,Logged_0x417FC
	ld hl,$000A
	dec a
	jr z,Logged_0x41809

Logged_0x417FC:
	add hl,de
	ld a,[hl]
	ld a,$00
	add a,c
	ld [hld],a
	ld a,[hl]
	ld a,$00
	adc a,b
	ld [hl],a
	jr Logged_0x41814

Logged_0x41809:
	add hl,de
	ld a,[hl]
	ld a,$00
	sub c
	ld [hld],a
	ld a,[hl]
	ld a,$00
	sbc a,b
	ld [hl],a

Logged_0x41814:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$0014
	add hl,de
	sub [hl]
	jr z,Logged_0x41852
	jr c,Logged_0x4183B
	ld c,$05
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x4182E
	ld c,$04

Logged_0x4182E:
	ld hl,$000A
	add hl,de
	ld a,[hl]
	sub c
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr Logged_0x41852

Logged_0x4183B:
	ld c,$05
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr nz,Logged_0x41847
	ld c,$04

Logged_0x41847:
	ld hl,$000A
	add hl,de
	ld a,[hl]
	add a,c
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a

Logged_0x41852:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$0013
	add hl,de
	sub [hl]
	jr z,Logged_0x41890
	jr c,Logged_0x41879
	ld c,$05
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x4186C
	ld c,$04

Logged_0x4186C:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	sub c
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr Logged_0x41890

Logged_0x41879:
	ld c,$05
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr nz,Logged_0x41885
	ld c,$04

Logged_0x41885:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	add a,c
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a

Logged_0x41890:
	ret

Unknown_0x41891:
	ret

Logged_0x41892:
	ld b,$00
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$0014
	add hl,de
	sub [hl]
	jr z,Logged_0x41909
	inc b
	jr c,Unknown_0x418D7
	ld c,$10
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr z,Unknown_0x418CA
	ld c,$04
	sla a
	jr c,Unknown_0x418BB
	sla a
	jr c,Unknown_0x418BB
	sla a
	jr nc,Unknown_0x418BD

Unknown_0x418BB:
	ld a,$FF

Unknown_0x418BD:
	cp $FC
	jr c,Unknown_0x418C3
	ld a,$FB

Unknown_0x418C3:
	xor $FF
	inc a
	inc hl
	cp [hl]
	jr nc,Unknown_0x418FE

Unknown_0x418CA:
	ld hl,$000A
	add hl,de
	ld a,[hl]
	sub c
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr Logged_0x41909

Unknown_0x418D7:
	ld c,$10
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr nz,Unknown_0x418FE
	ld c,$04
	sla a
	jr nc,Unknown_0x418EF
	sla a
	jr nc,Unknown_0x418EF
	sla a
	jr c,Unknown_0x418F1

Unknown_0x418EF:
	ld a,$01

Unknown_0x418F1:
	cp $05
	jr nc,Unknown_0x418F7
	ld a,$05

Unknown_0x418F7:
	xor $FF
	inc a
	inc hl
	cp [hl]
	jr c,Unknown_0x418CA

Unknown_0x418FE:
	ld hl,$000A
	add hl,de
	ld a,[hl]
	add a,c
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a

Logged_0x41909:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$0013
	add hl,de
	sub [hl]
	jr z,Logged_0x4197E
	inc b
	jr c,Unknown_0x4194C
	ld c,$10
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr z,Unknown_0x4193F
	ld c,$04
	sla a
	jr c,Unknown_0x41930
	sla a
	jr c,Unknown_0x41930
	sla a
	jr nc,Unknown_0x41932

Unknown_0x41930:
	ld a,$FF

Unknown_0x41932:
	cp $FC
	jr c,Unknown_0x41938
	ld a,$FB

Unknown_0x41938:
	xor $FF
	inc a
	inc hl
	cp [hl]
	jr nc,Unknown_0x41973

Unknown_0x4193F:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	sub c
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr Logged_0x4197E

Unknown_0x4194C:
	ld c,$10
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr nz,Unknown_0x41973
	ld c,$04
	sla a
	jr nc,Unknown_0x41964
	sla a
	jr nc,Unknown_0x41964
	sla a
	jr c,Unknown_0x41966

Unknown_0x41964:
	ld a,$01

Unknown_0x41966:
	cp $05
	jr nc,Unknown_0x4196C
	ld a,$05

Unknown_0x4196C:
	xor $FF
	inc a
	inc hl
	cp [hl]
	jr c,Unknown_0x4193F

Unknown_0x41973:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	add a,c
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a

Logged_0x4197E:
	ld hl,$0012
	add hl,de
	dec [hl]
	ret nz
	push hl
	ld hl,$DC08
	set 6,[hl]
	ld hl,$0011
	add hl,de
	ld a,[hl]
	sub $04
	jr c,Logged_0x4199F
	ld [hl],a
	sub $40
	jr z,Logged_0x4199A
	jr nc,Logged_0x4199C

Logged_0x4199A:
	ld a,$04

Logged_0x4199C:
	pop hl
	ld [hl],a
	ret

Logged_0x4199F:
	pop hl
	ld a,$04
	ld [hl],a
	ld a,b
	or a
	jr nz,Logged_0x419D9
	ld hl,$0006
	add hl,de
	call Logged_0x43261
	ld hl,$000A
	add hl,de
	call Logged_0x43261
	ld hl,$0005
	add hl,de
	ld a,[hli]
	or [hl]
	ld hl,$0009
	add hl,de
	or [hl]
	inc hl
	or [hl]
	jr nz,Logged_0x419D9
	ld a,$0E
	ld c,$02
	call Logged_0x43277
	ld hl,$0011
	add hl,de
	ld a,$1E
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$05
	ld [hl],a

Logged_0x419D9:
	ret

Logged_0x419DA:
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	ld a,[$D141]
	bit 7,a
	jr z,Unknown_0x419F1
	ld a,[$DC07]
	or $10
	ld [$DC07],a
	jr Logged_0x419F9

Unknown_0x419F1:
	ld a,[$DC07]
	or $08
	ld [$DC07],a

Logged_0x419F9:
	ld a,$10
	ld c,$03
	call Logged_0x43277
	ld hl,$0011
	add hl,de
	ld a,$3C
	ld [hl],a
	ld hl,$0012
	add hl,de
	ld a,$3C
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$06
	ld [hl],a
	ret

Logged_0x41A16:
	ld hl,$0012
	add hl,de
	ld a,[hl]
	or a
	jr z,Logged_0x41A1F
	dec a

Logged_0x41A1F:
	ld [hl],a
	swap a
	and $03
	ld hl,$D141
	bit 0,[hl]
	jr z,Logged_0x41A2D
	add a,$04

Logged_0x41A2D:
	ld c,a
	ld b,$00
	ld hl,$5A7F
	add hl,bc
	ld a,[hl]
	ld [$C15E],a
	ld hl,$C15C
	set 1,[hl]
	or a
	jr nz,Logged_0x41A77
	ld a,[$D16A]
	ld c,a
	ld a,[$D16B]
	or c
	jr nz,Logged_0x41A77
	ld a,[$D141]
	bit 6,a
	jr nz,Logged_0x41A77
	ld bc,$C220
	ld hl,$0013
	add hl,bc
	ld a,$10
	ld [hl],a
	ld hl,$001B
	add hl,bc
	ld a,$00
	ld [hl],a
	ld hl,$0014
	add hl,bc
	set 5,[hl]
	ld a,$02
	call Logged_0x1331
	ld c,a
	ld a,[$D142]
	and $FE
	or c
	ld [$D142],a

Logged_0x41A77:
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	jr Logged_0x41A87

UnknownData_0x41A7F:
INCBIN "baserom.gb", $41A7F, $41A83 - $41A7F

LoggedData_0x41A83:
INCBIN "baserom.gb", $41A83, $41A87 - $41A83

Logged_0x41A87:
	ld a,$15
	ld c,$04
	call Logged_0x43277
	xor a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$001F
	add hl,de
	res 6,[hl]
	ld hl,$0011
	add hl,de
	ld a,$F0
	ld [hl],a
	ld hl,$0012
	add hl,de
	ld a,$3C
	ld [hl],a
	ld hl,$DC08
	set 7,[hl]
	ld hl,$0010
	add hl,de
	ld a,$07
	ld [hl],a
	ret

Logged_0x41ABC:
	ld hl,$001F
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x41AD1
	ld a,$1E
	ld [$C15E],a
	ld hl,$C15C
	set 1,[hl]
	jp Logged_0x41B4E

Logged_0x41AD1:
	ld hl,$0012
	add hl,de
	ld a,[hl]
	or a
	jr z,Logged_0x41ADA
	dec a

Logged_0x41ADA:
	ld [hl],a
	swap a
	and $03
	ld hl,$D141
	bit 7,[hl]
	jr nz,Logged_0x41AE8
	add a,$04

Logged_0x41AE8:
	ld c,a
	ld b,$00
	ld hl,$5B01
	add hl,bc
	ld a,[hl]
	ld [$C15E],a
	ld hl,$C15C
	set 1,[hl]
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	jp Logged_0x41B4E

LoggedData_0x41B01:
INCBIN "baserom.gb", $41B01, $41B07 - $41B01

UnknownData_0x41B07:
INCBIN "baserom.gb", $41B07, $41B09 - $41B07

Unknown_0x41B09:
	ret

Logged_0x41B0A:
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	ret z
	ld a,$23
	ld c,$07
	call Logged_0x43277
	call Logged_0x432A6
	ld hl,$0011
	add hl,de
	ld a,$D2
	ld [hl],a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	sub $50
	jr nc,Logged_0x41B30
	ld bc,$FFF8
	jr Logged_0x41B33

Logged_0x41B30:
	ld bc,$0008

Logged_0x41B33:
	ld hl,$000A
	add hl,de
	ld a,c
	ld [hld],a
	ld a,b
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0A
	ld [hl],a
	ret

Logged_0x41B43:
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	ld a,$13
	ld [$FF00+$91],a
	ret

Logged_0x41B4E:
	ld a,$00
	ld c,$00
	call Logged_0x43277
	ld hl,$0011
	add hl,de
	ld a,$B0
	ld [hli],a
	ld a,$04
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

Logged_0x41B67:
	ld a,$05
	ld c,$01
	call Logged_0x43277
	ld a,$68
	ld hl,$0011
	add hl,de
	ld [hl],a
	ld a,$20
	ld hl,$0012
	add hl,de
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$04
	ld [hl],a
	ret

Logged_0x41B84:
	ld a,$1A
	ld c,$06
	call Logged_0x43277
	ld hl,$0003
	add hl,de
	ld a,[hl]
	sub $08
	ld [hl],a
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld a,[$DC0A]
	or $10
	ld [$DC0A],a
	ld hl,$D12B
	set 4,[hl]
	ld hl,$D12A
	res 5,[hl]
	ld hl,$0010
	add hl,de
	ld a,$09
	ld [hl],a
	ret
	ld hl,$D289
	inc [hl]
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x41BEA
	dw Logged_0x41C5E
	dw Logged_0x41CC9
	dw Logged_0x41D95
	dw Logged_0x41E31
	dw Logged_0x41EE0
	dw Logged_0x420BC
	dw Logged_0x420BC
	dw Logged_0x420D2
	dw Logged_0x4213D
	dw Logged_0x4219D
	dw Logged_0x42230
	dw Unknown_0x42307
	dw Logged_0x4233A
	dw Logged_0x423BE
	dw Logged_0x423F1
	dw Logged_0x42430
	dw Unknown_0x4243B
	dw Logged_0x4243C

Logged_0x41BEA:
	push de
	call Logged_0x3069
	pop de
	jr c,Logged_0x41C2E
	push de
	push hl
	ld hl,$D28D
	pop de
	ld a,e
	ld [hli],a
	ld a,d
	ld [hl],a
	ld a,$01
	ld [de],a
	ld hl,$0001
	add hl,de
	ld a,$A3
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$11
	ld [hl],a
	ld a,$C0
	ld hl,$0007
	add hl,de
	ld [hli],a
	ld a,$60
	ld hl,$0003
	add hl,de
	ld [hli],a
	ld a,$3E
	ld c,$09
	call Logged_0x43277
	ld hl,$001F
	add hl,de
	set 0,[hl]
	ld hl,$000C
	add hl,de
	res 7,[hl]
	pop de

Logged_0x41C2E:
	ld a,$50
	ld hl,$0007
	add hl,de
	ld [hli],a
	ld a,$50
	ld hl,$0003
	add hl,de
	ld [hli],a
	ld a,$4E
	ld c,$0C
	call Logged_0x43277
	ld a,$1C
	ld [$FF00+$49],a
	ld hl,$0012
	add hl,de
	ld a,$3C
	ld [hl],a
	xor a
	ld [$D291],a
	dec a
	ld [$D286],a
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x41C5E:
	ld a,[$FF00+$91]
	cp $04
	ret z
	ld a,$03
	ld c,$00
	call Logged_0x43277
	xor a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0011
	add hl,de
	ld a,$2C
	ld [hli],a
	ld a,$01
	ld [hl],a
	ld hl,$001F
	add hl,de
	res 6,[hl]
	res 0,[hl]
	ld a,[$D286]
	cp $FF
	jr z,Logged_0x41C98
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

Logged_0x41C98:
	xor a
	ld [$D286],a
	ld hl,$0011
	add hl,de
	ld a,$01
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hli]
	ld [hl],a
	ld hl,$001B
	add hl,de
	add a,$08
	and $F0
	ld [hl],a
	ld hl,$0007
	add hl,de
	ld a,[hli]
	ld [hl],a
	ld hl,$001A
	add hl,de
	and $F0
	add a,$08
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$03
	ld [hl],a
	ret

Logged_0x41CC9:
	ld c,$02
	call Logged_0x43A09
	jr nc,Logged_0x41CD0

Logged_0x41CD0:
	ld hl,$001F
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x41D0C
	res 6,[hl]
	ld hl,$DC04
	set 6,[hl]
	ld hl,$0011
	add hl,de
	ld a,$3C
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hli]
	ld [hl],a
	ld hl,$001B
	add hl,de
	add a,$08
	and $F0
	ld [hl],a
	ld hl,$0007
	add hl,de
	ld a,[hli]
	ld [hl],a
	ld hl,$001A
	add hl,de
	and $F0
	add a,$08
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$03
	ld [hl],a
	ret

Logged_0x41D0C:
	call Logged_0x43289
	jr nz,Logged_0x41D15
	ld c,$04
	jr Logged_0x41D63

Logged_0x41D15:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	inc hl
	sub b
	call Logged_0x41D7E
	ld hl,$0007
	add hl,de
	ld a,[hl]
	inc hl
	sub c
	call Logged_0x41D7E
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld [$D29A],a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld [$D299],a
	call Logged_0x42524
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,$0C
	ld [$D29A],a
	call Logged_0x42524
	ld hl,$0007
	add hl,de
	ld a,[hl]
	add a,$0E
	ld [$D299],a
	call Logged_0x42524
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld [$D29A],a
	call Logged_0x42524
	ld c,$01

Logged_0x41D63:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	sub c
	ld [hli],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	ret nc
	ld a,$0C
	ld c,$01
	call Logged_0x43277
	ld hl,$0010
	add hl,de
	ld a,$08
	ld [hl],a
	ret

Logged_0x41D7E:
	jr z,Logged_0x41D94
	jr nc,Logged_0x41D8C
	ld a,[hl]
	add a,$20
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	jr Logged_0x41D94

Logged_0x41D8C:
	ld a,[hl]
	sub $20
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a

Logged_0x41D94:
	ret

Logged_0x41D95:
	ld c,$02
	call Logged_0x43A09
	jr nc,Logged_0x41D9C

Logged_0x41D9C:
	ld hl,$0011
	add hl,de
	dec [hl]
	jr nz,Logged_0x41DC0
	inc [hl]
	inc [hl]
	ld hl,$0004
	add hl,de
	ld a,[hl]
	ld hl,$001B
	add hl,de
	cp [hl]
	jr nz,Logged_0x41DC0
	ld hl,$0008
	add hl,de
	ld a,[hl]
	ld hl,$001A
	add hl,de
	cp [hl]
	jr nz,Logged_0x41DC0
	jp Logged_0x41E10

Logged_0x41DC0:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	and $03
	cp $02
	jr nz,Logged_0x41DF5
	ld hl,$0004
	add hl,de
	push hl
	ld a,[hl]
	ld hl,$001B
	add hl,de
	cp [hl]
	jr z,Logged_0x41DDE
	jr c,Unknown_0x41DDD
	dec a
	jr Logged_0x41DDE

Unknown_0x41DDD:
	inc a

Logged_0x41DDE:
	pop hl
	ld [hl],a
	ld hl,$0008
	add hl,de
	push hl
	ld a,[hl]
	ld hl,$001A
	add hl,de
	cp [hl]
	jr z,Logged_0x41DF3
	jr c,Logged_0x41DF2
	dec a
	jr Logged_0x41DF3

Logged_0x41DF2:
	inc a

Logged_0x41DF3:
	pop hl
	ld [hl],a

Logged_0x41DF5:
	ld a,$03
	call Logged_0x1331
	dec a
	ld hl,$0004
	add hl,de
	add a,[hl]
	dec hl
	ld [hl],a
	ld a,$03
	call Logged_0x1331
	dec a
	ld hl,$0008
	add hl,de
	add a,[hl]
	dec hl
	ld [hl],a
	ret

Logged_0x41E10:
	ld hl,$0004
	add hl,de
	ld a,[hl]
	dec hl
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$0008
	add hl,de
	ld a,[hl]
	dec hl
	ld [hli],a
	xor a
	ld [hl],a
	ld a,$24
	ld c,$06
	call Logged_0x43277
	ld hl,$0010
	add hl,de
	ld a,$04
	ld [hl],a
	ret

Logged_0x41E31:
	ld c,$02
	call Logged_0x43A09
	jr nc,Logged_0x41E38

Logged_0x41E38:
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	ret z
	ld hl,$0002
	add hl,de
	ld a,[hl]
	cp $28
	jr nz,Logged_0x41E61
	ld a,$02
	call Logged_0x1331
	push hl
	ld hl,$0012
	add hl,de
	ld [hl],a
	pop hl
	sla a
	sla a
	add a,l
	add a,$2A
	ld c,$07
	call Logged_0x43277
	ret

Logged_0x41E61:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	and $F0
	add a,$08
	ld [hli],a
	push hl
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	and $F0
	ld [hli],a
	push hl
	ld hl,$001B
	add hl,de
	ld [hl],a
	xor a
	pop hl
	ld [hl],a
	pop hl
	ld [hl],a
	ld a,$04
	call Logged_0x1331
	ld hl,$0011
	add hl,de
	ld [hl],a
	ld bc,$5EC8
	call Logged_0x438D3
	ld hl,$0011
	add hl,de
	ld a,$2C
	ld [hli],a
	ld a,$01
	ld [hl],a
	ld hl,$0012
	add hl,de
	ld a,[hl]
	push af
	xor $01
	ld l,a
	sla a
	sla a
	add a,l
	add a,$34
	ld hl,$001C
	add hl,de
	ld [hl],a
	ld c,$08
	call Logged_0x43277
	res 6,[hl]
	ld hl,$DC08
	set 0,[hl]
	ld hl,$0010
	add hl,de
	pop af
	ld a,$05
	ld [hl],a
	ret

UnknownData_0x41EC8:
INCBIN "baserom.gb", $41EC8, $41ECE - $41EC8

LoggedData_0x41ECE:
INCBIN "baserom.gb", $41ECE, $41EE0 - $41ECE

Logged_0x41EE0:
	ld c,$02
	call Logged_0x43A09
	jr nc,Logged_0x41EE7

Logged_0x41EE7:
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x41EF6
	res 6,[hl]
	ld hl,$DC08
	set 0,[hl]

Logged_0x41EF6:
	ld hl,$0013
	add hl,de
	ld a,[hli]
	bit 7,a
	jr nz,Logged_0x41F02
	or [hl]
	jr Logged_0x41F04

Logged_0x41F02:
	and [hl]
	inc a

Logged_0x41F04:
	jr nz,Logged_0x41F15
	ld a,$4E
	ld c,$0C
	call Logged_0x43277
	ld hl,$0010
	add hl,de
	ld a,$07
	ld [hl],a
	ret

Logged_0x41F15:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	sub $01
	ld [hli],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr nc,Logged_0x41F46
	dec hl
	ld a,$14
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$0013
	add hl,de
	sra [hl]
	inc hl
	rr [hl]
	ld hl,$0015
	add hl,de
	sra [hl]
	inc hl
	rr [hl]
	ld hl,$0017
	add hl,de
	inc [hl]

Logged_0x41F46:
	xor a
	ld [$D28F],a
	ld [$D290],a
	ld [$D292],a
	ld hl,$0003
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	jr nz,Logged_0x41F9D
	ld a,[hli]
	and $FF
	jr nz,Logged_0x41F9D
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$0015
	add hl,de
	push de
	ld e,a
	ld a,b
	ld b,$00
	bit 7,[hl]
	jr z,Logged_0x41F74
	dec b
	sub $20

Logged_0x41F74:
	inc b
	add a,$10
	ld [$D28F],a
	ld d,a
	push de
	push bc
	ld bc,$02C0
	call Logged_0x2F6C
	jr z,Logged_0x41F90
	pop bc
	pop de
	call Logged_0x420B0
	pop de
	call Logged_0x43979
	jr Logged_0x41F93

Logged_0x41F90:
	pop bc
	pop de
	pop de

Logged_0x41F93:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$001B
	add hl,de
	ld [hl],a

Logged_0x41F9D:
	ld hl,$0007
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	cp $08
	jr nz,Logged_0x41FEC
	ld a,[hli]
	and $FF
	jr nz,Logged_0x41FEC
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$0013
	add hl,de
	push de
	ld d,a
	ld a,b
	ld b,$02
	bit 7,[hl]
	jr z,Logged_0x41FC3
	dec b
	sub $20

Logged_0x41FC3:
	inc b
	add a,$10
	ld [$D290],a
	ld e,a
	push de
	push bc
	ld bc,$02C0
	call Logged_0x2F6C
	jr z,Logged_0x41FDF
	pop bc
	pop de
	call Logged_0x420B0
	pop de
	call Logged_0x43992
	jr Logged_0x41FE2

Logged_0x41FDF:
	pop bc
	pop de
	pop de

Logged_0x41FE2:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$001A
	add hl,de
	ld [hl],a

Logged_0x41FEC:
	ld hl,$0017
	add hl,de
	ld a,[hl]
	or a
	jr nz,Logged_0x4206E
	ld hl,$0007
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	jr nz,Logged_0x4206E
	ld a,[hli]
	and $FF
	jr nz,Logged_0x4206E
	ld hl,$001B
	add hl,de
	ld a,[hli]
	ld hl,$0015
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x42012
	sub $20

Logged_0x42012:
	add a,$10
	ld [$D28F],a
	ld hl,$001A
	add hl,de
	ld a,[hli]
	ld hl,$0013
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x42026
	sub $20

Logged_0x42026:
	add a,$10
	ld [$D290],a
	push de
	ld a,[$D290]
	ld e,a
	ld a,[$D28F]
	ld d,a
	ld bc,$02C0
	call Logged_0x2F6C
	pop de
	jr z,Logged_0x4206E
	push de
	push af
	call Logged_0x43979
	call Logged_0x43992
	ld a,$02
	call Logged_0x1331
	and a
	jr z,Logged_0x42054
	ld b,$00
	ld hl,$0015
	jr Logged_0x42059

Logged_0x42054:
	ld b,$02
	ld hl,$0013

Logged_0x42059:
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x4205F
	inc b

Logged_0x4205F:
	ld a,[$D290]
	ld e,a
	ld a,[$D28F]
	ld d,a
	pop af
	call Logged_0x420B0
	pop de
	jr Logged_0x4206E

Logged_0x4206E:
	ld a,[$D292]
	or a
	jr nz,Logged_0x420A2
	ld hl,$0017
	add hl,de
	ld a,[hl]
	or a
	jr z,Logged_0x420AF
	ld hl,$0015
	add hl,de
	ld c,l
	ld b,h
	ld hl,$0005
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ld hl,$0013
	add hl,de
	ld c,l
	ld b,h
	ld hl,$0009
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ld hl,$0017
	add hl,de
	xor a
	ld [hl],a
	jr Logged_0x420AF

Logged_0x420A2:
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a

Logged_0x420AF:
	ret

Logged_0x420B0:
	bit 6,a
	ret z
	ld h,b
	ld b,$80
	ld c,$80
	call Logged_0x3256
	ret

Logged_0x420BC:
	ld c,$02
	call Logged_0x43A09
	jr nc,Logged_0x420C3

Logged_0x420C3:
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	ret z
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x420D2:
	ld c,$02
	call Logged_0x43A09
	jr nc,Logged_0x420D9

Logged_0x420D9:
	ld hl,$0002
	add hl,de
	ld a,[hl]
	cp $0F
	ret nz
	ld hl,$0005
	add hl,de
	ld a,$FF
	ld [hli],a
	ld a,$80
	ld [hl],a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld c,a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$001B
	add hl,de
	ld [hl],a
	ld b,a
	push de
	ld hl,$D28D
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ld hl,$0003
	add hl,de
	ld a,b
	ld [hli],a
	ld hl,$0007
	add hl,de
	ld a,c
	ld [hl],a
	ld a,$3E
	ld c,$09
	call Logged_0x43277
	pop de
	ld c,$03
	ld hl,$D293

Logged_0x42122:
	xor a
	ld [hli],a
	ld a,$C0
	ld [hli],a
	dec c
	jr nz,Logged_0x42122
	ld hl,$DC08
	set 1,[hl]
	ld hl,$001F
	add hl,de
	set 0,[hl]
	ld hl,$0010
	add hl,de
	ld a,$09
	ld [hl],a
	ret

Logged_0x4213D:
	call Logged_0x42447
	ld hl,$0003
	add hl,de
	ld a,[hl]
	cp $B0
	jr c,Logged_0x4214F
	cp $E0
	jr nc,Logged_0x4214F
	jr Logged_0x4215E

Logged_0x4214F:
	ld hl,$0006
	add hl,de
	ld a,$FF
	ld a,[hl]
	sub $04
	ld [hld],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	ret

Logged_0x4215E:
	ld a,[$D298]
	cp $C0
	jr nz,Logged_0x4216A
	call Unknown_0x4248F
	jr Logged_0x4215E

Logged_0x4216A:
	ld hl,$D286
	ld a,$01
	sub [hl]
	jr c,Logged_0x4217F
	inc a
	ld c,a
	ld hl,$D298

Logged_0x42177:
	ld a,$C0
	ld [hld],a
	xor a
	ld [hld],a
	dec c
	jr nz,Logged_0x42177

Logged_0x4217F:
	xor a
	ld [$D290],a
	ld hl,$0011
	add hl,de
	ld a,$F8
	ld [hl],a
	ld hl,$0005
	add hl,de
	xor a
	ld [hli],a
	ld [hl],a
	ld a,$3C
	ld [$FF00+$49],a
	ld hl,$0010
	add hl,de
	ld a,$0A
	ld [hl],a
	ret

Logged_0x4219D:
	ld a,[$D290]
	inc a
	cp $03
	jr nz,Logged_0x421A6
	xor a

Logged_0x421A6:
	ld [$D290],a
	sla a
	ld hl,$D293
	add a,l
	ld c,a
	ld a,$00
	adc a,h
	ld b,a
	push de
	ld hl,$D28D
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ld hl,$0003
	add hl,de
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0007
	add hl,de
	ld a,[bc]
	ld [hl],a
	pop de
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	inc [hl]
	push de
	ld hl,$D28D
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	pop de
	cp $C0
	ret z
	push de
	ld hl,$D28D
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ld a,$49
	ld c,$0B
	call Logged_0x43277
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld b,a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	pop de
	ld hl,$0007
	add hl,de
	ld [hl],a
	ld hl,$001B
	add hl,de
	ld a,b
	ld [hl],a
	ld a,$11
	ld c,$02
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$0005
	add hl,de
	ld a,$02
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld a,$1C
	ld [$FF00+$49],a
	ld hl,$DC08
	set 2,[hl]
	ld hl,$0010
	add hl,de
	ld a,$0B
	ld [hl],a
	ret

Logged_0x42230:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	cp $B0
	jr nc,Logged_0x42242
	ld hl,$001B
	add hl,de
	cp [hl]
	jr c,Logged_0x42242
	jr Logged_0x42243

Logged_0x42242:
	ret

Logged_0x42243:
	ld hl,$001B
	add hl,de
	ld a,[hl]
	ld hl,$0003
	add hl,de
	ld [hli],a
	xor a
	ld [hl],a
	ld hl,$001F
	add hl,de
	res 6,[hl]
	res 0,[hl]
	ld hl,$0005
	add hl,de
	xor a
	ld [hli],a
	ld [hl],a
	push de
	ld hl,$D28D
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ld hl,$0007
	add hl,de
	ld a,$C0
	ld [hl],a
	pop de
	push de
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld c,a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld d,c
	ld e,a
	ld bc,$0280
	call Logged_0x2F6C
	ld a,d
	pop de
	cp $10
	jr z,Logged_0x422EC
	ld a,[$D141]
	bit 0,a
	jr z,Unknown_0x422D0
	ld a,[$D16A]
	ld c,a
	ld a,[$D16B]
	or c
	jr nz,Unknown_0x422D0
	ld a,[$D141]
	bit 6,a
	jr nz,Unknown_0x422D0
	ld bc,$C420
	ld a,[$D141]
	bit 7,a
	jr z,Unknown_0x422AD
	ld bc,$C220

Unknown_0x422AD:
	ld hl,$0013
	add hl,bc
	ld a,$10
	ld [hl],a
	ld hl,$001B
	add hl,bc
	ld a,$00
	ld [hl],a
	ld hl,$0014
	add hl,bc
	set 5,[hl]
	ld a,$02
	call Logged_0x1331
	ld c,a
	ld a,[$D142]
	and $FE
	or c
	ld [$D142],a

Unknown_0x422D0:
	scf
	ld a,$11
	ld c,$02
	call Logged_0x43277
	ld hl,$0011
	add hl,de
	ld a,$1E
	ld [hl],a
	ld hl,$DC08
	set 3,[hl]
	ld hl,$0010
	add hl,de
	ld a,$0C
	ld [hl],a
	ret

Logged_0x422EC:
	ld a,$14
	ld c,$02
	call Logged_0x43277
	ld hl,$0011
	add hl,de
	ld a,$F0
	ld [hl],a
	ld hl,$DC08
	set 4,[hl]
	ld hl,$0010
	add hl,de
	ld a,$0D
	ld [hl],a
	ret

Unknown_0x42307:
	ld c,$02
	call Logged_0x43A09
	jr nc,Unknown_0x4230E

Unknown_0x4230E:
	call Logged_0x424D7
	ld hl,$0011
	add hl,de
	dec [hl]
	jr z,Unknown_0x42322
	ld a,$03
	call Logged_0x1331
	dec a
	ld [$C0DE],a
	ret

Unknown_0x42322:
	ld a,$1F
	ld c,$05
	call Logged_0x43277
	xor a
	ld [$C0DE],a
	ld hl,$0012
	add hl,de
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0F
	ld [hl],a
	ret

Logged_0x4233A:
	ld c,$02
	call Logged_0x43A09
	jr nc,Logged_0x42341

Logged_0x42341:
	call Logged_0x424D7
	ld hl,$001F
	add hl,de
	bit 6,[hl]
	jr nz,Logged_0x4237D
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x4235B
	ld a,$19
	ld c,$02
	call Logged_0x43277

Logged_0x4235B:
	ld hl,$D289
	bit 0,[hl]
	ret z
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	ld a,$1F
	ld c,$05
	call Logged_0x43277
	ld hl,$0012
	add hl,de
	ld a,$FF
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0F
	ld [hl],a
	ret

Logged_0x4237D:
	ld hl,$001F
	add hl,de
	res 6,[hl]
	ld hl,$0011
	add hl,de
	ld a,$3C
	ld [hl],a
	ld a,$1C
	ld c,$04
	call Logged_0x43277
	ld hl,$D286
	inc [hl]
	ld hl,$D286
	ld a,[hl]
	cp $03
	jr z,Logged_0x423A4
	ld hl,$DC09
	set 2,[hl]
	jr Logged_0x423B6

Logged_0x423A4:
	ld hl,$D12B
	set 4,[hl]
	ld hl,$D12A
	res 5,[hl]
	ld hl,$0010
	add hl,de
	ld a,$12
	ld [hl],a
	ret

Logged_0x423B6:
	ld hl,$0010
	add hl,de
	ld a,$0E
	ld [hl],a
	ret

Logged_0x423BE:
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	ld hl,$D286
	ld a,[hl]
	cp $03
	jr z,Logged_0x423E2
	ld a,$1F
	ld c,$05
	call Logged_0x43277
	ld hl,$0012
	add hl,de
	ld a,$FF
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0F
	ld [hl],a
	ret

Logged_0x423E2:
	ld hl,$0011
	add hl,de
	ld a,$D2
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$10
	ld [hl],a
	ret

Logged_0x423F1:
	ld c,$02
	call Logged_0x43A09
	jr nc,Logged_0x423F8

Logged_0x423F8:
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	ret z
	ld hl,$0012
	add hl,de
	ld a,[hl]
	and a
	jr nz,Logged_0x4240F
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x4240F:
	ld hl,$0003
	add hl,de
	ld a,[hli]
	ld [hl],a
	ld hl,$001B
	add hl,de
	add a,$08
	and $F0
	ld [hl],a
	ld hl,$0007
	add hl,de
	ld a,[hli]
	ld [hl],a
	ld hl,$001A
	add hl,de
	and $F0
	add a,$08
	ld [hl],a
	jp Logged_0x41E10

Logged_0x42430:
	ld hl,$0011
	add hl,de
	dec [hl]
	ret nz
	ld a,$13
	ld [$FF00+$91],a
	ret

Unknown_0x4243B:
	ret

Logged_0x4243C:
	call Logged_0x432A6
	ld hl,$0010
	add hl,de
	ld a,$0E
	ld [hl],a
	ret

Logged_0x42447:
	push de
	ld a,[$D297]
	and a
	jr nz,Logged_0x4248D
	ld a,$80
	call Logged_0x1331
	and $F0
	add a,$18
	ld e,a
	ld a,$70
	call Logged_0x1331
	and $F0
	add a,$20
	ld d,a
	ld c,$03
	ld hl,$D293

Logged_0x42467:
	ld a,[hli]
	and a
	jr z,Logged_0x4247A
	cp d
	jr nz,Logged_0x42474
	ld a,[hli]
	cp e
	jr nz,Logged_0x42475
	jr Logged_0x4248D

Logged_0x42474:
	inc hl

Logged_0x42475:
	dec c
	jr nz,Logged_0x42467
	jr Logged_0x4248D

Logged_0x4247A:
	dec hl
	push hl
	push de
	ld bc,$0280
	call Logged_0x2F6C
	ld a,d
	pop de
	pop hl
	and a
	jr nz,Logged_0x4248D
	ld a,d
	ld [hli],a
	ld a,e
	ld [hl],a

Logged_0x4248D:
	pop de
	ret

Unknown_0x4248F:
	push de
	ld a,$80
	call Logged_0x1331
	and $F0
	add a,$18
	ld e,a
	ld a,$70
	call Logged_0x1331
	and $F0
	add a,$20
	ld d,a
	ld c,$03
	ld hl,$D293

Unknown_0x424A9:
	ld a,[hli]
	and a
	jr z,Unknown_0x424BC
	cp d
	jr nz,Unknown_0x424B6
	ld a,[hli]
	cp e
	jr nz,Unknown_0x424B7
	jr Unknown_0x424D5

Unknown_0x424B6:
	inc hl

Unknown_0x424B7:
	dec c
	jr nz,Unknown_0x424A9
	jr Unknown_0x424D5

Unknown_0x424BC:
	dec hl
	push hl
	push de
	ld bc,$0280
	call Logged_0x2F6C
	ld a,d
	pop de
	pop hl
	and a
	jr z,Unknown_0x424D1
	cp $10
	jr z,Unknown_0x424D1
	jr Unknown_0x424D5

Unknown_0x424D1:
	ld a,d
	ld [hli],a
	ld a,e
	ld [hl],a

Unknown_0x424D5:
	pop de
	ret

Logged_0x424D7:
	ld a,[$D291]
	cp $00
	jr z,Logged_0x424E3
	dec a
	ld [$D291],a
	ret

Logged_0x424E3:
	push de
	ld a,$80
	call Logged_0x1331
	and $F0
	add a,$18
	ld e,a
	ld a,$70
	call Logged_0x1331
	and $F0
	add a,$20
	ld d,a
	push de
	call Logged_0x2FA4
	pop de
	ld a,[hl]
	cp $10
	jr nz,Logged_0x42522
	inc hl
	ld a,[hld]
	ld [hl],a
	push af
	call Logged_0x3007
	pop af
	push de
	ld c,e
	ld b,d
	call Logged_0x26C2
	call Logged_0x3047
	pop de
	ld a,$13
	ld [hli],a
	ld a,d
	ld [hli],a
	ld a,e
	ld [hli],a
	xor a
	ld [hli],a
	ld a,$0A
	ld [$D291],a

Logged_0x42522:
	pop de
	ret

Logged_0x42524:
	push de
	ld a,[$D29A]
	and $F0
	ld [$D29A],a
	ld d,a
	ld a,[$D299]
	sub $08
	and $F0
	add a,$08
	ld [$D299],a
	ld e,a
	ld bc,$0240
	call Logged_0x2F6C
	pop de
	ret z
	push de
	call Logged_0x3069
	pop de
	ret c
	push hl
	push de
	ld a,[$D29A]
	ld d,a
	ld a,[$D299]
	ld e,a
	call Logged_0x2FA4
	ld a,[hli]
	push af
	ld a,[hld]
	ld [hl],a
	push af
	ld a,[$D29A]
	ld d,a
	ld a,[$D299]
	ld e,a
	call Logged_0x3007
	pop af
	ld c,e
	ld b,d
	call Logged_0x26C2
	pop bc
	pop de
	pop hl
	push bc
	ld bc,$0000
	add hl,bc
	ld a,$80
	ld [hl],a
	ld bc,$0001
	add hl,bc
	ld a,$80
	ld [hli],a
	xor a
	ld [hli],a
	ld a,[$D29A]
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,[$D299]
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld bc,$0001
	add hl,bc
	xor a
	ld [hl],a
	ld bc,$0004
	add hl,bc
	ld a,$08
	ld [hl],a
	ld bc,$0004
	add hl,bc
	pop af
	ld [hl],a
	ld hl,$DC0A
	set 4,[hl]
	ret
	call Logged_0x42B05
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x425D4
	dw Logged_0x42621
	dw Logged_0x4266B
	dw Logged_0x4267F
	dw Logged_0x426BC
	dw Logged_0x42703
	dw Logged_0x427E8
	dw Logged_0x42876
	dw Logged_0x42884

UnknownData_0x425C4:
INCBIN "baserom.gb", $425C4, $425C6 - $425C4

LoggedData_0x425C6:
INCBIN "baserom.gb", $425C6, $425D4 - $425C6

Logged_0x425D4:
	xor a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld a,$50
	ld hl,$0007
	add hl,de
	ld [hli],a
	ld a,$30
	ld hl,$0003
	add hl,de
	ld [hli],a
	ld a,$46
	ld c,$0E
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$90
	ld [hl],a
	xor a
	ld hl,$0015
	add hl,de
	ld [hl],a
	ld hl,$0016
	add hl,de
	ld [hl],a
	ld [$D288],a
	ld hl,$D289
	ld c,$10
	xor a

Logged_0x42611:
	ld [hli],a
	dec c
	jr nz,Logged_0x42611
	xor a
	ld [$D286],a
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x42621:
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld a,$10
	ld c,$04
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$20
	ld [hl],a
	ld a,$02
	call Logged_0x1331
	sla a
	sla a
	ld c,a
	ld b,$00
	ld hl,$6663
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

LoggedData_0x42663:
INCBIN "baserom.gb", $42663, $4266B - $42663

Logged_0x4266B:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	add a,$20
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	jr Logged_0x42691

Logged_0x4267F:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	add a,$40
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz

Logged_0x42691:
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,$02
	ld [hl],a
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	add a,$27
	ld c,$09
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$20
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$04
	ld [hl],a
	ret

Logged_0x426BC:
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	inc [hl]
	push de
	call Logged_0x307D
	pop de
	ret c
	push hl
	ld hl,$0010
	add hl,de
	ld a,$05
	ld [hl],a
	ld a,[$D286]
	sla a
	sla a
	ld b,a
	sla a
	ld c,a
	ld a,$0A
	sub c
	call Logged_0x1331
	add a,$06
	sub b
	ld a,$02
	ld hl,$0019
	add hl,de
	ld [hli],a
	ld a,$00
	ld [hl],a
	ld hl,$0014
	add hl,de
	set 7,[hl]
	pop hl
	push de
	ld c,$20

Logged_0x426F9:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x426F9
	pop de
	xor a
	ld [de],a
	ret

Logged_0x42703:
	push de
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$0007
	add hl,de
	ld e,[hl]
	ld d,a
	call Logged_0x2FBC
	pop de
	ld a,[hl]
	cp $43
	jr nz,Logged_0x4273A
	ld hl,$0014
	add hl,de
	res 7,[hl]
	ld a,[hl]
	sla a
	sla a
	add a,[hl]
	add a,$14
	ld c,$05
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$20
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0A
	ld [hl],a
	ret

Logged_0x4273A:
	push de
	and $0F
	sla a
	sla a
	add a,$B5
	ld l,a
	ld a,$00
	adc a,$6D
	ld h,a
	push hl
	ld hl,$0014
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x4275A
	push hl
	ld a,$04
	call Logged_0x1331
	pop hl
	ld [hl],a

Logged_0x4275A:
	ld a,[hl]
	sla a
	sla a
	add a,$F5
	ld e,a
	ld a,$00
	adc a,$6D
	ld d,a
	dec de
	pop bc

Logged_0x42769:
	inc de
	ld a,[de]
	add a,c
	ld l,a
	ld a,$00
	adc a,b
	ld h,a
	bit 0,[hl]
	jr z,Logged_0x42769
	ld a,[de]
	pop de
	ld hl,$0014
	add hl,de
	ld [hl],a
	sla a
	sla a
	add a,[hl]
	push af
	add a,$10
	ld c,$04
	call Logged_0x43277
	pop af
	ld hl,$0015
	add hl,de
	ld c,[hl]
	inc c
	dec c
	jr z,Logged_0x42795
	add a,$14

Logged_0x42795:
	ld c,a
	ld b,$00
	ld hl,$67C0
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0013
	add hl,de
	ld a,[bc]
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$06
	ld [hl],a
	ret

LoggedData_0x427C0:
INCBIN "baserom.gb", $427C0, $427E8 - $427C0

Logged_0x427E8:
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld hl,$0015
	add hl,de
	ld a,[hl]
	inc a
	dec a
	jr nz,Logged_0x42828
	ld hl,$0019
	add hl,de
	ld a,[hl]
	sub $01
	ld [hli],a
	ld a,[hl]
	sbc a,$00
	ld [hl],a
	jr nc,Logged_0x42853
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld a,$3D
	ld c,$0D
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$40
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$08
	ld [hl],a
	ret

Logged_0x42828:
	ld hl,$0015
	add hl,de
	ld a,[hl]
	ld hl,$0003
	add hl,de
	cp [hl]
	jr nz,Logged_0x42853
	ld hl,$0016
	add hl,de
	ld a,[hl]
	ld hl,$0007
	add hl,de
	cp [hl]
	jr nz,Logged_0x42853
	ld hl,$D287
	ld a,[hl]
	cp $05
	jr nz,Logged_0x42856
	xor a
	ld hl,$0015
	add hl,de
	ld [hl],a
	ld hl,$0016
	add hl,de
	ld [hl],a

Logged_0x42853:
	jp Logged_0x42703

Logged_0x42856:
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld a,$42
	ld c,$0E
	call Logged_0x43277
	ld hl,$D287
	inc [hl]
	ld hl,$0010
	add hl,de
	ld a,$07
	ld [hl],a
	ret

Logged_0x42876:
	ld a,[$D287]
	cp $05
	ret nz
	ld hl,$0010
	add hl,de
	ld a,$0A
	ld [hl],a
	ret

Logged_0x42884:
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld a,$12
	call Logged_0x1331
	sla a
	sla a
	ld c,a
	ld b,$00
	ld hl,$68D6
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0015
	add hl,de
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0016
	add hl,de
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0017
	add hl,de
	ld a,[bc]
	ld [hl],a
	inc bc
	ld a,[bc]
	sla a
	sla a
	sla a
	sla a
	add a,$1E
	ld c,a
	ld a,$00
	adc a,$69
	ld b,a
	push de
	ld e,$12
	ld hl,$D289

Logged_0x428C8:
	ld a,[bc]
	ld [hli],a
	inc bc
	dec e
	jr nz,Logged_0x428C8
	pop de
	xor a
	ld [$D287],a
	jp Logged_0x42703

LoggedData_0x428D6:
INCBIN "baserom.gb", $428D6, $4293E - $428D6
	push de
	call Logged_0x3069
	pop de
	ret c
	push hl
	ld a,$24
	ld c,$08
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$20
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0B
	ld [hl],a
	pop hl
	push de
	ld c,$20

Logged_0x4295E:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x4295E
	pop de
	xor a
	ld [de],a
	ret
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld hl,$0017
	add hl,de
	ld a,[hl]
	ld a,$47
	ld c,$0E
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$0013
	add hl,de
	ld a,$10
	ld [hl],a
	ld hl,$0006
	add hl,de
	ld [hld],a
	ld a,$FE
	ld [hl],a
	ld hl,$000A
	add hl,de
	ld a,$00
	ld [hld],a
	ld [hl],a
	ld hl,$DC09
	set 6,[hl]
	ld hl,$0010
	add hl,de
	ld a,$0C
	ld [hl],a
	ret
	ld hl,$0006
	add hl,de
	ld a,[hl]
	add a,$40
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld a,$46
	ld c,$0E
	call Logged_0x43277
	xor a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,$01
	ld [hl],a
	ld hl,$0013
	add hl,de
	xor a
	ld [hl],a
	ld hl,$001F
	add hl,de
	res 6,[hl]
	ld hl,$0010
	add hl,de
	ld a,$0D
	ld [hl],a
	ret
	ld hl,$001F
	add hl,de
	bit 6,[hl]
	jr nz,Logged_0x42A57
	push de
	ld hl,$C440
	ld b,$10
	ld c,$00

Logged_0x429F6:
	ld de,$0020
	ld a,[hl]
	cp $94
	jr nz,Logged_0x42A0B
	ld de,$0010
	add hl,de
	ld de,$0010
	ld a,[hl]
	cp $06
	jr nz,Logged_0x42A0B
	inc c

Logged_0x42A0B:
	add hl,de
	dec b
	jr nz,Logged_0x429F6
	pop de
	ld a,$04
	cp c
	ret nz
	ld hl,$0003
	add hl,de
	ld a,[hl]
	sub $01
	ld [hl],a

Logged_0x42A1C:
	ld a,$38
	ld c,$0C
	call Logged_0x43277
	xor a
	ld hl,$0015
	add hl,de
	ld [hl],a
	ld hl,$0016
	add hl,de
	ld [hl],a
	ld hl,$0017
	add hl,de
	ld [hl],a
	ld hl,$0013
	add hl,de
	ld a,$10
	ld [hl],a
	ld hl,$0006
	add hl,de
	ld [hld],a
	ld a,$FE
	ld [hl],a
	ld hl,$000A
	add hl,de
	ld a,$00
	ld [hld],a
	ld [hl],a
	ld hl,$DC09
	set 6,[hl]
	ld hl,$0010
	add hl,de
	ld a,$03
	ld [hl],a
	ret

Logged_0x42A57:
	ld hl,$001F
	add hl,de
	res 6,[hl]
	ld hl,$D286
	ld a,[hl]
	cp $02
	jr nz,Logged_0x42A89
	ld hl,$D12B
	set 4,[hl]
	ld hl,$D12A
	res 5,[hl]
	ld hl,$0013
	add hl,de
	ld a,$60
	ld [hl],a
	ld a,$33
	ld c,$0B
	call Logged_0x43277
	ld hl,$D286
	inc [hl]
	ld hl,$0010
	add hl,de
	ld a,$10
	ld [hl],a
	ret

Logged_0x42A89:
	ld hl,$DC09
	set 2,[hl]
	ld hl,$0013
	add hl,de
	ld a,$60
	ld [hl],a
	ld a,$33
	ld c,$0B
	call Logged_0x43277
	ld hl,$D286
	inc [hl]
	ld hl,$0010
	add hl,de
	ld a,$0E
	ld [hl],a
	ret
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	inc [hl]
	ld hl,$C240
	ld c,$0E

Logged_0x42AB4:
	ld a,[hl]
	cp $94
	ret z
	ld a,c
	ld bc,$0020
	add hl,bc
	ld c,a
	dec c
	jr nz,Logged_0x42AB4
	ld hl,$D286
	ld a,[hl]
	cp $03
	jr z,Logged_0x42AD4
	ld hl,$0003
	add hl,de
	ld a,[hl]
	sub $01
	ld [hl],a
	jp Logged_0x42A1C

Logged_0x42AD4:
	ld a,$45
	ld c,$0E
	call Logged_0x43277
	ld hl,$000C
	add hl,de
	res 7,[hl]
	ld hl,$0013
	add hl,de
	ld a,$78
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0F
	ld [hl],a
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld a,$13
	ld [$FF00+$91],a
	ret
	call Logged_0x432A6
	ld hl,$0010
	add hl,de
	ld a,$0E
	ld [hl],a
	ret

Logged_0x42B05:
	ld hl,$0010
	add hl,de
	ld a,[hl]
	cp $03
	ret c
	push de
	ld hl,$C200
	ld de,$0020
	ld b,$20
	ld c,$00

Logged_0x42B18:
	ld a,[hl]
	cp $94
	jr nz,Logged_0x42B1E
	inc c

Logged_0x42B1E:
	add hl,de
	dec b
	jr nz,Logged_0x42B18
	pop de
	ld a,$04
	cp c
	ret z
	push de
	call Logged_0x3069
	pop de
	ret c
	ld bc,$0000
	add hl,bc
	ld a,$94
	ld [hl],a
	ld bc,$0001
	add hl,bc
	ld a,$93
	ld [hli],a
	xor a
	ld [hli],a
	ld a,$C0
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$F8
	ld [hl],a
	ld bc,$0005
	add hl,bc
	xor a
	ld [hli],a
	ret
	ld hl,$001F
	add hl,de
	bit 6,[hl]
	jr z,Logged_0x42B6E
	ld hl,$DC04
	set 3,[hl]
	ld hl,$0000
	add hl,de
	ld a,$8C
	ld [hl],a
	ld hl,$0010
	add hl,de
	xor a
	ld [hl],$8C
	ret

Logged_0x42B6E:
	ld hl,$0010
	add hl,de
	ld a,[hl]
	cp $03
	jr z,Logged_0x42B9D
	cp $04
	jr z,Logged_0x42B9D
	cp $0A
	jr z,Logged_0x42B9D
	cp $0B
	jr z,Logged_0x42B9D
	cp $0C
	jr z,Logged_0x42B9D
	cp $05
	jr c,Logged_0x42B96
	cp $0B
	jr nc,Logged_0x42B96
	ld c,$00
	call Logged_0x43AD3
	jr Logged_0x42B9D

Logged_0x42B96:
	ld c,$00
	call Logged_0x43A09
	jr Logged_0x42B9D

Logged_0x42B9D:
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x42BBF
	dw Logged_0x42C0A
	dw Logged_0x42C42
	dw Logged_0x42C8A
	dw Logged_0x42CC7
	dw Logged_0x42CF0
	dw Logged_0x42E2D
	dw Logged_0x42EDD

UnknownData_0x42BB3:
INCBIN "baserom.gb", $42BB3, $42BB7 - $42BB3

LoggedData_0x42BB7:
INCBIN "baserom.gb", $42BB7, $42BBF - $42BB7

Logged_0x42BBF:
	xor a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$000C
	add hl,de
	set 6,[hl]
	ld hl,$0013
	add hl,de
	ld a,$80
	ld [hl],a
	xor a
	ld hl,$0015
	add hl,de
	ld [hl],a
	ld hl,$0016
	add hl,de
	ld [hl],a
	ld hl,$0017
	add hl,de
	ld [hl],a
	ld hl,$0019
	add hl,de
	ld [hl],a
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$0007
	add hl,de
	and [hl]
	jr z,Logged_0x42C02
	ld hl,$0010
	add hl,de
	ld a,$01
	ld [hl],a
	ret

Logged_0x42C02:
	ld hl,$0010
	add hl,de
	ld a,$02
	ld [hl],a
	ret

Logged_0x42C0A:
	ld hl,$0013
	add hl,de
	dec [hl]
	jr z,Logged_0x42C2C
	ld hl,$000C
	add hl,de
	bit 6,[hl]
	ret z
	res 6,[hl]
	ld a,$02
	call Logged_0x1331
	dec a
	jr z,Logged_0x42C24
	ld a,$03

Logged_0x42C24:
	add a,$34
	ld c,$03
	call Logged_0x43277
	ret

Logged_0x42C2C:
	ld a,$28
	ld c,$02
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$20
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$04
	ld [hl],a
	ret

Logged_0x42C42:
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld hl,$0014
	add hl,de
	ld a,$02
	call Logged_0x1331
	sla a
	sla a
	add a,$82
	ld c,a
	ld a,$00
	adc a,$6C
	ld b,a
	ld hl,$0003
	add hl,de
	ld a,[bc]
	ld [hli],a
	xor a
	ld [hl],a
	inc bc
	ld hl,$0007
	add hl,de
	ld a,[bc]
	ld [hli],a
	xor a
	ld [hl],a
	inc bc
	ld hl,$0014
	add hl,de
	ld a,[bc]
	ld [hl],a
	sla a
	sla a
	add a,[hl]
	ld c,$00
	call Logged_0x43277
	jp Logged_0x430DC

UnknownData_0x42C82:
INCBIN "baserom.gb", $42C82, $42C86 - $42C82

LoggedData_0x42C86:
INCBIN "baserom.gb", $42C86, $42C89 - $42C86

UnknownData_0x42C89:
INCBIN "baserom.gb", $42C89, $42C8A - $42C89

Logged_0x42C8A:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	add a,$40
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,$02
	ld [hl],a

Logged_0x42CA4:
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	add a,$28
	ld c,$02
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$20
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$04
	ld [hl],a
	ret

Logged_0x42CC7:
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	inc [hl]
	push de
	call Logged_0x307D
	pop de
	ret c
	push hl
	ld hl,$0010
	add hl,de
	ld a,$05
	ld [hl],a
	ld hl,$0014
	add hl,de
	set 7,[hl]
	pop hl
	push de
	ld c,$20

Logged_0x42CE6:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x42CE6
	pop de
	xor a
	ld [de],a
	ret

Logged_0x42CF0:
	push de
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$0007
	add hl,de
	ld e,[hl]
	ld d,a
	call Logged_0x2FBC
	pop de
	ld a,[hl]
	cp $43
	jr nz,Logged_0x42D27
	ld hl,$0014
	add hl,de
	res 7,[hl]
	ld a,[hl]
	sla a
	sla a
	add a,[hl]
	add a,$14
	ld c,$05
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$20
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0A
	ld [hl],a
	ret

Logged_0x42D27:
	push de
	and $0F
	sla a
	sla a
	add a,$B5
	ld l,a
	ld a,$00
	adc a,$6D
	ld h,a
	push hl
	ld hl,$0014
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x42D47
	push hl
	ld a,$04
	call Logged_0x1331
	pop hl
	ld [hl],a

Logged_0x42D47:
	ld a,[hl]
	sla a
	sla a
	add a,$F5
	ld e,a
	ld a,$00
	adc a,$6D
	ld d,a
	dec de
	pop bc

Logged_0x42D56:
	inc de
	ld a,[de]
	add a,c
	ld l,a
	ld a,$00
	adc a,b
	ld h,a
	bit 0,[hl]
	jr z,Logged_0x42D56
	ld a,[de]
	pop de
	ld hl,$0014
	add hl,de
	ld [hl],a
	sla a
	sla a
	add a,[hl]
	push af
	add a,$14
	ld c,$01
	call Logged_0x43277
	pop af
	ld hl,$0015
	add hl,de
	ld c,[hl]
	inc c
	dec c
	jr z,Logged_0x42D82
	add a,$14

Logged_0x42D82:
	ld c,a
	ld b,$00
	ld hl,$6E05
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0013
	add hl,de
	ld a,[bc]
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$06
	ld [hl],a
	ret

UnknownData_0x42DAD:
INCBIN "baserom.gb", $42DAD, $42DC1 - $42DAD

LoggedData_0x42DC1:
INCBIN "baserom.gb", $42DC1, $42DC5 - $42DC1

UnknownData_0x42DC5:
INCBIN "baserom.gb", $42DC5, $42DC9 - $42DC5

LoggedData_0x42DC9:
INCBIN "baserom.gb", $42DC9, $42DD1 - $42DC9

UnknownData_0x42DD1:
INCBIN "baserom.gb", $42DD1, $42DD9 - $42DD1

LoggedData_0x42DD9:
INCBIN "baserom.gb", $42DD9, $42DE1 - $42DD9

UnknownData_0x42DE1:
INCBIN "baserom.gb", $42DE1, $42DE5 - $42DE1

LoggedData_0x42DE5:
INCBIN "baserom.gb", $42DE5, $42DE9 - $42DE5

UnknownData_0x42DE9:
INCBIN "baserom.gb", $42DE9, $42DF5 - $42DE9

LoggedData_0x42DF5:
INCBIN "baserom.gb", $42DF5, $42DF8 - $42DF5

UnknownData_0x42DF8:
INCBIN "baserom.gb", $42DF8, $42DF9 - $42DF8

LoggedData_0x42DF9:
INCBIN "baserom.gb", $42DF9, $42DFC - $42DF9

UnknownData_0x42DFC:
INCBIN "baserom.gb", $42DFC, $42DFD - $42DFC

LoggedData_0x42DFD:
INCBIN "baserom.gb", $42DFD, $42E00 - $42DFD

UnknownData_0x42E00:
INCBIN "baserom.gb", $42E00, $42E01 - $42E00

LoggedData_0x42E01:
INCBIN "baserom.gb", $42E01, $42E04 - $42E01

UnknownData_0x42E04:
INCBIN "baserom.gb", $42E04, $42E05 - $42E04

LoggedData_0x42E05:
INCBIN "baserom.gb", $42E05, $42E2D - $42E05

Logged_0x42E2D:
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld hl,$0015
	add hl,de
	ld a,[hl]
	inc a
	dec a
	jr nz,Logged_0x42E76
	ld hl,$D289
	ld a,[hl]
	inc a
	dec a
	jr z,Logged_0x42EAB
	ld bc,$D295

Logged_0x42E47:
	ld a,[bc]
	inc a
	dec a
	jr nz,Logged_0x42E52
	dec bc
	dec bc
	dec bc
	dec bc
	jr Logged_0x42E47

Logged_0x42E52:
	ld hl,$0015
	add hl,de
	ld [hl],a
	inc bc
	ld a,[bc]
	ld hl,$0016
	add hl,de
	ld [hl],a
	inc bc
	ld a,[bc]
	ld hl,$0017
	add hl,de
	ld [hl],a
	inc bc
	ld a,[bc]
	ld hl,$0019
	add hl,de
	ld [hl],a
	xor a
	ld [bc],a
	dec bc
	ld [bc],a
	dec bc
	ld [bc],a
	dec bc
	ld [bc],a
	jr Logged_0x42EAB

Logged_0x42E76:
	ld hl,$0015
	add hl,de
	ld a,[hl]
	ld hl,$0003
	add hl,de
	cp [hl]
	jr nz,Logged_0x42EAB
	ld hl,$0016
	add hl,de
	ld a,[hl]
	ld hl,$0007
	add hl,de
	cp [hl]
	jr nz,Logged_0x42EAB
	ld hl,$D287
	ld a,[hl]
	cp $05
	jr nz,Logged_0x42EAE
	xor a
	ld hl,$0015
	add hl,de
	ld [hl],a
	ld hl,$0016
	add hl,de
	ld [hl],a
	ld hl,$0017
	add hl,de
	ld [hl],a
	ld hl,$0019
	add hl,de
	ld [hl],a

Logged_0x42EAB:
	jp Logged_0x42CF0

Logged_0x42EAE:
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0017
	add hl,de
	ld a,[hl]
	ld hl,$0014
	add hl,de
	ld [hl],a
	sla a
	sla a
	add a,[hl]
	add a,$14
	ld c,$05
	call Logged_0x43277
	ld hl,$D287
	inc [hl]
	ld hl,$0010
	add hl,de
	ld a,$07
	ld [hl],a
	ret

Logged_0x42EDD:
	ld a,[$D287]
	cp $05
	ret nz
	xor a
	ld hl,$0015
	add hl,de
	ld [hl],a
	ld hl,$0016
	add hl,de
	ld [hl],a
	ld hl,$0017
	add hl,de
	ld [hl],a
	ld hl,$0019
	add hl,de
	ld a,[hl]
	ld hl,$0013
	add hl,de
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0A
	ld [hl],a
	ret
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	inc [hl]
	push de
	call Logged_0x3069
	pop de
	ret c
	push hl
	ld hl,$0014
	add hl,de
	ld a,[hl]
	sla a
	add a,[hl]
	add a,$34
	ld c,$03
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$20
	ld [hl],a
	ld hl,$0010
	add hl,de
	ld a,$0B
	ld [hl],a
	pop hl
	push de
	ld c,$20

Logged_0x42F34:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x42F34
	pop de
	xor a
	ld [de],a
	ret
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	inc [hl]
	ld hl,$0014
	add hl,de
	ld a,[hl]
	sla a
	ld c,a
	ld b,$00
	ld hl,$71DC
	add hl,bc
	ld b,[hl]
	inc hl
	ld c,[hl]
	push de
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,b
	ld hl,$0007
	add hl,de
	ld d,a
	ld a,[hl]
	add a,c
	ld e,a
	ld bc,$0280
	call Logged_0x2F6C
	ld a,d
	pop de
	jr z,Logged_0x42F9E
	ld hl,$0003
	add hl,de
	ld a,[hl]
	cp $10
	jr z,Unknown_0x42F8B
	cp $90
	jr z,Unknown_0x42F8B
	ld hl,$0007
	add hl,de
	ld a,[hl]
	cp $08
	jr z,Unknown_0x42F8B
	cp $98
	jr z,Unknown_0x42F8B
	jr Logged_0x42F8E

Unknown_0x42F8B:
	jp Logged_0x42CA4

Logged_0x42F8E:
	ld hl,$0014
	add hl,de
	ld a,[hl]
	add a,$D8
	ld c,a
	ld a,$00
	adc a,$71
	ld b,a
	ld a,[bc]
	ld [hl],a
	ret

Logged_0x42F9E:
	ld hl,$0014
	add hl,de
	ld a,[hl]
	sla a
	sla a
	push af
	add a,[hl]
	ld c,$00
	call Logged_0x43277
	ld hl,$0013
	add hl,de
	ld a,$10
	ld [hl],a
	pop af
	ld c,a
	ld b,$00
	ld hl,$6FDB
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0010
	add hl,de
	ld a,$0C
	ld [hl],a
	ret

LoggedData_0x42FDB:
INCBIN "baserom.gb", $42FDB, $42FEB - $42FDB
	ld hl,$0006
	add hl,de
	ld a,[hl]
	add a,$40
	ld [hld],a
	ld a,[hl]
	adc a,$00
	ld [hl],a
	ld hl,$0013
	add hl,de
	dec [hl]
	ret nz
	ld hl,$0014
	add hl,de
	ld a,[hl]
	sla a
	sla a
	ld c,a
	ld b,$00
	ld hl,$7042
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,$02
	ld [hl],a
	ld hl,$0013
	add hl,de
	xor a
	ld [hl],a
	ld hl,$001F
	add hl,de
	res 7,[hl]
	res 6,[hl]
	ld hl,$0010
	add hl,de
	ld a,$0D
	ld [hl],a
	jr Logged_0x430AB

LoggedData_0x43042:
INCBIN "baserom.gb", $43042, $43052 - $43042
	ld hl,$0013
	add hl,de
	ld a,[hl]
	inc a
	ld [hl],a
	and $0F
	jr z,Logged_0x430AB
	ld hl,$001F
	add hl,de
	bit 5,[hl]
	jr nz,Logged_0x43068
	jp Logged_0x43171

Logged_0x43068:
	res 5,[hl]
	ld hl,$0014
	add hl,de
	ld a,[hl]
	sla a
	ld c,a
	ld b,$00
	ld hl,$71E4
	add hl,bc
	ld b,[hl]
	inc hl
	ld c,[hl]
	push de
	ld hl,$0003
	add hl,de
	ld a,[hl]
	and $F0
	add a,b
	ld hl,$0007
	add hl,de
	ld d,a
	ld a,[hl]
	add a,$08
	and $F0
	sub $08
	add a,c
	ld e,a
	ld bc,$0280
	call Logged_0x2F6C
	ld a,d
	pop de
	jr z,Logged_0x430A8
	ld hl,$0013
	add hl,de
	ld c,[hl]
	ld a,$0F
	sub c
	ld [hl],a
	jp Logged_0x43118

Logged_0x430A8:
	jp Logged_0x43171

Logged_0x430AB:
	ld hl,$0014
	add hl,de
	ld a,[hl]
	sla a
	ld c,a
	ld b,$00
	ld hl,$71DC
	add hl,bc
	ld b,[hl]
	inc hl
	ld c,[hl]
	push de
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,b
	ld hl,$0007
	add hl,de
	ld d,a
	ld a,[hl]
	add a,c
	ld e,a
	ld bc,$0280
	call Logged_0x2F6C
	ld a,d
	pop de
	jr nz,Logged_0x43111
	cp $10
	jr z,Logged_0x430DC
	jp Logged_0x43171

Logged_0x430DC:
	ld hl,$0013
	add hl,de
	ld a,$10
	ld [hl],a
	ld hl,$0014
	add hl,de
	ld a,[hl]
	sla a
	sla a
	ld c,a
	ld b,$00
	ld hl,$6FDB
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0010
	add hl,de
	ld a,$03
	ld [hl],a
	ret

Logged_0x43111:
	ld hl,$0013
	add hl,de
	ld a,$0F
	ld [hl],a

Logged_0x43118:
	ld hl,$0006
	add hl,de
	push hl
	ld hl,$0004
	add hl,de
	pop bc
	ld a,[bc]
	add a,[hl]
	ld [hld],a
	dec bc
	ld a,[bc]
	adc a,[hl]
	ld [hl],a
	ld hl,$000A
	add hl,de
	push hl
	ld hl,$0008
	add hl,de
	pop bc
	ld a,[bc]
	add a,[hl]
	ld [hld],a
	dec bc
	ld a,[bc]
	adc a,[hl]
	ld [hl],a
	ld hl,$0014
	add hl,de
	ld a,[hl]
	add a,$D8
	ld c,a
	ld a,$00
	adc a,$71
	ld b,a
	ld a,[bc]
	ld [hl],a
	sla a
	sla a
	push af
	add a,[hl]
	ld c,$00
	call Logged_0x43277
	pop af
	add a,$42
	ld c,a
	ld a,$00
	adc a,$70
	ld b,a
	ld hl,$0006
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$000A
	add hl,de
	ld a,[bc]
	ld [hld],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ret

Logged_0x43171:
	ld b,$00
	ld hl,$001F
	add hl,de
	bit 7,[hl]
	ret z
	ld hl,$001E
	add hl,de
	ld c,[hl]
	ld hl,$0005
	add hl,de
	bit 0,c
	jr z,Logged_0x4318F
	bit 7,[hl]
	jr nz,Logged_0x43199
	set 0,b
	jr Logged_0x43199

Logged_0x4318F:
	bit 1,c
	jr z,Logged_0x43199
	bit 7,[hl]
	jr z,Logged_0x43199
	set 0,b

Logged_0x43199:
	ld hl,$0009
	add hl,de
	bit 2,c
	jr z,Unknown_0x431A9
	bit 7,[hl]
	jr nz,Logged_0x431B3
	set 1,b
	jr Logged_0x431B3

Unknown_0x431A9:
	bit 3,c
	jr z,Logged_0x431B3
	bit 7,[hl]
	jr z,Logged_0x431B3
	set 1,b

Logged_0x431B3:
	ld hl,$001F
	add hl,de
	xor a
	ld [hl],a
	ld hl,$0014
	add hl,de
	bit 1,[hl]
	jr z,Logged_0x431C7
	bit 1,b
	jr z,Logged_0x431D7
	jr Logged_0x431CB

Logged_0x431C7:
	bit 0,b
	jr z,Logged_0x431D7

Logged_0x431CB:
	ld hl,$0013
	add hl,de
	ld c,[hl]
	ld a,$0F
	sub c
	ld [hl],a
	jp Logged_0x43118

Logged_0x431D7:
	ret

LoggedData_0x431D8:
INCBIN "baserom.gb", $431D8, $431D9 - $431D8

UnknownData_0x431D9:
INCBIN "baserom.gb", $431D9, $431DA - $431D9

LoggedData_0x431DA:
INCBIN "baserom.gb", $431DA, $431EC - $431DA

UnknownData_0x431EC:
INCBIN "baserom.gb", $431EC, $43243 - $431EC

Logged_0x43243:
	ld hl,$000A
	add hl,de
	ld a,[hl]
	cpl
	add a,$01
	ld [hld],a
	ld a,[hl]
	cpl
	adc a,$00
	ld [hl],a
	ret

Logged_0x43252:
	ld hl,$0006
	add hl,de
	ld a,[hl]
	cpl
	add a,$01
	ld [hld],a
	ld a,[hl]
	cpl
	adc a,$00
	ld [hl],a
	ret

Logged_0x43261:
	ld a,[hld]
	add a,$80
	ld a,[hli]
	adc a,$00
	jr c,Logged_0x43273
	ld a,[hld]
	sub $80
	ld a,[hli]
	sbc a,$00
	jr c,Logged_0x43273
	jr Logged_0x43276

Logged_0x43273:
	xor a
	ld [hld],a
	ld [hl],a

Logged_0x43276:
	ret

Logged_0x43277:
	push de
	ld hl,$0002
	add hl,de
	ld [hl],a
	ld hl,$000C
	add hl,de
	set 7,[hl]
	inc hl
	call Logged_0x31C3
	pop de
	ret

Logged_0x43289:
	ld a,[$C220]
	push af
	cp $00
	jr nz,Logged_0x4329A
	ld a,[$C423]
	ld b,a
	ld a,[$C427]
	jr Logged_0x432A1

Logged_0x4329A:
	ld a,[$C223]
	ld b,a
	ld a,[$C227]

Logged_0x432A1:
	ld c,a
	pop af
	cp $00
	ret

Logged_0x432A6:
	ld a,[$C9E4]
	cp $07
	jr nz,Logged_0x432C0
	ld a,[$CEB5]
	cp $07
	jr z,Logged_0x432C0
	ld hl,$DC07
	set 7,[hl]
	ld a,$02
	ld [$D245],a
	jr Logged_0x432CA

Logged_0x432C0:
	ld hl,$DC07
	set 7,[hl]
	ld hl,$D245
	set 0,[hl]

Logged_0x432CA:
	ret
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x432D5
	dw Logged_0x43307

Logged_0x432D5:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$001B
	add hl,de
	ld [hl],a
	ld bc,$72EF
	jp Logged_0x438D3

UnknownData_0x432EF:
INCBIN "baserom.gb", $432EF, $43301 - $432EF

LoggedData_0x43301:
INCBIN "baserom.gb", $43301, $43307 - $43301

Logged_0x43307:
	xor a
	ld [$D28F],a
	ld [$D290],a
	ld [$D292],a
	ld hl,$0003
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	jr nz,Logged_0x43385
	ld a,[hli]
	and $FF
	jr nz,Logged_0x43385
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$0015
	add hl,de
	push de
	ld e,a
	ld a,b
	bit 7,[hl]
	jr z,Logged_0x43332
	sub $20

Logged_0x43332:
	add a,$10
	ld [$D28F],a
	ld d,a
	ld bc,$0280
	call Logged_0x2F6C
	pop de
	call nz,Logged_0x43979
	call Logged_0x43426
	ld hl,$0007
	add hl,de
	ld b,[hl]
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$0013
	add hl,de
	push de
	ld d,a
	ld a,b
	bit 7,[hl]
	jr z,Logged_0x4335C
	sub $20

Logged_0x4335C:
	add a,$10
	ld [$D290],a
	ld e,a
	ld bc,$0280
	call Logged_0x2F6C
	pop de
	call nz,Logged_0x43992
	call Logged_0x43426
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$001B
	add hl,de
	ld [hl],a
	jr Logged_0x433DF

Logged_0x43385:
	ld hl,$0017
	add hl,de
	ld a,[hl]
	or a
	jr nz,Logged_0x433DF
	ld hl,$0007
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	jr nz,Logged_0x433DF
	ld a,[hli]
	and $FF
	jr nz,Logged_0x433DF
	ld hl,$001B
	add hl,de
	ld a,[hli]
	ld hl,$0015
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x433AB
	sub $20

Logged_0x433AB:
	add a,$10
	ld [$D28F],a
	ld hl,$001A
	add hl,de
	ld a,[hli]
	ld hl,$0013
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x433BF
	sub $20

Logged_0x433BF:
	add a,$10
	ld [$D290],a
	push de
	ld a,[$D290]
	ld e,a
	ld a,[$D28F]
	ld d,a
	ld bc,$0280
	call Logged_0x2F6C
	pop de
	jr z,Logged_0x433DF
	call Logged_0x43979
	call Logged_0x43992
	call Logged_0x43426

Logged_0x433DF:
	ld c,$00
	call Logged_0x43A09
	jr c,Logged_0x43419
	ld hl,$001F
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x43422
	res 7,[hl]
	ld hl,$001E
	add hl,de
	ld c,[hl]
	ld hl,$0005
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x43403
	bit 1,c
	jr z,Logged_0x43422
	jr Logged_0x43407

Logged_0x43403:
	bit 0,c
	jr z,Logged_0x43422

Logged_0x43407:
	ld hl,$0009
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x43415
	bit 3,c
	jr z,Logged_0x43422
	jr Logged_0x43419

Logged_0x43415:
	bit 2,c
	jr z,Logged_0x43422

Logged_0x43419:
	call Logged_0x43979
	call Logged_0x43992
	call Logged_0x43426

Logged_0x43422:
	call Logged_0x439AB
	ret

Logged_0x43426:
	ld bc,$0000
	ld hl,$0013
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x43433
	set 1,c

Logged_0x43433:
	ld hl,$0015
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x4343D
	set 0,c

Logged_0x4343D:
	ld hl,$7448
	add hl,bc
	ld a,[hl]
	ld hl,$001C
	add hl,de
	ld [hl],a
	ret

LoggedData_0x43448:
INCBIN "baserom.gb", $43448, $4344C - $43448
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x43456
	dw Logged_0x43492

Logged_0x43456:
	ld bc,$7462
	call Logged_0x438D3
	ld hl,$0019
	add hl,de
	ld [hl],a
	ret

LoggedData_0x43462:
INCBIN "baserom.gb", $43462, $43492 - $43462

Logged_0x43492:
	xor a
	ld [$D292],a
	ld hl,$0019
	add hl,de
	ld c,[hl]
	bit 0,c
	jr z,Logged_0x434A8
	ld hl,$0003
	add hl,de
	ld a,[hli]
	and $0F
	jr Logged_0x434B1

Logged_0x434A8:
	ld hl,$0007
	add hl,de
	ld a,[hli]
	and $0F
	cp $08

Logged_0x434B1:
	jr nz,Logged_0x434BA
	ld a,[hli]
	and $FF
	jr nz,Logged_0x434BA
	jr Logged_0x434E5

Logged_0x434BA:
	ld hl,$001F
	add hl,de
	bit 5,[hl]
	jr z,Logged_0x43527
	res 5,[hl]
	ld b,$00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	ld a,c
	add a,$C9
	ld c,a
	ld a,b
	adc a,$75
	ld b,a
	inc bc
	inc bc
	inc bc
	inc bc
	call Logged_0x435AE
	jr z,Logged_0x43527
	jr Logged_0x4353A

Logged_0x434E5:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$001B
	add hl,de
	ld [hl],a
	ld b,$00
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	ld a,c
	add a,$C9
	ld c,a
	ld a,b
	adc a,$75
	ld b,a
	ld hl,$0017
	add hl,de
	ld a,[hl]
	or a
	jr z,Logged_0x4351B
	inc bc
	inc bc
	jr Logged_0x43520

Logged_0x4351B:
	call Logged_0x435AE
	jr z,Logged_0x43594

Logged_0x43520:
	inc bc
	inc bc
	call Logged_0x435AE
	jr nz,Logged_0x43594

Logged_0x43527:
	ld c,$00
	call Logged_0x43A09
	jr c,Logged_0x4353A
	call Logged_0x43B7F
	ld a,b
	and $03
	jr nz,Logged_0x4353A
	jr Logged_0x435AA

UnknownData_0x43538:
INCBIN "baserom.gb", $43538, $4353A - $43538

Logged_0x4353A:
	ld hl,$0019
	add hl,de
	ld a,[hl]
	cp $06
	jr nc,Logged_0x43565
	cp $02
	jr c,Logged_0x43565
	ld hl,$0007
	add hl,de
	ld a,[hl]
	sub $08
	and $F0
	add a,$08
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	and $F0
	ld hl,$001B
	add hl,de
	ld [hl],a
	jr Logged_0x43583

Logged_0x43565:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	add a,$07
	and $F0
	add a,$08
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	add a,$0F
	and $F0
	ld hl,$001B
	add hl,de
	ld [hl],a

Logged_0x43583:
	ld hl,$0019
	add hl,de
	ld a,[hl]
	add a,$09
	ld c,a
	ld a,$00
	adc a,$76
	ld b,a
	jr Logged_0x43594

UnknownData_0x43592:
INCBIN "baserom.gb", $43592, $43594 - $43592

Logged_0x43594:
	ld a,[bc]
	ld hl,$0011
	add hl,de
	ld [hl],a
	ld bc,$7462
	call Logged_0x43930
	ld hl,$0019
	add hl,de
	ld [hl],a
	ld a,$FF
	ld [$D292],a

Logged_0x435AA:
	call Logged_0x439AB
	ret

Logged_0x435AE:
	push de
	ld hl,$001B
	add hl,de
	ld a,[bc]
	inc bc
	add a,[hl]
	ld hl,$001A
	add hl,de
	ld d,a
	ld a,[bc]
	add a,[hl]
	inc bc
	push bc
	ld e,a
	ld bc,$0280
	call Logged_0x2F6C
	pop bc
	pop de
	ret

LoggedData_0x435C9:
INCBIN "baserom.gb", $435C9, $435CC - $435C9

UnknownData_0x435CC:
INCBIN "baserom.gb", $435CC, $435CD - $435CC

LoggedData_0x435CD:
INCBIN "baserom.gb", $435CD, $435D0 - $435CD

UnknownData_0x435D0:
INCBIN "baserom.gb", $435D0, $435D1 - $435D0

LoggedData_0x435D1:
INCBIN "baserom.gb", $435D1, $435D4 - $435D1

UnknownData_0x435D4:
INCBIN "baserom.gb", $435D4, $435D5 - $435D4

LoggedData_0x435D5:
INCBIN "baserom.gb", $435D5, $435D8 - $435D5

UnknownData_0x435D8:
INCBIN "baserom.gb", $435D8, $435D9 - $435D8

LoggedData_0x435D9:
INCBIN "baserom.gb", $435D9, $435DC - $435D9

UnknownData_0x435DC:
INCBIN "baserom.gb", $435DC, $435DD - $435DC

LoggedData_0x435DD:
INCBIN "baserom.gb", $435DD, $435E0 - $435DD

UnknownData_0x435E0:
INCBIN "baserom.gb", $435E0, $435E1 - $435E0

LoggedData_0x435E1:
INCBIN "baserom.gb", $435E1, $435E4 - $435E1

UnknownData_0x435E4:
INCBIN "baserom.gb", $435E4, $435E5 - $435E4

LoggedData_0x435E5:
INCBIN "baserom.gb", $435E5, $435E8 - $435E5

UnknownData_0x435E8:
INCBIN "baserom.gb", $435E8, $435E9 - $435E8

LoggedData_0x435E9:
INCBIN "baserom.gb", $435E9, $435EC - $435E9

UnknownData_0x435EC:
INCBIN "baserom.gb", $435EC, $435ED - $435EC

LoggedData_0x435ED:
INCBIN "baserom.gb", $435ED, $435F0 - $435ED

UnknownData_0x435F0:
INCBIN "baserom.gb", $435F0, $435F1 - $435F0

LoggedData_0x435F1:
INCBIN "baserom.gb", $435F1, $435F4 - $435F1

UnknownData_0x435F4:
INCBIN "baserom.gb", $435F4, $435F5 - $435F4

LoggedData_0x435F5:
INCBIN "baserom.gb", $435F5, $435F8 - $435F5

UnknownData_0x435F8:
INCBIN "baserom.gb", $435F8, $435F9 - $435F8

LoggedData_0x435F9:
INCBIN "baserom.gb", $435F9, $435FC - $435F9

UnknownData_0x435FC:
INCBIN "baserom.gb", $435FC, $435FD - $435FC

LoggedData_0x435FD:
INCBIN "baserom.gb", $435FD, $43600 - $435FD

UnknownData_0x43600:
INCBIN "baserom.gb", $43600, $43601 - $43600

LoggedData_0x43601:
INCBIN "baserom.gb", $43601, $43604 - $43601

UnknownData_0x43604:
INCBIN "baserom.gb", $43604, $43605 - $43604

LoggedData_0x43605:
INCBIN "baserom.gb", $43605, $43608 - $43605

UnknownData_0x43608:
INCBIN "baserom.gb", $43608, $43609 - $43608

LoggedData_0x43609:
INCBIN "baserom.gb", $43609, $43611 - $43609
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x4361B
	dw Logged_0x43653

Logged_0x4361B:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$001B
	add hl,de
	ld [hl],a
	ld hl,$001D
	add hl,de
	xor a
	ld [hl],a
	ld bc,$763B
	jp Logged_0x438D3

LoggedData_0x4363B:
INCBIN "baserom.gb", $4363B, $43647 - $4363B

UnknownData_0x43647:
INCBIN "baserom.gb", $43647, $43653 - $43647

Logged_0x43653:
	xor a
	ld [$D292],a
	ld hl,$0015
	add hl,de
	ld a,[hli]
	or [hl]
	jr nz,Logged_0x43662
	jp Logged_0x436FD

Logged_0x43662:
	ld hl,$0003
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	jr nz,Logged_0x43673
	ld a,[hli]
	and $FF
	jr nz,Logged_0x43673
	jr Logged_0x43682

Logged_0x43673:
	ld hl,$001F
	add hl,de
	bit 5,[hl]
	jr z,Logged_0x436A9
	res 5,[hl]
	ld hl,$001B
	add hl,de
	ld b,[hl]

Logged_0x43682:
	ld hl,$001B
	add hl,de
	ld [hl],b
	push de
	ld hl,$001A
	add hl,de
	ld a,[hl]
	ld hl,$0015
	add hl,de
	ld e,a
	call Logged_0x4379A
	ld d,a
	call Logged_0x2F6C
	pop de
	jr z,Logged_0x436A9
	ld hl,$001D
	add hl,de
	ld a,[hl]
	or a
	jr z,Logged_0x436CF
	ld a,$80
	ld [hl],a
	jr Logged_0x436CF

Logged_0x436A9:
	ld c,$00
	call Logged_0x43A09
	jr c,Logged_0x436B7
	call Logged_0x43B7F
	bit 0,b
	jr z,Logged_0x436E8

Logged_0x436B7:
	ld hl,$001B
	add hl,de
	ld b,[hl]
	push hl
	ld hl,$0015
	add hl,de
	call Logged_0x4379A
	pop hl
	ld [hl],a
	ld hl,$001D
	add hl,de
	ld a,$01
	ld [hl],a
	jr Logged_0x436D4

Logged_0x436CF:
	ld c,$00
	call Logged_0x43A09

Logged_0x436D4:
	call Logged_0x43979
	ld a,$0A
	ld hl,$0015
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x436E3
	ld a,$00

Logged_0x436E3:
	ld hl,$001C
	add hl,de
	ld [hl],a

Logged_0x436E8:
	ld a,[$D292]
	or a
	jr nz,Logged_0x436F9
	ld hl,$001D
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x436F9
	inc [hl]
	jr Logged_0x436FC

Logged_0x436F9:
	call Logged_0x439AB

Logged_0x436FC:
	ret

Logged_0x436FD:
	ld hl,$0007
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	cp $08
	jr nz,Logged_0x43710
	ld a,[hli]
	and $FF
	jr nz,Logged_0x43710
	jr Logged_0x4371F

Logged_0x43710:
	ld hl,$001F
	add hl,de
	bit 5,[hl]
	jr z,Logged_0x43746
	res 5,[hl]
	ld hl,$001A
	add hl,de
	ld b,[hl]

Logged_0x4371F:
	ld hl,$001A
	add hl,de
	ld [hl],b
	push de
	ld hl,$001B
	add hl,de
	ld a,[hl]
	ld hl,$0013
	add hl,de
	ld d,a
	call Logged_0x4379A
	ld e,a
	call Logged_0x2F6C
	pop de
	jr z,Logged_0x43746
	ld hl,$001D
	add hl,de
	ld a,[hl]
	or a
	jr z,Logged_0x4376C
	ld a,$80
	ld [hl],a
	jr Logged_0x4376C

Logged_0x43746:
	ld c,$00
	call Logged_0x43A09
	jr c,Logged_0x43754
	call Logged_0x43B7F
	bit 1,b
	jr z,Logged_0x43785

Logged_0x43754:
	ld hl,$001A
	add hl,de
	ld b,[hl]
	push hl
	ld hl,$0013
	add hl,de
	call Logged_0x4379A
	pop hl
	ld [hl],a
	ld hl,$001D
	add hl,de
	ld a,$01
	ld [hl],a
	jr Logged_0x43771

Logged_0x4376C:
	ld c,$00
	call Logged_0x43A09

Logged_0x43771:
	call Logged_0x43992
	ld a,$05
	ld hl,$0013
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x43780
	ld a,$0F

Logged_0x43780:
	ld hl,$001C
	add hl,de
	ld [hl],a

Logged_0x43785:
	ld a,[$D292]
	or a
	jr nz,Logged_0x43796
	ld hl,$001D
	add hl,de
	bit 7,[hl]
	jr z,Logged_0x43796
	inc [hl]
	jr Logged_0x43799

Logged_0x43796:
	call Logged_0x439AB

Logged_0x43799:
	ret

Logged_0x4379A:
	ld a,b
	bit 7,[hl]
	jr z,Logged_0x437A1
	sub $20

Logged_0x437A1:
	add a,$10
	ld bc,$0280
	ret
	ld hl,$0010
	add hl,de
	ld a,[hl]
	rst JumpList
	dw Logged_0x437B1
	dw Logged_0x437E9

Logged_0x437B1:
	ld hl,$0007
	add hl,de
	ld a,[hl]
	ld hl,$001A
	add hl,de
	ld [hl],a
	ld hl,$0003
	add hl,de
	ld a,[hl]
	ld hl,$001B
	add hl,de
	ld [hl],a
	ld hl,$001C
	add hl,de
	xor a
	ld [hl],a
	ld bc,$77D1
	jp Logged_0x438D3

LoggedData_0x437D1:
INCBIN "baserom.gb", $437D1, $437DD - $437D1

UnknownData_0x437DD:
INCBIN "baserom.gb", $437DD, $437E9 - $437DD

Logged_0x437E9:
	xor a
	ld [$D292],a
	ld hl,$0015
	add hl,de
	ld a,[hli]
	or [hl]
	jr nz,Logged_0x437F8
	jp Logged_0x4385D

Logged_0x437F8:
	ld hl,$0003
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	jr nz,Logged_0x43809
	ld a,[hli]
	and $FF
	jr nz,Logged_0x43809
	jr Logged_0x43818

Logged_0x43809:
	ld hl,$001F
	add hl,de
	bit 5,[hl]
	jr z,Logged_0x43832
	res 5,[hl]
	ld hl,$001B
	add hl,de
	ld b,[hl]

Logged_0x43818:
	ld hl,$001B
	add hl,de
	ld [hl],b
	push de
	ld hl,$001A
	add hl,de
	ld a,[hl]
	ld hl,$0015
	add hl,de
	ld e,a
	call Logged_0x438C6
	ld d,a
	call Logged_0x2F6C
	pop de
	jr nz,Logged_0x43851

Logged_0x43832:
	ld c,$00
	call Logged_0x43A09
	jr c,Logged_0x43840
	call Logged_0x43B7F
	bit 0,b
	jr z,Logged_0x43859

Logged_0x43840:
	ld hl,$001B
	add hl,de
	ld b,[hl]
	push hl
	ld hl,$0015
	add hl,de
	call Logged_0x438C6
	pop hl
	ld [hl],a
	jr Logged_0x43856

Logged_0x43851:
	ld c,$00
	call Logged_0x43A09

Logged_0x43856:
	call Logged_0x43979

Logged_0x43859:
	call Logged_0x439AB
	ret

Logged_0x4385D:
	ld hl,$0007
	add hl,de
	ld a,[hli]
	ld b,a
	and $0F
	cp $08
	jr nz,Logged_0x43870
	ld a,[hli]
	and $FF
	jr nz,Logged_0x43870
	jr Logged_0x4387F

Logged_0x43870:
	ld hl,$001F
	add hl,de
	bit 5,[hl]
	jr z,Logged_0x4389B
	res 5,[hl]
	ld hl,$001A
	add hl,de
	ld b,[hl]

Logged_0x4387F:
	ld hl,$001A
	add hl,de
	ld [hl],b
	push de
	ld hl,$001B
	add hl,de
	ld a,[hl]
	ld hl,$0013
	add hl,de
	ld d,a
	call Logged_0x438C6
	ld e,a
	call Logged_0x2F6C
	pop de
	jr z,Logged_0x4389B
	jr Logged_0x438BA

Logged_0x4389B:
	ld c,$00
	call Logged_0x43A09
	jr c,Logged_0x438A9
	call Logged_0x43B7F
	bit 1,b
	jr z,Logged_0x438C2

Logged_0x438A9:
	ld hl,$001A
	add hl,de
	ld b,[hl]
	push hl
	ld hl,$0013
	add hl,de
	call Logged_0x438C6
	pop hl
	ld [hl],a
	jr Logged_0x438BF

Logged_0x438BA:
	ld c,$00
	call Logged_0x43A09

Logged_0x438BF:
	call Logged_0x43992

Logged_0x438C2:
	call Logged_0x439AB
	ret

Logged_0x438C6:
	ld a,b
	bit 7,[hl]
	jr z,Logged_0x438CD
	sub $20

Logged_0x438CD:
	add a,$10
	ld bc,$0280
	ret

Logged_0x438D3:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	ld h,$00
	push bc
	sla a
	rl h
	ld c,a
	ld b,h
	sla a
	rl h
	ld l,a
	add hl,bc
	pop bc
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0015
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0013
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0017
	add hl,de
	ld a,$01
	ld [hl],a
	ld hl,$0002
	add hl,de
	ld a,[bc]
	ld [hl],a
	ld hl,$001C
	add hl,de
	ld [hl],a
	ld hl,$000C
	add hl,de
	set 7,[hl]
	inc hl
	xor a
	ld [hli],a
	ld [hli],a
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0010
	add hl,de
	inc [hl]
	inc bc
	ld a,[bc]
	ret

Logged_0x43930:
	ld hl,$0011
	add hl,de
	ld a,[hl]
	ld h,$00
	push bc
	sla a
	rl h
	ld c,a
	ld b,h
	sla a
	rl h
	ld l,a
	add hl,bc
	pop bc
	add hl,bc
	ld c,l
	ld b,h
	ld hl,$0015
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0013
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	inc bc
	ld hl,$0017
	add hl,de
	ld a,$01
	ld [hl],a
	ld hl,$001C
	add hl,de
	ld a,[bc]
	ld [hl],a
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a
	inc bc
	ld a,[bc]
	ret

Logged_0x43979:
	ld hl,$0016
	add hl,de
	ld a,[hl]
	cpl
	add a,$01
	ld [hld],a
	ld a,[hl]
	cpl
	adc a,$00
	ld [hl],a
	ld hl,$0017
	add hl,de
	inc [hl]
	ld a,$FF
	ld [$D292],a
	ret

Logged_0x43992:
	ld hl,$0014
	add hl,de
	ld a,[hl]
	cpl
	add a,$01
	ld [hld],a
	ld a,[hl]
	cpl
	adc a,$00
	ld [hl],a
	ld hl,$0017
	add hl,de
	inc [hl]
	ld a,$FF
	ld [$D292],a
	ret

Logged_0x439AB:
	ld a,[$D292]
	or a
	jr nz,Logged_0x439E7
	ld hl,$0017
	add hl,de
	ld a,[hl]
	or a
	jr z,Logged_0x439F4
	ld hl,$0015
	add hl,de
	ld c,l
	ld b,h
	ld hl,$0005
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ld hl,$0013
	add hl,de
	ld c,l
	ld b,h
	ld hl,$0009
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ld hl,$001C
	add hl,de
	ld a,[hl]
	call Logged_0x439F5
	ld hl,$0017
	add hl,de
	xor a
	ld [hl],a
	jr Logged_0x439F4

Logged_0x439E7:
	xor a
	ld hl,$0005
	add hl,de
	ld [hli],a
	ld [hl],a
	ld hl,$0009
	add hl,de
	ld [hli],a
	ld [hl],a

Logged_0x439F4:
	ret

Logged_0x439F5:
	push de
	ld hl,$0002
	add hl,de
	ld [hl],a
	ld hl,$000C
	add hl,de
	set 7,[hl]
	inc hl
	ld c,$00
	call Logged_0x31C3
	pop de
	ret

Logged_0x43A09:
	ld a,[$D141]
	bit 0,a
	jr z,Logged_0x43A13
	jp Logged_0x43AAE

Logged_0x43A13:
	ld b,$00
	sla c
	rl b
	sla c
	rl b
	ld hl,$7AB7
	add hl,bc
	push hl
	push de
	ld de,$C420
	ld a,[$D141]
	bit 0,a
	jr nz,Logged_0x43A30
	ld de,$C220

Logged_0x43A30:
	ld hl,$0003
	add hl,de
	ld b,[hl]
	ld hl,$0007
	add hl,de
	ld c,[hl]
	pop de
	ld hl,$0003
	add hl,de
	ld a,[hl]
	pop hl
	add a,[hl]
	cp b
	jr nc,Logged_0x43AAE
	inc hl
	add a,[hl]
	cp b
	jr c,Logged_0x43AAE
	push hl
	ld hl,$0007
	add hl,de
	ld a,[hl]
	pop hl
	inc hl
	add a,[hl]
	cp c
	jr nc,Logged_0x43AAE
	inc hl
	add a,[hl]
	cp c
	jr c,Logged_0x43AAE
	ld a,[$D16A]
	ld c,a
	ld a,[$D16B]
	or c
	jr nz,Logged_0x43A9C
	ld a,[$D141]
	bit 6,a
	jr nz,Logged_0x43A9C
	ld bc,$C420
	ld a,[$D141]
	bit 0,a
	jr nz,Logged_0x43A79
	ld bc,$C220

Logged_0x43A79:
	ld hl,$0013
	add hl,bc
	ld a,$10
	ld [hl],a
	ld hl,$001B
	add hl,bc
	ld a,$00
	ld [hl],a
	ld hl,$0014
	add hl,bc
	set 5,[hl]
	ld a,$02
	call Logged_0x1331
	ld c,a
	ld a,[$D142]
	and $FE
	or c
	ld [$D142],a

Logged_0x43A9C:
	ld hl,$0018
	add hl,de
	ld a,[hl]
	and a
	jr z,Logged_0x43AA6
	jr Logged_0x43AB4

Logged_0x43AA6:
	ld hl,$0018
	add hl,de
	inc a
	ld [hl],a
	scf
	ret

Logged_0x43AAE:
	ld hl,$0018
	add hl,de
	xor a
	ld [hl],a

Logged_0x43AB4:
	scf
	ccf
	ret

LoggedData_0x43AB7:
INCBIN "baserom.gb", $43AB7, $43ACF - $43AB7

UnknownData_0x43ACF:
INCBIN "baserom.gb", $43ACF, $43AD3 - $43ACF

Logged_0x43AD3:
	ld a,[$D141]
	bit 0,a
	jr nz,Logged_0x43ADD
	jp Logged_0x43B76

Logged_0x43ADD:
	ld b,$00
	sla c
	rl b
	sla c
	rl b
	ld hl,$7AB7
	add hl,bc
	push hl
	push de
	ld de,$C420
	ld a,[$D141]
	bit 0,a
	jr nz,Logged_0x43AFA
	ld de,$C220

Logged_0x43AFA:
	ld hl,$0003
	add hl,de
	ld b,[hl]
	ld hl,$0007
	add hl,de
	ld c,[hl]
	pop de
	ld hl,$0003
	add hl,de
	ld a,[hl]
	pop hl
	add a,[hl]
	cp b
	jr nc,Logged_0x43B76
	inc hl
	add a,[hl]
	cp b
	jr c,Logged_0x43B76
	push hl
	ld hl,$0007
	add hl,de
	ld a,[hl]
	pop hl
	inc hl
	add a,[hl]
	cp c
	jr nc,Logged_0x43B76
	inc hl
	add a,[hl]
	cp c
	jr c,Logged_0x43B76
	ld hl,$0018
	add hl,de
	ld a,[hl]
	and a
	jr nz,Logged_0x43B7C
	ld a,[$D16A]
	ld c,a
	ld a,[$D16B]
	or c
	jr nz,Logged_0x43B6E
	ld a,[$D141]
	bit 6,a
	jr nz,Logged_0x43B6E
	ld bc,$C420
	ld a,[$D141]
	bit 0,a
	jr nz,Logged_0x43B4B
	ld bc,$C220

Logged_0x43B4B:
	ld hl,$0013
	add hl,bc
	ld a,$10
	ld [hl],a
	ld hl,$001B
	add hl,bc
	ld a,$00
	ld [hl],a
	ld hl,$0014
	add hl,bc
	set 5,[hl]
	ld a,$02
	call Logged_0x1331
	ld c,a
	ld a,[$D142]
	and $FE
	or c
	ld [$D142],a

Logged_0x43B6E:
	ld hl,$0018
	add hl,de
	inc a
	ld [hl],a
	scf
	ret

Logged_0x43B76:
	ld hl,$0018
	add hl,de
	xor a
	ld [hl],a

Logged_0x43B7C:
	scf
	ccf
	ret

Logged_0x43B7F:
	ld b,$00
	ld hl,$001F
	add hl,de
	bit 7,[hl]
	ret z
	ld hl,$001E
	add hl,de
	ld c,[hl]
	ld hl,$0015
	add hl,de
	bit 0,c
	jr z,Logged_0x43B9D
	bit 7,[hl]
	jr nz,Logged_0x43BA7
	set 0,b
	jr Logged_0x43BA7

Logged_0x43B9D:
	bit 1,c
	jr z,Logged_0x43BA7
	bit 7,[hl]
	jr z,Logged_0x43BA7
	set 0,b

Logged_0x43BA7:
	ld hl,$0013
	add hl,de
	bit 2,c
	jr z,Logged_0x43BB7
	bit 7,[hl]
	jr nz,Logged_0x43BC1
	set 1,b
	jr Logged_0x43BC1

Logged_0x43BB7:
	bit 3,c
	jr z,Logged_0x43BC1
	bit 7,[hl]
	jr z,Logged_0x43BC1
	set 1,b

Logged_0x43BC1:
	ld hl,$001F
	add hl,de
	xor a
	ld [hl],a
	ret

UnknownData_0x43BC8:
INCBIN "baserom.gb", $43BC8, $44000 - $43BC8

SECTION "Bank11", ROMX, BANK[$11]

Logged_0x44000:
	call Logged_0x37E0
	call Logged_0x451D1
	call Logged_0x45196
	call Logged_0x2958
	call Logged_0x0B60
	ld a,[$D26E]
	rst JumpList
	dw Logged_0x4401B
	dw Logged_0x440BE
	dw Logged_0x440D0
	dw Logged_0x440FE

Logged_0x4401B:
	call Logged_0x05CC
	call Logged_0x1384
	ld a,$01
	ld [$D12E],a
	ld a,$01
	ld [$C157],a
	ld a,$E3
	ld [$C0A7],a
	xor a
	ld [$C0DE],a
	ld [$FF00+$42],a
	ld [$C0DF],a
	ld [$FF00+$43],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld a,$E4
	ld [$FF00+$47],a
	ld a,$1E
	ld [$FF00+$48],a
	ld hl,$9800
	ld bc,$0800
	ld a,$03
	call Logged_0x0914
	call Logged_0x45747
	ld a,$0F
	call Logged_0x0A96
	ld hl,$9800
	ld de,$0010
	call Logged_0x37A1
	ld hl,$9C00
	ld de,$0011
	call Logged_0x37A1
	ld hl,$C200
	ld de,$0004
	call Logged_0x3795
	ld de,$0004
	call Logged_0x4514A
	ld a,$01
	ld [$D701],a
	xor a
	ld [$C128],a
	ld a,$03
	ld [$C129],a
	ld a,$01
	ld [$C156],a
	ld hl,$4CEE
	ld de,$C12A
	ld c,$0C

Logged_0x4409A:
	ld a,[hli]
	ld [de],a
	inc de
	dec c
	jr nz,Logged_0x4409A
	ld a,$34
	call Logged_0x1629
	ld a,$34
	call Logged_0x3262
	xor a
	ld [$FF00+$45],a
	ld a,[$C0A6]
	set 1,a
	ld [$C0A6],a
	call Logged_0x060E
	ld a,$01
	ld [$D26E],a
	ret

Logged_0x440BE:
	ld a,$E4
	ld [$FF00+$47],a
	ld a,$1E
	ld [$FF00+$48],a
	ld a,$83
	ld [$FF00+$49],a
	ld a,$02
	ld [$D26E],a
	ret

Logged_0x440D0:
	ld a,[$D704]
	and a
	jr nz,Logged_0x440E8
	ld a,[$FF00+$8B]
	and $08
	ret z
	ld a,$FF
	ld [$FF00+$47],a
	ld [$FF00+$49],a
	ld [$FF00+$48],a
	ld [$D704],a
	jr Logged_0x440FE

Logged_0x440E8:
	ld d,$00
	ld e,$20
	call Logged_0x4514A
	ld a,$01
	ld [$D701],a
	xor a
	ld [$D704],a
	ld a,$03
	ld [$D26E],a
	ret

Logged_0x440FE:
	ld a,[$D704]
	and a
	ret z
	call Logged_0x45158
	ld bc,$023C
	call Logged_0x0AE5
	ld a,$12
	ld [$FF00+$91],a
	ld a,$0A
	ld [$FF00+$90],a
	ld a,$03
	call Logged_0x1629
	ld a,$0B
	call Logged_0x1629
	ld a,[$FF00+$FF]
	res 1,a
	ld [$FF00+$FF],a
	ld a,$00
	ld [$D12E],a
	xor a
	ld [$C156],a
	xor a
	ld [$D26E],a
	ret

Logged_0x44132:
	call Logged_0x451D1
	call Logged_0x2958
	ld a,[$D26D]
	rst JumpList
	dw Logged_0x44140
	dw Logged_0x441AC

Logged_0x44140:
	call Logged_0x05CC
	call Logged_0x1384
	ld a,$01
	ld [$D12E],a
	ld a,$01
	ld [$C157],a
	ld a,$E3
	ld [$C0A7],a
	xor a
	ld [$FF00+$42],a
	ld [$C0DE],a
	ld [$FF00+$43],a
	ld [$C0DF],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	xor a
	ld [$FF00+$47],a
	ld a,$1C
	ld [$FF00+$48],a
	ld a,$83
	ld [$FF00+$49],a
	ld hl,$9800
	ld bc,$0400
	ld a,$7E
	call Logged_0x0914
	call Logged_0x3851
	ld a,$29
	call Logged_0x0A96
	ld a,$FF
	ld [$D727],a
	ld a,$7A
	call Logged_0x1629
	ld a,$7A
	call Logged_0x3262
	call Logged_0x060E
	ld a,$00
	ld [$D243],a
	ld a,$09
	ld [$D244],a
	ld a,$1E
	ld [$FF00+$47],a
	ld a,$01
	ld [$D26D],a
	ret

Logged_0x441AC:
	ld a,[$FF00+$8B]
	and $0B
	ret z
	call Logged_0x45158
	ld hl,$DC06
	set 0,[hl]
	ld a,$00
	ld [$D26D],a
	ld bc,$0228
	call Logged_0x0AE5
	xor a
	ld [$FF00+$49],a
	ld [$FF00+$47],a
	ld a,$00
	ld [$D12E],a
	xor a
	ld [$FF00+$42],a
	ld [$C0DE],a
	ld [$FF00+$43],a
	ld [$C0DF],a
	xor a
	ld [$C580],a
	ld [$C5A0],a
	ld [$C5C0],a
	ld a,$00
	ld [$C157],a
	xor a
	ld [$D6A5],a
	ret

Logged_0x441ED:
	call Logged_0x451D1
	call Logged_0x2958
	ld a,[$D26D]
	rst JumpList
	dw Logged_0x441FF
	dw Logged_0x4432B
	dw Logged_0x44361
	dw Logged_0x443B0

Logged_0x441FF:
	call Logged_0x05CC
	call Logged_0x1384
	ld a,$01
	ld [$D12E],a
	ld a,$01
	ld [$C157],a
	ld a,$E3
	ld [$C0A7],a
	xor a
	ld [$FF00+$42],a
	ld [$C0DE],a
	ld [$FF00+$43],a
	ld [$C0DF],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	xor a
	ld [$FF00+$47],a
	ld a,$1C
	ld [$FF00+$48],a
	ld a,$83
	ld [$FF00+$49],a
	ld hl,$9800
	ld bc,$0400
	ld a,$7E
	call Logged_0x0914
	ld a,[$D141]
	bit 7,a
	jr z,Logged_0x4424F
	ld a,[$C223]
	and $F0
	ld b,a
	ld a,[$C227]
	jr Logged_0x44258

Logged_0x4424F:
	ld a,[$C423]
	and $F0
	ld b,a
	ld a,[$C427]

Logged_0x44258:
	sub $08
	swap a
	and $0F
	or b
	sub $10
	ld c,a
	ld a,[$C9E4]
	ld d,a
	ld a,[$CFDB]
	ld e,a
	ld hl,$7D24

Logged_0x4426D:
	ld a,[hli]
	cp $FF
	jr z,Logged_0x44284
	cp d
	jr nz,Logged_0x4427F
	ld a,[hli]
	cp e
	jr nz,Logged_0x44280
	ld a,[hli]
	cp c
	jr nz,Logged_0x44281
	jr Logged_0x44284

Logged_0x4427F:
	inc hl

Logged_0x44280:
	inc hl

Logged_0x44281:
	inc hl
	jr Logged_0x4426D

Logged_0x44284:
	ld a,[hl]
	ld [$D6A5],a
	call Logged_0x3851
	cp $5A
	jr nc,Logged_0x442F1
	cp $50
	jr nc,Logged_0x4429E
	cp $46
	jr c,Logged_0x4429E
	ld a,$2A
	call Logged_0x0A96
	jr Logged_0x442A3

Logged_0x4429E:
	ld a,$28
	call Logged_0x0A96

Logged_0x442A3:
	ld hl,$C5A0
	ld de,$0024
	call Logged_0x3795
	ld a,$60
	ld [$D727],a
	ld [$FF00+$42],a
	ld [$C0DE],a
	ld a,$48
	call Logged_0x1629
	ld a,$48
	call Logged_0x3262
	call Logged_0x060E
	ld a,[$C9E4]
	sub $08
	jr c,Logged_0x442D4
	dec a
	jr z,Logged_0x442E0
	ld hl,$C14B
	ld a,[hli]
	or [hl]
	jr z,Logged_0x442E6

Logged_0x442D4:
	ld a,$01
	ld [$D243],a
	ld a,$0B
	ld [$D244],a
	jr Logged_0x442E6

Logged_0x442E0:
	ld bc,$0210
	call Logged_0x0B09

Logged_0x442E6:
	ld hl,$DC0C
	set 3,[hl]
	ld a,$01
	ld [$D26D],a
	ret

Logged_0x442F1:
	ld a,$29
	call Logged_0x0A96
	ld a,$FF
	ld [$D727],a
	ld a,$7A
	call Logged_0x1629
	ld a,$7A
	call Logged_0x3262
	call Logged_0x060E
	ld a,[$D136]
	cp $06
	jr nz,Logged_0x4431B
	ld a,$01
	ld [$D243],a
	ld a,$0D
	ld [$D244],a
	jr Logged_0x44321

Logged_0x4431B:
	ld bc,$0210
	call Logged_0x0B09

Logged_0x44321:
	ld a,$1E
	ld [$FF00+$47],a
	ld a,$02
	ld [$D26D],a
	ret

Logged_0x4432B:
	ld a,[$D727]
	ld [$C0DE],a
	srl a
	add a,$88
	ld [$C5A3],a
	ld a,[$D727]
	swap a
	srl a
	and $03
	ld c,a
	ld b,$00
	ld hl,$435D
	add hl,bc
	ld a,[hl]
	ld [$FF00+$47],a
	ld a,[$D727]
	dec a
	dec a
	dec a
	ld [$D727],a
	cp $FD
	ret nz
	ld a,$02
	ld [$D26D],a
	ret

LoggedData_0x4435D:
INCBIN "baserom.gb", $4435D, $44361 - $4435D

Logged_0x44361:
	ld a,[$FF00+$8B]
	and $0B
	ret z
	call Logged_0x45158
	ld hl,$DC06
	set 0,[hl]
	ld a,[$D727]
	cp $FF
	jr nz,Logged_0x44382
	ld bc,$0228
	call Logged_0x0AF7
	xor a
	ld [$FF00+$49],a
	ld [$FF00+$47],a
	jr Logged_0x443E4

Logged_0x44382:
	ld a,[$C9E4]
	sub $08
	jr c,Logged_0x44393
	dec a
	jr z,Logged_0x4439B
	ld hl,$C14B
	ld a,[hli]
	or [hl]
	jr z,Logged_0x443A1

Logged_0x44393:
	ld bc,$0228
	call Logged_0x0AE5
	jr Logged_0x443A1

Logged_0x4439B:
	ld bc,$0228
	call Logged_0x0AF7

Logged_0x443A1:
	ld hl,$DC0C
	set 4,[hl]
	xor a
	ld [$D727],a
	ld a,$03
	ld [$D26D],a
	ret

Logged_0x443B0:
	ld a,[$D727]
	ld [$C0DE],a
	srl a
	add a,$88
	ld [$C5A3],a
	ld a,[$D727]
	swap a
	srl a
	and $03
	ld c,a
	ld b,$00
	ld hl,$43E0
	add hl,bc
	ld a,[hl]
	ld [$FF00+$49],a
	ld [$FF00+$47],a
	ld a,[$D727]
	inc a
	inc a
	inc a
	ld [$D727],a
	cp $63
	jr z,Logged_0x443E4
	ret

LoggedData_0x443E0:
INCBIN "baserom.gb", $443E0, $443E4 - $443E0

Logged_0x443E4:
	ld a,$00
	ld [$D12E],a
	ld a,$00
	ld [$D26D],a
	xor a
	ld [$FF00+$42],a
	ld [$C0DE],a
	ld [$FF00+$43],a
	ld [$C0DF],a
	xor a
	ld [$C580],a
	ld [$C5A0],a
	ld [$C5C0],a
	ld a,[$D136]
	cp $06
	jr nz,Logged_0x44425
	ld a,$00
	ld [$C157],a
	ld a,[$D12B]
	res 0,a
	ld [$D12B],a
	xor a
	ld [$C154],a
	ld a,$07
	ld [$FF00+$91],a
	ld a,$20
	ld [$DC0A],a
	ret

Logged_0x44425:
	call Logged_0x2570
	ld a,[$D12B]
	res 0,a
	ld [$D12B],a
	ld a,$00
	ld [$C157],a
	ld a,[$C155]
	ld [$FF00+$91],a
	ret

Logged_0x4443B:
	call Logged_0x451D1
	call Logged_0x2958
	call Logged_0x47F0A
	ld a,[$D26D]
	rst JumpList
	dw Logged_0x44452
	dw Logged_0x44554
	dw Logged_0x4481E
	dw Logged_0x448FE
	dw Logged_0x44968

Logged_0x44452:
	call Logged_0x05CC
	call Logged_0x1384
	ld a,$01
	ld [$D12E],a
	ld a,$01
	ld [$C157],a
	ld a,$E3
	ld [$C0A7],a
	xor a
	ld [$FF00+$42],a
	ld [$FF00+$43],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld a,$1E
	ld [$FF00+$47],a
	ld [$FF00+$48],a
	ld [$FF00+$49],a
	ld a,$0A
	call Logged_0x0A96
	ld hl,$9800
	ld de,$0003
	call Logged_0x37A1
	call Logged_0x444C0
	call Logged_0x444F8
	ld hl,$C580
	ld de,$0020
	call Logged_0x3795
	ld a,$33
	call Logged_0x1629
	ld a,$33
	call Logged_0x3262
	call Logged_0x060E
	ld a,$01
	ld [$D26D],a
	ld a,$04
	ld [$D70B],a
	ld a,$01
	ld [$D707],a
	xor a
	ld [$D708],a
	ld [$D709],a
	ld [$D706],a
	ret

Logged_0x444C0:
	ld de,$CE54
	ld bc,$44F0
	ld l,$04

Logged_0x444C8:
	ld a,[de]
	bit 0,a
	jr nz,Logged_0x444E9
	push hl
	ld a,[bc]
	ld l,a
	inc bc
	ld a,[bc]
	ld h,a
	dec bc
	ld a,$A2
	ld [hli],a
	ld a,$A3
	ld [hl],a
	ld a,l
	add a,$1F
	ld l,a
	ld a,h
	adc a,$00
	ld h,a
	ld a,$B2
	ld [hli],a
	ld a,$B3
	ld [hl],a
	pop hl

Logged_0x444E9:
	inc de
	inc bc
	inc bc
	dec l
	jr nz,Logged_0x444C8
	ret

LoggedData_0x444F0:
INCBIN "baserom.gb", $444F0, $444F8 - $444F0

Logged_0x444F8:
	ld a,[$CE53]
	bit 6,a
	jr z,Logged_0x4450F
	ld hl,$9909
	ld a,$80
	ld [hli],a
	inc a
	ld [hl],a
	ld hl,$9929
	ld a,$90
	ld [hli],a
	inc a
	ld [hl],a

Logged_0x4450F:
	ld a,[$CE66]
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld hl,$C150
	ld de,$9925
	ld c,$00
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	ld a,[$CE5C]
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld hl,$C151
	ld de,$992D
	ld c,$00
	call Logged_0x3AA0
	ld a,[$CE5B]
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld hl,$C150
	ld de,$992F
	ld c,$00
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	ret

Logged_0x44554:
	ld a,[$FF00+$8A]
	and a
	jr nz,Logged_0x4455E
	xor a
	ld [$D725],a
	ret

Logged_0x4455E:
	bit 2,a
	ret nz
	ld a,[$FF00+$8B]
	and a
	jr nz,Logged_0x44571
	ld hl,$D725
	inc [hl]
	ld a,[hl]
	cp $1E
	ret c
	ld a,$17
	ld [hl],a

Logged_0x44571:
	ld a,[$D707]
	add a,$0C
	ld l,a
	ld a,$00
	adc a,$46
	ld h,a
	ld c,[hl]
	ld a,[$D707]
	add a,$08
	ld l,a
	ld a,$00
	adc a,$D7
	ld h,a
	ld a,[$FF00+$8B]
	bit 7,a
	jr nz,Logged_0x445A6
	bit 6,a
	jr nz,Logged_0x445B3
	bit 5,a
	jr nz,Logged_0x445BF
	bit 4,a
	jr nz,Logged_0x445C7
	bit 1,a
	jr nz,Logged_0x445A3
	and $09
	jr nz,Logged_0x445FB
	ret

Logged_0x445A3:
	jp Logged_0x44ADF

Logged_0x445A6:
	ld a,[$D707]
	inc a
	cp $02
	jr z,Logged_0x445D3
	ld [$D707],a
	jr Logged_0x445CE

Logged_0x445B3:
	ld a,[$D707]
	sub $01
	jr c,Logged_0x445D3
	ld [$D707],a
	jr Logged_0x445CE

Logged_0x445BF:
	ld a,[hl]
	sub $01
	jr c,Logged_0x445D3
	ld [hl],a
	jr Logged_0x445CE

Logged_0x445C7:
	ld a,[hl]
	add a,$01
	cp c
	jr z,Logged_0x445D3
	ld [hl],a

Logged_0x445CE:
	ld a,$10
	ld [$DC06],a

Logged_0x445D3:
	ld a,[$D707]
	add a,$08
	ld l,a
	ld a,$00
	adc a,$D7
	ld h,a
	ld a,[$D707]
	sla a
	sla a
	add a,[hl]
	ld [$D70B],a
	sla a
	ld h,$00
	ld l,a
	ld de,$460E
	add hl,de
	ld a,[hli]
	ld [$C5A3],a
	ld a,[hld]
	ld [$C5A7],a
	ret

Logged_0x445FB:
	ld a,[$D707]
	cp $01
	jr nz,Logged_0x4461E
	ld a,[$D709]
	inc a
	dec a
	jr nz,Logged_0x4461E
	jp Logged_0x44ADF

LoggedData_0x4460C:
INCBIN "baserom.gb", $4460C, $4461C - $4460C

UnknownData_0x4461C:
INCBIN "baserom.gb", $4461C, $4461E - $4461C

Logged_0x4461E:
	ld a,$20
	ld [$DC06],a
	ld a,[$D70B]
	ld e,a
	ld d,$00
	sla e
	sla e
	ld hl,$46D0
	add hl,de
	push hl
	ld a,[$CFDB]
	add a,$42
	ld l,a
	ld a,$00
	adc a,$CC
	ld h,a
	ld a,[hl]
	pop hl
	cp $FF
	jr nz,Logged_0x44653
	ld a,[$D70B]
	cp $03
	jr nz,Logged_0x44653
	xor a
	ld [$C5A0],a
	ld a,$39
	jp Logged_0x446F0

Logged_0x44653:
	ld a,[$C9E4]
	cp $08
	jr nz,Logged_0x4466C
	xor a
	ld [$C5A0],a
	ld a,[$D70B]
	srl a
	srl a
	and $02
	add a,$39
	jp Logged_0x446F0

Logged_0x4466C:
	ld a,[$D12A]
	bit 0,a
	jr z,Logged_0x44682
	ld a,[$D70B]
	cp $03
	jr nz,Logged_0x44682
	xor a
	ld [$C5A0],a
	ld a,$39
	jr Logged_0x446F0

Logged_0x44682:
	ld a,[hl]
	cp $FF
	jr z,Logged_0x446BD
	cp $FE
	jr z,Unknown_0x446AD
	push hl
	ld e,a
	ld hl,$CE54
	add hl,de
	ld a,[hl]
	pop hl
	bit 7,a
	jr nz,Unknown_0x4469D
	cp $00
	jr z,Unknown_0x446A5
	jr Logged_0x446BD

Unknown_0x4469D:
	xor a
	ld [$C5A0],a
	ld a,$39
	jr Logged_0x446F0

Unknown_0x446A5:
	xor a
	ld [$C5A0],a
	ld a,$38
	jr Logged_0x446F0

Unknown_0x446AD:
	push hl
	call Logged_0x37CD
	pop hl
	jr c,Logged_0x446BD
	xor a
	ld [$C5A0],a
	ld a,$3A
	jp Logged_0x446F0

Logged_0x446BD:
	inc hl
	inc hl
	inc hl
	xor a
	ld [$C5A0],a
	ld a,[hl]
	cp $40
	jr nz,Logged_0x446F0
	ld a,[$C9E4]
	add a,$40
	jr Logged_0x446F0

LoggedData_0x446D0:
INCBIN "baserom.gb", $446D0, $446D1 - $446D0

UnknownData_0x446D1:
INCBIN "baserom.gb", $446D1, $446D3 - $446D1

LoggedData_0x446D3:
INCBIN "baserom.gb", $446D3, $446D5 - $446D3

UnknownData_0x446D5:
INCBIN "baserom.gb", $446D5, $446D7 - $446D5

LoggedData_0x446D7:
INCBIN "baserom.gb", $446D7, $446D9 - $446D7

UnknownData_0x446D9:
INCBIN "baserom.gb", $446D9, $446DB - $446D9

LoggedData_0x446DB:
INCBIN "baserom.gb", $446DB, $446DD - $446DB

UnknownData_0x446DD:
INCBIN "baserom.gb", $446DD, $446DF - $446DD

LoggedData_0x446DF:
INCBIN "baserom.gb", $446DF, $446E0 - $446DF

UnknownData_0x446E0:
INCBIN "baserom.gb", $446E0, $446E4 - $446E0

LoggedData_0x446E4:
INCBIN "baserom.gb", $446E4, $446E5 - $446E4

UnknownData_0x446E5:
INCBIN "baserom.gb", $446E5, $446E7 - $446E5

LoggedData_0x446E7:
INCBIN "baserom.gb", $446E7, $446E9 - $446E7

UnknownData_0x446E9:
INCBIN "baserom.gb", $446E9, $446EB - $446E9

LoggedData_0x446EB:
INCBIN "baserom.gb", $446EB, $446EC - $446EB

UnknownData_0x446EC:
INCBIN "baserom.gb", $446EC, $446F0 - $446EC

Logged_0x446F0:
	ld [$D729],a
	push af
	push af
	ld a,$1C
	call Logged_0x164B
	pop af
	ld d,$00
	ld e,a
	sla e
	rl d
	sla e
	rl d
	ld hl,$46A1
	add hl,de
	ld a,[hli]
	ld [$D713],a
	ld a,$98
	ld [$D714],a
	ld a,[hli]
	ld [$D717],a
	ld a,[hli]
	ld [$D719],a
	ld a,[hli]
	ld [$D71B],a
	ld hl,$5757
	add hl,de
	ld de,$D2A5
	ld a,e
	ld [$D715],a
	ld a,d
	ld [$D716],a
	ld a,[hli]
	ld [$D70F],a
	ld a,[hli]
	ld [$D711],a
	ld a,[hli]
	ld e,a
	ld a,[hl]
	ld d,a
	ld a,[de]
	ld c,a
	inc de
	ld a,[de]
	ld b,a
	inc de
	inc b
	ld hl,$D2A5

Logged_0x44744:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x44744
	dec b
	jr nz,Logged_0x44744
	pop af
	cp $40
	call nc,Logged_0x447C1
	ld a,[$D129]
	or $01
	ld [$D129],a
	ld a,$02
	ld [$D26D],a
	ret

LoggedData_0x44761:
INCBIN "baserom.gb", $44761, $44769 - $44761

UnknownData_0x44769:
INCBIN "baserom.gb", $44769, $4476D - $44769

LoggedData_0x4476D:
INCBIN "baserom.gb", $4476D, $44771 - $4476D

UnknownData_0x44771:
INCBIN "baserom.gb", $44771, $44779 - $44771

LoggedData_0x44779:
INCBIN "baserom.gb", $44779, $44781 - $44779

UnknownData_0x44781:
INCBIN "baserom.gb", $44781, $447A1 - $44781

LoggedData_0x447A1:
INCBIN "baserom.gb", $447A1, $447AD - $447A1

UnknownData_0x447AD:
INCBIN "baserom.gb", $447AD, $447B1 - $447AD

LoggedData_0x447B1:
INCBIN "baserom.gb", $447B1, $447BD - $447B1

UnknownData_0x447BD:
INCBIN "baserom.gb", $447BD, $447C1 - $447BD

Logged_0x447C1:
	and $0F
	ld e,a
	ld d,$00
	ld hl,$4816
	add hl,de
	ld e,[hl]
	ld hl,$D2A5
	add hl,de
	ld de,$CC42
	ld a,[$C9E5]
	ld b,a

Logged_0x447D6:
	push hl
	ld a,[$C9E6]
	ld c,a

Logged_0x447DB:
	ld a,[$CE55]
	bit 0,a
	jr nz,Logged_0x447EC
	ld a,[hl]
	and $F0
	cp $E0
	jr nz,Logged_0x447EC
	ld a,$D0
	ld [hl],a

Logged_0x447EC:
	ld a,[de]
	cp $FF
	jr nz,Logged_0x44803
	ld a,[hl]
	cp $D0
	jr z,Logged_0x44801
	cp $E9
	jr z,Logged_0x44800
	cp $EA
	jr z,Logged_0x44800
	jr Logged_0x44803

Logged_0x44800:
	inc a

Logged_0x44801:
	inc a
	ld [hl],a

Logged_0x44803:
	inc de
	inc hl
	dec c
	jr nz,Logged_0x447DB
	pop hl
	push de
	ld a,[$D711]
	ld e,a
	ld d,$00
	add hl,de
	pop de
	dec b
	jr nz,Logged_0x447D6
	ret

LoggedData_0x44816:
INCBIN "baserom.gb", $44816, $44819 - $44816

UnknownData_0x44819:
INCBIN "baserom.gb", $44819, $4481A - $44819

LoggedData_0x4481A:
INCBIN "baserom.gb", $4481A, $4481D - $4481A

UnknownData_0x4481D:
INCBIN "baserom.gb", $4481D, $4481E - $4481D

Logged_0x4481E:
	ld a,[$D70F]
	cp $00
	jr nz,Logged_0x44850
	ld hl,$D129
	bit 0,[hl]
	ret nz
	ld a,[$D729]
	ld hl,$486D
	add a,l
	ld l,a
	ld a,$00
	adc a,h
	ld h,a
	ld a,[hl]
	call Logged_0x164B
	ld a,[$D717]
	ld [$C5C3],a
	ld a,[$D719]
	ld [$C5C7],a
	call Logged_0x448B5
	ld a,$04
	ld [$D26D],a
	ret

Logged_0x44850:
	dec a
	ld [$D70F],a
	ld a,[$D713]
	ld [$D29F],a
	ld e,a
	ld a,[$D714]
	ld [$D2A0],a
	ld d,a
	ld hl,$0020
	add hl,de
	ld a,l
	ld [$D713],a
	ld a,h
	ld [$D714],a
	ld a,$01
	ld [$D2A1],a
	ld a,[$D711]
	ld [$D2A2],a
	ld a,[$D715]
	ld [$D2A3],a
	ld e,a
	ld a,[$D716]
	ld [$D2A4],a
	ld d,a
	ld a,[$D711]
	ld l,a
	ld h,$00
	add hl,de
	ld a,l
	ld [$D715],a
	ld a,h
	ld [$D716],a
	ld de,$D29F
	call Logged_0x09A3
	ret

LoggedData_0x4489D:
INCBIN "baserom.gb", $4489D, $4489F - $4489D

UnknownData_0x4489F:
INCBIN "baserom.gb", $4489F, $448A0 - $4489F

LoggedData_0x448A0:
INCBIN "baserom.gb", $448A0, $448A1 - $448A0

UnknownData_0x448A1:
INCBIN "baserom.gb", $448A1, $448A3 - $448A1

LoggedData_0x448A3:
INCBIN "baserom.gb", $448A3, $448A5 - $448A3

UnknownData_0x448A5:
INCBIN "baserom.gb", $448A5, $448AD - $448A5

LoggedData_0x448AD:
INCBIN "baserom.gb", $448AD, $448B0 - $448AD

UnknownData_0x448B0:
INCBIN "baserom.gb", $448B0, $448B1 - $448B0

LoggedData_0x448B1:
INCBIN "baserom.gb", $448B1, $448B4 - $448B1

UnknownData_0x448B4:
INCBIN "baserom.gb", $448B4, $448B5 - $448B4

Logged_0x448B5:
	ld a,[$D70B]
	cp $00
	ret nz
	ld hl,$CE54
	bit 7,[hl]
	ret nz
	bit 0,[hl]
	ret z
	ld a,[$C9E4]
	cp $08
	ret z
	ld e,a
	ld d,$00
	ld hl,$48F6
	add hl,de
	ld a,[hl]
	ld e,a
	ld d,$48
	ld hl,$C9E6
	ld a,[$CFDB]

Logged_0x448DB:
	sub [hl]
	jr c,Logged_0x448E6
	push af
	ld a,$08
	add a,d
	ld d,a
	pop af
	jr Logged_0x448DB

Logged_0x448E6:
	add a,[hl]
	sla a
	sla a
	sla a
	add a,e
	ld [$C587],a
	ld a,d
	ld [$C583],a
	ret

LoggedData_0x448F6:
INCBIN "baserom.gb", $448F6, $448F9 - $448F6

UnknownData_0x448F9:
INCBIN "baserom.gb", $448F9, $448FA - $448F9

LoggedData_0x448FA:
INCBIN "baserom.gb", $448FA, $448FD - $448FA

UnknownData_0x448FD:
INCBIN "baserom.gb", $448FD, $448FE - $448FD

Logged_0x448FE:
	ld a,[$D70F]
	cp $00
	jr nz,Logged_0x4491B
	ld hl,$D129
	bit 0,[hl]
	ret nz
	ld a,$33
	call Logged_0x164B
	ld a,$01
	ld [$C5A0],a
	ld a,$01
	ld [$D26D],a
	ret

Logged_0x4491B:
	dec a
	ld [$D70F],a
	ld a,[$D713]
	ld [$D29F],a
	ld e,a
	ld a,[$D714]
	ld [$D2A0],a
	ld d,a
	ld hl,$FFE0
	add hl,de
	ld a,l
	ld [$D713],a
	ld a,h
	ld [$D714],a
	ld a,$01
	ld [$D2A1],a
	ld a,[$D711]
	ld [$D2A2],a
	ld a,[$D715]
	ld [$D2A3],a
	ld e,a
	ld a,[$D716]
	ld [$D2A4],a
	ld d,a
	ld a,[$D711]
	ld l,a
	ld h,$00
	add hl,de
	ld a,l
	ld [$D715],a
	ld a,h
	ld [$D716],a
	ld de,$D29F
	call Logged_0x09A3
	ret

Logged_0x44968:
	ld a,[$FF00+$8A]
	and a
	jr nz,Logged_0x44972
	xor a
	ld [$D725],a
	ret

Logged_0x44972:
	ld a,[$FF00+$8B]
	and a
	jr nz,Logged_0x44982
	ld hl,$D725
	inc [hl]
	ld a,[hl]
	cp $1E
	ret c
	ld a,$17
	ld [hl],a

Logged_0x44982:
	ld a,[$C5C7]
	ld b,a
	ld a,[$FF00+$8B]
	bit 5,a
	jr nz,Logged_0x449A3
	bit 4,a
	jr nz,Logged_0x449AB
	bit 2,a
	jr nz,Unknown_0x4499D
	bit 1,a
	jr nz,Logged_0x449C4
	and $09
	jr nz,Logged_0x449BB
	ret

Unknown_0x4499D:
	ld a,[$D719]
	cp b
	jr z,Logged_0x449AB

Logged_0x449A3:
	ld a,[$D719]
	ld [$C5C7],a
	jr Logged_0x449B3

Logged_0x449AB:
	ld a,[$D71B]
	ld [$C5C7],a
	jr Logged_0x449B3

Logged_0x449B3:
	cp b
	ret z
	ld a,$10
	ld [$DC06],a
	ret

Logged_0x449BB:
	ld hl,$C5C7
	ld a,[$D71B]
	cp [hl]
	jr nz,Logged_0x44A1B

Logged_0x449C4:
	ld a,$40
	ld [$DC06],a
	ld d,$00
	ld e,$3F
	sla e
	rl d
	sla e
	rl d
	ld hl,$5757
	add hl,de
	ld de,$9A20
	ld a,e
	ld [$D713],a
	ld a,d
	ld [$D714],a
	ld de,$D2A5
	ld a,e
	ld [$D715],a
	ld a,d
	ld [$D716],a
	call Logged_0x37AC
	ld a,b
	ld [$D70F],a
	ld a,c
	ld [$D711],a
	call Logged_0x44B14
	call Logged_0x44B4C
	ld a,$1C
	call Logged_0x164B
	ld a,[$D129]
	or $01
	ld [$D129],a
	ld a,$D0
	ld [$C5C3],a
	ld [$C583],a
	ld a,$03
	ld [$D26D],a
	ret

Logged_0x44A1B:
	ld a,[$D70B]
	rst JumpList

UnknownData_0x44A1F:
INCBIN "baserom.gb", $44A1F, $44A23 - $44A1F

LoggedData_0x44A23:
INCBIN "baserom.gb", $44A23, $44A27 - $44A23

UnknownData_0x44A27:
INCBIN "baserom.gb", $44A27, $44A29 - $44A27

LoggedData_0x44A29:
INCBIN "baserom.gb", $44A29, $44A2D - $44A29
	ld a,[$DC06]
	set 5,a
	ld [$DC06],a
	ld hl,$CE56
	dec [hl]
	call Logged_0x32B5
	jp Logged_0x44ADF
	ld a,[$DC06]
	set 5,a
	ld [$DC06],a
	ld hl,$CE57
	dec [hl]
	call Logged_0x329D
	jp Logged_0x44ADF
	ld a,[$DC06]
	set 5,a
	ld [$DC06],a
	ld bc,$0218
	call Logged_0x0AE5
	ld a,$00
	ld [$D12E],a
	ld a,$00
	ld [$D26D],a
	ld a,[$D12B]
	res 0,a
	ld [$D12B],a
	ld hl,$D245
	set 0,[hl]
	call Logged_0x37CD
	jr nc,Logged_0x44A7E
	call Logged_0x37B7

Logged_0x44A7E:
	xor a
	ld [$DC0F],a
	ld a,$00
	ld [$C157],a
	ld a,$00
	ld [$FF00+$91],a
	ret
	ld a,[$DC06]
	set 5,a
	ld [$DC06],a
	ld bc,$0218
	call Logged_0x0AE5
	ld a,$00
	ld [$D26D],a
	ld a,$00
	ld [$D12E],a
	ld hl,$D245
	set 0,[hl]
	ld a,$00
	ld [$C157],a
	ld a,[$D12B]
	res 0,a
	ld [$D12B],a
	xor a
	ld [$DC0F],a
	ld a,[$C9E4]
	ld c,a
	ld a,[$CC41]
	inc c

Logged_0x44AC2:
	srl a
	dec c
	jr nz,Logged_0x44AC2
	jr c,Logged_0x44AD2
	xor a
	ld [$C154],a
	ld a,$16
	ld [$FF00+$91],a
	ret

Logged_0x44AD2:
	ld a,$15
	ld [$FF00+$91],a
	ld a,$00
	ld [$D22E],a
	ld [$D12E],a
	ret

Logged_0x44ADF:
	call Logged_0x45158
	ld a,$00
	ld [$D12E],a
	ld a,$00
	ld [$D26D],a
	ld a,[$DC06]
	set 0,a
	ld [$DC06],a
	ld a,[$D12B]
	res 0,a
	ld [$D12B],a
	xor a
	ld [$C580],a
	ld [$C5A0],a
	ld [$C5C0],a
	call Logged_0x2570
	ld a,$00
	ld [$C157],a
	ld a,[$C155]
	ld [$FF00+$91],a
	ret

Logged_0x44B14:
	ld de,$CE54
	ld bc,$4B44
	ld l,$04

Logged_0x44B1C:
	ld a,[de]
	bit 0,a
	jr nz,Logged_0x44B3D
	push hl
	ld a,[bc]
	ld l,a
	inc bc
	ld a,[bc]
	ld h,a
	dec bc
	ld a,$A2
	ld [hli],a
	ld a,$A3
	ld [hl],a
	ld a,l
	sub $15
	ld l,a
	ld a,h
	sbc a,$00
	ld h,a
	ld a,$B2
	ld [hli],a
	ld a,$B3
	ld [hl],a
	pop hl

Logged_0x44B3D:
	inc de
	inc bc
	inc bc
	dec l
	jr nz,Logged_0x44B1C
	ret

UnknownData_0x44B44:
INCBIN "baserom.gb", $44B44, $44B46 - $44B44

LoggedData_0x44B46:
INCBIN "baserom.gb", $44B46, $44B4C - $44B46

Logged_0x44B4C:
	ld a,[$CE53]
	bit 6,a
	jr z,Logged_0x44B63
	ld hl,$D362
	ld a,$80
	ld [hli],a
	inc a
	ld [hl],a
	ld hl,$D34E
	ld a,$90
	ld [hli],a
	inc a
	ld [hl],a

Logged_0x44B63:
	ld a,[$CE66]
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld hl,$C150
	ld de,$D34A
	ld c,$00
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	ld a,[$CE5C]
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld hl,$C151
	ld de,$D352
	ld c,$00
	call Logged_0x3AA0
	ld a,[$CE5B]
	ld l,a
	ld h,$00
	call Logged_0x14EB
	ld hl,$C150
	ld de,$D354
	ld c,$00
	call Logged_0x3AA0
	inc hl
	call Logged_0x3AA0
	ret

Logged_0x44BA8:
	call Logged_0x37E0
	call Logged_0x451D1
	call Logged_0x45196
	call Logged_0x2958
	ld a,[$D701]
	bit 2,a
	jr z,Logged_0x44BC0
	call Unknown_0x0BBA
	jr Logged_0x44BC3

Logged_0x44BC0:
	call Logged_0x0B60

Logged_0x44BC3:
	ld a,[$D26E]
	rst JumpList
	dw Logged_0x44BD1
	dw Logged_0x44CFA
	dw Logged_0x44D19
	dw Logged_0x44D34
	dw Logged_0x44D62

Logged_0x44BD1:
	ld bc,$0201
	call Logged_0x0AE5
	call Logged_0x05CC
	call Logged_0x1384
	ld a,$01
	ld [$D12E],a
	ld a,$01
	ld [$C157],a
	ld a,$E3
	ld [$C0A7],a
	xor a
	ld [$C0DE],a
	ld [$FF00+$42],a
	ld [$C0DF],a
	ld [$FF00+$43],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld hl,$9800
	ld bc,$0800
	ld a,$03
	call Logged_0x0914
	call Logged_0x45747
	ld a,[$C9E4]
	cp $07
	jr z,Logged_0x44C5C
	cp $00
	jr z,Logged_0x44C5C
	ld a,[$C9E4]
	add a,$10
	call Logged_0x0A96
	ld a,[$C9E4]
	add a,$08
	ld e,a
	ld d,$00
	ld hl,$9800
	call Logged_0x37A1
	ld a,[$CC40]
	ld e,$00

Logged_0x44C33:
	srl a
	jr nc,Logged_0x44C38
	inc e

Logged_0x44C38:
	cp $00
	jr nz,Logged_0x44C33
	ld a,e
	dec a
	push af
	push af
	add a,$2D
	call Logged_0x0A96
	pop af
	add a,$28
	ld e,a
	ld d,$00
	ld hl,$C200
	call Logged_0x3795
	pop af
	add a,$05
	ld e,a
	ld d,$00
	call Logged_0x4514A
	jr Logged_0x44C8B

Logged_0x44C5C:
	ld a,[$C9E4]
	add a,$10
	call Logged_0x0A96
	ld a,[$C9E4]
	add a,$08
	ld e,a
	ld d,$00
	ld hl,$9800
	call Logged_0x37A1
	ld a,[$C9E4]
	add a,$28
	ld e,a
	ld d,$00
	ld hl,$C200
	call Logged_0x3795
	ld a,[$C9E4]
	add a,$05
	ld e,a
	ld d,$00
	call Logged_0x4514A

Logged_0x44C8B:
	ld a,$01
	ld [$D701],a
	xor a
	ld [$D702],a
	xor a
	ld [$C128],a
	ld a,$03
	ld [$C129],a
	ld a,$01
	ld [$C156],a
	ld hl,$4CEE
	ld de,$C12A
	ld c,$0C

Logged_0x44CAA:
	ld a,[hli]
	ld [de],a
	inc de
	dec c
	jr nz,Logged_0x44CAA
	ld a,[$C9E4]
	add a,$40
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	xor a
	ld [$FF00+$45],a
	ld a,[$C0A6]
	set 1,a
	ld [$C0A6],a
	call Logged_0x060E
	ld a,[$C9E4]
	cp $07
	jr z,Logged_0x44CDE
	ld a,$01
	ld [$D243],a
	ld a,$08
	ld [$D244],a
	jr Logged_0x44CE8

Logged_0x44CDE:
	ld a,$02
	ld [$D243],a
	ld a,$01
	ld [$D244],a

Logged_0x44CE8:
	ld a,$01
	ld [$D26E],a
	ret

LoggedData_0x44CEE:
INCBIN "baserom.gb", $44CEE, $44CFA - $44CEE

Logged_0x44CFA:
	ld a,$E4
	ld [$FF00+$47],a
	ld a,$1E
	ld [$FF00+$48],a
	ld a,$E3
	ld [$FF00+$49],a
	ld a,[$C9E4]
	cp $07
	jr z,Logged_0x44D13
	ld a,$02
	ld [$D26E],a
	ret

Logged_0x44D13:
	ld a,$04
	ld [$D26E],a
	ret

Logged_0x44D19:
	ld a,[$FF00+$8B]
	and $08
	ret z
	ld d,$00
	ld e,$20
	call Logged_0x4514A
	ld a,$01
	ld [$D701],a
	xor a
	ld [$D704],a
	ld a,$03
	ld [$D26E],a
	ret

Logged_0x44D34:
	ld a,[$D704]
	and a
	ret z
	call Logged_0x45158
	xor a
	ld [$D12E],a
	ld bc,$0201
	call Logged_0x0AE5
	ld a,$15
	ld [$FF00+$91],a
	ld a,$03
	call Logged_0x1629
	ld a,$0B
	call Logged_0x1629
	ld a,[$FF00+$FF]
	res 1,a
	ld [$FF00+$FF],a
	xor a
	ld [$C156],a
	ld [$D26E],a
	ret

Logged_0x44D62:
	ld hl,$D6E1
	ld a,[hl]
	inc hl
	or [hl]
	ret nz
	call Logged_0x45158
	xor a
	ld [$D12E],a
	ld bc,$0201
	call Logged_0x0AE5
	ld a,[$FF00+$FF]
	res 1,a
	ld [$FF00+$FF],a
	xor a
	ld [$C157],a
	xor a
	ld [$C156],a
	ld [$D26E],a
	ld [$FF00+$91],a
	ld a,$0E
	ld [$FF00+$90],a
	ret

Logged_0x44D8E:
	call Logged_0x37C2
	jr nc,Logged_0x44D94
	ret

Logged_0x44D94:
	call Logged_0x451D1
	call Logged_0x2958
	call Logged_0x0B60
	ld a,[$D26D]
	rst JumpList
	dw Logged_0x44DA7
	dw Logged_0x44E3F
	dw Logged_0x44E60

Logged_0x44DA7:
	ld hl,$D12A
	set 6,[hl]
	call Logged_0x05CC
	call Logged_0x1384
	ld a,$01
	ld [$D12E],a
	ld a,$01
	ld [$C157],a
	xor a
	ld [$FF00+$42],a
	ld [$FF00+$43],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld a,$E4
	ld [$FF00+$47],a
	ld a,$00
	ld [$FF00+$48],a
	ld a,$E0
	ld [$FF00+$49],a
	ld a,$02
	call Logged_0x0A96
	ld hl,$C200
	ld bc,$0400
	xor a
	call Logged_0x0914
	ld hl,$9800
	ld bc,$0800
	xor a
	call Logged_0x0914
	ld hl,$9800
	ld de,$0000
	call Logged_0x37A1
	ld hl,$C200
	ld de,$0000
	call Logged_0x3795
	ld de,$0000
	call Logged_0x4514A
	ld a,$0B
	call Logged_0x1629
	ld a,$03
	call Logged_0x1629
	ld a,$30
	call Logged_0x1629
	ld a,$30
	call Logged_0x3262
	call Logged_0x060E
	ld hl,$D12A
	res 6,[hl]
	ld a,$01
	ld [$D243],a
	ld a,$01
	ld [$D244],a
	ld a,$01
	ld [$D26D],a
	ld a,$01
	ld [$D707],a
	ld a,$00
	ld hl,$D708
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ret

Logged_0x44E3F:
	ld a,[$FF00+$8B]
	bit 3,a
	ret z
	call Logged_0x45158
	ld hl,$C203
	ld a,$74
	ld [hl],a
	ld a,[$DC06]
	set 5,a
	ld [$DC06],a
	ld hl,$D70B
	ld a,$30
	ld [hl],a
	ld a,$02
	ld [$D26D],a

Logged_0x44E60:
	ld a,$E0
	ld hl,$D70B
	bit 2,[hl]
	jr z,Logged_0x44E6B
	ld a,$2F

Logged_0x44E6B:
	ld [$FF00+$49],a
	dec [hl]
	ret nz
	ld bc,$0001
	call Logged_0x0AE5
	xor a
	ld [$D12E],a
	ld [$D26D],a
	jp Logged_0x1324

Logged_0x44E7F:
	call Logged_0x451D1
	call Logged_0x2958
	ld a,[$D26D]
	rst JumpList
	dw Logged_0x44E8D
	dw Logged_0x44EFB

Logged_0x44E8D:
	call Logged_0x05CC
	call Logged_0x1384
	ld a,$01
	ld [$D12E],a
	ld a,$01
	ld [$C157],a
	ld a,$E3
	ld [$C0A7],a
	xor a
	ld [$FF00+$42],a
	ld [$FF00+$43],a
	ld [$C0DF],a
	ld [$C0DE],a
	ld a,$90
	ld [$FF00+$4A],a
	ld a,$07
	ld [$FF00+$4B],a
	ld a,$1E
	ld [$FF00+$47],a
	ld [$FF00+$48],a
	ld [$FF00+$49],a
	ld a,$0D
	call Logged_0x0A96
	ld hl,$C580
	ld de,$0021
	call Logged_0x3795
	call Logged_0x37CD
	jr c,Logged_0x44ED5
	ld de,$0005
	jr Logged_0x44ED8

Logged_0x44ED5:
	ld de,$0004

Logged_0x44ED8:
	ld hl,$9800
	call Logged_0x37A1
	ld de,$000D
	call Logged_0x4514A
	xor a
	ld [$D70B],a
	ld a,$31
	call Logged_0x1629
	ld a,$31
	call Logged_0x3262
	call Logged_0x060E
	ld a,$01
	ld [$D26D],a
	ret

Logged_0x44EFB:
	ld a,[$D70B]
	and a
	ret z
	call Logged_0x45158
	xor a
	ld [$D26D],a
	ld bc,$0201
	call Logged_0x0AE5
	xor a
	ld [$C580],a
	ld [$C5A0],a
	ld [$C5C0],a
	ld a,[$D70B]
	cp $01
	jr nz,Logged_0x44F39
	xor a
	ld [$D12E],a
	call Logged_0x37CD
	jr nc,Unknown_0x44F30
	xor a
	ld [$C157],a
	ld a,$18
	ld [$FF00+$91],a
	ret

Unknown_0x44F30:
	xor a
	ld [$C157],a
	ld a,$16
	ld [$FF00+$91],a
	ret

Logged_0x44F39:
	xor a
	ld [$D12E],a
	ld [$C157],a
	jp Logged_0x37DA

UnknownData_0x44F43:
INCBIN "baserom.gb", $44F43, $4514A - $44F43

Logged_0x4514A:
	sla e
	rl d
	call Logged_0x45158
	call Logged_0x4517B
	call Logged_0x451D1
	ret

Logged_0x45158:
	xor a
	ld hl,$D6D1
	ld b,$20

Logged_0x4515E:
	ld [hli],a
	dec b
	jr nz,Logged_0x4515E
	ld hl,$D6A9
	ld b,$08

Logged_0x45167:
	ld [hli],a
	dec b
	jr nz,Logged_0x45167
	ld [$D705],a
	ld [$D704],a
	ld [$D703],a
	ld [$D702],a
	ld [$D701],a
	ret

Logged_0x4517B:
	ld a,d
	ld d,$00
	ld hl,$6336
	add hl,de
	ld c,l
	ld b,h
	ld e,a
	ld hl,$D6D1
	add hl,de
	xor a
	ld [hli],a
	ld [hld],a
	ld de,$0010
	add hl,de
	ld a,[bc]
	ld [hli],a
	inc bc
	ld a,[bc]
	ld [hl],a
	ret

Logged_0x45196:
	ld a,[$D701]
	bit 1,a
	ret nz
	ld de,$C200
	ld c,$20

Logged_0x451A1:
	push de
	ld hl,$001D
	add hl,de
	push hl
	push de
	ld hl,$001F
	add hl,de
	push hl
	ld hl,$0006
	add hl,de
	pop de
	ld a,[de]
	add a,[hl]
	ld [hld],a
	dec de
	ld a,[de]
	adc a,[hl]
	ld [hl],a
	pop de
	ld hl,$000A
	add hl,de
	pop de
	ld a,[de]
	add a,[hl]
	ld [hld],a
	dec de
	ld a,[de]
	adc a,[hl]
	ld [hl],a
	pop de
	ld hl,$0020
	add hl,de
	ld e,l
	ld d,h
	dec c
	jr nz,Logged_0x451A1
	ret

Logged_0x451D1:
	ld a,[$C0FE]
	or a
	jr z,Logged_0x45205
	ld a,[$FF00+$95]
	ld b,a
	ld a,[$FF00+$93]
	or b
	ld [$D72E],a
	ld a,[$FF00+$96]
	ld b,a
	ld a,[$FF00+$94]
	or b
	ld [$D72D],a
	jr Unknown_0x451F5

UnknownData_0x451EB:
INCBIN "baserom.gb", $451EB, $451F5 - $451EB

Unknown_0x451F5:
	bit 3,a
	jr z,Logged_0x45205
	ld a,[$D701]
	bit 0,a
	jr nz,Logged_0x45205
	ld a,$FF
	ld [$D702],a

Logged_0x45205:
	ld a,[$D129]
	and $01
	ld [$D29B],a
	ld hl,$D6D1
	ld c,$08

Logged_0x45212:
	ld a,[$D702]
	or a
	jr nz,Logged_0x45227
	ld a,[hli]
	sub $01
	ld b,a
	ld a,[hld]
	sbc a,$00
	jr c,Logged_0x45227
	inc hl
	ld [hld],a
	ld a,b
	ld [hl],a
	jr Logged_0x4523C

Logged_0x45227:
	ld a,c
	cp $01
	jr z,Logged_0x45239
	ld a,[$C0FE]
	or a
	jr z,Logged_0x45239
	ld a,[$D129]
	bit 0,a
	jr nz,Logged_0x4523C

Logged_0x45239:
	call Logged_0x45242

Logged_0x4523C:
	inc hl
	inc hl
	dec c
	jr nz,Logged_0x45212
	ret

Logged_0x45242:
	push hl
	push bc
	push hl
	ld bc,$0010
	add hl,bc
	ld a,[hli]
	ld c,a
	ld a,[hld]
	ld h,a
	ld l,c
	or l
	jr nz,Logged_0x45255
	pop hl

Logged_0x45252:
	pop bc
	pop hl
	ret

Logged_0x45255:
	ld a,[hli]
	push hl
	rst JumpList
	dw Logged_0x452B8
	dw Logged_0x452CB
	dw Logged_0x452DE
	dw Logged_0x452E7
	dw Logged_0x452F0
	dw Logged_0x452FC
	dw Logged_0x45337
	dw Logged_0x4530D
	dw Logged_0x4535F
	dw Logged_0x45387
	dw Logged_0x45397
	dw Unknown_0x453A7
	dw Unknown_0x453BB
	dw Unknown_0x453DE
	dw Logged_0x453EE
	dw Unknown_0x453FE
	dw Unknown_0x4540E
	dw Logged_0x4541D
	dw Logged_0x45429
	dw Unknown_0x45435
	dw Logged_0x45441
	dw Unknown_0x4544D
	dw Unknown_0x45464
	dw Unknown_0x45473
	dw Logged_0x454A5
	dw Unknown_0x454B1
	dw Unknown_0x454D8
	dw Unknown_0x454EC
	dw Unknown_0x454FD
	dw Unknown_0x4550E
	dw Unknown_0x4551E
	dw Unknown_0x4552B
	dw Unknown_0x45538
	dw Unknown_0x45545
	dw Unknown_0x45552
	dw Unknown_0x45563
	dw Logged_0x455E2
	dw Logged_0x455EE
	dw Unknown_0x455FE
	dw Logged_0x45612
	dw Unknown_0x45629
	dw Logged_0x45689
	dw Logged_0x4569F
	dw Logged_0x456AE
	dw Logged_0x456B7
	dw Logged_0x456C6
	dw Logged_0x456D7
	dw Logged_0x456E6

Logged_0x452B8:
	pop de
	pop hl
	ld bc,$0010
	add hl,bc
	xor a
	ld [hli],a
	ld [hl],a
	ld a,[$D704]
	dec a
	ld [$D704],a
	jp Logged_0x45252

Logged_0x452CB:
	pop de
	pop hl
	ld a,[de]
	ld [hli],a
	inc de
	ld a,[de]
	ld [hld],a
	inc de
	ld bc,$0010
	add hl,bc
	ld a,e
	ld [hli],a
	ld a,d
	ld [hl],a
	jp Logged_0x45252

Logged_0x452DE:
	pop hl
	ld a,[hli]
	ld c,a
	ld a,[hl]
	ld l,c
	ld h,a
	jp Logged_0x45255

Logged_0x452E7:
	pop hl
	call Logged_0x456F8
	ld a,[hli]
	ld [bc],a
	jp Logged_0x45255

Logged_0x452F0:
	pop hl
	call Logged_0x456F8
	ld a,[hli]
	ld [bc],a
	inc bc
	ld a,[hli]
	ld [bc],a
	jp Logged_0x45255

Logged_0x452FC:
	pop hl
	call Logged_0x456F8
	call Logged_0x456FD
	push hl
	ld l,c
	ld h,b
	call Logged_0x3795
	pop hl
	jp Logged_0x45255

Logged_0x4530D:
	pop hl
	ld a,[$D29B]
	bit 1,a
	jr nz,Logged_0x45334
	ld bc,$D2A5
	ld a,c
	ld [$D72B],a
	ld a,b
	ld [$D72C],a
	ld a,[$D29B]
	or $02
	ld [$D29B],a
	xor a
	ld [$D29C],a
	ld a,[$D129]
	or $01
	ld [$D129],a

Logged_0x45334:
	jp Logged_0x45255

Logged_0x45337:
	pop hl
	call Logged_0x456F8
	call Logged_0x456FD
	push hl
	ld l,c
	ld h,b
	ld a,[$D72B]
	ld c,a
	ld a,[$D72C]
	ld b,a
	call Logged_0x45702
	ld a,c
	ld [$D72B],a
	ld a,b
	ld [$D72C],a
	ld a,[$D29C]
	inc a
	ld [$D29C],a
	pop hl
	jp Logged_0x45255

Logged_0x4535F:
	pop hl
	call Logged_0x456F8
	call Logged_0x456FD
	push hl
	ld hl,$0001
	add hl,bc
	ld a,e
	ld [hli],a
	ld a,d
	ld [hli],a
	ld bc,$0009
	add hl,bc
	inc hl
	push hl
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	inc hl
	ld a,$FF
	ld [hli],a
	pop hl
	ld c,$00
	call Logged_0x31C3
	pop hl
	jp Logged_0x45255

Logged_0x45387:
	pop hl
	ld a,[hli]
	ld b,a
	ld a,[hli]
	ld c,a
	ld a,[hli]
	push hl
	ld h,a
	ld l,c
	ld a,[hl]
	add a,b
	ld [hl],a
	pop hl
	jp Logged_0x45255

Logged_0x45397:
	pop hl
	ld a,[hli]
	ld b,a
	ld a,[hli]
	ld c,a
	ld a,[hli]
	push hl
	ld h,a
	ld l,c
	ld a,[hl]
	sub b
	ld [hl],a
	pop hl
	jp Logged_0x45255

Unknown_0x453A7:
	pop hl
	call Logged_0x456F8
	call Logged_0x456FD
	push hl
	ld h,d
	ld l,e
	ld a,[hl]
	add a,c
	ld [hli],a
	ld a,[hl]
	adc a,b
	ld [hl],a
	pop hl
	jp Logged_0x45255

Unknown_0x453BB:
	pop hl
	call Logged_0x456F8
	call Logged_0x456FD
	push hl
	ld h,d
	ld l,e
	ld a,[hl]
	sub c
	ld [hli],a
	ld a,[hl]
	sbc a,b
	ld [hl],a
	pop hl
	jp Logged_0x45255

Logged_0x453CF:
	inc hl
	ld a,[hli]
	ld c,a
	ld a,[hl]
	ld l,c
	ld h,a
	jp Logged_0x45255

Logged_0x453D8:
	inc hl
	inc hl
	inc hl
	jp Logged_0x45255

Unknown_0x453DE:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	cp [hl]
	inc hl
	inc bc
	jr nz,Logged_0x453D8
	ld a,[bc]
	cp [hl]
	jr nz,Logged_0x453D8
	jr Logged_0x453CF

Logged_0x453EE:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	cp [hl]
	inc hl
	inc bc
	jr nz,Logged_0x453CF
	ld a,[bc]
	cp [hl]
	jr nz,Logged_0x453CF
	jr Logged_0x453D8

Unknown_0x453FE:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	scf
	sbc a,[hl]
	inc hl
	inc bc
	ld a,[bc]
	sbc a,[hl]
	jr c,Logged_0x453D8
	jp Logged_0x453CF

Unknown_0x4540E:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	sub [hl]
	inc hl
	inc bc
	ld a,[bc]
	sbc a,[hl]
	jr c,Logged_0x453CF
	jp Logged_0x453D8

Logged_0x4541D:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	cp [hl]
	jp nz,Logged_0x453D8
	jp Logged_0x453CF

Logged_0x45429:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	cp [hl]
	jp nz,Logged_0x453CF
	jp Logged_0x453D8

Unknown_0x45435:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	scf
	sbc a,[hl]
	jr c,Logged_0x453D8
	jp Logged_0x453CF

Logged_0x45441:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	sub [hl]
	jp c,Logged_0x453CF
	jp Logged_0x453D8

Unknown_0x4544D:
	pop hl
	call Logged_0x456F8
	ld a,[hli]
	ld e,a
	ld a,[hli]
	push hl
	ld h,a
	ld l,e
	inc hl
	call Logged_0x1334
	ld a,l
	ld [bc],a
	inc bc
	ld a,h
	ld [bc],a
	pop hl
	jp Logged_0x453D8

Unknown_0x45464:
	pop hl
	call Logged_0x456F8
	ld a,[hli]
	inc a
	push hl
	call Logged_0x1331
	ld [bc],a
	pop hl
	jp Logged_0x453D8

Unknown_0x45473:
	pop hl
	call Logged_0x456F8
	ld a,[bc]
	ld e,a
	inc bc
	ld a,[bc]
	ld d,a
	call Logged_0x456F8
	push hl
	ld l,e
	ld h,d
	ld a,[bc]
	ld e,a
	inc bc
	ld a,[bc]
	ld d,a
	ld a,[$D72B]
	ld c,a
	ld a,[$D72C]
	ld b,a
	call Logged_0x45702
	ld a,c
	ld [$D72B],a
	ld a,b
	ld [$D72C],a
	ld a,[$D29C]
	inc a
	ld [$D29C],a
	pop hl
	jp Logged_0x45255

Logged_0x454A5:
	pop hl
	call Logged_0x456F8
	call Logged_0x456FD
	ld a,[de]
	ld [bc],a
	jp Logged_0x45255

Unknown_0x454B1:
	pop hl
	call Logged_0x456F8
	call Logged_0x456FD
	ld a,[de]
	ld [bc],a
	inc bc
	inc de
	ld a,[de]
	ld [bc],a
	jp Logged_0x45255

Unknown_0x454C1:
	call Logged_0x456F8
	call Logged_0x456FD
	ld h,d
	ld l,e
	ret

Unknown_0x454CA:
	pop hl
	inc hl
	inc hl
	inc hl
	jp Logged_0x453D8

Unknown_0x454D1:
	pop hl
	inc hl
	inc hl
	inc hl
	jp Logged_0x453CF

Unknown_0x454D8:
	pop hl
	push hl
	call Unknown_0x454C1
	ld a,[bc]
	cp [hl]
	inc hl
	inc bc
	jp nz,Unknown_0x454CA
	ld a,[bc]
	cp [hl]
	jp nz,Unknown_0x454CA
	jp Unknown_0x454D1

Unknown_0x454EC:
	pop hl
	push hl
	call Unknown_0x454C1
	ld a,[bc]
	cp [hl]
	inc hl
	inc bc
	jr nz,Unknown_0x454D1
	ld a,[bc]
	cp [hl]
	jr nz,Unknown_0x454D1
	jr Unknown_0x454CA

Unknown_0x454FD:
	pop hl
	push hl
	call Unknown_0x454C1
	ld a,[bc]
	scf
	sbc a,[hl]
	inc hl
	inc bc
	ld a,[bc]
	sbc a,[hl]
	jr c,Unknown_0x454CA
	jp Unknown_0x454D1

Unknown_0x4550E:
	pop hl
	push hl
	call Unknown_0x454C1
	ld a,[bc]
	sub [hl]
	inc hl
	inc bc
	ld a,[bc]
	sbc a,[hl]
	jr c,Unknown_0x454D1
	jp Unknown_0x454CA

Unknown_0x4551E:
	pop hl
	push hl
	call Unknown_0x454C1
	ld a,[bc]
	cp [hl]
	jp nz,Unknown_0x454CA
	jp Unknown_0x454D1

Unknown_0x4552B:
	pop hl
	push hl
	call Unknown_0x454C1
	ld a,[bc]
	cp [hl]
	jp nz,Unknown_0x454D1
	jp Unknown_0x454CA

Unknown_0x45538:
	pop hl
	push hl
	call Unknown_0x454C1
	ld a,[bc]
	scf
	sbc a,[hl]
	jr c,Unknown_0x454CA
	jp Unknown_0x454D1

Unknown_0x45545:
	pop hl
	push hl
	call Unknown_0x454C1
	ld a,[bc]
	sub [hl]
	jp c,Unknown_0x454D1
	jp Unknown_0x454CA

Unknown_0x45552:
	pop hl
	call Logged_0x456FD
	push hl
	ld a,[de]
	ld l,a
	inc de
	ld a,[de]
	ld h,a
	call Logged_0x14EB
	pop hl
	jp Logged_0x45255

Unknown_0x45563:
	pop hl
	ld a,[hli]
	ld [$D29F],a
	ld a,[hli]
	ld [$D2A0],a
	ld a,$02
	ld [$D2A1],a
	ld a,[hli]
	ld [$D2A2],a
	ld e,a
	ld d,$00
	push hl
	ld a,[$D72B]
	ld [$D2A3],a
	ld c,a
	ld a,[$D72C]
	ld [$D2A4],a
	ld b,a
	ld a,$52
	sub e
	ld l,a
	ld a,$C1
	sbc a,d
	ld h,a
	push hl
	push de

Unknown_0x45591:
	ld a,[hli]
	push hl
	add a,$CE
	ld l,a
	ld a,$55
	adc a,$00
	ld h,a
	ld a,[hl]
	ld [bc],a
	pop hl
	inc bc
	dec e
	jr nz,Unknown_0x45591
	pop de
	pop hl

Unknown_0x455A4:
	ld a,[hli]
	push hl
	add a,$D8
	ld l,a
	ld a,$55
	adc a,$00
	ld h,a
	ld a,[hl]
	ld [bc],a
	pop hl
	inc bc
	dec e
	jr nz,Unknown_0x455A4
	ld a,c
	ld [$D72B],a
	ld a,b
	ld [$D72C],a
	ld a,[$D29C]
	inc a
	ld [$D29C],a
	ld de,$D29F
	call Logged_0x09A3
	pop hl
	jp Logged_0x45255

UnknownData_0x455CE:
INCBIN "baserom.gb", $455CE, $455E2 - $455CE

Logged_0x455E2:
	pop hl
	call Logged_0x456FD
	push hl
	call Logged_0x4517B
	pop hl
	jp Logged_0x45255

Logged_0x455EE:
	pop hl
	ld a,[hli]
	ld b,a
	ld a,[hli]
	ld c,a
	ld a,[hli]
	push hl
	ld h,a
	ld l,c
	ld a,[hl]
	and b
	ld [hl],a
	pop hl
	jp Logged_0x45255

Unknown_0x455FE:
	pop hl
	call Logged_0x456FD
	call Logged_0x456F8
	push hl
	ld h,b
	ld l,c
	ld a,[hl]
	and e
	ld [hli],a
	ld a,[hl]
	and d
	ld [hl],a
	pop hl
	jp Logged_0x45255

Logged_0x45612:
	pop hl
	ld a,[hli]
	push hl
	ld e,a
	ld d,$00
	ld hl,$D6D1
	add hl,de
	xor a
	ld [hli],a
	ld [hld],a
	ld de,$0010
	add hl,de
	ld [hli],a
	ld [hld],a
	pop hl
	jp Logged_0x45255

Unknown_0x45629:
	pop hl
	ld a,[hli]
	ld [$D29F],a
	ld a,[hli]
	ld [$D2A0],a
	ld a,$01
	ld [$D2A1],a
	ld a,[hli]
	ld [$D2A2],a
	ld e,a
	ld d,$00
	push hl
	ld a,[$D72B]
	ld [$D2A3],a
	ld c,a
	ld a,[$D72C]
	ld [$D2A4],a
	ld b,a
	ld a,$52
	sub e
	ld l,a
	ld a,$C1
	sbc a,d
	ld h,a

Unknown_0x45655:
	ld a,[hli]
	push hl
	add a,$7F
	ld l,a
	ld a,$56
	adc a,$00
	ld h,a
	ld a,[hl]
	ld [bc],a
	pop hl
	inc bc
	dec e
	jr nz,Unknown_0x45655
	ld a,c
	ld [$D72B],a
	ld a,b
	ld [$D72C],a
	ld a,[$D29C]
	inc a
	ld [$D29C],a
	ld de,$D29F
	call Logged_0x09A3
	pop hl
	jp Logged_0x45255

UnknownData_0x4567F:
INCBIN "baserom.gb", $4567F, $45689 - $4567F

Logged_0x45689:
	pop hl
	pop de
	push de
	ld c,[hl]
	inc hl
	ld b,[hl]
	inc hl
	push bc
	push hl
	ld hl,$0020
	add hl,de
	pop de
	ld a,e
	ld [hli],a
	ld a,d
	ld [hl],a
	pop hl
	jp Logged_0x45255

Logged_0x4569F:
	pop hl
	pop de
	push de
	ld hl,$0020
	add hl,de
	ld a,[hli]
	ld c,a
	ld a,[hl]
	ld h,a
	ld l,c
	jp Logged_0x45255

Logged_0x456AE:
	ld a,$01
	ld [$D245],a
	pop hl
	jp Logged_0x45255

Logged_0x456B7:
	pop hl
	ld a,[hli]
	push hl
	push af
	call Logged_0x1629
	pop af
	call Logged_0x3262
	pop hl
	jp Logged_0x45255

Logged_0x456C6:
	pop hl
	ld bc,$D6A9
	ld d,$07

Logged_0x456CC:
	ld a,[hli]
	ld [bc],a
	inc bc
	dec d
	jr nz,Logged_0x456CC
	xor a
	ld [bc],a
	jp Logged_0x45255

Logged_0x456D7:
	pop hl
	ld bc,$D6A9
	ld d,$08

Logged_0x456DD:
	ld a,[hli]
	ld [bc],a
	inc bc
	dec d
	jr nz,Logged_0x456DD
	jp Logged_0x45255

Logged_0x456E6:
	pop de
	pop hl
	ld a,[de]
	ld [hli],a
	inc de
	xor a
	ld [hld],a
	ld bc,$0010
	add hl,bc
	ld a,e
	ld [hli],a
	ld a,d
	ld [hl],a
	jp Logged_0x45252

Logged_0x456F8:
	ld a,[hli]
	ld c,a
	ld a,[hli]
	ld b,a
	ret

Logged_0x456FD:
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ret

Logged_0x45702:
	push hl
	sla e
	rl d
	sla e
	rl d
	ld hl,$5757
	add hl,de
	pop de
	ld a,e
	ld [$D29F],a
	ld a,d
	ld [$D2A0],a
	ld a,[hli]
	ld [$D2A1],a
	ld a,[hli]
	ld [$D2A2],a
	ld a,c
	ld [$D2A3],a
	ld a,b
	ld [$D2A4],a
	push bc
	ld a,[hli]
	ld e,a
	ld a,[hli]
	ld d,a
	ld a,[de]
	ld c,a
	inc de
	ld a,[de]
	ld b,a
	inc de
	inc b
	pop hl

Logged_0x45735:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x45735
	dec b
	jr nz,Logged_0x45735
	push hl
	ld de,$D29F
	call Logged_0x09A3
	pop bc
	ret

Logged_0x45747:
	ld hl,$C200
	ld c,$20
	xor a

Logged_0x4574D:
	ld b,$20

Logged_0x4574F:
	ld [hli],a
	dec b
	jr nz,Logged_0x4574F
	dec c
	jr nz,Logged_0x4574D
	ret

UnknownData_0x45757:
INCBIN "baserom.gb", $45757, $45817 - $45757

LoggedData_0x45817:
INCBIN "baserom.gb", $45817, $4581F - $45817

UnknownData_0x4581F:
INCBIN "baserom.gb", $4581F, $45823 - $4581F

LoggedData_0x45823:
INCBIN "baserom.gb", $45823, $45827 - $45823

UnknownData_0x45827:
INCBIN "baserom.gb", $45827, $4582F - $45827

LoggedData_0x4582F:
INCBIN "baserom.gb", $4582F, $45837 - $4582F

UnknownData_0x45837:
INCBIN "baserom.gb", $45837, $45857 - $45837

LoggedData_0x45857:
INCBIN "baserom.gb", $45857, $45863 - $45857

UnknownData_0x45863:
INCBIN "baserom.gb", $45863, $45867 - $45863

LoggedData_0x45867:
INCBIN "baserom.gb", $45867, $45873 - $45867

UnknownData_0x45873:
INCBIN "baserom.gb", $45873, $45897 - $45873

LoggedData_0x45897:
INCBIN "baserom.gb", $45897, $458BB - $45897

UnknownData_0x458BB:
INCBIN "baserom.gb", $458BB, $45AC2 - $458BB

LoggedData_0x45AC2:
INCBIN "baserom.gb", $45AC2, $45EC4 - $45AC2

UnknownData_0x45EC4:
INCBIN "baserom.gb", $45EC4, $45F6B - $45EC4

LoggedData_0x45F6B:
INCBIN "baserom.gb", $45F6B, $4606B - $45F6B

UnknownData_0x4606B:
INCBIN "baserom.gb", $4606B, $460D0 - $4606B

LoggedData_0x460D0:
INCBIN "baserom.gb", $460D0, $46240 - $460D0

UnknownData_0x46240:
INCBIN "baserom.gb", $46240, $462D2 - $46240

LoggedData_0x462D2:
INCBIN "baserom.gb", $462D2, $46338 - $462D2

UnknownData_0x46338:
INCBIN "baserom.gb", $46338, $4633E - $46338

LoggedData_0x4633E:
INCBIN "baserom.gb", $4633E, $46352 - $4633E

UnknownData_0x46352:
INCBIN "baserom.gb", $46352, $46366 - $46352

LoggedData_0x46366:
INCBIN "baserom.gb", $46366, $463A4 - $46366

UnknownData_0x463A4:
INCBIN "baserom.gb", $463A4, $463AA - $463A4

LoggedData_0x463AA:
INCBIN "baserom.gb", $463AA, $463AC - $463AA

UnknownData_0x463AC:
INCBIN "baserom.gb", $463AC, $463B4 - $463AC

LoggedData_0x463B4:
INCBIN "baserom.gb", $463B4, $46B8C - $463B4

UnknownData_0x46B8C:
INCBIN "baserom.gb", $46B8C, $46B8E - $46B8C

LoggedData_0x46B8E:
INCBIN "baserom.gb", $46B8E, $46F38 - $46B8E

UnknownData_0x46F38:
INCBIN "baserom.gb", $46F38, $46F3B - $46F38

LoggedData_0x46F3B:
INCBIN "baserom.gb", $46F3B, $46F71 - $46F3B

UnknownData_0x46F71:
INCBIN "baserom.gb", $46F71, $46F74 - $46F71

LoggedData_0x46F74:
INCBIN "baserom.gb", $46F74, $46FAA - $46F74

UnknownData_0x46FAA:
INCBIN "baserom.gb", $46FAA, $46FAD - $46FAA

LoggedData_0x46FAD:
INCBIN "baserom.gb", $46FAD, $47004 - $46FAD

UnknownData_0x47004:
INCBIN "baserom.gb", $47004, $47007 - $47004

LoggedData_0x47007:
INCBIN "baserom.gb", $47007, $47046 - $47007

UnknownData_0x47046:
INCBIN "baserom.gb", $47046, $47049 - $47046

LoggedData_0x47049:
INCBIN "baserom.gb", $47049, $47089 - $47049

UnknownData_0x47089:
INCBIN "baserom.gb", $47089, $4708C - $47089

LoggedData_0x4708C:
INCBIN "baserom.gb", $4708C, $470C2 - $4708C

UnknownData_0x470C2:
INCBIN "baserom.gb", $470C2, $470C5 - $470C2

LoggedData_0x470C5:
INCBIN "baserom.gb", $470C5, $4784D - $470C5

UnknownData_0x4784D:
INCBIN "baserom.gb", $4784D, $4787A - $4784D

LoggedData_0x4787A:
INCBIN "baserom.gb", $4787A, $47889 - $4787A

UnknownData_0x47889:
INCBIN "baserom.gb", $47889, $47B42 - $47889

LoggedData_0x47B42:
INCBIN "baserom.gb", $47B42, $47B7F - $47B42

UnknownData_0x47B7F:
INCBIN "baserom.gb", $47B7F, $47B88 - $47B7F

LoggedData_0x47B88:
INCBIN "baserom.gb", $47B88, $47B9F - $47B88

UnknownData_0x47B9F:
INCBIN "baserom.gb", $47B9F, $47BA1 - $47B9F

LoggedData_0x47BA1:
INCBIN "baserom.gb", $47BA1, $47C13 - $47BA1

UnknownData_0x47C13:
INCBIN "baserom.gb", $47C13, $47D24 - $47C13

LoggedData_0x47D24:
INCBIN "baserom.gb", $47D24, $47D89 - $47D24

UnknownData_0x47D89:
INCBIN "baserom.gb", $47D89, $47D8C - $47D89

LoggedData_0x47D8C:
INCBIN "baserom.gb", $47D8C, $47D8D - $47D8C

UnknownData_0x47D8D:
INCBIN "baserom.gb", $47D8D, $47D90 - $47D8D

LoggedData_0x47D90:
INCBIN "baserom.gb", $47D90, $47D92 - $47D90

UnknownData_0x47D92:
INCBIN "baserom.gb", $47D92, $47D94 - $47D92

LoggedData_0x47D94:
INCBIN "baserom.gb", $47D94, $47D96 - $47D94

UnknownData_0x47D96:
INCBIN "baserom.gb", $47D96, $47D98 - $47D96

LoggedData_0x47D98:
INCBIN "baserom.gb", $47D98, $47D9A - $47D98

UnknownData_0x47D9A:
INCBIN "baserom.gb", $47D9A, $47D9C - $47D9A

LoggedData_0x47D9C:
INCBIN "baserom.gb", $47D9C, $47D9E - $47D9C

UnknownData_0x47D9E:
INCBIN "baserom.gb", $47D9E, $47DA0 - $47D9E

LoggedData_0x47DA0:
INCBIN "baserom.gb", $47DA0, $47DA2 - $47DA0

UnknownData_0x47DA2:
INCBIN "baserom.gb", $47DA2, $47DA4 - $47DA2

LoggedData_0x47DA4:
INCBIN "baserom.gb", $47DA4, $47DAA - $47DA4

UnknownData_0x47DAA:
INCBIN "baserom.gb", $47DAA, $47DAC - $47DAA

LoggedData_0x47DAC:
INCBIN "baserom.gb", $47DAC, $47DC7 - $47DAC

UnknownData_0x47DC7:
INCBIN "baserom.gb", $47DC7, $47DC8 - $47DC7

LoggedData_0x47DC8:
INCBIN "baserom.gb", $47DC8, $47DCD - $47DC8

UnknownData_0x47DCD:
INCBIN "baserom.gb", $47DCD, $47DD0 - $47DCD

LoggedData_0x47DD0:
INCBIN "baserom.gb", $47DD0, $47DD1 - $47DD0

UnknownData_0x47DD1:
INCBIN "baserom.gb", $47DD1, $47DD4 - $47DD1

LoggedData_0x47DD4:
INCBIN "baserom.gb", $47DD4, $47DD5 - $47DD4

UnknownData_0x47DD5:
INCBIN "baserom.gb", $47DD5, $47DD8 - $47DD5

LoggedData_0x47DD8:
INCBIN "baserom.gb", $47DD8, $47DDA - $47DD8

UnknownData_0x47DDA:
INCBIN "baserom.gb", $47DDA, $47DDC - $47DDA

LoggedData_0x47DDC:
INCBIN "baserom.gb", $47DDC, $47DE6 - $47DDC

UnknownData_0x47DE6:
INCBIN "baserom.gb", $47DE6, $47DE8 - $47DE6

LoggedData_0x47DE8:
INCBIN "baserom.gb", $47DE8, $47DEA - $47DE8

UnknownData_0x47DEA:
INCBIN "baserom.gb", $47DEA, $47DEC - $47DEA

LoggedData_0x47DEC:
INCBIN "baserom.gb", $47DEC, $47DEE - $47DEC

UnknownData_0x47DEE:
INCBIN "baserom.gb", $47DEE, $47DF0 - $47DEE

LoggedData_0x47DF0:
INCBIN "baserom.gb", $47DF0, $47DF2 - $47DF0

UnknownData_0x47DF2:
INCBIN "baserom.gb", $47DF2, $47DF4 - $47DF2

LoggedData_0x47DF4:
INCBIN "baserom.gb", $47DF4, $47DF9 - $47DF4

UnknownData_0x47DF9:
INCBIN "baserom.gb", $47DF9, $47DFC - $47DF9

LoggedData_0x47DFC:
INCBIN "baserom.gb", $47DFC, $47E12 - $47DFC

UnknownData_0x47E12:
INCBIN "baserom.gb", $47E12, $47E14 - $47E12

LoggedData_0x47E14:
INCBIN "baserom.gb", $47E14, $47E16 - $47E14

UnknownData_0x47E16:
INCBIN "baserom.gb", $47E16, $47E18 - $47E16

LoggedData_0x47E18:
INCBIN "baserom.gb", $47E18, $47E1B - $47E18

UnknownData_0x47E1B:
INCBIN "baserom.gb", $47E1B, $47E1C - $47E1B

LoggedData_0x47E1C:
INCBIN "baserom.gb", $47E1C, $47E21 - $47E1C

UnknownData_0x47E21:
INCBIN "baserom.gb", $47E21, $47E24 - $47E21

LoggedData_0x47E24:
INCBIN "baserom.gb", $47E24, $47E25 - $47E24

UnknownData_0x47E25:
INCBIN "baserom.gb", $47E25, $47E28 - $47E25

LoggedData_0x47E28:
INCBIN "baserom.gb", $47E28, $47E29 - $47E28

UnknownData_0x47E29:
INCBIN "baserom.gb", $47E29, $47E2C - $47E29

LoggedData_0x47E2C:
INCBIN "baserom.gb", $47E2C, $47E3F - $47E2C

UnknownData_0x47E3F:
INCBIN "baserom.gb", $47E3F, $47E40 - $47E3F

LoggedData_0x47E40:
INCBIN "baserom.gb", $47E40, $47E47 - $47E40

UnknownData_0x47E47:
INCBIN "baserom.gb", $47E47, $47E48 - $47E47

LoggedData_0x47E48:
INCBIN "baserom.gb", $47E48, $47E67 - $47E48

UnknownData_0x47E67:
INCBIN "baserom.gb", $47E67, $47E68 - $47E67

LoggedData_0x47E68:
INCBIN "baserom.gb", $47E68, $47E6E - $47E68

UnknownData_0x47E6E:
INCBIN "baserom.gb", $47E6E, $47E70 - $47E6E

LoggedData_0x47E70:
INCBIN "baserom.gb", $47E70, $47E7A - $47E70

UnknownData_0x47E7A:
INCBIN "baserom.gb", $47E7A, $47E7C - $47E7A

LoggedData_0x47E7C:
INCBIN "baserom.gb", $47E7C, $47E81 - $47E7C

UnknownData_0x47E81:
INCBIN "baserom.gb", $47E81, $47E84 - $47E81

LoggedData_0x47E84:
INCBIN "baserom.gb", $47E84, $47E86 - $47E84

UnknownData_0x47E86:
INCBIN "baserom.gb", $47E86, $47E88 - $47E86

LoggedData_0x47E88:
INCBIN "baserom.gb", $47E88, $47E92 - $47E88

UnknownData_0x47E92:
INCBIN "baserom.gb", $47E92, $47E94 - $47E92

LoggedData_0x47E94:
INCBIN "baserom.gb", $47E94, $47E9F - $47E94

UnknownData_0x47E9F:
INCBIN "baserom.gb", $47E9F, $47EA0 - $47E9F

LoggedData_0x47EA0:
INCBIN "baserom.gb", $47EA0, $47EAA - $47EA0

UnknownData_0x47EAA:
INCBIN "baserom.gb", $47EAA, $47EAC - $47EAA

LoggedData_0x47EAC:
INCBIN "baserom.gb", $47EAC, $47EAF - $47EAC

UnknownData_0x47EAF:
INCBIN "baserom.gb", $47EAF, $47EB0 - $47EAF

LoggedData_0x47EB0:
INCBIN "baserom.gb", $47EB0, $47EB6 - $47EB0

UnknownData_0x47EB6:
INCBIN "baserom.gb", $47EB6, $47EB8 - $47EB6

LoggedData_0x47EB8:
INCBIN "baserom.gb", $47EB8, $47EBB - $47EB8

UnknownData_0x47EBB:
INCBIN "baserom.gb", $47EBB, $47EBC - $47EBB

LoggedData_0x47EBC:
INCBIN "baserom.gb", $47EBC, $47EC6 - $47EBC

UnknownData_0x47EC6:
INCBIN "baserom.gb", $47EC6, $47EC8 - $47EC6

LoggedData_0x47EC8:
INCBIN "baserom.gb", $47EC8, $47ECA - $47EC8

UnknownData_0x47ECA:
INCBIN "baserom.gb", $47ECA, $47ECC - $47ECA

LoggedData_0x47ECC:
INCBIN "baserom.gb", $47ECC, $47ECE - $47ECC

UnknownData_0x47ECE:
INCBIN "baserom.gb", $47ECE, $47ED0 - $47ECE

LoggedData_0x47ED0:
INCBIN "baserom.gb", $47ED0, $47EDA - $47ED0

UnknownData_0x47EDA:
INCBIN "baserom.gb", $47EDA, $47EDC - $47EDA

LoggedData_0x47EDC:
INCBIN "baserom.gb", $47EDC, $47F08 - $47EDC

UnknownData_0x47F08:
INCBIN "baserom.gb", $47F08, $47F0A - $47F08

Logged_0x47F0A:
	ld a,[$FF00+$8A]
	bit 2,a
	ret z
	ld a,[$D706]
	add a,$5B
	ld l,a
	ld a,$00
	adc a,$7F
	ld h,a
	ld a,[$FF00+$8B]
	and $FB
	ret z
	cp [hl]
	jr nz,Unknown_0x47F53
	ld a,[$D706]
	inc a
	ld [$D706],a
	inc hl
	ld a,[hl]
	cp $FF
	jr nz,Unknown_0x47F57
	ld a,$00
	ld [$DC06],a
	ld a,$10
	ld [$DC05],a
	ld a,[$CE53]
	or $0F
	ld [$CE53],a
	ld a,$01
	ld [$CE54],a
	ld [$CE55],a
	ld [$CE56],a
	ld [$CE57],a
	xor a
	ld [$D26D],a

Unknown_0x47F53:
	xor a
	ld [$D706],a

Unknown_0x47F57:
	xor a
	ld a,[$FF00+$8B]
	ret

UnknownData_0x47F5B:
INCBIN "baserom.gb", $47F5B, $48000 - $47F5B

SECTION "Bank12", ROMX, BANK[$12]

Logged_0x48000:
	ld hl,$4054
	ld b,[hl]
	inc hl
	ld c,[hl]
	inc hl
	push bc
	ld e,[hl]
	inc hl
	ld d,[hl]
	ld hl,$D3F9

Logged_0x4800E:
	push bc
	push hl

Logged_0x48010:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x48010
	pop hl
	ld bc,$FFEC
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x4800E
	pop bc
	ret

Logged_0x48021:
	push hl
	sla e
	rl d
	sla e
	rl d
	ld hl,$4048
	add hl,de
	ld b,[hl]
	inc hl
	ld c,[hl]
	inc hl
	ld e,[hl]
	inc hl
	ld d,[hl]
	pop hl

Logged_0x48036:
	push bc
	push hl

Logged_0x48038:
	ld a,[de]
	ld [hli],a
	inc de
	dec c
	jr nz,Logged_0x48038
	pop hl
	ld bc,$0020
	add hl,bc
	pop bc
	dec b
	jr nz,Logged_0x48036
	ret

LoggedData_0x48048:
INCBIN "baserom.gb", $48048, $4804C - $48048

UnknownData_0x4804C:
INCBIN "baserom.gb", $4804C, $48054 - $4804C

LoggedData_0x48054:
INCBIN "baserom.gb", $48054, $4805C - $48054

UnknownData_0x4805C:
INCBIN "baserom.gb", $4805C, $48060 - $4805C

LoggedData_0x48060:
INCBIN "baserom.gb", $48060, $48090 - $48060

UnknownData_0x48090:
INCBIN "baserom.gb", $48090, $480CC - $48090

LoggedData_0x480CC:
INCBIN "baserom.gb", $480CC, $480D4 - $480CC

UnknownData_0x480D4:
INCBIN "baserom.gb", $480D4, $480D8 - $480D4

LoggedData_0x480D8:
INCBIN "baserom.gb", $480D8, $48240 - $480D8

UnknownData_0x48240:
INCBIN "baserom.gb", $48240, $4859C - $48240

LoggedData_0x4859C:
INCBIN "baserom.gb", $4859C, $4886C - $4859C

UnknownData_0x4886C:
INCBIN "baserom.gb", $4886C, $489D4 - $4886C

LoggedData_0x489D4:
INCBIN "baserom.gb", $489D4, $4A180 - $489D4

UnknownData_0x4A180:
INCBIN "baserom.gb", $4A180, $4A5B8 - $4A180

LoggedData_0x4A5B8:
INCBIN "baserom.gb", $4A5B8, $4A906 - $4A5B8

Logged_0x4A906:
	push hl
	sla e
	rl d
	ld hl,$694A
	add hl,de
	ld e,[hl]
	inc hl
	ld d,[hl]
	pop hl
	ld a,[de]
	inc de

Logged_0x4A915:
	push af
	ld a,$01
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld a,$FF
	ld [hli],a
	ld a,[de]
	inc de
	ld [hli],a
	xor a
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld bc,$000E
	add hl,bc
	ld [hli],a
	ld [hli],a
	pop af
	dec a
	jr nz,Logged_0x4A915
	ld hl,$C20D
	ld c,$00
	call Logged_0x31C3
	ret

LoggedData_0x4A94A:
INCBIN "baserom.gb", $4A94A, $4A94C - $4A94A

UnknownData_0x4A94C:
INCBIN "baserom.gb", $4A94C, $4A952 - $4A94C

LoggedData_0x4A952:
INCBIN "baserom.gb", $4A952, $4A956 - $4A952

UnknownData_0x4A956:
INCBIN "baserom.gb", $4A956, $4A98A - $4A956

LoggedData_0x4A98A:
INCBIN "baserom.gb", $4A98A, $4A98E - $4A98A

UnknownData_0x4A98E:
INCBIN "baserom.gb", $4A98E, $4A992 - $4A98E

LoggedData_0x4A992:
INCBIN "baserom.gb", $4A992, $4A994 - $4A992

UnknownData_0x4A994:
INCBIN "baserom.gb", $4A994, $4A99A - $4A994

LoggedData_0x4A99A:
INCBIN "baserom.gb", $4A99A, $4A9AA - $4A99A

UnknownData_0x4A9AA:
INCBIN "baserom.gb", $4A9AA, $4A9B0 - $4A9AA

LoggedData_0x4A9B0:
INCBIN "baserom.gb", $4A9B0, $4A9B6 - $4A9B0

UnknownData_0x4A9B6:
INCBIN "baserom.gb", $4A9B6, $4AA99 - $4A9B6

LoggedData_0x4AA99:
INCBIN "baserom.gb", $4AA99, $4ABD2 - $4AA99

UnknownData_0x4ABD2:
INCBIN "baserom.gb", $4ABD2, $4C000 - $4ABD2

SECTION "Bank13", ROMX, BANK[$13]

LoggedData_0x4C000:
INCBIN "baserom.gb", $4C000, $4D260 - $4C000

UnknownData_0x4D260:
INCBIN "baserom.gb", $4D260, $4D2E0 - $4D260

LoggedData_0x4D2E0:
INCBIN "baserom.gb", $4D2E0, $4FA30 - $4D2E0

UnknownData_0x4FA30:
INCBIN "baserom.gb", $4FA30, $4FA70 - $4FA30

LoggedData_0x4FA70:
INCBIN "baserom.gb", $4FA70, $4FB40 - $4FA70

UnknownData_0x4FB40:


Logged_0x50000:
	rla
