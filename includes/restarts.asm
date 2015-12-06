; multiplie a par 12 si a <= 42 (attention au carry pour a > 21 !)
; 6 octets, et en plus, rapide :)
; détruit b, qui vaut a (avant multiplication)
SECTION "rst $00", HOME[$00]
multBy12::
	ld d, a ; 0 < a < 3
	rla ; 0 < a < 6
	add a, d ; 0 < a < 9
	rla ; 0 < a < 18
	rla ; 0 < a < 36
	ret

; charge la banque a, puis saute à hl
; 4 octets seulement :P
; préserve bc et de, a vaut l'ID de la banque du script, et hl l'adresse atteinte
SECTION "rst $08", HOME[$08]
jumpFarBank::
	ld [bankSwitch], a
	jp [hl]

; attend a frames
; 7 octets
; a vaut 0
SECTION "rst $10", HOME[$10]
waitFrames::
	halt
	dec a
	jp nz, waitFrames
	ret

; remplit bc octets à partir de [hl]
; 9 octets !
; Ne préserve que e
; ATTENTION ! Ne PAS tenter de "remplir" l'OAM avec cette routine !!
SECTION "rst $18", HOME[$17]
fillMemory::
	ld a, d
fillBytes::
	ldi [hl], a
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, fillMemory
	ret

; 
; 
; 
SECTION "rst $20", HOME[$20]
rst20::
	ret

; 
; 
; 
SECTION "rst $28", HOME[$28]
rst28::
	ret

; 
; 
; 
SECTION "rst $30", HOME[$30]
rst30::
	ret

; NOTICE !!
; Peut être appelé conditionnellement !
; il suffit d'effectuer un push de l'adresse retour, puis un jr [condition], @+1
; si la condition est remplie, le jump s'effectuera un octet en arrière, et lira un "rst 38".
; C'est un hack un peu bizarre, je recommande d'utiliser la macro callFar

; charge la banque a, saute à hl, et retourne à la banque c, à l'adresse [sp]
; 7 octets seulement :O
; même side effects que jumpFarBank, mais ne préserve que de
SECTION "rst $38", HOME[$38]
callFarBank::
	push bc
	rst $08 ; effectue le premier swapBank, et nous fait retourner ici
	pop af
	pop hl
	jp jumpFarBank ; effectue le second swapBank, et quitte.


; Routines d'interruption

; utilisé, mais ne sert qu'à quitter le mode HALT
SECTION "vblank", HOME[$40]
	reti

; idem
SECTION "hblank", HOME[$48]
	reti

; inutilisé
SECTION "timer",  HOME[$50]
	reti

; inutilisé
SECTION "serial", HOME[$58]
	reti

; inutilisé
SECTION "joypad", HOME[$60]
	reti
