#include "s21_cat.h"

void fileError(char arg[]) {
  printf("cat: %s: No such file or directory\n", arg);
  exit(1);
}

void printUsage() { printf("usage: s21_cat [-benstv] [file ...]\n"); }

size_t getMaxLenString(FILE* file) {
  size_t maxLength = 0;
  size_t currentLength = 0;
  int ch;

  while ((ch = fgetc(file)) != EOF) {
    currentLength++;
    if (ch == '\n') {
      if (currentLength > maxLength) {
        maxLength = currentLength;
      }
      currentLength = 0;
    }
  }

  if (currentLength > maxLength) {
    maxLength = currentLength;
  }

  rewind(file);
  return maxLength;
}

void printFile(arguments arg, char* filepath, int argc, int count) {
  int isLastLineEmpty = 0;
  FILE* file = fopen(filepath, "r");
  size_t lineCount = 1;

  if (file == NULL) {
    fileError(filepath);
    if (count + 1 == argc - 1) exit(0);
    return;
  }

  size_t MaxLenString = getMaxLenString(file);
  char* buff = malloc(MaxLenString + 1);
  if (buff == NULL) {
    printf("Error! memory not allocated.");
    fclose(file);
    exit(1);
  }

  while (fgets(buff, MaxLenString + 1, file) != NULL) {
    if (arg.s & (emptyLines(buff[0], &isLastLineEmpty) == 0)) {
      continue;
    }

    if (arg.b) {
      lineCounter(buff[0], arg, &lineCount);
    } else if (arg.n && !arg.b) {
      printf("%6zu\t", lineCount++);
    }

    charProcessing(buff, arg);
  }

  if (buff != NULL) {
    free(buff);
  }
  fclose(file);
}

int emptyLines(char buff, int* isLastLineEmpty) {
  if ((buff == '\n') && (!*isLastLineEmpty)) {
    *isLastLineEmpty = 1;
  } else if ((buff == '\n') && (*isLastLineEmpty)) {
    return 0;
  } else if (buff != '\n') {
    *isLastLineEmpty = 0;
  }
  return 1;
}

void lineCounter(char buff, arguments arg, size_t* lineCount) {
  if (buff != '\n') {
    printf("%6zu\t", (*lineCount)++);
  } else if (arg.e) {
    printf("      \t");
  }
}

void charProcessing(char* buff, arguments arg) {
  for (size_t i = 0; buff[i] != '\0'; i++) {
    if (arg.e && buff[i] == '\n') {
      printf("$");
    }
    if (buff[i] >= 32 && buff[i] <= 126) {
      putchar(buff[i]);
    } else if (buff[i] == '\t' && arg.t) {
      printf("^I");
    } else if (buff[i] == '\n') {
      putchar('\n');
    } else if (arg.v) {
      unsigned char ch = (unsigned char)buff[i];

      if (ch == 127) {
        printf("^?");
      } else if (ch < 32 && ch != 9 && ch != 10) {
        printf("^%c", ch + 64);
      } else if (ch > 126 /*&& ch < 160*/) {
        printf("M-^%c", (ch - 128) + 64);
      } else {
        putchar(ch);
      }

    } else {
      putchar(buff[i]);
    }
  }
}

void CatNoPath() {
  int c;
  while ((c = getchar()) != EOF) {
    putchar(c);
  }
}

arguments argument_parser(int argc, char* argv[]) {
  struct option long_options[] = {{"number-nonblank", 0, 0, 'b'},
                                  {"number", 0, 0, 'n'},
                                  {"squeeze-blank", 0, 0, 's'},
                                  {0, 0, 0, 0}};

  arguments arg = {0};
  int opt = 0;
  while ((opt = getopt_long(argc, argv, "benstTvE", long_options, NULL)) !=
         -1) {
    switch (opt) {
      case 'b':
        arg.b = 1;
        break;
      case 'e':
        arg.e = 1;
        arg.v = 1;
        break;
      case 'n':
        arg.n = 1;
        break;
      case 's':
        arg.s = 1;
        break;
      case 't':
        arg.t = 1;
        arg.v = 1;
        break;
      case 'v':
        arg.v = 1;
        break;
      case 'T':
        arg.t = 1;
        break;
      case 'E':
        arg.e = 1;
        break;
      case '?':
        printUsage();
        exit(1);
      default:
        break;
    }
  }
  return arg;
}

int main(int argc, char* argv[]) {
  arguments arg = argument_parser(argc, argv);
  if (optind == argc) {
    CatNoPath();
  } else {
    for (int i = optind; i < argc; i++) {
      printFile(arg, argv[i], argc, i);
    }
  }
  return 0;
}