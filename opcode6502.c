#include "enum6502.h"

#define XXXX IN6502_INVALID_OPCODE

unsigned char opcode6502[IN6502_TOTAL][ADR6502_TOTAL] =
{

//        IMM   ZEROPAGE  ZEROPAGEX  ABS   ABSX   ABSY   INDX   INDY   ZEROPAGEY  ACC   INDIRECT   IMPLIED  RELATIVE
/*ADC*/ { 0x69, 0x65,     0x75,      0x6D, 0x7D,  0x79,  0x61,  0x71,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*AND*/ { 0x29, 0x25,     0x35,      0x2D, 0x3D,  0x39,  0x21,  0x31,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*ASL*/ { XXXX, 0x06,     0x16,      0x0E, 0x1E,  XXXX,  XXXX,  XXXX,  XXXX,      0X0A, XXXX,      XXXX,    XXXX },
/*BCC*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    0x90 },
/*BCS*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    0xB0 },
/*BEQ*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    0xF0 },
/*BIT*/ { XXXX, 0x24,     XXXX,      0x2C, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*BMI*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    0x30 },
/*BNE*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    0xD0 },
/*BPL*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    0x10 },
/*BRK*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x00,    XXXX },
/*BVC*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    0x50 },
/*BVS*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    0x70 },
/*CLC*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x18,    XXXX },
/*CLD*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xD8,    XXXX },
/*CLI*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x58,    XXXX },
/*CLV*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xB8,    XXXX },
/*CMP*/ { 0xC9, 0xC5,     0xD5,      0xCD, 0xDD,  0xD9,  0xC1,  0xD1,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*CPX*/ { 0xE0, 0xE4,     XXXX,      0xEC, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*CPY*/ { 0xC0, 0xC4,     XXXX,      0xCC, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*DEC*/ { XXXX, 0xC6,     0xD6,      0xCE, 0xDE,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*DEX*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xCA,    XXXX },
/*DEY*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x88,    XXXX },
/*EOR*/ { 0x49, 0x45,     0x55,      0x4D, 0x5D,  0x59,  0x41,  0x51,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*INC*/ { XXXX, 0xE6,     0xF6,      0xEE, 0xFE,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*INX*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xE8,    XXXX },
/*INY*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xC8,    XXXX },
/*JMP*/ { XXXX, XXXX,     XXXX,      0x4C, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, 0x6C,      XXXX,    XXXX },
/*JSR*/ { XXXX, XXXX,     XXXX,      0x20, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*LDA*/ { 0xA9, 0xA5,     0xB5,      0xAD, 0xBD,  0xB9,  0xA1,  0xB1,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*LDX*/ { 0xA2, 0xA6,     XXXX,      0xAE, XXXX,  0xBE,  XXXX,  XXXX,  0xB6,      XXXX, XXXX,      XXXX,    XXXX },
/*LDY*/ { 0xA0, 0xA4,     0xB4,      0xAC, 0xBC,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*LSR*/ { XXXX, 0x46,     0x56,      0x4E, 0x5E,  XXXX,  XXXX,  XXXX,  XXXX,      0X4A, XXXX,      XXXX,    XXXX },
/*NOP*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xEA,    XXXX },
/*ORA*/ { 0x09, 0x05,     0x15,      0x0D, 0x1D,  0x19,  0x01,  0x11,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*PHA*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x48,    XXXX },
/*PHP*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x08,    XXXX },
/*PLA*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x68,    XXXX },
/*PLP*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x28,    XXXX },
/*ROL*/ { XXXX, 0x26,     0x36,      0x2E, 0x3E,  XXXX,  XXXX,  XXXX,  XXXX,      0X2A, XXXX,      XXXX,    XXXX },
/*ROR*/ { XXXX, 0x66,     0x76,      0x6E, 0x7E,  XXXX,  XXXX,  XXXX,  XXXX,      0x6A, XXXX,      XXXX,    XXXX },
/*RTI*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x40,    XXXX },
/*RTS*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x60,    XXXX },
/*SBC*/ { 0xE9, 0xE5,     0xF5,      0xED, 0xFD,  0xF9,  0xE1,  0xF1,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*SEC*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x38,    XXXX },
/*SED*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xF8,    XXXX },
/*SEI*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x78,    XXXX },
/*STA*/ { XXXX, 0x85,     0x95,      0x8D, 0x9D,  0x99,  0x81,  0x91,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*STX*/ { XXXX, 0x86,     XXXX,      0x8E, XXXX,  XXXX,  XXXX,  XXXX,  0x96,      XXXX, XXXX,      XXXX,    XXXX },
/*STY*/ { XXXX, 0x84,     0x94,      0x8C, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      XXXX,    XXXX },
/*TAX*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xAA,    XXXX },
/*TAY*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xA8,    XXXX },
/*TSX*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0xBA,    XXXX },
/*TXA*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x8A,    XXXX },
/*TXS*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x9A,    XXXX },
/*TYA*/ { XXXX, XXXX,     XXXX,      XXXX, XXXX,  XXXX,  XXXX,  XXXX,  XXXX,      XXXX, XXXX,      0x98,    XXXX },
    
};

char* name6502[IN6502_TOTAL] =
{
    "ADC", //add with carry
    "AND", //and (with accumulator)
    "ASL", //arithmetic shift left
    "BCC", //branch on carry clear
    "BCS", //branch on carry set
    "BEQ", //branch on equal (zero set)
    "BIT", //bit test
    "BMI", //branch on minus (negative set)
    "BNE", //branch on not equal (zero clear)
    "BPL", //branch on plus (negative clear)
    "BRK", //interrupt
    "BVC", //branch on overflow clear
    "BVS", //branch on overflow set
    "CLC", //clear carry
    "CLD", //clear decimal
    "CLI", //clear interrupt disable
    "CLV", //clear overflow
    "CMP", //compare (with accumulator)
    "CPX", //compare with X
    "CPY", //compare with Y
    "DEC", //decrement
    "DEX", //decrement X
    "DEY", //decrement Y
    "EOR", //exclusive or (with accumulator)
    "INC", //increment
    "INX", //increment X
    "INY", //increment Y
    "JMP", //jump
    "JSR", //jump subroutine
    "LDA", //load accumulator
    "LDX", //load X
    "LDY", //load Y
    "LSR", //logical shift right
    "NOP", //no operation
    "ORA", //or with accumulator
    "PHA", //push accumulator
    "PHP", //push processor status (SR)
    "PLA", //pull accumulator
    "PLP", //pull processor status (SR)
    "ROL", //rotate left
    "ROR", //rotate right
    "RTI", //return from interrupt
    "RTS", //return from subroutine
    "SBC", //subtract with carry
    "SEC", //set carry
    "SED", //set decimal
    "SEI", //set interrupt disable
    "STA", //store accumulator
    "STX", //store X
    "STY", //store Y
    "TAX", //transfer accumulator to X
    "TAY", //transfer accumulator to Y
    "TSX", //transfer stack pointer to X
    "TXA", //transfer X to accumulator
    "TXS", //transfer X to stack pointer
    "TYA" //transfer Y to accumulator
};
