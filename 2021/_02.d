import std.stdio;
import std.conv;
import std.algorithm;
import std.array;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
string keep_numbers(string input)
{
    string result = "";
    foreach(c; input)
        if('0' <= c && c <= '9')
            result ~= c;
    return result;
}
int part1()
{
    File input = File("file.txt", "r");
    int x = 0, y = 0;
    while(!input.eof)
    {
        string []parts = input.readln.split(" ");
        if(parts.length == 0)
            break;
        string direction = parts[0];
        int steps = to!int(keep_numbers(parts[1]));
        if(direction == "forward")
            x += steps;
        else if(direction == "up")
            y -= steps;
        else if(direction == "down")
            y += steps;
        else
            writeln("invalid string");
    }
    input.close;
    return x * y;
}
int part2()
{
    File input = File("file.txt", "r");
    int x = 0, y = 0, aim = 0;
    while(!input.eof)
    {
        string []parts = input.readln.split(" ");
        if(parts.length == 0)
            break;
        string direction = parts[0];
        int steps = to!int(keep_numbers(parts[1]));
        if(direction == "forward")
        {
            x += steps;
            y += aim * steps;
        }
        else if(direction == "up")
            aim -= steps;
        else if(direction == "down")
            aim += steps;
        else
            writeln("invalid string");
    }
    input.close;
    return x * y;
}