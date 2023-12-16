import std;

void main()
{
    writeln("part1 ", part1);
    writeln("part2 ", part2);
}

auto part1()
{
    return lines("input.txt").split("").map!(x => x.to!(int[]).sum).maxElement;
}
auto part2()
{		
    return lines("input.txt").split("").map!(x => x.to!(int[]).sum).array.sort[$ - 3 .. $].sum;
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}