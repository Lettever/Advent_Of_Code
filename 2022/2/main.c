#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#define LOSE 0
#define DRAW 3
#define WIN 6
#define ROCK 1
#define PAPER 2
#define SCISSORS 3
uint32_t calculate_score(char*);
void stop_at_char(char*, char);
/*
	chose rock		score += 1
	chose paper		score += 2
	chose scissors	score += 3
	lost 			score += 0
	draw			score += 3
	win				score += 6
	A				opponent choses rock
	B				opponent choses paper
	C				opponent choses scissors
	X				you chose rock
	Y				you chose paper
	Z				you chose scissors
*/
int main()
{
	const int buffer = 4;
	char *str = malloc(buffer * sizeof(char));
	FILE *fp = fopen("file.txt", "r");
	uint32_t score = 0;
	while(fgets(str, buffer, fp) != NULL)
	{
		stop_at_char(str, '\n');
		printf("%s", str);
		score += calculate_score(str);
	}
	if(feof(fp))
		fclose(fp);
	printf("\nEntire file was read\n");
	printf("LOSE: %i\nDRAW: %i\nWIN: %i\n", LOSE, DRAW, WIN);
	printf("score: %u", score);
	return 727;
}
uint32_t calculate_score(char* str)
{
	uint32_t score = 0;
	/*
		A				opponent choses rock
		B				opponent choses paper
		C				opponent choses scissors
		X				you need to lose
		Y				you need to draw
		Z				you need to win
	*/
	if(str[0] == 'A')
	{
		if(str[2] == 'X')
		{
			score += LOSE + SCISSORS;
		}
		else if(str[2] == 'Y')
		{
			score += DRAW + ROCK;
		}
		else if(str[2] == 'Z')
		{
			score += WIN + PAPER;
		}
		else
			printf("Something is wrong A\n");
	}
	else if(str[0] == 'B')
	{
		if(str[2] == 'X')
		{
			score += LOSE + ROCK;
		}
		else if(str[2] == 'Y')
		{
			score += DRAW + PAPER;
		}
		else if(str[2] == 'Z')
		{
			score += WIN + SCISSORS;
		}
		else
			printf("Something is wrong B\n");
	}
	else if(str[0] == 'C')
	{
		if(str[2] == 'X')
		{
			score += LOSE + PAPER;
		}
		else if(str[2] == 'Y')
		{
			score += DRAW + SCISSORS;
		}
		else if(str[2] == 'Z')
		{
			score += WIN + ROCK;
		}
		else
			printf("Something is wrong C\n");
	}
	else
		printf("Something is wrong\n");
	return score;
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
