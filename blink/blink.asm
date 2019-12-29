;	hello.asm
;	turns on an LED which is connected to PB5 (digital out 13)
;	Written by Tamas Schöberl
;	12/24/2019



.org 0x0000
.device ATMega328P
.equ DDRB = 0x04
.equ PortB = 0x05
.equ RAMEND = 0x08ff
.equ SPL = 0x3d
.equ SPH = 0x3e


rjmp main

main:
	ldi r16, low(RAMEND)
	out SPL, r16
	ldi r16, high(RAMEND)
	out SPH, r16

	ldi r16, 0xFF
	out DDRB, r16

loop:
	sbi PortB, 5
	rcall delay_05
	cbi PortB, 5
	rcall delay_05
	rjmp loop

delay_05:
	ldi r16, 64

outer_loop:

	ldi r24, low(3037)
	ldi r25, high(3037)

delay_loop:
	adiw r24, 1
	brne delay_loop

	dec r16
	brne outer_loop
	ret
