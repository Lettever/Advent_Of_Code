import std.stdio;
import std.string;
import std.format;
import std.algorithm;
struct Point
{
    int x, y;
    void next(char rhs)
    {
        if(rhs == '^')
            y++;
        else if(rhs == 'v')
            y--;
        else if(rhs == '>')
            x++;
        else if(rhs == '<')
            x--;
        else
            assert(false);
    }
}
void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    string line = input.readln.chomp;
    input.close;
    
    int total = 1;
    Point start;
    bool [Point]map;
    map[start] = true;
    
    foreach(ch; line)
    {
        start.next(ch);

        if((start in map) is null)
            map[start] = false;

        total += !map[start];
        map[start] = true;
    }
    
    return total;
}
int part2()
{
    File input = File("file.txt", "r");
    string line = input.readln.chomp;
    input.close;
    
    int total = 1;
    Point [2]santas;
    bool [Point]map;
    map[santas[0]] = true;
    
    foreach(index, ch; line)
    {
        santas[index % 2].next(ch);

        if((santas[index % 2] in map) is null)
            map[santas[index % 2]] = false;

        total += !map[santas[index % 2]];
        map[santas[index % 2]] = true;
    }
    
    return total;
}