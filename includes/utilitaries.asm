SECTION "Home", HOME[$68]
copy::
	inc b
copyBytes::
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jp nz, copyBytes
	dec b
	jp nz, copyBytes
	ret

copyToVRAM::
	ld a, %00001000
	ld [STAT], a ; on active les interruptions Hblank, pour pouvoir utiliser HALT entre les lectures

	inc b
copyVRAM::
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [STAT]
	and %00000010 ; on ne garde qu'un des bits de l'état du LCD pour traiter 0 et 1, ainsi que 2 et 3, comme un seul cas
	jp z, skipWaitFreeVRAMaccess ; si on est en mode 2 ou 3, on ne peut pas copier ; on va donc attendre.
	halt ; on attend un Vblank ou un Hblank, les deux se valent
skipWaitFreeVRAMaccess::
	dec c
	jp nz, copyVRAM
	dec b
	jp nz, copyVRAM

	xor a
	ld [STAT], a ; on enlève l'interruption Hblank
	ret

fillToVRAM::
	ld d, a
	ld a, %00001000
	ld [STAT], a

	inc b
fillVRAM::
	ld [hl], d
	inc hl
	ld a, [STAT]
	and %00000010
	jp z, VRAMisFree
	halt
VRAMisFree::
	dec c
	jp nz, fillVRAM
	dec b
	jp nz, fillVRAM

	xor a
	ld [STAT], a
	ret

DMAscript::
	halt ; attente d'un Vblank
	ld a, $C0
	ld [DMA], a ; démarrage du transfert DMA ($C000 -> $C09F)
	xor %11101000 ; $C0 xor $E8 = $28
DMAloop:: ; $07E
	dec a
	jr nz, DMAloop ; ne PAS utiliser jp !!
	ret ; NB : retourne a = 0
DMAscriptEnd::

getKeys::
	ld a, selectDpad
	ld [JOYP], a
	ld a, [JOYP]
	ld a, [JOYP]
	cpl
	and $0F
	swap a
	ld b, a
	ld a, selectButtons
	ld [JOYP], a
REPT 6
	ld a, [JOYP]
ENDR
	cpl
	and $0F
	or b
	ld b, a
	ld a, [OLDJOYP]
	xor b
	and b
	ld [NEWJOYP], a
	ld a, b
	ld [OLDJOYP], a
	ld a, $30
	ld [JOYP], a
	ret