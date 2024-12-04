#include "s21_grep.h"

void fileError(const char *filepath, arguments arg) {
  if (!arg.s) printf("grep: %s: No such file or directory\n", filepath);
  exit(EXIT_FAILURE);
}

void printFile(const char *filepath) {
  FILE *file = fopen(filepath, "r");
  if (!file) {
    printf("file: %s not found.\n", filepath);
    exit(EXIT_FAILURE);
  }
  int ch;
  while ((ch = fgetc(file)) != EOF) {
    putchar(ch);
  }
  fclose(file);
}

void memalloc_error(FILE *file) {
  perror("Memory allocation error");
  fclose(file);
  exit(EXIT_FAILURE);
}

int isFileEmpty(FILE *file) {
  fseek(file, 0, SEEK_END);
  int is_empty = ftell(file) == 0;
  rewind(file);
  return is_empty;
}

FILE *openFile(const char *file_path) {
  FILE *file = fopen(file_path, "r");
  if (!file) {
    printf("grep: %s: No such file or directory\n", file_path);
    exit(EXIT_FAILURE);
  }
  return file;
}

char *getPatternFromFile(const char *pattern_file_path, arguments arg) {
  FILE *file = openFile(pattern_file_path);
  if (isFileEmpty(file)) {
    fclose(file);
    return NULL;
  }

  size_t buffer_size = 1024;
  char *patterns = malloc(buffer_size);
  if (!patterns) memalloc_error(file);
  patterns[0] = '\0';
  char line[256];

  //  идем по строкам
  while (fgets(line, sizeof(line), file) != NULL) {
    line[strcspn(line, "\n")] = '\0';  // line[индекс \n]
    if (line[0] == '#' || line[0] == '\0') continue;

    // хватит ли места для новой строки
    if (strlen(patterns) + strlen(line) + 2 > buffer_size) {
      buffer_size *= 2;
      void *new_patterns = realloc(patterns, buffer_size);
      if (!new_patterns) {
        free(patterns);
        memalloc_error(file);
      }
      patterns = new_patterns;
    }

    if (strlen(line) == 0) {
      strcat(patterns, ".*|");
    } else {
      strcat(patterns, line);
      strcat(patterns, "|");
    }
  }

  fclose(file);
  if (strlen(patterns) > 0 && patterns[strlen(patterns) - 1] == '|')
    patterns[strlen(patterns) - 1] = '\0';

  return patterns;
}

char *processLineForIgnoreCase(char *line, arguments arg, regex_t *preg,
                               char *lower_line) {
  if (!lower_line) {
    printf("-> \tgrep -i: STRDUP FAIL\n");
    free(line);
    regfree(preg);
    exit(EXIT_FAILURE);
  }
  for (int i = 0; lower_line[i]; ++i) {
    lower_line[i] = tolower(lower_line[i]);
  }
  return lower_line;
}

void grepThisFile(FILE *file, arguments arg, regex_t *preg, char *filename,
                  int more_than_1_file) {
  if (arg.h) more_than_1_file = 0;  // -h

  int total_matches = 0;
  int line_count = 0;
  int MatchInFile = 0;
  char *line = NULL;
  size_t linelen = 0;

  regmatch_t match;

  // идем по строчкам
  while ((linelen = getline(&line, &linelen, file)) != -1) {
    line_count++;

    char *proccesed_line = line;
    char *lower_line = strdup(line);

    if (arg.i)
      proccesed_line = processLineForIgnoreCase(line, arg, preg, lower_line);

    int match_result =
        regexec(preg, proccesed_line, 1, &match, 0);  // 0 -> MATCH
    int should_print =
        (!match_result && !arg.v) || (match_result && arg.v);  // -v

    if (should_print) {
      MatchInFile = 1;
      total_matches++;

      output(match, arg, &more_than_1_file, filename, &line_count, line);
    }

    free(lower_line);
  }

  if (arg.c)
    printTotalMatch(arg, &more_than_1_file, filename, &total_matches,
                    &MatchInFile);

  if ((MatchInFile && arg.l && !arg.c) || (!MatchInFile && arg.l && arg.v))
    printf("%s\n", filename);  // -l

  free(line);
}

void output(regmatch_t match, arguments arg, int *more_than_1_file,
            char *filename, int *line_count, char *line) {
  if (!arg.c && !arg.l) {
    if (*more_than_1_file) printf("%s:", filename);
    if (arg.n) printf("%d:", *line_count);

    if (arg.o && !arg.v)
      printf("%.*s\n", (int)(match.rm_eo - match.rm_so), line + match.rm_so);
    else
      printf("%s", line);
  }
}

void printTotalMatch(arguments arg, int *more_than_1_file, char *filename,
                     int *total_matches, int *MatchInFile) {
  if (arg.l && *total_matches > 0) *total_matches = 1;
  if (*more_than_1_file)
    printf("%s:%d\n", filename, *total_matches);
  else {
    printf("%d\n", *total_matches);
  }
  if (arg.l && *MatchInFile) {
    printf("%s\n", filename);
  }
}

char *processPattern(int argc, char *argv[], arguments arg,
                     int *pattern_allocated, int *pattern_is_blank) {
  char *pattern = NULL;
  if (arg.f) {  // -f
    pattern = getPatternFromFile(argv[optind], arg);
    if (!pattern) {
      *pattern_is_blank = 1;
      if (arg.c) printf("0\n");
      if (arg.v) pattern = "^$";
      if (!arg.v) return NULL;
    } else {
      *pattern_allocated = 1;
    }
  } else {  // если паттерн передан напрямую
    pattern = argv[optind];
    if (pattern && strlen(pattern) == 0) *pattern_is_blank = 1;
  }

  if (pattern[0] == '\0')
    pattern = ".*";  // если паттерн пуст, совпадает с любым текстом

  if (arg.i && strcmp(pattern, "^$") != 0) {  // -i
    char *pattern_copy = strdup(pattern);
    if (!pattern_copy) {
      perror("strdup failed");
      return NULL;
    }
    for (size_t i = 0; pattern_copy[i]; ++i) {
      pattern_copy[i] = tolower(pattern_copy[i]);
    }

    if (pattern != pattern_copy && pattern != argv[optind] &&
        *pattern_allocated) {
      free(pattern);
    }
    pattern = pattern_copy;
  }

  return pattern;
}

void openFileAndFindPattern(int argc, char *argv[], arguments arg) {
  int pattern_allocated = 0;
  int pattern_is_blank = 0;

  if (optind >= argc) {
    printf("-> \tgrep: NO PATTERN\n");
    exit(EXIT_FAILURE);
  }

  char *pattern =
      processPattern(argc, argv, arg, &pattern_allocated, &pattern_is_blank);
  if (pattern == NULL) return;

  regex_t preg_storage;
  regex_t *preg = &preg_storage;
  if (compileRegex(preg, pattern)) {
    if (pattern) free(pattern);
    exit(EXIT_FAILURE);
  }

  // по файлам
  processFiles(argc, argv, arg, preg);

  regfree(preg);

  if (strcmp(pattern, "^&") != 0 && pattern && pattern != argv[optind] &&
      !pattern_is_blank) {
    free(pattern);
  }
}

void processFiles(int argc, char *argv[], arguments arg, regex_t *preg) {
  int more_than_1_file = 0;
  for (int i = optind + 1; i < argc; i++) {
    if (argv[i][0] == '-') continue;
    char *filepath = argv[i];

    if (i + 1 < argc)
      more_than_1_file = 1;  // если более 1 файла, надо печатать имя файла

    FILE *file = fopen(filepath, "r");
    if (file == NULL) {
      fileError(filepath, arg);
    }
    grepThisFile(file, arg, preg, filepath, more_than_1_file);
    fclose(file);
  }
}

int compileRegex(regex_t *preg, const char *pattern) {
  if (regcomp(preg, pattern, REG_EXTENDED)) {
    regfree(preg);
    return 1;
  }
  return 0;
}

arguments argument_parser(int argc, char *argv[]) {
  arguments arg = {0};
  int opt = 0;
  while ((opt = getopt(argc, argv, "eivclnhsof")) != -1) {
    switch (opt) {
      case 'e':
        arg.e = 1;
        break;
      case 'i':
        arg.i = 1;
        break;
      case 'v':
        arg.v = 1;
        break;
      case 'c':
        arg.c = 1;
        break;
      case 'l':
        arg.l = 1;
        break;
      case 'n':
        arg.n = 1;
        break;
      case 'h':
        arg.h = 1;
        break;
      case 's':
        arg.s = 1;
        break;
      case 'o':
        arg.o = 1;
        break;
      case 'f':
        arg.f = 1;
        break;
      case '?':
        printFile(usagePath);
        exit(EXIT_FAILURE);
      default:
        break;
    }
  }
  return arg;
}

int main(int argc, char *argv[]) {
  arguments arg = argument_parser(argc, argv);
  if (argc < 2) {
    printFile(usagePath);
    return 1;
  }
  openFileAndFindPattern(argc, argv, arg);
  return 0;
}