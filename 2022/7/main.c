#include <stdio.h>
#include <string.h>
#include "_rstypes.h"
#include <stdlib.h>
#include <math.h>

#define MAX_BUFFER 1024
#define MAX_CAP 20

const string numbers = "0123456789";

typedef struct
{
	string name;
	u64 size;
}file;
struct folder
{
	struct folder* prev;
	string name;
	u64 size;
	struct folder* folder_array[MAX_CAP];
	u8 folder_size;
	file file_array[MAX_CAP];
	u8 file_size;
};

typedef struct folder *folder_ptr;

folder_ptr create_folder(string);
file create_file(string, u64);

void insert_folder_in_folder(folder_ptr, folder_ptr);
void insert_file_in_folder(folder_ptr, file);
void update_size_folder(folder_ptr);
void update_size_tree(folder_ptr);

bool cmp_str(string, string, u64);
bool char_in_str(char, string);
void stop_at(string, char);
u64 string_to_u64(string);

u64 digits(u64);

void print_tree(folder_ptr, u64);
void free_tree(folder_ptr);
void free_folder(folder_ptr);

void calc_final_size(folder_ptr, u64*);

void find_dir(folder_ptr, u64*);

int main()
{
	string buffer = malloc(MAX_BUFFER);
	FILE* file_pointer = fopen("file.txt", "r");
	u64 temp_size;
	folder_ptr current_folder = create_folder("home"), temp_folder;
	const folder_ptr start = current_folder;
	file temp_file;
	
	while(fgets(buffer, MAX_BUFFER, file_pointer) != NULL)
	{
		printf("%s", buffer);
		stop_at(buffer, '\n');
		if(cmp_str(buffer, "$ cd ..", 7) == true)
		{
			current_folder = current_folder->prev;
		}
		else if(cmp_str(buffer, "$ cd", 4) == true)
		{
			temp_folder = create_folder(buffer + 5);
			insert_folder_in_folder(current_folder, temp_folder);
			current_folder = temp_folder;
		}
		else if(char_in_str(buffer[0], numbers) == true)
		{
			temp_size = string_to_u64(buffer);
			temp_file = create_file(buffer + digits(temp_size) + 1, temp_size);
			insert_file_in_folder(current_folder, temp_file);
		}
	}
	
	printf("\nEND OF READING THE FILE\n");
	print_tree(start, 0);
	temp_size = 0;
	calc_final_size(start, &temp_size);
	printf("%llu\n", temp_size);
	temp_size = start->size;
	find_dir(start, &temp_size);
	printf("%s\n", temp_folder->name);
	printf("%llu\n", temp_size);
	free_tree(start);
	free(buffer);
	fclose(file_pointer);
	return 727;
}

folder_ptr create_folder(string name)
{
	folder_ptr result = malloc(sizeof(*result));
	result->prev = NULL;
	result->name = malloc(strlen(name) + 1);
	strcpy(result->name, name);
	result->folder_size = 0;
	result->file_size = 0;	
	result->size = 0;
	return result;
}
file create_file(string name, u64 size)
{
	file result;
	result.size = size;
	result.name = malloc(strlen(name) + 1);
	strcpy(result.name, name);
	return result;
}

void insert_folder_in_folder(folder_ptr parent, folder_ptr child)
{
	child->prev = parent;
	parent->folder_array[parent->folder_size++] = child;
}
void insert_file_in_folder(folder_ptr parent, file child)
{
	parent->file_array[parent->file_size++] = child;
	folder_ptr temp = parent;
	while(temp != NULL)
	{
		temp->size += child.size;
		temp = temp->prev;
	}
}
void update_size_folder(folder_ptr folder)
{
	folder->size = 0;
	u8 i;
	for(i = 0; i < folder->file_size; i++)
		folder->size += folder->file_array[i].size;
	for(i = 0; i < folder->folder_size; i++)
		folder->size += folder->folder_array[i]->size;
}
void update_size_tree(folder_ptr start)
{
	start->size = 0;
	u8 i;
	for(i = 0; i < start->folder_size; i++)
		update_size_tree(start->folder_array[i]);
	update_size_folder(start);
}

bool cmp_str(string str1, string str2, u64 chars)
{
	u32 i;
	for(i = 0; i < chars; i++)
	{
		if(str1[i] == '\0' || str2[i] == '\0')
			return false;
		if(str1[i] != str2[i])
			return false;	
	}
	return true;
}
bool char_in_str(char c, string str)
{
	u32 i;
	for(i = 0; i < strlen(str); i++)
		if(c == str[i])
			return true;
	return false;
}
void stop_at(string str, char c)
{
	u32 i;
	for(i = 0; i < strlen(str); i++)
		if(str[i] == c)
		{
			str[i] = '\0';
			break;
		}
}
u64 string_to_u64(string str)
{
	u8 i = 0;
	u64 result = 0;
	while(char_in_str(str[i], numbers) == true)
	{
		result *= 10;
		result += str[i] - '0';
		i++;
	}
	return result;
}

u64 digits(u64 num)
{
	return log10(num + (num == 0));
}

void print_indent(u64 n)
{
	u64 i;
	for(i = 0; i < n; i++)
		printf("\t");	
}
void print_tree(folder_ptr start, u64 indent)
{
	u8 i;
	print_indent(indent);
	printf("folder: %s || size: %llu\n", start->name, start->size);
	for(i = 0; i < start->file_size; i++)
	{
		print_indent(indent + 1);
		printf("file: %s || size: %llu\n", start->file_array[i].name, start->file_array[i].size);
	}
	for(i = 0; i < start->folder_size; i++)
		print_tree(start->folder_array[i], indent + 1);
}
void free_tree(folder_ptr start)
{
	u8 i;
	for(i = 0; i < start->folder_size; i++)
		free_tree(start->folder_array[i]);
	for(i = 0; i < start->file_size; i++)
		free(start->file_array[i].name);
	free_folder(start);
}
void free_folder(folder_ptr folder)
{
	free(folder->name);
	free(folder);
}

void calc_final_size(folder_ptr start, u64* size)
{
	if(start->size <= 100000)
		*size += start->size;
	{
		u8 i;
		for(i = 0; i < start->folder_size; i++)
			calc_final_size(start->folder_array[i], size);
	}
}

void find_dir(folder_ptr start, u64* curr_size)
{
	//total: 	   70000000
	//needed_size: 30000000
	//used_size:   42558312
	//10148525 is too high
	if((start->size < *curr_size) && (start->size >= 2558312))
		*curr_size = start->size;
	u8 i;
	for(i = 0; i < start->folder_size; i++)
		find_dir(start->folder_array[i], curr_size);
}
