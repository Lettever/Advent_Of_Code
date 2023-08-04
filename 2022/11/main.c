#include "header.h"
#define MAX_MONKEY 8
#define MAX_ROUNDS 10000
int main()
{
	monkey array[MAX_MONKEY];
	for(int i = 0; i < MAX_MONKEY; i++)
		array[i] = create_monkey(i);
	int array2[MAX_MONKEY] = {0};
	
	for(int i = 0; i < MAX_ROUNDS; i++)
		for(int j = 0; j < MAX_MONKEY; j++)
			throw_items(j, array, array2);
			
	for(int i = 0; i < MAX_MONKEY; i++)
		for(int j = i + 1; j < MAX_MONKEY; j++)
			if(array2[i] > array2[j])
			{
				int temp = array2[i];
				array2[i] = array2[j];
				array2[j] = temp;
			}
	for(int i = 0; i < MAX_MONKEY; i++)
	{
		printf("%i ", array2[i]);
		free(array[i]);
	}
	printf("\n%llu", (u64)array2[MAX_MONKEY - 1] * (u64)array2[MAX_MONKEY - 2]);
}
