%.hex: %.asm
	avra -fI $<
	rm *.eep.hex *.obj

all: $(patsubst %.asm,%.hex,$(wildcard *.asm))

upload: ${program}.hex
	avrdude -p m328p -c stk500v1 -b 57600 -P /dev/ttyUSB0 -U flash:w:$<

monitor:
	picocom --send-cmd "ascii_xfr -s -v -l10" --nolock /dev/ttyUSB0

.PHONY: all upload monitor
