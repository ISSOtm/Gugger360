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
	xor a
	ld [currentLevel], a
levelSelect::
	loadBank 2 ; tous les graphismes requis sont chargés, on peut ouvrir la banque de niveaux
	ld hl, levelSelectTileMap
	ld de, lvSelectTiles
	ld bc, levelSelectTileMapEnd - levelSelectTileMap
	call copyToVRAM
	ld a, [currentLevel]
	ld d, a ; contient l'ID du niveau demandé
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
	and maxLevel
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
	ld [currentLevel], a
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

	xor a
	ld [currentCircle], a

	call beginStage

redrawDigits::
	ld hl, currentIDs
	ld de, OAMbuffer + 4 * 8 + 2
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
	call DMAtransfer
	or 6
	rst delayAframes
	dec b
	jp nz, putDigits
	ld c, 0
	ld hl, currentIDs
compareDigitList::
	ld a, [hli]
	cp c
	jr nz, waitSelectCircle ; fail, le chiffre n'est pas bon
	inc c ; on attend les chiffres par ordre croissant
	xor 9 ; On a atteint le chiffre 9 ou pas ?
	jp nz, compareDigitList
levelEnd:: ; tous les chiffres sont OK !!
	loadBank 1 ; on charge la banque des sprites
	ld hl, sprites + 20
	ld de, $C014
	ld c, 11
resetSprites::
	ld b, 12
	halt
resetSprite::
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jp nz, resetSprite
	call DMAtransfer
	or 6
	rst delayAframes
	dec c
	jr nz, resetSprites

	ld hl, printSelectedLevelsName ; la fonction sautera le scroll de l'écran
	push hl ; manipulation du stack pas très jolie...
	jp levelSelect ; ... mais efficace.

waitSelectCircle::
	ld a, 30
	rst delayAframes
selectCircle::
	ld a, [currentCircle]
	rst x12
	ld d, 0
	ld e, a
	ld hl, circles
	add hl, de
	ld de, $C01C
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
; hl pointe vers la liste des slots, on en aura besoin à selectSlots
	ld de, $C024
	ld b, 10
	xor a
resetSlots::
	ld [de], a
REPT 4
	inc de
ENDR
	ld [de], a
REPT 8
	inc de
ENDR
	dec b
	jp nz, resetSlots
selectSlots::
	ld a, [hli]
	inc a
	jp z, refreshSprites
	ld d, a
	rla
	add a, d
	rla
	rla
	add a, $20 - 12
	ld e, a
	ld d, $C0
	ld a, [de]
REPT 4
	inc de
ENDR
	ld [de], a
REPT 4
	inc de
ENDR
	ld [de], a
	jp selectSlots

rotateCircle1::
	ld a, [currentCircle]
	rst x12
	ld h, 0
	ld l, a
	ld bc, circles + 2
	add hl, bc
	ld c, 0
swapSlots::
	ld a, [hli]
	inc a
	jr z, swapLastSlot
	add a, $EF
	ld d, $C0
	ld e, a
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	jp swapSlots
swapLastSlot::
	ld a, [currentCircle]
	rst x12
	ld h, 0
	ld l, a
	ld a, [hl]
	add a, $EF
	ld h, $C0
	ld l, a
	ld [hl], c
	jp redrawDigits

rotateCircle2::
	ld a, [currentCircle]
	rst x12
	ld h, 0
	ld l, a
	ld bc, circles + 2
	add hl, bc
	ld de, circleCopyBuf + 9
	ld a, $FF
	ld [de], a
copyCircle::
	ld a, [hli]
	ld [de], a
	dec de
	inc a
	jp nz, copyCircle
	ld c, 0
	jp swapSlots

selectNextCircle::
	ld a, [currentCircle]
	inc a
	and 3 ; wrap 4 -> 0
	ld [currentCircle], a
	add a, $C0
	ld h, $C0
	ld l, a
	xor a
	or [hl]
	jr z, selectNextCircle
	jp selectCircle

selectPrevCircle::
	ld a, [currentCircle]
	dec a
	and 3 ; wrap 4 -> 0
	ld [currentCircle], a
	add a, $C0
	ld h, $C0
	ld l, a
	xor a
	or [hl]
	jr z, selectPrevCircle
	jp selectCircle
	
refreshSprites::
	call DMAtransfer
gameLoop:: ; ENFIN !!
waitDpadRelease::
	ld a, selectDpad
	ld [JOYP], a
	ld a, [JOYP]
	ld a, [JOYP]
	ld a, [JOYP]
	ld a, [JOYP]
	ld a, [JOYP]
	ld a, [JOYP]
	cp $EF
	jp nz, waitDpadRelease
	ld a, selectDpad
	ld [JOYP], a
	halt
	ld a, [JOYP]
	rra
	jr nc, selectNextCircle
	rra
	jr nc, selectPrevCircle
	rra
	call nc, rotateCircle1
	rra
	call nc, rotateCircle2
	ld a, selectButtons
	ld [JOYP], a
	ld a, [JOYP]
	ld a, [JOYP]
	ld a, [JOYP]
	ld a, [JOYP]
	ld a, [JOYP]
	ld a, [JOYP]
	rra
	rra
	jp nc, levelEnd
	rra
	call nc, beginStage
	rra
	jp c, gameLoop
pauseGame::
	xor a
	ld [IFlg], a
	or $10
	ld [IE], a
	stop
	xor a
	ld [IFlg], a
	or $13
	ld [IE], a
	jp gameLoop

beginStage::
	ld a, $90
scrollGoal::
	dec a
	ld [WY], a
	halt
	cp $70
	jr nz, scrollGoal

	and $10
	rst delayAframes

drawLevel::
	ld hl, slotCoords
	ld de, OAMbuffer + 4 * 8 ; on saute 8 sprites
	ld b, 10
moveSprites:: ; redessine tous les chiffres en accord avec le buffer RAM
	ld a, [hli]
	ld [de], a; on écrit la coodonnée horizontale
	inc de
	ld a, [hld]
	ld [de], a ; idem pour la coordonnée verticale
	inc de ; on ne peut pas ajouter, et on ne doit avancer que de 4 octets.
	inc de ; J'assume que quatre INCs sont OK p/r à d'autres méthodes
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	sub a, 4
	ld [de], a
	inc de
	inc de
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	add a, 4
	ld [de], a
	inc de
	inc de
	inc de ; un inc en moins, on va arriver au chiffre suivant
	call DMAtransfer
	or 6
	rst delayAframes
	dec b
	jp nz, moveSprites

	or $F0 ; 240 frames = 4 secondes
	rst delayAframes

	or $70
unscrollGoal::
	inc a
	ld [WY], a
	halt
	cp $A7
	jr nz, unscrollGoal
	ret

; graphismes
INCLUDE "graphics.asm"

; niveaux
INCLUDE "levels.asm"