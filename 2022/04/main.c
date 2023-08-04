#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
uint32_t str_to_uint(char *str);
void store_elf_info(char*, uint32_t[2], uint32_t[2]);
int elem_in_array(char*, char);
uint32_t is_range_inside_the_other(uint32_t[2], uint32_t[2]);
int main()
{
	const size_t size = 50;
	uint32_t lines = 0, sum = 0;
	uint32_t elf1[2], elf2[2];
	char *str = malloc(size * sizeof(char));
	FILE *fp = fopen("file.txt", "r");
	while(fgets(str, size, fp) != NULL)
	{
		printf("str: %s\n", str);
		store_elf_info(str, elf1, elf2);
		printf("elf1[0]: %u\nelf1[1]: %u\nelf2[0]: %u\nelf2[1]: %u\n", elf1[0], elf1[1], elf2[0], elf2[1]);
		printf("is_range_inside_the_other(elf1, elf2): %u\n", is_range_inside_the_other(elf1, elf2));
		sum += is_range_inside_the_other(elf1, elf2);
	}
	if(feof(fp))
		fclose(fp);
	printf("\nEntire file was read\n");
	printf("%u", sum);
	return 727;
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
void store_elf_info(char *str, uint32_t elf1[2], uint32_t elf2[2])
{
	size_t i, temp_index = 0;
	uint32_t temp[4], num = 0;
	for(i = 0; str[i] != '\0'; i++)
	{
		if(elem_in_array("0123456789", str[i]) == 1)
		{
			num *= 10;
			num += str[i] - '0';
		}
		else
		{
			temp[temp_index++] = num;
			num = 0;
		}
	}
	elf1[0] = temp[0];
	elf1[1] = temp[1];
	elf2[0] = temp[2];
	elf2[1] = temp[3];
}
int elem_in_array(char *str, char c)
{
	size_t i;
	for(i = 0; str[i] != '\0'; i++)
		if(str[i] == c)
			return 1;
	return 0;
}
uint32_t is_range_inside_the_other(uint32_t elf1[2], uint32_t elf2[2])
{
	if((elf1[0] <= elf2[0]) && (elf1[1] >= elf2[1]))
		return 1;
	else if((elf1[0] >= elf2[0]) && (elf1[1] <= elf2[1]))
		return 1;
	else if((elf1[0] <= elf2[1]) && (elf2[0] <= elf1[1]))
		return 1;
	else
		return 0;
}
