#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bel.h"
#include "symbol.h"
#include "block.h"

struct BEL* createBEL(int malloc_size)
{
    struct BEL* bel = malloc(sizeof(struct BEL));
    bel->malloc_size = malloc_size;
    bel->size = 0;
    bel->eval_type = BELEVALTYPE_BYTE;
    bel->operands = malloc(sizeof(struct BELoperand) * malloc_size);
    return bel;
}

void addBELbyte(struct BEL* bel, char operatorc, unsigned char byte)
{
    if(!bel) return;
    unsigned int pos = bel->size;
    if(pos + 1 > bel->malloc_size)
    {
        #ifdef DEBUG
            printf("increasing size of bel malloc from %d to %d\n", bel->malloc_size, bel->malloc_size + BEL_LARGE_MALLOC_SIZE);
        #endif
        bel->malloc_size += BEL_LARGE_MALLOC_SIZE;
        bel->operands = realloc(bel->operands, sizeof(struct BELoperand) * bel->malloc_size);
    }
    (bel->operands + pos)->operatorc = operatorc;
    (bel->operands + pos)->type = BELOPERANDTYPE_BYTE;
    (bel->operands + pos)->value.byte = byte;
    bel->size++;
}

void addBELword(struct BEL* bel, char operatorc, unsigned short word)
{
    if(!bel) return;
    unsigned int pos = bel->size;
    if(pos + 1 > bel->malloc_size)
    {
        #ifdef DEBUG
            printf("increasing size of bel malloc from %d to %d\n", bel->malloc_size, bel->malloc_size + BEL_LARGE_MALLOC_SIZE);
        #endif
        bel->malloc_size += BEL_LARGE_MALLOC_SIZE;
        bel->operands = realloc(bel->operands, sizeof(struct BELoperand) * bel->malloc_size);    
    }
    (bel->operands + pos)->operatorc = operatorc;
    (bel->operands + pos)->type = BELOPERANDTYPE_WORD;
    (bel->operands + pos)->value.word = word;
    bel->size++;
}

void addBELsym(struct BEL* bel, char operatorc, struct symbol* sym)
{
    if(!bel) return;
    if(!sym) return;
    unsigned int pos = bel->size;
    if(pos + 1 > bel->malloc_size)
    {
        #ifdef DEBUG
            printf("increasing size of bel malloc from %d to %d\n", bel->malloc_size, bel->malloc_size + BEL_LARGE_MALLOC_SIZE);
        #endif
        bel->malloc_size += BEL_LARGE_MALLOC_SIZE;
        bel->operands = realloc(bel->operands, sizeof(struct BELoperand) * bel->malloc_size);
    }
    (bel->operands + pos)->operatorc = operatorc;
    (bel->operands + pos)->type = BELOPERANDTYPE_SYMBOL;
    (bel->operands + pos)->value.sym = sym;
    bel->size++;
}

char* getBELstring(struct BEL* bel)
{
    static char buf[1024];
    if(!bel) return "";
    struct symbol* sym;
    struct BELoperand* operand;
    char tmpbuf[256];
    int i = 0;
    buf[0] = 0;
    while(i < bel->size)
    {
        operand = bel->operands + i;
        snprintf(tmpbuf, sizeof(tmpbuf), "%c ", operand->operatorc);
        strncat(buf, tmpbuf, sizeof(buf));
        switch(operand->type)
        {
            case BELOPERANDTYPE_BYTE:
                snprintf(tmpbuf, sizeof(tmpbuf), "0x%02X", operand->value.byte);
            break;
            case BELOPERANDTYPE_WORD:
                snprintf(tmpbuf, sizeof(tmpbuf), "0x%04X", operand->value.word);
            break;
            case BELOPERANDTYPE_SYMBOL:
                sym = operand->value.sym;
                switch(sym->symtype)
                {
                    case SYMBOLTYPE_VALUE8:
                        snprintf(tmpbuf, sizeof(tmpbuf), "0x%02X", sym->symvalue.value8);
                    break;
                    case SYMBOLTYPE_VALUE16:
                        snprintf(tmpbuf, sizeof(tmpbuf), "0x%04X", sym->symvalue.value16);
                    break;
                    case SYMBOLTYPE_ADDRESS16:
                        snprintf(tmpbuf, sizeof(tmpbuf), "0x%04X", sym->symvalue.address16);
                    break;
                }
            break;
        }
        strncat(buf, tmpbuf, sizeof(buf));
        i++;
    }
    return buf;
}

int markUndefinedRef(struct BEL* bel, struct block* blk)
{
    if(!bel) return;
    unsigned int numRef = 0;
    unsigned int i = 0;
    struct BELoperand* operand;
    struct symbol* sym;
    for(;i < bel->size; i++)
    {
        operand = bel->operands + i;    
        if(operand->type == BELOPERANDTYPE_SYMBOL)
        {
            sym = operand->value.sym;
            if(!sym->defined)
            {
                addForwardRef(sym, blk);
                numRef++;
            }
        }
    }
    return numRef;
}

char evaluateBEL(struct BEL* bel, unsigned short* result, char* eval_type)
{
    if(!bel) return;
    char eval_result = BELEVALRESULT_GOOD;
    unsigned int value;
    unsigned int i = 0;
    struct BELoperand* operand;
    struct symbol* sym;
    (*result) = 0;
    //Iterate through each operand in the expression
    for(;i < bel->size; i++)
    {
        operand = bel->operands + i;
        switch(operand->type)
        {
            case BELOPERANDTYPE_BYTE:
                value = operand->value.byte;
            break;
            case BELOPERANDTYPE_WORD:
                value = operand->value.word;
            break;    
            case BELOPERANDTYPE_SYMBOL:
                sym = operand->value.sym;
                if(sym->defined)
                {
                    switch(sym->symtype)
                    {
                        case SYMBOLTYPE_VALUE8:
                            value = sym->symvalue.value8;
                        break;
                        case SYMBOLTYPE_VALUE16:
                            value = sym->symvalue.value16;
                        break;
                        case SYMBOLTYPE_ADDRESS16:
                            value = sym->symvalue.address16;
                        break;
                    }
                }
                else
                {
                    //Undefined symbol in the expression, can't evaluate
                    eval_result = BELEVALRESULT_UNDEFINED_SYMBOL;
                }
            break; 
        }
        if(eval_result == BELEVALRESULT_UNDEFINED_SYMBOL)
        {
            (*result) = 0;
            break; //Stop iterating through expression
        }
        switch(operand->operatorc)
        {
            case '+': (*result) += value; break;
            case '-': (*result) -= value; break;
            case '*': (*result) *= value; break;
            case '/': (*result) /= value; break;
            case '|': (*result) |= value; break;
            case '&': (*result) &= value; break;
            case '=': (*result) = value; break;
        }
    }
    if(eval_type)
    {
        *eval_type = bel->eval_type;
    }
    return eval_result;
}

void printBEL(struct BEL* bel)
{
    if(!bel) return;
    unsigned int i = 0;
    struct BELoperand* operand;
    struct symbol* sym;
    printf("BEL (size %d):\n", bel->size);
    for(;i < bel->size; i++)
    {
        operand = bel->operands + i;
        printf("    BEL operator '%c' ", operand->operatorc);
        switch(operand->type)
        {
            case BELOPERANDTYPE_BYTE:
                printf("byte value 0x%02X", operand->value.byte);
            break;    
            case BELOPERANDTYPE_WORD:
                printf("word value 0x%04X", operand->value.word);
            break;    
            case BELOPERANDTYPE_SYMBOL:
                sym = operand->value.sym;
                switch(sym->symtype)
                {
                    case SYMBOLTYPE_VALUE8:
                        printf("symbol '%s' -> 8-bit value 0x%02X", sym->symname, sym->symvalue.value8);
                    break;
                    case SYMBOLTYPE_VALUE16:
                        printf("symbol '%s' -> 16-bit value 0x%04X", sym->symname, sym->symvalue.value16);
                    break;
                    case SYMBOLTYPE_ADDRESS16:
                        printf("symbol '%s' -> 16-bit address 0x%04X", sym->symname, sym->symvalue.address16);
                    break;
                }
            break;    
        }
        printf("\n");
    }
}

void freeBEL(struct BEL* bel)
{
    if(!bel) return;
    if(bel->operands) free(bel->operands);
    free(bel);        
}
