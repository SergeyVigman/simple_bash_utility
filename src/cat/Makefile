CC = gcc
FLAGS = -Wall -Wextra -Werror -std=c11

all: s21_cat

s21_cat: s21_cat.c s21_cat.h
		$(CC) $(FLAGS) s21_cat.c -o s21_cat

clang:
		clang-format -i *.h *.c

clean:
		rm s21_cat

rebuild:
		make clean all