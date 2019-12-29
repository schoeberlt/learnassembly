;	hello.asm
;	turns on an LED which is connected to PB5 (digital out 13)
;	Written by Tamas Schöberl
;	12/24/2019



.ORG 0x000
.device ATMega328P
.equ DDRB = 0x04
.equ PortB = 0x05

ldi r18, 0b00000000
ldi r16, 0b00000000

Delay:
	ldi r17, 0b00011111

Outer:
	ldi r24, 0b11111111
	ldi r25, 0b01111111
	;ldi r24, 0b00000000
	;ldi r25, 0b00000000

Delay05:
	adiw r24, 1
	brne Delay05
	dec r17
	brne Outer
	cp r16, r18
	brne On
	rjmp Off

Off:
	ldi r16, 0b00000000
	out DDRB, r16
	out PortB, r16
	ldi r16, 0b00100000
	rjmp Delay

On:
	ldi r16, 0b00100000
	out DDRB, r16
	out PortB, r16
	ldi r16, 0b00000000
	rjmp Delay
Start:
	rjmp Start

