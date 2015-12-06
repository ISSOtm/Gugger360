SECTION "Graphics", DATA, BANK[1]
unlicenseTileMap::
	ds 131 ; 155 tuiles $00
	db "CE JEU N'A PAS"
	ds 50
	db "ETE LICENCE PAR"
	ds 50
	db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $19
	ds 19
	db $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18

introTileMap::
	ds $E2 ; $E3 tuiles $00
	db "KAMOULOX  GAMING"
	ds $3F
introTileMap2::
	db "PRESENTE"
	ds $03

Tiles::
	dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
	dw $F000, $F000, $FC00, $FC00, $FC00, $FC00, $F300, $F300
	dw $3C00, $3C00, $3C00, $3C00, $3C00, $3C00, $3C00, $3C00
	dw $F000, $F000, $F000, $F000, $0000, $0000, $F300, $F300
	dw $0000, $0000, $0000, $0000, $0000, $0000, $CF00, $CF00
	dw $0000, $0000, $0F00, $0F00, $3F00, $3F00, $0F00, $0F00
	dw $0000, $0000, $0000, $0000, $C000, $C000, $0F00, $0F00
	dw $0000, $0000, $0000, $0000, $0000, $0000, $F000, $F000
	dw $0000, $0000, $0000, $0000, $0000, $0000, $F300, $F300
	dw $0000, $0000, $0000, $0000, $0000, $0000, $C000, $C000
	dw $0300, $0300, $0300, $0300, $0300, $0300, $FF00, $FF00
	dw $C000, $C000, $C000, $C000, $C000, $C000, $C300, $C300
	dw $0000, $0000, $0000, $0000, $0000, $0000, $FC00, $FC00
	dw $F300, $F300, $F000, $F000, $F000, $F000, $F000, $F000
	dw $3C00, $3C00, $FC00, $FC00, $FC00, $FC00, $3C00, $3C00
	dw $F300, $F300, $F300, $F300, $F300, $F300, $F300, $F300
	dw $F300, $F300, $C300, $C300, $C300, $C300, $C300, $C300
	dw $CF00, $CF00, $CF00, $CF00, $CF00, $CF00, $CF00, $CF00
	dw $3C00, $3C00, $3F00, $3F00, $3C00, $3C00, $0F00, $0F00
	dw $3C00, $3C00, $FC00, $FC00, $0000, $0000, $FC00, $FC00
	dw $FC00, $FC00, $F000, $F000, $F000, $F000, $F000, $F000
	dw $F300, $F300, $F300, $F300, $F300, $F300, $F000, $F000
	dw $C300, $C300, $C300, $C300, $C300, $C300, $FF00, $FF00
	dw $CF00, $CF00, $CF00, $CF00, $CF00, $CF00, $C300, $C300
	dw $0F00, $0F00, $0F00, $0F00, $0F00, $0F00, $FC00, $FC00
	dw $3C00, $4200, $B900, $A500, $B900, $A500, $4200, $3C00
	ds 7 * 16

; Symboles sp�ciaux
	dw $0C0C, $0C0C, $0C0C, $0C0C, $0C0C, $0000, $0C0C, $0C0C ; !
	ds 5 * 16
	dw $3030, $3030, $3030, $3030, $0000, $0000, $0000, $0000 ; '

; Tiles du menu de sauvegarde
	dw $3F3F, $6060, $4640, $4840, $4440, $4240, $4C40, $4040
	dw $404C, $404A, $404C, $404A, $404A, $6060, $3F3F, $0000
	dw $FFFF, $0000, $4A00, $AA00, $EA00, $AA00, $AE00, $0000
	dw $00EE, $0084, $00C4, $0084, $00E4, $0000, $FFFF, $0000
	dw $FFFF, $0000, $AE00, $A800, $AC00, $A800, $4E00, $0000
	dw $00EA, $00AA, $00AA, $00AA, $00EE, $0000, $FFFF, $0000
	dw $F8F8, $0C0C, $C404, $A404, $C404, $A404, $A404, $0404
	dw $04C4, $04A4, $04C4, $04A4, $04A4, $0C0C, $F8F8, $0000

; Chiffres (non utilis�s par l'OAM)
	dw $3C3C, $7E7E, $6666, $6666, $6666, $6666, $7E7E, $3C3C ; 0
	dw $1818, $1818, $7878, $7878, $1818, $1818, $7E7E, $7E7E ; 1
	dw $3C3C, $7E7E, $6666, $0E0E, $1C1C, $3838, $7E7E, $7E7E ; 2
	dw $3C3C, $7E7E, $6666, $0C0C, $0C0C, $6666, $7E7E, $3C3C ; 3
	dw $0C0C, $1C1C, $3C3C, $6C6C, $FEFE, $FEFE, $0C0C, $0C0C ; 4
	dw $7E7E, $7E7E, $6060, $7878, $1E1E, $0606, $7E7E, $7C7C ; 5
	dw $3E3E, $7E7E, $6060, $7C7C, $7E7E, $6666, $7E7E, $3C3C ; 6
	dw $7E7E, $7E7E, $0606, $0C0C, $1818, $1818, $1818, $1818 ; 7
	dw $3C3C, $7E7E, $6666, $3C3C, $3C3C, $6666, $7E7E, $3C3C ; 8
	dw $3C3C, $7E7E, $6666, $7E7E, $3E3E, $0606, $7E7E, $3C3C ; 9

	dw $0000, $0000, $0C0C, $0C0C, $0000, $0C0C, $0C0C, $0000 ; :
	dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ; ;
	dw $0000, $0404, $0C0C, $1C1C, $3C3C, $7C7C, $0C0C, $0C0C
	dw $0C0C, $0C0C, $7C7C, $3C3C, $1C1C, $0C0C, $0404, $0000
	dw $0000, $7F7F, $7F7F, $6060, $6060, $6060, $6060, $6060
	dw $6060, $6060, $6060, $6060, $6060, $7F7F, $7F7F, $0000
	dw $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000 ; @

; Lettres
	dw $3C3C, $7E7E, $6666, $6666, $7E7E, $7E7E, $6666, $6666 ; A
	dw $7C7C, $7E7E, $6666, $7C7C, $7E7E, $6666, $7E7E, $7C7C ; B
	dw $3C3C, $7E7E, $6666, $6060, $6060, $6666, $7E7E, $3C3C ; C
	dw $7C7C, $7E7E, $6666, $6666, $6666, $6666, $7E7E, $7C7C ; D
	dw $3E3E, $7E7E, $6060, $7878, $7878, $6060, $7E7E, $3E3E ; E
	dw $3E3E, $7E7E, $6060, $7878, $7878, $6060, $6060, $6060 ; F
	dw $3C3C, $7E7E, $6666, $6060, $6E6E, $6666, $7E7E, $3C3C ; G
	dw $6666, $6666, $6666, $7E7E, $7E7E, $6666, $6666, $6666 ; H
	dw $7E7E, $7E7E, $1818, $1818, $1818, $1818, $7E7E, $7E7E ; I
	dw $7E7E, $7E7E, $1818, $1818, $1818, $1818, $7878, $7070 ; J
	dw $6666, $6E6E, $7C7C, $7878, $7878, $7C7C, $6E6E, $6666 ; K
	dw $6060, $6060, $6060, $6060, $6060, $6060, $7E7E, $3E3E ; L
	dw $6666, $7E7E, $7E7E, $7E7E, $6666, $6666, $6666, $6666 ; M
	dw $7C7C, $7E7E, $6666, $6666, $6666, $6666, $6666, $6666 ; N
	dw $3C3C, $7E7E, $6666, $6666, $6666, $6666, $7E7E, $3C3C ; O
	dw $7C7C, $6E6E, $6666, $6E6E, $7C7C, $6060, $6060, $6060 ; P
	dw $3C3C, $7E7E, $6666, $6666, $6666, $6E6E, $7C7C, $3A3A ; Q
	dw $7C7C, $6E6E, $6666, $6E6E, $7C7C, $7878, $6C6C, $6666 ; R
	dw $3E3E, $7E7E, $6060, $7C7C, $3E3E, $0606, $7E7E, $7C7C ; S
	dw $7E7E, $7E7E, $1818, $1818, $1818, $1818, $1818, $1818 ; T
	dw $6666, $6666, $6666, $6666, $6666, $6666, $7E7E, $3C3C ; U
	dw $6666, $6666, $6666, $6666, $6666, $7E7E, $3C3C, $1818 ; V
	dw $C3C3, $C3C3, $C3C3, $DBDB, $DBDB, $FFFF, $7E7E, $2424 ; W
	dw $6666, $6666, $7E7E, $3C3C, $3C3C, $7E7E, $6666, $6666 ; X
	dw $6666, $6666, $6666, $7E7E, $3C3C, $1818, $1818, $1818 ; Y
	dw $7E7E, $7E7E, $0606, $1E1E, $7878, $6060, $7E7E, $7E7E ; Z
	ds 5 * 16

; Chiffres
; Ceux-ci sont utilis�s par l'OAM (� cause des sprites en 8 * 16)
; les autres sont pr�sents pour respecter le codage ASCII
	dw $0000, $0000, $0000, $0000, $3C3C, $7E7E, $6666, $6666
	dw $6666, $6666, $7E7E, $3C3C, $0000, $0000, $0000, $0000 ; 0
	dw $0000, $0000, $0000, $0000, $1818, $1818, $7878, $7878
	dw $1818, $1818, $7E7E, $7E7E, $0000, $0000, $0000, $0000 ; 1
	dw $0000, $0000, $0000, $0000, $3C3C, $7E7E, $6666, $0E0E
	dw $1C1C, $3838, $7E7E, $7E7E, $0000, $0000, $0000, $0000 ; 2
	dw $0000, $0000, $0000, $0000, $3C3C, $7E7E, $6666, $0C0C
	dw $0C0C, $6666, $7E7E, $3C3C, $0000, $0000, $0000, $0000 ; 3
	dw $0000, $0000, $0000, $0000, $0C0C, $1C1C, $3C3C, $6C6C
	dw $FEFE, $FEFE, $0C0C, $0C0C, $0000, $0000, $0000, $0000 ; 4
	dw $0000, $0000, $0000, $0000, $7E7E, $7E7E, $6060, $7878
	dw $1E1E, $0606, $7E7E, $7C7C, $0000, $0000, $0000, $0000 ; 5
	dw $0000, $0000, $0000, $0000, $3E3E, $7E7E, $6060, $7C7C
	dw $7E7E, $6666, $7E7E, $3C3C, $0000, $0000, $0000, $0000 ; 6
	dw $0000, $0000, $0000, $0000, $7E7E, $7E7E, $0606, $0C0C
	dw $1818, $1818, $1818, $1818, $0000, $0000, $0000, $0000 ; 7
	dw $0000, $0000, $0000, $0000, $3C3C, $7E7E, $6666, $3C3C
	dw $3C3C, $6666, $7E7E, $3C3C, $0000, $0000, $0000, $0000 ; 8
	dw $0000, $0000, $0000, $0000, $3C3C, $7E7E, $6666, $7E7E
	dw $3E3E, $0606, $7E7E, $3C3C, $0000, $0000, $0000, $0000 ; 9

; Cadres
	dw $0000, $3F3F, $7F7F, $7070, $6060, $6060, $6060, $6060 ; haut-gauche
	dw $6060, $6060, $6060, $6060, $7070, $7F7F, $3F3F, $0000 ; bas-gauche
	dw $0000, $FCFC, $FEFE, $0E0E, $0606, $0606, $0606, $0606 ; haut-droite
	dw $0606, $0606, $0606, $0606, $0E0E, $FEFE, $FCFC, $0000 ; bas-droite
	dw $0000, $FFFF, $FFFF, $0000, $0000, $0000, $0000, $0000 ; haut
	dw $6060, $6060, $6060, $6060, $6060, $6060, $6060, $6060 ; gauche
	dw $0606, $0606, $0606, $0606, $0606, $0606, $0606, $0606 ; droite
	dw $0000, $0000, $0000, $0000, $0000, $FFFF, $FFFF, $0000 ; bas

; Fl�ches
	dw $0000, $0808, $1C1C, $3E3E, $7F7F, $0000, $0000, $0000 ; Fl�che vers le haut
	dw $0000, $0000, $0000, $7F7F, $3E3E, $1C1C, $0808, $0000 ; Fl�che vers le bas
TileDataEnd::

	ds 4
	db "BRAVO, TU VIENS DE TROUVER UN EASTER EGG !  BIEN JOUE MEC, MAIS IL N'Y EN A PAS D'AUTRES :)"

titleTiles::
	dw $FFFF, $80FF, $BFFF, $A0E0, $A0E0, $AFEF, $A8EF, $AFEF
	dw $DCDC, $54DC, $D4DC, $141C, $141C, $D4DC, $54DC, $54DC
	dw $3B3B, $2A3B, $2A3B, $2A3B, $2A3B, $2A3B, $2A3B, $2A3B
	dw $FFFF, $01FF, $FFFF, $8080, $8080, $9F9F, $919F, $9D9F
	dw $7F7F, $407F, $5F7F, $5070, $5070, $5373, $5273, $5373
	dw $EFEF, $28EF, $EBEF, $0A0E, $0B0F, $E8EF, $2BEF, $AAEE
	dw $FDFD, $05FD, $FDFD, $0101, $C1C1, $41C1, $C1C1, $0101
	dw $F8F8, $04FC, $72FE, $4ACE, $4ACE, $72FE, $04FC, $68F8
	dw $0101, $0101, $0101, $0101, $0101, $0101, $0101, $0101
	dw $FFFF, $00FF, $7FFF, $40C0, $40C0, $40C0, $40C0, $40C0
	dw $B8B8, $A8B8, $A8B8, $2838, $2838, $2838, $2838, $2838
	dw $7777, $5477, $5577, $5577, $5577, $5477, $5577, $5577
	dw $E3E3, $12F3, $CAFB, $2A3B, $CAFB, $12F3, $CAFB, $2A3B
	dw $FFFF, $01FF, $FFFF, $8080, $FFFF, $01FF, $FFFF, $8080
	dw $4040, $6060, $7070, $7878, $7070, $6060, $4040, $0000
	ds 16
	dw $A1E1, $BFFF, $80FF, $FFFF, $0000, $0000, $0000, $0000
	dw $54DC, $57DF, $50DF, $DFDF, $0000, $0000, $0000, $0000
	dw $2A3B, $EAFB, $0AFB, $FBFB, $0000, $0000, $0000, $0000
	dw $8587, $FDFF, $01FF, $FFFF, $0000, $0000, $0000, $0000
	dw $5070, $5F7F, $407F, $7F7F, $0000, $0000, $0000, $0000
	dw $AAEE, $ABEF, $28EF, $EFEF, $0000, $0000, $0000, $0000
	dw $0101, $FDFD, $05FD, $FDFD, $0000, $0000, $0000, $0000
	dw $54DC, $4ACE, $45C7, $C3C3, $0000, $0000, $0000, $0000
	dw $0101, $0101, $0101, $0101, $0000, $0000, $0000, $0000
	dw $40C0, $7FFF, $00FF, $FFFF, $0000, $0000, $0000, $0000
	dw $2838, $AFBF, $A0BF, $BFBF, $0000, $0000, $0000, $0000
	dw $5577, $D5F7, $14F7, $F7F7, $0000, $0000, $0000, $0000
	dw $2A3B, $CAFB, $12F3, $E3E3, $0000, $0000, $0000, $0000
	dw $8080, $FFFF, $01FF, $FFFF, $0000, $0000, $0000, $0000
titleTilesEnd::

titleTileMap::
	ds $65
	db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E
	ds $12
	db $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E
titleTileMapEnd::

motdTiles::
	db "ENCORE MIEUX QUE", 0
	db "LE RUBIKS CUBE !", 0

pushSTARTtiles::
	db "APPUIE SUR START !"
pushSTARTtilesEnd::

sprites::
	db 0, 68, $28, $10
	db 0, 76, $2A, $10
	db 0, 84, $2C, $10
	db 0, 92, $2E, $10
	ds 3 * 4
	db 0, 0, $3C, $00
	db 0, 0, $60, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $62, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $64, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $66, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $68, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $6A, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $6C, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $6E, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $70, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
	db 0, 0, $72, $00
	db 0, 0, $3E, $00
	db 0, 0, $3E, $20
spritesEnd::

DMAscript:: ; ne d�truit que a
	halt ; attente d'un Vblank
	ld a, $C0
	ld [DMA], a ; d�marrage du transfert DMA ($C000 -> $C09F)
	xor %11101000 ; $C0 xor $E8 = $28
DMAloop:: ; $07E
	dec a
	jr nz, DMAloop ; ne PAS utiliser jp !!
	ret ; NB : retourne a = 0
DMAscriptEnd::