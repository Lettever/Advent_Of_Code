import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;
import std.container : DList;

class Octopus
{
    int value, i, j;
    bool flashed;
    this(int a, int b, int c)
    {
        value = a;
        i = b;
        j = c;
    }
    int opUnary(string s : "++")() => this.value++;
}

class Queue
{
    auto queue = new DList!Octopus;
    void push(Octopus new_element)
    {
        this.queue.insertBack(new_element);
    }
    Octopus pop()
    {
        Octopus result = queue.front;
        queue.removeFront;
        return result;
    }
    bool empty() => queue.empty;
}

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    Octopus [][]matrix;
    int i, j;
    while(!input.eof)
    {
        matrix ~= input.readln.chomp.map!(x => new Octopus(x - '0', i, j++)).array;
        i++;
        j = 0;
    }
    input.close;

    int flashes;
    auto queue = new Queue;

    foreach(_ ; 0 .. 100)
    {
        queue.insert_all_in_queue(matrix);
        while(!queue.empty)
        {
            auto element = queue.pop;
            if(element.flashed)
                continue;
            element.value++;
            if(element.value > 9)
            {
                element.value = 0;
                element.flashed = true;
                insert_all_around(queue, matrix, element);
            }
        }
        flashes += count_flashes(matrix);
        matrix.reset_flashes;
    }
    return flashes;
}
int part2()
{
    File input = File("file.txt", "r");
    Octopus [][]matrix;
    int i, j;
    while(!input.eof)
    {
        matrix ~= input.readln.chomp.map!(x => new Octopus(x - '0', i, j++)).array;
        i++;
        j = 0;
    }
    input.close;

    int steps;
    auto queue = new Queue;
    
    while(!all_true(matrix))
    {
        reset_flashes(matrix);
        queue.insert_all_in_queue(matrix);
        while(!queue.empty)
        {
            auto element = queue.pop;
            if(element.flashed)
                continue;
            element.value++;
            if(element.value > 9)
            {
                element.value = 0;
                element.flashed = true;
                insert_all_around(queue, matrix, element);
            }
        }
        steps++;
    }
    return steps;
}
void insert_all_in_queue(ref Queue queue, Octopus [][]matrix)
{
    foreach (array; matrix)
        foreach (element; array)
            queue.push(element);
}
void insert_all_around(ref Queue queue, Octopus [][]matrix, Octopus center)
{
    int []dx_v = [-1, 0, 1];
    int []dy_v = [-1, 0, 1];
    foreach (dx; dx_v)
        foreach (dy; dy_v)
        {
            if(dy == 0 && dx == 0)
                continue;
            int i = center.i + dy;
            int j = center.j + dx;
            
            if(i.in_range(0, matrix.length.to!int - 1) && j.in_range(0, matrix[center.i].length.to!int - 1))
                queue.push(matrix[i][j]);
        }
}
int count_flashes(Octopus [][]matrix)
{
    int sum = 0;
    for(int i = 0; i < matrix.length; i++)
        for(int j = 0; j < matrix[i].length; j++)
            sum += matrix[i][j].flashed;
    return sum;
}
void reset_flashes(ref Octopus [][]matrix)
{
    for(int i = 0; i < matrix.length; i++)
        for(int j = 0; j < matrix[i].length; j++)
            matrix[i][j].flashed = false;
}
bool in_range(int number, int min, int max) => min <= number && number <= max;
bool all_true(Octopus [][]matrix)
{
    for(int i = 0; i < matrix.length; i++)
        for(int j = 0; j < matrix[i].length; j++)
            if(matrix[i][j].flashed == false)
                return false;
    return true;
}