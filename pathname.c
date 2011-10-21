#include "pathname.h"
#include <string.h>
#include <stdio.h>

///
// Implements OS-agnostic path name parsing
///

#ifdef WIN32
    #include <Windows.h>
    static const char path_sep = '\\';
#else
    #include <unistd.h>
    static const char path_sep = '/';
#endif

int getCurrentDirectory(char* output_path, int buf_len)
{
    char current_cmd[512];
    #ifdef WIN32
        GetModuleFileName(NULL, current_cmd, sizeof(current_cmd));
    #else
        char procsstr[512];
        sprintf(proc_name, "/proc/%u/exe", getpid());
        readlink(procsstr, current_cmd, sizeof(current_cmd));
    #endif
    //printf("current command: '%s'\n", current_cmd);
    getDirectory(output_path, current_cmd);
    //printf("current path: '%s'\n", output_path);
    return 0;
}
int getDirectory(char* output_path, char* input_path)
{
    int i = strlen(input_path);
    char c;
    char prev_c = 0;
    for(; i >= 0; i--)
    {
        c = input_path[i];
        if((c == '/') ||
            ((c == '\\') &&(prev_c != ' ')))
        {
            strncpy(output_path, input_path, i + 1);
            output_path[i + 1] = 0;
            return 0;
        }
        prev_c = c;
    }
    strcpy(output_path, "");
    return 0;
}
