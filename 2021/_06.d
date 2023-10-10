import std.stdio;
import std.string;
import std.algorithm;
import std.conv;
import std.array;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
ulong part1()
{
    File input = File("file.txt", "r");
    int []fishes = input.readln.chomp.split(",").map!(e => e.to!int).array;
    input.close;
    foreach(_; 0 .. 80)
    {
        /*
        foreach_reverse(ref fish; fishes)
        {
            fish--;
            if(fish == -1)
            {
                fish = 6;
                fishes ~= 8;
            }
        }
        */
        for(int i = to!int(fishes.length) - 1; i >= 0; i--)
        {
            fishes[i]--;
            if(fishes[i] == -1)
            {
                fishes[i] = 6;
                fishes ~= 8;
            }
        }
    }
    return fishes.length;
}
ulong part2()
{
    File input = File("file.txt", "r");
    int []fishes = input.readln.chomp.split(",").map!(e => e.to!int).array;
    input.close;
    ulong [9]abc;
    foreach(fish; fishes)
        abc[fish]++;
    writeln(abc);
    foreach(day; 0 .. 256)
    {
        ulong zeros = abc[0];
        for(int i = 1; i < abc.length; i++)
            abc[i - 1] = abc[i];
        abc[8] = zeros;
        abc[6] += zeros;
    }
    return abc.reduce!((a, b) => a + b);
}