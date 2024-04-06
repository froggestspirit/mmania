.PHONY: all compare

objects := main.o

all: mm.gb compare
compare: baserom.gb mm.gb
	cmp $^

%.o: %.asm
	rgbasm -o $@ $<

mm.gb: $(objects)
	rgblink -n mm.sym -m mm.map -p 0xFF -o $@ $^
	rgbfix -p 0xFF -v $@