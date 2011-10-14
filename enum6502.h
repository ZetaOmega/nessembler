#ifndef enum6502_H
#define enum6502_H

#define IN6502_ADC 0x00 // add with carry
#define IN6502_AND 0x01 //and (with accumulator)
#define IN6502_ASL 0x02 //arithmetic shift left
#define IN6502_BCC 0x03 //branch on carry clear
#define IN6502_BCS 0x04 //branch on carry set
#define IN6502_BEQ 0x05 //branch on equal (zero set)
#define IN6502_BIT 0x06 //bit test
#define IN6502_BMI 0x07 //branch on minus (negative set)
#define IN6502_BNE 0x08 //branch on not equal (zero clear)
#define IN6502_BPL 0x09 //branch on plus (negative clear)
#define IN6502_BRK 0x0A //interrupt
#define IN6502_BVC 0x0B //branch on overflow clear
#define IN6502_BVS 0x0C //branch on overflow set
#define IN6502_CLC 0x0D //clear carry
#define IN6502_CLD 0x0E //clear decimal
#define IN6502_CLI 0x0F //clear interrupt disable
#define IN6502_CLV 0x10 //clear overflow
#define IN6502_CMP 0x11 //compare (with accumulator)
#define IN6502_CPX 0x12 //compare with X
#define IN6502_CPY 0x13 //compare with Y
#define IN6502_DEC 0x14 //decrement
#define IN6502_DEX 0x15 //decrement X
#define IN6502_DEY 0x16 //decrement Y
#define IN6502_EOR 0x17 //exclusive or (with accumulator)
#define IN6502_INC 0x18 //increment
#define IN6502_INX 0x19 //increment X
#define IN6502_INY 0x1A //increment Y
#define IN6502_JMP 0x1B //jump
#define IN6502_JSR 0x1C //jump subroutine
#define IN6502_LDA 0x1D //load accumulator
#define IN6502_LDX 0x1E //load X
#define IN6502_LDY 0x1F //load Y
#define IN6502_LSR 0x20 //logical shift right
#define IN6502_NOP 0x21 //no operation
#define IN6502_ORA 0x22 //or with accumulator
#define IN6502_PHA 0x23 //push accumulator
#define IN6502_PHP 0x24 //push processor status (SR)
#define IN6502_PLA 0x25 //pull accumulator
#define IN6502_PLP 0x26 //pull processor status (SR)
#define IN6502_ROL 0x27 //rotate left
#define IN6502_ROR 0x28 //rotate right
#define IN6502_RTI 0x29 //return from interrupt
#define IN6502_RTS 0x2A //return from subroutine
#define IN6502_SBC 0x2B //subtract with carry
#define IN6502_SEC 0x2C //set carry
#define IN6502_SED 0x2D //set decimal
#define IN6502_SEI 0x2E //set interrupt disable
#define IN6502_STA 0x2F //store accumulator
#define IN6502_STX 0x30 //store X
#define IN6502_STY 0x31 //store Y
#define IN6502_TAX 0x32 //transfer accumulator to X
#define IN6502_TAY 0x33 //transfer accumulator to Y
#define IN6502_TSX 0x34 //transfer stack pointer to X
#define IN6502_TXA 0x35 //transfer X to accumulator
#define IN6502_TXS 0x36 //transfer X to stack pointer
#define IN6502_TYA 0x37 //transfer Y to accumulator
#define IN6502_TOTAL 0x38 //size of dimension

#define ADR6502_IMM       0x00 //immediate address
#define ADR6502_ZEROPAGE  0x01 //zero page address
#define ADR6502_ZEROPAGEX 0x02 //zero page, x address
#define ADR6502_ABSOLUTE  0x03 //absolute address
#define ADR6502_ABSX      0x04 //absolute, x address
#define ADR6502_ABSY      0x05 //absolute, y address
#define ADR6502_INDX      0x06 //(index, x) address
#define ADR6502_INDY      0x07 //(index), y address
#define ADR6502_ZEROPAGEY 0x08 //zero page, y address
#define ADR6502_ACC       0x09 //accumulator address
#define ADR6502_INDIRECT  0x0A //(indirect) address
#define ADR6502_IMPLIED   0x0B //implied address
#define ADR6502_RELATIVE  0x0C //relative address
#define ADR6502_TOTAL     0x0D //size of dimension

#define IN6502_INVALID_OPCODE 0x02

extern unsigned char opcode6502[IN6502_TOTAL][ADR6502_TOTAL];
extern char* name6502[IN6502_TOTAL];

#endif

