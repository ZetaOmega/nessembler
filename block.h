#ifndef BLOCK_H
#define BLOCK_H

#define MAX_BANKS 8

#define OPERANDTYPE_NONE   0x00
#define OPERANDTYPE_BYTE   0x01
#define OPERANDTYPE_WORD   0x02
#define OPERANDTYPE_BEL    0x03

struct symbol;
struct BEL;

//8-bit instruction block
struct instr8
{
    unsigned char opcode;
    char operandtype;
    union
    {
        unsigned char byte;
        unsigned short word;
        struct BEL* bel;
    } operand;
};

//16-bit instruction block
struct instr16
{
    unsigned short opcode;
    char operand1type;
    char operand2type;
    union
    {
        unsigned short byte;
        unsigned short word;
        struct BEL* bel;
    } operand1;
    union
    {
        unsigned short byte;
        unsigned short word;
        struct BEL* bel;
    } operand2;
};

//Arbitrary data block
struct datablock
{
    unsigned long size;    
    unsigned long malloc_size;    
    char* data;
};

#define BLOCKTYPE_UNKNOWN  0x00
#define BLOCKTYPE_INSTR8   0x01
#define BLOCKTYPE_INSTR16  0x02
#define BLOCKTYPE_DATA     0x03 

struct debugrec;
struct block
{
    unsigned long address;
    char blocktype;
    union
    {
        struct instr8*  i8;
        struct instr16* i16;
        struct datablock* dblock;
    } block;
    struct debugrec* debug;
};

struct blockrec;
struct blockrec
{
    struct block*    bl;
    struct blockrec* next;
};
struct blocktable
{
    struct blockrec* first;
    struct blockrec* last;
};

struct blocktable* createBlockTable();

void addBlock(struct blocktable* table, struct block* newblock);
void addBlockTable(struct blocktable* table, struct blocktable* newblocktable);

struct block* createBlocki8(struct block** b, unsigned long* address, unsigned char opcode, char operandtype, struct BEL* bel);
struct block* createBlocki16(struct block** b, unsigned long* address, unsigned short opcode, char operand1type, char operand2type,
    struct BEL* bel1, struct BEL* bel2);
struct block* createBlockData(struct block** b, unsigned long* address, int malloc_size, int size);

int countBlockTable(struct blocktable* table);
void printBlocks(struct blocktable* table);

void freeBlockTable(struct blocktable* table, char freeBlocks);

#endif //BLOCK_H

