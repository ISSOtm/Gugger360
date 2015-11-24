; 
; 
; 
SECTION "rst $00", HOME[$00]
rst00::
	ret

; charge la banque a, puis saute � hl
; 4 octets seulement :P
; pr�serve bc et de, a vaut l'ID de la banque du script, et hl l'adresse atteinte
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

; remplit bc octets � partir de [hl]
; 9 octets !
; Ne pr�serve que e
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
; Peut �tre appel� conditionnellement !
; il suffit d'effectuer un push de l'adresse retour, puis un jr [condition], @+1
; si la condition est remplie, le jump s'effectuera un octet en arri�re, et lira un "rst 38".
; C'est un hack un peu bizarre, je recommande d'utiliser la macro callFar

; charge la banque a, saute � hl, et retourne � la banque c, � l'adresse [sp]
; 7 octets seulement :O
; m�me side effects que jumpFarBank, mais ne pr�serve que de
SECTION "rst $38", HOME[$38]
callFarBank::
	push bc
	rst $08 ; effectue le premier swapBank, et nous fait retourner ici
	pop af
	pop hl
	jp jumpFarBank ; effectue le second swapBank, et quitte.


; Routines d'interruption

; utilis�, mais ne sert qu'� quitter le mode HALT
SECTION "vblank", HOME[$40]
	reti

; idem
SECTION "hblank", HOME[$48]
	reti

; inutilis�
SECTION "timer",  HOME[$50]
	reti

; inutilis�
SECTION "serial", HOME[$58]
	reti

; inutilis�
SECTION "joypad", HOME[$60]
	reti
