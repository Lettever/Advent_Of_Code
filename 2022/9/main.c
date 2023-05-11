#include "C:\headers\rstypes.h"
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <assert.h>

#define MAX_BUFFER 1024
#define MAX_SIZE 1000

typedef struct
{
    i32 x, y;
}vec2;

void stop_at_char(string, char);
i32 string_to_i32(string);
bool char_in_string(char, string);

void update_tail_pos(vec2*, vec2);
int main()
{
    vec2 start = {.x = MAX_SIZE/2, .y = MAX_SIZE/2};
    vec2 temp_v[10];
    i32 temp, i, j, visited = 1, k;
    for(i = 0; i < 10; i++)
        temp_v[i] = start;

    string buffer = malloc(MAX_BUFFER);
    FILE* file_pointer = fopen("file.txt", "r");
    bool array[MAX_SIZE][MAX_SIZE] = {false};
    array[temp_v[0].y][temp_v[0].x] = true;
    printf("a\n");
    getchar();
    while(fgets(buffer, MAX_BUFFER, file_pointer) != NULL)
    {
        //printf("%s", buffer);
        stop_at_char(buffer, '\n');
        if(buffer[0] == 'R')
        {
            temp = string_to_i32(buffer + 2);
            for(i = 0; i < temp; i++)
            {
                printf("R");
                temp_v[0].x++;
                for(j = 0; j < 9; j++)
                    update_tail_pos(&temp_v[j + 1], temp_v[j]);
                if(array[temp_v[9].y][temp_v[9].x] == false)
                {
                    visited++;
                    array[temp_v[9].y][temp_v[9].x] = true;
                }
            }
            printf("\n");
        }
        else if(buffer[0] == 'L')
        {
            temp = string_to_i32(buffer + 2);
            for(i = 0; i < temp; i++)
            {
                printf("L");
                temp_v[0].x--;
                for(j = 0; j < 9; j++)
                    update_tail_pos(&temp_v[j + 1], temp_v[j]);
                if(array[temp_v[9].y][temp_v[9].x] == false)
                {
                    visited++;
                    array[temp_v[9].y][temp_v[9].x] = true;
                }
            }
            printf("\n");
        }
        else if(buffer[0] == 'U')
        {
            temp = string_to_i32(buffer + 2);
            for(i = 0; i < temp; i++)
            {
                printf("U");
                temp_v[0].y--;
                for(j = 0; j < 9; j++)
                    update_tail_pos(&temp_v[j + 1], temp_v[j]);
                if(array[temp_v[9].y][temp_v[9].x] == false)
                {
                    visited++;
                    array[temp_v[9].y][temp_v[9].x] = true;
                }
            }
            printf("\n");
        }
        else
        {
            temp = string_to_i32(buffer + 2);
            for(i = 0; i < temp; i++)
            {
                printf("D");
                temp_v[0].y++;
                for(j = 0; j < 9; j++)
                    update_tail_pos(&temp_v[j + 1], temp_v[j]);
                if(array[temp_v[9].y][temp_v[9].x] == false)
                {
                    visited++;
                    array[temp_v[9].y][temp_v[9].x] = true;
                }
            }
            printf("\n");
        }
    }
    printf("visited: %i", visited);
    return 727;
}

void stop_at_char(string str, char c)
{
    for(i32 i = 0; str[i] != '\0'; i++)
        if(str[i] == c)
        {
            str[i] = '\0';
            return;
        }    
}

i32 string_to_i32(string str)
{
    u8 i = 0;
    i32 sum = 0;
    while((str[i] != '\0') && (char_in_string(str[i], "0123456789") == 1))
    {
        sum *= 10;
        sum += str[i] - '0';
        i++;
    }
    return sum;
}

bool char_in_string(char c, string str)
{
    u8 i;
    for(i = 0; str[i] != '\0'; i++)
        if(c == str[i])
            return true;
    return false;
}

void update_tail_pos(vec2* tail, vec2 head)
{
    /*
        . . .    . . .    . . .
        . . . -> . . . -> . . .
        T H .    T . H    . T H

        . . .    . H .    . H .
        . H . -> . . . -> . T .
        T . .    T . .    . . .
    */
    i32 x = head.x - tail->x;
    i32 y = head.y - tail->y;

    if(abs(x) == 2)
    {
        tail->x += x / abs(x);
        if(abs(y) == 1)
            tail->y += y / abs(y);
    }

    if(abs(y) == 2)
    {
        tail->y += y / abs(y);
        if(abs(x) == 1)
            tail->x += x / abs(x);
    }
}