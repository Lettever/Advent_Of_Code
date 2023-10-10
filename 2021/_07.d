import std.stdio;
import std.string;
import std.algorithm;
import std.array;
import std.conv;
import std.math;

@property int triangular(int number) => (number) * (number + 1) / 2;
@property ulong triangular(ulong number) => (number) * (number + 1) / 2;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}
int part1()
{
    File input = File("file.txt", "r");
    int []crabs = input.readln.chomp.split(",").map!(e => e.to!int).array;
    input.close;
    int min = crabs.reduce!((a, b) => a > b ? b : a);
    int max = crabs.reduce!((a, b) => a > b ? a : b);
    int min_fuel = int.max;
    for(int i = min; i <= max; i++)
    {
        int sum;
        for(int j = 0; j < crabs.length; j++)
            sum += abs(crabs[j] - i);
        if(sum < min_fuel)
            min_fuel = sum;
    }
    return min_fuel;
}
ulong part2()
{
    File input = File("file.txt", "r");
    int []crabs = input.readln.chomp.split(",").map!(e => e.to!int).array;
    input.close;
    int min = crabs.reduce!((a, b) => a > b ? b : a);
    int max = crabs.reduce!((a, b) => a > b ? a : b);
    ulong min_fuel = ulong.max;
    for(int i = min; i <= max; i++)
    {
        ulong sum;
        for(int j = 0; j < crabs.length; j++)
            sum += abs(crabs[j] - i).triangular;
        if(sum < min_fuel)
            min_fuel = sum;
    }
    return min_fuel;
}
 