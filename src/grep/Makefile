CC = gcc
FLAGS = -Wall -Wextra -Werror -std=c11

all: s21_grep

s21_cat: s21_grep.c s21_grep.h
		$(CC) $(FLAGS) s21_grep.c -o s21_grep

clang:
		clang-format -i *.h *.c

clean:
		rm s21_grep

rebuild:
		make clean all