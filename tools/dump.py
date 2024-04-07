
from struct import unpack

tilesets = []
with open("../baserom.gb", "rb") as infile:
    pointer_offset = 0x8CDC
    for ts in range(0x68):
        infile.seek(pointer_offset)
        pointer_offset += 2
        ts_offset = unpack("<H", infile.read(2))[0] + 0x4000
        #print(f"\nTileset_{ts:02X}:")
        infile.seek(ts_offset,)
        ts_offset += 1
        chunks = unpack("<B", infile.read(1))[0]
        #print(f"\tdb ${chunks:02X}")
        for chunk in range(chunks):
            infile.seek(ts_offset)
            ts_offset += 7
            bank, source, dest, size = unpack("<BHHH", infile.read(7))
            rom_source = ((bank - 1) * 0x4000) + source
            #print(f"\tdbw Tileset_0x{rom_source:06X}")
            #print(f"\tdw ${dest:04X}")
            #print(f"\tdw ${size:04X}")
            #print(f"dd ibs=1 count=$((0x{size:04X})) skip=$((0x{rom_source:06X})) if=baserom.gb of=gfx/tilesets/tileset_0x{rom_source:06X}.2bpp")
            if (rom_source, size) not in tilesets:
                tilesets.append((rom_source, size))
tilesets.sort()
for ts in tilesets:
    #print(f"Tileset_0x{ts[0]:06X}:\nINCBIN \"gfx/tilesets/tileset_0x{ts[0]:06X}.2bpp\"  ; ${ts[0]:06X} - ${ts[0] + ts[1]:06X}")
    print(f"dd ibs=1 count=$((0x{ts[1]:04X})) skip=$((0x{ts[0]:06X})) if=baserom.gb of=gfx/tilesets/tileset_0x{ts[0]:06X}.2bpp")
