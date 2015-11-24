; ============= EQUATES =============
; ------------- RESTART -------------
;rst00          equ $00
jumpFar        equ $08
delayAframes   equ $10
fill           equ $18
;rst20          equ $20
;rst28          equ $28
;rst30          equ $30
callFar        equ $38

; ----------- BANK SWITCH -----------
bankSwitch     equ $2100 ; pas $2000 à cause du MBC2
currentRomBank equ $FFB4

; ----------- GRAPHISMES ------------
; adresses des tuiles graphiques
tileDataBGOBJ  equ $8000
tileDataBGWIN  equ $8800

; adresses de la tile map
tileMap        equ $9800
tileMap2       equ $9C00

; adresses des tile map destinations
tileMapTitle   equ $99FE
lvSelectTiles  equ $98A2

OAMbuffer      equ $C000 ; adresse du buffer transféré à l'OAM
DMAtransfer    equ $FF80 ; adresse à appeler pour lancer le transfert DMA

; -------------- WRAM ---------------
titleScreenBuf equ $C1E0
options        equ $C1DE

; ------------- JOYPAD --------------
selectDpad     equ %00100000
selectButtons  equ %00010000

directionDown  equ %10000000
directionUp    equ %01000000
directionLeft  equ %00100000
directionRight equ %00010000

buttonStart    equ %00001000
buttonSelect   equ %00000100
buttonB        equ %00000010
buttonA        equ %00000001

OLDJOYP        equ $C1DE
NEWJOYP        equ $C1DF

; ------------- NIVEAU --------------
slotCoords     equ $C0A0 ; Paires de coordonnées pour chaque slot
levelName      equ $C0B4 ; Nom du niveau (en ASCII, bien sûr !)
circles        equ $C0C0 ; Liste des slots pour chaque cercle
currentIDs     equ $C0F0 ; Liste des IDs de chaque slot


; =========== CONSTANTES ============
_WRAM          equ $C000
JOYP           equ $FF00
IFlg           equ $FF0F
LCDC           equ $FF40
STAT           equ $FF41
SCY            equ $FF42
SCX            equ $FF43
LY             equ $FF44
LYC            equ $FF45
DMA            equ $FF46
BGP            equ $FF47
OBP0           equ $FF48
OBP1           equ $FF49
WY             equ $FF4A
WX             equ $FF4B
; la HRAM commence à $FF80, mais les $0B premiers octets sont utilisés par le script DMA
_HRAM          equ $FF80 + $0B ; $0B : longueur du DMAscript
IE             equ $FFFF


; ============= MACROS ==============
; Usage : loadBank bankID
; Charge la banque bankID.
loadBank: MACRO
	ld a, \1
	ld [bankSwitch], a
ENDM


; macro un peu bizarre, mais qui fonctionne.
; pour les curieux, voir http://wikiti.brandonw.net/index.php?title=Z80_Optimization#Conditional_rst

; Usage : callFarRoutine condition, label, returnLabel
; Effectue un appel à label (quelle que soit sa banque), et retourne à returnLabel (quel que soit sa banque)
noCond         equ $FF ; jr sans condition
carryUnset     equ $20
carrySet       equ $28
isNonZero      equ $30
isZero         equ $38
callFarRoutine: MACRO
	ld c, BANK(\3)
	ld hl, \2
	push hl
	ld a, BANK(\2)
	ld hl, \2
IF \1 != noCond
	db \1
ENDC
	rst $38
	pop hl
ENDM