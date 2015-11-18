SECTION "Header", HOME[$100]
	nop
	jp Start
	
	; $0104-$0133 (Nintendo logo)
	db	$CE, $ED, $66, $66, $CC, $0D, $00, $0B, $03, $73, $00, $83, $00, $0C, $00, $0D
	db	$00, $08, $11, $1F, $88, $89, $00, $0E, $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99
	db	$BB, $BB, $67, $63, $6E, $0E, $EC, $CC, $DD, $DC, $99, $9F, $BB, $B9, $33, $3E

	; $0134-$013E (Game title - up to 11 upper case ASCII characters; pad with $00)
	db	"GUGGER 360",0
		;0123456789  A

	; $013F-$0142 (Product code - 4 ASCII characters, assigned by Nintendo, just leave blank)
	db	"ISSO"
		;0123

	; $0143 (Color GameBoy compatibility code)
	db	$00	; Built for DMG

	; $0144 (High-nibble of license code - normally $00 if $014B != $33)
	db	$00

	; $0145 (Low-nibble of license code - normally $00 if $014B != $33)
	db	$00

	; $0146 (GameBoy/Super GameBoy indicator)
	db	$00	; Doesn't intend SGB feats

	; $0147 (Cartridge type - all Color GameBoy cartridges are at least $19)
	db	$05 ; MBC2

	; $0148 (ROM size)
	db	$03	; 16 banks

	; $0149 (RAM size)
	db	$01	; 512 * 4 bytes

	; $014A (Destination code)
	db	$01	; Definitely not Japanese

	; $014B (Licensee code - this _must_ be $33)
	db	$33	; $33 - Check $0144/$0145 for Licensee code.

	; $014C (Mask ROM version - handled by RGBFIX)
	db	$00

	; $014D (Complement check - handled by RGBFIX)
	db	$00

	; $014E-$014F (Cartridge checksum - handled by RGBFIX)
	dw	$00