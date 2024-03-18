import std;

void main()
{
    writeln("part1 ", part1());
    writeln("part2 ", part2());
}
auto part1()
{
    int max = 150;
    auto containers = lines("input.txt").to!(int[]);
    int helper(int acc, int i)
    {
        if(acc > max)
            return 0;
        if(acc == max)
            return 1;        
        return iota(i + 1, containers.length).fold!((acc1, x) => acc1 + helper(acc + containers[x], x))(0);
    }
    return iota(containers.length).fold!((acc, x) => acc + helper(containers[x], x))(0);
}
auto part2()
{
    int max = 150;
    auto containers = lines("input.txt").to!(int[]);
    int[int] counter;
    void helper(int acc, int i, int cups)
    {
        if(acc > max)
            return;
        if(acc == max) {
            counter[cups]++;
            return;
        }
        iota(i + 1, containers.length).each!(x => helper(acc + containers[x], x, cups + 1));
    }
    iota(containers.length).each!(x => helper(containers[x], x, 1));
    return counter[counter.byKey().minElement()];
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}