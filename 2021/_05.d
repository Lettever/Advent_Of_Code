import std.stdio;
import std.algorithm;
import std.datetime;
import std.typecons;

@property int sign(int number) => 2 * (number > 0) - 1 + (number == 0);
@property int abs(int number) => (2 * (number > 0) - 1) * number;

void main()
{
    writeln("start");
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    int [][]space = new int[][](1000, 1000);
    int [2]x;
    int [2]y;
    int intersections = 0;
    while(input.readf!"%d,%d -> %d,%d\n"(x[0], y[0], x[1], y[1]) == 4)
    {
        if(is_straight_line(x, y))
        {
            int [2]raycast = [(x[1] - x[0]).sign, (y[1] - y[0]).sign];
            if(space[y[0]][x[0]] == 1)
                intersections++;
            space[y[0]][x[0]]++;
            while(!(x[0] == x[1] && y[0] == y[1]))
            {
                x[0] += raycast[0];
                y[0] += raycast[1];
                if(space[y[0]][x[0]] == 1)
                    intersections++;
                space[y[0]][x[0]]++;
            }
        }
    }
    input.close;

    return intersections;
}
int part2()
{
    File input = File("file.txt", "r");
    int [][]space = new int[][](1000, 1000);
    int [2]x;
    int [2]y;
    int intersections = 0;
    while(input.readf!"%d,%d -> %d,%d\n"(x[0], y[0], x[1], y[1]) == 4)
    {
        int [2]raycast = [(x[1] - x[0]).sign, (y[1] - y[0]).sign];
        if(space[y[0]][x[0]] == 1)
            intersections++;
        space[y[0]][x[0]]++;
        while(!(x[0] == x[1] && y[0] == y[1]))
        {
            x[0] += raycast[0];
            y[0] += raycast[1];
            if(space[y[0]][x[0]] == 1)
                intersections++;
            space[y[0]][x[0]]++;
        }
    }
    input.close;

    return intersections;
}
bool is_straight_line(int [2]x, int [2]y)
{
    return (x[1] - x[0]) * (y[1] - y[0]) == 0;    
}
bool is_diagonal_line(int [2]x, int [2]y)
{
    return (x[1] - x[0]).abs == (y[1] - y[0]).abs;
}