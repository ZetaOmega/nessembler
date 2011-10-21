#ifndef PATHNAME_H
#define PATHNAME_H

///
// Implements OS-agnostic path name parsing
///

int getCurrentDirectory(char* output_path, int buf_len);
int getDirectory(char* output_path, char* input_path);
#endif

