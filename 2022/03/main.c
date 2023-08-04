#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
char is_in_both_strings(char*, char*, char*);
uint32_t calculate_score(char);
int main()
{
	uint32_t sum = 0;
	uint32_t size_str;
	const size_t size = 100;
	char *str1 = malloc(size * sizeof(char));
	char *str2 = malloc(size * sizeof(char));
	char *str3 = malloc(size * sizeof(char));
	uint32_t lines = 0;
	FILE *fp = fopen("file.txt", "r");
	while(fgets(str1, size, fp) != NULL)
	{
		fgets(str2, size, fp);
		fgets(str3, size, fp);
		lines += 3;
		printf("str1: %s", str1);
		printf("str2: %s", str2);
		printf("str3: %s", str3);
		char c = is_in_both_strings(str1, str2, str3);
		printf("char: %c\n\n", c);
		sum += calculate_score(c);
	}
	if(feof(fp))
		fclose(fp);
	printf("\nEntire file was read\n");
	printf("%u lines were read\n", lines);
	printf("score: %u", sum);
}
char is_in_both_strings(char *str1, char *str2, char *str3)
{
	size_t size1, size2, size3;
	for(size1 = 0; str1[size1] != '\0'; size1++)
		for(size2 = 0; str2[size2] != '\0'; size2++)
			for(size3 = 0; str3[size3] != '\0'; size3++)
				if(str1[size1] == str2[size2] && str1[size1] == str3[size3])
					return str1[size1];
	printf("char was not found\n");
	return 0;
}
uint32_t calculate_score(char c)
{
	if('a' <= c && c <= 'z')
		return c + 1 - 'a';
	if('A' <= c && c <= 'Z')
		return c - 'A' + 1 + 26;
}
