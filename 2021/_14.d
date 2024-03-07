import std;

void main()
{
    writeln("part1 ", solve(1));
    writeln("part2 ", solve(2));
}
auto solve(int part)
{
    int steps = part == 1 ? 10 : 40;
    auto lines = lines("file.txt").split("");
    string start = lines[0][0];
    string[string] rules;
    foreach(c; lines[1])
    {
        string a, b;
        c.formattedRead("%s -> %s", a, b);
        rules[a] = b;
    }
    long[string] count;
    foreach(window; start.slide(2).map!(x => x.to!string))
        count[window]++;
    foreach(_; 0 .. steps)
    {
        long[string] update;
        foreach(k, v; count)
        {
            update[k[0] ~ rules[k]] += v;
            update[rules[k] ~ k[1]] += v;
        }
        count = update;
    }
    long[char] final_count;
    final_count[start[$ - 1]] = 1;
    foreach(k, v; count)
        final_count[k[0]] += v;
    return final_count.byValue.maxElement - final_count.byValue.minElement;
}
auto lines(string file)
{
    File handle = File(file, "r");
    auto lines = handle.byLine.map!(x => x.to!string).array;
    handle.close;
    return lines;
}