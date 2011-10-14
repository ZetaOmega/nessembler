#include "pathname.h"
#include <string.h>
#include <stdio.h>

///
// Implements OS-agnostic path name parsing
///

const char* getPathSeperator()
{
    #ifdef _WIN32
        return "\\";
    #else
        return "/";
    #endif
}
int getBaseName(const char* path)
{
    #ifdef _WIN32
        char pathSep = '\\';
    #else
        char pathSep = '/';
    #endif
    int i = strlen(path);
    for(; i >= 0; i--)
    {
        if(path[i] == pathSep)
        {
            return i + 1;
        }
    }
    return 0;
}
int getCurrentDirectory(char* inputPath, int buf_len)
{
    #ifdef WINDOWS
        #include <direct.h>
        #define GetCurrentDir    _getcwd
    #else
        #include <unistd.h>
        #define GetCurrentDir    getcwd
    #endif
    if (!GetCurrentDir(inputPath, buf_len))
    {
        return 1;
    }
    return 0;
}
