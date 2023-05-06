#include "_rstypes.h"
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#define MAX 15
#define BUFFER_SIZE 1024
typedef struct
{
	string name;
	u64 size;
}file;
typedef struct s_folder* folder;
struct s_folder
{
	folder prev;
	string name;
	folder *folder_array;
	u8 folder_size;
	file *file_array;
	u8 file_size;
	u64 size;
};

folder create_folder(string);
void insert_folder_in_folder(folder, folder);
void insert_file_in_folder(folder, file);
void update_size(folder);
i32 find_folder_in_folder(folder root, string name);

file create_file(string, u64);

void print_indent(u64);
void print_tree(folder);

u8 cmp_str(string, string, u64);
u8 char_in_str(char, string);
void stop_at(string, char);

int main()
{
	string buffer = malloc(BUFFER_SIZE);
	u64 size;
	u8 indice;
	folder current, temp;
	const string main = "file.txt";
	const string test = "test.txt"; 
	FILE* file_pointer = fopen(test, "r");
	
	while(fgets(buffer, BUFFER_SIZE, file_pointer) != NULL)
	{
		printf("%s", buffer);
		stop_at(buffer, '\n');
		if(cmp_str(buffer, "$ cd ..", 7) == 1)
		{
			update_size(current);
			current = current->prev;
		}
		else if(cmp_str(buffer, "$ cd", 4) == 1)
		{
			temp = create_folder(buffer + 5);
			printf("1\n");
			insert_folder_in_folder(current, temp);
			printf("2\n");
			current = temp;
			printf("3\n");
		}
		else if(char_in_str(buffer[0], "0123456789") == 1)
		{
			size = 0;
			while(char_in_str(buffer[0], "0123456789") == 1)
			{
				size *= 10;
				size += buffer[0] - '0';
				buffer++;
			}
			create_file(buffer + 1, size);
		}
	}
	
	free(buffer);
	fclose(file_pointer);
	return 727;
}
u8 cmp_str(string str1, string str2, u64 size)
{
	u64 i = 0;
	while(i != size)
	{
		if(str1[i] == '\0' || str2[i] == '\0')
			return 0;
		if(str1[i] != str2[i])
			return 0;
		i++;
	}
	return 1;
}
void print_indent(u64 n)
{
	u64 i;
	for(i = 0; i < n; i++)
		printf("\t");
}
u8 char_in_str(char c, string str)
{
	u32 i;
	for(i = 0; str[i] != '\0'; i++)
		if(c == str[i])
			return 1;
	return 0;
}
folder create_folder(string name)
{
	folder result = malloc(sizeof(*result));
	result->name = malloc(strlen(name) + 1);
	strcpy(result->name, name);
	result->size = 0;
	u8 i;
	result->folder_array = malloc(sizeof(*result->file_array) * MAX);
	result->folder_size = 0;
	for(i = 0; i < MAX; i++)
		result->folder_array[i] = NULL;
	result->file_array = malloc(sizeof(*result->file_array) * MAX);
	result->file_size = 0;
	return result;
}
file create_file(string name, u64 size)
{
	file result;
	result.name = malloc(strlen(name) + 1);
	strcpy(result.name, name);
	result.size = size;
	return result;
}
void insert_folder_in_folder(folder parent, folder child)
{
	child->prev = parent;
	printf("\t1\n");
	parent->folder_array[parent->folder_size++] = child;
	printf("\t2\n");
	parent->folder_size++;
	printf("\tDirectory %s was connect to directory %s\n", child->name, parent->name);
}
void insert_file_in_folder(folder parent, file child)
{
	parent->file_array[parent->file_size++] = child;
	printf("File %s was connect to directory %s\n", child.name, parent->name);
}
void update_size(folder folder)
{
	folder->size = 0;
	u64 i;
	for(i = 0; i < folder->folder_size; i++)
		folder->size += folder->folder_array[i]->size;
	for(i = 0; i < folder->file_size; i++)
		folder->size += folder->file_array[i].size;
}
void print_tree(folder root)
{
	printf("folder: %s\n", root->name);
	folder current = root;
	u64 i;
	for(i = 0; i < current->file_size; i++)
		printf("%s: %u\n", current->file_array[i].name, current->file_array[i].size);
	for(i = 0; i < current->folder_size; i++)
		print_tree(current->folder_array[i]);
}
void stop_at(string str, char c)
{
	u64 i;
	for(i = 0; str[i] != '\0'; i++)
		if(str[i] == c)
		{
			str[i] = '\0';
			break;
		}
}
i32 find_folder_in_folder(folder root, string name)
{
	u64 i;
	for(i = 0; i < root->folder_size; i++)
		if(strcmp(root->folder_array[i]->name, name) == 0)
			return i;
	return -1;
}
