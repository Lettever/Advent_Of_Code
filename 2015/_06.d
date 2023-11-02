import std.stdio;
import std.string;
import std.format;
import std.algorithm;
import std.conv;
import std.array;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    auto lights = new bool[][](1000, 1000);
    File input = File("file.txt", "r");
    while(!input.eof)
    {
        auto a = input.readln.chomp.split(" ");
        if(a[0] == "turn")
        {
            bool b = a[1] == "on";
            auto c = (a[2].split(",") ~ a[4].split(",")).map!(x => x.to!int).array;
            for(int i = c[0]; i <= c[2]; i++)
                for(int j = c[1]; j <= c[3]; j++)
                    lights[i][j] = b;
        }
        else
        {
            auto c = (a[1].split(",") ~ a[3].split(",")).map!(x => x.to!int).array;
            for(int i = c[0]; i <= c[2]; i++)
                for(int j = c[1]; j <= c[3]; j++)
                    lights[i][j] = !lights[i][j];
        }
    }
    input.close;
    int sum;
    for(int i = 0; i < lights.length; i++)
        for(int j = 0; j < lights[i].length; j++)
            sum += lights[i][j];
    return sum;
}
long part2()
{
    auto lights = new long[][](1000, 1000);
    File input = File("file.txt", "r");
    while(!input.eof)
    {
        auto a = input.readln.chomp.split(" ");
        if(a[0] == "turn")
        {
            auto c = (a[2].split(",") ~ a[4].split(",")).map!(x => x.to!int).array;
            for(int i = c[0]; i <= c[2]; i++)
                for(int j = c[1]; j <= c[3]; j++)
                    if(a[1] == "on")
                        lights[i][j]++;
                    else
                        lights[i][j] = max(lights[i][j] - 1, 0);
        }
        else
        {
            auto c = (a[1].split(",") ~ a[3].split(",")).map!(x => x.to!int).array;
            for(int i = c[0]; i <= c[2]; i++)
                for(int j = c[1]; j <= c[3]; j++)
                    lights[i][j] += 2;

        }
    }
    input.close;
    long sum;
    for(int i = 0; i < lights.length; i++)
        for(int j = 0; j < lights[i].length; j++)
            sum += lights[i][j];
    return sum;
}