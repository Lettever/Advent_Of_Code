#include "C:\headers\rstypes.h"
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <assert.h>

#define MAX_BUFFER 1024

typedef struct
{
    i32 height;
    bool is_visible;
}tree;

typedef struct
{
    i32 lines;
    i32 rows;
    tree** array;
}tree_array;

const string numbers = "0123456789";

bool char_in_string(char, string);

void find_tree_north(tree_array, i32);
void find_tree_south(tree_array, i32);
void find_tree_east(tree_array, i32);
void find_tree_west(tree_array, i32);

i32 count_tree(tree_array);

void print_tree(tree_array);

i32 calc_score(tree_array, i32, i32);
i32 look_up(tree_array, i32, i32);
i32 look_down(tree_array, i32, i32);
i32 look_left(tree_array, i32, i32);
i32 look_right(tree_array, i32, i32);

int main()
{
    string buffer = malloc(MAX_BUFFER);
    const string file_name = "file.txt";
    FILE* file_pointer = fopen(file_name, "r");

    i32 size, i, j;
    if(strcmp(file_name, "test.txt") == 0)
        size = 5;
    if(strcmp(file_name, "file.txt") == 0)
        size = 99;
    tree_array main_array;
    main_array.lines = size;
    main_array.rows = size;
    main_array.array = malloc(sizeof(*main_array.array) * main_array.lines);
    for(i = 0; i < main_array.lines; i++)
        main_array.array[i] = malloc(sizeof(*main_array.array[i]) * main_array.rows);

    i32 line = 0, row = 0;
    while(fgets(buffer, MAX_BUFFER, file_pointer) != NULL)
    {
        printf("%s", buffer);
        while(char_in_string(buffer[row], numbers) == true)
        {
            main_array.array[line][row].height = buffer[row] - '0';
            main_array.array[line][row].is_visible = false;
            row++;
        }
        line++;
        row = 0;
    }
    
    for(i = 0; i < size; i++)
    {
        find_tree_north(main_array, i);
        find_tree_south(main_array, i);
        find_tree_east(main_array, i);
        find_tree_west(main_array, i);
    }

    i32 sum = count_tree(main_array);
    printf("%i\n", sum);

    sum = 0;
    i32 temp;
    for(i = 1; i < size - 1; i++)
        for(j = 1; j < size - 1; j++)
        {
            temp = calc_score(main_array, i, j);
            if(temp > sum)
                sum = temp;
        }
    printf("%i", sum);

    free(buffer);
    fclose(file_pointer);
    for(i = 0; i < main_array.lines; i++)
        free(main_array.array[i]);
    free(main_array.array);
    return 727;
}

bool char_in_string(char c, string str)
{
    for(u32 i = 0; str[i] != '\0'; i++)
        if(str[i] == c)
            return true;
    return false;
}

void find_tree_north(tree_array array, i32 row)
{
    i32 i, max_height = array.array[0][row].height;
    array.array[0][row].is_visible = true;
    for(i = 0; i < array.lines; i++)
    {
        if(array.array[i][row].height > max_height)
        {
            max_height = array.array[i][row].height;
            array.array[i][row].is_visible = true;
        }
    }
}
void find_tree_south(tree_array array, i32 row)
{
    i32 i, max_height = array.array[array.lines - 1][row].height;
    array.array[array.lines - 1][row].is_visible = true;
    for(i = array.lines - 1; i >= 0; i--)
    {
        if(array.array[i][row].height > max_height)
        {
            max_height = array.array[i][row].height;
            array.array[i][row].is_visible = true;
        }        
    }
}
void find_tree_west(tree_array array, i32 line)
{
    i32 i, max_height = array.array[line][0].height;
    array.array[line][0].is_visible = true;
    for(i = 0; i < array.rows; i++)
    {
        if(array.array[line][i].height > max_height)
        {
            max_height = array.array[line][i].height;
            array.array[line][i].is_visible = true;
        }        
    }
}
void find_tree_east(tree_array array, i32 line)
{
    i32 i, max_height = array.array[line][array.rows - 1].height;
    array.array[line][array.rows - 1].is_visible = true;    
    for(i = array.rows - 1; i >= 0; i--)
    {
        if(array.array[line][i].height > max_height)
        {
            max_height = array.array[line][i].height;
            array.array[line][i].is_visible = true;
        }
    }
}

i32 count_tree(tree_array array)
{
    i32 sum = 0, i, j;
    for(i = 0; i < array.lines; i++)
        for(j = 0; j < array.rows; j++)
            sum += array.array[i][j].is_visible;
    return sum;
}

void print_tree(tree_array array)
{
    i32 i, j;
    for(i = 0; i < array.lines; i++)
    {
        for(j = 0; j < array.rows; j++)
            printf("h: %i b: %i\t", array.array[i][j].height, array.array[i][j].is_visible);        
        printf("\n");
    }
}

i32 calc_score(tree_array array, i32 line, i32 row)
{
    i32 result = look_up(array, line, row) * look_down(array, line, row) * look_left(array, line, row) * look_right(array, line, row);
}

i32 look_up(tree_array array, i32 line, i32 row)
{
    i32 sum = 0, i;
    for(i = line - 1; i >= 0; i--)
    {
        sum++;
        if(array.array[i][row].height >= array.array[line][row].height)
            break;
    }
    return sum;
}
i32 look_down(tree_array array, i32 line, i32 row)
{
    i32 sum = 0, i;
    for(i = line + 1; i < array.lines; i++)
    {
        sum++;
        if(array.array[i][row].height >= array.array[line][row].height)
            break;
    }
    return sum;
}
i32 look_left(tree_array array, i32 line, i32 row)
{
    i32 sum = 0, i;
    for(i = row - 1; i >= 0; i--)
    {
        sum++;
        if(array.array[line][i].height >= array.array[line][row].height)
            break;
    }
    return sum;        
}
i32 look_right(tree_array array, i32 line, i32 row)
{
    i32 sum = 0, i;
    for(i = row + 1; i < array.rows; i++)
    {
        sum++;
        if(array.array[line][i].height >= array.array[line][row].height)
            break;
    }
    return sum;
}