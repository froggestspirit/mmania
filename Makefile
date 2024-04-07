.PHONY: all compare

objects := main.o
GFX := $(patsubst %.png,%.2bpp,$(wildcard gfx/tilesets/*.png))

%.o: %.asm
	rgbasm -o $@ $<

%.2bpp: %.png
	rgbgfx -o $@ $<

all: $(GFX) mm.gb compare

compare: baserom.gb mm.gb
	cmp $^

clean:
	rm *.o $(GFX) mm.gb

mm.gb: $(objects)
	rgblink -n mm.sym -m mm.map -p 0xFF -o $@ $^
	rgbfix -p 0xFF -v $@
	