#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.epilogue.h"
#include "assembledebug.h"
#include "block.h"
#include "enum6502.h"

//defined in scanner.l
extern char error_buf[256];

//defined in parser.y
extern unsigned long cur_addr;

//defined in main.c
extern char assembleDebugFlag;

int checkOpcode(unsigned char opcode)
{
    if(opcode == IN6502_INVALID_OPCODE)
    {
        return 0;
    }
    return 1;
}

void checkOpcodeOrDie(unsigned char opcode, const char* addressModeName, unsigned int line_number)
{
    if(opcode == IN6502_INVALID_OPCODE)
    {
        sprintf(error_buf, "fatal error: illegal addressing mode: %s", addressModeName);
        bisonError(error_buf, line_number);
        exit(1);
    }
}

//Returns true if the difference between the given to_addr and from_addr is within the relative addressing range
//addr_diff is set to the byte difference
int calcAddressRange(unsigned short* addr_diff, unsigned short from_addr, unsigned short to_addr)
{
    (*addr_diff) = to_addr - from_addr;
    //printf("diff is %04X - %04X = %04X\n", to_addr, from_addr, *addr_diff);
    return ((signed short)(*addr_diff) <= 127) && ((signed short)(*addr_diff) >= -128);
}

struct blocktable* advanceAddress(struct blocktable* bt, unsigned short new_addr, unsigned int line_number)
{
    unsigned short addr_diff = new_addr - cur_addr;
    if(!bt)
    {
        bisonError("Unable to advance address on nonexistent bank", line_number);
        exit(1);
    }
    if(addr_diff < 0)
    {
        sprintf(error_buf, "fatal error: advance directive move to previous position");
        bisonError(error_buf, line_number);
        exit(1);
    }
    #ifdef DEBUG
        printf("line %d: 0x%04X: advance to address 0x%04X\n", line_number, (unsigned short)(cur_addr), new_addr);
    #endif
    struct block* bl = createBlockData(&bl, &cur_addr, addr_diff, addr_diff);
    memset(bl->block.dblock->data, 0, addr_diff); //Set all bytes in between addresses to 0
    if(assembleDebugFlag) bl->debug = createDebugRecord(line_number, 0, "");
    addBlock(bt, bl);
    return bt;
}

void bisonError(const char* msg, unsigned int line_number)
{
    fprintf(stderr, "%s : line %d\n", msg, line_number);
}

