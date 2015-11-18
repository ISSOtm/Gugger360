SECTION "rst $00", HOME[$00] ; 7 octets
callFarBank:: ; charge la banque a, saute à hl, et retourne à la banque c, à l'adresse [sp]
	push bc
	ld [bankSwitch], a
	jp [hl]
	pop af
	pop hl
	nop ; continue au instructions suivantes ; plus rapide !

SECTION "rst $08", HOME[$08] ; 4 octets :P
jumpFarBank:: ; charge la banque a, puis saute à hl
	ld [bankSwitch], a
	jp [hl]

SECTION "rst $10", HOME[$0D] ; 11 octets !
handleCunderflow::
	ret z
	dec b
	dec c
fillMemory:: ; ATTENTION ! Ne PAS tenter de "remplir" l'OAM avec cette routine !!
	inc b
fillBytes:: ; remplit bc octets à partir de [hl]
	ldi [hl], a
	dec c
	jr nz, fillBytes
	dec b
	jr handleCunderflow
	
SECTION "rst $18", HOME[$18]
waitFrames:: ; attend a frames
	halt
	dec a
	jp nz, waitFrames
	ret ; side effect : a = 0

SECTION "rst $20", HOME[$20]
rst20::
	ret

SECTION "rst $28", HOME[$28]
rst28::
	ret

SECTION "rst $30", HOME[$30]
rst30::
	ret

SECTION "rst $38", HOME[$38]
rst38::
	ret


; interrupt vectors
SECTION "vblank", HOME[$40]
	reti
SECTION "hblank", HOME[$48]
	reti
SECTION "timer",  HOME[$50]
	reti
SECTION "serial", HOME[$58]
	reti
SECTION "joypad", HOME[$60]
	reti