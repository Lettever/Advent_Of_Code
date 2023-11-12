#include "C:\headers\rstypes.h"
#include <string.h>
#include <stdio.h>

i32 part1();
i32 part2();
void write(FILE*, i32, i32);

i32 main()
{
    printf("part1 %i\n", part1());
    printf("part2 %i\n", part2());
}
i32 part1()
{
    FILE* input = fopen("file.txt", "r");
    i32 cycles = 1;
    i32 X = 1;
    i32 strength = 0;
    char buffer[1025];
    while(fgets(buffer, 1024, input) != NULL)
    {
        *strchr(buffer, '\n') = '\0';
        if(*buffer == 'n')
            cycles++;
        else
        {
            cycles++;
            if(cycles % 40 == 20)
                strength += cycles * X;
            i32 value;
            sscanf(buffer, "addx %d", &value);
            X += value;
            cycles++;
        }
        if(cycles % 40 == 20)
            strength += cycles * X;
    }
    fclose(input);
    return strength;
}
i32 part2()
{
    FILE* input = fopen("file.txt", "r");
    FILE* output = fopen("output.txt", "w");
    i32 cycles = 1;
    i32 X = 1;
    char buffer[1025];
    while(fgets(buffer, 1024, input) != NULL)
    {
        *strchr(buffer, '\n') = '\0';
        if(*buffer == 'n')
        {
            write(output, cycles, X);
            cycles++;
        }
        else
        {
            write(output, cycles, X);
            cycles++;
            int value;
            sscanf(buffer, "addx %d", &value);
            write(output, cycles, X);
            cycles++;
            X += value;
        }
    }
    fclose(output);
    fclose(input);
    return 0;
}
void write(FILE* output, int cycle, int X)
{
    cycle %= 40;
    if(X <= cycle && cycle <= X + 2)
        fprintf(output, "█");
    else
        fprintf(output, ".");
    if(cycle % 40 == 0)
        fprintf(output, "\n");
}
