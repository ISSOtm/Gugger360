Start:: ; here we begin our adventure !

; activation des interruptions VBlank et uniquement de celles-ci, du coup HALT fait attendre un VBlank
	di
	xor a
; on vire les interruptions de LCD STAT
	ld [STAT], a
	ld [IFlg], a
	or %00000011 ; on n'active que Vblank et LCD STAT
; en pratique, seul le Vblank est actif, puisque LCD STAT ne se déclenche jamais...
; sauf pendant copyToVRAM !
	ld [IE], a
	ei

	or %01111100
	rst delayAframes

	xor a
	halt ; en théorie, il ne faut éteindre le LCD que pendant un Vblank (sur émulateur, osef mais je préfère le laisser :)
	ld [LCDC], a ; extinction de l'écran pour démarrer le jeu

	ld hl, tileDataBGOBJ
	ld bc, $800
	call fillToVRAM ; on efface la VRAM pour être sûr de ce qu'il y a
	ld hl, tileMap
	ld bc, $1000
	call fillToVRAM

; on reset tous les graphismes
	loadBank Tiles
	ld hl, Tiles
	ld de, tileDataBGOBJ
	ld bc, (TileDataEnd - Tiles)
	call copy ; c'est de la VRAM, mais l'écran est éteint.
	ld hl, unlicenseTileMap
	ld de, tileMap
	ld bc, (introTileMap - unlicenseTileMap)
	call copy

	xor a
	ld hl, OAMbuffer
	ld bc, $A0
	rst fill ; on vide l'OAMbuffer, qu'on transfèrera plus tard

; on remet le scroll à 0
	ld [SCY], a
	ld [SCX], a

	or %10010101 ; a = %10011101
	; IE : LCD ON,
	;      Window [9800 - 9C00],
	;      Window OFF,
	;      BG tiles [8000 - 8FFF],
	;      BG tileMap [9800 - 9BFF],
	;      sprites en 8x16 pixels,
	;      sprites OFF,
	;      BG ON.
	ld [LCDC], a

	xor %01110001 ; a = %11 10 01 00 ($E4)
	ld [BGP], a
	ld [OBP0], a
	ld [OBP1], a
	
	xor a
	ld hl, _WRAM
	ld bc, $2000
	rst fill

; on copie le programme DMA en HRAM
	ld hl, DMAscript
	ld de, DMAtransfer
	ld bc, DMAscriptEnd - DMAscript
	call copy; le script est copié au début de la HRAM pour ne pas poser de problèmes avec le stack
	
	ld hl, sprites
	ld de, OAMbuffer
	ld bc, spritesEnd - sprites
	call copy ; on initialise l'OAM
	
	call DMAtransfer ; on transfère l'OAM
	; a = 0 après exécution ;)

	halt
	or %10010111
	ld [LCDC], a

; attente pour l'intro
	xor %11101111 ; on attendra 30 frames, soit un peu moins d'une demie-seconde
	rst delayAframes
	ld hl, introTileMap
	ld de, tileMap
	ld bc, introTileMap2 - introTileMap
	call copyToVRAM
	
	; le dernier octet copié ici est un $00
	or 30 ; 1/2 seconde
	rst delayAframes
	ld hl, introTileMap2
	ld de, $9926
	ld bc, Tiles - introTileMap2
	call copyToVRAM

	ld hl, titleTiles
	ld de, tileDataBGOBJ + 16
	ld bc, titleTilesEnd - titleTiles
	call copyToVRAM
	ld hl, titleTileMap
	ld de, tileMapTitle
	ld bc, titleTileMapEnd - titleTileMap
	call copyToVRAM
	
	; de même ici
	or 120
	rst delayAframes
scrollDown::
	inc a
	halt
	ld [SCY], a
	cp $90
	jr nz, scrollDown
	
	rrca ; a = $48
	rrca ; a = $24
	rrca ; a = $12 (18)
	rst delayAframes
	ld hl, motdTiles
	ld de, $9AC2
printMOTD::
	ld a, 10
	rst delayAframes ; puts us at the end of a Vblank
	ld a, [hli]
	ld [de], a
	inc de
	and a
	jp nz, printMOTD
	ld de, $9B02
printMOTD2::
	ld a, 10
	rst delayAframes ; puts us at the end of a Vblank
	ld a, [hli]
	ld [de], a
	inc de
	and a
	jp nz, printMOTD2

	halt
	ld hl, $98E2
	ld bc, $4C
	rst fill

pushSTART:: ; tout ce code fonctionne. Don't question it.
	ld hl, pushSTARTtiles
	ld de, $9BE1
	ld bc, pushSTARTtilesEnd - pushSTARTtiles
	call copyToVRAM

	or $FF
	ld b, 20
	ld hl, JOYP
blinkPushSTART1::
	ld [hl], selectButtons
	halt
	and [hl]
	dec b
	jr nz, blinkPushSTART1
	ld d, a
	xor a
	ld hl, $9BE1
	ld bc, pushSTARTtilesEnd - pushSTARTtiles
	halt
	rst fill
	ld a, d
	ld b, 20
	ld hl, JOYP
blinkPushSTART2::
	ld [hl], selectButtons
	halt
	and [hl]
	dec b
	jr nz, blinkPushSTART2
	and buttonStart
	jr nz, pushSTART

	ld b, 10
blinkSTART::
	push bc
	ld hl, pushSTARTtiles
	ld de, $9BE1
	ld bc, pushSTARTtilesEnd - pushSTARTtiles
	call copyToVRAM
	ld a, 3
	rst delayAframes
	ld hl, $9BE1
	ld bc, pushSTARTtilesEnd - pushSTARTtiles
	halt
	rst fill
	or 3
	rst delayAframes
	pop bc
	dec b
	jr nz, blinkSTART
	
	ld hl, menuOptions
	ld de, $9BA5
	ld bc, menuOptionsEnd - menuOptions
	call copyToVRAM
	ld de, $9BA5