%top {
#include <stdio.h>
#include <stdlib.h>
#include "symbol.h"
#include "block.h"
#include "enum6502.h"
#include "parser.tab.h"
#include "pathname.h"

char string_buf[256];
char error_buf[256];
unsigned int line_number = 1;
int yylex(void);
void yyerror(const char*);
char* toupperStr(char*, int);
void parseAsmFile(FILE* f);

/* The extended_token struct is used to store the line number of a token, along with its value */
inline void extokenByte(unsigned char byte)
{
    yylval.ex_tk.line_number = line_number;
    yylval.ex_tk.value.byte = byte;    
};
/*inline void extokenWord(unsigned short word)
{
    yylval.ex_tk.line_number = line_number;
    yylval.ex_tk.value.word = word;
};
inline void extokenSymbol(struct symbol* sym)
{
    yylval.ex_tk.line_number = line_number;
    yylval.ex_tk.value.sym = sym;
};*/
inline void extokenNoValue()
{
    yylval.ex_tk.line_number = line_number;
};

//defined in main.c
extern char* inputFileName;
extern char inputPath[];
extern char* outputFileName;
extern char assembleDebugFlag;
extern struct symtable* globalSymTable;
extern struct symtable* localSymTable;
}

%option case-insensitive noyywrap batch
%x COMMENT_STATE

NAME [a-zA-Z_][a-zA-Z0-9_]*

%%
<COMMENT_STATE>\n      { BEGIN INITIAL; line_number++; /* Exit comment state */ } ;
<COMMENT_STATE>.       /* ignore all characters except newline in comment state */
\;                     { BEGIN COMMENT_STATE; /* Enter comment state */ } ;
,                      { return T_COMMA; } ;
:                      { return T_COLON; } ;
\(                     { return T_OPEN_PAREN; } ;
\)                     { return T_CLOSE_PAREN; } ;
\[                     { return T_OPEN_SQUARE; } ;
\]                     { return T_CLOSE_SQUARE; } ;
\<                     { return T_LEFT_ANGLE; } ;
\>                     { return T_RIGHT_ANGLE; } ;
\|                     { return T_OR; } ;
\&                     { return T_AND; } ;
#\$[a-fA-F0-9]{2}      { /*Byte immediate hex value */ yylval.byte = strtol(yytext + 2, 0, 16); return T_IMM_BYTE; } ;
\$[a-fA-F0-9]{2}       { /*Byte hex value */ yylval.byte = strtol(yytext + 1, 0, 16); return T_BYTE; } ;
#\$[a-fA-F0-9]{4}      { /*Word immediate hex value */ yylval.word = strtol(yytext + 2, 0, 16); return T_IMM_WORD; } ;
\$[a-fA-F0-9]{4}       { /*Word hex value */ yylval.word = strtol(yytext + 1, 0, 16); return T_WORD; } ;
#%[01]{8}              { /*Byte immediate binary value */ yylval.byte = strtol(yytext + 2, 0, 2); return T_IMM_BYTE; } ;
%[01]{8}               { /*Byte binary value */ yylval.byte = strtol(yytext + 1, 0, 2); return T_BYTE; } ;
[0-9]{1,3}             {
    /* Decimal value */
    unsigned short val = strtol(yytext, 0, 10);
    if(val <= 0xFF)
    {
        yylval.byte = (unsigned char)(val & 0xFF);
        return T_DECIMAL_BYTE;
    }
    yylval.word = val;
    return T_DECIMAL_WORD;
} ;
#[0-9]{1,3}            {
    /* Decimal immediate */
    unsigned short val = strtol(yytext + 1, 0, 10);
    if(val <= 0xFF)
    {
        yylval.byte = (unsigned char)(val & 0xFF);
        return T_IMM_BYTE;
    }
    yylval.word = val;
    return T_IMM_WORD;
} ;
\"[^"]*\"              {
    /* String literal */
    strcpy(string_buf, inputPath);  //Insert path of source file
    strcat(string_buf, yytext + 1); //Remove beginning quote
    string_buf[strlen(string_buf) - 1] = 0; //Truncate last quote
    return T_STRING_LITERAL;
} ;
ADC { extokenByte(IN6502_ADC); return T_INSTR8; } ;
AND { extokenByte(IN6502_AND); return T_INSTR8; } ;
ASL { extokenByte(IN6502_ASL); return T_INSTR8; } ;
BCC { extokenByte(IN6502_BCC); return T_INSTR8; } ;
BCS { extokenByte(IN6502_BCS); return T_INSTR8; } ;
BEQ { extokenByte(IN6502_BEQ); return T_INSTR8; } ;
BIT { extokenByte(IN6502_BIT); return T_INSTR8; } ;
BMI { extokenByte(IN6502_BMI); return T_INSTR8; } ;
BNE { extokenByte(IN6502_BNE); return T_INSTR8; } ;
BPL { extokenByte(IN6502_BPL); return T_INSTR8; } ;
BRK { extokenByte(IN6502_BRK); return T_INSTR8; } ;
BVC { extokenByte(IN6502_BVC); return T_INSTR8; } ;
BVS { extokenByte(IN6502_BVS); return T_INSTR8; } ;
CLC { extokenByte(IN6502_CLC); return T_INSTR8; } ;
CLD { extokenByte(IN6502_CLD); return T_INSTR8; } ;
CLI { extokenByte(IN6502_CLI); return T_INSTR8; } ;
CLV { extokenByte(IN6502_CLV); return T_INSTR8; } ;
CMP { extokenByte(IN6502_CMP); return T_INSTR8; } ;
CPX { extokenByte(IN6502_CPX); return T_INSTR8; } ;
CPY { extokenByte(IN6502_CPY); return T_INSTR8; } ;
DEC { extokenByte(IN6502_DEC); return T_INSTR8; } ;
DEX { extokenByte(IN6502_DEX); return T_INSTR8; } ;
DEY { extokenByte(IN6502_DEY); return T_INSTR8; } ;
EOR { extokenByte(IN6502_EOR); return T_INSTR8; } ;
INC { extokenByte(IN6502_INC); return T_INSTR8; } ;
INX { extokenByte(IN6502_INX); return T_INSTR8; } ;
INY { extokenByte(IN6502_INY); return T_INSTR8; } ;
JMP { extokenByte(IN6502_JMP); return T_INSTR8; } ;
JSR { extokenByte(IN6502_JSR); return T_INSTR8; } ;
LDA { extokenByte(IN6502_LDA); return T_INSTR8; } ;
LDX { extokenByte(IN6502_LDX); return T_INSTR8; } ;
LDY { extokenByte(IN6502_LDY); return T_INSTR8; } ;
LSR { extokenByte(IN6502_LSR); return T_INSTR8; } ;
NOP { extokenByte(IN6502_NOP); return T_INSTR8; } ;
ORA { extokenByte(IN6502_ORA); return T_INSTR8; } ;
PHA { extokenByte(IN6502_PHA); return T_INSTR8; } ;
PHP { extokenByte(IN6502_PHP); return T_INSTR8; } ;
PLA { extokenByte(IN6502_PLA); return T_INSTR8; } ;
PLP { extokenByte(IN6502_PLP); return T_INSTR8; } ;
ROL { extokenByte(IN6502_ROL); return T_INSTR8; } ;
ROR { extokenByte(IN6502_ROR); return T_INSTR8; } ;
RTI { extokenByte(IN6502_RTI); return T_INSTR8; } ;
RTS { extokenByte(IN6502_RTS); return T_INSTR8; } ;
SBC { extokenByte(IN6502_SBC); return T_INSTR8; } ;
SEC { extokenByte(IN6502_SEC); return T_INSTR8; } ;
SED { extokenByte(IN6502_SED); return T_INSTR8; } ;
SEI { extokenByte(IN6502_SEI); return T_INSTR8; } ;
STA { extokenByte(IN6502_STA); return T_INSTR8; } ;
STX { extokenByte(IN6502_STX); return T_INSTR8; } ;
STY { extokenByte(IN6502_STY); return T_INSTR8; } ;
TAX { extokenByte(IN6502_TAX); return T_INSTR8; } ;
TAY { extokenByte(IN6502_TAY); return T_INSTR8; } ;
TSX { extokenByte(IN6502_TSX); return T_INSTR8; } ;
TXA { extokenByte(IN6502_TXA); return T_INSTR8; } ;
TXS { extokenByte(IN6502_TXS); return T_INSTR8; } ;
TYA { extokenByte(IN6502_TYA); return T_INSTR8; } ;
X           { return T_X_REGISTER; } ;
Y           { return T_Y_REGISTER; } ;
A           { return T_ACCUMULATOR; } ;
\.advance   { extokenNoValue(); return T_KEYWORD_ADVANCE; };
\.end       { return T_END; };
\.bank      { extokenNoValue(); return T_KEYWORD_BANK; } ;
\.db        { extokenNoValue(); return T_KEYWORD_DEFINE_BYTE; } ;
\.dbr       { extokenNoValue(); return T_KEYWORD_DEFINE_BYTE_REPEAT; } ;
\.dw        { extokenNoValue(); return T_KEYWORD_DEFINE_WORD; } ;
\.mapper    { return T_KEYWORD_MAPPER; } ;
\.rombanks  { return T_KEYWORD_ROMBANKS; } ;
\.vrombanks { return T_KEYWORD_VROMBANKS; } ;
\.rambanks  { return T_KEYWORD_RAMBANKS; } ;
\.mirror    { return T_KEYWORD_MIRROR; } ;
VERT        { return T_KEYWORD_MIRROR_VERT; } ;
HORZ        { return T_KEYWORD_MIRROR_HORZ; } ;
\.country   { return T_KEYWORD_COUNTRY; } ;
NTSC        { yylval.byte = 0; return T_KEYWORD_COUNTRY_VALUE; } ;
PAL         { yylval.byte = 1; return T_KEYWORD_COUNTRY_VALUE; } ;
\.loadfile  { extokenNoValue(); return T_KEYWORD_LOADFILE; } ;
^#{NAME}               {
    /* Variable declaration */
    strcpy(string_buf, yytext + 1); //Remove initial #
    return T_VARIABLE_DECL;
} ;
#{NAME}               {
    /* Immediate variable reference */
    strcpy(string_buf, yytext + 1); //Remove initial #
    struct symbol* s = findSymbol(globalSymTable, string_buf);
    if(!s) //If symbol is not found in table
    {
        yyerror("Use of undefined variable\n");
        exit(1);
    }
    switch(s->symtype)
    {
        case SYMBOLTYPE_VALUE8:
            yylval.byte = s->symvalue.value8;
            return T_IMM_BYTE;
        break;
        case SYMBOLTYPE_VALUE16:
            yylval.word = s->symvalue.value16;
            return T_IMM_WORD;
        break;
    }
    yyerror("Invalid use of variable\n");
    exit(1);
} ;
^\++:?|-+:?            {
    /* Relative label definition */
    extokenNoValue();
    strcpy(string_buf, yytext);
    if(yytext[strlen(yytext) - 1] == ':') string_buf[strlen(yytext) - 1] = 0; //Truncate the colon    
    return T_LABEL;
} ;
\++                    {
    extokenNoValue();
    strcpy(string_buf, yytext);
    return T_PLUS;
} ;
\-+                    {
    extokenNoValue();
    strcpy(string_buf, yytext);
    return T_MINUS;
} ;
{NAME}:                {
    /* Named label definition */
    extokenNoValue();
    strcpy(string_buf, yytext);
    string_buf[strlen(yytext) - 1] = 0; //Truncate the colon
    return T_LABEL;
} ; 
^{NAME}                {
    /* Named label definition */
    extokenNoValue();
    strcpy(string_buf, yytext);
    return T_LABEL;
} ;
\s+               /* ignore */
{NAME}                 {
    /* Name reference */
    struct symbol* s = findSymbol(globalSymTable, yytext);
    if(!s) //If symbol is not found in global table
    {
        s = findSymbol(localSymTable, yytext); //Search the local table
        if(!s) //If symbol is not found in the local table
        {
            //Assume symbol is reference to yet-to-be-defined absolute address (16 bit)
            //Add symbol to symbol table if it isn't already in it
            #ifdef DEBUG
                printf("adding undef symbol '%s' to the table\n", yytext);
            #endif
            createSymbol(&s, localSymTable, yytext, SYMBOLTYPE_ADDRESS16)->symvalue.address16 = 0XD00F; //Sanity value
            s->defined = 0;
            yylval.sym = s;
            return T_UNDEFINED_SYMBOL;
        }
    }
    switch(s->symtype)
    {
        case SYMBOLTYPE_VALUE8:
            yylval.byte = s->symvalue.value8;
            return T_BYTE;
        break;
        case SYMBOLTYPE_VALUE16:
            yylval.word = s->symvalue.value16;
            return T_WORD;
        break;
        case SYMBOLTYPE_ADDRESS16:
            yylval.sym = s;
            if(s->defined) return T_DEFINED_SYMBOL;
            return T_UNDEFINED_SYMBOL;
        break;
    }
} ;
\n                { line_number++; } ;
.                 {
    //yyerror("syntax error");
    //exit(1);
}
%%
char* toupperStr(char* str, int len)
{
    int i = 0;    
    for(; i < len; i++) { string_buf[i] = toupper(str[i]); }
    string_buf[i] = 0;
    return string_buf;
}
void yyerror(const char* msg)
{
    fprintf(stderr, "%s: line %d at '%s'\n", msg, line_number, yytext);
}
void parseAsmFile(FILE* f)
{
    YY_BUFFER_STATE buffer = yy_create_buffer(f, YY_BUF_SIZE);
    yypush_buffer_state(buffer);

    yyparse();
    yypop_buffer_state();
}
