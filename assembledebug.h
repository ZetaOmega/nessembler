#ifndef ASSEMBLEDEBUG_H
#define ASSEMBLEDEBUG_H

struct debugrec
{
    unsigned int line_number;
    char instruction_name[5];
    char format_str[32];
};

struct debugrec* createDebugRecord(unsigned int line_number, char* instruction_name, char* format_str);

#endif
