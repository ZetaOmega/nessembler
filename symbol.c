#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol.h"
#include "block.h"
#include "bel.h"

static const int SYMBOLTABLE_MAX_SIZE = 1024;

struct symtable* createSymbolTable()
{
    struct symtable* st = malloc(sizeof(struct symtable));
    st->size = 0;
    st->max_size = SYMBOLTABLE_MAX_SIZE;
    st->syms = malloc(sizeof(struct symbol) * st->max_size);
    return st;
}

struct symbol* findSymbol(struct symtable* table, char* name)
{
    struct symbol* sym = 0;
    if(table)
    {
        unsigned int i = 0;
        while(i < table->size)
        {
            sym = table->syms + i;
            if(!strcmp(sym->symname, name))
            {
                return sym;
            }
            i++;
        }
    }
    return 0;
}

struct symbol* addSymbol(struct symtable* table, struct symbol* newsym)
{
    struct symbol* sym;
    if(table)
    {
        unsigned int i = table->size;
        if(table->size + 1 > table->max_size)
        {
            fprintf(stderr, "Symbol table size limit exceeded\n");
            exit(1);
        }
        sym = table->syms + i;
        memcpy(sym, newsym, sizeof(struct symbol));
        table->size++;
    }
    return sym;
}

void addForwardRef(struct symbol* sym, struct block* blk)
{
    if(!sym) return;
    if(!sym->frtable)
    {
        sym->frtable = createBlockTable();
    }
    addBlock(sym->frtable, blk);
}

int resolveForwardRef(struct symbol* sym, char* error_buf, int buf_size)
{
    if(!sym) return 0;
    int resolve_status = 0;
    struct blocktable* fref = sym->frtable;
    if(fref)
    {
        #ifdef DEBUG
            printf("resolving unknown references to '%s':\n", sym->symname);
        #endif
        struct BEL* bel;
        unsigned short addr_diff;
        unsigned short result;
        char eval_type;
        char eval_result;
        unsigned short cur_addr = sym->symvalue.address16;
        unsigned short rel_addr;
        struct blockrec* rec = fref->first;
        struct block* bl = 0;
        while(rec && rec->bl)
        {
            bl = rec->bl;
            #ifdef DEBUG
                printf("    address 0x%04X", (unsigned short)bl->address);
            #endif
            switch(bl->blocktype)
            {
                case BLOCKTYPE_INSTR8: //8-bit instruction
                    bel = bl->block.i8->operand.bel;
                    eval_result = evaluateBEL(bel, &result, &eval_type);
                    if(eval_result == BELEVALRESULT_GOOD)
                    {
                        switch(eval_type)
                        {
                            case BELEVALTYPE_BYTE:
                                #ifdef DEBUG
                                    printf(", resolve to byte 0x%02X\n", result & 0xFF);
                                #endif
                                bl->block.i8->operandtype = OPERANDTYPE_BYTE;
                                bl->block.i8->operand.byte = result & 0xFF;
                            break;
                            case BELEVALTYPE_WORD:
                                #ifdef DEBUG
                                    printf(", resolve to word 0x%04X\n", result);
                                #endif
                                bl->block.i8->operandtype = OPERANDTYPE_WORD;
                                bl->block.i8->operand.word = result;
                            break;
                            case BELEVALTYPE_REL_ADDR:
                                rel_addr = (unsigned short)(bl->address & 0xFFFF)
                                           + sizeof(bl->block.i8->opcode) + sizeof(unsigned char);
                                if(calcAddressRange(&addr_diff, rel_addr, cur_addr))
                                {
                                    #ifdef DEBUG
                                        printf(", resolve to relative address 0x%04X - 0x%04X = 0x%02X\n", (unsigned short)cur_addr, rel_addr, (unsigned char)(addr_diff & 0xFF));
                                    #endif
                                    bl->block.i8->operandtype = OPERANDTYPE_BYTE;
                                    bl->block.i8->operand.byte = addr_diff & 0xFF;
                                }
                                else
                                {
                                    //Out of range
                                    snprintf(error_buf, buf_size, "fatal error: branch address out of range: 0x%04X", (unsigned short)(addr_diff & 0xFFFF));
                                    return 1;
                                }
                            break;
                        }
                        freeBEL(bel);
                    }
                    else
                    {
                        #ifdef DEBUG
                            printf(", resolution failed\n");
                        #endif
                        resolve_status = 1; //Expression could not be resolved because some symbol is still undefined
                    }
                break;
                case BLOCKTYPE_INSTR16: //16-bit instruction
                break;
                case BLOCKTYPE_DATA: //word define
                    #ifdef DEBUG
                        printf("    at 0x%04X: word = 0x%04X\n", (unsigned short)bl->address, (unsigned short)cur_addr);
                    #endif
                    bl->block.dblock->data[0] = cur_addr & 0xFF; //LSB
                    bl->block.dblock->data[1] = (cur_addr >> 8) & 0xFF;
                break;
            }
            rec = rec->next;
        }
        freeBlockTable(fref, 0); //Free the fref table, but don't free the blocks associated with the table
        sym->frtable = 0;
    }
    return resolve_status;
}

struct symbol* createSymbol(struct symbol** s, struct symtable* table, char* symname, char symtype)
{
    struct symbol sym;
    sym.symname = malloc(sizeof(char) * strlen(symname) + sizeof('\0'));
    strcpy(sym.symname, symname);
    #ifdef DEBUG
        //printf("allocating symbol %s\n", (*s)->symname);
    #endif
    sym.defined = 1;
    sym.symtype = symtype;
    sym.frtable = 0;
    (*s) = addSymbol(table, &sym);
    return (*s);
}

void emptySymTable(struct symtable* table)
{
    if(table)
    {
        struct symbol* sym;
        unsigned int i = 0;
        while(i < table->size)
        {
            sym = table->syms + i;
            if(sym->symname)
            {
                free(sym->symname);
                sym->symname = 0;
            }
            freeBlockTable(sym->frtable, 0); //Don't free blocks associated with table
            sym->frtable = 0;
            i++;
        }
        table->size = 0;    
    }    
}


void freeSymTable(struct symtable* table)
{
    if(table)
    {
        struct symbol* sym;
        unsigned int i = 0;
        while(i < table->size)
        {
            sym = table->syms + i;
            if(sym->symname)
            {
                free(sym->symname);
                sym->symname = 0;
            }
            freeBlockTable(sym->frtable, 0); //Don't free blocks associated with table
            sym->frtable = 0;
            i++;
        }
        free(table->syms);
        free(table);
    }
}

