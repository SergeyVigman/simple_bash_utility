#ifndef S21_GREP_H
#define S21_GREP_H

#define _GNU_SOURCE
#define usagePath "usage.txt"

#include <ctype.h>
#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct arguments {
  int e, i, v, c, l, n, h, s, o, f;
} arguments;

void cleanup(FILE *file, char *pattern);
void printFile(const char *filepath);
void fileError(const char *filepath, arguments arg);
void printFile(const char *filepath);
void grepThisFile(FILE *file, arguments arg, regex_t *preg, char *filenam,
                  int more_than_1_file);
void openFileAndFindPattern(int argc, char *argv[], arguments arg);
arguments argument_parser(int argc, char *argv[]);
char *getPatternFromFile(const char *pattern_file_path, arguments arg);
void memalloc_error(FILE *file);
char *processLineForIgnoreCase(char *line, arguments arg, regex_t *preg,
                               char *lower_line);
void printTotalMatch(arguments arg, int *more_than_1_file, char *filename,
                     int *total_matches, int *MatchInFile);
void output(regmatch_t match, arguments arg, int *more_than_1_file,
            char *filename, int *line_count, char *line);
FILE *openFile(const char *file_path);
int isFileEmpty(FILE *file);
void processFiles(int argc, char *argv[], arguments arg, regex_t *preg);
int compileRegex(regex_t *preg, const char *pattern);
char *processPattern(int argc, char *argv[], arguments arg,
                     int *pattern_allocated, int *pattern_is_blank);
#endif