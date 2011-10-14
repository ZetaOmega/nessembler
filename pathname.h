#ifndef PATHNAME_H
#define PATHNAME_H

///
// Implements OS-agnostic path name parsing
///

const char* getPathSeperator();
int getBaseName(const char* path);
int getCurrentDirectory(char* inputPath, int buf_len);
#endif

