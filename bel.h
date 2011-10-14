#ifndef BEL_H
#define BEL_H

//BEL - Binary Expression List

#define BELOPERANDTYPE_BYTE   0x00
#define BELOPERANDTYPE_WORD   0x01
#define BELOPERANDTYPE_SYMBOL 0x02

struct symbol;
struct block;

struct BELoperand
{
    char operatorc;
    char type;
    union
    {
        unsigned char byte;
        unsigned short word;
        struct symbol* sym;
    } value;
};

#define BELEVALTYPE_BYTE     0x00
#define BELEVALTYPE_WORD     0x01
#define BELEVALTYPE_REL_ADDR 0x02

struct BEL
{
    unsigned int malloc_size;
    unsigned int size;
    char eval_type;
    struct BELoperand* operands; //array
};

#define BEL_SMALL_MALLOC_SIZE 4
#define BEL_LARGE_MALLOC_SIZE 16

struct BEL* createBEL(int malloc_size);
void addBELbyte(struct BEL* bel, char operatorc, unsigned char byte);
void addBELword(struct BEL* bel, char operatorc, unsigned short word);
void addBELsym(struct BEL* bel, char operatorc, struct symbol* sym);

char* getBELstring(struct BEL* bel);

#define BELEVALRESULT_GOOD             0x00
#define BELEVALRESULT_UNDEFINED_SYMBOL 0x01

//Examines the BEL for undefined symbols, and adds the indicated block to the forward reference table of each
//Returns number of undefined references in the expression
int markUndefinedRef(struct BEL* bel, struct block* blk);

//Returns evaluation result
char evaluateBEL(struct BEL* bel, unsigned short* result, char* eval_type);

void printBEL(struct BEL* bel);

void freeBEL(struct BEL* bel);

#endif

