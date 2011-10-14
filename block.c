#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "block.h"
#include "symbol.h"
#include "bel.h"
#include "assembledebug.h"

struct blocktable* createBlockTable()
{
    struct blocktable* bt = malloc(sizeof(struct blocktable));
    bt->first = 0;
    bt->last = 0;
    return bt;
}

void addBlock(struct blocktable* table, struct block* newblock)
{
    #ifdef DEBUG
        //static int calls;
    #endif
    if(table && newblock)
    {
        #ifdef DEBUG
            //calls++;
            //printf("addBlock calls: %d\n", calls);
        #endif
        struct blockrec* rec = malloc(sizeof(struct blockrec));
        rec->bl = newblock;
        rec->next = 0;
        if(table->last)
        {
            table->last->next = rec;
        }
        else
        {
            table->first = rec;
        }
        table->last = rec;
    }
}

void addBlockTable(struct blocktable* table, struct blocktable* newblocktable)
{
    if(table && newblocktable)
    {
        if(table->last)
        {
            table->last->next = newblocktable->first;
        }
        else
        {
            table->first = newblocktable->first;    
        }
        table->last = newblocktable->last;
        //free(newblocktable);
    }
}

struct block* createBlocki8(struct block** b, unsigned long* address, unsigned char opcode, char operandtype, struct BEL* bel)
{
    (*b) = malloc(sizeof(struct block));
    (*b)->address = *address;
    (*b)->blocktype = BLOCKTYPE_INSTR8;
    (*b)->block.i8 = malloc(sizeof(struct instr8));
    (*b)->block.i8->opcode = opcode;    
    (*b)->block.i8->operandtype = operandtype;
    (*b)->debug = 0;
    //Calculate offset
    (*address) += sizeof((*b)->block.i8->opcode);
    switch(operandtype)
    {
        case OPERANDTYPE_BYTE:
            (*address) += sizeof((*b)->block.i8->operand.byte);
        break;
        case OPERANDTYPE_WORD:
            (*address) += sizeof((*b)->block.i8->operand.word);
        break;
        case OPERANDTYPE_BEL:
            (*b)->block.i8->operand.bel = bel;
            switch(bel->eval_type)
            {
                case BELEVALTYPE_BYTE:
                case BELEVALTYPE_REL_ADDR:
                    (*address) += sizeof(unsigned char);
                break;
                case BELEVALTYPE_WORD:
                    (*address) += sizeof(unsigned short);
                break;
            }
        break;
        case OPERANDTYPE_NONE:
            //No operands
        break;
    }
    return (*b);
}

struct block* createBlocki16(struct block** b, unsigned long* address, unsigned short opcode, char operand1type, char operand2type,
    struct BEL* bel1, struct BEL* bel2)
{
    (*b) = malloc(sizeof(struct block));
    (*b)->address = *address;
    (*b)->blocktype = BLOCKTYPE_INSTR16;
    (*b)->block.i16 = malloc(sizeof(struct instr16));
    (*b)->block.i16->opcode = opcode;    
    (*b)->block.i16->operand1type = operand1type;
    (*b)->block.i16->operand2type = operand2type;
    (*b)->debug = 0;
    //Calculate offset        
    (*address) += sizeof((*b)->block.i16->opcode);
    switch(operand1type)
    {
        case OPERANDTYPE_BYTE:
            (*address) += sizeof((*b)->block.i16->operand1.byte);
        break;
        case OPERANDTYPE_WORD:
            (*address) += sizeof((*b)->block.i16->operand1.word);
        break;
        case OPERANDTYPE_BEL:
            (*b)->block.i16->operand1.bel = bel1;
            switch(bel1->eval_type)
            {
                case BELOPERANDTYPE_BYTE:
                    (*address) += sizeof(unsigned char);
                break;
                case BELOPERANDTYPE_WORD:
                    (*address) += sizeof(unsigned short);
                break;
            }
        break;
        case OPERANDTYPE_NONE:
            //No operands
        break;
    }
    switch(operand2type)
    {
        case OPERANDTYPE_BYTE:
            (*address) += sizeof((*b)->block.i16->operand2.byte);
        break;
        case OPERANDTYPE_WORD:
            (*address) += sizeof((*b)->block.i16->operand2.word);
        break;
        case OPERANDTYPE_BEL:
            (*b)->block.i16->operand2.bel = bel2;
            switch(bel2->eval_type)
            {
                case BELOPERANDTYPE_BYTE:
                    (*address) += sizeof(unsigned char);
                break;
                case BELOPERANDTYPE_WORD:
                    (*address) += sizeof(unsigned short);
                break;
            }
        break;
        case OPERANDTYPE_NONE:
            //No operands
        break;
    }
    return (*b);
}

struct block* createBlockData(struct block** b, unsigned long* address, int malloc_size, int size)
{
    (*b) = malloc(sizeof(struct block));
    (*b)->address = *address;
    (*b)->blocktype = BLOCKTYPE_DATA;
    (*b)->block.dblock = malloc(sizeof(struct datablock));
    (*b)->block.dblock->size = size;
    (*b)->block.dblock->malloc_size = malloc_size;
    (*b)->debug = 0;
    if(size)
    {
        (*b)->block.dblock->data = malloc(malloc_size);
    }
    else
    {
        (*b)->block.dblock->data = 0;
    }
    //Calculate offset        
    (*address) += size;
    return (*b);
}

int countBlockTable(struct blocktable* table)
{
    unsigned int num = 0;
    if(table)
    {
        struct blockrec* rec = table->first;
        while(rec)
        {
            num++;
            rec = rec->next;
        }
    }
    return num;
}

void printBlocks(struct blocktable* table)
{
    static char* blocktypestr[] =
        { "UNKNOWN", "INSTR8", "INSTR16", "DATA", 0 };
    if(table)
    {
        int blockind = 0;
        struct blockrec* rec = table->first;
        struct block* bl = 0;
        int i = 0;
        while(rec && rec->bl)
        {
            blockind++;
            bl = rec->bl;
            printf("    Block %d: address 0x%04X type %s", blockind, (unsigned short)(bl->address), blocktypestr[bl->blocktype]);
            switch(bl->blocktype)
            {
                case BLOCKTYPE_INSTR8:
                    switch(bl->block.i8->operandtype)
                    {
                        case OPERANDTYPE_NONE:
                            printf(", opcode 0x%02X", bl->block.i8->opcode);
                        break;
                        case OPERANDTYPE_BYTE:
                            printf(", opcode 0x%02X, byte 0x%02X", bl->block.i8->opcode, bl->block.i8->operand.byte);
                        break;
                        case OPERANDTYPE_WORD:
                            printf(", opcode 0x%02X, word 0x%04X", bl->block.i8->opcode, bl->block.i8->operand.word);
                        break;
                        case OPERANDTYPE_BEL:
                            printf(", opcode 0x%02X, bel '%s'", bl->block.i8->opcode, getBELstring(bl->block.i8->operand.bel));
                        break;
                    }
                break;
                case BLOCKTYPE_INSTR16:
                    printf("16-bit instruction");
                break;
                case BLOCKTYPE_DATA:
                    printf(", size %lu bytes", bl->block.dblock->size);
                    /*i = 0;
                    printf(" -> 0x%02X", (unsigned char)bl->block.dblock->data[i]);
                    for(i += 1; i < bl->block.dblock->size; i++)
                    {
                        printf(", 0x%02X", (unsigned char)bl->block.dblock->data[i]);
                    }*/
                break;
                case BLOCKTYPE_UNKNOWN:
                    printf("unknown instruction");
                break;
            }
            printf("\n");
            rec = rec->next;
        }
    }
}

void freeBlockTable(struct blocktable* table, char freeBlocks)
{
    if(table)
    {
        struct blockrec* recnext = 0;
        struct blockrec* rec = table->first;
        while(rec)
        {
            recnext = rec->next;
            if(freeBlocks && rec->bl)
            {
                switch(rec->bl->blocktype)
                {
                    case BLOCKTYPE_INSTR8:
                        if(rec->bl->block.i8->operandtype == OPERANDTYPE_BEL)
                        {
                            freeBEL(rec->bl->block.i8->operand.bel);    
                        }
                        free(rec->bl->block.i8);
                        rec->bl->block.i8 = 0;
                    break;
                    case BLOCKTYPE_INSTR16:
                        free(rec->bl->block.i16);
                        rec->bl->block.i16 = 0;
                    break;
                    case BLOCKTYPE_DATA:
                        free(rec->bl->block.dblock->data);
                        rec->bl->block.dblock->data = 0;
                        free(rec->bl->block.dblock);
                        rec->bl->block.dblock = 0;
                    break;    
                }
                free(rec->bl->debug);
                free(rec->bl);
                rec->bl = 0;
            }
            free(rec);
            rec = recnext;
        }
        table->first = 0;
        table->last = 0;
        free(table);
    }
}


