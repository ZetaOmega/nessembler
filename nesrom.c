#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "nesrom.h"
#include "block.h"
#include "assembledebug.h"

static const unsigned int NESROM_MAX_TABLE = 8;
//defined in main.c
extern char assembleDebugFlag;

struct nesROM* createNESROM()
{
    struct nesROM* rom = malloc(sizeof(struct nesROM));
    rom->header.nes0 = 'N';
    rom->header.nes1 = 'E';
    rom->header.nes2 = 'S';
    rom->header.nes3 = 0x1A;
    rom->header.rom_banks = 2;
    rom->header.vrom_banks = 0;
    rom->header.mirror_hi_mapper_lo = 0;
    rom->header.mapper_hi = 0;
    rom->header.ram_banks = 1;
    rom->header.country_code = 0;
    rom->header.byte10 = 0;
    rom->header.byte11 = 0;
    rom->header.byte12 = 0;
    rom->header.byte13 = 0;
    rom->header.byte14 = 0;
    rom->header.byte15 = 0;
    rom->ntables = 0;
    rom->tables = malloc(sizeof(struct blocktable*) * NESROM_MAX_TABLE);
    return rom;
}

void writeBlockTableToNESROM(struct nesROM* rom, struct blocktable* bt)
{
    if(!bt) return;
    if(!rom) return;
    unsigned int i = rom->ntables;
    if(rom->ntables + 1 > NESROM_MAX_TABLE)
    {
        fprintf(stderr, "Exceeded rom table limit\n");
        exit(1);
    }
    memcpy(rom->tables + i, &bt, sizeof(struct blocktable*));
    rom->ntables++;
}

void writeNESROMToFile(struct nesROM* rom, const char* file_name)
{
    if(!rom) return;
    if(!file_name) return;
    FILE* romFile  = fopen(file_name, "wb");
    if(!romFile)
    {
        fprintf(stderr, "Unable to open output file '%s'\n", file_name);
        exit(1);
    }
    unsigned int tablei = 0;
    const unsigned int tmpbuf_max_size = 512;
    unsigned char tmpbuf[tmpbuf_max_size];
    unsigned int tmpbuf_size = 0;
    unsigned int datai;
    struct blocktable* bt = 0;

    FILE* debugFile = 0;
    struct debugrec* db_rec = 0;
    if(assembleDebugFlag)
    {
        strcpy(tmpbuf, file_name);
        strcat(tmpbuf, ".debug");
        printf("Created NES ROM debug file '%s'\n", tmpbuf);
        debugFile = fopen(tmpbuf, "w");
        if(!debugFile)
        {
            fprintf(stderr, "Unable to open debug file '%s'\n", tmpbuf);
            exit(1);
        }
        fprintf(debugFile, "Debug NES ROM file for '%s'\n", file_name);
    }

    tmpbuf_size = sizeof(struct nesROMheader);
    memcpy(tmpbuf, &(rom->header), tmpbuf_size);
    fwrite(tmpbuf, tmpbuf_size, 1, romFile);

    while(tablei < rom->ntables) //Iterate through each block table
    {
        struct blockrec* rec;
        memcpy(&bt, rom->tables + tablei, sizeof(struct blocktable*));
        rec = bt->first;
        while(rec != 0) //Iterate through each block record
        {
            struct block* bl;
            bl = rec->bl;
            if(debugFile)
            {
                db_rec = bl->debug;
                fprintf(debugFile, "file address 0x%06X, rom address 0x%04X, src line %d: ", (unsigned int)ftell(romFile), (unsigned int)bl->address, (int)(db_rec->line_number));
            }
            switch(bl->blocktype)
            {
                case BLOCKTYPE_INSTR8:
                    tmpbuf[0] = bl->block.i8->opcode;
                    if(debugFile)
                    {
                        //Print instruction name
                        fprintf(debugFile, "%s", db_rec->instruction_name);
                    }
                    switch(bl->block.i8->operandtype)
                    {
                        case OPERANDTYPE_NONE:
                            tmpbuf_size = sizeof(unsigned char); //size of opcode
                        break;
                        case OPERANDTYPE_BYTE:
                            tmpbuf[1] = bl->block.i8->operand.byte;
                            if(debugFile)
                            {
                                //Print byte operand of instruction
                                fprintf(debugFile, db_rec->format_str, tmpbuf[1]);
                            }
                            tmpbuf_size = sizeof(unsigned char) + sizeof(unsigned char);
                        break;
                        case OPERANDTYPE_WORD:
                            memcpy(tmpbuf + 1, &(bl->block.i8->operand.word), sizeof(unsigned short));
                            if(debugFile)
                            {
                                //Print word operand of instruction
                                fprintf(debugFile, db_rec->format_str, (unsigned short)((tmpbuf[2] << 8) | tmpbuf[1]));
                            }
                            tmpbuf_size = sizeof(unsigned char) + sizeof(unsigned short);
                        break;
                    }
                    if(debugFile)
                    {
                        fprintf(debugFile, " (opcode 0x%02X + %d bytes)", tmpbuf[0], tmpbuf_size - 1);
                    }
                break;
                case BLOCKTYPE_DATA:
                    if(debugFile)
                    {
                        fprintf(debugFile, "data block of 0x%04X bytes ending at file address 0x%04X",
                            (unsigned int)(bl->block.dblock->size), (unsigned int)(ftell(romFile) + bl->block.dblock->size - 1));
                    }
                    datai = 0;
                    if(bl->block.dblock->size > tmpbuf_max_size)
                    {
                        while(datai < bl->block.dblock->size - tmpbuf_max_size)
                        {
                            memcpy(tmpbuf, bl->block.dblock->data + datai, tmpbuf_max_size);
                            fwrite(tmpbuf, tmpbuf_max_size, 1, romFile);
                            datai += tmpbuf_max_size;
                        }
                    }
                    tmpbuf_size = bl->block.dblock->size - datai;
                    memcpy(tmpbuf, bl->block.dblock->data + datai, tmpbuf_size);
                break;
            }
            fwrite(tmpbuf, tmpbuf_size, 1, romFile);
            if(debugFile)
            {
                fprintf(debugFile, "\n");
            }
            rec = rec->next;
        }
        tablei++;
    }
    fclose(romFile);
    if(debugFile)
    {
        fclose(debugFile);
    }
    printf("Wrote NES ROM '%s'\n", file_name);
}

void freeNESROM(struct nesROM* rom)
{
    if(!rom) return;
    struct blocktable* bt;
    unsigned int tablei = 0;
    while(tablei < rom->ntables) //Iterate through each block table
    {
        memcpy(&bt, rom->tables + tablei, sizeof(struct blocktable*));
        freeBlockTable(bt, 1);
        tablei++;
    }
    free(rom->tables);
    free(rom);
}
