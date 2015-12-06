; un niveau prend 90 ($5A) octets
; les niveaux prennent l'aire de $4000 à $6CFF
SECTION "Levels", DATA, BANK[2]
; niveau 0
	db 27, 31
	db 37, 46
	db 47, 61
	db 57, 76
	db 67, 91
	db 77, 106
	db 87, 121
	db 96, 136
	db 96, 137
	db 109, 137
	db "ENTRAINEMENT" ; 12 chars
	db $6D, $1B
	db 0, 1, $FF, 0, 0, 0, 0, 0, 0, 0
	db $5D, $1B
	db 2, 3, $FF, 0, 0, 0, 0, 0, 0, 0
	db $4D, $1B
	db 4, 5, $FF, 0, 0, 0, 0, 0, 0, 0
	db $3D, $1B
	db 6, 7, $FF, 0, 0, 0, 0, 0, 0, 0
	db 9, 8, 7, 6, 5, 4, 3, 2, 1, 0

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
	db "VOTRE OBJECTIF :"
	ds $70
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