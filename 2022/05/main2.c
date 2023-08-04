#include "C:\headers\rstypes.h"
#include <stdio.h>
#include <stdlib.h>

#define MAX_BUFFER 1024
#define MAX_SIZE 60
#define MAX_STACK 9

struct node
{
	char value[MAX_SIZE];
	u32 size;
};
typedef struct node *stack;

stack create_stack();
char remove_from_stack(stack);
void insert_in_stack(stack, char);
void insert_in_stack_str(stack, string);
void print_stack(stack);
void print_stack_debug(stack);
bool char_in_string(char, string);
u32 string_to_u32(string, u32*);
void print_stacks_v(stack*, u32);

int main()
{
	string buffer = malloc(MAX_BUFFER);
	stack array[MAX_STACK];
	u32 i, crates_moving, og_stack, next_stack;
	for(i = 0; i < MAX_STACK; i++)
		array[i] = create_stack();
	u32 curr_stack = 0;
	insert_in_stack_str(array[0], "WDGBHRV");
	insert_in_stack_str(array[1], "JNGCRF");
	insert_in_stack_str(array[2], "LSFHDNJ");
	insert_in_stack_str(array[3], "JDSV");
	insert_in_stack_str(array[4], "SHDRQWNV");
	insert_in_stack_str(array[5], "PGHCM");
	insert_in_stack_str(array[6], "FJBGLZHC");
	insert_in_stack_str(array[7], "SJR");
	insert_in_stack_str(array[8], "LGSRBNVM");
	
	FILE* fp = fopen("file.txt", "r");
	
	for(i = 0; i < 10; i++)
		fgets(buffer, MAX_BUFFER, fp);
	
	print_stacks_v(array, MAX_STACK);
	while(fgets(buffer, MAX_BUFFER, fp) != NULL)
	{
		printf("%s", buffer);
		while(!char_in_string(buffer[0], "0123456789"))
			buffer++;
		crates_moving = string_to_u32(buffer, &i);
//		printf("%u - crates_moving\n", curr_stack);
		buffer += i;
		while(!char_in_string(buffer[0], "0123456789"))
			buffer++;
		og_stack = string_to_u32(buffer, &i);
//		printf("%u - next_stack\n", curr_stack);
		buffer += i;
		while(!char_in_string(buffer[0], "0123456789"))
			buffer++;
		next_stack = string_to_u32(buffer, &i);
//		printf("%u - next_stack\n", curr_stack);
		og_stack--;
		next_stack--;
//		printf("crates_moving: %u\n", crates_moving);
//		printf("og_stack: %u\n", og_stack);
//		printf("next_stack: %u\n", next_stack);
		for(i = 0; i < crates_moving; i++)
		{
//			printf("og_stack->size(before): %u\n", array[og_stack]->size);
			char temp = remove_from_stack(array[og_stack]);
//			printf("og_stack->size(afer): %u\n", array[og_stack]->size);
//			printf("next_stack->size(before): %u\n", array[next_stack]->size);
			insert_in_stack(array[next_stack], temp);
//			printf("next_stack->size(after): %u\n", array[next_stack]->size);
		}
//		print_stacks_v(array, MAX_STACK);
		for(i = 0; i < MAX_STACK; i++)
//			printf("array[%u]->size: %u :: str: %s\n", i, array[i]->size, array[i]->value);
		curr_stack++;
	}
	
	fclose(fp);
	free(buffer);
	for(i = 0; i < MAX_STACK; i++)
		free(array[i]);
	return 727;
}

stack create_stack()
{
	stack result = malloc(sizeof(*result));
	result->size = 0;
	return result;
}
void insert_in_stack(stack stack, char value)
{
	stack->value[stack->size++] = value;
}
void insert_in_stack_str(stack stack, string str)
{
	for(u32 i = 0; str[i] != '\0'; i++)
		insert_in_stack(stack, str[i]);
}
char remove_from_stack(stack stack)
{
	return stack->value[--stack->size];
}
void print_stack(stack stack)
{
	for(u32 i = stack->size - 1;; i--)
	{
		printf("%c ", stack->value[i]);	
		if(i == 0)
			break;
	}
	printf("\n");
}
void print_stack_debug(stack stack)
{
	printf("%u\t%s\n", stack->size, stack->value);
}
bool char_in_string(char c, string str)
{
	for(u32 i = 0; str[i] != '\0'; i++)
		if(c == str[i])
			return true;
	return false;
}
u32 string_to_u32(string str, u32* u32_pointer)
{
	u32 result = 0, i = 0;
	while(char_in_string(str[i], "0123456789"))
	{
		result *= 10;
		result += str[i] - '0';
		i++;
	}
	*u32_pointer = i;
	return result;
}
void print_stacks_v(stack* array, u32 size)
{
	u32 max = 0;
	i32 i, j;
	for(i = 0; i < size; i++)
		if(array[i]->size > max)
			max = array[i]->size;
	for(i = 0; i < max; i++)
	{
		for(j = 0; j < size; j++)
			if(array[j]->size + i >= max)
				printf("[%c] ", array[j]->value[max - i - 1]);
			else
				printf("    ");
		printf("\n");
	}
}
