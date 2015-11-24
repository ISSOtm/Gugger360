INCLUDE "constants.asm"


; rst vectors
INCLUDE "restarts.asm"

; routines d'intérêt général
INCLUDE "utilitaries.asm"

; header de la cartouche.
INCLUDE "header.asm"


SECTION "Main", HOME[$150]
INCLUDE "intro.asm"	

	ld hl, scrollScreen
	push hl
levelSelect::
	loadBank 2 ; tous les graphismes requis sont chargés, on peut ouvrir la banque de niveaux
	ld hl, levelSelectTileMap
	ld de, lvSelectTiles
	ld bc, levelSelectTileMapEnd - levelSelectTileMap
	call copyToVRAM
	ld d, 0 ; contient l'ID du niveau demandé
	ret ; NE PAS ENLEVER !! Optimisation assez moche à voir, mais efficace

scrollScreen::
	ld a, $90
scrollToLevelSelect::
	dec a
	dec a
	halt
	ld [SCY], a
	cp $20
	jr nz, scrollToLevelSelect

printSelectedLevelsName::
	ld a, d
	and $7F
	ld d, a
	push de
	dec a
	call getLevelName
	ld de, $9964
	ld bc, 12
	call copyToVRAM
	pop de
	ld a, d
	push de
	call getLevelName
	ld de, $99A4
	ld bc, 12
	call copyToVRAM
	pop de
	ld a, d
	push de
	inc a
	call getLevelName
	ld de, $99E4
	ld bc, 12
	call copyToVRAM
	ld a, $EF
waitReleaseDpad::
	ld [JOYP], a
	ld a, [JOYP]
	ld a, [JOYP]
	xor $EF
	jr nz, waitReleaseDpad
	pop de
	nop ; on attend la stabilisation de l'input
	nop
levelSelectMenu::
	ld a, $EF
	ld [JOYP], a
	ld a, [JOYP]
	ld a, [JOYP]
	and $0C
	xor $0C
	jp nz, moveLevelSelectCursor
	ld a, $DF
	ld [JOYP], a
REPT 6
	ld a, [JOYP]
ENDR
	and $0F
	xor $0F
	jp z, levelSelectMenu
	and buttonB
	jp z, loadLevel ; autre bouton, on charge le niveau
; bouton B, on revient à l'écran titre
	xor a
	ld hl, $9AC2
	ld bc, 80
	call fillToVRAM ; on efface le MOTD
	loadBank 1 ; on charge la banque de graphismes
	ld a, $20 ; le scroll n'est pas à 0 !!
	jp scrollDown

moveLevelSelectCursor::
	dec d
	and $08
	jp z, printSelectedLevelsName
	inc d
	inc d
	jp printSelectedLevelsName

loadLevel::
	ld a, d
	call getLevelName
	ld a, -20
	add a, l
	ld l, a
	ld de, slotCoords
	ld bc, 90
	call copy ; on copie le niveau en RAM pour édition

	xor a
	ld hl, $98C4
	ld bc, 12
	call fillToVRAM
	ld hl, $9905
	ld bc, 10
	call fillToVRAM
	ld hl, levelSelectClearMap
	ld de, $9952
	ld bc, $60
	call copyToVRAM
	ld hl, levelSelectClearMap
	ld bc, $40
	call copyToVRAM

drawLevel::
	ld hl, slotCoords
	ld de, OAMbuffer + 4
	ld b, 10
moveSprites:: ; redessine tous les chiffres en accord avec le buffer RAM
	ld a, [hli]
	ld [de], a; on écrit la coodonnée horizontale
	inc de
	ld a, [hli]
	ld [de], a ; idem pour la coordonnée verticale
	inc de ; on ne peut pas ajouter, et on ne doit avancer que de 4 octets.
	inc de ; J'assume que quatre INCs sont OK
	inc de
	inc de
	ld [de], a
	inc de
	inc de
	inc de
	inc de
	ld [de], a
	inc de
	inc de
	inc de ; un inc en moins, on va arriver au chiffre suivant
	dec b
	jp nz, moveSprites
	ld hl, currentIDs
	ld de, OAMbuffer + 6
	ld b, 10
putDigits::
	push bc
	ld a, [hli]
	push hl
	add a, a
	add a, $60
	ld [de], a
	ld hl, 12
	add hl, de
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec b
	jp nz, putDigits
	call DMAtransfer
	ld c, 0
	ld hl, currentIDs
compareDigitList::
	ld a, [hli]
	cp c
	jr nz, gameLoop ; fail, le chiffre n'est pas bon
	inc c ; on attend les chiffres par ordre croissant
	xor 9 ; On a atteint le chiffre 9 ou pas ?
	jp nz, compareDigitList
levelEnd:: ; tous les chiffres sont OK !!
	loadBank 1 ; on charge la banque des sprites
	ld hl, sprites
	ld de, OAMbuffer
	ld bc, spritesEnd - sprites
	call copy ; on réinitialise tous les sprites
	call DMAtransfer
	ld hl, printSelectedLevelsName ; la fonction sautera le scroll de l'écran
	push hl ; manipulation du stack pas très jolie...
	jp levelSelect ; ... mais efficace.

gameLoop:: ; ENFIN !!
	
	or 255
	rst delayAframes
	jp levelEnd


; graphismes
INCLUDE "graphics.asm"

; niveaux
INCLUDE "levels.asm"