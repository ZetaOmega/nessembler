#ifndef SYMBOL_H
#define SYMBOL_H

#define SYMBOLTYPE_VALUE8    0x00
#define SYMBOLTYPE_VALUE16   0x01 
#define SYMBOLTYPE_ADDRESS16 0x02

struct blocktable;
struct block;

struct symbol
{
    char* symname;
    char defined;
    char symtype;
    union
    {
        unsigned char  value8;
        unsigned short value16;
        unsigned short address16;
    } symvalue;
    struct blocktable* frtable; //forward reference table
};


struct symtable
{
    unsigned int size;
    unsigned int max_size;
    struct symbol* syms;
};

struct symtable* createSymbolTable();

struct symbol* findSymbol(struct symtable* table, char* name);
struct symbol* addSymbol(struct symtable* table, struct symbol* newsym);

//Adds the indicated block to the forward reference table
//When resolveForwardRef is called, the value of all blocks in this table will be updated
void addForwardRef(struct symbol* sym, struct block* blk);

int resolveForwardRef(struct symbol* sym, char* error_buf, int buf_size);

struct symbol* createSymbol(struct symbol** s, struct symtable* table, char* symname, char symtype);

void emptySymTable(struct symtable* table);
void freeSymTable(struct symtable* table);

#endif

