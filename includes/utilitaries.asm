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
	ld a, [STAT]
	and %00000010 ; on ne garde qu'un des bits de l'�tat du LCD pour traiter 0 et 1, ainsi que 2 et 3, comme un seul cas
	jp z, skipWaitFreeVRAMaccess ; si on est en mode 2 ou 3, on ne peut pas copier ; on va donc attendre.
	halt ; on attend un Vblank ou un Hblank, les deux se valent
skipWaitFreeVRAMaccess::
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jp nz, copyVRAM
	dec b
	jp nz, copyVRAM

	xor a
	ld [STAT], a ; on enl�ve l'interruption Hblank
	ret

fillToVRAM::
	ld d, a
	ld a, %00001000
	ld [STAT], a

	inc b
	halt
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

; d�truit a et b, retourne un pointeur dans hl vers le nom du niveau n�a
getLevelName:: ; assume que la banque 2 est charg�e
	and $7F ; le wrap graphique est g�r� ici, c'est plus simple
	; d'abord, a * 90, c�d 2 * 5 * 3 * 3

	; cette multiplication par 3 prend autant d'octets mais est plus rapide
	ld l, a
	add a, a ; a varie entre 00 et FE
	add a, l ; seule cette op�ration peut overflow, puisque a varie entre 00 et 7F
	ld l, a ; on stocke a * 3
	xor a
	rla
	ld h, a ; on r�cup�re le carry dans h

	add hl, hl ; on double hl

	ld b, h ; une multiplication par 3
	ld c, l
	add hl, hl
	add hl, bc

	ld b, h ; et une autre par 5
	ld c, l
	add hl, hl
	add hl, hl
	add hl, bc

	ld bc, $4014
	add hl, bc
	ret
