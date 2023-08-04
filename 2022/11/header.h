#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
typedef uint64_t u64;
typedef struct monkey* monkey;
monkey create_monkey(int);
void insert(monkey, u64);
u64 remove_item(monkey);
void update_item(monkey);
void throw_items(int, monkey*, int*);
