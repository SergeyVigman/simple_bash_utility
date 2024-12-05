#include "s21_cat.h"

void fileError(char arg[]) {
  printf("cat: %s: No such file or directory\n", arg);
  exit(1);
}

void printUsage() { printf("usage: s21_cat [-benstv] [file ...]\n"); }

void printFile(arguments arg, char* filepath, int argc, int count) {
  FILE* file = fopen(filepath, "r");
  if (file) {
    fileProcessing(file, arg);
  } else {
    fileError(filepath);
    if (count + 1 == argc - 1)
      exit(EXIT_FAILURE);  // проверка что файл последний
  }

  fclose(file);
}

void printLineNumber(arguments arg, size_t* line_counter, int ch) {
  // нумерация строк
  if (arg.b && ch != '\n') {
    printf("%6zu\t", (*line_counter)++);
  } else if (arg.n && !arg.b) {
    printf("%6zu\t", (*line_counter)++);
  }
}

void processNewline(arguments arg, int last_char, int* blank_line_streak) {
  // новая строка
  if (arg.e) {
    if (last_char == '\n' && arg.b) {
      printf("      \t");
    }
    printf("$");
  }
  putchar('\n');

  *blank_line_streak = (last_char == '\n') ? 1 : 0;
}

void charProcessing(int ch, arguments arg) {
  // обработка символов
  if (ch >= 32 && ch <= 126) {
    putchar(ch);
  } else if (ch == '\t' && arg.t) {
    printf("^I");
  } else if (arg.v) {
    if (ch == 127) {
      printf("^?");
    } else if (ch < 32 && ch != '\t' && ch != '\n') {
      printf("^%c", ch + 64);
    } else if (ch > 126 && ch < 160) {
      printf("M-^%c", (ch - 128) + 64);
    } else {
      putchar(ch);
    }
  } else {
    putchar(ch);
  }
}

void fileProcessing(FILE* file, arguments arg) {
  size_t line_counter = 1;
  int ch;
  int last_char = '\n';
  int blank_line_streak = 0;

  while ((ch = fgetc(file)) != EOF) {
    if (last_char == '\n') {
      if (arg.s && blank_line_streak && ch == '\n') {  // -s
        continue;
      }
      // нумерация строк
      printLineNumber(arg, &line_counter, ch);
    }
    if (ch == '\n') {
      // новая строка
      processNewline(arg, last_char, &blank_line_streak);
    } else {
      blank_line_streak = 0;
      // обработка символов
      charProcessing(ch, arg);
    }

    last_char = ch;
  }
}

void catNoPath() {
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
        arg.v = 0;
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
    catNoPath();
  } else {
    for (int i = optind; i < argc; i++) {
      printFile(arg, argv[i], argc, i);
    }
  }
  return 0;
}