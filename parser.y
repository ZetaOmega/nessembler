%{
/* Prologue */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol.h"
#include "block.h"
#include "bel.h"
#include "enum6502.h"
#include "nesrom.h"
#include "assembledebug.h"

#include "parser.epilogue.h" //Helper functions are declared here

unsigned long cur_addr = 0; //Current address of assembly instruction in a bank as it scans the file

struct blocktable* currentBlockTable = 0;

//defined in main.c
extern struct symtable*   globalSymTable;
extern struct symtable*   localSymTable;
extern struct nesROM*     workingROM;
extern char* inputFileName;
extern char inputPath[];
extern char* outputFileName;
extern char assembleDebugFlag;
//defined in scanner.l
extern char string_buf[256];
extern char error_buf[256];
%}

/* Bison declarations */ 
%union
{
    int novalue;
    unsigned char byte;
    unsigned short word;
    struct symbol* sym;
    struct BEL* bel;
    struct block* bl;
    struct blocktable* bltable;
    /* The extended_token struct is used to store the line number
    that a token appears on, along with its value. This is used
    for outputing errors and debug statements. */
    struct extended_token
    {
        unsigned int line_number;
        union
        {
            unsigned char byte;
            unsigned short word;
            struct symbol* sym;
            struct BEL* bel;
        } value;
    } ex_tk;
}

/* Tokens */
%token <byte>    T_IMM_BYTE
%token <byte>    T_BYTE
%token <byte>    T_DECIMAL_BYTE
%token <word>    T_IMM_WORD
%token <word>    T_WORD
%token <word>    T_DECIMAL_WORD
%token <byte>    T_NAME
%token <sym>     T_DEFINED_SYMBOL
%token <sym>     T_UNDEFINED_SYMBOL
%token <novalue> T_VARIABLE_DECL
%token <ex_tk>   T_LABEL
%token <ex_tk>   T_INSTR8
%token <novalue> T_STRING_LITERAL
%token <novalue> T_COMMA
%token <novalue> T_COLON
%token <novalue> T_OPEN_PAREN
%token <novalue> T_CLOSE_PAREN
%token <novalue> T_OPEN_SQUARE
%token <novalue> T_CLOSE_SQUARE
%token <novalue> T_LEFT_ANGLE
%token <novalue> T_RIGHT_ANGLE
%token <ex_tk>   T_PLUS
%token <ex_tk>   T_MINUS
%token <novalue> T_OR
%token <novalue> T_AND

%token <ex_tk>   T_KEYWORD_ADVANCE
%token <ex_tk>   T_KEYWORD_BANK
%token <ex_tk>   T_KEYWORD_DEFINE_BYTE
%token <ex_tk>   T_KEYWORD_DEFINE_BYTE_REPEAT
%token <ex_tk>   T_KEYWORD_DEFINE_WORD
%token <ex_tk>   T_KEYWORD_LOADFILE
%token <novalue> T_KEYWORD_MAPPER
%token <novalue> T_KEYWORD_ROMBANKS
%token <novalue> T_KEYWORD_VROMBANKS
%token <novalue> T_KEYWORD_RAMBANKS
%token <novalue> T_KEYWORD_MIRROR
%token <novalue> T_KEYWORD_MIRROR_HORZ
%token <novalue> T_KEYWORD_MIRROR_VERT
%token <novalue> T_KEYWORD_COUNTRY
%token <byte>    T_KEYWORD_COUNTRY_VALUE

%token <novalue> T_ACCUMULATOR
%token <novalue> T_X_REGISTER
%token <novalue> T_Y_REGISTER

%token <novalue> T_END

/* Types */
%type <novalue>  SOURCE_FILE
%type <novalue>  VARIABLE_DECL_BLOCK
%type <novalue>  VARIABLE_DECL

%type <novalue>  ROM_OPTIONS
%type <novalue>  MAPPER
%type <novalue>  ROMBANKS
%type <novalue>  VROMBANKS
%type <novalue>  RAMBANKS
%type <novalue>  MIRROR
%type <novalue>  COUNTRY

%type <novalue>  BANKS
%type <novalue>  BANK
%type <byte>     BANK_DECL
%type <bltable>  CODE_BLOCK
%type <bl>       INSTRUCTION
%type <bl>       DATA
%type <bl>       BYTE_RANGE
%type <bl>       WORD_RANGE
%type <novalue>  LABEL

%type <bel>      IMMEDIATE_EXPRESSION
%type <bel>      UNDEFINED_SYMBOL_EXPRESSION
%type <bel>      DEFINED_SYMBOL_EXPRESSION

%type <novalue>  END_SOURCE

%%

/* Grammar rules */


SOURCE_FILE: BANKS END_SOURCE
    | VARIABLE_DECL_BLOCK BANKS END_SOURCE
    | VARIABLE_DECL_BLOCK ROM_OPTIONS BANKS END_SOURCE ;

VARIABLE_DECL_BLOCK: VARIABLE_DECL
    | VARIABLE_DECL_BLOCK VARIABLE_DECL ;

VARIABLE_DECL: T_VARIABLE_DECL T_BYTE {
        struct symbol* s = findSymbol(globalSymTable, string_buf);
        if(!s) //If symbol is not found in table
        {
            //Symbol is variable that is being declared
            createSymbol(&s, globalSymTable, string_buf, SYMBOLTYPE_VALUE8)->symvalue.value8 = $2;
        }
        else //If symbol is found in table
        {
            //Variable is being defined twice
            //FIXME: Is this illegal?    
        }
    }
    | T_VARIABLE_DECL T_IMM_BYTE {
        struct symbol* s = findSymbol(globalSymTable, string_buf);
        if(!s) //If symbol is not found in table
        {
            //Symbol is variable that is being declared
            createSymbol(&s, globalSymTable, string_buf, SYMBOLTYPE_VALUE16)->symvalue.value8 = $2;
        }
        else //If symbol is found in table
        {
            //Variable is being defined twice
            //FIXME: Is this illegal?    
        }
    }
    | T_VARIABLE_DECL T_WORD {
        struct symbol* s = findSymbol(globalSymTable, string_buf);
        if(!s) //If symbol is not found in table
        {
            //Symbol is variable that is being declared
            createSymbol(&s, globalSymTable, string_buf, SYMBOLTYPE_VALUE16)->symvalue.value16 = $2;
        }
        else //If symbol is found in table
        {
            //Variable is being defined twice
            //FIXME: Is this illegal?    
        }
    }
    | T_VARIABLE_DECL T_DECIMAL_BYTE {
        struct symbol* s = findSymbol(globalSymTable, string_buf);
        if(!s) //If symbol is not found in table
        {
            //Symbol is variable that is being declared
            createSymbol(&s, globalSymTable, string_buf, SYMBOLTYPE_VALUE8)->symvalue.value8 = $2;
        }
        else //If symbol is found in table
        {
            //Variable is being defined twice
            //FIXME: Is this illegal?    
        }
    } ;

ROM_OPTIONS: MAPPER
    | ROMBANKS
    | VROMBANKS
    | RAMBANKS
    | MIRROR
    | COUNTRY
    | ROM_OPTIONS MAPPER
    | ROM_OPTIONS ROMBANKS
    | ROM_OPTIONS VROMBANKS
    | ROM_OPTIONS RAMBANKS
    | ROM_OPTIONS MIRROR
    | ROM_OPTIONS COUNTRY ;

MAPPER:    T_KEYWORD_MAPPER    T_DECIMAL_BYTE {
        unsigned char mapper = $2;
        workingROM->header.mirror_hi_mapper_lo |= (mapper & 0x0F) << 4;
        workingROM->header.mapper_hi = (mapper & 0xF0);
    };
ROMBANKS:  T_KEYWORD_ROMBANKS  T_DECIMAL_BYTE { workingROM->header.rom_banks = $2; };
VROMBANKS: T_KEYWORD_VROMBANKS T_DECIMAL_BYTE { workingROM->header.vrom_banks = $2; };
RAMBANKS:  T_KEYWORD_RAMBANKS  T_DECIMAL_BYTE { workingROM->header.ram_banks = $2; };
MIRROR:    T_KEYWORD_MIRROR    T_KEYWORD_MIRROR_VERT {
        workingROM->header.mirror_hi_mapper_lo |= 1;
    }
    |      T_KEYWORD_MIRROR    T_KEYWORD_MIRROR_HORZ {
        workingROM->header.mirror_hi_mapper_lo |= 1;
        workingROM->header.mirror_hi_mapper_lo ^= 1;
    };
COUNTRY:   T_KEYWORD_COUNTRY   T_KEYWORD_COUNTRY_VALUE { workingROM->header.country_code = $2; };

BANKS: BANK
    | BANKS BANK  ;

BANK: BANK_DECL CODE_BLOCK {
        unsigned char bankNum = $1;
        #ifdef DEBUG
            printf("Bank %u:\n", bankNum);
            printBlocks(currentBlockTable);
        #endif
        if(bankNum < MAX_BANKS)
        {
            writeBlockTableToNESROM(workingROM, currentBlockTable);
        }
        emptySymTable(localSymTable);
    } ;

BANK_DECL: T_KEYWORD_BANK T_DECIMAL_BYTE {
        unsigned char bankNum = $2;
        currentBlockTable = createBlockTable();
        if(bankNum > MAX_BANKS)
        {
            sprintf(error_buf, "Maximum number of banks exceeded: %d", MAX_BANKS);
            bisonError(error_buf, $1.line_number);
            exit(1);
        }
        //cur_addr = 0;
        $$ = bankNum;
    } ;

END_SOURCE: T_END ;

CODE_BLOCK:  INSTRUCTION {
        //First instruction
        addBlock(currentBlockTable, $1);
        $$ = currentBlockTable;
    }
    | DATA {
        //First datablock
        addBlock(currentBlockTable, $1);
        $$ = currentBlockTable;
    }
    | T_KEYWORD_ADVANCE T_WORD {
        $$ = advanceAddress(currentBlockTable, $2, $1.line_number);
    }
    | LABEL {
        $$ = currentBlockTable;
    }
    | CODE_BLOCK INSTRUCTION {
        //Next instruction
        addBlock($1, $2);
        $$ = $1;
    }
    | CODE_BLOCK DATA {
        //Next data block
        addBlock($1, $2);
        $$ = $1;
    }
    | CODE_BLOCK T_KEYWORD_ADVANCE T_WORD {
        $$ = advanceAddress($1, $3, $2.line_number);
    }
    | CODE_BLOCK LABEL {
        $$ = $1;
    } ;

INSTRUCTION: T_INSTR8 IMMEDIATE_EXPRESSION {
        /* Immediate address instruction */
        unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: immediate address\n", line_number, (unsigned short)(cur_addr));
        #endif
        struct BEL* bel = $2;
        char eval_type;
        unsigned short value;
        evaluateBEL(bel, &value, &eval_type);
        freeBEL(bel);
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_IMM];
        checkOpcodeOrDie(opcode, "immediate", line_number);
        struct block* b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BYTE, 0);
        b->block.i8->operand.byte = value & 0xFF;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " #$%02X");
        $$ = b;
    } 
    | T_INSTR8 DEFINED_SYMBOL_EXPRESSION {
        /* Relative/absolute/zero address instruction from defined reference */
        struct BEL* bel = $2;
        struct block* b;
        char eval_type;
        unsigned short branch_addr;
        unsigned int line_number = $1.line_number;
        evaluateBEL(bel, &branch_addr, &eval_type); //Get the value of the expression, result should be BELEVALRESULT_GOOD
        freeBEL(bel);
        //Determine if relative addressing is valid for this instruction
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_RELATIVE];
        if(checkOpcode(opcode))
        {
            //Relative addressing
            #ifdef DEBUG
                printf("line %d: 0x%04X: relative defined reference\n", line_number, (unsigned short)(cur_addr));
            #endif
            unsigned short addr_diff;
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BYTE, 0);
            calcAddressRange(&addr_diff, (unsigned short)cur_addr, branch_addr);
            b->block.i8->operand.byte = addr_diff & 0xFF;
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%02X");
        }
        else if(eval_type == BELEVALTYPE_WORD)
        {
            //Absolute addressing
            #ifdef DEBUG
                printf("line %d: 0x%04X: absolute defined reference\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ABSOLUTE];
            checkOpcodeOrDie(opcode, "absolute", line_number);
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_WORD, 0);
            b->block.i8->operand.word = branch_addr;
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%04X");
        }
        else
        {
            //Zero page addressing
            #ifdef DEBUG
                printf("line %d: 0x%04X: zero page address\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ZEROPAGE];
            checkOpcodeOrDie(opcode, "zero page", line_number);
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BYTE, 0);
            b->block.i8->operand.byte = branch_addr & 0xFF;
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%02X");
        }
        $$ = b;
    }
    | T_INSTR8 DEFINED_SYMBOL_EXPRESSION T_COMMA T_X_REGISTER {
        struct BEL* bel = $2;
        struct block* b;
        char eval_type;
        unsigned short branch_addr;
        unsigned int line_number = $1.line_number;
        evaluateBEL(bel, &branch_addr, &eval_type); //Get the value of the expression, result should be BELEVALRESULT_GOOD
        freeBEL(bel);
        unsigned char opcode;
        if(eval_type == BELEVALTYPE_BYTE)
        {
            /* Zero page, X address instruction */
            #ifdef DEBUG
                printf("line %d: 0x%04X: zero page, x address\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ZEROPAGEX];
            checkOpcodeOrDie(opcode, "zero page, x", line_number);
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BYTE, 0);
            b->block.i8->operand.byte = branch_addr & 0xFF;
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%02X,X");
        }
        else
        {
            /* Absolute, X address instruction */
            #ifdef DEBUG
                printf("line %d: 0x%04X: absolute, x address\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ABSX];
            checkOpcodeOrDie(opcode, "absolute, x", line_number);
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_WORD, 0);
            b->block.i8->operand.word = branch_addr;
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%04X,X");
        }
        $$ = b;
    } 
    | T_INSTR8 DEFINED_SYMBOL_EXPRESSION T_COMMA T_Y_REGISTER {
        const unsigned int line_number = $1.line_number;
        struct BEL* bel = $2;
        struct block* b;
        char eval_type;
        unsigned short branch_addr;
        evaluateBEL(bel, &branch_addr, &eval_type); //Get the value of the expression, result should be BELEVALRESULT_GOOD
        freeBEL(bel);
        unsigned char opcode;
        if(eval_type == BELEVALTYPE_BYTE)
        {
            /* Zero page, Y address instruction */
            #ifdef DEBUG
                printf("line %d: 0x%04X: zero page, y address\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ZEROPAGEY];
            checkOpcodeOrDie(opcode, "zero page, y", line_number);
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BYTE, 0);
            b->block.i8->operand.byte = branch_addr & 0xFF;
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%02X,Y");
        }
        else
        {
            /* Absolute, Y address instruction */
            #ifdef DEBUG
                printf("line %d: 0x%04X: absolute, y address\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ABSY];
            checkOpcodeOrDie(opcode, "absolute, y", line_number);
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_WORD, 0);
            b->block.i8->operand.word = branch_addr;
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%04X,Y");
        }
        $$ = b;
    } 
    | T_INSTR8 T_OPEN_PAREN T_BYTE T_COMMA T_X_REGISTER T_CLOSE_PAREN {
        /* Indirect indexed with X instruction */
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: indirect indexed with x\n", line_number, (unsigned short)(cur_addr));
        #endif
        unsigned char byte = $3;
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_INDX];
        checkOpcodeOrDie(opcode, "indirect indexed", line_number);
        struct block* b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BYTE, 0);
        b->block.i8->operand.byte = byte;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " ($%02X,X)");
        $$ = b;
    }  
    | T_INSTR8 T_OPEN_PAREN T_BYTE T_CLOSE_PAREN T_COMMA T_Y_REGISTER {
        /* Indexed indirect with Y instruction */
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: indexed indirect with y\n", line_number, (unsigned short)(cur_addr));
        #endif
        unsigned char byte = $3;
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_INDY];
        checkOpcodeOrDie(opcode, "indexed indirect", line_number);
        struct block* b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BYTE, 0);
        b->block.i8->operand.byte = byte;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " ($%02X),Y");
        $$ = b;
    }
    | T_INSTR8 T_OPEN_PAREN T_BYTE T_CLOSE_PAREN {
        /* Indirect address instruction */
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: indirect address\n", line_number, (unsigned short)(cur_addr));
        #endif
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_INDIRECT];
        unsigned char byte = $3;
        checkOpcodeOrDie(opcode, "indirect", line_number);
        struct block* b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_WORD, 0);
        b->block.i8->operand.word = 0x0000 | byte;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " ($%02X)");
        $$ = b;
    } 
    | T_INSTR8 T_OPEN_PAREN T_WORD T_CLOSE_PAREN {
        /* Indirect address instruction */
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: indirect address\n", line_number, (unsigned short)(cur_addr));
        #endif
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_INDIRECT];
        unsigned char word = $3;
        checkOpcodeOrDie(opcode, "indirect", line_number);
        struct block* b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_WORD, 0);
        b->block.i8->operand.word = word;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " ($%04X)");
        $$ = b;
    } 
    | T_INSTR8 UNDEFINED_SYMBOL_EXPRESSION {
        /* Relative/absolute/zero address instruction from undefined reference */
        const unsigned int line_number = $1.line_number;
        struct block* b = 0;
        struct BEL* bel = $2;
        char beltype = bel->eval_type;
        //Determine if relative addressing is valid for this instruction
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_RELATIVE];
        if(checkOpcode(opcode))
        {
            //Relative addressing
            #ifdef DEBUG
                printf("line %d: 0x%04X: relative undefined address\n", line_number, (unsigned short)cur_addr);
            #endif
            bel->eval_type = BELEVALTYPE_REL_ADDR;
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BEL, bel);
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%02X");
        }
        else if(beltype == BELEVALTYPE_WORD)
        {
            //Absolute addressing
            #ifdef DEBUG
                printf("line %d: 0x%04X: absolute undefined address\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ABSOLUTE];
            checkOpcodeOrDie(opcode, "absolute", line_number);
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BEL, bel);
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%04X");
        }
        else
        {
            //Zero page addressing
            #ifdef DEBUG
                printf("line %d: 0x%04X: zero undefined address\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ZEROPAGE];
            checkOpcodeOrDie(opcode, "zero page", line_number);
            b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BEL, bel);
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%02X");
        }
        markUndefinedRef(bel, b); //Add block to forward reference table of each symbol to be resolved later
        $$ = b;
    }
    | T_INSTR8 UNDEFINED_SYMBOL_EXPRESSION T_COMMA T_X_REGISTER {
        /* Absolute, x address instruction from undefined reference */
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: absolute undefined address, x\n", line_number, (unsigned short)(cur_addr));
        #endif
        struct block* b = 0;
        struct BEL* bel = $2;
        char beltype = bel->eval_type;
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_ABSX];
        checkOpcodeOrDie(opcode, "absolute, x", line_number);
        if(beltype != BELEVALTYPE_WORD)
        {
            sprintf(error_buf, "Expected word address");
            bisonError(error_buf, line_number);
            exit(1);
        }
        b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BEL, bel);
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%04X,X");
        markUndefinedRef(bel, b); //Add block to forward reference table to be resolved later
        $$ = b;
    }
    | T_INSTR8 UNDEFINED_SYMBOL_EXPRESSION T_COMMA T_Y_REGISTER {
        /* Absolute, y address instruction from undefined reference */
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: absolute undefined address, y\n", line_number, (unsigned short)(cur_addr));
        #endif
        struct block* b = 0;
        struct BEL* bel = $2;
        char beltype = bel->eval_type;
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_ABSY];
        checkOpcodeOrDie(opcode, "absolute, y", line_number);
        if(beltype != BELEVALTYPE_WORD)
        {
            sprintf(error_buf, "Expected word address");
            bisonError(error_buf, line_number);
            exit(1);
        }
        b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_BEL, bel);
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], " $%04X,Y");
        markUndefinedRef(bel, b); //Add block to forward reference table to be resolved later
        $$ = b;
    }
    | T_INSTR8 T_ACCUMULATOR {
        /* accumulator address */
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: accumulator\n", line_number, (unsigned short)(cur_addr));
        #endif
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_ACC];
        checkOpcodeOrDie(opcode, "accumulator", line_number);
        struct block* b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_NONE, 0);
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], "");
        $$ = b;
    }
    | T_INSTR8 {
        /* implied/accumulator address */
        const unsigned int line_number = $1.line_number;
        unsigned char opcode = opcode6502[$1.value.byte][ADR6502_IMPLIED];
        if(!checkOpcode(opcode))
        {
            #ifdef DEBUG
                printf("line %d: 0x%04X: accumulator\n", line_number, (unsigned short)(cur_addr));
            #endif
            opcode = opcode6502[$1.value.byte][ADR6502_ACC];
            checkOpcodeOrDie(opcode, "implied", line_number); //Yes, 'implied' should be here
        }
        #ifdef DEBUG
        else
        {
            printf("line %d: 0x%04X: implied\n", line_number, (unsigned short)(cur_addr));
        }
        #endif
        struct block* b = createBlocki8(&b, &cur_addr, opcode, OPERANDTYPE_NONE, 0);
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, name6502[$1.value.byte], "");
        $$ = b;
    } ;

IMMEDIATE_EXPRESSION: T_IMM_BYTE {
        /* Construct binary expression list */
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        bel->eval_type = BELEVALTYPE_BYTE;
        addBELbyte(bel, '=', $1);
        $$ = bel;
    }
    | T_IMM_WORD {
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        bel->eval_type = BELEVALTYPE_WORD;
        addBELword(bel, '=', $1);
        $$ = bel;
    }
    | T_OPEN_SQUARE T_LEFT_ANGLE T_WORD T_CLOSE_SQUARE {
        /* Get least significant byte of a word */
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        bel->eval_type = BELEVALTYPE_BYTE;
        addBELword(bel, '=', $3 & 0xFF);
        $$ = bel;
    }
    | T_OPEN_SQUARE T_RIGHT_ANGLE T_WORD T_CLOSE_SQUARE {
        /* Get most significant byte of a word */
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        bel->eval_type = BELEVALTYPE_BYTE;
        addBELword(bel, '=', ($3 >> 8) & 0xFF);
        $$ = bel;
    }
    | T_BYTE T_OR T_BYTE {
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        addBELbyte(bel, '=', $1);
        addBELbyte(bel, '|', $3);
        $$ = bel;
    }
    | IMMEDIATE_EXPRESSION T_OR T_BYTE {
        struct BEL* bel = $1;
        addBELbyte(bel, '|', $3);
        $$ = bel;
    }
    | IMMEDIATE_EXPRESSION T_OR T_WORD {
        struct BEL* bel = $1;
        addBELword(bel, '|', $3);
        $$ = bel;
    }
    | IMMEDIATE_EXPRESSION T_OR T_IMM_BYTE {
        struct BEL* bel = $1;
        addBELbyte(bel, '|', $3);
        $$ = bel;
    }
    | IMMEDIATE_EXPRESSION T_OR T_IMM_WORD {
        struct BEL* bel = $1;
        addBELword(bel, '|', $3);
        $$ = bel;
    } ;

UNDEFINED_SYMBOL_EXPRESSION: T_UNDEFINED_SYMBOL {
        /* Construct binary expression list */
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        struct symbol* sym = $1;
        bel->eval_type = BELEVALTYPE_WORD;
        addBELsym(bel, '=', sym);
        $$ = bel;
    }
    | T_PLUS {
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        struct symbol* sym = findSymbol(localSymTable, string_buf);
        bel->eval_type = BELEVALTYPE_WORD;
        if(!sym)
        {
            createSymbol(&sym, localSymTable, string_buf, SYMBOLTYPE_ADDRESS16)->symvalue.address16 = 0XD00F; //Sanity value
            sym->defined = 0;
        }
        addBELsym(bel, '=', sym);
        $$ = bel;
    }
    | UNDEFINED_SYMBOL_EXPRESSION T_PLUS T_DECIMAL_BYTE {
        struct BEL* bel = $1;
        addBELbyte(bel, '+', $3);
        $$ = bel;
    }
    | UNDEFINED_SYMBOL_EXPRESSION T_MINUS T_DECIMAL_BYTE {
        struct BEL* bel = $1;
        addBELbyte(bel, '-', $3);
        $$ = bel;
    }
    | UNDEFINED_SYMBOL_EXPRESSION T_PLUS T_UNDEFINED_SYMBOL {
        struct BEL* bel = $1;
        struct symbol* sym = $3;
        //TODO: Add rule for adding/subtracting defined symbol
        addBELsym(bel, '+', sym);
        $$ = bel;
    } ;

DEFINED_SYMBOL_EXPRESSION: T_DEFINED_SYMBOL {
        /* Construct binary expression list */
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        bel->eval_type = BELEVALTYPE_WORD;
        addBELsym(bel, '=', $1);
        $$ = bel;
    }
    | T_MINUS {
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        struct symbol* s = findSymbol(localSymTable, string_buf);
        bel->eval_type = BELEVALTYPE_WORD;
        if(!s || (s->defined == 0))
        {
            sprintf(error_buf, "Undefined backreference '%s'", string_buf);
            bisonError(error_buf, $1.line_number);
            exit(1);    
        }
        addBELsym(bel, '=', s);
        $$ = bel;
    }
    | T_BYTE {
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        bel->eval_type = BELEVALTYPE_BYTE;
        addBELbyte(bel, '=', $1);
        $$ = bel;
    }
    | T_WORD {
        struct BEL* bel = createBEL(BEL_SMALL_MALLOC_SIZE);
        bel->eval_type = BELEVALTYPE_WORD;
        addBELword(bel, '=', $1);
        $$ = bel;
    }
    | DEFINED_SYMBOL_EXPRESSION T_PLUS T_DECIMAL_BYTE {
        struct BEL* bel = $1;
        if(strlen(string_buf) > 1)
        {
            sprintf(error_buf, "Invalid operator '%s'", string_buf);
            bisonError(error_buf, $2.line_number);
            exit(1);
        }
        addBELbyte(bel, '+', $3);
        $$ = bel;
    }
    | DEFINED_SYMBOL_EXPRESSION T_MINUS T_DECIMAL_BYTE {
        struct BEL* bel = $1;
        if(strlen(string_buf) > 1)
        {
            sprintf(error_buf, "Invalid operator '%s'", string_buf);
            bisonError(error_buf, $2.line_number);
            exit(1);
        }
        addBELbyte(bel, '-', $3);
        $$ = bel;
    } ;

DATA: T_KEYWORD_LOADFILE T_STRING_LITERAL {
        /* Load binary file */
        const unsigned int line_number = $1.line_number;
        struct block* b = 0;
        FILE* f = fopen(string_buf, "rb");
        if(f)
        {
            unsigned long file_size;
            char* datablock_ptr;

            fseek(f, 0, SEEK_END);
            file_size = ftell(f);
            #ifdef DEBUG
                printf("loading file '%s' -> %lu bytes\n", string_buf, file_size);
            #endif
            fseek(f, 0, SEEK_SET);

            //Load all bytes from the file
            datablock_ptr = createBlockData(&b, &cur_addr, file_size, file_size)->block.dblock->data;
            fread(datablock_ptr, file_size, 1, f);

            fclose(f);
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, 0, "");
            #ifdef DEBUG
                printf("line %d: 0x%04X: defined %lu byte range from file '%s'\n", line_number, (unsigned short)(cur_addr), file_size, string_buf);
            #endif
        }
        else
        {
            sprintf(error_buf, "error: could not load file '%s'", string_buf);
            bisonError(error_buf, line_number);
            exit(1);
        }
        $$ = b;
    }
    | T_KEYWORD_DEFINE_BYTE BYTE_RANGE {
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: defined %lu byte range\n", line_number, (unsigned short)(cur_addr), $2->block.dblock->size);
        #endif
        struct block* b = $2;
        //Allocated datablock size may be bigger than actual size, so let's resize it
        unsigned long actual_size = b->block.dblock->size;
        b->block.dblock->data = realloc(b->block.dblock->data, actual_size);
        b->block.dblock->malloc_size = actual_size;
        cur_addr += actual_size;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, 0, "");
        $$ = b; 
    }
    | T_KEYWORD_DEFINE_BYTE_REPEAT T_BYTE T_COMMA T_DECIMAL_BYTE {
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: define 0x%02X repeat %d\n", line_number, (unsigned short)(cur_addr), $2, $4);
        #endif
        struct block* b = 0;
        unsigned char byte = $2;
        unsigned long size = $4;
        if(size >= 1)
        {
            char* datablock_ptr = createBlockData(&b, &cur_addr, size, size)->block.dblock->data;
            memset(datablock_ptr, byte, size);
            if(assembleDebugFlag) b->debug = createDebugRecord(line_number, 0, "");
        }
        $$ = b;
    }
    | T_KEYWORD_DEFINE_WORD WORD_RANGE {
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: defined %lu word range\n", line_number, (unsigned short)(cur_addr), ($2->block.dblock->size) / sizeof(unsigned short));
        #endif
        struct block* b = $2;
        unsigned long actual_size = b->block.dblock->size;
        b->block.dblock->data = realloc(b->block.dblock->data, actual_size); //Readjust heap allocation for datablock
        b->block.dblock->malloc_size = actual_size;
        cur_addr += actual_size;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, 0, "");
        $$ = b;
    }
    | T_KEYWORD_DEFINE_WORD T_DEFINED_SYMBOL {
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: defined word 0x%04X from reference\n", line_number, (unsigned short)(cur_addr), $2->symvalue.address16);
        #endif
        //Symbol type should be SYMBOLTYPE_ADDRESS16
        struct block* b = 0;
        unsigned short word = $2->symvalue.address16;
        char* datablock_ptr = createBlockData(&b, &cur_addr, 2, 2)->block.dblock->data;
        datablock_ptr[0] = word & 0xFF; //Little endian, LSB first
        datablock_ptr[1] = (word >> 8) & 0xFF;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, 0, "");
        $$ = b;
    }
    | T_KEYWORD_DEFINE_WORD T_UNDEFINED_SYMBOL {
        //Symbol type should be SYMBOLTYPE_ADDRESS16
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: undefined word\n", line_number, (unsigned short)(cur_addr));
        #endif
        struct block* b = 0;
        struct symbol* sym = $2;
        unsigned short word = sym->symvalue.address16;
        char* datablock_ptr = createBlockData(&b, &cur_addr, 2, 2)->block.dblock->data;
        datablock_ptr[0] = word & 0xFF; //Little endian, LSB first
        datablock_ptr[1] = (word >> 8) & 0xFF;
        if(assembleDebugFlag) b->debug = createDebugRecord(line_number, 0, "");
        addForwardRef(sym, b); //Add block to forward reference table to be resolved later
        $$ = b;
    };

BYTE_RANGE: T_BYTE {
        struct block* b = 0;
        //Create temp address, don't increment the real cur_addr until we know how large the block is
        unsigned long temp_addr = cur_addr;
        char* datablock_ptr = createBlockData(&b, &temp_addr, 64, 1)->block.dblock->data; //malloc 64 bytes
        //Debug record must be added by another rule is assembleDebugFlag is true!
        datablock_ptr[0] = $1;
        $$ = b;
    }
    | BYTE_RANGE T_COMMA T_BYTE {
        struct block* b = $1;
        char* datablock_ptr = b->block.dblock->data; //malloc 64 bytes
        unsigned long size = b->block.dblock->size;
        if(size + 1 > b->block.dblock->malloc_size)
        {
            b->block.dblock->data = realloc(b->block.dblock->data, size + 64);
            b->block.dblock->malloc_size = size + 64;
        }
        datablock_ptr[size] = $3;
        b->block.dblock->size++;
        $$ = b;
    }
    | BYTE_RANGE T_COLON {};

WORD_RANGE: T_WORD {
        struct block* b = 0;
        //Create temp address, don't increment the real cur_addr until we know how large the block is
        unsigned long temp_addr = cur_addr;
        char* datablock_ptr = createBlockData(&b, &temp_addr, 64, sizeof(unsigned short))->block.dblock->data; //malloc 64 bytes
        //Debug record must be added by another rule is assembleDebugFlag is true!
        datablock_ptr[0] = $1 & 0xFF;
        datablock_ptr[1] = ($1 >> 8) & 0xFF;
        $$ = b;
    }
    | WORD_RANGE T_COMMA T_WORD {
        struct block* b = $1;
        char* datablock_ptr = b->block.dblock->data; //malloc 64 bytes
        unsigned long size = b->block.dblock->size;
        if(size + sizeof(unsigned short) > b->block.dblock->malloc_size)
        {
            b->block.dblock->data = realloc(b->block.dblock->data, size + 64);    
            b->block.dblock->malloc_size = size + 64;
        }
        datablock_ptr[size] = $3 & 0xFF;
        datablock_ptr[size + 1] = ($3 >> 8) & 0xFF;
        b->block.dblock->size += sizeof(unsigned short);
        $$ = b;
    }
    | WORD_RANGE T_COLON {};

LABEL: T_LABEL {
        const unsigned int line_number = $1.line_number;
        #ifdef DEBUG
            printf("line %d: 0x%04X: defined label '%s'\n", line_number, (unsigned short)(cur_addr), string_buf);
        #endif
        struct symbol* s = findSymbol(localSymTable, string_buf);
        if(!s) //If symbol is NOT found in the symbol table
        {
            //Label has never been referenced before
            createSymbol(&s, localSymTable, string_buf, SYMBOLTYPE_ADDRESS16)->symvalue.address16 = cur_addr;
            s->defined = 1;
            s->symvalue.address16 = cur_addr;
        }
        else if(!(s->defined)) //If symbol is not defined
        {
            //Previously referenced label is now being defined
            s->defined = 1;
            s->symvalue.address16 = cur_addr;
            //Calculate relative addressing for previous references in the forward reference table
            int resolve_status = resolveForwardRef(s, error_buf, sizeof(error_buf));
            if(!resolve_status) //If all forward references were successfully resolved
            {
                if(s->symname[0] == '+') //If this is a plus reference
                {
                    s->defined = 0;
                }
            }
        }
        else if(s->defined)
        {
            //Label is being redefined
            //FIXME: Only should be valid for relative labels (e.i. '-')
            s->defined = 1;
            s->symvalue.address16 = cur_addr;
        }
    };

%%

/* Epilogue */

