INCLUDE "constants.asm"

; rst vectors
INCLUDE "restarts.asm"

; routines d'intérêt général
INCLUDE "utilitaries.asm"

; header de la cartouche.
INCLUDE "header.asm"


SECTION "Main", HOME[$150]
INCLUDE "intro.asm"

titleMenuCursor::
	call getKeys
	ld a, [NEWJOYP]
	swap a
	cp directionUp
	jr nc, afterTitleMenu
	and buttonStart + buttonSelect
	jr z, titleMenuCursor

switchTitleCursorPos::
	halt
	xor a
	ld [de], a
	or $40
	xor e
	ld e, a
	ld a, $0F
	ld [de], a
	jr titleMenuCursor

afterTitleMenu::
	ld hl, $9A63
	ld de, titleScreenBuf
	ld bc, $18A
	call copyToVRAM
	
	jr @


INCLUDE "graphics.asm"
INCLUDE "levels.asm"