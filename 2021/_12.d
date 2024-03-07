import ascii = std.ascii;
import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
auto solve(int part)
{
    auto input = lines("input.txt");
    string[][string] map;
    foreach(line; input)
    {
        auto caves = line.split("-");
        map[caves[0]] ~= caves[1];
        map[caves[1]] ~= caves[0];
    }
    int helper(string cave, string[] visited, int part)
    {
        if(cave == "end")
            return 1;
        if(visited.any!(x => x == cave))
        {
            if(cave == "start")
                return 0;
            if(cave.all!(ascii.isLower))
                if(part == 1)
                    return 0;
                else
                    part--;
        }
        return map[cave].fold!((acc, x) => acc + helper(x, visited ~ cave, part))(0);
    }
    return helper("start", [], part);
}
auto lines(string file)
{
    File handle = File(file, "r");
    scope(exit)
        handle.close;
    return handle.byLine.map!(x => x.to!string).array;
}