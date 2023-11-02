import std.stdio;
import std.string;
import std.format;
import std.algorithm;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    int sum = 0;
    string line = input.readln.chomp;
    input.close;
    foreach(ch; line)
        if(ch == '(')
            sum++;
        else
            sum--;
    return sum;
}
int part2()
{
    File input = File("file.txt", "r");
    int sum = 0;
    string line = input.readln.chomp;
    input.close;
    int i;
    while(sum != -1)
    {
        if(line[i] == '(')
            sum++;
        else
            sum--;
        i++;
    }
    return i;
}