#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "assembledebug.h"

struct debugrec* createDebugRecord(unsigned int line_number, char* instruction_name, char* format_str)
{
    struct debugrec* rec = malloc(sizeof(struct debugrec));
    rec->line_number = line_number;
    if(instruction_name)
    {
        strncpy(rec->instruction_name, instruction_name, sizeof(rec->instruction_name));
    }
    else
    {
        rec->instruction_name[0] = 0; //Empty string
    }
    if(format_str)
    {
        strncpy(rec->format_str, format_str, sizeof(rec->format_str));
    }
    else
    {
        rec->format_str[0] = 0; //Empty string    
    }
    return rec;
}

