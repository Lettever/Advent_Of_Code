#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
uint32_t max(uint32_t*, size_t);
void stop_at_char(char*, char);
uint32_t str_to_uint(char*);
int main()
{
	uint32_t current_array_index = 0;
	uint32_t number_of_lines = 2251;
	uint32_t number_of_elfs = 254;
	uint32_t calories_of_elfs[255];
	memset(calories_of_elfs, 0, 255 * sizeof(int));
	const uint8_t size = 100;
	char *str1 = malloc(size * sizeof(char));
	FILE *fp = fopen("file.txt", "r");
	while(fgets(str1, size, fp) != NULL)
	{
		stop_at_char(str1, '\n');
		printf("str: %s\tsize: %zu\n", str1, strlen(str1));
		calories_of_elfs[current_array_index] += str_to_uint(str1);
		if(str1[0] == '\0')
		{
			current_array_index++;
			printf("changed index\n");
		}
	}
	if(feof(fp))
		fclose(fp);
	printf("Entire file was read\n");
	printf("%u lines were read\n", number_of_lines);
	printf("There are %u elfs\n", number_of_elfs);
	printf("Index: %u\n", current_array_index);
	for(current_array_index = 0; current_array_index < 255; current_array_index++)
		printf("calories_of_elfs[%u]: %u\n", current_array_index, calories_of_elfs[current_array_index]);
	uint32_t max1 = max(calories_of_elfs, 254);
	printf("max: %u\n", max);
	printf("max: %u\n", max1);
	free(str1);
	return 727;
}
void stop_at_char(char *str, char c)
{
	uint32_t i = 0;
	while(str[i] != '\0')
		if(str[i] == c)
			str[i] = '\0';
		else
			i++;
}
uint32_t max(uint32_t *arr, size_t size)
{
	uint32_t max = arr[0], i;
	for(i = 1; i < size; i++)
		if(arr[i] > max)
			max = arr[i];
	return max;
}
uint32_t str_to_uint(char *str)
{
	uint32_t result = 0, i = 0;
	while(str[i] != '\0')
	{
		result *= 10;
		result += str[i] - '0';
		i++;
	}
	return result;
}
