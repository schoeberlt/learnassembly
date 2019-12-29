;	blinktimer.asm
;	This code blinks an LED on PB5 every second
;	This time by using timers
;
;	Created by Tamas Schöberl
;	28/12/2019

.device ATMega328P

.def temp = r16
.def overflows = r17

.equ DDRB = 0x04
.equ PORTB = 0x05
.equ TCCR0B = 0x25
.equ TCNT0 = 0x26
.equ TIMSK0 = 0x6E

.org 0x0000
rjmp Reset

.org 0x0020
rjmp overflow_handler

Reset:
	ldi temp, 0b00000101
	out TCCR0B, temp 	;This sets the timer to the speed of Clock/1024

	ldi temp, 0b00000001	;Enables Timer Interrupt
	sts TIMSK0, temp

	sei			;Enables Global Interrupt

	clr temp
	out TCNT0, temp		;Start Timer
	sbi DDRB, 5

blink:
	sbi PORTB, 5
	rcall delay
	cbi PORTB, 5
	rcall delay
	rjmp blink



delay:
	clr overflows
	sec_count:
		cpi overflows, 30
	brne sec_count
	ret


overflow_handler:
	inc overflows
	cpi overflows, 0b00111111	;Test for 61 overflows
	brne PC+2
	clr overflows
	reti


