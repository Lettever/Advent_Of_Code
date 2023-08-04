#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#define MAX_SIZE 60
#define MAX_STACK 9
struct node
{
	char value[MAX_SIZE];
	size_t size;
};
typedef struct node *stack;
stack create_stack(void);
char remove_from_stack(stack);
void insert_in_stack(stack, char);
void insert_in_stack_str(stack, char*);
void print_stack(stack);
int elem_in_array(char, char*);
int main()
{
	stack stack[MAX_STACK + 1];
	size_t i;
	uint32_t op[3] = {0 ,0, 0}, current_index = 0;
	const size_t max = 20;
	for(i = 0; i < MAX_STACK + 1; i++)
		stack[i] = create_stack();
	insert_in_stack_str(stack[0], "WDGBHRV");
	insert_in_stack_str(stack[1], "JNGCRF");
	insert_in_stack_str(stack[2], "LSFHDNJ");
	insert_in_stack_str(stack[3], "JDSV");
	insert_in_stack_str(stack[4], "SHDRQWNV");
	insert_in_stack_str(stack[5], "PGHCM");
	insert_in_stack_str(stack[6], "FJBGLZHC");
	insert_in_stack_str(stack[7], "SJR");
	insert_in_stack_str(stack[8], "LGSRBNVM");
	const size_t buffer = 50;
	char *str = malloc(buffer * sizeof(char));
	FILE *fp = fopen("file.txt", "r");
	for(i = 0; i < 10; i++)
		fgets(str, buffer, fp);
	while(fgets(str, buffer, fp) != NULL)
	{
		printf("%s", str);
		for(i = 0; str[i] != '\0'; i++)
		{
			if(elem_in_array(str[i], "0123456789") == 1)
			{
				while(elem_in_array(str[i], "0123456789") == 1)
				{
					op[current_index] *= 10;
					op[current_index] += str[i] - '0';
					i++;
				}
				current_index++;
			}
		}
		printf("\nop[0]: %u\top[1]: %u\top[2]: %u\n\n", op[0], op[1], op[2]);
		while(op[0] != 0)
		{
			char temp_char = remove_from_stack(stack[op[1]-1]);
			insert_in_stack(stack[9], temp_char);
			op[0]--;
		}
		while(stack[9]->size != 0)
		{
			char temp_char = remove_from_stack(stack[9]);
			insert_in_stack(stack[op[2]-1], temp_char);
		}
		op[0] = 0;
		op[1] = 0;
		op[2] = 0;
		current_index = 0;
	}
	if(feof(fp))
		fclose(fp);
	for(i = 0; i < MAX_STACK+1; i++)
		printf("%c", remove_from_stack(stack[i]));
}
stack create_stack(void)
{
	stack result = malloc(sizeof(struct node));
	strcpy(result->value, "");
	result->size = 0;
	return result;
}
void insert_in_stack(stack stack, char value)
{
	if(stack->size + 1 > MAX_SIZE)
	{
		printf("Stack is full\n");
		return;
	}
	stack->value[stack->size++] = value;
}
char remove_from_stack(stack stack)
{
	if(stack->size == 0)
	{
		printf("Stack is empty\n");
		return '\0';
	}
	stack->size--;
	return stack->value[stack->size];
}
void print_stack(stack stack)
{
	size_t i;
	for(i = stack->size - 1; (int)i >= 0; i--)
		printf("%c\n", stack->value[i]);	
}
void insert_in_stack_str(stack stack, char *str)
{
	size_t i;
	for(i = 0; str[i] != '\0'; i++)
		insert_in_stack(stack, str[i]);
}
int elem_in_array(char c, char *str)
{
	size_t i;
	for(i = 0; str[i] != '\0'; i++)
		if(c == str[i])
			return 1;
	return 0;
}
