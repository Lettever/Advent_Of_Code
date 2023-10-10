import std.stdio;
import std.algorithm;
import std.string;
import std.conv;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    int [12][2]matrix;
    while(!input.eof)
    {
        string line = input.readln.chomp;
        if(line.length == 0)
            break;
        foreach(index, value; line)
            matrix[value - '0'][index]++;
    }
    input.close;
    int gamma, epsilon;
    for(int i = 0; i < 12; i++)
    {
        int max = matrix[1][i] > matrix[0][i];
        int min = 1 - max;
        gamma = gamma * 2 + max;
        epsilon = epsilon * 2 + min;
    }
    return gamma * epsilon;
}
int part2()
{
    File input = File("file.txt", "r");
    int [12][2]matrix;
    string []lines;
    while(!input.eof)
    {
        string line = input.readln.chomp;
        if(line.length == 0)
            break;
        lines ~= line;
        foreach(index, value; line)
            matrix[value - '0'][index]++;
    }
    input.close;
    int [12]max, min;
    for(int i = 0; i < 12; i++)
    {
        max[i] = matrix[1][i] > matrix[0][i];
        min[i] = 1 - max[i];
    }
    string []oxygen = lines.dup;
    string []scrubber = lines.dup;
    return -1;
}
