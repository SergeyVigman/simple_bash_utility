#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

typedef struct arguments {
  int b, e, n, s, t, v, T, E;
} arguments;

arguments argument_parser(int argc, char *argv[]);
void fileError(char arg[]);
void printUsage();
void printFile(arguments arg, char *filepath, int argc, int count);
void catNoPath();
void fileProcessing(FILE *file, arguments arg);
void charProcessing(int ch, arguments arg);
void processNewline(arguments arg, int last_char, int *blank_line_streak);
void printLineNumber(arguments arg, size_t *line_counter, int ch);

#endif