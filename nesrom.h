#ifndef NESROM_H
#define NESROM_H

struct blocktable;

struct nesROMheader
{
    unsigned char nes0;
    unsigned char nes1;
    unsigned char nes2;
    unsigned char nes3;
    unsigned char rom_banks;
    unsigned char vrom_banks;
    unsigned char mirror_hi_mapper_lo;
    unsigned char mapper_hi;
    unsigned char ram_banks;
    unsigned char country_code;
    unsigned char byte10;
    unsigned char byte11;
    unsigned char byte12;
    unsigned char byte13;
    unsigned char byte14;
    unsigned char byte15;
};

struct nesROM
{
    struct nesROMheader header;
    unsigned int ntables;
    struct blocktable** tables;
};

struct nesROM* createNESROM();
void writeBlockTableToNESROM(struct nesROM* rom, struct blocktable* bt);
void writeNESROMToFile(struct nesROM* rom, const char* file_name);
void freeNESROM(struct nesROM* rom);

#endif

