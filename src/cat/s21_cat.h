#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

typedef struct arguments {
  int b, e, n, s, t, v, T, E;
} arguments;

size_t getMaxLenString(FILE* file);
arguments argument_parser(int argc, char* argv[]);
void fileError(char arg[]);
void printUsage();
void printFile(arguments arg, char* filepath, int argc, int count);
void CatNoPath();
void charProcessing(char* buff, arguments arg);
void lineCounter(char buff, arguments arg, size_t* lineCount);
int emptyLines(char buff, int* isLastLineEmpty);

#endif