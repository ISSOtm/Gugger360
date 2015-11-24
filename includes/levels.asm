; un niveau prend 90 ($5A) octets
; les niveaux prennent l'aire de $4000 à $6CFF
SECTION "Levels", DATA, BANK[2]
; niveau 0
	db 12, 8
	db 14, 14
	db 22, 22
	db 30, 30
	db 38, 38
	db 46, 46
	db 54, 54
	db 62, 62
	db 70, 70
	db 78, 78
	db "ENTRAINEMENT" ; 12 chars
	ds 4 * 12
	db $09, $08, $07, $06, $05, $04, $03, $02, $01, $00

; niveau 1
	ds 20
	db "FACILE 1    " ; 12 chars
	ds 4 * 12
	db $09, $08, $07, $06, $05, $04, $03, $02, $01, $00

REPT $7E ; au total, $80 niveaux, càd 128
	ds 20
	db "ENTRAINEMENT"
	ds 4 * 12
	db $09, $08, $07, $06, $05, $04, $03, $02, $01, $00
ENDR

; Tile Maps liées aux niveaux
; Dans cette banque pour ne pas avoir à charger l'autre banque
levelSelectTileMap::
	db $74
REPT 14
	db $78
ENDR
	db $76
	ds $10
	db $79, $00
	db "SELECTIONNEZ"
	db $00, $7A
	ds $10
	db $79
	ds $0E
	db $7A
	ds $10
	db $79, $00, $00
	db "UN NIVEAU:"
	db $00, $00, $7A
levelSelectClearMap::
REPT 3
	ds $10
	db $79
	ds $0E
	db $7A
ENDR
	ds $10
	db $79
	ds $02
	db $7C
	ds $0B
	db $7A
	ds $10
	db $79
	db $0F
	ds $0D
	db $7A
	ds $10
	db $79
	ds $02
	db $7D
	ds $0B
	db $7A
REPT 2
	ds $10
	db $79
	ds $0E
	db $7A
ENDR
	ds $10
	db $75
REPT 14
	db $7B
ENDR
	db $77
levelSelectTileMapEnd::