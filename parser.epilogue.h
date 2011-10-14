#ifndef PARSEREPILOGUE_H
#define PARSEREPILOGUE_H

struct blocktable;

int checkOpcode(unsigned char opcode);
void checkOpcodeOrDie(unsigned char opcode, const char* addressModeName, unsigned int line_number);
int calcAddressRange(unsigned short* addr_diff, unsigned short from_addr, unsigned short to_addr);
struct blocktable* advanceAddress(struct blocktable* bt, unsigned short new_addr, unsigned int line_number);
void bisonError(const char* msg, unsigned int line_number);

#endif

