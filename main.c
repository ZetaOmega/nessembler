#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include "string.h"
#include "symbol.h"
#include "block.h"
#include "pathname.h"
#include "nesrom.h"

struct symtable* globalSymTable = 0;
struct symtable* localSymTable = 0;
struct nesROM* workingROM = 0;
char* inputFileName = 0;
char inputPath[1024];
char* outputFileName = 0;
char assembleDebugFlag = 0;
//defined by parser.y
extern void parseAsmFile(FILE* f);

void exitFunc()
{
    int i;
    freeSymTable(globalSymTable);
    globalSymTable = 0;
    freeSymTable(localSymTable);
    localSymTable = 0;
    freeNESROM(workingROM);
    workingROM = 0;
    if(inputFileName) free(inputFileName);
    inputFileName = 0;
    if(outputFileName) free(outputFileName);
    outputFileName = 0;
}

int main(int argc, char* argv[])
{
    atexit(exitFunc);
    globalSymTable = createSymbolTable();
    localSymTable = createSymbolTable();
    workingROM = createNESROM();

    //
    // Extract command-line parameters
    //
    {
        struct option longopts[] =
        {
            {"input",  required_argument, 0, 'i'},  //Name of assembly source
            {"output", required_argument, 0, 'o'},  //Name of output rom
            {"debug",  no_argument,       0, 'd'},  //Indicates that debug file should be exported
            {0, 0, 0, 0}
        };
        char c;
        while((c = getopt_long(argc, argv, "i:o:d", longopts, 0)) != -1)
        {
            switch(c)
            {
                case 'i':
                    inputFileName = malloc(strlen(optarg) + sizeof('\0'));
                    strcpy(inputFileName, optarg);
                break;
                case 'o':
                    outputFileName = malloc(strlen(optarg) + sizeof('\0'));
                    strcpy(outputFileName, optarg);
                break;
                case 'd':
                    assembleDebugFlag = 1;
                break;
                default:
                    //Badness
                break;
            }
        }
        if(optind < argc)
        {
            inputFileName = malloc(strlen(argv[optind]) + sizeof('\0'));
            strcpy(inputFileName, argv[optind]);
        }
    }

    if(inputFileName)
    {
        //Get the path of the inputFileName
        if(getCurrentDirectory(inputPath, sizeof(inputPath)))
        {
            fprintf(stderr, "nessembler: could not parse file path '%s'\n", inputFileName);
            return 1;
        }
        strcat(inputPath, getPathSeperator());
        strcat(inputPath, inputFileName);
        inputPath[getBaseName(inputPath)] = 0; //Truncate file name

        //printf("input path: %s\n", inputPath);

        FILE* inputFile = fopen(inputFileName, "r");
        if(!inputFile)
        {
            fprintf(stderr, "nessembler: could not open file '%s'\n", inputFileName);
            return 1;
        }
        else
        {
            printf("nessembler: reading source file '%s'\n", inputFileName);
        }

        parseAsmFile(inputFile);
        writeNESROMToFile(workingROM, outputFileName);

        fclose(inputFile);
        inputFile = 0;
    }
    else
    {
        fprintf(stderr, "nessembler: no input files\n");
    }
    
    return 0;
}

